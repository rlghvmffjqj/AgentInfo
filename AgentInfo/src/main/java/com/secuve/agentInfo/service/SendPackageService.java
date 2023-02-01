package com.secuve.agentInfo.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.SendPackageDao;
import com.secuve.agentInfo.vo.SendPackage;

@Service
public class SendPackageService {
	@Autowired SendPackageDao sendPackageDao;
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	public void fileDownload(SendPackage sendPackage, MultipartFile sendPackageView) throws IllegalStateException, IOException {
		File newFileName = new File(filePath + File.separator + "sendPackage",sendPackage.getSendPackageNameView()+"_"+sendPackage.getSendPackageRandomUrl());
		sendPackageView.transferTo(newFileName);
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy년MM월dd일_HH시mm분ss초");
		return formatter.format(now);
	}

	public String insertSendPackage(SendPackage sendPackage, MultipartFile sendPackageView) throws IllegalStateException, IOException {
		sendPackage.setSendPackageNameView(sendPackageView.getOriginalFilename());
		if(sendPackage.getSendPackageStartDateView().length() > 10) {
			sendPackage.setSendPackageStartDateView(sendPackage.getSendPackageStartDateView().replaceAll("/", "-").substring(0,13));
		}
		if(sendPackage.getSendPackageEndDateView().length() > 10) {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView().replaceAll("/", "-").substring(0,13));
		} else {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView() + " 24");
		}
		while(true) {
			sendPackage.setSendPackageRandomUrl(createKey());
			int count = sendPackageDao.getRandomUrlCheck(sendPackage.getSendPackageRandomUrl());
			if(count == 0) {
				break;
			}
		}
		int sucess = sendPackageDao.insertSendPackage(sendPackage);
		if (sucess <= 0)
			return "FALSE";
		fileDownload(sendPackage, sendPackageView);
		return "OK";
	}
	
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

	public List<SendPackage> getSendPackage(SendPackage search) {
		return sendPackageDao.getSendPackage(sendPackageSearch(search));
	}

	public int getSendPackageCount(SendPackage search) {
		return sendPackageDao.getSendPackageCount(sendPackageSearch(search));
	}

	public void downloadCount(String sendPackageName, String sendPackageRandomUrl) {
		sendPackageDao.downloadCount(sendPackageName, sendPackageRandomUrl);
		int count = sendPackageDao.downloadLimitCount(sendPackageName, sendPackageRandomUrl);
		if(count < 1) {
			//fileDelete(sendPackageName);
			//sendPackageDao.deleteSendPackageCountOver(sendPackageName, sendPackageRandomUrl);
			sendPackageDao.updateSendPackageFlag(sendPackageName, sendPackageRandomUrl);
		}
	}
	
	public SendPackage sendPackageSearch(SendPackage search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setManagementServerArr(search.getManagementServer().split(","));
		
		return search;
	}
	
	public String fileDelete(String sendPackageName) {
		//파일 경로 지정
		String path = "C:\\AgentInfo\\sendPackage";
				
		//현재 게시판에 존재하는 파일객체를 만듬
		File file = new File(path + "\\" + sendPackageName);
			
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 파일 삭제
			return "OK"; 
		}
		return "NotFile";
	}

	public String deleteSendPackage(int[] chkList) {
		for(int sendPackageKeyNum: chkList) {
			//int sucess = sendPackageDao.updateSendPackageFlagKey(sendPackageKeyNum);
			SendPackage sendPackage = sendPackageDao.getSendPackageOne(sendPackageKeyNum);
			fileDelete(sendPackage.getSendPackageName()+"_"+sendPackage.getSendPackageRandomUrl());
			int sucess = sendPackageDao.deleteSendPackage(sendPackageKeyNum);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public List<SendPackage> getSendPackageListOne(String sendPackageRandomUrl) {
		return sendPackageDao.getSendPackageListOne(sendPackageRandomUrl);
	}

	public SendPackage getSendPackageOne(int sendPackageKeyNum) {
		return sendPackageDao.getSendPackageOne(sendPackageKeyNum);
	}

	public String updateSendPackage(SendPackage sendPackage)  {
		int sucess = 0;
		if(sendPackage.getSendPackageStartDateView().length() > 10) {
			sendPackage.setSendPackageStartDateView(sendPackage.getSendPackageStartDateView().replaceAll("/", "-").substring(0,13));
		}
		if(sendPackage.getSendPackageEndDateView().length() > 10) {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView().replaceAll("/", "-").substring(0,13));
		}
		for(String sendPackageKeyNum : sendPackage.getSendPackageKeyNumList().split(",")) {
			sendPackage.setSendPackageKeyNum(Integer.parseInt(sendPackageKeyNum));
			sucess = sendPackageDao.updateSendPackage(sendPackage);
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public void deleteSendPackageSchedule() {
		ArrayList<SendPackage> sendPackageList = new ArrayList<>(sendPackageDao.deleteSendPackageScheduleList());
		for (SendPackage sendPackage : sendPackageList) {
			fileDelete(sendPackage.getSendPackageName()+"_"+sendPackage.getSendPackageRandomUrl());
		}
		sendPackageDao.deleteSendPackageSchedule();
		
	}

	public void expirationSendPackageSchedule() {
		sendPackageDao.expirationSendPackageSchedule();
	}

	public void copySendPackage(SendPackage sendPackage, MultipartFile sendPackageView) throws IllegalStateException, IOException {
		sendPackage.setSendPackageNameView(sendPackageView.getOriginalFilename());
		if(sendPackage.getSendPackageStartDateView().length() > 10) {
			sendPackage.setSendPackageStartDateView(sendPackage.getSendPackageStartDateView().replaceAll("/", "-").substring(0,13));
		}
		if(sendPackage.getSendPackageEndDateView().length() > 10) {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView().replaceAll("/", "-").substring(0,13));
		} else {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView() + " 24");
		}
		sendPackageDao.insertSendPackage(sendPackage);
		fileDownload(sendPackage, sendPackageView);
	}

	public boolean getSendPackageOneUrl(String sendPackageName, String sendPackageRandomUrl) {
		return sendPackageDao.getSendPackageOneUrl(sendPackageName, sendPackageRandomUrl);
	}

	public void updateInfoSendPackage(SendPackage sendPackage) {
		sendPackageDao.updateInfoSendPackage(sendPackage);
	}

	public String insertSendPackageMulti(SendPackage sendPackage, MultipartFile sendPackageView, String sendPackageRandomUrl) throws IllegalStateException, IOException {
		sendPackage.setSendPackageNameView(sendPackageView.getOriginalFilename());
		if(sendPackage.getSendPackageStartDateView().length() > 10) {
			sendPackage.setSendPackageStartDateView(sendPackage.getSendPackageStartDateView().replaceAll("/", "-").substring(0,13));
		}
		if(sendPackage.getSendPackageEndDateView().length() > 10) {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView().replaceAll("/", "-").substring(0,13));
		} else {
			sendPackage.setSendPackageEndDateView(sendPackage.getSendPackageEndDateView() + " 24");
		}
		if(sendPackageRandomUrl == "" || sendPackageRandomUrl == null) {
			while(true) {
				sendPackage.setSendPackageRandomUrl(createKey());
				int count = sendPackageDao.getRandomUrlCheck(sendPackage.getSendPackageRandomUrl());
				if(count == 0) {
					break;
				}
			}
		} else {
			sendPackage.setSendPackageRandomUrl(sendPackageRandomUrl);
		}
		sendPackageDao.insertSendPackage(sendPackage);
		fileDownload(sendPackage, sendPackageView);
		return sendPackage.getSendPackageRandomUrl();
	}

	public void updateDelete(String sendPackageKeyNumList) {
		for(String sendPackageKeyNum: sendPackageKeyNumList.split(",")) {
			//sendPackageDao.updateSendPackageFlagKey(Integer.parseInt(sendPackageKeyNum));
			SendPackage sendPackage = sendPackageDao.getSendPackageOne(Integer.parseInt(sendPackageKeyNum));
			fileDelete(sendPackage.getSendPackageName()+"_"+sendPackage.getSendPackageRandomUrl());
			sendPackageDao.deleteSendPackage(Integer.parseInt(sendPackageKeyNum));
		}
		
	}

}
