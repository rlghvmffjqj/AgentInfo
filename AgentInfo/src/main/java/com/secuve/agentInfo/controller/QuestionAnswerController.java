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
import com.secuve.agentInfo.vo.Answer;
import com.secuve.agentInfo.vo.Question;

@Controller
public class QuestionAnswerController {
	@Autowired QuestionAnswerService questionAnswerService;
	@Autowired EmployeeService employeeService;
	
	@GetMapping(value = "/questionAnswer/list")
	public String QuestionAnswerList(Model model, Principal principal) {
		model.addAttribute("writer", principal.getName());
		return "questionAnswer/QuestionAnswerList";
	}
	
	@ResponseBody
	@PostMapping(value = "/question")
	public Map<String, Object> Question(Question search) {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<Question> list = new ArrayList<>(questionAnswerService.getQuestionAnswerList(search));

		int totalCount = questionAnswerService.getQuestionAnswerListCount(search);
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		
		return map;
	}
	
	@GetMapping(value = "/question/write")
	public String QuestionWriteView(Principal principal, Model model) {
		Question question = new Question();
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		question.setEmployeeName(employeeService.getEmployeeOne(principal.getName()).getEmployeeName());
		question.setQuestionDate(formatter.format(now));
		
		model.addAttribute("question", question);
		model.addAttribute("viewType", "insert");
		
		return "questionAnswer/QuestionAnswerView";
	}
	
	@ResponseBody
	@PostMapping(value = "/question/insert")
	public String InsertQuestion(Question question, Principal principal) {
		question.setQuestionRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
		question.setQuestionRegistrationDate(formatter.format(now));
		question.setQuestionDate(formatter2.format(now));
		question.setEmployeeId(principal.getName());
		question.setQuestionRegistrant(principal.getName());

		return questionAnswerService.insertQuestion(question);
	}
	
	@PostMapping(value = "/question/view")
	public String QuestionView(int questionKeyNum, Model model) {
		questionAnswerService.questionAnswerCountPlus(questionKeyNum);
		Question question = questionAnswerService.getQuestionOne(questionKeyNum);
		Answer answer = questionAnswerService.getAnswerOne(questionKeyNum);
		
		model.addAttribute("question", question);
		model.addAttribute("answer", answer);
		model.addAttribute("viewType", "view");
		return "questionAnswer/QuestionAnswerView";
	}
	
	@ResponseBody
	@PostMapping(value = "/answer/insert")
	public Map<String, String> InsertAnswer(Answer answer, Principal principal) {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
		
		answer.setAnswerDate(formatter2.format(now));
		answer.setAnswerRegistrant(principal.getName());
		answer.setAnswerRegistrationDate(formatter.format(now));
		answer.setEmployeeId(principal.getName());
		
		return questionAnswerService.insertAnswer(answer);
	}

}
