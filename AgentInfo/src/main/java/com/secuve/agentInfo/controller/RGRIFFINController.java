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
import com.secuve.agentInfo.service.RGRIFFINService;
import com.secuve.agentInfo.vo.RGRIFFIN;

@Controller
public class RGRIFFINController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired RGRIFFINService rGRIFFINService;
	
	@GetMapping(value = "/rGRIFFIN/issuance")
	public String LicenseList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "라이선스 관리 - RGRIFFIN");
		
		return "/rGRIFFIN/LicenseList";
	}
	
	@ResponseBody
	@PostMapping(value = "/rGRIFFIN")
	public Map<String, Object> Licens(RGRIFFIN search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<RGRIFFIN> list = new ArrayList<>(rGRIFFINService.getLicenseList(search));

		int totalCount = rGRIFFINService.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/rGRIFFIN/issuedView")
	public String InsertLicenseView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/rGRIFFIN/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/rGRIFFIN/licenseIssuance")
	public String LicenseInsert(RGRIFFIN license, Principal principal) {
		license.setRGRIFFINRegistrant(principal.getName());
		license.setRGRIFFINRegistrationDate(rGRIFFINService.nowDate());
		return rGRIFFINService.licenseInsert(license);
	}
	
	@ResponseBody
	@PostMapping(value = "/rGRIFFIN/delete")
	public String LicenseDelete(@RequestParam int[] chkList, Principal principal) {
		return rGRIFFINService.delLicense(chkList, principal);
	}
	
	@PostMapping(value = "/rGRIFFIN/updateView")
	public String UpdateLicenseView(Model model, int rGRIFFINKeyNum) {
		RGRIFFIN license = rGRIFFINService.getLicenseOne(rGRIFFINKeyNum);
		
		model.addAttribute("viewType", "update").addAttribute("license", license);
		return "/rGRIFFIN/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/rGRIFFIN/licenseUpdate")
	public String RGRIFFINUpdate(RGRIFFIN license, Principal principal) throws ParseException {
		license.setRGRIFFINModifier(principal.getName());
		license.setRGRIFFINModifiedDate(rGRIFFINService.nowDate());

		return rGRIFFINService.updateLicense(license, principal);
	}
	
	@PostMapping(value = "/rGRIFFIN/export")
	public void exportServerList(@ModelAttribute RGRIFFIN license, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] columnList = {"rGRIFFINCompany", "rGRIFFINCategory", "rGRIFFINExpire", "rGRIFFINQuantity", "rGRIFFINRgmsid", "rGRIFFINPassword", "rGRIFFINFilePath", "rGRIFFINRequester"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "rGRIFFIN Entire Data - " + formatter.format(now) + ".csv";

		List list = rGRIFFINService.listAll(license);

		if (license.getRGRIFFINExpireStart() != "" && license.getRGRIFFINExpireEnd() != "") {
			filename = license.getRGRIFFINExpireStart() + " - " + license.getRGRIFFINExpireEnd() + ".csv";
		}

		try {
			if (license.getRGRIFFINExpireStart() != "" && license.getRGRIFFINExpireEnd() == ""
					|| license.getRGRIFFINExpireStart() == "" && license.getRGRIFFINExpireEnd() != "") {
				filename = "전달일자 범위 오류.csv";
				list = new ArrayList<Object>();
			}
			Util.exportExcelFile(response, filename, list, columnList, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
}
