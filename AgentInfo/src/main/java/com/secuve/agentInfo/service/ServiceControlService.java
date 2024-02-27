package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
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
import com.secuve.agentInfo.vo.ServiceControlHost;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ServiceControlService {
	@Autowired ServiceControlDao serviceControlDao;

	public String serviceControlManagerInsert(ServiceControl serviceControl) {
		if(serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp()) != null) {
			return "duplication";
		}
		serviceControl.setServiceControlScvEAPath(serviceControl.getServiceControlServicePath());
		serviceControl.setServiceControlScvCAPath(serviceControl.getServiceControlServicePath());
		serviceControl.setServiceControlLogServerPath(serviceControl.getServiceControlServicePath());
		String result = removeCharacter(insertSync(serviceControl),'"');
		// 추가시 전체 동기화 징행 할경우 주석 해제
		//if (result.equals("OK"))
		//	result = serviceControlSynchronization();
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
        		.queryParam("serviceControlServerType", serviceControl.getServiceControlServerType())
        		.queryParam("serviceControlPurpose", serviceControl.getServiceControlPurpose())
        		.queryParam("serviceControlIp", serviceControl.getServiceControlIp())
        		.queryParam("serviceControlHostIp", serviceControl.getServiceControlHostIp())
        		.queryParam("serviceControlScvEAPath", serviceControl.getServiceControlScvEAPath())
        		.queryParam("serviceControlScvCAPath", serviceControl.getServiceControlScvCAPath())
        		.queryParam("serviceControlLogServerPath", serviceControl.getServiceControlLogServerPath())
        		.queryParam("serviceControlTomcatPath", serviceControl.getServiceControlTomcatPath())
        		.queryParam("serviceControlDbType", serviceControl.getServiceControlDbType())
        		.queryParam("serviceControlJdbcPath", serviceControl.getServiceControlJdbcPath())
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
		search.setServiceControlServerTypeArr(search.getServiceControlServerType().split(","));
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
		// serviceControlSynchronization()  // 동기화
		return "OK";
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
	
	public List<ServiceControlHost> getHyperVList(String serviceControlIp) {
		String url = "http://"+serviceControlIp+":8081/serviceControlAgent/hyperVList";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate(getClientHttpRequestFactory());

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.build();
        
        try {
        	ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

	        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
	        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
	        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인
	
	        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
	        ObjectMapper mapper = new ObjectMapper();
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
			System.out.println(jsonInString);
		} catch (Exception e) {
			System.out.println(e);
		}
        String jsonInStringPasing = jsonInString.substring(2, jsonInString.length() - 5);
        List<String> hostList = new ArrayList<>(Arrays.asList(jsonInStringPasing.split(",   ")));
        hostList.remove(0);
        hostList.remove(0);
        List<ServiceControlHost> serviceControlHostList = new ArrayList<ServiceControlHost>();
        for(String hostValue : hostList) {
        	ServiceControlHost serviceControlHost = new ServiceControlHost();
        	String[] hostStr = hostValue.split("\\|");
        	serviceControlHost.setState(hostStr[0]);
        	if(hostStr[1].length() > 2) {
        		long bytes = Long.parseLong(hostStr[1]);
        		long megabytes = bytes / (1024 * 1024);
        		serviceControlHost.setMemoryAssigned(Long.toString(megabytes)+"MB");
        	} else {
        		serviceControlHost.setMemoryAssigned(hostStr[1]);
        	}
        	if(hostStr[2].length() > 9) {
        		String[] parts = hostStr[2].split(":");
                String parsedStr = parts[0] + ":" + parts[1] + ":" + parts[2].substring(0,2);
                serviceControlHost.setUptime(parsedStr);
        	} else {
        		serviceControlHost.setUptime(hostStr[2]);
        	}
        	serviceControlHost.setVmName(hostStr[3]);
        	serviceControlHostList.add(serviceControlHost);
        }
        Collections.sort(serviceControlHostList);

        return serviceControlHostList;
	}
	
	
	public List<String> getServiceControlValue(String column) {
		return serviceControlDao.getServiceControlValue(column);
	}

	public ServiceControl getServiceControlOne(int serviceControlKeyNum) {
		return serviceControlDao.getServiceControlOne(serviceControlKeyNum);
	}

	public String executionChange(ServiceControl serviceControl) {
		String result = "OK";
		ServiceControl sc = serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp());
		sc.setStatus(serviceControl.getStatus());
		sc.setService(serviceControl.getService());
		result = changeStatus(sc);
		serviceControl = serviceControlDao.getServiceControlIpOne(serviceControl.getServiceControlIp());
		serviceControlDao.delServiceControlIp(serviceControl.getServiceControlIp());
		insertSync(serviceControl);
		if(result.equals("null") || result == "" || result == null || result.contains("OK")) 
			return "OK";
		return result;
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
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}

	public String hostRunModChange(ServiceControlHost serviceControlHost) {
		String url = "http://"+serviceControlHost.getIp()+":8081/serviceControlAgent/hostRunModChange";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate(getClientHttpRequestFactory());

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("vmName", serviceControlHost.getVmName())
        		.queryParam("state", serviceControlHost.getState())
        		.build();
        
        try {
        	ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.POST, entity, String.class);

	        result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
	        result.put("header", resultMap.getHeaders()); //헤더 정보 확인
	        result.put("body", resultMap.getBody()); //실제 데이터 정보 확인
	
	        //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
	        ObjectMapper mapper = new ObjectMapper();
			jsonInString = mapper.writeValueAsString(resultMap.getBody());
			if(jsonInString.contains("메모리가 부족")) {
				return "LowMemory";
			}
		} catch (Exception e) {
			System.out.println(e);
			return "FALSE";
		}
        return jsonInString;
	}
}

