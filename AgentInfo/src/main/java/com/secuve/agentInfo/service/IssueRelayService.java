package com.secuve.agentInfo.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.IssueRelayDao;
import com.secuve.agentInfo.vo.IssueRelay;

@Service
public class IssueRelayService {
	@Autowired IssueRelayDao issueRelayDao;
	
	public static String createKey() {
	    StringBuffer key = new StringBuffer();
	    Random rnd = new Random();
	
	    for (int i = 0; i < 8; i++) { // 인증코드 8자리
	        int index = rnd.nextInt(3); // 0~2 까지 랜덤
	
	        switch (index) {
	            case 0:
	                key.append((char) ((int) (rnd.nextInt(26)) + 97));
	                //  a~z  (ex. 1+97=98 => (char)98 = 'b')
	                break;
	            case 1:
	                key.append((char) ((int) (rnd.nextInt(26)) + 65));
	                //  A~Z
	                break;
	            case 2:
	                key.append((rnd.nextInt(10)));
	                // 0~9
	                break;
	        }
	    }
	    return key.toString();
	}

	public void insertIssueRelay(IssueRelay issueRelay) {
		issueRelayDao.insertIssueRelay(issueRelay);
	}

	public IssueRelay getIssueRelayUrlOne(String issueRelayRandomUrl) {
		return issueRelayDao.getIssueRelayUrlOne(issueRelayRandomUrl);
	}
}
