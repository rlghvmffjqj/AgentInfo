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

import com.secuve.agentInfo.service.SharedNoteTreeService;
import com.secuve.agentInfo.vo.SharedNoteTree;

@Controller
public class SharedNoteTreeController {
	@Autowired SharedNoteTreeService sharedNoteTreeService;
	
	/**
	 * 트리 정보 가져오기
	 * @param parentPath
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/sharedNoteTree/list")
	public Object SharedNoteTreeList(@RequestParam String parentPath, Principal principal) {
		return sharedNoteTreeService.getSharedNoteTreeList(parentPath, principal.getName());
	}
	
	/**
	 * 트리 추가 Modal
	 * @param model
	 * @param sharedNoteTreeFullPath
	 * @return
	 */
	@PostMapping(value = "/sharedNoteTree/insertView")
	public String InsertEmployeeView(Model model, @RequestParam String sharedNoteTreeFullPath) {
		model.addAttribute("viewType","insert").addAttribute("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		return "/sharedNoteTree/SharedNoteTreeView";
	}
	
	/**
	 * 트리 추가
	 * @param sharedNoteTree
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/sharedNoteTree/insert")
	public Map<String,String> InsertEmployee(Principal principal, SharedNoteTree sharedNoteTree) {
		Map<String,String> map = new HashMap<String,String>();
		sharedNoteTree.setSharedNoteTreeRegistrant(principal.getName());
		sharedNoteTree.setSharedNoteTreeRegistrationDate(sharedNoteTreeService.nowDate());
		String result = sharedNoteTreeService.insertSharedNoteTree(sharedNoteTree);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 트리 삭제
	 * @param sharedNoteTree
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/sharedNoteTree/delete")
	public Map<String,String> DeleteSharedNoteTree(Principal principal, SharedNoteTree sharedNoteTree) {
		Map<String,String> map = new HashMap<String,String>();
		sharedNoteTree.setSharedNoteTreeRegistrant(principal.getName());
		String result = sharedNoteTreeService.deleteSharedNoteTree(sharedNoteTree);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 트리 수정 Modal
	 * @param model
	 * @param sharedNoteTreeFullPath
	 * @return
	 */
	@PostMapping(value = "/sharedNoteTree/updateView")
	public String UpdateEmployeeView(Model model, @RequestParam String sharedNoteTreeFullPath) {
		model.addAttribute("viewType","update").addAttribute("sharedNoteTreeFullPath", sharedNoteTreeFullPath);
		return "/sharedNoteTree/SharedNoteTreeView";
	}
	
	/**
	 * 트리 수정
	 * @param sharedNoteTree
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/sharedNoteTree/update")
	public Map<String,String> updateEmployee(Principal principal, SharedNoteTree sharedNoteTree) {
		Map<String,String> map = new HashMap<String,String>();
		sharedNoteTree.setSharedNoteTreeRegistrant(principal.getName());
		sharedNoteTree.setSharedNoteTreeModifier(principal.getName());
		sharedNoteTree.setSharedNoteTreeModifiedDate(sharedNoteTreeService.nowDate());
		String result = sharedNoteTreeService.updateSharedNoteTree(sharedNoteTree);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 트리 이동
	 * @return
	 */
	@PostMapping(value = "/sharedNoteTree/sharedNoteTreeMoveView")
	public String SharedNoteTreeMoveView() {
		return "/sharedNoteTree/SharedNoteTreeMoveView";
	}

}
