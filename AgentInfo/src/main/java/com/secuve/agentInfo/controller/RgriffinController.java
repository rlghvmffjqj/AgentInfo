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
import com.secuve.agentInfo.service.RgriffinService;
import com.secuve.agentInfo.vo.Rgriffin;

@Controller
public class RgriffinController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired RgriffinService rgriffinService;
	
	@GetMapping(value = "/rgriffin/issuance")
	public String LicenseList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "라이선스 관리 - Rgriffin");
		
		return "/rgriffin/LicenseList";
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin")
	public Map<String, Object> Licens(Rgriffin search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Rgriffin> list = new ArrayList<>(rgriffinService.getLicenseList(search));

		int totalCount = rgriffinService.getLicenseListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@PostMapping(value = "/rgriffin/issuedView")
	public String InsertLicenseView(Model model) {
		model.addAttribute("viewType", "insert");
		return "/rgriffin/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin/licenseIssuance")
	public String LicenseInsert(Rgriffin license, Principal principal) {
		license.setRgriffinRegistrant(principal.getName());
		license.setRgriffinRegistrationDate(rgriffinService.nowDate());
		return rgriffinService.licenseInsert(license);
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin/delete")
	public String LicenseDelete(@RequestParam int[] chkList, Principal principal) {
		return rgriffinService.delLicense(chkList, principal);
	}
	
	@PostMapping(value = "/rgriffin/updateView")
	public String UpdateLicenseView(Model model, int rgriffinKeyNum) {
		Rgriffin license = rgriffinService.getLicenseOne(rgriffinKeyNum);
		
		model.addAttribute("viewType", "update").addAttribute("license", license);
		return "/rgriffin/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin/licenseUpdate")
	public String RgriffinUpdate(Rgriffin license, Principal principal) throws ParseException {
		license.setRgriffinModifier(principal.getName());
		license.setRgriffinModifiedDate(rgriffinService.nowDate());

		return rgriffinService.updateLicense(license, principal);
	}
	
	@PostMapping(value = "/rgriffin/export")
	public void exportServerList(@ModelAttribute Rgriffin license, @RequestParam String[] columns,
			@RequestParam String[] headers, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] columnList = {"rgriffinCompany", "rgriffinCategory", "rgriffinExpire", "rgriffinQuantity", "rgriffinRgmsid", "rgriffinPassword", "rgriffinFilePath", "rgriffinRequester"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "rgriffin Entire Data - " + formatter.format(now) + ".csv";

		List list = rgriffinService.listAll(license);

		if (license.getRgriffinExpireStart() != "" && license.getRgriffinExpireEnd() != "") {
			filename = license.getRgriffinExpireStart() + " - " + license.getRgriffinExpireEnd() + ".csv";
		}

		try {
			if (license.getRgriffinExpireStart() != "" && license.getRgriffinExpireEnd() == ""
					|| license.getRgriffinExpireStart() == "" && license.getRgriffinExpireEnd() != "") {
				filename = "전달일자 범위 오류.csv";
				list = new ArrayList<Object>();
			}
			Util.exportExcelFile(response, filename, list, columnList, headers);
		} catch (Exception e) {
			System.out.println("FAIL: Export failed.\n" + e.toString());
		}
	}
}
