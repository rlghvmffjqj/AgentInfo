package com.secuve.agentInfo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.QuestionAnswerDao;
import com.secuve.agentInfo.vo.Answer;
import com.secuve.agentInfo.vo.Question;

@Service
public class QuestionAnswerService {
	@Autowired QuestionAnswerDao questionAnswerDao;

	public List<Question> getQuestionAnswerList(Question search) {
		return questionAnswerDao.getQuestionAnswerList(search);
	}

	public int getQuestionAnswerListCount(Question search) {
		return questionAnswerDao.getQuestionAnswerListCount(search);
	}

	public String insertQuestion(Question question) {
		if(question.getQuestionTitle() == null) {
			return "NotTitle";
		}
		if(question.getQuestionDetail() == null) {
			return "NotDetail";
		}
		
		int sucess = questionAnswerDao.insertQuestion(question);
		if (sucess <= 0)
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
		int sucess = questionAnswerDao.insertAnswer(answer);
		if (sucess <= 0)
			map.put("result", "FALSE") ;
		questionAnswerDao.updateQuestionState(answer);
		map.put("result", "OK");
		map.put("detail", answer.getAnswerDetail());
		return map;
	}

	public Answer getAnswerOne(int questionKeyNum) {
		return questionAnswerDao.getAnswerOne(questionKeyNum);
	}

}
