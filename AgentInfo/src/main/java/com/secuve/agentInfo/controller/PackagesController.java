package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.PackagesService;
import com.secuve.agentInfo.vo.Packages;

@Controller
public class PackagesController {
	
	@Autowired PackagesService packagesService;
	@Autowired Packages packages;

	@GetMapping(value = "/packages/list")
	public String PackagesList() {
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
}
