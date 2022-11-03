package com.secuve.agentInfo.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.secuve.agentInfo.service.IndividualNoteService;
import com.secuve.agentInfo.vo.IndividualNote;

@Controller
public class IndividualNoteController {
	@Autowired IndividualNoteService individualNoteService;
	
	@GetMapping(value = "/individualNote/list")
	public ModelAndView IndividualNoteList(ModelAndView mav, Principal principal) {
		ArrayList<IndividualNote> list = new ArrayList<>(individualNoteService.getIndividualNote(principal.getName()));
		List<String> individualNoteTitle = individualNoteService.getIndividualNoteTitle(principal.getName());
		mav.addObject("list", list).addObject("individualNoteTitle", individualNoteTitle).setViewName("individualNote/IndividualNoteList");
		return mav;
	}
	
	@PostMapping(value = "/individualNote/insertView")
	public String InsertIndividualNoteView(Model model, IndividualNote individualNote) {
		model.addAttribute("viewType", "insert");
		return "/individualNote/IndividualNoteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/insert")
	public Map<String, String> InsertIndividualNote(IndividualNote individualNote, Principal principal) {
		individualNote.setIndividualNoteRegistrant(principal.getName());
		individualNote.setIndividualNoteRegistrationDate(individualNoteService.nowDate());
		individualNote.setIndividualNoteModifier(principal.getName());
		individualNote.setIndividualNoteModifiedDate(individualNoteService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = individualNoteService.insertIndividualNote(individualNote);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/search")
	public ArrayList<IndividualNote> IndividualNoteReset(ModelAndView mav, Principal principal, String[] individualNoteTitle) {
		ArrayList<IndividualNote> list = new ArrayList<>(individualNoteService.getIndividualNoteSearch(individualNoteTitle, principal.getName()));
		return list;
	}
	
	@PostMapping(value = "/individualNote/updateView")
	public String UpdateIndividualNoteView(Model model, Principal principal, String individualNoteKeyNum) {
		IndividualNote individualNote = individualNoteService.getIndividualNoteOne(individualNoteKeyNum, principal.getName());
		model.addAttribute("individualNote", individualNote);
		model.addAttribute("viewType", "update");
		return "/individualNote/IndividualNoteView";
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/update")
	public Map<String, String> UpdateIndividualNote(IndividualNote individualNote, Principal principal) {
		individualNote.setIndividualNoteModifier(principal.getName());
		individualNote.setIndividualNoteModifiedDate(individualNoteService.nowDate());

		Map<String, String> map = new HashMap<String, String>();
		String result = individualNoteService.updateIndividualNote(individualNote, principal);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/delete")
	public String IndividualNoteDelete(String individualNoteKeyNum, Principal principal) {
		return individualNoteService.delIndividualNote(individualNoteKeyNum);
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/save")
	public String SaveIndividualNote(@RequestParam(value="individualNoteTitle[]") List<String> individualNoteTitle, @RequestParam(value="individualNoteContents[]") List<String> individualNoteContents, Principal principal) {
		individualNoteService.delAllIndividualNote(principal.getName());
		return individualNoteService.saveIndividualNote(individualNoteTitle, individualNoteContents, principal.getName());
	}
	
}
