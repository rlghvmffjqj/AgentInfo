package com.secuve.agentInfo.service;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.FontProgram;
import com.itextpdf.io.font.FontProgramFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.IBlockElement;
import com.itextpdf.layout.element.IElement;
import com.itextpdf.layout.font.FontProvider;
import com.secuve.agentInfo.dao.IssueDao;
import com.secuve.agentInfo.vo.Issue;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IssueService {
	@Autowired IssueDao issueDao;
	
	public void makepdf(String BODY, String dest) throws IOException {
		//한국어를 표시하기 위해 폰트 적용 
	    String FONT = "C:\\AgentInfo\\font\\NanumBarunGothic.ttf";
	    //ConverterProperties : htmlconverter의 property를 지정하는 메소드인듯
	    ConverterProperties properties = new ConverterProperties();
	    FontProvider fontProvider = new DefaultFontProvider(false, false, false);
	    FontProgram fontProgram = FontProgramFactory.createFont(FONT);
	    fontProvider.addFont(fontProgram);
	    properties.setFontProvider(fontProvider);

		//pdf 페이지 크기를 조정
		List<IElement> elements = HtmlConverter.convertToElements(BODY, properties);
	    PdfDocument pdf = new PdfDocument(new PdfWriter(dest));
	    Document document = new Document(pdf);
	    	//setMargins 매개변수순서 : 상, 우, 하, 좌
	        document.setMargins(50, 20, 50, 20);
	        for (IElement element : elements) {
	            document.add((IBlockElement) element);
	        }
	        document.close();
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public Map insertIssue(Issue issue, Principal principal) {
		Map map = new HashMap();
		issue.setIssueKeyNum(IssueKeyNum(issue.getIssueKeyNum()));
		map.put("issueKeyNum", issue.getIssueKeyNum());
		
		int sucess = 1;
		issue = oneDate(issue);
		for(int i=0; i < issue.getIssueOsList().size(); i++) {
			sucess *= issueDao.insertIssue(issue.getIssueKeyNum(), issue.getIssueCustomer(), issue.getIssueTitle(), issue.getIssueDate(), issue.getIssueTosms(), issue.getIssueTosrf(), issue.getIssuePortal(), issue.getIssueJava(), issue.getIssueWas(), issue.getTotal(), issue.getSolution(), issue.getUnresolved(), issue.getHold(), issue.getIssueDivisionList().get(i), issue.getIssueOsList().get(i), issue.getIssueAwardList().get(i), issue.getIssueMiddleList().get(i), issue.getIssueUnder1List().get(i), issue.getIssueUnder2List().get(i), issue.getIssueUnder3List().get(i), issue.getIssueUnder4List().get(i), issue.getIssueFlawNumList().get(i), issue.getIssueEffectList().get(i), issue.getIssueTextResultList().get(i), issue.getIssueApplyYnList().get(i), issue.getIssueConfirmList().get(i), issue.getIssueObstacleList().get(i), issue.getIssueNoteList().get(i), issue.getIssueRegistrant(), issue.getIssueRegistrationDate(), issue.getIssueModifier(), issue.getIssueModifiedDate());
		}
		if (sucess <= 0) {
			map.put("result", "FALSE");
		} else {
			map.put("result", "OK");
			map.put("issueKeyNum", issue.getIssueKeyNum());
		}
		return map;
	}
	
	public Issue oneDate(Issue issue) {
		List<String> list = new ArrayList<String>();
		list.add("");
		if(issue.getIssueDivisionList().size() == 0) 
			issue.setIssueDivisionList(list);
		if(issue.getIssueOsList().size() == 0) 
			issue.setIssueOsList(list);
		if(issue.getIssueAwardList().size() == 0) 
			issue.setIssueAwardList(list);
		if(issue.getIssueMiddleList().size() == 0) 
			issue.setIssueMiddleList(list);
		if(issue.getIssueUnder1List().size() == 0) 
			issue.setIssueUnder1List(list);
		if(issue.getIssueUnder2List().size() == 0) 
			issue.setIssueUnder2List(list);
		if(issue.getIssueUnder3List().size() == 0) 
			issue.setIssueUnder3List(list);
		if(issue.getIssueUnder4List().size() == 0) 
			issue.setIssueUnder4List(list);
		if(issue.getIssueFlawNumList().size() == 0) 
			issue.setIssueFlawNumList(list);
		if(issue.getIssueEffectList().size() == 0) 
			issue.setIssueEffectList(list);
		if(issue.getIssueTextResultList().size() == 0) 
			issue.setIssueTextResultList(list);
		if(issue.getIssueApplyYnList().size() == 0) 
			issue.setIssueApplyYnList(list);
		if(issue.getIssueConfirmList().size() == 0) 
			issue.setIssueConfirmList(list);
		if(issue.getIssueObstacleList().size() == 0) 
			issue.setIssueObstacleList(list);
		if(issue.getIssueNoteList().size() == 0) 
			issue.setIssueNoteList(list);
		
		return issue;
	}
	
	public List<Issue> getIssueList(Issue search) {
		return issueDao.getIssueList(issueSearch(search));
	}

	public int getIssueListCount(Issue search) {
		return issueDao.getIssueListCount(issueSearch(search));
	}
	
	public Issue issueSearch(Issue search) {
		search.setIssueCustomerArr(search.getIssueCustomer().split(","));
		search.setIssueTitleArr(search.getIssueTitle().split(","));
		search.setIssueTosmsArr(search.getIssueTosms().split(","));
		search.setIssueTosrfArr(search.getIssueTosrf().split(","));
		search.setIssuePortalArr(search.getIssuePortal().split(","));
		search.setIssueJavaArr(search.getIssueJava().split(","));
		search.setIssueWasArr(search.getIssueWas().split(","));
		
		return search;
	}
	
	public int IssueKeyNum(int issueKeyNum) {
		if(issueKeyNum == 0) {
			issueKeyNum = 1;
		} else {
			return issueKeyNum;
		}
		try {
			issueKeyNum = issueDao.getIssueKeyNum();
		} catch (Exception e) {
			return issueKeyNum;
		}
		return ++issueKeyNum;
	}

	public List<String> getSelectInput(String selectInput) {
		return issueDao.getSelectInput(selectInput);
	}

	public List<Issue> getIssueOne(int issueKeyNum) {
		return issueDao.getIssueOne(issueKeyNum);
	}

	public Issue getIssueOneTitle(int issueKeyNum) {
		return issueDao.getIssueOneTitle(issueKeyNum);
	}

	public String delIssue(int[] chkList) {
		for (int issueKeyNum : chkList) {
			int sucess = issueDao.delIssue(issueKeyNum);

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}


	public Map updateIssue(Issue issue, Principal principal) {
		Map map = new HashMap();
		int count = issueDao.delIssue(issue.getIssueKeyNum());
		if(count == 0 && issue.getIssueKeyNum() != 0) {
			map.put("result", "FALSE");
			return map;
		}
		return insertIssue(issue, principal);
	}

	public Map copyIssue(Issue issue, Principal principal) {
		issue.setIssueKeyNum(0);
		return insertIssue(issue, principal);
	}
}
