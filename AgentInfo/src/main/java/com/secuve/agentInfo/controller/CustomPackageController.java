package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	
	/**
	 * 커스텀 패키지 이동
	 * @return
	 */
	@GetMapping(value = "/customPackage/List")
	public String CustomPackageList(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> osType = categoryService.getCategoryValue("osType");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("osType", osType);
		model.addAttribute("agentVer", agentVer);
		
		return "customPackage/CustomPackageList";
	}
	
	/**
	 * 커스텀 패키지 테이블 데이터 가져오기
	 * @param search
	 * @return
	 */
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
	
	/**
	 * 커스텀 패키지 추가 Modal
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/customPackage/insertView")
	public String InsertCustomPackageView(Model model) {
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> osType = categoryService.getCategoryValue("osType");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("osType", osType);
		model.addAttribute("viewType","insert");
		return "/customPackage/CustomPackageView";
	}
	
	/**
	 * 커스텀 패키지 추가
	 * @param customPackage
	 * @param releaseNotesView
	 * @param principal
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
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
	
	/**
	 * 커스텀 패키지 추가 Modal
	 * @param model
	 * @param customPackageKeyNum
	 * @return
	 */
	@PostMapping(value = "/customPackage/updateView")
	public String UpdateCustomPackageView(Model model, int customPackageKeyNum) {
		CustomPackage customPackage = customPackageService.getCustomPackageOne(customPackageKeyNum);
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", customPackage.getCustomerName());
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> osType = categoryService.getCategoryValue("osType");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("osType", osType);
		model.addAttribute("viewType","update").addAttribute("customPackage", customPackage);
		return "/customPackage/CustomPackageView";
	}
	
	/**
	 * 커스텀 패키지 추가
	 * @param customPackage
	 * @param releaseNotesView
	 * @param principal
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
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
	
	/**
	 * 커스텀 패키지 삭제
	 * @param chkList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customPackage/delete")
	public String deleteCustomPackage(@RequestParam int[] chkList) {
		return customPackageService.deleteCustomPackage(chkList);
	}
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	/**
	 * 파일 존재 유무 덮어쓰기하기위해 사용
	 * @param releaseNotesView
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/customPackage/existenceConfirmation")
	public String ExistenceConfirmation(MultipartFile releaseNotesView) {
		String filePath = this.filePath + File.separator + "releaseNotes";
		// Create a file object
		File file = new File(filePath + File.separator + releaseNotesView.getOriginalFilename());
		
		boolean isExists = file.exists();
		
		if(isExists) {
			return "existence";
		} else {
			return "nonExistence";
		}
	}
	
	/**
	 * 커스텀 패키지 단일 파일 다운로드
	 * @param fileName
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/customPackage/fileDownload")
	public View FileDownload(@RequestParam String fileName, Principal principal, Model model) {
		String filePath = this.filePath + File.separator + "releaseNotes";
		String files = fileName;
		String changeFileName =  fileName + "-" + principal.getName() + "-" + customPackageService.nowDate() + ".zip";  // 바뀌는 파일 명
		
		String zipFileName  = filePath + File.separator + "CustomPackageHistory"+ File.separator + changeFileName;		//ZIP 파일이 저장될 위치 및 파일 명
		byte[] buf = new byte[4096];
		try {
		    ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
		    files = filePath + File.separator + files;
		    FileInputStream in = new FileInputStream(files);
		    Path p = Paths.get(files);
		    fileName = p.getFileName().toString();
		            
		    ZipEntry ze = new ZipEntry(fileName);
		    out.putNextEntry(ze);
		      
		    int len;
		    while ((len = in.read(buf)) > 0) {
		        out.write(buf, 0, len);
		    }
		      
		    out.closeEntry();
		    in.close();
		          
		    out.close();
		} catch (IOException e) {
		    e.printStackTrace();
		}
		
		model.addAttribute("fileUploadPath", filePath);           // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);     // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);          // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	/**
	 * 커스텀 패키지 일괃 파일 다운로드 Zip
	 * @param chkList
	 * @param principal
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/customPackage/batchDownload")
	public View BatchDownload(@RequestParam int chkList[], Principal principal, Model model) {
		String filePath = this.filePath + File.separator + "releaseNotes";
		
		String files[] = customPackageService.BatchDownload(chkList);
		String changeFileName =  "CustomPackage-" + principal.getName() + "-" + customPackageService.nowDate() +".zip"; 	// 바뀌는 파일 명
		
		String zipFileName  = filePath + File.separator + "CustomPackageHistory"+ File.separator + changeFileName;	//ZIP 파일이 저장될 경로 및 파일 명
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
		
		model.addAttribute("fileUploadPath", filePath + File.separator + "CustomPackageHistory");					// 파일 경로
		model.addAttribute("filePhysicalName", "/"+changeFileName);		// 파일 이름
		model.addAttribute("fileLogicalName", "CustomPackage.zip");		// 출력할 파일 이름
	
		return new FileDownloadView();
	}
}