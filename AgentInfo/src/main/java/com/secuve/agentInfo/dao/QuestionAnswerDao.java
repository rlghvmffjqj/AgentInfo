package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Answer;
import com.secuve.agentInfo.vo.Question;

@Repository
public class QuestionAnswerDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Question> getQuestionAnswerList(Question search) {
		return sqlSession.selectList("questionAnswer.getQuestionAnswerList", search);
	}

	public int getQuestionAnswerListCount(Question search) {
		return sqlSession.selectOne("questionAnswer.getQuestionAnswerListCount", search);
	}

	public int insertQuestion(Question question) {
		return sqlSession.insert("questionAnswer.insertQuestion", question);
	}

	public Question getQuestionOne(int questionKeyNum) {
		return sqlSession.selectOne("questionAnswer.getQuestionOne", questionKeyNum);
	}

	public void questionAnswerCountPlus(int questionAnswerKeyNum) {
		sqlSession.update("questionAnswer.questionAnswerCountPlus", questionAnswerKeyNum);
	}

	public int insertAnswer(Answer answer) {
		return sqlSession.insert("questionAnswer.insertAnswer", answer);
	}

	public Answer getAnswerOne(int questionKeyNum) {
		return sqlSession.selectOne("questionAnswer.getAnswerOne", questionKeyNum);
	}

	public void deleteAnswer(Answer answer) {
		sqlSession.delete("questionAnswer.deleteAnswer", answer);
		
	}

	public void updateQuestionState(Answer answer) {
		sqlSession.update("questionAnswer.updateQuestionState", answer);
	}

}
