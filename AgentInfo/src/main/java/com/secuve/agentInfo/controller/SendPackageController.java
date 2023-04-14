package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.SendPackageService;
import com.secuve.agentInfo.vo.SendPackage;

@Controller
public class SendPackageController {
	@Autowired SendPackageService sendPackageService;
	@Autowired CategoryService categoryService;
	
	/**
	 * 파일 저장 경로(application.properties 설정 정보)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;

	@GetMapping(value = "/sendPackage/list")
	public String SendPackageList(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> categoryBusinessName = categoryService.getCategoryBusinessNameList();
		List<String> managementServer = categoryService.getCategoryValue("managementServer");

		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", categoryBusinessName);
		model.addAttribute("managementServer", managementServer);
		return "/sendPackage/SendPackageList";
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage")
	public Map<String, Object> SendPackage(SendPackage search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<SendPackage> list = new ArrayList<>(sendPackageService.getSendPackage(search));
		
		int totalCount = sendPackageService.getSendPackageCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/sendPackage/insertView")
	public String InsertSendPackageView(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> categoryBusinessName = categoryService.getCategoryBusinessNameList();
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", categoryBusinessName);
		model.addAttribute("managementServer", managementServer);
		
		model.addAttribute("viewType","insert");
		return "/sendPackage/SendPackageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/existenceConfirmation")
	public String ExistenceConfirmation(String sendPackageFileName) {
		String filePath = this.filePath + File.separator + "sendPackage";
		
		// Create a file object
		File file = new File(filePath + File.separator + sendPackageFileName);
		
		boolean isExists = file.exists();
		
		if(isExists) {
			return "existence";
		} else {
			return "nonExistence";
		}
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/packagesCount")
	public int getPackagesCount(int packagesKeyNum) {
		return sendPackageService.getPackagesCount(packagesKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/insert")
	public Map<String, String> InsertSendPackage(SendPackage sendPackage, MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		sendPackage.setSendPackageRegistrant(principal.getName());
		sendPackage.setSendPackageRegistrationDate(sendPackageService.nowDate());
		
		List<MultipartFile> fileList = request.getFiles("sendPackageView");
		Map<String,String> resultMap = new HashMap<String, String>();
		
		Map<String, String> map = new HashMap<String, String>();
		for (MultipartFile sendPackageView : fileList) {
			resultMap = sendPackageService.insertSendPackage(sendPackage, sendPackageView);
			sendPackage.setSendPackageRandomUrl(resultMap.get("sendPackageRandomUrl"));
		}
		
		map.put("result", resultMap.get("result"));
		return map;
	}
	
	@GetMapping(value = "/PKG/download/{sendPackageRandomUrl}")
	public String SendPackageRandomUrl(@PathVariable String sendPackageRandomUrl, Model model) {
		ArrayList<SendPackage> list = new ArrayList<>(sendPackageService.getSendPackageListOne(sendPackageRandomUrl));
		model.addAttribute("sendPackageRandomUrl", sendPackageRandomUrl);
		model.addAttribute("list",list);
		return "/sendPackage/SendPackageDownload";
	}
	
	@ResponseBody
	@PostMapping(value = "/PKG/downloadCount")
	public void getFileName(@RequestParam String sendPackageName, @RequestParam String sendPackageRandomUrl) {
		sendPackageService.downloadCount(sendPackageName, sendPackageRandomUrl);
	}
	
	@GetMapping(value = "/PKG/fileDownload")
	public View FileDownload(@RequestParam String fileName, @RequestParam String url, Model model) throws Exception {
		if(!sendPackageService.getSendPackageOneUrl(fileName, url)) {
			return null;
		}
		sendPackageService.downloadCount(fileName, url);
		
		String filePath = this.filePath + File.separator + "sendPackage";
		
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName+"_"+url);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/delete")
	public String DeleteSendPackage(@RequestParam int[] chkList) {
		return sendPackageService.deleteSendPackage(chkList);
	}
	
	@PostMapping(value = "/sendPackage/updateView")
	public String UpdateSendPackageView(Model model, int sendPackageKeyNum) {
		SendPackage sendPackage = sendPackageService.getSendPackageOne(sendPackageKeyNum);
		
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", sendPackage.getCustomerName());
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("managementServer", managementServer);
		
		model.addAttribute("viewType", "update").addAttribute("sendPackage", sendPackage);
		return "/sendPackage/SendPackageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/packagesUpdate")
	public Map<String, String> UpdatePackages(SendPackage sendPackage, MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		sendPackage.setSendPackageModifier(principal.getName());
		sendPackage.setSendPackageModifiedDate(sendPackageService.nowDate());
		
		Map<String,String> resultMap = new HashMap<String, String>();
		List<MultipartFile> fileList = request.getFiles("sendPackageView");
		Map<String, String> map = new HashMap<String, String>();
		List<SendPackage> sendPackageListPackage = new ArrayList<SendPackage>();
		sendPackageListPackage = sendPackageService.getSendPackageListPackages(sendPackage.getPackagesKeyNum());
		if(!fileList.get(0).getOriginalFilename().equals("")) {
			
			if(sendPackageListPackage.size() > 0) {
				for(SendPackage sendPackageMulti : sendPackageListPackage) {
					sendPackageService.updateDelete(sendPackageMulti.getSendPackageKeyNum());
				}
			} 
			
			for (MultipartFile sendPackageView : fileList) {
				resultMap = sendPackageService.insertSendPackage(sendPackage, sendPackageView);
				sendPackage.setSendPackageRandomUrl(resultMap.get("sendPackageRandomUrl"));
			}
		} else {
			for(SendPackage sendPackageMulti : sendPackageListPackage) {
				sendPackage.setSendPackageKeyNum(sendPackageMulti.getSendPackageKeyNum());
				sendPackage.setSendPackageCountView(sendPackageMulti.getSendPackageCount());
				resultMap.put("result", sendPackageService.updateSendPackage(sendPackage));
			}
		}
		map.put("result", resultMap.get("result"));
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/update")
	public Map UpdateSendPackage(SendPackage sendPackage, MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		sendPackage.setSendPackageModifier(principal.getName());
		sendPackage.setSendPackageModifiedDate(sendPackageService.nowDate());
		
		List<MultipartFile> fileList = request.getFiles("sendPackageView");
		Map<String, String> map = new HashMap<String, String>();

		String result = sendPackageService.updateSendPackageFile(sendPackage, fileList.get(0));
		
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/sendPackage/copy")
	public void CopySendPackage(SendPackage sendPackage, MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		sendPackage.setSendPackageRegistrant(principal.getName());
		sendPackage.setSendPackageRegistrationDate(sendPackageService.nowDate());
		
		List<MultipartFile> fileList = request.getFiles("sendPackageView");
		
		for (MultipartFile sendPackageView : fileList) {
			sendPackageService.insertSendPackage(sendPackage, sendPackageView);
		}
		
	}
	
}
