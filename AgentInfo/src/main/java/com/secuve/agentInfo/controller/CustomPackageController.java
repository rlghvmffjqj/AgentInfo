package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.CustomPackageService;
import com.secuve.agentInfo.vo.CustomPackage;

@Controller
public class CustomPackageController {
	@Autowired CustomPackageService customPackageService;
	@Autowired CategoryService categoryService;
	
	@GetMapping(value = "/customPackage/List")
	public String CustomPackageList() {
		return "customPackage/CustomPackageList";
	}
	
	@ResponseBody
	@PostMapping(value = "/customPackage")
	public Map<String, Object> CustomPackage(CustomPackage search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<CustomPackage> list = new ArrayList<>(customPackageService.getCustomPackage(search));

		int totalCount = customPackageService.getCustomPackageCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/customPackage/insertView")
	public String InsertCustomPackageView(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("viewType","insert");
		return "/customPackage/CustomPackageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/customPackage/insert")
	public Map<String, String> InsertCustomPackage(CustomPackage customPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		customPackage.setCustomPackageRegistrant(principal.getName());
		customPackage.setCustomPackageRegistrationDate(customPackageService.nowDate());
		
		Map<String, String> map = new HashMap<String, String>();
		String result = customPackageService.insertCustomPackage(customPackage, releaseNotesView, principal);
		
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/customPackage/updateView")
	public String UpdateCustomPackageView(Model model, int customPackageKeyNum) {
		CustomPackage customPackage = customPackageService.getCustomPackageOne(customPackageKeyNum);
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", customPackage.getCustomerName());
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("viewType","update").addAttribute("customPackage", customPackage);
		return "/customPackage/CustomPackageView";
	}
	
	@ResponseBody
	@PostMapping(value = "/customPackage/update")
	public Map<String, String> UpdateCustomPackage(CustomPackage customPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		customPackage.setCustomPackageModifier(principal.getName());
		customPackage.setCustomPackageModifiedDate(customPackageService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = customPackageService.updateCustomPackage(customPackage, releaseNotesView, principal);
		
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/customPackage/delete")
	public String deleteCustomPackage(@RequestParam int[] chkList) {
		return customPackageService.deleteCustomPackage(chkList);
	}
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	@GetMapping(value = "/customPackage/fileDownload", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> fileDownload(@RequestParam String fileName, HttpServletRequest request) {
		 ResponseEntity<Resource> result = null;

	        try {
	            String originFileName = fileName;
	            String agent = request.getHeader("User-Agent");

	            Resource file = new FileSystemResource(filePath + File.separator + originFileName);

	            if(!file.exists()) return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	            
	          //브라우저별 한글파일 명 처리
                if(agent.contains("Trident"))//Internet Explore
                	originFileName = URLEncoder.encode(originFileName, "UTF-8").replaceAll("\\+", " ");
                    
                else if(agent.contains("Edge")) //Micro Edge
                	originFileName = URLEncoder.encode(originFileName, "UTF-8");
                    
                else //Chrome
                	originFileName = new String(originFileName.getBytes("UTF-8"), "ISO-8859-1");
                //브라우저별 한글파일 명 처리
	            
	            String onlyFileName = originFileName.substring(originFileName.lastIndexOf("_") + 1);
	            HttpHeaders header = new HttpHeaders();
	            header.add("Content-Disposition", "attachment; filename=" + onlyFileName);

	            result = new ResponseEntity<>(file, header, HttpStatus.OK);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/customPackage/batchDownload")
	public void BatchDownload() {
		
		
		
	}
	
	@ResponseBody
	@PostMapping(value = "/customPackage/existenceConfirmation")
	public String ExistenceConfirmation(MultipartFile releaseNotesView) {
		
		// Create a file object
		File file = new File(filePath + File.separator + releaseNotesView.getOriginalFilename());
		
		boolean isExists = file.exists();
		
		if(isExists) {
			return "existence";
		} else {
			return "nonExistence";
		}
	}
	
	
	
}
