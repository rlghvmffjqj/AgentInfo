package com.secuve.agentInfo.controller;

import java.security.Principal;
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
}
