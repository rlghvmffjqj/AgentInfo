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
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.PackagesService;
import com.secuve.agentInfo.service.SendPackageService;
import com.secuve.agentInfo.vo.Packages;
import com.secuve.agentInfo.vo.SendPackage;

@Controller
public class PackagesController {
	@Autowired PackagesService packagesService;
	@Autowired CategoryService categoryService;
	@Autowired SendPackageService sendPackageService;
	@Autowired FavoritePageService favoritePageService;
	

	/**
	 * 패키지 리스트 이동
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/packages/list")
	public String PackagesList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "패키지 배포 관리");
		
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> categoryBusinessName = categoryService.getCategoryBusinessNameList();
		List<String> existingNew = categoryService.getCategoryValue("existingNew");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> generalCustom = categoryService.getCategoryValue("generalCustom");
		List<String> osType = categoryService.getCategoryValue("osType");
		List<String> requestProductCategory = categoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = categoryService.getCategoryValue("deliveryMethod");
		List<String> purchaseCategory = categoryService.getCategoryValue("purchaseCategory");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> agentOS = categoryService.getCategoryValue("agentOS");
		List<String> customerId = categoryService.getCategoryKeyNum();
		
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", categoryBusinessName);
		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("purchaseCategory", purchaseCategory);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("customerId", customerId);

		return "packages/PackagesList";
	}

	/**
	 * 패키지 데이터 조회
	 * 
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
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}

	/**
	 * 패키지 삭제
	 * @param chkList
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/delete")
	public String PackagesDelete(@RequestParam int[] chkList, Principal principal) {
		return packagesService.delPackages(chkList, principal);
	}

	/**
	 * 패키지 추가 모달
	 * 
	 * @param model
	 * @param packages
	 * @return
	 */
	@PostMapping(value = "/packages/insertView")
	public String InsertPackagesView(Model model, Packages packages) {
		List<String> existingNew = categoryService.getCategoryValue("existingNew");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> generalCustom = categoryService.getCategoryValue("generalCustom");
		List<String> osType = categoryService.getCategoryValue("osType");
		List<String> requestProductCategory = categoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = categoryService.getCategoryValue("deliveryMethod");
		List<String> purchaseCategory = categoryService.getCategoryValue("purchaseCategory");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> agentOS = categoryService.getCategoryValue("agentOS");
		List<String> customerName = categoryService.getCategoryValue("customerName");

		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("purchaseCategory", purchaseCategory);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("customerName", customerName);
		model.addAttribute("viewType", "insert").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}

	/**
	 * 패키지 추가
	 * 
	 * @param packages
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/insert")
	public Map InsertPackages(Packages packages, Principal principal) {
		packages.setPackagesRegistrant(principal.getName());
		packages.setPackagesRegistrationDate(packagesService.nowDate());

		Map map = new HashMap();
		String result = packagesService.insertPackages(packages, principal);
		map.put("packagesKeyNum", packages.getPackagesKeyNum());
		map.put("result", result);
		return map;
	}

	/**
	 * 패키지 업데이트 모달
	 * 
	 * @param model
	 * @param packagesKeyNum
	 * @return
	 */
	@PostMapping(value = "/packages/updateView")
	public String UpdatePackagesView(Model model, int packagesKeyNum) {
		Packages packages = packagesService.getPackagesOne(packagesKeyNum);
		SendPackage sendPackage = sendPackageService.getPackageOne(packagesKeyNum);

		List<String> existingNew = categoryService.getCategoryValue("existingNew");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> generalCustom = categoryService.getCategoryValue("generalCustom");
		List<String> osType = categoryService.getCategoryValue("osType");
		List<String> requestProductCategory = categoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = categoryService.getCategoryValue("deliveryMethod");
		List<String> purchaseCategory = categoryService.getCategoryValue("purchaseCategory");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> agentOS = categoryService.getCategoryValue("agentOS");
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryBusinessValue(packages.getCustomerName());

		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("purchaseCategory", purchaseCategory);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("sendPackage", sendPackage);
		model.addAttribute("viewType", "update").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}

