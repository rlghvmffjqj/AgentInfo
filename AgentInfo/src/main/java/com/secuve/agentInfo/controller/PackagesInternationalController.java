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
import com.secuve.agentInfo.service.PackagesInternationalService;
import com.secuve.agentInfo.service.SendPackageService;
import com.secuve.agentInfo.vo.PackagesInternational;
import com.secuve.agentInfo.vo.SendPackage;

@Controller
public class PackagesInternationalController {
	@Autowired PackagesInternationalService packagesInternationalService;
	@Autowired CategoryService categoryService;
	@Autowired SendPackageService sendPackageService;
	@Autowired FavoritePageService favoritePageService;
	

	/**
	 * 패키지 리스트 이동
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/packagesInternational/list")
	public String PackagesInternationalList(Model model, Principal principal, HttpServletRequest req) {
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

		return "packagesInternational/PackagesInternationalList";
	}

	/**
	 * 패키지 데이터 조회
	 * 
	 * @param search
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational")
	public Map<String, Object> Package(PackagesInternational search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<PackagesInternational> list = new ArrayList<>(packagesInternationalService.getPackagesInternationalList(search));

		int totalCount = packagesInternationalService.getPackagesInternationalListCount(search);
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
	@PostMapping(value = "/packagesInternational/delete")
	public String PackagesInternationalDelete(@RequestParam int[] chkList, Principal principal) {
		return packagesInternationalService.delPackagesInternational(chkList, principal);
	}

	/**
	 * 패키지 추가 모달
	 * 
	 * @param model
	 * @param packagesInternational
	 * @return
	 */
	@PostMapping(value = "/packagesInternational/insertView")
	public String InsertPackagesInternationalView(Model model, PackagesInternational packagesInternational) {
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
		model.addAttribute("viewType", "insert").addAttribute("packagesInternational", packagesInternational);
		return "/packagesInternational/PackagesInternationalView";
	}

	/**
	 * 패키지 추가
	 * 
	 * @param packagesInternational
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/insert")
	public Map InsertPackagesInternational(PackagesInternational packagesInternational, Principal principal) {
		packagesInternational.setPackagesInternationalRegistrant(principal.getName());
		packagesInternational.setPackagesInternationalRegistrationDate(packagesInternationalService.nowDate());

		Map map = new HashMap();
		String result = packagesInternationalService.insertPackagesInternational(packagesInternational, principal);
		map.put("packagesInternationalKeyNum", packagesInternational.getPackagesInternationalKeyNum());
		map.put("result", result);
		return map;
	}

	/**
	 * 패키지 업데이트 모달
	 * 
	 * @param model
	 * @param packagesInternationalKeyNum
	 * @return
	 */
	@PostMapping(value = "/packagesInternational/updateView")
	public String UpdatePackagesInternationalView(Model model, int packagesInternationalKeyNum) {
		PackagesInternational packagesInternational = packagesInternationalService.getPackagesInternationalOne(packagesInternationalKeyNum);
		SendPackage sendPackage = sendPackageService.getPackageOne(packagesInternationalKeyNum);

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
		List<String> businessName = categoryService.getCategoryBusinessValue(packagesInternational.getCustomerName());

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
		model.addAttribute("viewType", "update").addAttribute("packagesInternational", packagesInternational);
		return "/packagesInternational/PackagesInternationalView";
	}

	/**
	 * 패키지 업데이트
	 * 
	 * @param packagesInternational
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/update")
	public Map<String, String> UpdatePackagesInternational(PackagesInternational packagesInternational, Principal principal) {
		packagesInternational.setPackagesInternationalModifier(principal.getName());
		packagesInternational.setPackagesInternationalModifiedDate(packagesInternationalService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = packagesInternationalService.updatePackagesInternational(packagesInternational, principal);
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
	@PostMapping(value = "/packagesInternational/import")
	public String Import(HttpServletRequest request, PackagesInternational packagesInternational, Principal principal,
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
				result = packagesInternationalService.importPackagesInternationalCSV(mfile, principal);
			} else if (fileext.equalsIgnoreCase("xlsx") == true) {
				if (packagesInternational.getExcelImportYear().equals("2019년"))
					result = packagesInternationalService.importPackagesInternationalXlxs2019(mfile, principal);
				if (packagesInternational.getExcelImportYear().equals("2021년"))
					result = packagesInternationalService.importPackagesInternationalXlxs2021(mfile, principal);
				if (packagesInternational.getExcelImportYear().equals("2022년"))
					result = packagesInternationalService.importPackagesInternationalXlxs2022(mfile, principal);
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
	@PostMapping(value = "/packagesInternational/importView")
	public String UpdatePackagesInternationalImport() {
		return "/packagesInternational/Import";
	}

	/**
	 * 엑셀 Export
	 * 
	 * @param packagesInternational
	 * @param columns
	 * @param headers
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@PostMapping(value = "/packagesInternational/export")
	public void exportServerList(@ModelAttribute PackagesInternational packagesInternational, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] columnList = {"categoryKeyNum","customerName", "businessName", "networkClassification", "requestDate", "deliveryData", "state", "managementServer", "generalCustom", "agentVer", "packageName", "manager", "osType", "osDetailVersion", "agentOS", "existingNew", "requestProductCategory", "deliveryMethod", "purchaseCategory", "note", "statusComment"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "Package Deployment Data - " + formatter.format(now) + ".csv";

		List list = packagesInternationalService.listAll(packagesInternational);

		if (packagesInternational.getDeliveryDateStart() != "" && packagesInternational.getDeliveryDateEnd() != "") {
			filename = packagesInternational.getDeliveryDateStart() + " - " + packagesInternational.getDeliveryDateEnd() + ".csv";
		}

		try {
			if (packagesInternational.getDeliveryDateStart() != "" && packagesInternational.getDeliveryDateEnd() == ""
					|| packagesInternational.getDeliveryDateStart() == "" && packagesInternational.getDeliveryDateEnd() != "") {
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
	 * @param packagesInternationalKeyNum
	 * @return
	 */
	@PostMapping(value = "/packagesInternational/copyView")
	public String CopyPackagesInternationalView(Model model, int packagesInternationalKeyNum) {
		PackagesInternational packagesInternational = packagesInternationalService.getPackagesInternationalOne(packagesInternationalKeyNum);

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
		List<String> businessName = categoryService.getCategoryBusinessValue(packagesInternational.getCustomerName());

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
		model.addAttribute("viewType", "copy").addAttribute("packagesInternational", packagesInternational);
		return "/packagesInternational/PackagesInternationalView";
	}

