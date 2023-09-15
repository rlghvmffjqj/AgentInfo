package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.QuestionAnswer;

@Repository
public class QuestionAnswerDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<QuestionAnswer> getQuestionAnswerList(QuestionAnswer search) {
		return sqlSession.selectList("questionAnswer.getQuestionAnswerList", search);
	}

	public int getQuestionAnswerListCount(QuestionAnswer search) {
		return sqlSession.selectOne("questionAnswer.getQuestionAnswerListCount", search);
	}

	public int insertQuestionAnswer(QuestionAnswer questionAnswer) {
		return sqlSession.insert("questionAnswer.insertQuestionAnswer", questionAnswer);
	}

}
