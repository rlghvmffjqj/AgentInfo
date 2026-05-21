package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

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
import com.secuve.agentInfo.service.WorkManageService;
import com.secuve.agentInfo.vo.WorkManage;

@Controller
public class WorkManageController {
	@Autowired WorkManageService workManageService;
	@Autowired EmployeeService employeeService;
	@Autowired FavoritePageService favoritePageService;
	@Autowired CategoryService categoryService;
	@Autowired XssConfig xssConfig;

	@GetMapping(value = "/workManage/list")
	public String WorkManageList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "업무 관리");
		
		return "workManage/WorkManageList";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage")
	public Map<String, Object> WorkManage(WorkManage search) {
		Map<String, Object> map = new HashMap<String, Object>();
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
	public Map InsertWorkManage(
	        WorkManage workManage,
	        @RequestParam(required = false) MultipartFile workManagePackageFileOneView,
	        @RequestParam(required = false) MultipartFile workManagePackageFileTwoView,
	        @RequestParam(required = false) MultipartFile workManagePackageFileThreeView,
	        @RequestParam(required = false) MultipartFile workManagePackageFileFourView,
	        Principal principal) throws IllegalStateException, IOException {
		workManage.setWorkManageRegistrant(principal.getName());
		workManage.setWorkManageRegistrationDate(workManageService.nowDateDetail());
		workManage.setWorkManageAuthorView(employeeService.getEmployeeOne(principal.getName()).getEmployeeName());

		Map<String, Object> map = new HashMap<>();
		String result = workManageService.insertWorkManage(workManage, workManagePackageFileOneView, workManagePackageFileTwoView, workManagePackageFileThreeView, workManagePackageFileFourView);
		
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
		.addAttribute("workManageCustomer", workManageCustomer).addAttribute("workManageProductType", workManageProductType);
		return "/workManage/WorkManageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/update")
	public Map<String, String> UpdateWorkManage(
	        WorkManage workManage,
	        @RequestParam(required = false) MultipartFile workManagePackageFileOneView,
	        @RequestParam(required = false) MultipartFile workManagePackageFileTwoView,
	        @RequestParam(required = false) MultipartFile workManagePackageFileThreeView,
	        @RequestParam(required = false) MultipartFile workManagePackageFileFourView,
	        Principal principal) throws IllegalStateException, IOException {
		workManage.setWorkManageModifier(principal.getName());
		workManage.setWorkManageModifiedDate(workManageService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = workManageService.updateWorkManage(workManage, workManagePackageFileOneView, workManagePackageFileTwoView, workManagePackageFileThreeView, workManagePackageFileFourView);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/workManage/delete")
	public String WorkManageDelete(@RequestParam int[] chkList) {
		return workManageService.delWorkManage(chkList);
	}
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	@GetMapping(value = "/workManage/fileDownload")
	public View FileDownload(@RequestParam String fileName, Principal principal, Model model) {
		String filePath = this.filePath + File.separator + "workManage";
		model.addAttribute("fileUploadPath", filePath);           // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);     // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);          // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	public static boolean isKorean(String str) {
        return str.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*");
    }
	
	@ResponseBody
	@PostMapping(value = "/workManage/mailSend")
	public String MailSend(int workManageKeyNum, Principal principal) {
		String result = "OK";
		WorkManage workManage =workManageService.getWorkManageOne(workManageKeyNum);
		
		workManage.setWorkManageDetailNote(xssConfig.sanitize(workManage.getWorkManageDetailNote()));
		String host = "mail.secuve.com";                                                                           
		String port = "25";                                                                           
		String password = "";                                                                   
		String from = principal.getName() + "@secuve.com";   

		String[] to = workManage.getWorkManageTester().split("\\s*,\\s*");
		
		for (int i = 0; i < to.length; i++) {
		    String inner = to[i].replaceAll(".*\\(([^)]+)\\).*", "$1");
		    to[i] = inner + "@secuve.com";
		    if (isKorean(to[i])) {
		        return "Korean";
		    }
		}
		String[] productTypes = {
		        workManage.getWorkManageProductTypeOne(),
		        workManage.getWorkManageProductTypeTwo(),
		        workManage.getWorkManageProductTypeThree(),
		        workManage.getWorkManageProductTypeFour()
		};

		String[] packageNames = {
		        workManage.getWorkManagePackageNameOne(),
		        workManage.getWorkManagePackageNameTwo(),
		        workManage.getWorkManagePackageNameThree(),
		        workManage.getWorkManagePackageNameFour()
		};

		StringBuilder testProduct = new StringBuilder();

		for (int i = 0; i < packageNames.length; i++) {

		    if (packageNames[i] != null && !packageNames[i].isEmpty()) {

		        testProduct.append("<b>" + productTypes[i] + "</b>")
		                   .append("  /  ")
		                   .append(packageNames[i])
		                   .append("<br>");
		    }
		}

		String subject = "[" + workManage.getWorkManageCustomer() + "] " + workManage.getWorkManageOneLine();

		String text =
		        "<div style='font-family:맑은 고딕; font-size:14px; line-height:1.6;'>"

		        + "<div style='font-size:16px; font-weight:bold; color:#2F5597;'>"
		        + "패키지 테스트 바랍니다."
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

		        + "<div style='font-weight:bold; color:#2F5597;'>■ 상세 내용</div>"

		        + "<div style='margin-top:5px; padding:12px; "
		        + "border:1px solid #d9d9d9; "
		        + "background-color:#f8f9fa; "
		        + "border-radius:6px;'>"

		        + workManage.getWorkManageDetailNote()

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
			                                                                                                            
			msg.setFrom(from);                                                                                          
			msg.setTo(to);
			msg.setSubject(subject);                                                                                    
			msg.setText(text, true);
			
			// 첨부파일 경로
	        String basePath = this.filePath + File.separator + "workManage" + File.separator;
	        long maxFileSize = 5 * 1024 * 1024;

	        // 첨부파일 목록
	        String[] fileNames = {
	                workManage.getWorkManagePackageFileOne(),
	                workManage.getWorkManagePackageFileTwo(),
	                workManage.getWorkManagePackageFileThree(),
	                workManage.getWorkManagePackageFileFour()
	        };

	        // 첨부파일 추가
	        for (String fileName : fileNames) {
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
			
			mail.send(message);                                                                                         
			System.out.println("sendMail() success.");                                                                   
			System.out.println("------------------------------ SecuveMailSender END ------------------------------");

			return result;                                                                                                
		}                                                                                                             
		catch (Exception e) {
			System.out.println("sendMail() failed.");
			System.out.println(e);
		  	return "False";                                                                                               
		} 
	}
	
	@GetMapping(value = "/workManage/downloadUrl")
	public String FileDownloadUrl(int number, Model model) {
		WorkManage workManage = workManageService.getWorkManageOne(number);
		model.addAttribute("workManage", workManage);
		return "/workManage/WorkManageDownLoad";
	}
}
