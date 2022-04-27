package com.secuve.agentInfo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.DepartmentService;
import com.secuve.agentInfo.vo.Department;

@Controller
public class DepartmentController {
	@Autowired DepartmentService departmentService;

	/**
	 * 부서 정보 가져오기
	 * @param parentPath
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/department/list")
	public Object DepartmentList(@RequestParam String parentPath) {
		return departmentService.getDepartmentList(parentPath);
	}
	
	/**
	 * 부서 추가 Modal
	 * @param model
	 * @param departmentFullPath
	 * @return
	 */
	@PostMapping(value = "/department/insertView")
	public String InsertEmployeeView(Model model, @RequestParam String departmentFullPath) {
		model.addAttribute("viewType","insert").addAttribute("departmentFullPath", departmentFullPath);
		return "/department/DepartmentView";
	}
	
	/**
	 * 부서 추가
	 * @param department
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/department/insert")
	public Map<String,String> InsertEmployee(Department department) {
		Map<String,String> map = new HashMap<String,String>();
		String result = departmentService.insertDepartment(department);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 삭제
	 * @param department
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/department/delete")
	public Map<String,String> DeleteDepartment(Department department) {
		Map<String,String> map = new HashMap<String,String>();
		String result = departmentService.deleteDepartment(department);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 수정 Modal
	 * @param model
	 * @param departmentFullPath
	 * @return
	 */
	@PostMapping(value = "/department/updateView")
	public String UpdateEmployeeView(Model model, @RequestParam String departmentFullPath) {
		model.addAttribute("viewType","update").addAttribute("departmentFullPath", departmentFullPath);
		return "/department/DepartmentView";
	}
	
	/**
	 * 부서 수정
	 * @param department
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/department/update")
	public Map<String,String> updateEmployee(Department department) {
		Map<String,String> map = new HashMap<String,String>();
		String result = departmentService.updateDepartment(department);
		map.put("result", result);
		return map;
	}
	
	/**
	 * 부서 이동
	 * @return
	 */
	@PostMapping(value = "/department/departmentMoveView")
	public String DepartmentMoveView() {
		return "/department/DepartmentMoveView";
	}
	
}
