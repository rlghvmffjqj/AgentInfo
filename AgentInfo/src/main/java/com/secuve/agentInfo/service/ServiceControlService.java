package com.secuve.agentInfo.service;

import java.security.Principal;
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
import com.secuve.agentInfo.dao.ServiceControlDao;
import com.secuve.agentInfo.vo.ServiceControl;

@Service
public class ServiceControlService {
	@Autowired ServiceControlDao serviceControlDao;

	public String serviceControlInsert(ServiceControl serviceControl) {
		return insertSync(serviceControl);
	}
	
	public String insertSync(ServiceControl serviceControl) {
		String url = "http://"+serviceControl.getServiceControlIp()+":8081/serviceControlAgent";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("serviceControlPurpose", serviceControl.getServiceControlPurpose())
        		.queryParam("serviceControlIp", serviceControl.getServiceControlIp())
        		.queryParam("serviceControlServicePath", serviceControl.getServiceControlServicePath())
        		.queryParam("serviceControlTomcatPath", serviceControl.getServiceControlTomcatPath())
        		.queryParam("serviceControlDbType", serviceControl.getServiceControlDbType())
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
        
        return jsonInString;
	}

	public List<ServiceControl> getServiceControlList(ServiceControl search) {
		return serviceControlDao.getServiceControlList(serviceControlSearch(search));
	}

	public int getServiceControlListCount(ServiceControl search) {
		return serviceControlDao.getServiceControlListCount(serviceControlSearch(search));
	}
	
	public ServiceControl serviceControlSearch(ServiceControl search) {
		search.setServiceControlPurposeArr(search.getServiceControlPurposeSearch().split(","));
		search.setServiceControlIpArr(search.getServiceControlIpSearch().split(","));
		return search;
	}

	public String delServiceControl(int[] chkList, Principal principal) {
		for (int serviceControlKeyNum : chkList) {
			int sucess = serviceControlDao.delServiceControl(serviceControlKeyNum);
			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	public ServiceControl getServiceControlOne(String serviceControlIp) {
		return serviceControlDao.getServiceControlOne(serviceControlIp);
	}

	public String serviceControlSynchronization() {
		List<ServiceControl> serviceControlList = serviceControlDao.serviceControlAll();
		serviceControlDao.delServiceControlAll();
		try {
			for(ServiceControl serviceControl : serviceControlList) {
				insertSync(serviceControl);
			}
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

}
