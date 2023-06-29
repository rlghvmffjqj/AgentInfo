package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.secuve.agentInfo.AgentInfoApplication;
import com.secuve.agentInfo.dao.License5Dao;
import com.secuve.agentInfo.vo.License5;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class License5Service {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	@Autowired License5Dao license5Dao;
	@Autowired CategoryService categoryService;
	@Autowired License5UidLogService license5UidLogService;

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
	
	public String linuxIssuedLicense50(License5 license, Principal principal) throws ParseException {
		String resault = "OK";
		String route = license5Dao.getRoute("linuxLicense50Route");
		String ip = license5Dao.getRoute("licenseSettingIP");
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		if(ip == null || ip.equals("") || ip == "") {
			return "NotIp";
		}
		license.setMacAddressView(license.getMacAddressView().replaceAll("-", ":"));
		
		if("on".equals(license.getChkLicenseIssuance())) {
			try {
				resault = LinuxLicenseIssued50(ip, route, license).replaceAll("\"", "");
				license.setSerialNumberView(resault);
			} catch (Exception e) {
				System.out.println(e);
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			license = licenseInputFormat(license);
			int sucess = license5Dao.issuedLicense(license);
		
			// 로그 기록
			if (sucess <= 0) {
				LOGGER.debug("리눅스 라이선스 5.0 발급 INSERT ERROR");
				return "FALSE";
			}
			license5UidLogService.license5UidLogInsert(license, "INSERT", principal);	// 로그 수집
		} else {
			LOGGER.debug("리눅스 라이선스 5.0 발급 ERROR");
			return "FALSE";
		}
		return resault;
	}
	
	public String linuxUpdateLicense50(License5 license, Principal principal) throws ParseException {
		String resault = "OK";
		String route = license5Dao.getRoute("linuxLicense50Route");
		String ip = license5Dao.getRoute("licenseSettingIP");
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		license.setMacAddressView(license.getMacAddressView().replaceAll("-", ":"));
		
		if("on".equals(license.getChkLicenseIssuance())) {
			try {
				resault = LinuxLicenseIssued50(ip, route, license).replaceAll("\"", "");
				license.setSerialNumberView(resault);
			} catch (Exception e) {
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			license = licenseInputFormat(license);
			int sucess = license5Dao.updateLicense(license);
		
			// 로그 기록
			if (sucess <= 0) {
				LOGGER.debug("리눅스 라이선스 5.0 발급 INSERT ERROR");
				return "FALSE";
			}
			license5UidLogService.license5UidLogInsert(license, "UPDATE", principal);	// 로그 수집
		} else {
			LOGGER.debug("리눅스 라이선스 5.0 발급 ERROR");
			return "FALSE";
		}
		return resault;
	}
	
	public String LinuxLicenseIssued50(String ip, String route, License5 license) {
		String url = "http://"+ip+":8080/linuxLicenseIssued50";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("route", route)
        		.queryParam("productType", license.getProductTypeView())
        		.queryParam("customerName", license.getCustomerNameView())
        		.queryParam("businessName", license.getBusinessNameView())
        		.queryParam("additionalInformation", license.getAdditionalInformationView())
        		.queryParam("macAddress", license.getMacAddressView())
        		.queryParam("issueDate", license.getIssueDateView())
        		.queryParam("expirationDays", license.getExpirationDaysView())
        		.queryParam("igriffinAgentCount", license.getIgriffinAgentCountView())
        		.queryParam("tos5AgentCount", license.getTos5AgentCountView())
        		.queryParam("tos2AgentCount", license.getTos2AgentCountView())
        		.queryParam("dbmsCount", license.getDbmsCountView())
        		.queryParam("networkCount", license.getNetworkCountView())
        		.queryParam("aixCount", license.getAixCountView())
        		.queryParam("hpuxCount", license.getHpuxCountView())
        		.queryParam("solarisCount", license.getSolarisCountView())
        		.queryParam("linuxCount", license.getLinuxCountView())
        		.queryParam("windowsCount", license.getWindowsCountView())
        		.queryParam("managerOsType", license.getManagerOsTypeView())
        		.queryParam("managerDbmsType", license.getManagerDbmsTypeView())
        		.queryParam("country", license.getCountryView())
        		.queryParam("productVersion", license.getProductVersionView())
        		.queryParam("licenseFilePath", license.getLicenseFilePathView())
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

	public ResponseEntity<?> fileDownload(String licenseFilePath) {
		String ip = license5Dao.getRoute("licenseSettingIP");
		String url = "http://"+ip+":8080/fileDownload";
		RestTemplate restTemplate = new RestTemplate();
		String route = license5Dao.getRoute("linuxLicense50Route");
		String[] routeArr = route.split("/");
		String routeStr = "";
		for (int i=0; i<routeArr.length-1; i++) {
			routeStr += routeArr[i]+"/";
		}
		
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("fileName", licenseFilePath)
				.queryParam("filePath", routeStr)
        		.build();
		HttpHeaders header = new HttpHeaders();
		HttpEntity<?> entity = new HttpEntity<>(header);
		ResponseEntity<?> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.GET, entity, String.class);
		return resultMap;
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int licenseKeyNum : chkList) {
			License5 license = license5Dao.getLicenseOne(licenseKeyNum);
			int sucess = license5Dao.delLicense(licenseKeyNum);

			// 로그 기록
			if (sucess > 0) {
			} else if (sucess <= 0) {
				LOGGER.debug("라이선스 DELETE ERROR");
				return "FALSE";
			}
			license5UidLogService.license5UidLogDeleteInsert(license, "DELETE", principal);	// 로그 수집
		}
		return "OK";
	}
	
	public License5 licenseInputFormat(License5 license) throws ParseException {
		if(license.getExpirationDaysView().isEmpty()) {
			license.setExpirationDaysView("무제한");
		} else {
			if(license.getExpirationDaysView().length() < 4) {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.setTime(formatter.parse(license.getIssueDateView()));
				cal.add(Calendar.DATE, Integer.parseInt(license.getExpirationDaysView()));
				Date date = new Date(cal.getTimeInMillis());
				
				license.setExpirationDaysView(formatter.format(date));
			}
		}
		
		if(license.getExpirationDaysView().isEmpty()) {
			license.setExpirationDaysView("무제한");
		}
		
		if(license.getIgriffinAgentCountView().isEmpty()) {
			license.setIgriffinAgentCountView("무제한");
		}
		if(license.getTos5AgentCountView().isEmpty()) {
			license.setTos5AgentCountView("무제한");
		}
		if(license.getTos2AgentCountView().isEmpty()) {
			license.setTos2AgentCountView("무제한");
		}
		if(license.getDbmsCountView().isEmpty()) {
			license.setDbmsCountView("무제한");
		}
		if(license.getNetworkCountView().isEmpty()) {
			license.setNetworkCountView("무제한");
		}
		
		
		return license;
	}
	
	public void categoryCheck(License5 license, Principal principal) {
		if (categoryService.getCategory("customerName", license.getCustomerNameView()) == 0) {
			categoryService.setCategory("customerName", license.getCustomerNameView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", license.getBusinessNameView()) == 0) {
			categoryService.setCategory("businessName", license.getBusinessNameView(), principal.getName(), nowDate());
		}
	}
	
	public License5 getLicenseOne(int licenseKeyNum) {
		return license5Dao.getLicenseOne(licenseKeyNum);
	}
	
	/**
	 * 파일 저장 경로(application.properties)
	 */
	@Value("${spring.servlet.multipart.location}")
	String filePath;

	public int licenseXmlInsert(License5 license, MultipartFile xmlFile) {
		try {
			String fileName = xmlFile.getOriginalFilename();
		    String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
		    if(!extension.equals("xml")) {
		    	return 0;
		    }
		    
			File newFileName = new File(filePath + File.separator + "license5", xmlFile.getOriginalFilename());
			xmlFile.transferTo(newFileName);
			
			BufferedReader file_reader = new BufferedReader(new InputStreamReader(new FileInputStream(newFileName), "utf-8"));
			String line;
			while ((line = file_reader.readLine()) != null) {
			 if (line.contains("serialNumber")) 
				 license.setSerialNumberView(line.replace("<serialNumber>", "").replace("</serialNumber>","").replace(" ", ""));
			 if (line.contains("productType")) 
				 license.setProductTypeView(line.replace("<productType>", "").replace("</productType>","").replace(" ", ""));
			 if (line.contains("companyName")) 
				 license.setCustomerNameView(line.replace("<companyName>", "").replace("</companyName>","").replace(" ", ""));
			 if (line.contains("projectName")) 
				 license.setBusinessNameView(line.replace("<projectName>", "").replace("</projectName>","").replace(" ", ""));
			 if (line.contains("additional")) 
				 license.setAdditionalInformationView(line.replace("<additional>", "").replace("</additional>","").replace(" ", ""));
			 if (line.contains("system_MAC")) 
				 license.setMacAddressView(line.replace("<system_MAC>", "").replace("</system_MAC>","").replace(" ", ""));
			 if (line.contains("issueDate")) 
				 license.setIssueDateView(line.replace("<issueDate>", "").replace("</issueDate>","").replace(" ", ""));
			 if (line.contains("expireDate")) 
				 license.setExpirationDaysView(line.replace("<expireDate>", "").replace("</expireDate>","").replace(" ", ""));
			 if (line.contains("limit_iGRIFFIN")) 
				 license.setIgriffinAgentCountView(line.replace("<limit_iGRIFFIN>", "").replace("</limit_iGRIFFIN>","").replace(" ", ""));
			 if (line.contains("limit_TOS20")) 
				 license.setTos2AgentCountView(line.replace("<limit_TOS20>", "").replace("</limit_TOS20>","").replace(" ", ""));
			 if (line.contains("limit_TOS50")) 
				 license.setTos5AgentCountView(line.replace("<limit_TOS50>", "").replace("</limit_TOS50>","").replace(" ", ""));
			 if (line.contains("limit_DBMS")) 
				 license.setDbmsCountView(line.replace("<limit_DBMS>", "").replace("</limit_DBMS>","").replace(" ", ""));
			 if (line.contains("limit_Network")) 
				 license.setNetworkCountView(line.replace("<limit_Network>", "").replace("</limit_Network>","").replace(" ", ""));
			}
			file_reader.close();
		} catch (Exception e) {
			return 0;
		}
		license.setLicenseFilePathView(xmlFile.getOriginalFilename());
		return license5Dao.issuedLicense(license);
	}

	public Map<String, Object> licenseXmlImport(List<MultipartFile> fileList, Principal principal) {
		int sucess = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		for (MultipartFile xmlFile : fileList) {
			License5 license = new License5();
			license.setLicenseIssuanceRegistrant(principal.getName());
			license.setLicenseIssuanceRegistrationDate(nowDate());
			sucess += licenseXmlInsert(license, xmlFile);
		}
		
		if(sucess > 0) {
			map.put("result", "OK");
			map.put("sucess", sucess);
		} else {
			map.put("result", "FALSE");
		}
		return map;
	}

	public List<String> existenceCheckInsert(License5 license) {
		return license5Dao.existenceCheckInsert(license);
	}

	public List<String> existenceCheckUpdate(License5 license) {
		return license5Dao.existenceCheckUpdate(license);
	}
}

