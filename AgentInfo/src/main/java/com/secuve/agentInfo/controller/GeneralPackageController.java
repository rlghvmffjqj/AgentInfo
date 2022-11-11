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
import com.secuve.agentInfo.service.GeneralPackageService;
import com.secuve.agentInfo.vo.GeneralPackage;

@Controller
public class GeneralPackageController {
	@Autowired GeneralPackageService generalPackageService;
	@Autowired CategoryService categoryService;
	
	/**
	 * 일반 패키지 이동
	 * @return
	 */
	@GetMapping(value = "/generalPackage/List")
	public String GeneralPackageList(Model model) {
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> osType = categoryService.getCategoryValue("osType");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("osType", osType);
		model.addAttribute("agentVer", agentVer);
		return "generalPackage/GeneralPackageList";
	}
	
	/**
	 * 일반 패키지 테이블 조회
	 * @param search
	 * @return
	 */
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
	
	/**
	 * 일반 패키지 추가 Modal
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/generalPackage/insertView")
	public String InsertGeneralPackageView(Model model) {
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> osType = categoryService.getCategoryValue("osType");
		
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("osType", osType);
		model.addAttribute("viewType","insert");
		return "/generalPackage/GeneralPackageView";
	}
	
	/**
	 * 일반 패키지 수정 Modal
	 * @param model
	 * @param generalPackageKeyNum
	 * @return
	 */
	@PostMapping(value = "/generalPackage/updateView")
	public String UpdateGeneralPackageView(Model model, int generalPackageKeyNum) {
		GeneralPackage generalPackage = generalPackageService.getGeneralPackageOne(generalPackageKeyNum);
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> osType = categoryService.getCategoryValue("osType");
		
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("osType", osType);
		model.addAttribute("viewType","update").addAttribute("generalPackage", generalPackage);
		return "/generalPackage/GeneralPackageView";
	}
	
	/**
	 * 일반 패키지 추가
	 * @param generalPackage
	 * @param releaseNotesView
	 * @param principal
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
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
	
	/**
	 * 일반 패키지 수정
	 * @param generalPackage
	 * @param releaseNotesView
	 * @param principal
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
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
	
	/**
	 * 일반 패키지 삭제
	 * @param chkList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/generalPackage/delete")
	public String DeleteGeneralPackage(@RequestParam int[] chkList) {
		return generalPackageService.deleteGeneralPackage(chkList);
	}
	
	/**
	 * 파일 저장 경로(application.properties 설정 정보)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	/**
	 * 일반 패키지 단일 다운로드
	 * @param fileName
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@GetMapping(value = "/generalPackage/fileDownload")
	public View FileDownload(@RequestParam String fileName, Principal principal, Model model) throws Exception {
		String filePath = this.filePath + File.separator + "releaseNotes";
		String files = fileName;
		String changeFileName =  fileName + "-" + principal.getName() + "-" + generalPackageService.nowDate()  + ".zip"; 
		
		String zipFileName  = filePath + File.separator + "GeneralPackageHistory"+ File.separator + changeFileName;		//ZIP 파일이 저장될 위치 및 파일 명
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
		
		
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	/**
	 * 일반 패키지 일괄 다운로드
	 * @param chkList
	 * @param principal
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/generalPackage/batchDownload")
	public View BatchDownload(@RequestParam int chkList[], Principal principal, Model model) {
		String filePath = this.filePath + File.separator + "releaseNotes";
		String files[] = generalPackageService.BatchDownload(chkList);
		String changeFileName =  "GeneralPackage-" + principal.getName() + "-" + generalPackageService.nowDate() + ".zip"; 
		
		String zipFileName  = filePath + File.separator + "GeneralPackageHistory"+ File.separator + changeFileName;		//ZIP 파일이 저장될 경로 및 파일 명
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
		
		model.addAttribute("fileUploadPath", filePath + File.separator + "GeneralPackageHistory");			// 파일 경로
		model.addAttribute("filePhysicalName", "/"+changeFileName);											// 파일 이름
		model.addAttribute("fileLogicalName", "GeneralPackage.zip");										// 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	/**
	 * 파일 존재 유무 덮어쓰기에 사용
	 * @param releaseNotesView
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/generalPackage/existenceConfirmation")
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
}