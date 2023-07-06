package com.secuve.agentInfo.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
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
		license.setLicenseType("(구)");
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
		if(license.getCustomerNameSelf().length() > 0)
			license.setCustomerNameView(license.getCustomerNameSelf());
		if(license.getBusinessNameSelf().length() > 0)
			license.setBusinessNameView(license.getBusinessNameSelf());
		if(license.getLicenseType().equals("(구)")) 
			license.setCustomerNameView(license.getCustomerNameOldView());
			
		model.addAttribute("license", license);
		model.addAttribute("viewType","issued");
		return "/license5/LicenseIssuanceConfirm";
	}
	
	@PostMapping(value = "/license5/licenseUpdateConfirm")
	public String licenseUpdateConfirm(License5 license, Model model) {
		if(license.getCustomerNameSelf().length() > 0)
			license.setCustomerNameView(license.getCustomerNameSelf());
		if(license.getBusinessNameSelf().length() > 0)
			license.setBusinessNameView(license.getBusinessNameSelf());
		if(license.getLicenseType().equals("(구)")) 
			license.setCustomerNameView(license.getCustomerNameOldView());
		
		model.addAttribute("license", license);
		model.addAttribute("viewType","update");
		return "/license5/LicenseIssuanceConfirm";
	}
	
	@PostMapping(value = "/license5/issuedBackView")
	public String issuedBackView(License5 license, Model model) {
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
		license.setAixCount(license.getAixCountView());
		license.setHpuxCount(license.getHpuxCountView());
		license.setSolarisCount(license.getSolarisCountView());
		license.setLinuxCount(license.getLinuxCountView());
		license.setWindowsCount(license.getWindowsCountView());
		license.setManagerOsType(license.getManagerOsTypeView());
		license.setManagerDbmsType(license.getManagerDbmsTypeView());
		license.setCountry(license.getCountryView());
		license.setProductVersion(license.getProductVersionView());
		license.setLicenseFilePath(license.getLicenseFilePathView());
		license.setRequester(license.getRequesterView());
		license.setSerialNumber(license.getSerialNumberView());
		
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryBusinessValue(license.getCustomerName());
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("license", license).addAttribute("viewType", "issuedback");
		
		return "/license5/LicenseView";
	}
	
	@PostMapping(value = "/license5/updateBackView")
	public String updateBackView(License5 license, Model model) {
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
		license.setAixCount(license.getAixCountView());
		license.setHpuxCount(license.getHpuxCountView());
		license.setSolarisCount(license.getSolarisCountView());
		license.setLinuxCount(license.getLinuxCountView());
		license.setWindowsCount(license.getWindowsCountView());
		license.setManagerOsType(license.getManagerOsTypeView());
		license.setManagerDbmsType(license.getManagerDbmsTypeView());
		license.setCountry(license.getCountryView());
		license.setProductVersion(license.getProductVersionView());
		license.setLicenseFilePath(license.getLicenseFilePathView());
		license.setRequester(license.getRequesterView());
		license.setSerialNumber(license.getSerialNumberView());
		
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryBusinessValue(license.getCustomerName());
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("license", license).addAttribute("viewType", "updateback");
		
		return "/license5/LicenseView";
	}
	
	@GetMapping(value = "/license5/fileDownload")
	public ResponseEntity<?> fileDownload(String licenseFilePath, String licenseType) {
		return license5Service.fileDownload(licenseFilePath, licenseType);
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
		List<String> businessName = categoryService.getCategoryBusinessValue(license.getCustomerName());
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("viewType", "update").addAttribute("license", license);
		return "/license5/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/licenseXmlImport")
	public Map<String, Object> licenseXmlImport(MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		List<MultipartFile> fileList = request.getFiles("licenseXml");
		
		return license5Service.licenseXmlImport(fileList, principal);
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/existenceCheckInsert")
	public List<String> existenceCheckInsert(License5 license, Principal principal) throws IllegalStateException, IOException {
		
		return license5Service.existenceCheckInsert(license);
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/existenceCheckUpdate")
	public List<String> existenceCheckUpdate(License5 license, Principal principal) throws IllegalStateException, IOException {
		license.setSerialNumber(license5Service.getLicenseOne(license.getLicenseKeyNum()).getSerialNumber());
		return license5Service.existenceCheckUpdate(license);
	}
	
	@GetMapping("/license5/license5SingleDownLoad")
	public ResponseEntity<Resource> singleDownLoad(@RequestParam int[] licenseKeyNum) {
	    List<String> serialNumber = license5Service.getSeriaNumber(licenseKeyNum);
	    return license5Service.singleDownLoad(serialNumber);
	}
	
	@GetMapping("/license5/license5MultiDownLoad")
	public ResponseEntity<Resource> multiDownLoad(@RequestParam int[] licenseKeyNum) throws IOException {
	    List<String> serialNumber = license5Service.getSeriaNumber(licenseKeyNum);
	    return license5Service.multiDownLoad(serialNumber);
	}
	
	@ResponseBody
	@PostMapping(value = "/license5/license5DownLoadCheck")
	public String downLoadCheck(@RequestParam int[] chkList) {
		return license5Service.downLoadCheck(chkList);
	}

}
