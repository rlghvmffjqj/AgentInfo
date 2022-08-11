package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.dao.LicenseDao;
import com.secuve.agentInfo.vo.License;

@Service
public class LicenseService {
	@Autowired LicenseDao licenseDao;
	@Autowired LicenseUidLogService licenseUidLogService;

	public List<License> getLicenseList(License search) {
		return licenseDao.getLicenseList(licenseSearch(search));
	}

	public int getLicenseListCount(License search) {
		return licenseDao.getLicenseListCount(licenseSearch(search));
	}

	public List<String> getSelectInput(String selectInput) {
		return licenseDao.getSelectInput(selectInput);
	}
	
	public License licenseSearch(License search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setRequesterArr(search.getRequester().split(","));;
		search.setPartnersArr(search.getPartners().split(","));
		search.setOsTypeArr(search.getOsType().split(","));
		search.setOsVersionArr(search.getOsVersion().split(","));
		search.setTosVersionArr(search.getTosVersion().split(","));
		search.setMacUmlHostIdArr(search.getMacUmlHostId().split(","));
		search.setReleaseTypeArr(search.getReleaseType().split(","));
		search.setDeliveryMethodArr(search.getDeliveryMethod().split(","));
		
		return search;
	}

	public String getLicenseIssueKey(int licenseKeyNum) {
		String result;
		try {
			result = licenseDao.getLicenseIssueKey(licenseKeyNum);
			if(result == "" || result.equals("")) {
				return "FALSE";
			}
		} catch (Exception e) {
			return "FALSE";
		}
		return result;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String linuxIssuedLicense(License license, Principal principal) {
		String resault = null;
		String answer = "";
		resault = LinuxLicenseIssued(license.getOsTypeView()+" "+license.getOsVersionView()+" "+license.getKernelVersionView(), license.getPeriodView()+" "+license.getMacUmlHostIdView());
		// 대괄호 외 대괄호 제거
		for(int i=1; i<resault.length()-1; i++) {
			answer += resault.charAt(i);
		}
		// 라이센스 발급 후 메시지에서 불필요 내용 제거
		try {
			answer = answer.substring(32);
		} catch (Exception e) {
			return "FALSE";
		}
		
		if(!answer.equals("FALSE")) {
			license.setLicenseKeyNum(LicenseKeyNum());
			license.setLicenseIssueKey(answer);
			int sucess = licenseDao.issuedLicense(license);
		
			// 로그 기록
			if (sucess > 0) {
				licenseUidLogService.insertLicenseUidLog(license, principal, "INSERT");
			} else {
				return "FALSE";
			}
		} else {
			return "FALSE";
		}
		return answer;
	}
	
	public String LinuxLicenseIssued(String firstStr, String lastStr) {
		String url = "http://172.16.50.182:8080/linuxLicenseIssued";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("firstStr", firstStr)
        		.queryParam("lastStr", lastStr)
        		.build();

        ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
        ObjectMapper mapper = new ObjectMapper();
        try {
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        System.out.println(jsonInString);
        return jsonInString;
	}
	
	public int windowIssuedLicense(License license, Principal principal) {
		Runtime rt = Runtime.getRuntime();
		
		String file = "C:\\vnc-viewer.exe";
		Process pro;
		try {
			pro = rt.exec(file);
			pro.waitFor();
		} catch (Exception e) {
			e.printStackTrace();
		}
		license.setLicenseKeyNum(LicenseKeyNum());
		license.setLicenseIssueKey("none");
		int sucess = licenseDao.issuedLicense(license);
		// 로그 기록
		if (sucess > 0) {
			return license.getLicenseKeyNum();
		} else {
			return 0;
		}
	}
	
	public int LicenseKeyNum() {
		int licenseKeyNum = 0;
		try {
			licenseKeyNum = licenseDao.getLicenseKeyNum();
		} catch (Exception e) {
			return licenseKeyNum;
		}
		return ++licenseKeyNum;
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int licenseKeyNum : chkList) {
			License license = licenseDao.getLicenseOne(licenseKeyNum);
			int sucess = licenseDao.delLicense(licenseKeyNum);

			// 로그 기록
			if (sucess > 0) {
				licenseUidLogService.insertLicenseUidLog(license, principal, "DELETE");
			}

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public String saveLicenseKey(String licenseIssueKey, int licenseKeyNum, int licenseUidLogKeyNum) {
		int sucess = licenseDao.saveLicenseKey(licenseIssueKey, licenseKeyNum);
		if(sucess <= 0) {
			return "FALSE";
		} 
		licenseUidLogService.saveUidLogLicenseKey(licenseIssueKey, licenseUidLogKeyNum);
		return "OK";
	}

	public int licenseUidLog(License license, Principal principal, int licenseKeyNum) {
		if(licenseKeyNum > 0) {
			int licenseUidLogKeyNum = licenseUidLogService.insertLicenseUidLog(license, principal, "INSERT");
			return licenseUidLogKeyNum;
		}
		return 0;
	}
	
}
