package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
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
	
	
	@GetMapping(value = "/customPackage/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) {
		model.addAttribute("fileUploadPath", filePath);           // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);     // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);          // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	
	@GetMapping(value = "/customPackage/batchDownload")
	public View BatchDownload(@RequestParam int chkList[], Principal principal, Model model) {
		
		String files[] = customPackageService.BatchDownload(chkList);
		String changeFileName =  "CustomPackage-" + principal.getName() + ".zip"; 
		
		String zipFileName  = filePath + File.separator + changeFileName;		//ZIP 압축 파일명
		byte[] buf = new byte[4096];
		try {
		    ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
		    for (int i=0; i<files.length; i++) {
		    	files[i] = filePath + File.separator + files[i];
		        FileInputStream in = new FileInputStream(files[i]);
		        Path p = Paths.get(files[i]);
		        String fileName = p.getFileName().toString();
		                
		        ZipEntry ze = new ZipEntry(fileName);
		        out.putNextEntry(ze);
		          
		        int len;
		        while ((len = in.read(buf)) > 0) {
		            out.write(buf, 0, len);
		        }
		          
		        out.closeEntry();
		        in.close();
		    }
		          
		    out.close();
		} catch (IOException e) {
		    e.printStackTrace();
		}
		
		model.addAttribute("fileUploadPath", filePath);					// 파일 경로
		model.addAttribute("filePhysicalName", "/"+changeFileName);		// 파일 이름
		model.addAttribute("fileLogicalName", "CustomPackage.zip");		// 출력할 파일 이름
	
		return new FileDownloadView();
	}

}
