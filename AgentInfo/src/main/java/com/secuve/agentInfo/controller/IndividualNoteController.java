package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.secuve.agentInfo.core.FileDownloadView;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.IndividualNoteService;
import com.secuve.agentInfo.vo.IndividualNote;

@Controller
public class IndividualNoteController {
	@Autowired IndividualNoteService individualNoteService;
	@Autowired FavoritePageService favoritePageService;
	
	@GetMapping(value = "/individualNote/list")
	public ModelAndView IndividualNoteList(ModelAndView mav, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "노트 - 개인 노트");
		ArrayList<IndividualNote> list = new ArrayList<>(individualNoteService.getIndividualNote(principal.getName()));
		List<String> individualNoteTitle = individualNoteService.getIndividualNoteTitle(principal.getName());
		List<String> individualNoteHashTag = individualNoteService.getIndividualNoteHashTag(principal.getName());
		mav.addObject("list", list).addObject("individualNoteTitle", individualNoteTitle).addObject("individualNoteHashTag",individualNoteHashTag).setViewName("individualNote/IndividualNoteList");
		return mav;
	}
	
	@PostMapping(value = "/individualNote/insertView")
	public String InsertIndividualNoteView(Model model, IndividualNote individualNote) {
		model.addAttribute("viewType", "insert");
		return "/individualNote/IndividualNoteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/insert")
	public Map InsertIndividualNote(IndividualNote individualNote, Principal principal, @RequestParam(value="fileInput", required=false) List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		individualNote.setIndividualNoteRegistrant(principal.getName());
		individualNote.setIndividualNoteRegistrationDate(individualNoteService.nowDate());
		individualNote.setIndividualNoteModifier(principal.getName());
		individualNote.setIndividualNoteModifiedDate(individualNoteService.nowDate());
		individualNote.setIndividualNoteContentsView(individualNote.getIndividualNoteContentsView().replace("'", "&#39;"));
		
		Map result = individualNoteService.insertIndividualNote(individualNote, fileInput);
		result.put("fileName", individualNoteService.getIndividualNoteFileName(individualNote.getIndividualNoteKeyNum()));
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/search")
	public ArrayList<IndividualNote> IndividualNoteReset(ModelAndView mav, Principal principal, String[] individualNoteTitle, String[] individualNoteHashTag, IndividualNote individualNote) {
		ArrayList<IndividualNote> list = new ArrayList<IndividualNote>();
		if(individualNote.getIndividualNoteTreeFullPath() == "/" || individualNote.getIndividualNoteTreeFullPath().equals("/")) {
			list = new ArrayList<>(individualNoteService.getIndividualNoteSearchAll(individualNoteTitle, individualNoteHashTag, principal.getName()));
		} else {
			list = new ArrayList<>(individualNoteService.getIndividualNoteSearch(individualNoteTitle, individualNoteHashTag, principal.getName(), individualNote));
		}
		return list;
	}
	
	@PostMapping(value = "/individualNote/updateView")
	public String UpdateIndividualNoteView(Model model, Principal principal, String individualNoteKeyNum) {
		IndividualNote individualNote = individualNoteService.getIndividualNoteOne(individualNoteKeyNum, principal.getName());
		List<String> individualNoteFileName = individualNoteService.getIndividualNoteFileName(individualNote.getIndividualNoteKeyNum());
		model.addAttribute("individualNote", individualNote);
		model.addAttribute("viewType", "update");
		model.addAttribute("individualNoteFileName",individualNoteFileName);
		return "/individualNote/IndividualNoteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/update")
	public Map UpdateIndividualNote(IndividualNote individualNote, Principal principal, @RequestParam(value="fileInput", required=false) List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		individualNote.setIndividualNoteModifier(principal.getName());
		individualNote.setIndividualNoteModifiedDate(individualNoteService.nowDate());
		individualNote.setIndividualNoteContentsView(individualNote.getIndividualNoteContentsView().replace("'", "&#39;"));

		Map map = new HashMap();
		String result = individualNoteService.updateIndividualNote(individualNote, principal, fileInput);
		map.put("result", result);
		map.put("fileName", individualNoteService.getIndividualNoteFileNameStr(individualNote.getIndividualNoteFileName()));
		map.put("individualNoteModifiedDate", individualNote.getIndividualNoteModifiedDate());
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/delete")
	public String IndividualNoteDelete(String individualNoteKeyNum, Principal principal) {
		return individualNoteService.delIndividualNote(individualNoteKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/save")
	public String SaveIndividualNote(@RequestParam(value="individualNoteKeyNum[]") List<Integer> individualNoteKeyNum) {
		return individualNoteService.saveIndividualNote(individualNoteKeyNum);
	}
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	@GetMapping(value = "/individualNote/fileDownload")
	public View FileDownload(@RequestParam String fileName, @RequestParam String individualNoteKeyNum,  Principal principal, Model model) {
		String filePath = this.filePath + File.separator + "individualNote";
		model.addAttribute("fileUploadPath", filePath);           // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+individualNoteKeyNum+"_"+fileName);     // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);          // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/fileDelete")
	public String FileDelete(String individualNoteFileName, int individualNoteKeyNum, Principal principal, Model model) {
		individualNoteService.deleteIndividualNoteFile(individualNoteKeyNum, individualNoteFileName);
		return individualNoteService.fileDelete(individualNoteKeyNum, individualNoteFileName);
	}
	
	@PostMapping(value = "/individualNote/explanationView")
	public String ExplanationView() {
		return "/individualNote/ExplanationView";
	}
	
}
