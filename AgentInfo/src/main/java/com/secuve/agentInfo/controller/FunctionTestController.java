package com.secuve.agentInfo.controller;

import java.io.File;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.core.PDFDownlod;
import com.secuve.agentInfo.core.WordDownload;
import com.secuve.agentInfo.service.FunctionTestService;
import com.secuve.agentInfo.service.FunctionTestSettingService;
import com.secuve.agentInfo.vo.FunctionTest;
import com.secuve.agentInfo.vo.FunctionTestSetting;

@Controller
public class FunctionTestController {
	@Autowired FunctionTestService functionTestService;
	@Autowired FunctionTestSettingService functionTestSettingService;
	@Autowired PDFDownlod pdfDownlod;
	@Autowired WordDownload wordDownload;
	
	@GetMapping(value = "/functionTest/list")
	public String functionTestList(String functionTestType, Model model) {
		model.addAttribute("functionTestType",functionTestType);
		return "functionTest/FunctionTest";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest")
	public Map<String, Object> functionTest(FunctionTest search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<FunctionTest> list = new ArrayList<>(functionTestService.getFunctionTest(search));

		int totalCount = functionTestService.getFunctionTestCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/functionTest/view")
	public String ExistingNew(String functionTestType, Model model) {
		List<FunctionTestSetting> functionTestSettingFormTOSMS = functionTestSettingService.functionTestForm("TOSMS", functionTestType);
		List<FunctionTestSetting> functionTestSettingFormAgent = functionTestSettingService.functionTestForm("Agent", functionTestType);
		List<FunctionTestSetting> functionTestSettingCategory = functionTestSettingService.functionTestCategory(functionTestType);
		List<FunctionTestSetting> functionTestSettingSubCategory = functionTestSettingService.functionTestSubCategory(functionTestType);
		FunctionTest functionTest = new FunctionTest();
		functionTest.setFunctionTestKeyNum(0);
		
		model.addAttribute("functionTestSettingFormTOSMS",functionTestSettingFormTOSMS);
		model.addAttribute("functionTestSettingFormAgent",functionTestSettingFormAgent);
		model.addAttribute("functionTestSettingCategory",functionTestSettingCategory);
		model.addAttribute("functionTestSettingSubCategory",functionTestSettingSubCategory);
		model.addAttribute("viewType","insert");
		model.addAttribute("functionTestTitle",functionTest);
		model.addAttribute("functionTestType",functionTestType);
		try {
			model.addAttribute("functionTestSettingFormKeyNumMin", functionTestSettingService.getFunctionTestSettingFormKeyNumMin("TOSMS"));
		} catch (Exception e) {
			model.addAttribute("functionTestSettingFormKeyNumMin", 0);
		}
		return "/functionTest/FunctionTestView";
	}
	
	@GetMapping(value = "/functionTest/detailView")
	public String detailView(FunctionTestSetting functionTestSetting, Model model) {
		FunctionTestSetting functionTestSettingDetail = functionTestSettingService.functionTestSettingDetail(functionTestSetting.getFunctionTestSettingSubCategoryKeyNum());
		model.addAttribute("functionTestSettingDetail", functionTestSettingDetail);
		return "/functionTest/FunctionTestDetail";
	}
	
	@GetMapping(value = "/functionTest/resultView")
	public String resultView(FunctionTest functionTest, Model model) {
		FunctionTest functionTestDelicacy = functionTestService.getFunctionTestDelicacy(functionTest);
		model.addAttribute("functionTest", functionTestDelicacy);
		return "/functionTest/FunctionTestResult";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/functionTestSave")
	public Map FunctionTestSave(FunctionTest functionTest, Principal principal) {
		functionTest.setFunctionTestRegistrant(principal.getName());
		functionTest.setFunctionTestRegistrationDate(functionTestService.nowDate());
		
		Map result = functionTestService.insertFunctionTest(functionTest, principal);
		return result;
	}
	
	@GetMapping(value = "/functionTest/updateView")
	public String UpdateView(Model model, Principal principal, int functionTestKeyNum, String functionTestType) {
		FunctionTest functionTestTitle = functionTestService.getFunctionTestOneTitle(functionTestKeyNum);
		ArrayList<FunctionTest> functionTest = new ArrayList<>(functionTestService.getFunctionTestOne(functionTestKeyNum));
		
		List<FunctionTestSetting> functionTestSettingFormTOSMS = functionTestSettingService.functionTestForm("TOSMS", functionTestType);
		List<FunctionTestSetting> functionTestSettingFormAgent = functionTestSettingService.functionTestForm("Agent", functionTestType);
		List<FunctionTestSetting> functionTestSettingCategory = functionTestSettingService.functionTestCategory(functionTestType);
		List<FunctionTestSetting> functionTestSettingSubCategory = functionTestSettingService.functionTestSubCategory(functionTestType);
		List<Integer> functionTestFunctionTestSettingSubCategoryKeyNum = functionTestService.functionTestFunctionTestSettingSubCategoryKeyNum(functionTestKeyNum);
		
		model.addAttribute("functionTestSettingFormTOSMS",functionTestSettingFormTOSMS);
		model.addAttribute("functionTestSettingFormAgent",functionTestSettingFormAgent);
		model.addAttribute("functionTestSettingCategory",functionTestSettingCategory);
		model.addAttribute("functionTestSettingSubCategory",functionTestSettingSubCategory);
		model.addAttribute("viewType", "update");
		model.addAttribute("functionTestTitle", functionTestTitle);
		model.addAttribute("functionTest",functionTest);
		model.addAttribute("functionTestFunctionTestSettingSubCategoryKeyNum", functionTestFunctionTestSettingSubCategoryKeyNum);
		model.addAttribute("functionTestType",functionTestType);
		model.addAttribute("functionTestSettingFormKeyNumMin", functionTestSettingService.getFunctionTestSettingFormKeyNumMin("TOSMS"));
		model.addAttribute("functionTestKeyNum", functionTestKeyNum);
		return "functionTest/FunctionTestView";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/delete")
	public String FunctionTestDelete(@RequestParam int[] chkList) {
		return functionTestService.delFunctionTest(chkList);
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/update")
	public Map FunctionTestUpdate(FunctionTest functionTest, Principal principal) {
		functionTest.setFunctionTestModifier(principal.getName());
		functionTest.setFunctionTestModifiedDate(functionTestService.nowDate());
		
		Map result = functionTestService.updateFunctionTest(functionTest, principal);
		return result;
	}
	
	@RequestMapping(value = "/functionTest/pdfView", method = RequestMethod.POST)
	public String PdfView(Model model, FunctionTest functionTest, FunctionTestSetting functionTestSetting) {
		FunctionTest functionTestTitle = functionTestService.getFunctionTestPDFTitle(functionTest);
		List<FunctionTestSetting> functionTestSettingList = functionTestService.getFunctionTestSettingPDFList(functionTest);
		
		model.addAttribute("functionTestTitle",functionTestTitle);
		model.addAttribute("functionTestSettingList",functionTestSettingList);
		return "functionTest/PdfView";
	}
	
	@RequestMapping(value = "/functionTest/wordView", method = RequestMethod.POST)
	public String WordView(Model model, FunctionTest functionTest, FunctionTestSetting functionTestSetting) {
		FunctionTest functionTestTitle = functionTestService.getFunctionTestPDFTitle(functionTest);
		List<FunctionTestSetting> functionTestSettingList = functionTestService.getFunctionTestSettingPDFList(functionTest);
		
		model.addAttribute("functionTestTitle",functionTestTitle);
		model.addAttribute("functionTestSettingList",functionTestSettingList);
		return "functionTest/WordView";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/pdf")
	public String PDF(StringBuffer jsp, String functionTestCustomer, String functionTestTitle, String functionTestDate, Principal principal, Model model) {
		String filePath = "C:\\AgentInfo\\functionTestDownload";
		String fileName = functionTestCustomer + "_" + functionTestTitle + "_" + functionTestDate + ".pdf";
		try {
			pdfDownlod.makepdf(jsp.toString(), filePath + "\\" + fileName);
		} catch (Exception e) {
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/word")
	public String Word(FunctionTest functionTest, FunctionTestSetting functionTestSetting) {
		String filePath = "C:\\AgentInfo\\functionTestDownload";
		String fileName = "document.docx";
		
		FunctionTest functionTestTitle = functionTestService.getFunctionTestPDFTitle(functionTest);
		List<FunctionTestSetting> functionTestSettingList = functionTestService.getFunctionTestSettingPDFList(functionTest);
		try {
			wordDownload.makeWord(functionTestSettingList, filePath + "\\" + fileName);
		} catch (Exception e) {
			e.printStackTrace();
			return "FALSE";
		}
		return "OK"; 
	}
	
	@GetMapping(value = "/functionTest/fileDownload")
	public View FileDownload(@RequestParam String fileName, Model model) throws Exception {
		String filePath = "C:\\AgentInfo\\functionTestDownload";
		model.addAttribute("fileUploadPath", filePath);          // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+fileName);    // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);  		 // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/fileDelete")
	public String FileDelete(String fileName, Principal principal, Model model) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\functionTestDownload";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + fileName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}
	
	@ResponseBody
	@PostMapping(value = "/functionTest/resultSave")
	public String resultSave(FunctionTest functionTest, Principal principal) {
		return functionTestService.resultSave(functionTest);
	}
}
