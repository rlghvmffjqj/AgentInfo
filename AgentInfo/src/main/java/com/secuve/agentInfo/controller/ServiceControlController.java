package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.ServiceControlService;
import com.secuve.agentInfo.vo.ServiceControl;

@Controller
public class ServiceControlController {
	@Autowired ServiceControlService serviceControlService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/serviceControl/list")
	public String ServiceControl(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "서비스 제어");
		List<String> serviceControlPurpose = serviceControlService.getServiceControlValue("serviceControlPurpose");
		List<String> serviceControlIp = serviceControlService.getServiceControlValue("serviceControlIp");
		model.addAttribute("serviceControlPurpose", serviceControlPurpose);
		model.addAttribute("serviceControlIp", serviceControlIp);
		return "serviceControl/ServiceControlList";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl")
	public Map<String, Object> ServiceControl(ServiceControl search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ServiceControl
		> list = new ArrayList<>(serviceControlService.getServiceControlList(search));

		int totalCount = serviceControlService.getServiceControlListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/serviceControl/insertView")
	public String ServiceControlAdd(Model model) {
		return "/serviceControl/ServiceControlAdd";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/insert")
	public String ServiceControlInsert(Principal principal, ServiceControl serviceControl) throws ParseException {
		return serviceControlService.serviceControlInsert(serviceControl);
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/delete")
	public String ServiceControlDelete(@RequestParam int[] chkList, Principal principal) {
		return serviceControlService.delServiceControl(chkList, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/synchronization")
	public String ServiceControlSynchronization() {
		return serviceControlService.serviceControlSynchronization();
	}
	
	@PostMapping(value = "/serviceControl/updateView")
	public String ServiceControlView(Model model, String serviceControlIp) {
		model.addAttribute("serviceControl",serviceControlService.getServiceControlIpOne(serviceControlIp));
		return "/serviceControl/ServiceControlView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/executionChange")
	public String ExecutionChange(ServiceControl serviceControl) {
		serviceControlService.executionChange(serviceControl);
		serviceControlService.serviceControlSynchronization();
		return "OK";
	}
	
	@PostMapping(value = "/serviceControl/logInquiryView")
	public String LogInquiryView(ServiceControl serviceControl, Model model) {
		String logInquiry = serviceControlService.getLogInquiry(serviceControl);
		logInquiry = logInquiry.replaceAll("\\\\n", "<br>");
		model.addAttribute("serviceControlIp", serviceControl.getServiceControlIp());
		model.addAttribute("serviceControlLog", logInquiry);
		return "/serviceControl/LogInquiryView";
	}
	
	@ResponseBody
	@PostMapping(value = "/serviceControl/update")
	public String ServiceControlUpdate(ServiceControl serviceControl) {
		StringBuffer result = new StringBuffer(); // 성공 스트링 버퍼
		// 로그 파일 경로
        String filePath = "D:/catalina.out";
        // 특정 날짜 이후의 로그를 필터링하려는 날짜
        String targetDateString = "2023-12-07 16:33:58";

        try {
            // SimpleDateFormat을 사용하여 문자열을 Date 객체로 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss.SSS");

            // 정규 표현식 패턴 생성
            Pattern datePattern = Pattern.compile("\\d{2}-[a-zA-Z]{3}-\\d{4} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}");

            Date targetDate = dateFormat.parse(targetDateString);

            // 로그 파일을 읽기 위해 Scanner 사용
            Scanner scanner = new Scanner(new File(filePath));

            // 특정 날짜 이후의 로그를 출력하는 플래그
            boolean printLogs = false;

            // 각 라인을 읽어와서 처리
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();

                // 정규 표현식으로 날짜를 찾기
                Matcher matcher = datePattern.matcher(line);
                if (matcher.find()) {
                    String logDateString = matcher.group();
                    try {
                        // 날짜를 Date 객체로 변환하여 특정 날짜와 비교
                        Date logDate = dateFormat.parse(logDateString);
                        if (logDate.equals(targetDate) || logDate.after(targetDate)) {
                            printLogs = true;
                        }
                    } catch (ParseException e) {
                        // 날짜를 파싱하는 중에 오류가 발생하면 무시하고 계속 진행
                    }
                }

                // 특정 날짜 이후의 로그를 출력
                if (printLogs) {
                    System.out.println(line);
                }
            }

            // Scanner 닫기
            scanner.close();
        } catch (FileNotFoundException e) {
            System.err.println("로그 파일을 찾을 수 없습니다: " + filePath);
        } catch (ParseException e) {
            System.err.println("날짜를 처리하는 중에 오류가 발생했습니다: " + e.getMessage());
        }

		return result.toString();
		//return serviceControlService.setServiceControlUpdate(serviceControl);
	}
}
