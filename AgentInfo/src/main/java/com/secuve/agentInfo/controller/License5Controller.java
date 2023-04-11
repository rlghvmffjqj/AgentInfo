package com.secuve.agentInfo.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.License5Service;
import com.secuve.agentInfo.vo.License5;

@Controller
public class License5Controller {
	@Autowired License5Service license5Service;
	@Autowired CategoryService categoryService;
	
	@GetMapping(value = "/license5/issuance")
	public String LicenseList(Model model) {
		List<String> customerName = license5Service.getSelectInput("customerName");
		List<String> businessName = license5Service.getSelectInput("businessName");
		List<String> additionalInformation = license5Service.getSelectInput("additionalInformation");
		List<String> productType = license5Service.getSelectInput("productType");
		List<String> macAddress = license5Service.getSelectInput("macAddress");
		List<String> managerOsType = license5Service.getSelectInput("managerOsType");
		List<String> managerDbmsType = license5Service.getSelectInput("managerDbmsType");
		List<String> productVersion = license5Service.getSelectInput("productVersion");
		List<String> licenseFilePath = license5Service.getSelectInput("licenseFilePath");
		List<String> serialNumber = license5Service.getSelectInput("serialNumber");
		List<String> country = license5Service.getSelectInput("country");
		List<String> requester = license5Service.getSelectInput("requester");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("additionalInformation", additionalInformation);
		model.addAttribute("productType", productType);
		model.addAttribute("macAddress", macAddress);
		model.addAttribute("managerOsType", managerOsType);
		model.addAttribute("managerDbmsType", managerDbmsType);
		model.addAttribute("productVersion", productVersion);
		model.addAttribute("licenseFilePath", licenseFilePath);
		model.addAttribute("serialNumber", serialNumber);
		model.addAttribute("country", country);
		model.addAttribute("requester", requester);
		return "/license5/LicenseList";
	}
	
