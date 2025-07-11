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


	public Map<String, Object> insertResultsReport(ResultsReport resultsReport) {
		Map<String, Object> map = new HashMap<>();
		String resultsReportKeyNumStr = resultsReport.getResultsReportNumber().substring(resultsReport.getResultsReportNumber().length() - 4);
		resultsReport.setResultsReportKeyNum(Integer.parseInt(resultsReportKeyNumStr));
		
		int success = 1;
		resultsReportDao.insertResultsReport(resultsReport);
		map.put("result", success <= 0 ? "FALSE" : "OK");
		if (success > 0) {
	        map.put("resultsReportKeyNum", resultsReport.getResultsReportKeyNum());
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

	public ResultsReport getResultsReportOne(int resultsReportKeyNum) {
		return resultsReportDao.getResultsReportOne(resultsReportKeyNum);
	}

	public String updateResultsReport(ResultsReport resultsReport) {
		int success = 1;
		resultsReportDao.updateResultsReport(resultsReport);
		return success <= 0 ? "FALSE" : "OK";
	}

	public String delResultsReport(int[] chkList, String resultsreportDelNote) {
		for (int resultsReportKeyNum : chkList) {
			ResultsReport resultsReport = resultsReportDao.getResultsReportOne(resultsReportKeyNum);
			if("del".equals(resultsReport.getResultsReportTemplate())) {
				return "NOTDELETE";
			}
			int resultsReportDelKeyNumMax = resultsReportDao.resultsReportDelKeyNumMax();
			if(resultsReportDelKeyNumMax > 9000) {
				resultsReport.setResultsreportDelKeyNum(resultsReportDao.resultsReportDelKeyNumMax() + 1);
			} else {
				resultsReport.setResultsreportDelKeyNum(resultsReportDao.resultsReportDelKeyNumMax() + 9000 + 1);
			}
			
			resultsReport.setResultsreportDelNote(resultsreportDelNote);
			// 문자열을 "-"로 분리
	        String[] parts = resultsReport.getResultsReportNumber().split("-");

	        // 안전하게 분리됐는지 확인
	        if (parts.length == 3) {
	        	resultsReport.setResultsReportNumber(parts[0] + "-" + parts[1] + "-Del-" + parts[2]);
	        } else if(parts.length == 4) {
	        	resultsReport.setResultsReportNumber(parts[0] + "-" + parts[1] + "-" + parts[2] + "-Del-" + parts[3]);
	        } else {
	            System.out.println("형식이 잘못되었습니다.");
	            return "FALSE";
	        }
			int success = resultsReportDao.delResultsReport(resultsReport);
			if (success <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public String resultsReportTemplateKeyNum() {
		int resultsReportKeyNumMax = 1;
		try {
			resultsReportKeyNumMax = resultsReportDao.resultsReportTemplateKeyNum();
		} catch (Exception e) {
		}
		String formatted = String.format("%02d", resultsReportKeyNumMax+1);

		return "Template-"+formatted;
	}

	public List<ResultsReport> getResultsReportTemplatList() {
		return resultsReportDao.getResultsReportTemplatList();
	}

	public List<String> getSelectInput(String selectInput) {
		return resultsReportDao.getSelectInput(selectInput);
	}

}
