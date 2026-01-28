package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.automated.portal.ServerApplicationService;
import com.secuve.agentInfo.vo.ResultMsg;

@Service
public class AutomatedTestingService {
	@Autowired ServerApplicationService serverApplicationService;
	
	public String automatedTestingRun(String applicationForm) {
		ResultMsg result = new ResultMsg();
		WebDriver driver = null;
		try {
	        String chromeVersion = getChromeVersion();
	        if (chromeVersion == null || chromeVersion.isEmpty()) {
	            return "[경고] Chrome 버전을 감지할 수 없습니다.";
	        }

	        String driverPath = getDriverPath(chromeVersion);
	        System.setProperty("webdriver.chrome.driver", driverPath);

	    	ChromeOptions options = new ChromeOptions();
	    	options.setAcceptInsecureCerts(true);
//	    	options.addArguments("--headless");
	    	options.addArguments("--start-maximized");
	    	options.addArguments("--window-size=1920,1080");
	    	options.addArguments("--disable-backgrounding-occluded-windows");
	    	options.addArguments("--no-sandbox");
	    	options.addArguments("--disable-dev-shm-usage");

	    	driver = new ChromeDriver(options);
	    	WebDriverWait wait = new WebDriverWait(driver, 10);

	    	String testUrl = "https://172.16.50.199:8445/portal/login";
	    	driver.get(testUrl);

	    	// 1. 로그인 필드 로딩 대기
	    	wait.until(ExpectedConditions.presenceOfElementLocated(By.name("j_username")));

	    	// 2. 로그인 정보 입력
	    	driver.findElement(By.name("j_username")).sendKeys("1004");
	    	driver.findElement(By.name("j_password")).sendKeys("Secuve00.");

	    	// 3. 로그인 버튼 클릭 (텍스트 기준 XPath)
	    	driver.findElement(By.xpath("//button[contains(text(), '로그인')]")).click();
	    	
	    	// 로그인 성공 시 나타나는 내부 페이지 요소 대기
	        try {
	            wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("div.navbar-header-logo"))); 
	            result.setResult(result.getResult() + "1단계. [홈] 로그인 성공\n");
	        } catch (TimeoutException e) {
		        WebElement errorPopup = driver.findElement(By.cssSelector("div.sweet-alert"));
		        String title = errorPopup.findElement(By.tagName("h2")).getText();
		        String message = errorPopup.findElement(By.cssSelector("p.lead.text-muted")).getText();
	
		        if ("오류".equals(title) && message.contains("로그인아이디 또는 패스워드가 틀렸습니다")) {
		            return "[경고] 로그인 실패: 아이디 또는 비밀번호가 틀렸습니다.";
		        } else {
		            return "[경고] 로그인 중 오류 발생";
		        }
		        
	        }
			
	        try {
	        	String applicationResult = "";
	        	/* 계정 신규신청 */
	        	if(applicationForm == "addAccount") {
	        		applicationResult = serverApplicationService.addAccount(driver, wait, result);
					
				}
	        	/* 신청 승인 */
	        	if(applicationResult == "OK") {
	        		applicationResult = approval(driver, wait, result);
	        	}
	        } catch (Exception e) {
	        	return result.getResult() + "\n [경고] 신청서 작성 중 에러 발생: " + e;
			}
	    } catch (Exception ex) {
	        ex.printStackTrace();
	        result.setResult(result.getResult() + "\n [경고] 테스트 중 오류 발생: " + ex.getMessage());
	        return result.getResult();
	    } finally {
	        if (driver != null) {
//	            driver.quit();
	        }
	    }
		return result.getResult();
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
	
	

	private String approval(WebDriver driver, WebDriverWait wait, ResultMsg result) {
		// TODO Auto-generated method stub
		
		return "OK";
	}

}