	/**
	 * 패키지 복사
	 * 
	 * @param packagesInternational
	 * @param principal
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/copy")
	public Map copyPackagesInternational(PackagesInternational packagesInternational, Principal principal) {
		packagesInternational.setPackagesInternationalRegistrant(principal.getName());
		packagesInternational.setPackagesInternationalRegistrationDate(packagesInternationalService.nowDate());
		
		String sendPackageRandomUrl = "";
		SendPackage sendPackage = sendPackageService.getPackageOne(packagesInternational.getPackagesInternationalKeyNum());
		try {
			sendPackageRandomUrl = sendPackage.getSendPackageRandomUrl();
		} catch (Exception e) {}

		Map map = new HashMap();
		String result = packagesInternationalService.copyPackagesInternational(packagesInternational, principal);
		map.put("packagesInternationalKeyNum", packagesInternational.getPackagesInternationalKeyNum());
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
	@PostMapping(value = "/packagesInternational/chart/managementServer")
	public List<Integer> chartManagementServer(String managementServerYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesInternationalService.getChartManagementServer(managementServerYear);
		return list;
	}

	/**
	 * 차트 OS종류별 Agent 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/chart/osType")
	public List<Integer> chartOsType(String osTypeYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesInternationalService.getOsType(osTypeYear);
		return list;
	}

	/**
	 * 차트 OS종류별 Agent 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/chart/requestProductCategory")
	public List<Integer> chartRequestProductCategory(String requestProductCategoryYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesInternationalService.getChartRequestProductCategory(requestProductCategoryYear);
		return list;
	}

	/**
	 * 차트 OS종류별 최다 배포 Agent버전(최근 3개월)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/chart/agentVer")
	public Map<String, List> chartAgentVer() {
		Map<String, List> map = new HashMap<String, List>();
		map = packagesInternationalService.getAgentVer();
		return map;
	}

	/**
	 * 월별 배포 현황(금년)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/chart/deliveryData")
	public List<Integer> chartDeliveryData(String deliveryDataYear) {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesInternationalService.getDeliveryData(deliveryDataYear);
		return list;
	}
	
	@ResponseBody
	@PostMapping(value = "/packagesInternational/chart/deliveryAvgData")
	public List<Integer> chartDeliveryAvgData() {
		List<Integer> list = new ArrayList<Integer>();
		list = packagesInternationalService.getDeliveryAvgData();
		return list;
	}

	/**
	 * 고객사별 패키지 배포 수량 TOP 7 (현재)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packagesInternational/chart/customerName")
	public Map<String, List> chartCustomerName(String customerNameYear) {
		Map<String, List> map = new HashMap<String, List>();
		map = packagesInternationalService.getCustomerName(customerNameYear);
		return map;
	}
	
	/**
	 * 상태 변경 Modal
	 * @return
	 */
	@PostMapping(value = "/packagesInternational/stateView")
	public String stateView() {
		return "/packagesInternational/StateView";
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
	@PostMapping(value = "/packagesInternational/stateChange")
	public Map<String, String> stateChange(@RequestParam int[] chkList, @RequestParam String statusComment, @RequestParam String stateView, Principal principal) {

		Map<String, String> map = new HashMap<String, String>();
		String result = packagesInternationalService.stateChange(chkList, statusComment, stateView, principal);
		if(stateView.equals("적용")) {
			packagesInternationalService.updateProduct(chkList, principal);
		}
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/packagesInternational/domesticMove")
	public String DomesticMove(@RequestParam int[] chkList, Principal principal) {
		return packagesInternationalService.domesticMove(chkList, principal);
	}
	
}