package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import com.secuve.agentInfo.AgentInfoApplication;
import com.secuve.agentInfo.dao.License5Dao;
import com.secuve.agentInfo.vo.License5;

@Service
public class License5Service {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	@Autowired License5Dao license5Dao;

	public List<License5> getLicenseList(License5 search) {
		return license5Dao.getLicenseList(licenseSearch(search));
	}

	public int getLicenseListCount(License5 search) {
		return license5Dao.getLicenseListCount(licenseSearch(search));
	}
	
	public License5 licenseSearch(License5 search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setRequesterArr(search.getRequester().split(","));;
		search.setProductTypeArr(search.getProductType().split(","));
		search.setAdditionalInformationArr(search.getAdditionalInformation().split(","));
		search.setMacAddressArr(search.getMacAddress().split(","));
		search.setManagerOsTypeArr(search.getManagerOsType().split(","));
		search.setManagerDbmsTypeArr(search.getManagerDbmsType().split(","));
		search.setProductVersionArr(search.getProductVersion().split(","));
		search.setLicenseFilePathArr(search.getLicenseFilePath().split(","));
		search.setSerialNumberArr(search.getSerialNumber().split(","));
		search.setCountryArr(search.getCountry().split(","));
		
		return search;
	}
	
	public List<String> getSelectInput(String selectInput) {
		return license5Dao.getSelectInput(selectInput);
	}

	public License5 insertLicenseView(Integer licenseKeyNum) {
		License5 license = new License5();
		if(licenseKeyNum != null) {
			license = license5Dao.getLicenseOne(licenseKeyNum);
		}
		return license;
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
	
	public String linuxIssuedLicense50(License5 license, Principal principal) {
		String resault = null;
		String answer = "";
		String route = license5Dao.getRoute("linuxLicense50Route", principal.getName());
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		try {
			resault = LinuxLicenseIssued50(route);
		} catch (Exception e) {
			return "NOTCONNECT";
		}
		
		if(!answer.equals("FALSE")) {
			int sucess = license5Dao.issuedLicense(license);
		
			// 로그 기록
			if (sucess <= 0) {
				LOGGER.debug("리눅스 라이센스 5.0 발급 INSERT ERROR");
				return "FALSE";
			}
		} else {
			LOGGER.debug("리눅스 라이센스 5.0 발급 ERROR");
			return "FALSE";
		}
		return answer;
	}
	
	public String LinuxLicenseIssued50(String route) {
		String url = "http://172.16.50.182:8080/linuxLicenseIssued50";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("route", route)
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
	
}

