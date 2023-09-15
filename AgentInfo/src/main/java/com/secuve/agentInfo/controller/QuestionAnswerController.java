package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.QuestionAnswerService;
import com.secuve.agentInfo.vo.Employee;
import com.secuve.agentInfo.vo.QuestionAnswer;

@Controller
public class QuestionAnswerController {
	@Autowired QuestionAnswerService questionAnswerService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/questionAnswer/list")
	public String QuestionAnswerList(Model model) {
		return "questionAnswer/QuestionAnswerList";
	}
	
	@ResponseBody
	@PostMapping(value = "/questionAnswer")
	public Map<String, Object> QuestionAnswer(QuestionAnswer search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<QuestionAnswer> list = new ArrayList<>(questionAnswerService.getQuestionAnswerList(search));

		int totalCount = questionAnswerService.getQuestionAnswerListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	@GetMapping(value = "/questionAnswer/write")
	public String QuestionAnswerView(Principal principal, Model model) {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		model.addAttribute("employeeName", employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
		model.addAttribute("questionAnswerDate", formatter.format(now));
		return "questionAnswer/QuestionAnswerView";
	}
	
	@ResponseBody
	@PostMapping(value = "/questionAnswer/insert")
	public String InsertQuestionAnswer(QuestionAnswer questionAnswer, Principal principal) {
		questionAnswer.setQuestionAnswerRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
		questionAnswer.setQuestionAnswerRegistrationDate(formatter.format(now));
		questionAnswer.setQuestionAnswerDate(formatter2.format(now));
		questionAnswer.setEmployeeId(principal.getName());

		return questionAnswerService.insertQuestionAnswer(questionAnswer);
	}

}
