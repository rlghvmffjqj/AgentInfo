package com.secuve.agentInfo.automated.portal;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.vo.ResultMsg;

@Service
public class ServerApplicationService {

	// iframe 탐색
		private WebElement findElementInAnyFrame(WebDriver driver, By locator) {

	        // 1. 메인 DOM
	        driver.switchTo().defaultContent();
	        List<WebElement> elements = driver.findElements(locator);
	        if (!elements.isEmpty()) {
	            return elements.get(0);
	        }

	        // 2. 모든 iframe 순회
	        List<WebElement> iframes = driver.findElements(By.tagName("iframe"));

	        for (WebElement iframe : iframes) {
	            try {
	                driver.switchTo().frame(iframe);
	                elements = driver.findElements(locator);
	                if (!elements.isEmpty()) {
	                    return elements.get(0);
	                }
	            } catch (Exception ignored) {
	            } finally {
	                driver.switchTo().defaultContent();
	            }
	        }

	        throw new NoSuchElementException(
	            "Element not found in any iframe: " + locator
	        );
	    }
		
		// Modal 오픈 대기
		WebElement waitForModalTitle(WebDriver driver, WebDriverWait wait, String title) {
		    return wait.until(d -> {
		        try {
		            WebElement el = findElementInAnyFrame(
		                d,
		                By.xpath("//h4[contains(@class,'modal-title') and normalize-space()='" + title + "']")
		            );
		            return (el.isDisplayed()) ? el : null;
		        } catch (Exception e) {
		            return null;
		        }
		    });
		}


