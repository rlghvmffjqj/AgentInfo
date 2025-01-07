package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.core.XssConfig;
import com.secuve.agentInfo.service.EmployeeService;
import com.secuve.agentInfo.service.FavoritePageService;
import com.secuve.agentInfo.service.QuestionAnswerService;
import com.secuve.agentInfo.vo.Answer;
import com.secuve.agentInfo.vo.Question;

@Controller
public class QuestionAnswerController {
	@Autowired QuestionAnswerService questionAnswerService;
	@Autowired EmployeeService employeeService;
	@Autowired FavoritePageService favoritePageService;
	@Autowired XssConfig xssConfig;
	
	@GetMapping(value = "/questionAnswer/list")
	public String QuestionAnswerList(Model model, Principal principal, HttpServletRequest req) {
		favoritePageService.insertFavoritePage(principal, req, "Q & A");
		model.addAttribute("writer", principal.getName());
		model.addAttribute("role",employeeService.getEmployeeOne(principal.getName()).getUsersRole());
		return "questionAnswer/QuestionAnswerList";
	}
	
	@ResponseBody
	@PostMapping(value = "/question")
	public Map<String, Object> Question(Principal principal, Question search) {
		search.setUsersRole(employeeService.getEmployeeOne(principal.getName()).getUsersRole());
		search.setEmployeeId(principal.getName());
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
		question.setQuestionDetail(xssConfig.sanitize(question.getQuestionDetail()));
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
	public String QuestionView(int questionKeyNum, Model model, Principal principal) {
		questionAnswerService.questionAnswerCountPlus(questionKeyNum);
		Question question = questionAnswerService.getQuestionOne(questionKeyNum);
		Answer answer = questionAnswerService.getAnswerOne(questionKeyNum);
		
		String role = employeeService.getEmployeeOne(principal.getName()).getUsersRole();
		String identityCheck = "off";
		if(question.getQuestionRegistrant().equals(principal.getName())) {
			identityCheck = "on";
		}
		if(question.getQuestionRegistrant().equals(principal.getName()) || role.equals("ADMIN")) {
			identityCheck = "adminOff";
		}
		if(question.getQuestionRegistrant().equals(principal.getName()) && role.equals("ADMIN")) {
			identityCheck = "adminOn";
		}
		
		questionAnswerService.updateUserAlarm(question, principal.getName());
		
		model.addAttribute("question", question);
		model.addAttribute("answer", answer);
		model.addAttribute("viewType", "view");
		model.addAttribute("identityCheck", identityCheck);
		model.addAttribute("writer", principal.getName());
		model.addAttribute("role", role);
		return "questionAnswer/QuestionAnswerView";
	}
	
	@ResponseBody
	@PostMapping(value = "/answer/insert")
	public Map<String, String> InsertAnswer(Answer answer, Principal principal) {
		answer.setAnswerDetail(xssConfig.sanitize(answer.getAnswerDetail()));
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
		
		answer.setAnswerDate(formatter2.format(now));
		answer.setAnswerRegistrant(principal.getName());
		answer.setAnswerRegistrationDate(formatter.format(now));
		answer.setEmployeeId(principal.getName());
		
		return questionAnswerService.insertAnswer(answer);
	}
	
	@ResponseBody
	@PostMapping(value = "/question/delete")
	public String DeleteQuestion(Question question) {
		return questionAnswerService.deleteQuestion(question);
	}
	
	@ResponseBody
	@PostMapping(value = "/question/update")
	public Map<String, String> UpdateQuestion(Question question, Principal principal) {
		question.setQuestionDetail(xssConfig.sanitize(question.getQuestionDetail()));
		question.setQuestionRegistrant(principal.getName());
		// Date formatter 현재 시간
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
		question.setQuestionDate(formatter2.format(now));
		question.setQuestionModifiedDate(formatter.format(now));
		question.setQuestionModifier(principal.getName());

		return questionAnswerService.updateQuestion(question);
	}

}
