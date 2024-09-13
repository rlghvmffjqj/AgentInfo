package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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
import com.secuve.agentInfo.dao.VmServerDao;
import com.secuve.agentInfo.vo.VmServer;
import com.secuve.agentInfo.vo.VmServerHost;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class VmServerService {
	@Autowired VmServerDao vmServerDao;

	public List<String> getSelectInput(String selectInput) {
		return vmServerDao.getSelectInput(selectInput);
	}

	public List<VmServer> getVmServer(VmServer search) {
		return vmServerDao.getVmServer(vmServerSearch(search));
	}
	
	
	public int getVmServerCount(VmServer search) {
		return vmServerDao.getVmServerCount(vmServerSearch(search));
	}
	
	public VmServer vmServerSearch(VmServer search) {
		search.setVmServerHostNameArr(search.getVmServerHostName().split(","));
		search.setVmServerNameArr(search.getVmServerName().split(","));
		search.setVmServerStatusArr(search.getVmServerStatus().split(","));

		return search;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertVmServerHost(VmServerHost vmServerHost) {
		if(vmServerDao.getVmServerHostValidity("vmServerHostName",vmServerHost.getVmServerHostNameView()) > 0) {
			return "NotVmServerHostNameDoub";
		}
		if(vmServerDao.getVmServerHostValidity("vmServerHostIp",vmServerHost.getVmServerHostIpView()) > 0) {
			return "NotVmServerHostIpDoub";
		}
		int sucess = vmServerDao.insertVmServerHost(vmServerHost);
		if (sucess <= 0)
			return "FALSE";
		List<VmServer> vmServerList = insertSync(vmServerHost.getVmServerHostIpView());
		for (VmServer vmServer : vmServerList) {
			vmServer.setVmServerHostName(vmServerHost.getVmServerHostNameView());
			sucess *= vmServerDao.insertVmServer(vmServer);
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public List<VmServer> insertSync(String vmServerHostIp) {
		String url = "http://"+vmServerHostIp+":8081/serviceControlAgent/hyperVList";
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
		} catch (Exception e) {
			System.out.println(e);
		}
        
        String jsonInStringPasing = jsonInString.substring(2, jsonInString.length() - 5);
        List<String> hostList = new ArrayList<>(Arrays.asList(jsonInStringPasing.split(",   ")));
        hostList.remove(0);
        hostList.remove(0);
        List<VmServer> vmServerList = new ArrayList<VmServer>();
        for(String hostValue : hostList) {
        	VmServer vmServer = new VmServer();
        	String[] hostStr = hostValue.split("\\|");
        	vmServer.setVmServerStatus(hostStr[0]);
        	if(hostStr[1].length() > 2) {
        		long bytes = Long.parseLong(hostStr[1]);
        		long megabytes = bytes / (1024 * 1024);
        		vmServer.setVmServerMemory(Long.toString(megabytes)+"MB");
        	} else {
        		vmServer.setVmServerMemory(hostStr[1]+"MB");
        	}
        	if(hostStr[2].length() > 9) {
        		String[] parts = hostStr[2].split(":");
                String parsedStr = parts[0] + ":" + parts[1] + ":" + parts[2].substring(0,2);
                vmServer.setVmServerTime(parsedStr);
        	} else {
        		vmServer.setVmServerTime(hostStr[2]);
        	}
        	vmServer.setVmServerName(hostStr[3]);
        	vmServerList.add(vmServer);
        }

        return vmServerList;
	}
	
	private ClientHttpRequestFactory getClientHttpRequestFactory() {
	    int timeout = 100; // 원하는 시간을 밀리초 단위로 설정하세요.
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}

	public String deleteVmServerHost(List<String> vmServerHostNameList) {
		int sucess = 1;
		for(String vmServerHostName : vmServerHostNameList) {
			sucess *= vmServerDao.deleteVmServerHost(vmServerHostName);
			if (sucess <= 0)
				return "FALSE";
			sucess *= vmServerDao.deleteVmServer(vmServerHostName);
			if (sucess <= 0)
				return "FALSE";
		}
		
		return "OK";
	}

	public List getVmServerSearchAll(VmServer vmServer) {
		return vmServerDao.getVmServerSearchAll(vmServerSearch(vmServer));
	}

	public String synchronization() {
		int sucess = 1;
		vmServerDao.deleteAllVmServer();
		List<VmServerHost> vmServerHostList = vmServerDao.getVmServerHost();
		for(VmServerHost vmServerHost : vmServerHostList) {
			List<VmServer> vmServerList = insertSync(vmServerHost.getVmServerHostIp());
			for (VmServer vmServer : vmServerList) {
				vmServer.setVmServerHostName(vmServerHost.getVmServerHostName());
				sucess *= vmServerDao.insertVmServer(vmServer);
			}
			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}
}
