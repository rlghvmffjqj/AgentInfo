package com.secuve.agentInfo.core;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.vo.Selenium;

@Service
public class PlayerService {

    //private WebDriver driver;

    public void runPlayback(Selenium selenium) {
        System.out.println("Playback Service: Reading macro.json file...");
        WebDriver driver = null; 
        try {
            ObjectMapper mapper = new ObjectMapper();
            String json = selenium.getSeleniumActionSteps();
            List<Map<String, Object>> events =
                    mapper.readValue(json, new TypeReference<List<Map<String, Object>>>() {});
            System.setProperty("webdriver.chrome.driver", "C:/AgentInfo/selenium/chromedriver-win64/chromedriver.exe");
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--ignore-certificate-errors");
            options.addArguments("--disable-infobars");
            options.setExperimentalOption("excludeSwitches", new String[]{"enable-automation"});
            
            driver = new ChromeDriver(options);
            driver.manage().window().maximize();

            driver.get(selenium.getSeleniumAddress());
            
            for (Map<String, Object> event : events) {
            	try {
            		playEvent(event, driver);
            	} catch (Exception e) {
                    // 브라우저가 닫혔거나 세션이 끊긴 경우 (invalid session id 포함)
                    if (e.getMessage().contains("invalid session id") || e.getMessage().contains("no such window")) {
                        System.err.println("브라우저가 닫혀 재생을 즉시 중단합니다.");
                        return; // 루프와 메서드 전체를 즉시 종료 (Thread 종료됨)
                    }
                    System.err.println("재생 중 제어 오류 발생: " + e.getMessage());
                }
            }

            System.out.println("재생 완료.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String lastUrl = ""; // 마지막으로 작업한 URL 캐싱

    private void playEvent(Map<String, Object> event, WebDriver driver) throws Exception { 
        String type = (String) event.get("type");
        String tag = (String) event.get("tag"); // 반드시 JSON에서 tag를 가져와야 합니다.
        String xpath = (String) event.get("xpath");
        String value = event.get("value") != null ? (String) event.get("value") : "";
        String targetUrl = (String) event.get("url");

        try {
            // 1. 창/URL 전환 핸들링
            if (targetUrl != null && !targetUrl.equals(lastUrl)) {
                handleWindowSwitch(targetUrl, driver);
                lastUrl = targetUrl;
                Thread.sleep(200); 
            }

            // 2. WebDriverWait 수정 (Selenium 3.x: Duration 대신 숫자로 초 설정)
            // 두 번째 인자를 Duration.ofSeconds(5) 대신 그냥 5로 변경합니다.
            WebDriverWait wait = new WebDriverWait(driver, 5); 
            
            // 요소가 존재할 때까지 대기
            WebElement element = wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath(xpath)));

            // 3. 요소로 스크롤
            ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                "arguments[0].scrollIntoView({block: 'center', inline: 'nearest'});", element);

            // 4. 타입별 실행 (SELECT 로직 수정)
            // "tag"라는 문자열이 아닌, 변수 tag와 비교해야 합니다.
            if ("SELECT".equalsIgnoreCase(tag)) {
                org.openqa.selenium.support.ui.Select select = new org.openqa.selenium.support.ui.Select(element);
                if (!value.isEmpty()) {
                    try {
                        // 값(Value)으로 먼저 시도
                        select.selectByValue(value);
                    } catch (Exception e) {
                        // 실패 시 보이는 텍스트로 시도
                        try { select.selectByVisibleText(value); } catch(Exception ex) {}
                    }
                    
                    // (매우 중요) SelectBox는 값 변경 후 JS 이벤트를 강제로 날려줘야 브라우저가 인식함
                    ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                        "var evt = document.createEvent('HTMLEvents');" +
                        "evt.initEvent('change', true, true);" +
                        "arguments[0].dispatchEvent(evt);", element);
                    
                    System.out.println("SELECT 수행 완료: " + value);
                }
            } 
            else if ("click".equals(type)) {
                try {
                    // 클릭 가능한 상태까지 대기 후 클릭
                    wait.until(ExpectedConditions.elementToBeClickable(element)).click();
                } catch (Exception e) {
                    // 일반 클릭 실패 시 JS 강제 클릭
                    ((org.openqa.selenium.JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
                }
            } 
            else if ("blur".equals(type) || "change".equals(type)) {
                element.clear();
                element.sendKeys(value);
                // 입력 후 포커스 아웃(blur) 이벤트 강제 발생
                ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                    "arguments[0].dispatchEvent(new Event('blur', { bubbles: true }));", element);
            }

            Thread.sleep(500);

        } catch (Exception e) {
            System.err.println("재생 중 에러: " + xpath + " -> " + e.getMessage());
            throw e;
        }
    }


    /**
     * [최적화 3] 불필요한 getCurrentUrl 호출 최소화
     */
    private void handleWindowSwitch(String targetUrl, WebDriver driver) {
        try {
            // [수정] 현재 창이 살아있는지 먼저 확인 (닫혔으면 바로 Catch로 이동)
            String currentUrl = "";
            try {
                currentUrl = driver.getCurrentUrl();
            } catch (Exception e) {
                // 현재 창이 이미 닫혔거나 유효하지 않음 -> 강제로 첫 번째 핸들로 복귀
                Set<String> allHandles = driver.getWindowHandles();
                if (!allHandles.isEmpty()) {
                    driver.switchTo().window(allHandles.iterator().next());
                }
            }

            // 목적지 URL과 현재 URL이 같으면 전환 불필요
            if (driver.getCurrentUrl().equals(targetUrl)) return;

            // URL이 다를 경우에만 전체 핸들 순회
            Set<String> handles = driver.getWindowHandles();
            for (String handle : handles) {
                driver.switchTo().window(handle);
                if (driver.getCurrentUrl().equals(targetUrl)) {
                    return;
                }
            }
        } catch (Exception e) {
            System.err.println("창 전환 중 오류: " + e.getMessage());
        }
    }



}

