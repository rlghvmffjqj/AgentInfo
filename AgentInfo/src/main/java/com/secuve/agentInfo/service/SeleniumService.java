package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpServletRequest;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.NoSuchSessionException;
import org.openqa.selenium.NoSuchWindowException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.UnreachableBrowserException;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.dao.SeleniumDao;
import com.secuve.agentInfo.vo.Packages;
import com.secuve.agentInfo.vo.Selenium;
import com.secuve.agentInfo.vo.SendPackage;

@Service
public class SeleniumService {
	@Autowired SeleniumDao seleniumDao;
	
	private volatile boolean recording;
    private volatile boolean driverAlive;
    private Thread monitorThread;

    private WebDriver driver;
    private JavascriptExecutor js;
    
    private List<Map<String, Object>> eventBuffer = new CopyOnWriteArrayList<>();

    // WebDriver 인스턴스 및 상태를 반환하는 Getter (PlayerService가 독립 실행되므로 사용 안 함)
    public WebDriver getDriver() { return driver; }
    public boolean isDriverAlive() { return driverAlive; }


    /* =========================
       START
     ========================= */
    public void start(Selenium selenium) {
        //WebDriverManager.chromedriver().setup();
        System.setProperty("webdriver.chrome.driver", "C:/AgentInfo/selenium/chromedriver-win64/chromedriver.exe");
        
        ChromeOptions options = new ChromeOptions();
        
        // [강력 추천] 브라우저가 생성될 때 포커스를 강제로 뺏어오는 옵션
        options.addArguments("--disable-popup-blocking");
        options.addArguments("--no-first-run");
        options.addArguments("--no-default-browser-check");
        options.addArguments("--start-maximized"); // 창 최대화
        options.addArguments("--focused");         // 창에 포커스 요청
        
        // 최신 크롬 필수 및 기본 설정
        options.addArguments("--remote-allow-origins=*");
        options.addArguments("--ignore-certificate-errors");
        
        driver = new ChromeDriver(options);
        
        // [중요] 드라이버 생성 직후 윈도우 핸들을 다시 활성화
        String originalHandle = driver.getWindowHandle();
        driver.switchTo().window(originalHandle);
        
        js = (JavascriptExecutor) driver;
        
        // 초기 접속 및 최대화
        driver.get(selenium.getSeleniumAddressView());
        try { driver.manage().window().maximize(); } catch (Exception ignored) {}
        
        waitForPageLoad();
        injectRecorderScript();
        
        recording = true;
        driverAlive = true;


        monitorThread = new Thread(() -> {
            String lastUrl = ""; 
            System.out.println(">>> 감시 스레드 시작");
            
            while (recording && driverAlive) {
                try {
                    // 1. 창 상태 및 포커스 복구 (가장 중요)
                    backupEventsFromBrowser(); 

                    // 2. 현재 활성화된 창의 URL 확인
                    String currentUrl = driver.getCurrentUrl();

                    if (!currentUrl.equals(lastUrl)) {
                        System.out.println("URL 변경 감지: " + lastUrl + " -> " + currentUrl);
                        waitForPageLoad(); 
                        injectRecorderScript();
                        lastUrl = currentUrl;
                    }
                    
                    // 루프 주기: 0.1초는 너무 빨라 충돌 위험이 있으므로 0.8~1초 권장
                    Thread.sleep(800); 
                    
                } catch (NoSuchWindowException | NoSuchFrameException e) {
                    // 팝업이 닫히는 찰나에 발생하는 에러 -> 무시하고 다음 루프에서 부모를 잡도록 함
                    System.out.println(">>> 창 유실 감지 (복구 대기 중...)");
                    try { Thread.sleep(1000); } catch (Exception ignored) {}
                    continue; // [핵심] 스레드를 종료(return)하지 않고 계속 유지

                } catch (NoSuchSessionException | UnreachableBrowserException e) {
                    // 브라우저가 완전히 종료된 경우만 스레드 종료
                    System.err.println(">>> 브라우저 세션 종료됨");
                    driverAlive = false;
                    return;
                } catch (Exception e) {
                    // 기타 예외 발생 시에도 스레드 유지
                    System.err.println(">>> 일반 에러 발생 (재시도): " + e.getMessage());
                    try { Thread.sleep(1000); } catch (Exception ignored) {}
                    continue; 
                }
            }
            System.out.println(">>> 감시 스레드 종료");
        });

        monitorThread.setDaemon(true);
        monitorThread.start();
    }



