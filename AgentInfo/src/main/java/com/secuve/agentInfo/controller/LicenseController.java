package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.service.LicenseService;
import com.secuve.agentInfo.vo.License;
import com.secuve.agentInfo.vo.LicenseSetting;

@Controller
public class LicenseController {
	@Autowired LicenseService licenseService;
	
	/**
	 * 라이센스 발급 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/license/issuance")
	public String LicenseList(Model model) {
		List<String> customerName = licenseService.getSelectInput("customerName");
		List<String> businessName = licenseService.getSelectInput("businessName");
		List<String> requester = licenseService.getSelectInput("requester");
		List<String> partners = licenseService.getSelectInput("partners");
		List<String> osVersion = licenseService.getSelectInput("osVersion");
		List<String> kernelVersion = licenseService.getSelectInput("kernelVersion");
		List<String> tosVersion = licenseService.getSelectInput("tosVersion");
		List<String> macUmlHostId = licenseService.getSelectInput("macUmlHostId");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("requester", requester);
		model.addAttribute("partners", partners);
		model.addAttribute("osVersion", osVersion);
		model.addAttribute("kernelVersion", kernelVersion);
		model.addAttribute("tosVersion", tosVersion);
		model.addAttribute("macUmlHostId", macUmlHostId);
		
		return "/license/LicenseList";
	}
	
	/**
	 * 라이센스 발급 테이블 정보 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license")
	public Map<String, Object> Licens(License search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<License> list = new ArrayList<>(licenseService.getLicenseList(search));

		int totalCount = licenseService.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 테이블 내 라이센스 발급 키 컬럼 버튼
	 * @param licenseKeyNum
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license/issueKey")
	public String IssueKey(int licenseKeyNum) {
		return licenseService.getLicenseIssueKey(licenseKeyNum);
	}
	
	/**
	 * 라이센스 발급 View
	 * @return
	 */
	@PostMapping(value = "/license/issuedView")
	public String InsertLicenseView(String licenseKeyNum, String viewType, Model model) {
		License license = licenseService.insertLicenseView(licenseKeyNum);
		model.addAttribute("license", license).addAttribute("viewType", viewType);
		return "/license/LicenseView";
	}
	
	/**
	 * 리눅스 라이센스 2.0 발급
	 * @param license
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license/linuxIssued20")
	public Map<String, String> LinuxIssuedLicense20(License license, Principal principal) {
		license.setLicenseRegistrant(principal.getName());
		license.setLicenseRegistrationDate(licenseService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = licenseService.linuxIssuedLicense20(license, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 리눅스 라이센스 5.0 발급
	 * @param license
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license/linuxIssued50")
	public Map<String, String> LinuxIssuedLicense50(License license, Principal principal) {
		license.setLicenseRegistrant(principal.getName());
		license.setLicenseRegistrationDate(licenseService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = licenseService.linuxIssuedLicense50(license, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 윈도우 라이센스 발급
	 * @param license
	 * @param principal
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/license/windowIssued")
	public String WindowIssuedLicense(License license, Principal principal, Model model, HttpServletRequest request) {
		license.setLicenseRegistrant(principal.getName());
		license.setLicenseRegistrationDate(licenseService.nowDate());

		int licenseKeyNum = licenseService.windowIssuedLicense(license, principal, request);
		model.addAttribute("licenseKeyNum", licenseKeyNum).addAttribute("viewType", license.getViewType());
		return "/license/LicenseWindowView";
	}
	
	/**
	 * 라인센스 삭제
	 * @param chkList
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license/delete")
	public String LicenseDelete(@RequestParam int[] chkList, Principal principal) {
		return licenseService.delLicense(chkList, principal);
	}
	
	/**
	 * 윈도우 라이센스 발급 키 저장
	 * @param licenseIssueKey
	 * @param licenseKeyNum
	 * @param licenseUidLogKeyNum
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license/saveLicenseKey")
	public Map<String,String> SaveLicenseKey(String licenseIssueKey, int licenseKeyNum, Principal principal) {
		Map<String,String> map = new HashMap<String,String>();
		String result = licenseService.saveLicenseKey(licenseIssueKey, licenseKeyNum, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 닫기 버튼 클릭
	 * @param licenseKeyNum
	 */
	@ResponseBody
	@PostMapping(value = "/license/licensCancel")
	public void LicensCancel(int licenseKeyNum) {
		licenseService.licensCancel(licenseKeyNum);
	}
	
	/**
	 * 텍스트 제목 Modal
	 * @param chkList
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/license/txtTitle")
	public String TxtTitle(@RequestParam int[] chkList, Model model) {
		model.addAttribute("chkList", chkList);
		return "/license/TxtTitle";
	}
	
	/**
	 * 라이센스 발급 세팅 Modal
	 * @param model
	 * @return
	 */
	@PostMapping(value = "/license/setting")
	public String LicenseSetting(Principal principal, Model model) {
		String employeeId = principal.getName();
		LicenseSetting licenseSetting = licenseService.getlicenseSetting(employeeId);
		model.addAttribute("licenseSetting", licenseSetting);
		return "/license/LicenseSetting";
	}
	
	/**
	 * 텍스트 저장
	 * @param chkList
	 * @param fileName
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/license/txtSave")
	public String TxtSave(@RequestParam int[] chkList, String fileName, Model model) {
		return licenseService.txtSave(chkList, fileName);
	}
	
	@ResponseBody
	@PostMapping(value = "/license/routeChange")
	public String RouteChange(LicenseSetting licenseSetting, Principal principal, Model model) {
		licenseSetting.setEmployeeId(principal.getName());
		return licenseService.RouteChange(licenseSetting);
	}
	
	/**
	 * 파일 다운로드
	 * @param fileName
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@GetMapping(value = "/license/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\license";
		fileName += ".txt";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@PostMapping(value = "/license/copyView")
	public String CopyLicenseView(Model model, int licenseKeyNum) {
		License license = licenseService.getLicenseOne(licenseKeyNum);
		
		model.addAttribute("viewType", "copy").addAttribute("license", license);
		return "/license/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/license/routeCheck")
	public Map<String, String> RouteCheck(Principal principal) {
		String result = licenseService.getRoute("windowsLicenseRoute", principal.getName());
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		return map;
	}
	
}
