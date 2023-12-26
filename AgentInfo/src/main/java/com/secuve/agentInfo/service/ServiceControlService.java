package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.dao.ServiceControlDao;
import com.secuve.agentInfo.vo.ServiceControl;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ServiceControlService {
	@Autowired ServiceControlDao serviceControlDao;

	public String serviceControlInsert(ServiceControl serviceControl) {
		if(serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp()) != null) {
			return "duplication";
		}
		serviceControl.setServiceControlScvEAPath(serviceControl.getServiceControlServicePath());
		serviceControl.setServiceControlScvCAPath(serviceControl.getServiceControlServicePath());
		serviceControl.setServiceControlLogServerPath(serviceControl.getServiceControlServicePath());
		String result = removeCharacter(insertSync(serviceControl),'"');
		if (result.equals("OK"))
			result = serviceControlSynchronization();
		return result;
	}
	
	public String removeCharacter(String input, char charToRemove) {
        String regex = Pattern.quote(String.valueOf(charToRemove));
        return input.replaceAll(regex, "");
    }
	
	public String insertSync(ServiceControl serviceControl) {
		String url = "http://"+serviceControl.getServiceControlIp()+":8081/serviceControlAgent";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate(getClientHttpRequestFactory());

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("serviceControlPurpose", serviceControl.getServiceControlPurpose())
        		.queryParam("serviceControlIp", serviceControl.getServiceControlIp())
        		.queryParam("serviceControlScvEAPath", serviceControl.getServiceControlScvEAPath())
        		.queryParam("serviceControlScvCAPath", serviceControl.getServiceControlScvCAPath())
        		.queryParam("serviceControlLogServerPath", serviceControl.getServiceControlLogServerPath())
        		.queryParam("serviceControlTomcatPath", serviceControl.getServiceControlTomcatPath())
        		.queryParam("serviceControlDbType", serviceControl.getServiceControlDbType())
        		.build();
        
        try {
        	ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

	        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
	        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
	        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인
	
	        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
	        ObjectMapper mapper = new ObjectMapper();
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (Exception e) {
			serviceControl.setServiceControlPcPower("off");
			serviceControl.setServiceControlDate(nowDate());
			serviceControl.setServiceControlPort("");
			if(serviceControl.getServiceControlTomcat().equals("execution")) {
				serviceControl.setServiceControlTomcat("notRunning");
			}
			if(serviceControl.getServiceControlLogServer().equals("execution")) {
				serviceControl.setServiceControlLogServer("notRunning");
			}
			if(serviceControl.getServiceControlScvEA().equals("execution")) {
				serviceControl.setServiceControlScvEA("notRunning");
			}
			if(serviceControl.getServiceControlScvCA().equals("execution")) {
				serviceControl.setServiceControlScvCA("notRunning");
			}
			if(serviceControl.getServiceControlDB().equals("execution")) {
				serviceControl.setServiceControlDB("notRunning");
			}
			serviceControlDao.insertServiceControl(serviceControl);
			//e.printStackTrace();
			return "pcOff";
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
		search.setServiceControlPurposeArr(search.getServiceControlPurpose().split(","));
		search.setServiceControlIpArr(search.getServiceControlIp().split(","));
		search.setServiceControlPcPowerArr(search.getServiceControlPcPower().split(","));
		search.setServiceControlTomcatArr(search.getServiceControlTomcat().split(","));
		search.setServiceControlLogServerArr(search.getServiceControlLogServer().split(","));
		search.setServiceControlScvEAArr(search.getServiceControlScvEA().split(","));
		search.setServiceControlScvCAArr(search.getServiceControlScvCA().split(","));
		search.setServiceControlDBArr(search.getServiceControlDB().split(","));
		return search;
	}

	public String delServiceControl(int[] chkList, Principal principal) {
		for (int serviceControlKeyNum : chkList) {
			int sucess = serviceControlDao.delServiceControl(serviceControlKeyNum);
			if (sucess <= 0)
				return "FALSE";
		}
		return serviceControlSynchronization();
 	}

	public String serviceControlSynchronization() {
		List<ServiceControl> serviceControlList = serviceControlDao.serviceControlAll();
		try {
			serviceControlDao.delServiceControlAll();
			for(ServiceControl serviceControl : serviceControlList) {
				insertSync(serviceControl);
			}
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}

	public List<String> getServiceControlValue(String column) {
		return serviceControlDao.getServiceControlValue(column);
	}

	public ServiceControl getServiceControlOne(int serviceControlKeyNum) {
		return serviceControlDao.getServiceControlOne(serviceControlKeyNum);
	}

	public void executionChange(ServiceControl serviceControl) {
		ServiceControl sc = serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp());
		sc.setStatus(serviceControl.getStatus());
		sc.setService(serviceControl.getService());
		changeStatus(sc);
		serviceControl = serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp());
		serviceControlDao.delServiceControlIp(serviceControl.getServiceControlIp());
		insertSync(serviceControl);
	}
	
	public String changeStatus(ServiceControl serviceControl) {
		String url = "http://"+serviceControl.getServiceControlIp()+":8081/serviceControlAgent/executionChange";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate(getClientHttpRequestFactory());

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("service", serviceControl.getService())
        		.queryParam("status", serviceControl.getStatus())
        		.queryParam("serviceControlScvEAPath", serviceControl.getServiceControlScvEAPath())
        		.queryParam("serviceControlScvCAPath", serviceControl.getServiceControlScvCAPath())
        		.queryParam("serviceControlLogServerPath", serviceControl.getServiceControlLogServerPath())
        		.queryParam("serviceControlTomcatPath", serviceControl.getServiceControlTomcatPath())
        		.queryParam("serviceControlIp", serviceControl.getServiceControlIp())
        		.build();
        
        try {
        	ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

	        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
	        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
	        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인
	
	        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
	        ObjectMapper mapper = new ObjectMapper();
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
		} catch (Exception e) {
			System.out.println(e);
		}
        
        return jsonInString;
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public ServiceControl getServiceControlIpOne(String serviceControlIp) {
		return serviceControlDao.getServiceControlIpOne(serviceControlIp);
	}

	public String getLogInquiry(ServiceControl serviceControl) {
		String logDate = serviceControlDao.getLastLogDate(serviceControl);
		ServiceControl sc = serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp());
		sc.setServiceControlLogDate(logDate);
		sc.setService(serviceControl.getService());
        return removeQuotes(logInquiry(sc));
	}
	
	private static String removeQuotes(String str) {
        // 문자열이 큰따옴표로 둘러싸여 있다면 제거
        if (str.startsWith("\"") && str.endsWith("\"")) {
            return str.substring(1, str.length() - 1);
        } else {
            return str;
        }
    }
	
	public String logInquiry(ServiceControl serviceControl) {
		String url = "http://"+serviceControl.getServiceControlIp()+":8081/serviceControlAgent/logInquiry";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate(getClientHttpRequestFactory());

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("service", serviceControl.getService())
        		.queryParam("serviceControlScvEAPath", serviceControl.getServiceControlScvEAPath())
        		.queryParam("serviceControlScvCAPath", serviceControl.getServiceControlScvCAPath())
        		.queryParam("serviceControlLogServerPath", serviceControl.getServiceControlLogServerPath())
        		.queryParam("serviceControlTomcatPath", serviceControl.getServiceControlTomcatPath())
        		.queryParam("serviceControlLogDate", serviceControl.getServiceControlLogDate())
        		.build();
        
        try {
        	ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

	        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
	        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
	        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인
	
	        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
	        ObjectMapper mapper = new ObjectMapper();
			jsonInString = mapper.writeValueAsString(resultMap.getBody()).toString();
		} catch (Exception e) {
			System.out.println(e);
		}
        
        return jsonInString;
	}

	public String setServiceControlUpdate(ServiceControl serviceControl) {
		int sucess = 0;
		sucess = serviceControlDao.setServiceControlUpdate(serviceControl);
		if (sucess <= 0)
			return "FALSE";
		return serviceControlSynchronization();
	}

	public String setRouteSetting(ServiceControl serviceControl) {
		int sucess = 0;
		sucess = serviceControlDao.setRouteSetting(serviceControl);
		if (sucess <= 0)
			return "FALSE";
		return serviceControlSynchronization();
	}
	
	private ClientHttpRequestFactory getClientHttpRequestFactory() {
	    int timeout = 100; // 원하는 시간을 밀리초 단위로 설정하세요.
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory
	     = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}

}


