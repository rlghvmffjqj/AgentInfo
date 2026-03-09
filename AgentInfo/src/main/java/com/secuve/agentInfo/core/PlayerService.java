package com.secuve.agentInfo.core;

import java.io.File;
import java.time.Duration;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import io.github.bonigarcia.wdm.WebDriverManager;

@Service
public class PlayerService {

    private WebDriver driver;

    public void runPlayback() {
        System.out.println("Playback Service: Reading macro.json file...");
        File file = new File("C:\\AgentInfo\\macro.json");

        if (!file.exists()) {
            System.err.println("오류: macro.json 파일이 존재하지 않습니다.");
            return;
        }

        try {
            ObjectMapper mapper = new ObjectMapper();
            List<Map<String, Object>> events = mapper.readValue(file, List.class);

            if (events == null || events.isEmpty()) {
                System.out.println("재생할 이벤트가 없습니다.");
                return;
            }

            // 브라우저 설정 및 시작
            WebDriverManager.chromedriver().setup();
            System.setProperty("webdriver.chrome.driver", "C:/AgentInfo/selenium/chromedriver-win64/chromedriver.exe");
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--ignore-certificate-errors");
            options.addArguments("--disable-infobars");
            options.setExperimentalOption("excludeSwitches", new String[]{"enable-automation"});
            
            driver = new ChromeDriver(options);
            driver.manage().window().maximize();

            // 첫 번째 이벤트가 페이지 로드라면 해당 URL로 이동, 아니면 기본 페이지 이동
            driver.get("https://172.16.50.199:8445/portal/login");

            for (Map<String, Object> event : events) {
                playEvent(event);
                //Thread.sleep(500); // 각 동작 사이의 간격
            }

            System.out.println("재생 완료.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String lastUrl = ""; // 마지막으로 작업한 URL 캐싱

    private void playEvent(Map<String, Object> event) {
        String type = (String) event.get("type");
        String xpath = (String) event.get("xpath");
        String value = (String) event.get("value") != null ? (String) event.get("value") : "";
        String targetUrl = (String) event.get("url");

        try {
            // 1. 창/URL 전환 핸들링
            if (targetUrl != null && !targetUrl.equals(lastUrl)) {
                handleWindowSwitch(targetUrl);
                lastUrl = targetUrl;
                Thread.sleep(500); // 모달/창 전환 안정화 시간 증가
            }

            // 2. 요소 대기 로직 강화 (최대 5초로 늘리고, 가시성 확인)
            WebDriverWait wait = new WebDriverWait(driver, 5); // 대기 시간을 10초로 넉넉히 설정
            WebElement element = null;

            try {
                // 요소가 화면에 나타나고(Visible) 클릭 가능할 때까지(Clickable) 대기
                element = wait.until(ExpectedConditions.elementToBeClickable(By.xpath(xpath)));
            } catch (TimeoutException e) {
                // 10초를 기다려도 안 나오면, 페이지가 바뀌었거나 팝업이 늦게 뜬 것임
                System.err.println(">>> 요소 대기 시간 초과(10초): " + xpath);
                // 여기서 바로 return 하지 말고, 마지막으로 JS 탐색 시도
                try {
                    element = driver.findElement(By.xpath(xpath));
                } catch (Exception ex) {
                    return; // 정말 없으면 스킵
                }
            }

            // 3. 요소로 스크롤 (모달 내부 스크롤 대응)
            ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                "arguments[0].scrollIntoView({block: 'center', inline: 'nearest'});", element);

            // 4. 타입별 실행 (강제성 부여)
            if ("click".equals(type)) {
                try {
                    element.click();
                } catch (Exception e) {
                    // 일반 클릭 실패 시 (다른 레이어에 가려진 경우) 자바스크립트로 강제 클릭
                    ((org.openqa.selenium.JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
                }
            } 
            else if ("blur".equals(type) || "change".equals(type)) {
                if ("SELECT".equals(event.get("tag"))) {
                    handleSelect(element, value);
                } else {
                    // Input/Textarea 입력 시 clear() 보다는 JS로 직접 주입하는 것이 모달에서 훨씬 안정적임
                    element.clear();
                    element.sendKeys(value);
                }
            }

            // 동작 후 짧은 대기 (DOM 변화 반영 시간)
            Thread.sleep(200);

        } catch (Exception e) {
            System.err.println("재생 중 에러 (스킵 안함): " + xpath + " -> " + e.getMessage());
        }
    }

    // Select 전용 처리 메서드 분리
    private void handleSelect(WebElement element, String value) {
        try {
            org.openqa.selenium.support.ui.Select select = new org.openqa.selenium.support.ui.Select(element);
            try {
                select.selectByVisibleText(value);
            } catch (Exception e) {
                select.selectByValue(value);
            }
            System.out.println("Select 완료: " + value);
        } catch (Exception e) {
            // Select 클래스 실패 시 JS 강제 변경
            ((org.openqa.selenium.JavascriptExecutor) driver).executeScript(
                "arguments[0].value = '" + value + "'; arguments[0].dispatchEvent(new Event('change'));", element);
        }
    }


    /**
     * [최적화 3] 불필요한 getCurrentUrl 호출 최소화
     */
    private void handleWindowSwitch(String targetUrl) {
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