    /* =========================
       STOP (C:\AgentInfo\macro.json 저장 구현 포함)
     ========================= */
    @SuppressWarnings("unchecked")
    public synchronized String stop() {
        recording = false;
        String result = "";
        backupEventsFromBrowser();

        try {
            if (eventBuffer.isEmpty()) {
                System.err.println("Recorder 결과가 비어 있습니다.");
            }

            // 입력 이벤트를 압축/정규화
            List<Map<String, Object>> normalizedEvents = normalizeInputEvents(eventBuffer);
            
            // Jackson ObjectMapper를 사용하여 List를 JSON 문자열로 변환 (쌍따옴표 포함)
            ObjectMapper mapper = new ObjectMapper();
            
            // 결과 변수에 JSON 문자열 할당
            result = mapper.writeValueAsString(normalizedEvents);

            System.out.println("=== NORMALIZED EVENTS (Final JSON Output) ===");
            System.out.println(result);
            
            // 파일 저장이 필요할 경우 주석 해제하여 사용
            // mapper.writerWithDefaultPrettyPrinter().writeValue(new File("C:\\AgentInfo\\macro.json"), normalizedEvents);

        } catch (Exception e) {
            System.err.println("Recorder stop 처리 중 오류 발생");
            e.printStackTrace();
            result = "[]"; // 오류 발생 시 빈 배열 반환
        } finally {
            try {
                driverAlive = false;
                if (driver != null) {
                    driver.quit();
                }
            } catch (Exception ignored) {}
            driver = null;
            js = null;
            eventBuffer.clear();
        }
        return result;
    }

    
    
    private Set<String> injectedHandles = Collections.synchronizedSet(new HashSet<>());

    private synchronized void backupEventsFromBrowser() {
        if (!driverAlive || driver == null) return;
        
        try {
            Set<String> currentHandles = driver.getWindowHandles();
            if (currentHandles.isEmpty()) return;
            
            int handleCount = currentHandles.size();
            System.out.println(">>> 현재 핸들 개수: " + handleCount);

            // 1. 현재 WebDriver가 잡고 있는 창의 생존 확인
            String activeHandle = null;
            try { 
                activeHandle = driver.getWindowHandle(); 
            } catch (Exception e) { 
                activeHandle = null; // 팝업 닫힘
            }

            // 2. [핵심] 타겟 창 결정 (가장 최근에 열린 창 우선)
            List<String> handleList = new ArrayList<>(currentHandles);
            String latestHandle = handleList.get(handleList.size() - 1); 

            // 3. 포커스 이동 결정 (현재 창이 죽었거나, 새로 열린 팝업이 있다면 이동)
            if (activeHandle == null || !currentHandles.contains(activeHandle) || !activeHandle.equals(latestHandle)) {
                try {
                    driver.switchTo().window(latestHandle);
                    activeHandle = latestHandle;
                    
                    // [추가] 전환 직후 브라우저가 안정을 찾을 시간을 아주 잠깐 줌
                    Thread.sleep(500); 
                    
                    // 창이 바뀌면 리코더 상태를 강제 초기화
                    js.executeScript("window._recorderInitialized = false;");
                    System.out.println(">>> 포커스 전환 완료: " + activeHandle);
                } catch (Exception e) {
                    System.err.println(">>> 전환 중 오류(다음 루프에서 재시도): " + e.getMessage());
                    return; // 이번 루프는 여기서 포기
                }
            }

            // 4. [주입 및 수집] 현재 고정된 창(activeHandle)에서만 수행
            try {
                // 리코더 생존 여부 실시간 체크 (새로고침 대응)
                Object isInit = js.executeScript("return window._recorderInitialized;");
                if (isInit == null || !(Boolean)isInit) {
                    injectRecorderScript();
                    injectedHandles.add(activeHandle);
                }
                
                // 데이터 수집 (팝업이면 팝업 데이터, 부모면 부모 데이터)
                collectEvents();
            } catch (Exception ignored) {}

            // 5. 관리 목록 정리
            injectedHandles.retainAll(currentHandles);

        } catch (Exception e) {
            System.err.println("Backup Error: " + e.getMessage());
        }
    }