	/**
	 * 패키지 업데이트
	 * 
	 * @param packages
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/update")
	public Map<String, String> UpdatePackages(Packages packages, Principal principal) {
		packages.setPackagesModifier(principal.getName());
		packages.setPackagesModifiedDate(packagesService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = packagesService.updatePackages(packages, principal);
		map.put("result", result);
		return map;
	}

	/**
	 * Excel Import
	 * 
	 * @param request
	 * @param principal
	 * @param mfile
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value = "/packages/import")
	public String Import(HttpServletRequest request, Packages packages, Principal principal,
			@RequestParam("file") MultipartFile mfile) throws Exception {
		String result = "FALSE";

		if (mfile.isEmpty()) {
			System.out.println("파일이 존재 하지 않습니다.");
		}

		BufferedReader rd = null;
		try {
			String filename = mfile.getOriginalFilename();
			String fileext = FilenameUtils.getExtension(filename);
			if (fileext.equalsIgnoreCase("csv") == true) {
				result = packagesService.importPackagesCSV(mfile, principal);
			} else if (fileext.equalsIgnoreCase("xlsx") == true) {
				if (packages.getExcelImportYear().equals("2019년"))
					result = packagesService.importPackagesXlxs2019(mfile, principal);
				if (packages.getExcelImportYear().equals("2021년"))
					result = packagesService.importPackagesXlxs2021(mfile, principal);
				if (packages.getExcelImportYear().equals("2022년"))
					result = packagesService.importPackagesXlxs2022(mfile, principal);
			}
		} catch (IOException e) {
			System.out.println("에러 : " + e);
		} finally {
			IOUtils.closeQuietly(rd);
		}

		return result;
	}

	/**
	 * Excel Import Model
	 * @return
	 */
	@PostMapping(value = "/packages/importView")
	public String UpdatePackagesImport() {
		return "/packages/Import";
	}

	/**
	 * 엑셀 Export
	 * 
	 * @param packages
	 * @param columns
	 * @param headers
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@PostMapping(value = "/packages/export")
	public void exportServerList(@ModelAttribute Packages packages, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] columnList = {"categoryKeyNum","customerName", "businessName", "networkClassification", "requestDate", "deliveryData", "state", "managementServer", "generalCustom", "agentVer", "packageName", "manager", "osType", "osDetailVersion", "agentOS", "existingNew", "requestProductCategory", "deliveryMethod", "purchaseCategory", "note", "statusComment"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "Package Deployment Data - " + formatter.format(now) + ".csv";

		List list = packagesService.listAll(packages);

		if (packages.getDeliveryDateStart() != "" && packages.getDeliveryDateEnd() != "") {
			filename = packages.getDeliveryDateStart() + " - " + packages.getDeliveryDateEnd() + ".csv";
		}

		try {
			if (packages.getDeliveryDateStart() != "" && packages.getDeliveryDateEnd() == ""
					|| packages.getDeliveryDateStart() == "" && packages.getDeliveryDateEnd() != "") {
				filename = "전달일자 범위 오류.csv";
				list = new ArrayList<Object>();
			}
			Util.exportExcelFile(response, filename, list, columnList, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}

	/**
	 * 패키지 한 행 복사 모달
	 * 
	 * @param model
	 * @param packagesKeyNum
	 * @return
	 */
	@PostMapping(value = "/packages/copyView")
	public String CopyPackagesView(Model model, int packagesKeyNum) {
		Packages packages = packagesService.getPackagesOne(packagesKeyNum);

		List<String> existingNew = categoryService.getCategoryValue("existingNew");
		List<String> managementServer = categoryService.getCategoryValue("managementServer");
		List<String> generalCustom = categoryService.getCategoryValue("generalCustom");
		List<String> osType = categoryService.getCategoryValue("osType");
		List<String> requestProductCategory = categoryService.getCategoryValue("requestProductCategory");
		List<String> deliveryMethod = categoryService.getCategoryValue("deliveryMethod");
		List<String> purchaseCategory = categoryService.getCategoryValue("purchaseCategory");
		List<String> agentVer = categoryService.getCategoryValue("agentVer");
		List<String> agentOS = categoryService.getCategoryValue("agentOS");
		List<String> customerName = categoryService.getCategoryValue("customerName");
		List<String> businessName = categoryService.getCategoryBusinessValue(packages.getCustomerName());

		model.addAttribute("existingNew", existingNew);
		model.addAttribute("managementServer", managementServer);
		model.addAttribute("generalCustom", generalCustom);
		model.addAttribute("osType", osType);
		model.addAttribute("requestProductCategory", requestProductCategory);
		model.addAttribute("deliveryMethod", deliveryMethod);
		model.addAttribute("purchaseCategory", purchaseCategory);
		model.addAttribute("agentVer", agentVer);
		model.addAttribute("agentOS", agentOS);
		model.addAttribute("customerName", customerName);
		model.addAttribute("businessName", businessName);
		model.addAttribute("viewType", "copy").addAttribute("packages", packages);
		return "/packages/PackagesView";
	}

