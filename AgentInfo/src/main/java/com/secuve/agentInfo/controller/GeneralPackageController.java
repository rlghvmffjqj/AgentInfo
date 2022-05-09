package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.secuve.agentInfo.service.GeneralPackageService;
import com.secuve.agentInfo.vo.GeneralPackage;
import com.secuve.agentInfo.vo.Packages;

@Controller
public class GeneralPackageController {
	@Autowired GeneralPackageService generalPackageService;
	@Autowired CategoryService categoryService;
	
	@GetMapping(value = "/generalPackage/List")
	public String GeneralPackageList( Model model) {
		return "generalPackage/GeneralPackageList";
	}
	
	@ResponseBody
	@PostMapping(value = "/generalPackage")
	public Map<String, Object> GeneralPackage(GeneralPackage search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<GeneralPackage> list = new ArrayList<>(generalPackageService.getGeneralPackage(search));

		int totalCount = generalPackageService.getGeneralPackageCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/generalPackage/insertView")
	public String InsertGeneralPackageView(Model model) {
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("viewType","insert");
		return "/generalPackage/GeneralPackageView";
	}
	
	@PostMapping(value = "/generalPackage/updateView")
	public String UpdateGeneralPackageView(Model model, int generalPackageKeyNum) {
		GeneralPackage generalPackage = generalPackageService.getGeneralPackageOne(generalPackageKeyNum);
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("viewType","update").addAttribute("generalPackage", generalPackage);
		return "/generalPackage/GeneralPackageView";
	}
	
	
	
	@ResponseBody
	@PostMapping(value = "/generalPackage/insert")
	public Map<String, String> InsertGeneralPackage(GeneralPackage generalPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		generalPackage.setGeneralPackageRegistrant(principal.getName());
		generalPackage.setGeneralPackageRegistrationDate(generalPackageService.nowDate());
		
		Map<String, String> map = new HashMap<String, String>();
		String result = generalPackageService.insertGeneralPackage(generalPackage, releaseNotesView, principal);
		
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/generalPackage/update")
	public Map<String, String> UpdateGeneralPackage(GeneralPackage generalPackage, MultipartFile releaseNotesView, Principal principal) throws IllegalStateException, IOException {
		generalPackage.setGeneralPackageModifier(principal.getName());
		generalPackage.setGeneralPackageModifiedDate(generalPackageService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = generalPackageService.updateGeneralPackage(generalPackage, releaseNotesView, principal);
		
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/generalPackage/delete")
	public String deleteGeneralPackage(@RequestParam int[] chkList) {
		return generalPackageService.deleteGeneralPackage(chkList);
	}
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	@GetMapping(value = "/generalPackage/fileDownload", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
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
	
}
