package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

@Service
public class AutomatedTestingService {
	
	public String automatedTestingRun(String applicationForm) {
		String result = "";
		WebDriver driver = null;
		try {
	        String chromeVersion = getChromeVersion();
	        if (chromeVersion == null || chromeVersion.isEmpty()) {
	            return "Chrome 버전을 감지할 수 없습니다.";
	        }

	        String driverPath = getDriverPath(chromeVersion);
	        System.setProperty("webdriver.chrome.driver", driverPath);

	    	ChromeOptions options = new ChromeOptions();
	    	options.setAcceptInsecureCerts(true);
	    	options.addArguments("--headless");
	    	options.addArguments("--no-sandbox");
	    	options.addArguments("--disable-dev-shm-usage");

	    	driver = new ChromeDriver(options);
	    	WebDriverWait wait = new WebDriverWait(driver, 10);

	    	String testUrl = "https://172.16.50.199:8443/portal/login";
	    	driver.get(testUrl);

	    	// 1. 로그인 필드 로딩 대기
	    	wait.until(ExpectedConditions.presenceOfElementLocated(By.name("j_username")));

	    	// 2. 로그인 정보 입력
	    	driver.findElement(By.name("j_username")).sendKeys("admin");
	    	driver.findElement(By.name("j_password")).sendKeys("secuve00.");

	    	// 3. 로그인 버튼 클릭 (텍스트 기준 XPath)
	    	driver.findElement(By.xpath("//button[contains(text(), '로그인')]")).click();
	    	
	    	// 로그인 성공 시 나타나는 내부 페이지 요소 대기
	        try {
	            wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.navbar-header-logo"))); 
	            result = "로그인 성공!\n";
	            if(applicationForm == "addAccount") {
	            	result += addAccount(driver, wait, result);
	            }
	            
	            return result;
	        } catch (TimeoutException e) {
	            // 실패 팝업이 나타나는지 검사
	            try {
	                WebElement errorPopup = driver.findElement(By.cssSelector("div.sweet-alert"));
	                String title = errorPopup.findElement(By.tagName("h2")).getText();
	                String message = errorPopup.findElement(By.cssSelector("p.lead.text-muted")).getText();

	                if ("오류".equals(title) && message.contains("로그인아이디 또는 패스워드가 틀렸습니다")) {
	                    return "로그인 실패: 아이디 또는 비밀번호가 틀렸습니다.";
	                } else {
	                    return "로그인 오류 발생";
	                }
	            } catch (NoSuchElementException ex) {
	                return "에러 발생!" + ex;
	            }
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	        return "테스트 중 오류 발생: " + ex.getMessage();
	    } finally {
	        if (driver != null) {
	            driver.quit();
	        }
	    }
	}
	
	private static String getChromeVersion() {
	    String version = "";
	    try {
	        Process process = Runtime.getRuntime().exec(
	            "reg query \"HKEY_CURRENT_USER\\Software\\Google\\Chrome\\BLBeacon\" /v version"
	        );
	        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
	        String line;
	        while ((line = reader.readLine()) != null) {
	            if (line.contains("version")) {
	                version = line.split("\\s+")[line.split("\\s+").length - 1];
	                break;
	            }
	        }
	        process.waitFor();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return version; // 예: 137.0.7151.120
	}
	
	private static String getDriverPath(String detectedVersion) {
	    // 버전에서 major.minor.build만 추출: 137.0.7151
	    String[] parts = detectedVersion.split("\\.");
	    if (parts.length < 3) return null;
	    String folderName = parts[0] + "." + parts[1] + "." + parts[2]; // "137.0.7151"
	    
	    // 매핑된 실제 드라이버 버전 이름 (하위 폴더 이름은 고정된 특정 버전 사용)
	    // 실무에서는 이 매핑 정보(json/properties 등)으로 구성 가능
	    String driverPath = "C:\\AgentInfo\\drivers\\" + folderName + ".119\\chromedriver.exe";
	    return driverPath;
	}


	
	public String addAccount(WebDriver driver, WebDriverWait wait, String result) {
		// 로그인 성공 후 페이지 이동
        driver.get("https://172.16.50.199:8443/portal/workflow/userapp/request/write/PROCESS_1_NM");
        
        // 필요하다면 이동 후 특정 요소까지 기다렸다가 응답
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("button#btnOpenAddRequest")));
        result += "서버계정 신규신청 접근 성공!\n";
        
        WebElement addButton = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnOpenAddRequest")));
        addButton.click();
        WebElement unixLink = wait.until(ExpectedConditions.elementToBeClickable(
            By.xpath("//a[contains(text(), 'UNIX/LINUX')]")
        ));
        unixLink.click();
        
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.modal-dialog div.modal-content div.modal-header h4.modal-title")));
        result += "신청내용 추가 Modal 로드 성공!\n";

        // 1. 현재 창의 핸들 저장
        String mainWindow = driver.getWindowHandle();

        // 2. 버튼 클릭 → 팝업 열림
        WebElement addServerBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnAddServer")));
        addServerBtn.click();
        result += "서버 선택 호출 성공!\n";
        // 3. 새 창으로 전환
        for (String handle : driver.getWindowHandles()) {
            if (!handle.equals(mainWindow)) {
                driver.switchTo().window(handle);
                break;
            }
        }

        // 4. 팝업 안에서 작업 수행
        WebElement targetCell = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//td[@title='TOSMS_KIHO_22']")));
        targetCell.click();


        WebElement selectBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnSelect")));
        selectBtn.click();
        
        // 다시 현재 페이지로 이동
        driver.switchTo().window(mainWindow);

        result += "서버명 선택 완료!\n";

        WebElement addAccountBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnAddAccount")));
        addAccountBtn.click();
        
        wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.modal-dialog div.modal-content div.modal-header h4.modal-title")));
        WebElement accountNameInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("fi_account_name")));
        accountNameInput.clear();  // 기존 값 삭제 (필요시)
        accountNameInput.sendKeys("Q001");

        WebElement allowIpInput = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("fi_allow_ip")));
        allowIpInput.clear();  // 기존 값 제거
        allowIpInput.sendKeys("127.0.0.1");
        
        WebElement addIpBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnAddIp")));
        addIpBtn.click();

        WebElement okBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnDialogOk")));
        okBtn.click();
        result += "계정 입력 완료!\n";
        
        WebElement saveBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnAddRequest")));
        saveBtn.click();
        result += "신청서 저장 완료!\n";

        WebElement reasonTextarea = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("f_reason")));
        reasonTextarea.clear();  // 기존 내용 삭제
        reasonTextarea.sendKeys("서버계정 신규 신청 자동화 테스트!!");

        WebElement requestBtn = wait.until(ExpectedConditions.elementToBeClickable(By.id("btnRequest")));
        requestBtn.click();
        result += "서버계정 신규 신청 신청서 신청 완료!\n";
        
        return result;
	}
}
