package com.secuve.agentInfo.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
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

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.core.Util;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.MailSendService;
import com.secuve.agentInfo.service.RgriffinService;
import com.secuve.agentInfo.vo.Rgriffin;
import com.secuve.agentInfo.vo.SendMailSetting;

import org.springframework.web.servlet.View;

@Controller
public class RgriffinController {
	@Autowired FavoritePageService favoritePageService;
	@Autowired RgriffinService rgriffinService;
	@Autowired MailSendService mailSendService;
	
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
		Rgriffin license = new Rgriffin();
		license.setLicenseType("(일반)");
		model.addAttribute("viewType", "insert").addAttribute("license", license);
		return "/rgriffin/LicenseView";
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin/licenseIssuance")
	public String LicenseInsert(Rgriffin license, Principal principal) throws IOException {
		license.setRgriffinRegistrant(principal.getName());
		license.setRgriffinRegistrationDate(rgriffinService.nowDate());
		return rgriffinService.licenseIssuance(license);
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
		
		String[] columnList = {"licenseType","rgriffinCompany", "rgriffinBusinessName", "rgriffinCategory", "rgriffinWriteDate", "rgriffinIssueDate", "rgriffinExpire", "rgriffinQuantity", "rgriffinRgmsid", "rgriffinPassword", "rgriffinFilePath", "rgriffinRequester"};
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "rgriffin Entire Data - " + formatter.format(now) + ".csv";

		List<Object> list = rgriffinService.listAll(license);

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
	
	@GetMapping(value = "/rgriffin/licenseIssuanceDownLoad")
	public View licenseIssuanceDownLoad(@RequestParam String fileName, Model model) throws UnsupportedEncodingException {
		fileName += ".json";
		String filePath = "C:\\License\\backup";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin/rgriffinDownLoadCheck")
	public String downLoadCheck(@RequestParam int[] chkList) {
		return rgriffinService.downLoadCheck(chkList);
	}
	
	@GetMapping("/rgriffin/rgriffinMultiDownLoad")
	public void downloadJson(int rgriffinKeyNum, HttpServletResponse response) throws IOException {
		Rgriffin license = rgriffinService.getLicenseOne(rgriffinKeyNum);
		
		String jsonData = license.getRgriffinContent();
		String filename = license.getRgriffinCompany();
		
	    response.setContentType("application/json; charset=UTF-8");
	    response.setHeader("Content-Disposition", "attachment; filename=\""+filename+".json\"");

	    try (OutputStream out = response.getOutputStream()) {
	        out.write(jsonData.getBytes(StandardCharsets.UTF_8));
	        out.flush();
	    }
	}
	
	@PostMapping(value = "/rgriffin/mailSetting")
	public String MailSetting(Model model) {
		SendMailSetting sendMailSetting = mailSendService.getTargetSetting("rgriffin");
		model.addAttribute(sendMailSetting);
		return "/mailSend/MailSetting";
	}
	
	@ResponseBody
	@PostMapping(value = "/rgriffin/individualMailSend")
	public String IndividualMailSend(int licenseKeyNum) {
		return rgriffinService.individualMailSend(licenseKeyNum);
	}
}