	/**
	 * 패키지 복사
	 * 
	 * @param packages
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/copy")
	public Map copyPackages(Packages packages, Principal principal) {
		packages.setPackagesRegistrant(principal.getName());
		packages.setPackagesRegistrationDate(packagesService.nowDate());
		
		String sendPackageRandomUrl = "";
		SendPackage sendPackage = sendPackageService.getPackageOne(packages.getPackagesKeyNum());
		try {
			sendPackageRandomUrl = sendPackage.getSendPackageRandomUrl();
		} catch (Exception e) {}

		Map map = new HashMap();
		String result = packagesService.copyPackages(packages, principal);
		map.put("packagesKeyNum", packages.getPackagesKeyNum());
		map.put("sendPackageRandomUrl", sendPackageRandomUrl);
		map.put("result", result);
		return map;
	}

	/**
	 * 차트 패키지 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/managementServer")
	public List<Integer> chartManagementServer(String managementServerYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesService.getChartManagementServer(managementServerYear);
		return list;
	}

	/**
	 * 차트 OS종류별 Agent 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/osType")
	public List<Integer> chartOsType(String osTypeYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesService.getOsType(osTypeYear);
		return list;
	}

	/**
	 * 차트 OS종류별 Agent 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/requestProductCategory")
	public List<Integer> chartRequestProductCategory(String requestProductCategoryYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesService.getChartRequestProductCategory(requestProductCategoryYear);
		return list;
	}

	/**
	 * 차트 OS종류별 최다 배포 Agent버전(최근 3개월)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/agentVer")
	public Map<String, List> chartAgentVer() {
		Map<String, List> map = new HashMap<String, List>();
		map = packagesService.getAgentVer();
		return map;
	}

	/**
	 * 월별 배포 현황(금년)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/deliveryData")
	public List<Integer> chartDeliveryData(String deliveryDataYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesService.getDeliveryData(deliveryDataYear);
		return list;
	}
	
	@ResponseBody
	@PostMapping(value = "/packages/chart/deliveryAvgData")
	public List<Integer> chartDeliveryAvgData() {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesService.getDeliveryAvgData();
		return list;
	}

	/**
	 * 고객사별 패키지 배포 수량 TOP 7 (현재)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/customerName")
	public Map<String, List> chartCustomerName(String customerNameYear) {
		Map<String, List> map = new HashMap<String, List>();
		map = packagesService.getCustomerName(customerNameYear);
		return map;
	}
	
	/**
	 * 상태 변경 Modal
	 * @return
	 */
	@PostMapping(value = "/packages/stateView")
	public String stateView() {
		return "/packages/StateView";
	}
	
	/**
	 * 상태 변경
	 * @param chkList
	 * @param statusComment
	 * @param stateView
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/stateChange")
	public Map<String, String> stateChange(@RequestParam int[] chkList, @RequestParam String statusComment, @RequestParam String stateView, Principal principal) {

		Map<String, String> map = new HashMap<String, String>();
		String result = packagesService.stateChange(chkList, statusComment, stateView, principal);
		if(stateView.equals("적용")) {
			packagesService.updateProduct(chkList, principal);
		}
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/packages/overseasMove")
	public String OverseasMove(@RequestParam int[] chkList, Principal principal) {
		return packagesService.overseasMove(chkList, principal);
	}
	
}