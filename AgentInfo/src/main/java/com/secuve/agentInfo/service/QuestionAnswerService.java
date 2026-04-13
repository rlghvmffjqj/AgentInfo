package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.dao.QuestionAnswerDao;
import com.secuve.agentInfo.vo.Answer;
import com.secuve.agentInfo.vo.Question;
import com.secuve.agentInfo.vo.UserAlarms;

@Service
public class QuestionAnswerService {
	@Autowired QuestionAnswerDao questionAnswerDao;
	@Autowired EmployeeDao employeeDao;

	public List<Question> getQuestionAnswerList(Question search) {
		return questionAnswerDao.getQuestionAnswerList(search);
	}

	public int getQuestionAnswerListCount(Question search) {
		return questionAnswerDao.getQuestionAnswerListCount(search);
	}

	public String insertQuestion(Question question) {
		if(question.getQuestionTitle() == null || question.getQuestionTitle() == "") {
			return "NotTitle";
		}
		if(question.getQuestionDetail() == null || question.getQuestionDetail() == "") {
			return "NotDetail";
		}
		
		int success = questionAnswerDao.insertQuestion(question);
		if (success <= 0)
			return "FALSE";
		return "OK";
	}

	public Question getQuestionOne(int questionKeyNum) {
		return questionAnswerDao.getQuestionOne(questionKeyNum);
	}

	public void questionAnswerCountPlus(int questionKeyNum) {
		questionAnswerDao.questionAnswerCountPlus(questionKeyNum);
	}

	public Map<String, String> insertAnswer(Answer answer) {
		questionAnswerDao.deleteAnswer(answer);
		Map<String, String> map = new HashMap<String, String>();
		int success = questionAnswerDao.insertAnswer(answer);
		if (success <= 0)
			map.put("result", "FALSE") ;
		questionAnswerDao.updateQuestionState(answer);
		
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Question question = questionAnswerDao.getQuestionOne(answer.getQuestionKeyNum());
		UserAlarms userAlarms = new UserAlarms();
		userAlarms.setUserAlarmsParameter(question.getQuestionKeyNum());
		userAlarms.setUserAlarmsEmployeeId(question.getEmployeeId());
		userAlarms.setUserAlarmsTitle(question.getQuestionTitle());
		userAlarms.setUserAlarmsDate(formatter.format(now));
		userAlarms.setUserAlarmsRegistrant(answer.getAnswerRegistrant());
		userAlarms.setUserAlarmsRegistrationDate(answer.getAnswerRegistrationDate());
		userAlarms.setUserAlarmsURL("/AgentInfo/question/view");
		
		employeeDao.delUserAlarms(answer.getQuestionKeyNum());
		employeeDao.setUserAlarms(userAlarms);
		
		map.put("employeeName", employeeDao.getEmployeeOne(answer.getEmployeeId()).getEmployeeName());
		map.put("answerDate", answer.getAnswerDate());
		map.put("result", "OK");
		map.put("detail", answer.getAnswerDetail());
		return map;
	}

	public Answer getAnswerOne(int questionKeyNum) {
		return questionAnswerDao.getAnswerOne(questionKeyNum);
	}

	public String deleteQuestion(Question question) {
		int success = questionAnswerDao.deleteQuestion(question);
		if (success <= 0)
			return "FALSE";
		return "OK";
	}

	public Map<String, String> updateQuestion(Question question) {
		Map<String, String> map = new HashMap<String, String>();
		if(questionAnswerDao.getAnswerOne(question.getQuestionKeyNum()) == null) {
			question.setQuestionState("답변 대기");
		} else {
			question.setQuestionState("재 답변 요청");
		}
		int success = questionAnswerDao.updateQuestion(question);
		if (success <= 0)
			map.put("result", "FALSE") ;
		map.put("result", "OK");
		map.put("detail", question.getQuestionDetail());
		return map;
	}

	public void updateUserAlarms(Question question, String employeeId) {
		if(question.getEmployeeId().equals(employeeId)) {
			Date now = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			UserAlarms userAlarms = new UserAlarms();
			userAlarms.setUserAlarmsEmployeeId(employeeId);
			userAlarms.setUserAlarmsModifier(employeeId);
			userAlarms.setUserAlarmsModifiedDate(formatter.format(now));
			userAlarms.setUserAlarmsParameter(question.getQuestionKeyNum());
			employeeDao.updateUserAlarms(userAlarms);
		}
	}

	public List<Question> getQuestionAnswerAlarm() {
		return questionAnswerDao.getQuestionAnswerAlarm();
	}

}
