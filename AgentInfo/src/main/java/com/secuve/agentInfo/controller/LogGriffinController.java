package com.secuve.agentInfo.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.LogGriffinService;
import com.secuve.agentInfo.vo.License5;
import com.secuve.agentInfo.vo.LogGriffin;

@Controller
public class LogGriffinController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired LogGriffinService logGriffinService;

	@GetMapping(value = "/loggriffin/issuance")
	public String LicenseList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "라이선스 관리 - LogGRIFFIN");
		
		List<String> customerName = logGriffinService.getSelectInput("customerName");
		List<String> businessName = logGriffinService.getSelectInput("businessName");
		List<String> macAddress = logGriffinService.getSelectInput("macAddress");
		List<String> productName = logGriffinService.getSelectInput("productName");
		List<String> productVersion = logGriffinService.getSelectInput("productVersion");
		List<String> serialNumber = logGriffinService.getSelectInput("serialNumber");
		List<String> licenseFilePath = logGriffinService.getSelectInput("licenseFilePath");
		List<String> requester = logGriffinService.getSelectInput("requester");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("macAddress", macAddress);
		model.addAttribute("productName", productName);
		model.addAttribute("productVersion", productVersion);
		model.addAttribute("serialNumber", serialNumber);
		model.addAttribute("licenseFilePath", licenseFilePath);
		model.addAttribute("requester", requester);
		
		return "/loggriffin/LicenseList";
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin")
	public Map<String, Object> Licens(LogGriffin search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<LogGriffin> list = new ArrayList<>(logGriffinService.getLicenseList(search));

		int totalCount = logGriffinService.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/loggriffin/issuedView")
	public String InsertLicenseView(Integer logGriffinKeyNum,String viewType, Model model) {
		LogGriffin license = logGriffinService.insertLicenseView(logGriffinKeyNum);
		
		LocalDateTime serverTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        String formattedTime = serverTime.format(formatter);
		
		model.addAttribute("license", license).addAttribute("viewType", viewType);
		model.addAttribute("ServerTime",formattedTime);
		return "/loggriffin/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/existenceCheckInsert")
	public List<String> existenceCheckInsert(LogGriffin license, Principal principal) throws IllegalStateException, IOException {
		return logGriffinService.existenceCheckInsert(license);
	}
	
	@PostMapping(value = "/loggriffin/licenseIssuanceConfirm")
	public String LicenseIssuanceConfirm(LogGriffin license, Model model) {	
		model.addAttribute("license", license);
		model.addAttribute("viewType","issued");
		return "/loggriffin/LicenseIssuanceConfirm";
	}
	
	@PostMapping(value = "/loggriffin/issuedBackView")
	public String issuedBackView(LogGriffin license, Model model) {
		license.setCustomerName(license.getCustomerNameView());
		license.setBusinessName(license.getBusinessNameView());
		license.setAdditionalInformation(license.getAdditionalInformationView());
		license.setMacAddress(license.getMacAddressView());
		license.setProductName(license.getProductNameView());
		license.setProductVersion(license.getProductVersionView());
		
		license.setAgentCount(license.getAgentCountView());
		license.setAgentLisCount(license.getAgentLisCountView());
		license.setIssueDate(license.getIssueDateView());
		license.setExpirationDays(license.getExpirationDaysView());
		license.setLicenseFilePath(license.getLicenseFilePathView());
		license.setRequester(license.getRequesterView());
		license.setSerialNumber(license.getSerialNumberView());
		
		LocalDateTime serverTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        String formattedTime = serverTime.format(formatter);
		
		model.addAttribute("ServerTime",formattedTime);
		model.addAttribute("license", license).addAttribute("viewType", "issuedback");
		
		return "/loggriffin/LicenseView";
	}
	
	@PostMapping(value = "/loggriffin/updateBackView")
	public String updateBackView(LogGriffin license, Model model) {
		license.setCustomerName(license.getCustomerNameView());
		license.setBusinessName(license.getBusinessNameView());
		license.setAdditionalInformation(license.getAdditionalInformationView());
		license.setMacAddress(license.getMacAddressView());
		license.setProductName(license.getProductNameView());
		license.setProductVersion(license.getProductVersionView());
		
		license.setAgentCount(license.getAgentCountView());
		license.setAgentLisCount(license.getAgentLisCountView());
		license.setIssueDate(license.getIssueDateView());
		license.setExpirationDays(license.getExpirationDaysView());
		license.setLicenseFilePath(license.getLicenseFilePathView());
		license.setRequester(license.getRequesterView());
		license.setSerialNumber(license.getSerialNumberView());
		
		LocalDateTime serverTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        String formattedTime = serverTime.format(formatter);
		
		model.addAttribute("ServerTime",formattedTime);
		model.addAttribute("license", license).addAttribute("viewType", "updateback");
		
		return "/loggriffin/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/loggriffinUpdate")
	public Map<String, String> LoggriffinUpdate(LogGriffin license, Principal principal) throws ParseException {
		license.setLogGriffinModifier(principal.getName());
		license.setLogGriffinModifiedDate(logGriffinService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = logGriffinService.loggriffinUpdate(license, principal);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/loggriffinIssued")
	public Map<String, String> LoggriffinIssued(LogGriffin license, Principal principal) throws ParseException {
		license.setLogGriffinRegistrant(principal.getName());
		license.setLogGriffinRegistrationDate(logGriffinService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = logGriffinService.loggriffinIssued(license, principal);
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/loggriffin/updateView")
	public String UpdateLicenseView(Model model, int logGriffinKeyNum) {
		LogGriffin license = logGriffinService.getLicenseOne(logGriffinKeyNum);
		
		LocalDateTime serverTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
        String formattedTime = serverTime.format(formatter);
		
		model.addAttribute("ServerTime",formattedTime);
		model.addAttribute("viewType", "update").addAttribute("license", license);
		return "/loggriffin/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/existenceCheckUpdate")
	public List<String> existenceCheckUpdate(LogGriffin license, Principal principal) throws IllegalStateException, IOException {
		license.setSerialNumber(logGriffinService.getLicenseOne(license.getLogGriffinKeyNum()).getSerialNumber());
		return logGriffinService.existenceCheckUpdate(license);
	}
	
	@PostMapping(value = "/loggriffin/licenseUpdateConfirm")
	public String licenseUpdateConfirm(LogGriffin license, Model model) {
		model.addAttribute("license", license);
		model.addAttribute("viewType","update");
		return "/loggriffin/LicenseIssuanceConfirm";
	}
}
