package com.secuve.agentInfo.controller;

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
	
	private static final String[] CATEGORY_KEYS = {
	        "existingNew", "managementServer", "generalCustom", "osType", 
	        "requestProductCategory", "deliveryMethod", "purchaseCategory", 
	        "agentVer", "agentOS", "customerName"
	    };
	

	/**
	 * 패키지 리스트 이동
	 * 
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/packages/list")
    public String packagesList(Model model, Principal principal, HttpServletRequest req) {
        favoritePageService.insertFavoritePage(principal, req, "패키지 배포 관리");

        for (String key : CATEGORY_KEYS) {
            model.addAttribute(key, categoryService.getCategoryValue(key));
        }

        model.addAttribute("businessName", categoryService.getCategoryBusinessNameList());
        model.addAttribute("customerId", categoryService.getCategoryKeyNum());

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
    public Map<String, Object> getPackages(Packages search) {
        Map<String, Object> response = new HashMap<>();
        List<Packages> packagesList = packagesService.getPackagesList(search);
        int totalCount = packagesService.getPackagesListCount(search);

        response.put("page", search.getPage());
        response.put("total", Math.ceil((float) totalCount / search.getRows()));
        response.put("records", totalCount);
        response.put("rows", packagesList);

        return response;
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
		for (String key : CATEGORY_KEYS) {
            model.addAttribute(key, categoryService.getCategoryValue(key));
        }
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

		Map<String, Object> map = new HashMap<>();
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
	public String UpdatePackagesView(Model model, int packagesKeyNum, String viewType) {
		Packages packages = packagesService.getPackagesOne(packagesKeyNum);
		SendPackage sendPackage = sendPackageService.getPackageOne(packagesKeyNum);

		for (String key : CATEGORY_KEYS) {
            model.addAttribute(key, categoryService.getCategoryValue(key));
        }
		
		if(!"im".equals(viewType)) {
			viewType = "update";
		}
		model.addAttribute("businessName", categoryService.getCategoryBusinessValue(packages.getCustomerName()));
		model.addAttribute("sendPackage", sendPackage);
		model.addAttribute("viewType", viewType).addAttribute("packages", packages);
		
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
    public String importPackages(@RequestParam("file") MultipartFile mfile, Packages packages, Principal principal) {
        if (mfile.isEmpty()) {
            return "FALSE";
        }

        String filename = mfile.getOriginalFilename();
        String fileExt = FilenameUtils.getExtension(filename);

        try {
            if ("csv".equalsIgnoreCase(fileExt)) {
                return packagesService.importPackagesCSV(mfile, principal);
            } else if ("xlsx".equalsIgnoreCase(fileExt)) {
                return importExcelByYear(mfile, packages.getExcelImportYear(), principal);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "FALSE";
    }
	
	private String importExcelByYear(MultipartFile file, String year, Principal principal) throws IOException {
        switch (year) {
            case "2019년":
                return packagesService.importPackagesXlxs2019(file, principal);
            case "2021년":
                return packagesService.importPackagesXlxs2021(file, principal);
            case "2022년":
                return packagesService.importPackagesXlxs2022(file, principal);
            default:
                return "FALSE";
        }
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

		if (!packages.getDeliveryDateStart().isEmpty() && !packages.getDeliveryDateEnd().isEmpty()) {
	        filename = packages.getDeliveryDateStart() + " - " + packages.getDeliveryDateEnd() + ".csv";
	    }

	    try {
	        if ((!packages.getDeliveryDateStart().isEmpty() && packages.getDeliveryDateEnd().isEmpty())
	                || (packages.getDeliveryDateStart().isEmpty() && !packages.getDeliveryDateEnd().isEmpty())) {
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

		for (String key : CATEGORY_KEYS) {
            model.addAttribute(key, categoryService.getCategoryValue(key));
        }
		model.addAttribute("businessName", categoryService.getCategoryBusinessValue(packages.getCustomerName()));
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
	public Map<String, Object> copyPackages(Packages packages, Principal principal) {
		packages.setPackagesRegistrant(principal.getName());
		packages.setPackagesRegistrationDate(packagesService.nowDate());
		
		String sendPackageRandomUrl = "";
		SendPackage sendPackage = sendPackageService.getPackageOne(packages.getPackagesKeyNum());
		if (sendPackage != null) {
	        sendPackageRandomUrl = sendPackage.getSendPackageRandomUrl();
	    }

		Map<String, Object> map = new HashMap<>();
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
		return packagesService.getChartManagementServer(managementServerYear);
	}

	/**
	 * 차트 OS종류별 Agent 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/osType")
	public List<Integer> chartOsType(String osTypeYear) {
		return packagesService.getOsType(osTypeYear);
	}

	/**
	 * 차트 OS종류별 Agent 배포 현황
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/requestProductCategory")
	public List<Integer> chartRequestProductCategory(String requestProductCategoryYear) {
		return packagesService.getChartRequestProductCategory(requestProductCategoryYear);
	}

	/**
	 * 차트 OS종류별 최다 배포 Agent버전(최근 3개월)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/agentVer")
	public Map<String, List<?>> chartAgentVer() {
		return packagesService.getAgentVer();
	}

	/**
	 * 월별 배포 현황(금년)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/deliveryData")
	public List<Integer> chartDeliveryData(String deliveryDataYear) {
		return packagesService.getDeliveryData(deliveryDataYear);
	}
	
	@ResponseBody
	@PostMapping(value = "/packages/chart/deliveryAvgData")
	public List<Integer> chartDeliveryAvgData() {
		return packagesService.getDeliveryAvgData();
	}

	/**
	 * 고객사별 패키지 배포 수량 TOP 7 (현재)
	 * 
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/packages/chart/customerName")
	public Map<String, List<?>> chartCustomerName(String customerNameYear) {
		return packagesService.getCustomerName(customerNameYear);
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
		if ("적용".equals(stateView)) {
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
	
	@PostMapping(value = "/packages/historyView")
	public String HistoryView(Model model, int packagesKeyNum, String packageName) {
		model.addAttribute("packagesKeyNum", packagesKeyNum);
		model.addAttribute("packageName", packageName);
		return "/packages/HistoryView";
	}
	
}