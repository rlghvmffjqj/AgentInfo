package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.QuestionAnswerDao;
import com.secuve.agentInfo.vo.QuestionAnswer;

@Service
public class QuestionAnswerService {
	@Autowired QuestionAnswerDao questionAnswerDao;

	public List<QuestionAnswer> getQuestionAnswerList(QuestionAnswer search) {
		return questionAnswerDao.getQuestionAnswerList(search);
	}

	public int getQuestionAnswerListCount(QuestionAnswer search) {
		return questionAnswerDao.getQuestionAnswerListCount(search);
	}

	public String insertQuestionAnswer(QuestionAnswer questionAnswer) {
		if(questionAnswer.getQuestionAnswerTitle() == null) {
			return "NotTitle";
		}
		if(questionAnswer.getQuestionAnswerDetail() == null) {
			return "NotDetail";
		}
		
		int sucess = questionAnswerDao.insertQuestionAnswer(questionAnswer);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

}
