package com.secuve.agentInfo.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.secuve.agentInfo.core.Util;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.LogGriffinService;
import com.secuve.agentInfo.service.MailSendService;
import com.secuve.agentInfo.vo.LogGriffin;
import com.secuve.agentInfo.vo.SendMailSetting;

@Controller
public class LogGriffinController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired LogGriffinService logGriffinService;
	@Autowired MailSendService mailSendService;

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
		license.setLicenseType("(일반)");
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
		if(license.getExpirationDaysView() == "" || license.getExpirationDaysView() == null) {
			license.setExpirationDaysView("무제한");
		}
		if(license.getAgentCountView() == "" || license.getAgentCountView() == null) {
			license.setAgentCountView("무제한");
		}
		if(license.getAgentLisCountView() == "" || license.getAgentLisCountView() == null) {
			license.setAgentLisCountView("무제한");
		}
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
		license.setWriteDate(license.getWriteDateView());
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
		license.setWriteDate(license.getWriteDateView());
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
	
	@GetMapping(value = "/loggriffin/fileDownload")
	public ResponseEntity<?> fileDownload(String licenseFilePath) throws UnsupportedEncodingException {
		return logGriffinService.fileDownload(licenseFilePath);
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
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/delete")
	public String LicenseDelete(@RequestParam int[] chkList, Principal principal) {
		return logGriffinService.delLicense(chkList, principal);
	}
	
	
	@PostMapping(value = "/loggriffin/export")
	public void exportServerList(@ModelAttribute LogGriffin license, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] columnList = {"licenseType", "customerName", "businessName", "macAddress", "productName", "productVersion", "agentCount", "agentLisCount", "writeDate", "issueDate", "expirationDays", "additionalInformation", "serialNumber", "licenseFilePath", "requester"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "LogGRIFFIN Entire Data - " + formatter.format(now) + ".csv";

		List list = logGriffinService.listAll(license);

		if (license.getIssueDateStart() != "" && license.getIssueDateEnd() != "") {
			filename = license.getIssueDateStart() + " - " + license.getIssueDateEnd() + ".csv";
		}

		try {
			if (license.getIssueDateStart() != "" && license.getIssueDateEnd() == ""
					|| license.getIssueDateStart() == "" && license.getIssueDateEnd() != "") {
				filename = "전달일자 범위 오류.csv";
				list = new ArrayList<Object>();
			}
			Util.exportExcelFile(response, filename, list, columnList, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/loggriffinDownLoadCheck")
	public String downLoadCheck(@RequestParam int[] chkList) {
		return logGriffinService.downLoadCheck(chkList);
	}
	
	@GetMapping("/loggriffin/loggriffinSingleDownLoad")
	public ResponseEntity<Resource> singleDownLoad(@RequestParam int[] logGriffinKeyNum) {
	    List<String> serialNumber = logGriffinService.getSeriaNumber(logGriffinKeyNum);
	    return logGriffinService.singleDownLoad(serialNumber);
	}
	
	@GetMapping("/loggriffin/loggriffinMultiDownLoad")
	public ResponseEntity<Resource> multiDownLoad(@RequestParam int[] logGriffinKeyNum) throws IOException {
	    List<String> serialNumber = logGriffinService.getSeriaNumber(logGriffinKeyNum);
	    return logGriffinService.multiDownLoad(serialNumber);
	}
	
	@PostMapping(value = "/loggriffin/licenseYmlImportView")
	public String LicenseYmlImport() {
		return "/loggriffin/LicenseYmlImport";
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/licenseYmlImport")
	public Map<String, Object> licenseYmlImport(MultipartHttpServletRequest  request, Principal principal) throws IllegalStateException, IOException {
		List<MultipartFile> fileList = request.getFiles("licenseYml");
		
		return logGriffinService.licenseYmlImport(fileList, principal);
	}
	
	@PostMapping(value = "/loggriffin/mailSetting")
	public String MailSetting(Model model) {
		SendMailSetting sendMailSetting = mailSendService.getTargetSetting("loggriffin");
		model.addAttribute(sendMailSetting);
		return "/mailSend/MailSetting";
	}
	
	@ResponseBody
	@PostMapping(value = "/loggriffin/individualMailSend")
	public String IndividualMailSend(int licenseKeyNum) {
		return logGriffinService.individualMailSend(licenseKeyNum);
	}
}
