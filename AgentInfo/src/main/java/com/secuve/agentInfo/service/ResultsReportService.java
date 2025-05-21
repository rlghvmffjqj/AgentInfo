package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.ResultsReportDao;
import com.secuve.agentInfo.vo.ResultsReport;

@Service
public class ResultsReportService {
	@Autowired ResultsReportDao resultsReportDao;

	public List<ResultsReport> getResultsReportList(ResultsReport search) {
		return resultsReportDao.getResultsReportList(resultsReportSearch(search));
	}

	public int getResultsReportListCount(ResultsReport search) {
		return resultsReportDao.getResultsReportListCount(resultsReportSearch(search));
	}
	
	public ResultsReport resultsReportSearch(ResultsReport search) {
		search.setResultsReportNumberArr(search.getResultsReportNumber().split(","));
		search.setResultsReportCustomerNameArr(search.getResultsReportCustomerName().split(","));;
		
		return search;
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
	
	public String yearDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy");
		return formatter.format(now);
	}


	public Map<String, String> insertResultsReport(ResultsReport resultsReport) {
		Map<String, String> map = new HashMap<>();
		int success = 1;
		resultsReportDao.insertResultsReport(resultsReport);
		map.put("result", success <= 0 ? "FALSE" : "OK");
		if (success > 0) {
	        map.put("resultsReportNumber", resultsReport.getResultsReportNumber());
	    }
		return map;
		
	}

	public String resultsReportKeyNumMax() {
		int resultsReportKeyNumMax = 1;
		try {
			resultsReportKeyNumMax = resultsReportDao.resultsReportKeyNumMax();
		} catch (Exception e) {
		}
		String formatted = String.format("%04d", resultsReportKeyNumMax+1);

		return formatted;
	}

	public ResultsReport getResultsReportOne(String resultsReportNumber) {
		return resultsReportDao.getResultsReportOne(resultsReportNumber);
	}

	public String updateResultsReport(ResultsReport resultsReport) {
		int success = 1;
		resultsReportDao.updateResultsReport(resultsReport);
		return success <= 0 ? "FALSE" : "OK";
	}

	public String delResultsReport(int[] chkList) {
		for (int resultsReportKeyNum : chkList) {
			int success = resultsReportDao.delResultsReport(resultsReportKeyNum);
			if (success <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public String setTemplateAdd(int[] chkList) {
		for (int resultsReportKeyNum : chkList) {
			int success = resultsReportDao.setTemplateAdd(resultsReportKeyNum);
			if (success <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public String setTemplateDel(int[] chkList) {
		for (int resultsReportKeyNum : chkList) {
			int success = resultsReportDao.setTemplateDel(resultsReportKeyNum);
			if (success <= 0)
				return "FALSE";
		}
		return "OK";
	}
}