	@ResponseBody
	@PostMapping(value = "/license5")
	public Map<String, Object> Licens(License5 search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<License5> list = new ArrayList<>(license5Service.getLicenseList(search));

		int totalCount = license5Service.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/license5/issuedView")
	public String InsertLicenseView(Integer licenseKeyNum, String viewType, Model model) {
		License5 license = license5Service.insertLicenseView(licenseKeyNum);
		List<String> customerName = categoryService.getCategoryValue("customerName");
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("license", license).addAttribute("viewType", viewType);
		
		return "/license5/LicenseView";
	}
	
	@PostMapping(value = "/license5/licenseXmlImportView")
	public String LicenseXmlImport() {
		return "/license5/LicenseXmlImport";
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/linuxIssued50")
	public Map<String, String> LinuxIssuedLicense50(License5 license, Principal principal) throws ParseException {
		license.setLicenseIssuanceRegistrant(principal.getName());
		license.setLicenseIssuanceRegistrationDate(license5Service.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = license5Service.linuxIssuedLicense50(license, principal);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/linuxUpdate50")
	public Map<String, String> LinuxUpdateLicense50(License5 license, Principal principal) throws ParseException {
		license.setLicenseIssuanceModifier(principal.getName());
		license.setLicenseIssuanceModifiedDate(license5Service.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = license5Service.linuxUpdateLicense50(license, principal);
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value = "/license5/licenseIssuanceConfirm")
	public String LicenseIssuanceConfirm(License5 license, Model model) {
		model.addAttribute("license", license);
		model.addAttribute("viewType","issued");
		return "/license5/LicenseIssuanceConfirm";
	}
	
	@PostMapping(value = "/license5/licenseUpdateConfirm")
	public String licenseUpdateConfirm(License5 license, Model model) {
		model.addAttribute("license", license);
		model.addAttribute("viewType","update");
		return "/license5/LicenseIssuanceConfirm";
	}
	
	@PostMapping(value = "/license5/issuedBackView")
	public String issuedBackView(License5 license, String viewType, Model model) {
		license.setCustomerName(license.getCustomerNameView());
		license.setBusinessName(license.getBusinessNameView());
		license.setAdditionalInformation(license.getAdditionalInformationView());
		license.setProductType(license.getProductTypeView());
		license.setMacAddress(license.getMacAddressView());
		license.setIssueDate(license.getIssueDateView());
		license.setExpirationDays(license.getExpirationDaysView());
		license.setIgriffinAgentCount(license.getIgriffinAgentCountView());
		license.setTos5AgentCount(license.getTos5AgentCountView());
		license.setTos2AgentCount(license.getTos2AgentCountView());
		license.setDbmsCount(license.getDbmsCountView());
		license.setNetworkCount(license.getNetworkCountView());
		license.setManagerOsType(license.getManagerOsTypeView());
		license.setManagerDbmsType(license.getManagerDbmsTypeView());
		license.setCountry(license.getCountryView());
		license.setProductVersion(license.getProductVersionView());
		license.setLicenseFilePath(license.getLicenseFilePathView());
		license.setRequester(license.getRequesterView());
		license.setSerialNumber(license.getSerialNumberView());
		
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", license.getCustomerName());
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("license", license).addAttribute("viewType", viewType);
		
		return "/license5/LicenseView";
	}
	
	@PostMapping(value = "/license5/updateBackView")
	public String updateBackView(License5 license, String viewType, Model model) {
		license.setCustomerName(license.getCustomerNameView());
		license.setBusinessName(license.getBusinessNameView());
		license.setAdditionalInformation(license.getAdditionalInformationView());
		license.setProductType(license.getProductTypeView());
		license.setMacAddress(license.getMacAddressView());
		license.setIssueDate(license.getIssueDateView());
		license.setExpirationDays(license.getExpirationDaysView());
		license.setIgriffinAgentCount(license.getIgriffinAgentCountView());
		license.setTos5AgentCount(license.getTos5AgentCountView());
		license.setTos2AgentCount(license.getTos2AgentCountView());
		license.setDbmsCount(license.getDbmsCountView());
		license.setNetworkCount(license.getNetworkCountView());
		license.setManagerOsType(license.getManagerOsTypeView());
		license.setManagerDbmsType(license.getManagerDbmsTypeView());
		license.setCountry(license.getCountryView());
		license.setProductVersion(license.getProductVersionView());
		license.setLicenseFilePath(license.getLicenseFilePathView());
		license.setRequester(license.getRequesterView());
		license.setSerialNumber(license.getSerialNumberView());
		
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", license.getCustomerName());
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("license", license).addAttribute("viewType", viewType);
		
		return "/license5/LicenseView";
	}
	
	@GetMapping(value = "/license5/fileDownload")
	public ResponseEntity<?> fileDownload(String licenseFilePath, Principal principal) {
		return license5Service.fileDownload(licenseFilePath, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/delete")
	public String LicenseDelete(@RequestParam int[] chkList, Principal principal) {
		return license5Service.delLicense(chkList, principal);
	}
	
	@PostMapping(value = "/license5/updateView")
	public String UpdateLicenseView(Model model, int licenseKeyNum) {
		License5 license = license5Service.getLicenseOne(licenseKeyNum);
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryValue("businessName", license.getCustomerName());
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("viewType", "update").addAttribute("license", license);
		return "/license5/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/licenseXmlImport")
	public Map<String, String> licenseXmlImport(License5 license, MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		license.setLicenseIssuanceRegistrant(principal.getName());
		license.setLicenseIssuanceRegistrationDate(license5Service.nowDate());
		
		List<MultipartFile> fileList = request.getFiles("licenseXml");
		
		Map<String, String> map = new HashMap<String, String>();
		int sucess = 1;
		for (MultipartFile xmlFile : fileList) {
			sucess *= license5Service.licenseXmlImport(license, xmlFile);
		}
		
		if(sucess > 0) 
			map.put("result", "OK");
		else
			map.put("result", "FALSE");
		return map;
	}
}
