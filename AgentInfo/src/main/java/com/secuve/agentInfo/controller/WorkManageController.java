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

import javax.servlet.http.HttpServletRequest;

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
}
