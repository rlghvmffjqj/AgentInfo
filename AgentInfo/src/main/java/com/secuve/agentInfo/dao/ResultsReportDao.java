package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.ResultsReport;

@Repository
public class ResultsReportDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<ResultsReport> getResultsReportList(ResultsReport search) {
		return sqlSession.selectList("resultsReport.getResultsReport", search);
	}

	public int getResultsReportListCount(ResultsReport search) {
		return sqlSession.selectOne("resultsReport.getResultsReportCount", search);
	}

	public int insertResultsReport(ResultsReport resultsReport) {
		return sqlSession.insert("resultsReport.insertResultsReport", resultsReport);
	}

	public int resultsReportKeyNumMax() {
		return sqlSession.selectOne("resultsReport.resultsReportKeyNumMax");
	}

	public ResultsReport getResultsReportOne(int resultsReportKeyNum) {
		return sqlSession.selectOne("resultsReport.getResultsReportOne", resultsReportKeyNum);
	}

	public int updateResultsReport(ResultsReport resultsReport) {
		return sqlSession.update("resultsReport.updateResultsReport", resultsReport);
	}

	public int delResultsReport(ResultsReport resultsReport) {
		return sqlSession.update("resultsReport.delResultsReport", resultsReport);
	}

	public Integer resultsReportTemplateKeyNum() {
		return sqlSession.selectOne("resultsReport.resultsReportTemplateKeyNum");
	}

	public List<ResultsReport> getResultsReportTemplatList() {
		return sqlSession.selectList("resultsReport.getResultsReportTemplatList");
	}

	public List<String> getSelectInput(String selectInput) {
		return sqlSession.selectList("resultsReport.getSelectInput", selectInput);
	}

	public int resultsReportDelKeyNumMax() {
		return sqlSession.selectOne("resultsReport.resultsReportDelKeyNumMax");
	}

}
