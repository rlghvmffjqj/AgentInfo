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

	public ResultsReport getResultsReportOne(String resultsReportNumber) {
		return sqlSession.selectOne("resultsReport.getResultsReportOne", resultsReportNumber);
	}

	public int updateResultsReport(ResultsReport resultsReport) {
		return sqlSession.update("resultsReport.updateResultsReport", resultsReport);
	}

	public int delResultsReport(int resultsReportKeyNum) {
		return sqlSession.delete("resultsReport.delResultsReport", resultsReportKeyNum);
	}

}
