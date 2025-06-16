package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.ResultsReport;

@Repository
public class ResultsReportDao {
	@Autowired SqlSessionTemplate sqlSession;
	
	private Map<String, Object> createParameterMap(Object... keyValues) {
        Map<String, Object> parameters = new HashMap<>();
        for (int i = 0; i < keyValues.length; i += 2) {
            parameters.put((String) keyValues[i], keyValues[i + 1]);
        }
        return parameters;
    }

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

	public int delResultsReport(int resultsReportKeyNum, String resultsreportDelNote) {
		Map<String, Object> parameters = createParameterMap(
			    "resultsReportKeyNum", resultsReportKeyNum,
			    "resultsreportDelNote", resultsreportDelNote
			);
		return sqlSession.update("resultsReport.delResultsReport", parameters);
	}

	public Integer resultsReportTemplateKeyNum() {
		return sqlSession.selectOne("resultsReport.resultsReportTemplateKeyNum");
	}

	public List<ResultsReport> getResultsReportTemplatList() {
		return sqlSession.selectList("resultsReport.getResultsReportTemplatList");
	}

}
