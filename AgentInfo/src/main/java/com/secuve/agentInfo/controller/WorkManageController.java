package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.core.XssConfig;
import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.MailSendService;
import com.secuve.agentInfo.service.WorkManageService;
import com.secuve.agentInfo.vo.MailSendList;
import com.secuve.agentInfo.vo.WorkManage;

@Controller
public class WorkManageController {
	@Autowired WorkManageService workManageService;
	@Autowired EmployeeService employeeService;
	@Autowired FavoritePageService favoritePageService;
	@Autowired CategoryService categoryService;
	@Autowired XssConfig xssConfig;
	@Autowired MailSendService mailSendService;

	@GetMapping(value = "/workManage/list")
	public String WorkManageList(Model model, Principal principal, HttpServletRequest req, @RequestParam(required = false) String managerNumber) {
		favoritePageService.insertFavoritePage(principal, req, "테스트 업무 관리");
		
		if(managerNumber != null && !managerNumber.isEmpty()) {
			managerNumber = "S" + String.format("%05d", Integer.parseInt(managerNumber));
		}
		
		model.addAttribute("managerNumber",managerNumber);
		return "workManage/WorkManageList";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage")
	public Map<String, Object> WorkManage(WorkManage search) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(!search.getManagerNumber().isEmpty()) {
			search.setWorkManageKeyNum(Integer.parseInt(search.getManagerNumber().replace("S", "")));
		}
		ArrayList<WorkManage> list = new ArrayList<>(workManageService.getWorkManageList(search));
		
		int totalCount = workManageService.getWorkManageListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/workManage/insertView")
	public String InsertWorkManageView(Model model, WorkManage workManage, Principal principal) {
		List<String> workManageCustomer = categoryService.getCategoryValue("customerName");
		List<String> workManageProductType = categoryService.getCategoryValue("managementServer");
		
		workManage.setWorkManageRequestDate(workManageService.nowDate());
		workManage.setWorkManageTestScheduleStart(workManageService.nowDate());
		workManage.setWorkManageTestScheduleEnd(workManageService.nowDate());
		
		model.addAttribute("viewType", "insert").addAttribute("workManage", workManage)
		.addAttribute("workManageCustomer", workManageCustomer).addAttribute("workManageProductType", workManageProductType);
		
		return "/workManage/WorkManageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/insert")
	public Map InsertWorkManage(WorkManage workManage, @RequestParam(required = false) List<MultipartFile> workManagePackageFileView, Principal principal) throws IllegalStateException, IOException {
		workManage.setWorkManageRegistrant(principal.getName());
		workManage.setWorkManageRegistrationDate(workManageService.nowDateDetail());
		workManage.setWorkManageAuthorView(employeeService.getEmployeeOne(principal.getName()).getEmployeeName());

		Map<String, Object> map = new HashMap<>();
		String result = workManageService.insertWorkManage(workManage, workManagePackageFileView);
		
		map.put("workManageKeyNum", workManage.getWorkManageKeyNum());
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/workManage/updateView")
	public String UpdateWorkManageView(Model model, int workManageKeyNum) {
		WorkManage workManage = workManageService.getWorkManageOne(workManageKeyNum);
		List<String> workManageCustomer = categoryService.getCategoryValue("customerName");
		List<String> workManageProductType = categoryService.getCategoryValue("managementServer");

		model.addAttribute("viewType", "update").addAttribute("workManage", workManage)
		.addAttribute("workManageCustomer", workManageCustomer).addAttribute("workManageProductType", workManageProductType).addAttribute("workManageKeyNum", workManageKeyNum);
		return "/workManage/WorkManageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/update")
	public Map<String, String> UpdateWorkManage(
	        WorkManage workManage, Principal principal) throws IllegalStateException, IOException {
		workManage.setWorkManageModifier(principal.getName());
		workManage.setWorkManageModifiedDate(workManageService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = workManageService.updateWorkManage(workManage);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/delete")
	public String WorkManageDelete(@RequestParam int[] chkList) {
		return workManageService.delWorkManage(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/deleteFlag")
	public String WorkManageDeleteFlag(@RequestParam int[] chkList, String workManageDelReaon) {
		return workManageService.delWorkManageFlag(chkList, workManageDelReaon);
	}
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	@GetMapping(value = "/workManageDownLoad/fileDownload")
	public View FileDownload(@RequestParam String fileName, Principal principal, Model model) {
		// 앞의 숫자_ 제거
		String logicalName = fileName.replaceFirst("^\\d+_", "");
		
		String filePath = this.filePath + File.separator + "workManage";
		model.addAttribute("fileUploadPath", filePath);           // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);     // 파일 이름    
		model.addAttribute("fileLogicalName", logicalName);          // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	public static boolean isKorean(String str) {
        return str.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*");
    }
	
	@ResponseBody
	@PostMapping(value = "/workManage/mailSend")
	public String MailSend(int workManageKeyNum, Principal principal) throws UnknownHostException {
		String localIp = InetAddress.getLocalHost().getHostAddress();
		String result = "OK";
		WorkManage workManage =workManageService.getWorkManageOne(workManageKeyNum);
		
		workManage.setWorkManageDetailNote(xssConfig.sanitize(workManage.getWorkManageDetailNote()));
		String host = "mail.secuve.com";                                                                           
		String port = "25";                                                                           
		String password = "";                                                                   
		String from = "";
		String fromName = "";
		
		if("admin".equals(principal.getName())) {
			from = "ksyang@secuve.com";
			fromName = "양 기석";
		} else {
			from = principal.getName() + "@secuve.com";
			fromName = employeeService.getEmployeeOne(principal.getName()).getEmployeeName();
		}
		
		String to[] = workManage.getWorkManageTester().split("\\s*,\\s*");
		
		Set<String> toSet = new HashSet<>();
		for (String t : to) {
		    if (t != null) toSet.add(t.trim().toLowerCase());
		}

		List<String> ccList = new ArrayList<>();
		Map<String, String> qaMap = new HashMap<>();
		qaMap.put("khkim@secuve.com", "김 기호");
		
		if(localIp.equals("172.16.100.90")) {
			ccList.add("김 기호 <khkim@secuve.com>");
		} else {
			ccList.add("양 기석 <ksyang@secuve.com>");
			qaMap.put("bspark@secuve.com", "박 범수");
			qaMap.put("smlee@secuve.com", "이 상민");
		}
		
		for (String email : qaMap.keySet()) {
			String name = qaMap.get(email);
			
			String formattedEmail = name + " <" + email + ">";
			ccList.add(formattedEmail);
		}
		
		for (int i = 0; i < to.length; i++) {
		    String inner = to[i].replaceAll(".*\\(([^)]+)\\).*", "$1");
		    to[i] = inner + "@secuve.com";
		    if (isKorean(to[i])) {
		        return "Korean";
		    }
		}

		StringBuilder testProduct = new StringBuilder();

		if(workManage.getWorkManagePackageNameView() != null) {
			for (int i = 0; i < workManage.getWorkManagePackageNameView().size(); i++) {
	
			    if (workManage.getWorkManagePackageNameView().get(i) != null && !workManage.getWorkManagePackageNameView().get(i).isEmpty()) {
	
			        testProduct.append("<b>" + workManage.getWorkManageProductTypeView().get(i) + "</b>")
			                   .append("  /  ")
			                   .append(workManage.getWorkManagePackageNameView().get(i))
			                   .append("<br>");
			    }
			}
		}

		String subject = "[" + workManage.getWorkManageCustomer() + "] " + workManage.getWorkManageOneLine();
		
		String url = "";
		if(localIp.equals("172.16.100.90")) {
			url = "https://172.16.100.90/AgentInfo/workManageDownLoad/downloadUrl?number=";
		} else {
			url = "https://qa.secuve.com/AgentInfo/workManageDownLoad/downloadUrl?number=";
		}
		
		String detailNote = workManage.getWorkManageDetailNote();
		if (detailNote == null) {
		    detailNote = "";
		} else {
		    detailNote = detailNote.trim();

		    detailNote = detailNote.replaceAll("(?i)<html[^>]*>\\s*(<br\\s*/?>\\s*)*", "")
		                           .replaceAll("(?i)<head[^>]*>.*?</head>\\s*(<br\\s*/?>\\s*)*", "")
		                           .replaceAll("(?i)<body[^>]*>\\s*(<br\\s*/?>\\s*)*", "")
		                           .replaceAll("(?i)(<br\\s*/?>\\s*)*</body>", "")
		                           .replaceAll("(?i)(<br\\s*/?>\\s*)</html>", "");

		    detailNote = detailNote.replaceAll("(?=\\d\\.\\s)", "<br><br>")   // 대항목 번호 앞에 여백 주입
		                           .replaceAll("(?<=\\))\\s+(?=\\d\\.)", "") 
		                           .replaceAll("(?<=\\S)\\s+(?=-)", "<br>- "); // 항목 대시 기호 바로 앞에 줄바꿈 1번만 주입

		    detailNote = detailNote.replace("\r\n", "<br>").replace("\n", "<br>").replace("\r", "<br>");
		    
		    while (true) {
		        detailNote = detailNote.trim();
		        if (detailNote.startsWith("<br>")) {
		            detailNote = detailNote.substring(4);
		        } else if (detailNote.startsWith("<br />")) {
		            detailNote = detailNote.substring(6);
		        } else {
		            break;
		        }
		    }
		    
		    detailNote = detailNote.trim();
		}


		String text =
		        "<div style='font-family:맑은 고딕; font-size:14px; line-height:1.6;'>"

		        + "<div style='font-size:16px; font-weight:bold; color:#2F5597;'>"
		        + "패키지 테스트 바랍니다.<br>"
		        + "코드번호 : "+"S" + String.format("%05d", workManageKeyNum)
		        + "</div><br>"

		        + "<table style='border-collapse:collapse; font-size:14px;'>"

		        + "<tr>"
		        + "<td style='width:100px; font-weight:bold;'>고객사</td>"
		        + "<td>" + workManage.getWorkManageCustomer() + "</td>"
		        + "</tr>"

		        + "<tr>"
		        + "<td style='font-weight:bold;'>엔지니어</td>"
		        + "<td>" + workManage.getWorkManageEngineer() + "</td>"
		        + "</tr>"

		        + "<tr>"
		        + "<td style='font-weight:bold;'>요청일자</td>"
		        + "<td>" + workManage.getWorkManageRequestDate() + "</td>"
		        + "</tr>"

		        + "<tr>"
		        + "<td style='font-weight:bold;'>희망일자</td>"
		        + "<td>" + workManage.getWorkManageCompleteDate() + "</td>"
		        + "</tr>"

		        + "</table><br>"

		        + "<div style='font-weight:bold; color:#2F5597;'>■ 패키지 목록</div>"
		        + "<div style='padding-left:5px;'>"
		        + testProduct
		        + "</div><br>"
		        
		        + "<div style='font-weight:bold; color:#2F5597;'>■ 다운로드 URL</div>"
		        + "<div style='padding-left:5px;'>"
		        + url + workManageKeyNum
		        + "</div><br>"
		        
		        + "<div style='font-weight:bold; color:#2F5597;'>■ 테스트 담당자 / 일정</div>"
		        + "<div style='padding-left:5px;'>"
		        + workManage.getWorkManageTester() + " /"
		        + "<br>" 
		        + workManage.getWorkManageTestScheduleStart()
		        + " ~ "
		        + workManage.getWorkManageTestScheduleEnd()
		        + "</div><br>"

		        + "<div style='font-weight:bold; color:#2F5597;'>■ 상세 내용</div>"

		        + "<div style='padding:15px; "
		        + "border:1px solid #d9d9d9; "
		        + "background-color:#f8f9fa; "
		        //+ "border-radius:6px; "
		        + "color:#333333; "
		        + "font-size:14px; "
		        //+ "line-height:1.8; " // 본문 줄간격을 여유 있게 조정
		        + "font-family:\"Malgun Gothic\", sans-serif; "
		        + "word-break:break-all;'>"

		        + detailNote

		        + "</div>"

		        + "<br><br>"
		        + "<div style='font-size:12px; color:#888888;'>"
		        + "※ 본 메일은 시스템에서 자동 발송되었습니다."
		        + "</div>"

		        + "</div>";
		
		System.out.println("------------------------------ SecuveMailSender START ------------------------------");
		System.out.println("server: host=" + host + ", port=" + port);                                                 
		System.out.println("message: " + from + "," + to + "," + subject);                                             
		                                                                                                              
		JavaMailSenderImpl mail = new JavaMailSenderImpl();                                                           
		mail.setHost(host);                                                                                           
		mail.setPort(Integer.parseInt(port));                                                                            
		                                                                                                              
		if (!StringUtils.isEmpty(password)) {                                                                         
			mail.setUsername(from);                                                                                     
			mail.setPassword(password);                                                                                 
		}                                                                                                             
		                                                                                                              
		try {                                                                                                         
			MimeMessage message = mail.createMimeMessage();                                                             
			MimeMessageHelper msg = new MimeMessageHelper(message, true, "UTF-8");                                      
			  
			msg.setFrom(new javax.mail.internet.InternetAddress(from, fromName, "UTF-8"));
			//msg.setFrom(from);                                                                                          
			msg.setTo(to);
			if (!ccList.isEmpty()) {
			    // 조립된 한글이름 포함 주소 리스트를 배열로 변환하여 주입
			    String[] ccArray = ccList.toArray(new String[0]);
			    msg.setCc(ccArray); 
			}
			msg.setSubject(subject);                                                                                    
			msg.setText(text, true);
			
			// 첨부파일 경로
	        String basePath = this.filePath + File.separator + "workManage" + File.separator;
	        long maxFileSize = 5 * 1024 * 1024;


	        // 첨부파일 추가
	        if(workManage.getWorkManagePackageNameView() != null) {
		        for (String fileName : workManage.getWorkManagePackageFileNameView()) {
		            if (fileName != null && !fileName.isEmpty()) {
		                File attFile = new File(basePath + fileName);
		                if (attFile.exists()) {
		                    long fileSize = attFile.length();
	
		                    if (fileSize > maxFileSize) {
		                    	System.out.println("첨부 제외(5MB 초과) : " + attFile.getName() + " / " + (fileSize / 1024 / 1024) + "MB");
		                    	result = "SizeFull";
		                    	continue;
		                    }
	
		                    msg.addAttachment(attFile.getName(), attFile);
		                    System.out.println("첨부파일 추가 : " + attFile.getAbsolutePath());
		                } else {
		                    System.out.println("첨부파일 없음 : " + attFile.getAbsolutePath());
		                }
		            }
		        }
	        }
			
			mail.send(message);                                                                                         
			System.out.println("sendMail() success.");                                                                   
			System.out.println("------------------------------ SecuveMailSender END ------------------------------");

			if(result == "OK") {
				mailSendService.setMailSendList("WorkManage",workManageKeyNum,principal.getName(),workManageService.nowDateDetail());
			}
			return result;                                                                                                
		}                                                                                                             
		catch (Exception e) {
			System.out.println("sendMail() failed.");
			System.out.println(e);
		  	return "False";                                                                                               
		} 
	}
	
	@GetMapping(value = "/workManageDownLoad/downloadUrl")
	public String FileDownloadUrl(int number, Model model) {
		WorkManage workManage = workManageService.getWorkManageOne(number);
		model.addAttribute("workManage", workManage).addAttribute("workManageKeyNum", number);
		return "/workManage/WorkManageDownLoad";
	}
	
	@PostMapping(value = "/workManage/progressView")
	public String progressView(@RequestParam int[] chkList, Model model) {
		WorkManage workManage = new WorkManage();
		if(chkList.length == 1) {
			workManage = workManageService.getWorkManageOne(chkList[0]);
		}
		model.addAttribute("workManage",workManage);
		return "/workManage/ProgressView";
	}
	
	@PostMapping(value = "/workManage/deleteFlagView")
	public String deleteFlagView(@RequestParam int[] chkList, Model model) {
		return "/workManage/DeleteFlagView";
	}
	
	@PostMapping(value = "/workManage/mailSendListView")
	public String mailSendListView(@RequestParam int[] chkList, Model model) {
		ArrayList<MailSendList> mailSendList = new ArrayList<>(mailSendService.getMailSendList("workManage", chkList[0]));
		model.addAttribute("mailSendList", mailSendList);
		return "/workManage/MailSendListView";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/progressChange")
	public Map<String, String> progressChange(@RequestParam int[] chkList, @RequestParam String workManageCommentView, @RequestParam String workManageProgressView, Principal principal) throws UnknownHostException {

		Map<String, String> map = new HashMap<String, String>();
		String result = workManageService.progressChange(chkList, workManageCommentView, workManageProgressView, principal);
		if ("100".equals(workManageProgressView)) {
			for (int workManageKeyNum : chkList) {
				WorkManage workManage = workManageService.getWorkManageOne(workManageKeyNum);
				
				String url = "";
				String to = "";
				String toName = "";
				String localIp = InetAddress.getLocalHost().getHostAddress();
				
				Map<String, String> qaMap = new HashMap<>();
				qaMap.put("khkim@secuve.com", "김 기호");
				
				if(localIp.equals("172.16.100.90")) {
					url = "https://172.16.100.90/AgentInfo/workManage/list?managerNumber="+workManageKeyNum;
					to = "khkim@secuve.com";
					toName = "김 기호";
				} else {
					url = "https://qa.secuve.com/AgentInfo/workManage/list?managerNumber="+workManageKeyNum;
					to = "ksyang@secuve.com";
					toName = "양 기석";
					qaMap.put("bspark@secuve.com", "박 범수");
					qaMap.put("smlee@secuve.com", "이 상민");
				}
				
				String host = "mail.secuve.com";                                                                           
				String port = "25";                                                                           
				String password = "";      
				String from = "";
				String fromName = "";
				if("admin".equals(principal.getName())) {
					from = "ksyang@secuve.com";
					fromName = "양 기석";
				} else {
					from = principal.getName() + "@secuve.com";
					fromName = employeeService.getEmployeeOne(principal.getName()).getEmployeeName();
				}
				
				List<String> ccList = new ArrayList<>();
				
				for (String email : qaMap.keySet()) {
					String name = qaMap.get(email);
					
					String formattedEmail = name + " <" + email + ">";
					ccList.add(formattedEmail);
				}

				StringBuilder testProduct = new StringBuilder();
				if(workManage.getWorkManagePackageNameView() != null) {
					for (int i = 0; i < workManage.getWorkManagePackageNameView().size(); i++) {
					    if (workManage.getWorkManagePackageNameView().get(i) != null && !workManage.getWorkManagePackageNameView().get(i).isEmpty()) {
	
					        testProduct.append("<b>" + workManage.getWorkManageProductTypeView().get(i) + "</b>")
					                   .append("  /  ")
					                   .append(workManage.getWorkManagePackageNameView().get(i))
					                   .append("<br>");
					    }
					}
				}
	
				String subject = "[" + workManage.getWorkManageCustomer() + "] 진행률 100%로 변경";
				
				String text =
				"<div style='font-family:맑은 고딕; font-size:14px; line-height:1.6;'>"
				    + "<div style='font-size:16px; font-weight:bold; color:#2F5597;'>"
				    + "진행률 100% 변경 안내<br>코드번호 : "+"S" + String.format("%05d", workManageKeyNum)
				    + "</div><br>"

				    + "<table style='border-collapse:collapse; font-size:14px;'>"

				    + "<tr>"
				    + "<td style='width:100px; font-weight:bold;'>고객사</td>"
				    + "<td>" + workManage.getWorkManageCustomer() + "</td>"
				    + "</tr>"

				    + "<tr>"
				    + "<td style='font-weight:bold;'>엔지니어</td>"
				    + "<td>" + workManage.getWorkManageEngineer() + "</td>"
				    + "</tr>"

				    + "<tr>"
				    + "<td style='font-weight:bold;'>요청일자</td>"
				    + "<td>" + workManage.getWorkManageRequestDate() + "</td>"
				    + "</tr>"

				    + "<tr>"
				    + "<td style='font-weight:bold;'>희망일자</td>"
				    + "<td>" + workManage.getWorkManageCompleteDate() + "</td>"
				    + "</tr>"

				    + "</table><br>"

				    + "<div style='font-weight:bold; color:#2F5597;'>■ 패키지 목록</div>"
				    + "<div style='padding-left:5px;'>"
				    + testProduct
				    + "</div><br>"

				    + "<div style='font-weight:bold; color:#2F5597;'>■ 테스트 일정</div>"
				    + "<div style='padding-left:5px;'>"
				    + workManage.getWorkManageTestScheduleStart()
				    + " ~ "
				    + workManage.getWorkManageTestScheduleEnd()
				    + "</div><br>"

				    + "<div style='font-weight:bold; color:#2F5597;'>■ 테스트 결과 비고</div>"

				    + "<div style='margin-top:5px; padding:12px; "
				    + "border:1px solid #d9d9d9; "
				    + "background-color:#f8f9fa; "
				    + "border-radius:6px;'>"

				    + workManage.getWorkManageComment()
					+ "<a href='"+url+"' "
				    + "style='color:#2F5597; text-decoration:none; font-weight:bold;'>"
				    + "업무관리 바로가기"
				    + "</a>"

				    + "</div><br>"
				    
				    + "<div style='font-weight:bold; color:#2F5597;'>■ 안내 내용</div>"

				    + "<div style='margin-top:5px; padding:12px; "
				    + "border:1px solid #d9d9d9; "
				    + "background-color:#f8f9fa; "
				    + "border-radius:6px;'>"

				    + "테스트 진행률이 <b style='color:#d9534f;'>100%</b> 로 변경되었습니다.<br>"
				    + "진행 확인 후 진행 상태 변경 부탁드립니다."

				    + "</div>"

				    + "<br><br>"
				    + "<div style='font-size:12px; color:#888888;'>"
				    + "※ 본 메일은 시스템에서 자동 발송되었습니다."
				    + "</div>"

				    + "</div>";
				
				System.out.println("------------------------------ SecuveMailSender START ------------------------------");
				System.out.println("server: host=" + host + ", port=" + port);                                                 
				System.out.println("message: " + from + "," + to + "," + subject);                                             
				                                                                                                              
				JavaMailSenderImpl mail = new JavaMailSenderImpl();                                                           
				mail.setHost(host);                                                                                           
				mail.setPort(Integer.parseInt(port));                                                                            
				                                                                                                              
				if (!StringUtils.isEmpty(password)) {                                                                         
					mail.setUsername(from);                                                                                     
					mail.setPassword(password);                                                                                 
				}                                                                                                             
				                                                                                                              
				try {                                                                                                         
					MimeMessage message = mail.createMimeMessage();                                                             
					MimeMessageHelper msg = new MimeMessageHelper(message, true, "UTF-8");                                      
					                                                                                                            
					msg.setFrom(new javax.mail.internet.InternetAddress(from, fromName, "UTF-8"));
					msg.setTo(new javax.mail.internet.InternetAddress(to, toName, "UTF-8"));
					if (!ccList.isEmpty()) {
					    // 조립된 한글이름 포함 주소 리스트를 배열로 변환하여 주입
					    String[] ccArray = ccList.toArray(new String[0]);
					    msg.setCc(ccArray); 
					}
					msg.setSubject(subject);                                                                                    
					msg.setText(text, true);
					
					mail.send(message);                                                                                         
					System.out.println("sendMail() success.");                                                                   
					System.out.println("------------------------------ SecuveMailSender END ------------------------------");
	
				}                                                                                                             
				catch (Exception e) {
					System.out.println("sendMail() failed.");
					System.out.println(e);
				} 
			}
	    }
		map.put("result", result);
		return map;
	}
	
	@GetMapping("/workManage/allReportDownload")
	public void allReportDownload(HttpServletResponse response)
	        throws Exception {
	    StringBuilder txt = new StringBuilder();
	    txt.append("주간업무내역서\r\n\r\n");
	    txt.append(workManageService.getPeriod());
	    txt.append("작 성 자 :    양 기 석       (서명)\r\n\r\n");
	    txt.append("확 인 자 :    한 승 호       (서명)\r\n\r\n");
	    txt.append("제 출 처 :    주덕규 상무   (서명)\r\n\r\n");
	    txt.append("O 진행사항\r\n\r\n");

	    List<String> customerList = workManageService.getCustomerList();
	    int count = 1;
	    
	    for(String workManageCustomer : customerList) {
	    	List<WorkManage> workManageCustomerProgressList = workManageService.getWorkManageCustomerAllProgressList(workManageCustomer);
	    	if(workManageCustomerProgressList == null || workManageCustomerProgressList.isEmpty()) {
	    		continue;
	    	}
	    	txt.append(count + ". " + workManageCustomer + "\r\n");
	    	for(WorkManage workManage : workManageCustomerProgressList) {
	    		String tester = workManage.getWorkManageTester().replaceAll("\\([^)]*\\)", "").replace(",", " /");
	    		txt.append("     - " + workManage.getWorkManageOneLine() + "  (진척률 : " + workManage.getWorkManageProgress() + ")  " + tester + "\r\n");
	    	}
	    	txt.append("\r\n");
	    	count++;
	    }
	    
	    count = 1;
	    txt.append("\r\n\r\n\r\n");
	    txt.append("O 예정사항\r\n\r\n");
	    for(String workManageCustomer : customerList) {
	    	List<WorkManage> workManageCustomerExpectedList = workManageService.getWorkManageCustomerAllExpectedList(workManageCustomer);
	    	if(workManageCustomerExpectedList == null || workManageCustomerExpectedList.isEmpty()) {
	    		continue;
	    	}
	    	txt.append(count + ". " + workManageCustomer + "\r\n");
	    	for(WorkManage workManage : workManageCustomerExpectedList) {
	    		String tester = workManage.getWorkManageTester().replaceAll("\\([^)]*\\)", "").replace(",", " /");
	    		if(workManage.getWorkManageTestScheduleEnd().isEmpty()) {
	    			workManage.setWorkManageTestScheduleEnd("테스트 완료 시 까지");
	    		}
	    		txt.append("     - " + workManage.getWorkManageOneLine() + "  (~ 완료예정 : " + workManage.getWorkManageTestScheduleEnd() + ")  " + tester + "\r\n");
	    	}
	    	txt.append("\r\n");
	    	count++;
	    }
	    

	    Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
		
	    // 파일명
	    String fileName = "평가인증개발본부_QA팀(양기석)_" + formatter.format(now) + ".txt";
	    response.setContentType("text/plain; charset=UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    response.setHeader(
	            "Content-Disposition",
	            "attachment; filename=\""
	            + URLEncoder.encode(fileName, "UTF-8")
	            + "\""
	    );

	    OutputStream os = response.getOutputStream();
	    os.write(txt.toString().getBytes(StandardCharsets.UTF_8));
	    os.flush();
	    os.close();
	}
	
	@GetMapping("/workManage/weeklyReportDownload")
	public void weeklyReportDownload(HttpServletResponse response, Principal principal) throws Exception {
		String employeeName = employeeService.getEmployeeOne(principal.getName()).getEmployeeName();
	    StringBuilder txt = new StringBuilder();
	    txt.append("주간업무내역서\r\n\r\n");
	    txt.append(workManageService.getPeriod());
	    txt.append("작 성 자 :    양 기 석       (서명)\r\n\r\n");
	    txt.append("확 인 자 :    " + employeeName.replaceAll("", " ").trim() + "       (서명)\r\n\r\n");
	    txt.append("제 출 처 :    주덕규 상무   (서명)\r\n\r\n");
	    txt.append("O 진행사항\r\n\r\n");

	    List<String> customerList = workManageService.getCustomerList();
	    int count = 1;
	    
	    for(String workManageCustomer : customerList) {
	    	List<WorkManage> workManageCustomerProgressList = workManageService.getWorkManageCustomerWeeklyProgressList(workManageCustomer, employeeName);
	    	if(workManageCustomerProgressList == null || workManageCustomerProgressList.isEmpty()) {
	    		continue;
	    	}
	    	txt.append(count + ". " + workManageCustomer + "\r\n");
	    	for(WorkManage workManage : workManageCustomerProgressList) {
	    		txt.append("     - " + workManage.getWorkManageOneLine() + "\r\n");
	    	}
	    	txt.append("\r\n");
	    	count++;
	    }
	    
	    count = 1;
	    txt.append("\r\n\r\n\r\n");
	    txt.append("O 예정사항\r\n\r\n");
	    for(String workManageCustomer : customerList) {
	    	List<WorkManage> workManageCustomerExpectedList = workManageService.getWorkManageCustomerWeeklyExpectedList(workManageCustomer, employeeName);
	    	if(workManageCustomerExpectedList == null || workManageCustomerExpectedList.isEmpty()) {
	    		continue;
	    	}
	    	txt.append(count + ". " + workManageCustomer + "\r\n");
	    	for(WorkManage workManage : workManageCustomerExpectedList) {
	    		txt.append("     - " + workManage.getWorkManageOneLine() + "\r\n");
	    	}
	    	txt.append("\r\n");
	    	count++;
	    }
	    
	    Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		
	    // 파일명
	    String fileName = "QA("+employeeName+")-"+formatter.format(now)+".txt";
	    response.setContentType("text/plain; charset=UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    response.setHeader(
	            "Content-Disposition",
	            "attachment; filename=\""
	            + URLEncoder.encode(fileName, "UTF-8")
	            + "\""
	    );

	    OutputStream os = response.getOutputStream();
	    os.write(txt.toString().getBytes(StandardCharsets.UTF_8));
	    os.flush();
	    os.close();
	}
}
