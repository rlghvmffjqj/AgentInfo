package com.secuve.agentInfo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.core.Util;
import com.secuve.agentInfo.service.CategoryService;
import com.secuve.agentInfo.service.PackagesService;
import com.secuve.agentInfo.vo.Packages;

@Controller
public class PackagesController {
	
	@Autowired PackagesService packagesService;
	@Autowired CategoryService caegoryService;

	/**
	 * 패키지 리스트 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/packages/list")
	public String PackagesList( Model model) {
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		List<String> agentVer = caegoryService.getCategoryValue("agentVer");
		List<String> agentOS = caegoryService.getCategoryValue("agentOS");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		
		return "packages/PackagesList";
	}
	
	/**
	 * 패키지 데이터 조회
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages")
	public Map<String, Object> Package(Packages search) {
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
	public String PackagesDelete(@RequestParam int[] chkList, Principal principal) {
		return packagesService.delPackages(chkList, principal);
	}
	
	/**
	 * 패키지 추가 모달
	 * @param model
	 * @param packages
	 * @return
	 */
	@PostMapping(value = "/packages/insertView")
	public String InsertPackagesView(Model model, Packages packages) {
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		List<String> agentVer = caegoryService.getCategoryValue("agentVer");
		List<String> agentOS = caegoryService.getCategoryValue("agentOS");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("viewType","insert").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}
	
	/**
	 * 패키지 추가
	 * @param packages
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/insert")
	public Map<String,String> InsertPackages(Packages packages, Principal principal) {
		packages.setPackagesRegistrant(principal.getName());
		packages.setPackagesRegistrationDate(packagesService.nowDate());

		Map<String,String> map = new HashMap<String,String>();
		String result = packagesService.insertPackages(packages, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 패키지 업데이트 모달
	 * @param model
	 * @param packagesKeyNum
	 * @return
	 */
	@PostMapping(value ="/packages/updateView")
	public String UpdatePackagesView(Model model, int packagesKeyNum) {
		Packages packages = packagesService.getPackagesOne(packagesKeyNum);
		
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		List<String> agentVer = caegoryService.getCategoryValue("agentVer");
		List<String> agentOS = caegoryService.getCategoryValue("agentOS");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("viewType","update").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}
	
	/**
	 * 패키지 업데이트
	 * @param packages
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/update")
	public Map<String,String> UpdateEmployee(Packages packages, Principal principal) {
		packages.setPackagesModifier(principal.getName());
		packages.setPackagesModifiedDate(packagesService.nowDate());
		
		Map<String,String> map = new HashMap<String,String>();
		String result = packagesService.updatePackages(packages, principal);
		map.put("result", result);
		return map;
	}
	
	/**
	 * Excel Import
	 * @param request
	 * @param principal
	 * @param mfile
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value = "/packages/import")
	public String Import(
			HttpServletRequest request,
			Packages packages,
			Principal principal,
			@RequestParam("file") MultipartFile mfile) throws Exception {
		String result = "FALSE";
		
		if (mfile.isEmpty()) {
			System.out.println("파일이 존재 하지 않습니다.");
		}
		
		BufferedReader rd = null;
		try {
			String filename = mfile.getOriginalFilename();
			String fileext = FilenameUtils.getExtension(filename);
			if (fileext.equalsIgnoreCase("csv") == true ) {
				result = packagesService.importPackagesCSV(mfile, principal);
			} else if(fileext.equalsIgnoreCase("xlsx") == true) {
				if(packages.getExcelImportYear().equals("2016년"))
					result = packagesService.importPackagesXlxs2019(mfile, principal);
				if(packages.getExcelImportYear().equals("2021년"))
					result = packagesService.importPackagesXlxs2021(mfile, principal);
				if(packages.getExcelImportYear().equals("2022년"))
					result = packagesService.importPackagesXlxs2022(mfile, principal);
			}

		} catch (IOException e) {
			System.out.println("에러 : " + e);

		} finally {
			IOUtils.closeQuietly(rd);
		}
		
		return result;
	}
	
	@PostMapping(value ="/packages/importView")
	public String UpdatePackagesImport() {
		return "/packages/Import";
	}
	
	
	/**
	 * 엑셀 Export
	 * @param packages
	 * @param columns
	 * @param headers
	 * @param request
	 * @param response
	 * @throws Exception
	 */
    @PostMapping(value="/packages/export")
	public void exportServerList(
			@ModelAttribute Packages packages,
			@RequestParam String[] columns,
			@RequestParam String[] headers,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String info1 = "";
		String result = "";
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "Package All Data - " + formatter.format(now) + ".csv";

		List list = packagesService.listAll(packages);
		
		if(packages.getDeliveryDataStart() != "" && packages.getDeliveryDataEnd() != "") {
			filename = packages.getDeliveryDataStart() + " - " + packages.getDeliveryDataEnd() + ".csv";
		}

		try {
			if(packages.getDeliveryDataStart() != "" && packages.getDeliveryDataEnd() == "" || packages.getDeliveryDataStart() == "" && packages.getDeliveryDataEnd() != "") {
				filename = "전달일자 범위 오류.csv";
				list = new ArrayList<Object>();
			}
			info1 = filename;
			Util.exportExcelFile(response, filename, list, columns, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}

	}
    
    /**
     * 패키지 한 행 복사 모달
     * @param model
     * @param packagesKeyNum
     * @return
     */
    @PostMapping(value ="/packages/copyView")
	public String CopyPackagesView(Model model, int packagesKeyNum) {
		Packages packages = packagesService.getPackagesOne(packagesKeyNum);
		
		List<String> existingNew = caegoryService.getCategoryValue("existingNew");
		List<String> managementServer = caegoryService.getCategoryValue("managementServer");
		List<String> generalCustom = caegoryService.getCategoryValue("generalCustom");
		List<String> osType = caegoryService.getCategoryValue("osType");
		List<String> requestProductCategory = caegoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = caegoryService.getCategoryValue("deliveryMethod");
		List<String> agentVer = caegoryService.getCategoryValue("agentVer");
		List<String> agentOS = caegoryService.getCategoryValue("agentOS");
		
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("viewType","copy").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}
    
    /**
     * 패키지 복사
     * @param packages
     * @param principal
     * @return
     */
    @ResponseBody
	@PostMapping(value = "/packages/copy")
	public Map<String,String> copyPackages(Packages packages, Principal principal) {
		packages.setPackagesRegistrant(principal.getName());
		packages.setPackagesRegistrationDate(packagesService.nowDate());

		Map<String,String> map = new HashMap<String,String>();
		String result = packagesService.copyPackages(packages, principal);
		map.put("result", result);
		return map;
	}
    
    
}
