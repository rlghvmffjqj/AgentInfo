package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.core.Util;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.SecuveOTPService;
import com.secuve.agentInfo.vo.SecuveOTP;

@Controller
public class SecuveOTPController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired SecuveOTPService secuveOTPService;
	
	@GetMapping(value = "/secuveOTP/issuance")
	public String LicenseList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "라이선스 관리 - SecuveOTP");
		
		return "/secuveOTP/LicenseList";
	}
	
	@ResponseBody
	@PostMapping(value = "/secuveOTP")
	public Map<String, Object> Licens(SecuveOTP search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<SecuveOTP> list = new ArrayList<>(secuveOTPService.getLicenseList(search));

		int totalCount = secuveOTPService.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/secuveOTP/issuedView")
	public String InsertLicenseView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/secuveOTP/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/secuveOTP/licenseIssuance")
	public String LicenseInsert(SecuveOTP license, Principal principal) {
		license.setSecuveOTPRegistrant(principal.getName());
		license.setSecuveOTPRegistrationDate(secuveOTPService.nowDate());
		return secuveOTPService.licenseInsert(license);
	}
	
	@ResponseBody
	@PostMapping(value = "/secuveOTP/delete")
	public String LicenseDelete(@RequestParam int[] chkList, Principal principal) {
		return secuveOTPService.delLicense(chkList, principal);
	}
	
	@PostMapping(value = "/secuveOTP/updateView")
	public String UpdateLicenseView(Model model, int secuveOTPKeyNum) {
		SecuveOTP license = secuveOTPService.getLicenseOne(secuveOTPKeyNum);
		
		model.addAttribute("viewType", "update").addAttribute("license", license);
		return "/secuveOTP/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/secuveOTP/licenseUpdate")
	public String SecuveOTPUpdate(SecuveOTP license, Principal principal) throws ParseException {
		license.setSecuveOTPModifier(principal.getName());
		license.setSecuveOTPModifiedDate(secuveOTPService.nowDate());

		return secuveOTPService.updateLicense(license, principal);
	}
	
	@PostMapping(value = "/secuveOTP/export")
	public void exportServerList(@ModelAttribute SecuveOTP license, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] columnList = {"secuveOTPCreated", "secuveOTPSite", "secuveOTPMac", "secuveOTPExpireym", "secuveOTPLicense", "secuveOTPBigo", "secuveOTPFilePath", "secuveOTPRequester"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "SecuveOTP Entire Data - " + formatter.format(now) + ".csv";

		List list = secuveOTPService.listAll(license);

		if (license.getSecuveOTPCreatedStart() != "" && license.getSecuveOTPCreatedEnd() != "") {
			filename = license.getSecuveOTPCreatedStart() + " - " + license.getSecuveOTPCreatedEnd() + ".csv";
		}

		try {
			if (license.getSecuveOTPCreatedStart() != "" && license.getSecuveOTPCreatedEnd() == ""
					|| license.getSecuveOTPCreatedStart() == "" && license.getSecuveOTPCreatedEnd() != "") {
				filename = "전달일자 범위 오류.csv";
				list = new ArrayList<Object>();
			}
			Util.exportExcelFile(response, filename, list, columnList, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
}
