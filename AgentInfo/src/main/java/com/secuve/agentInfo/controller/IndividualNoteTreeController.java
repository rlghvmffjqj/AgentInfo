package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.IndividualNoteTreeService;
import com.secuve.agentInfo.vo.IndividualNoteTree;

@Controller
public class IndividualNoteTreeController {
	@Autowired IndividualNoteTreeService individualNoteTreeService;
	
	/**
	 * 트리 정보 가져오기
	 * @param parentPath
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/individualNoteTree/list")
	public Object IndividualNoteTreeList(@RequestParam String parentPath, Principal principal) {
		return individualNoteTreeService.getIndividualNoteTreeList(parentPath, principal.getName());
	}
	
	/**
	 * 트리 추가 Modal
	 * @param model
	 * @param individualNoteTreeFullPath
	 * @return
	 */
	@PostMapping(value = "/individualNoteTree/insertView")
	public String InsertEmployeeView(Model model, @RequestParam String individualNoteTreeFullPath) {
		model.addAttribute("viewType","insert").addAttribute("individualNoteTreeFullPath", individualNoteTreeFullPath);
		return "/individualNoteTree/IndividualNoteTreeView";
	}
	
	/**
	 * 트리 추가
	 * @param individualNoteTree
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/individualNoteTree/insert")
	public Map<String,String> InsertEmployee(Principal principal, IndividualNoteTree individualNoteTree) {
		Map<String,String> map = new HashMap<String,String>();
		individualNoteTree.setIndividualNoteTreeRegistrant(principal.getName());
		individualNoteTree.setIndividualNoteTreeRegistrationDate(individualNoteTreeService.nowDate());
		String result = individualNoteTreeService.insertIndividualNoteTree(individualNoteTree);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 트리 삭제
	 * @param individualNoteTree
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/individualNoteTree/delete")
	public Map<String,String> DeleteIndividualNoteTree(Principal principal, IndividualNoteTree individualNoteTree) {
		Map<String,String> map = new HashMap<String,String>();
		individualNoteTree.setIndividualNoteTreeRegistrant(principal.getName());
		String result = individualNoteTreeService.deleteIndividualNoteTree(individualNoteTree);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 트리 수정 Modal
	 * @param model
	 * @param individualNoteTreeFullPath
	 * @return
	 */
	@PostMapping(value = "/individualNoteTree/updateView")
	public String UpdateEmployeeView(Model model, @RequestParam String individualNoteTreeFullPath) {
		model.addAttribute("viewType","update").addAttribute("individualNoteTreeFullPath", individualNoteTreeFullPath);
		return "/individualNoteTree/IndividualNoteTreeView";
	}
	
	/**
	 * 트리 수정
	 * @param individualNoteTree
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/individualNoteTree/update")
	public Map<String,String> updateEmployee(Principal principal, IndividualNoteTree individualNoteTree) {
		Map<String,String> map = new HashMap<String,String>();
		individualNoteTree.setIndividualNoteTreeRegistrant(principal.getName());
		individualNoteTree.setIndividualNoteTreeModifier(principal.getName());
		individualNoteTree.setIndividualNoteTreeModifiedDate(individualNoteTreeService.nowDate());
		String result = individualNoteTreeService.updateIndividualNoteTree(individualNoteTree);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 트리 이동
	 * @return
	 */
	@PostMapping(value = "/individualNoteTree/individualNoteTreeMoveView")
	public String IndividualNoteTreeMoveView() {
		return "/individualNoteTree/IndividualNoteTreeMoveView";
	}

}