    private void collectEvents() {
        try {
            // 메모리와 로컬스토리지를 모두 긁어오고 비우는 스크립트
        	String script =
        		    "let m = window.__RECORDED_EVENTS__ || [];\n" +
        		    "let s = JSON.parse(localStorage.getItem('RESCUE_EVENTS') || '[]');\n" +
        		    "let combined = [].concat(m, s);\n" +
        		    "window.__RECORDED_EVENTS__ = [];\n" +
        		    "localStorage.removeItem('RESCUE_EVENTS');\n" +
        		    "return combined;";
            List<Map<String, Object>> events = (List<Map<String, Object>>) js.executeScript(script);
            
            if (events != null && !events.isEmpty()) {
                for (Map<String, Object> evt : events) {
                    // 중복 체크 로직 (기존 유지)
                    boolean isDuplicate = eventBuffer.stream().anyMatch(e -> 
                        e.get("time").toString().equals(evt.get("time").toString()));
                    if (!isDuplicate) eventBuffer.add(evt);
                }
            }
        } catch (Exception ignored) {}
    }




    public void injectRecorderScript() {
        if (driver == null) return;
        js.executeScript(
        		"(function () {\n" +
        		"    window.alert = function() { return true; };\n" +
        		"    window.confirm = function() { return true; };\n" +
        		"    window.prompt = function() { return null; };\n" +
        		"\n" +
        		"    if (window._recorderInitialized) return;\n" +
        		"    window._recorderInitialized = true;\n" +
        		"    window.__RECORDED_EVENTS__ = window.__RECORDED_EVENTS__ || [];\n" +
        		"\n" +
        		"    function getXPath(el) {\n" +
        		"        if (!el || el.nodeType !== 1) return '';\n" +
        		"        if (el.id) return '//*[@id=\"' + el.id + '\"]';\n" +
        		"        var parts = [];\n" +
        		"        while (el && el.nodeType === Node.ELEMENT_NODE) {\n" +
        		"            var index = 1;\n" +
        		"            var sibling = el.previousSibling;\n" +
        		"            while (sibling) {\n" +
        		"                if (sibling.nodeType === Node.ELEMENT_NODE && sibling.tagName === el.tagName) index++;\n" +
        		"                sibling = sibling.previousSibling;\n" +
        		"            }\n" +
        		"            parts.unshift(el.tagName.toLowerCase() + '[' + index + ']');\n" +
        		"            el = el.parentNode;\n" +
        		"        }\n" +
        		"        return '/' + parts.join('/');\n" +
        		"    }\n" +
        		"\n" +
        		"    function record(type, targetOrObj) {\n" +
        		"        var event = {\n" +
        		"            type: type,\n" +
        		"            tag: targetOrObj.tagName,\n" +
        		"            xpath: getXPath(targetOrObj),\n" +
        		"            value: (targetOrObj.value || '').trim(),\n" +
        		"            time: Date.now(),\n" +
        		"            url: window.location.href\n" +
        		"        };\n" +
        		"\n" +
        		"        window.__RECORDED_EVENTS__.push(event);\n" +
        		"\n" +
        		"        var backup = JSON.parse(localStorage.getItem('RESCUE_EVENTS') || '[]');\n" +
        		"        backup.push(event);\n" +
        		"        localStorage.setItem('RESCUE_EVENTS', JSON.stringify(backup));\n" +
        		"\n" +
        		"        try {\n" +
        		"            if (window.opener && !window.opener.closed) {\n" +
        		"                var openerBackup = JSON.parse(window.opener.localStorage.getItem('RESCUE_EVENTS') || '[]');\n" +
        		"                openerBackup.push(event);\n" +
        		"                window.opener.localStorage.setItem('RESCUE_EVENTS', JSON.stringify(openerBackup));\n" +
        		"            }\n" +
        		"        } catch (e) {}\n" +
        		"    }\n" +
        		"\n" +
        		"    window.addEventListener('beforeunload', function() {\n" +
        		"        try {\n" +
        		"            if (window.opener && !window.opener.closed) {\n" +
        		"                window.opener.__RECORDED_EVENTS__ = (window.opener.__RECORDED_EVENTS__ || []).concat(window.__RECORDED_EVENTS__ || []);\n" +
        		"                window.opener._recorderInitialized = false;\n" +
        		"            }\n" +
        		"        } catch (e) {}\n" +
        		"    });\n" +
        		"\n" +
        		"    document.addEventListener('click', function(e) {\n" +
        		"        var targetEl = e.target.closest('a, button, input, li, img, [onclick], [role=\"button\"]');\n" +
        		"        if (!targetEl) targetEl = e.target;\n" +
        		"\n" +
        		"        if (e._processedByRecorder) return;\n" +
        		"\n" +
        		"        record('click', targetEl);\n" +
        		"\n" +
        		"        var btnText = (targetEl.innerText || targetEl.value || '').trim();\n" +
        		"        var onclickAttr = targetEl.getAttribute('onclick') || '';\n" +
        		"        var isCloseBtn = btnText === '닫기' || onclickAttr.indexOf('window.close') !== -1;\n" +
        		"        var linkEl = targetEl.closest('a');\n" +
        		"\n" +
        		"        var isActionable = targetEl.tagName === 'BUTTON' ||\n" +
        		"                           targetEl.tagName === 'INPUT' ||\n" +
        		"                           targetEl.tagName === 'A' ||\n" +
        		"                           targetEl.tagName === 'IMG' ||\n" +
        		"                           onclickAttr !== '';\n" +
        		"\n" +
        		"        if (isActionable && (!targetEl.target || targetEl.target !== '_blank')) {\n" +
        		"            e.preventDefault();\n" +
        		"            e.stopImmediatePropagation();\n" +
        		"\n" +
        		"            if (isCloseBtn) {\n" +
        		"                try {\n" +
        		"                    if (window.opener && !window.opener.closed) {\n" +
        		"                        window.opener.__RECORDED_EVENTS__ = window.opener.__RECORDED_EVENTS__.concat(window.__RECORDED_EVENTS__);\n" +
        		"                        window.__RECORDED_EVENTS__ = [];\n" +
        		"                        window.opener._recorderInitialized = false;\n" +
        		"                        window.opener.focus();\n" +
        		"                    }\n" +
        		"                } catch (err) {}\n" +
        		"            }\n" +
        		"\n" +
        		"            setTimeout(function() {\n" +
        		"                var href = linkEl ? linkEl.getAttribute('href') : null;\n" +
        		"                var isHash = !href || href === '#' || href.indexOf('javascript:') === 0;\n" +
        		"\n" +
        		"                if (linkEl && !isHash) {\n" +
        		"                    window.location.href = linkEl.href;\n" +
        		"                } else {\n" +
        		"                    var clickEvt = new MouseEvent('click', { bubbles: true, cancelable: true, view: window });\n" +
        		"                    clickEvt._processedByRecorder = true;\n" +
        		"                    targetEl.dispatchEvent(clickEvt);\n" +
        		"                }\n" +
        		"            }, 1500);\n" +
        		"        }\n" +
        		"    }, true);\n" +
        		"\n" +
        		"    document.addEventListener('blur', function(e) {\n" +
        		"        if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') {\n" +
        		"            record('blur', e.target);\n" +
        		"        }\n" +
        		"    }, true);\n" +
        		"\n" +
        		"})();"
        		);
    }


