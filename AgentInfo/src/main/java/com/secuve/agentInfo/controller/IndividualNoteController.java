package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.secuve.agentInfo.service.IndividualNoteService;
import com.secuve.agentInfo.vo.IndividualNote;

@Controller
public class IndividualNoteController {
	@Autowired IndividualNoteService individualNoteService;
	
	@GetMapping(value = "/individualNote/list")
	public ModelAndView IndividualNoteList(ModelAndView mav) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<IndividualNote> list = new ArrayList<>(individualNoteService.getIndividualNote());
		mav.addObject("list", list).setViewName("individualNote/IndividualNoteList");
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

		Map<String, String> map = new HashMap<String, String>();
		String result = individualNoteService.insertIndividualNote(individualNote);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/individualNote/search")
	public ArrayList<IndividualNote> IndividualNoteReset(ModelAndView mav, String individualNoteTitle) {
		ArrayList<IndividualNote> list = new ArrayList<>(individualNoteService.getIndividualNoteSearch(individualNoteTitle));
		return list;
	}
}
