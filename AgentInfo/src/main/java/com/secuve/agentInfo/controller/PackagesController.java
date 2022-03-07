package com.secuve.agentInfo.controller;

import java.security.Principal;
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
import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.PackagesService;
import com.secuve.agentInfo.vo.Packages;

@Controller
public class PackagesController {
	
	@Autowired PackagesService packagesService;
	@Autowired Packages packages;
	@Autowired CategoryService caegoryService;

	@GetMapping(value = "/packages/list")
	public String PackagesList( Model model) {
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		
		return "packages/PackagesList";
	}
	
	@ResponseBody
	@PostMapping(value = "/packages")
	public Map<String, Object> Package(@ModelAttribute("search") Packages search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Packages> list = new ArrayList<>(packagesService.getPackagesList(search));
		
		int totalCount = packagesService.getPackagesListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float)totalCount/search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/packages/delete")
	public String PackagesDelete(@RequestParam int[] chkList) {
		return packagesService.delPackages(chkList);
	}
	
	@PostMapping(value = "/packages/insertView")
	public String InsertPackagesView(Model model, Packages packages) {
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("viewType","insert").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}
	
	@ResponseBody
	@PostMapping(value = "/packages/insert")
	public Map<String,String> InsertPackages(Packages packages, Principal principal) {
		packages.setPackagesRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		packages.setPackagesRegistrationDate(formatter.format(now));

		Map<String,String> map = new HashMap<String,String>();
		String result = packagesService.insertPackages(packages);
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value ="/packages/updateView")
	public String UpdatePackagesView(Model model, int packagesKeyNum) {
		Packages packages = packagesService.getPackagesOne(packagesKeyNum);
		
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("viewType","update").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}
	
	@ResponseBody
	@PostMapping(value = "/packages/update")
	public Map<String,String> UpdateEmployee(Packages packages, Principal principal) {
		packages.setPackagesModifier(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		packages.setPackagesModifiedDate(formatter.format(now));
		
		Map<String,String> map = new HashMap<String,String>();
		String result = packagesService.updatePackages(packages);
		map.put("result", result);
		return map;
	}
	
	@PostMapping(value ="/packages/import")
	public String UpdatePackagesImport() {
		return "/packages/Import";
	}
	
	
    @PostMapping(value="/packages/export")
	public void exportServerList(
			@ModelAttribute Packages packages,
			@RequestParam String[] columns,
			@RequestParam String[] headers,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String info1 = "";
		String result = "";

		List list = packagesService.listAll(packages);

		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "ServerList-" + formatter + ".xls";

		try {
			info1 = filename;
			//Util.exportCsvFromObject(response, filename, list, columns, headers);
			Util.exportExcelFile(response, filename, list, columns, headers);
			result = "OK";

		} catch (Exception e) {
			result = "FAIL: Export failed.\n" + e.toString();
		}

	}
    
    
}