    private void waitForPageLoad() {
        if (driver == null) return;
        //WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
        WebDriverWait wait = new WebDriverWait(driver, 30);
        wait.until((ExpectedCondition<Boolean>) wd ->
            ((JavascriptExecutor) wd).executeScript("return document.readyState").equals("complete"));
    }
    
    private List<Map<String, Object>> normalizeInputEvents(List<Map<String, Object>> rawEvents) {
        List<Map<String, Object>> normalized = new ArrayList<>();
        Map<String, Map<String, Object>> lastInputMap = new LinkedHashMap<>();

        for (Map<String, Object> event : rawEvents) {
            String type = (String) event.get("type");
            String xpath = (String) event.get("xpath");
            if (type.equals("input") || type.equals("change") || type.equals("blur")) {
                lastInputMap.put(xpath, event);
            } else {
                if (!lastInputMap.isEmpty()) {
                    normalized.addAll(lastInputMap.values());
                    lastInputMap.clear();
                }
                normalized.add(event);
            }
        }
        if (!lastInputMap.isEmpty()) {
            normalized.addAll(lastInputMap.values());
        }
        return normalized;
    }

    private void saveEventsToFile(List<Map<String, Object>> events, String filePath) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            File file = new File(filePath);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }
            mapper.writeValue(file, events);
            System.out.println("이벤트가 성공적으로 저장되었습니다: " + filePath);
        } catch (IOException e) {
            System.err.println("파일 저장 중 오류 발생: " + filePath);
            e.printStackTrace();
        }
    }
    
    public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
    
	public String insertSelenium(Selenium selenium) {
		selenium.setSeleniumGroupParentPath(selenium.getSeleniumGroupFullPath().replace("/"+selenium.getSeleniumGroupName(), ""));
		int success = seleniumDao.insertSelenium(selenium);
		if (success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}
	public String updateSelenium(Selenium selenium) {
		selenium.setSeleniumGroupParentPath(selenium.getSeleniumGroupFullPath().replace("/"+selenium.getSeleniumGroupName(), ""));
		int success = seleniumDao.updateSelenium(selenium);
		if (success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}
	public Selenium getSeleniumOne(int seleniumKeyNum) {
		return seleniumDao.getSeleniumOne(seleniumKeyNum);
	}
	public List<Selenium> getSeleniumList(Selenium search) {
		return seleniumDao.getSeleniumList(search);
	}
	public int getSeleniumListCount(Selenium search) {
		return seleniumDao.getSeleniumListCount(search);
	}
	public String delSelenium(int[] chkList) {
		if (chkList == null || chkList.length == 0) {
            return "FALSE";
        }
		
		for (int seleniumKeyNum : chkList) {
			int success = seleniumDao.delSelenium(seleniumKeyNum);
			if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}
	public void startApi(Selenium selenium, String clientIp) {
		String url = "http://"+clientIp+":8082/clientStart";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("seleniumAddress", selenium.getSeleniumAddressView())
        		.build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        try {
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        System.out.println(jsonInString);
	}
	
	
	public String getClientIp(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");

	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }

	    return ip;
	}
	
	public String stopApi(String clientIp) {
		String url = "http://"+clientIp+":8082/clientStop";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        try {
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        jsonInString = jsonInString.replaceAll("^\"|\"$", "");
        jsonInString = jsonInString.replace("\\\"", "\"");
        jsonInString = jsonInString.replaceAll("\\\\\\\\", "\\\\");
        return jsonInString;
	}
	
	
	public String runApi(Selenium selenium, String clientIp) {
	    String url = "http://" + clientIp + ":8082/clientRun";

	    RestTemplate restTemplate = new RestTemplate();

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);

	    Map<String, Object> body = new HashMap<>();
	    body.put("seleniumAddress", selenium.getSeleniumAddressView());
	    body.put("seleniumActionSteps", selenium.getSeleniumActionStepsView());

	    HttpEntity<Map<String,Object>> request =
	            new HttpEntity<>(body, headers);

	    restTemplate.postForObject(url, request, String.class);

	    System.out.println(request.getBody());
	    return "OK";
	}
	public String updateSeleniumGroupCopy(int[] chkList, Selenium selenium, Principal principal) {
		int success = 1;
		for (int seleniumKeyNum : chkList) {
			Selenium seleniumCopy = seleniumDao.getSeleniumOne(seleniumKeyNum);
			seleniumCopy.setSeleniumGroupName(selenium.getSeleniumGroupName());
			seleniumCopy.setSeleniumGroupFullPath(selenium.getSeleniumGroupFullPath());
			seleniumCopy.setSeleniumGroupParentPath(selenium.getSeleniumGroupFullPath().replace("/"+selenium.getSeleniumGroupName(), ""));
			seleniumCopy.setSeleniumTitleView(seleniumCopy.getSeleniumTitle());
			seleniumCopy.setSeleniumAddressView(seleniumCopy.getSeleniumAddress());
			seleniumCopy.setSeleniumDetailNoteView(seleniumCopy.getSeleniumDetailNote());
			seleniumCopy.setSeleniumActionStepsView(seleniumCopy.getSeleniumActionSteps());
			seleniumCopy.setSeleniumRegistrant(principal.getName());
			seleniumCopy.setSeleniumRegistrationDate(nowDate());
			
			success *= seleniumDao.insertSelenium(seleniumCopy);
		}
		
		if (success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}
	public String seleniumPause(String clientIp) {
		String url = "http://" + clientIp + ":8082/clientPause";

        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        try {
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return "OK";
	}
	public String seleniumReRun(String clientIp) {
		String url = "http://" + clientIp + ":8082/clientReRun";

        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        try {
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return "OK";
	}
	public String seleniumNextRun(String clientIp) {
		String url = "http://" + clientIp + ":8082/clientNext";

        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        try {
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return "OK";
	}
	
	

}
