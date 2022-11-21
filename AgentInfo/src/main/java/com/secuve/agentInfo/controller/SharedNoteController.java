package com.secuve.agentInfo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.secuve.agentInfo.service.SharedNoteService;
import com.secuve.agentInfo.vo.SharedNote;

@Controller
public class SharedNoteController {
	@Autowired SharedNoteService sharedNoteService;
	
	@GetMapping(value = "/sharedNote/list")
	public ModelAndView SharedNoteList(ModelAndView mav, Principal principal) {
		ArrayList<SharedNote> list = new ArrayList<>(sharedNoteService.getSharedNote(principal.getName()));
		List<String> sharedNoteTitle = sharedNoteService.getSharedNoteTitle(principal.getName());
		List<String> sharedNoteHashTag = sharedNoteService.getSharedNoteHashTag(principal.getName());
		mav.addObject("list", list).addObject("sharedNoteTitle", sharedNoteTitle).addObject("sharedNoteHashTag",sharedNoteHashTag).setViewName("sharedNote/SharedNoteList");
		return mav;
	}
	
	@PostMapping(value = "/sharedNote/insertView")
	public String InsertSharedNoteView(Model model, SharedNote sharedNote) {
		model.addAttribute("viewType", "insert");
		return "/sharedNote/SharedNoteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedNote/insert")
	public Map InsertSharedNote(SharedNote sharedNote, Principal principal, @RequestParam(value="fileInput", required=false) List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		sharedNote.setSharedNoteRegistrant(principal.getName());
		sharedNote.setSharedNoteRegistrationDate(sharedNoteService.nowDate());
		sharedNote.setSharedNoteModifier(principal.getName());
		sharedNote.setSharedNoteModifiedDate(sharedNoteService.nowDate());
		sharedNote.setSharedNoteContentsView(sharedNote.getSharedNoteContentsView().replace("'", "&#39;"));
		
		Map result = sharedNoteService.insertSharedNote(sharedNote, fileInput);
		result.put("fileName", sharedNoteService.getSharedNoteFileName(sharedNote.getSharedNoteKeyNum()));
		return result;
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedNote/search")
	public ArrayList<SharedNote> SharedNoteReset(ModelAndView mav, Principal principal, String[] sharedNoteTitle, String[] sharedNoteHashTag, SharedNote sharedNote) {
		ArrayList<SharedNote> list = new ArrayList<SharedNote>();
		if(sharedNote.getSharedNoteTreeFullPath() == "/" || sharedNote.getSharedNoteTreeFullPath().equals("/")) {
			list = new ArrayList<>(sharedNoteService.getSharedNoteSearchAll(sharedNoteTitle, sharedNoteHashTag, principal.getName()));
		} else {
			list = new ArrayList<>(sharedNoteService.getSharedNoteSearch(sharedNoteTitle, sharedNoteHashTag, principal.getName(), sharedNote));
		}
		return list;
	}
	
	@PostMapping(value = "/sharedNote/updateView")
	public String UpdateSharedNoteView(Model model, Principal principal, String sharedNoteKeyNum) {
		SharedNote sharedNote = sharedNoteService.getSharedNoteOne(sharedNoteKeyNum, principal.getName());
		List<String> sharedNoteFileName = sharedNoteService.getSharedNoteFileName(sharedNote.getSharedNoteKeyNum());
		model.addAttribute("sharedNote", sharedNote);
		model.addAttribute("viewType", "update");
		model.addAttribute("sharedNoteFileName",sharedNoteFileName);
		return "/sharedNote/SharedNoteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedNote/update")
	public Map UpdateSharedNote(SharedNote sharedNote, Principal principal, @RequestParam(value="fileInput", required=false) List<MultipartFile> fileInput) throws IllegalStateException, IOException {
		sharedNote.setSharedNoteModifier(principal.getName());
		sharedNote.setSharedNoteModifiedDate(sharedNoteService.nowDate());
		sharedNote.setSharedNoteContentsView(sharedNote.getSharedNoteContentsView().replace("'", "&#39;"));

		Map map = new HashMap();
		String result = sharedNoteService.updateSharedNote(sharedNote, principal, fileInput);
		map.put("result", result);
		map.put("fileName", sharedNoteService.getSharedNoteFileNameStr(sharedNote.getSharedNoteFileName()));
		map.put("sharedNoteModifiedDate", sharedNote.getSharedNoteModifiedDate());
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedNote/delete")
	public String SharedNoteDelete(String sharedNoteKeyNum, Principal principal) {
		return sharedNoteService.delSharedNote(sharedNoteKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedNote/save")
	public String SaveSharedNote(@RequestParam(value="sharedNoteKeyNum[]") List<Integer> sharedNoteKeyNum) {
		return sharedNoteService.saveSharedNote(sharedNoteKeyNum);
	}
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	@GetMapping(value = "/sharedNote/fileDownload")
	public View FileDownload(@RequestParam String fileName, @RequestParam String sharedNoteKeyNum,  Principal principal, Model model) {
		String filePath = this.filePath + File.separator + "sharedNote";
		model.addAttribute("fileUploadPath", filePath);           // 파일 경로    
		model.addAttribute("filePhysicalName", "/"+sharedNoteKeyNum+"_"+fileName);     // 파일 이름    
		model.addAttribute("fileLogicalName", fileName);          // 출력할 파일 이름
	
		return new FileDownloadView();
	}
	
	@ResponseBody
	@PostMapping(value = "/sharedNote/fileDelete")
	public String FileDelete(String sharedNoteFileName, int sharedNoteKeyNum, Principal principal, Model model) {
		sharedNoteService.deleteSharedNoteFile(sharedNoteKeyNum, sharedNoteFileName);
		return sharedNoteService.fileDelete(sharedNoteKeyNum, sharedNoteFileName);
	}
	
}