		// 서버 계정 신규 신청
		public String addAccount(WebDriver driver, WebDriverWait wait, ResultMsg result) {

		    /* ===============================
		       1. 신규 신청 페이지 접근
		       =============================== */
		    driver.get("https://172.16.50.199:8445/portal/workflow/userapp/request/write/PROCESS_1_NM");

		    wait.until(ExpectedConditions.presenceOfElementLocated(
		        By.id("btnOpenAddRequest")
		    ));
		    result.setResult(result.getResult() + "2단계. [서버계정 신규 신청] 서버계정 신규신청 화면 접근\n");

		    driver.findElement(By.id("btnOpenAddRequest")).click();

		    /* ===============================
		       2. UNIX / LINUX 선택
		       =============================== */
		    wait.until(ExpectedConditions.elementToBeClickable(
		        By.xpath("//a[contains(text(),'UNIX/LINUX')]")
		    )).click();

		    String mainWindow = driver.getWindowHandle();

		    /* ===============================
		       3. 서버 선택 Modal 열림 확인 (신호용)
		       =============================== */
		    wait.until(ExpectedConditions.presenceOfElementLocated(
		        By.cssSelector("div.modal-dialog.ui-draggable")
		    ));

		    /* ===============================
		       4. 서버 추가 버튼 클릭 (iframe 자동 탐색)
		       =============================== */
		    WebElement btnAddServer = findElementInAnyFrame(
		        driver,
		        By.id("btnAddServer")
		    );

		    ((JavascriptExecutor) driver).executeScript(
		        "arguments[0].scrollIntoView({block:'center'});",
		        btnAddServer
		    );
		    ((JavascriptExecutor) driver).executeScript(
		        "arguments[0].click();",
		        btnAddServer
		    );

		    /* ===============================
		       5. 서버 선택 팝업 전환
		       =============================== */
		    wait.until(d -> d.getWindowHandles().size() > 1);

		    for (String handle : driver.getWindowHandles()) {
		        if (!handle.equals(mainWindow)) {
		            driver.switchTo().window(handle);
		            break;
		        }
		    }

		    result.setResult(result.getResult() + "3단계. [서버계정 신규 신청] 서버 선택 UNIX/LINUX 팝업 오픈\n");

		    /* ===============================
		       6. 서버 선택
		       =============================== */
		    wait.until(ExpectedConditions.elementToBeClickable(
		        By.xpath("//td[@title='TOSMS_KIHO_22']")
		    )).click();

		    wait.until(ExpectedConditions.elementToBeClickable(
		        By.id("btnSelect")
		    )).click();

		    wait.until(d -> d.getWindowHandles().size() == 1);
		    driver.switchTo().window(mainWindow);
		    result.setResult(result.getResult() + "4단계. [서버계정 신규 신청] 서버명 선택 완료\n");

		    /* ===============================
		       7. 계정 추가 Modal
		       =============================== */
		    WebElement btnAddAccount = findElementInAnyFrame(
		        driver,
		        By.id("btnAddAccount")
		    );
		
		    ((JavascriptExecutor) driver).executeScript(
		        "arguments[0].scrollIntoView({block:'center'});",
		        btnAddAccount
		    );
		    ((JavascriptExecutor) driver).executeScript(
		        "arguments[0].click();",
		        btnAddAccount
		    );
		    
		    waitForModalTitle(driver, wait, "계정정보");
		    
		    result.setResult(result.getResult() + "5단계. [서버계정 신규 신청] 계정 선택 Modal 오픈\n");

		    /* ===============================
		       8. 계정 정보 입력
		       =============================== */
		    WebElement accountNameInput = findElementInAnyFrame(
		        driver,
		        By.cssSelector("input#fi_account_name")
		    );
		    accountNameInput.clear();
		    accountNameInput.sendKeys("Q009");

		    WebElement allowIpInput = findElementInAnyFrame(
		        driver,
		        By.cssSelector("input#fi_allow_ip")
		    );
		    allowIpInput.clear();
		    allowIpInput.sendKeys("127.0.0.1");


		    WebElement btnAddIp = findElementInAnyFrame(driver, By.cssSelector("#btnAddIp"));
		    btnAddIp.click();

		    // Modal 확인 버튼 클릭
		    WebElement btnDialogOk = findElementInAnyFrame(driver, By.cssSelector("#btnDialogOk"));
		    btnDialogOk.click();

		    result.setResult(result.getResult() + "6단계. [서버계정 신규 신청] 계정 정보 입력 완료\n");

		    /* ===============================
				9. 신청서 저장 및 신청
		       =============================== */

		    // 신청서 저장 버튼 클릭
		    WebElement btnAddRequest = findElementInAnyFrame(driver, By.id("btnAddRequest"));
		    btnAddRequest.click();

		    // 신청 사유 입력
		    WebElement reasonTextarea = findElementInAnyFrame(driver, By.id("f_reason"));
		    reasonTextarea.clear();
		    reasonTextarea.sendKeys("서버계정 신규 신청 자동화 테스트");

		    // 신청 버튼 클릭
		    WebElement btnRequest = findElementInAnyFrame(driver, By.id("btnRequest"));
		    btnRequest.click();
		    
		    // 최종 신청서 처리 결과 확인
		    WebElement sweetAlert = wait.until(d -> {
		        try {
		            WebElement el = findElementInAnyFrame(
		                d,
		                By.cssSelector("div.sweet-alert.showSweetAlert.visible")
		            );
		            return el.isDisplayed() ? el : null;
		        } catch (Exception e) {
		            return null;
		        }
		    });
		    
		    String title = sweetAlert.findElement(By.tagName("h2")).getText().trim();
		    String message = sweetAlert.findElement(By.cssSelector("p.lead")).getText().trim();

		    if ("신청서 전송".equals(title)) {
		        result.setResult(result.getResult() + "7단계. [서버계정 신규 신청] 서버계정 신규 신청 완료\n");

		        // OK 버튼 클릭
		        WebElement okBtn = sweetAlert.findElement(By.cssSelector("button.confirm"));
		        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", okBtn);
		        return "OK";
		    } else {
		        result.setResult(result.getResult() + "[경고] 신청 실패 또는 기타 알림: " + title + " / " + message + "\n");
		    }
		    return "FALSE";
		}
		
}
