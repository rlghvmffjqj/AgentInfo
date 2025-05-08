package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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


	public String insertResultsReport(ResultsReport resultsReport) {
		int success = 1;
		resultsReportDao.insertResultsReport(resultsReport);
		return success <= 0 ? "FALSE" : "OK";
		
	}

	public String resultsReportKeyNumMax() {
		int resultsReportKeyNumMax = 1;
		try {
			resultsReportKeyNumMax = resultsReportDao.resultsReportKeyNumMax();
		} catch (Exception e) {
		}
		String formatted = String.format("%04d", resultsReportKeyNumMax);

		return formatted;
	}
}
