package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
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
import com.secuve.agentInfo.dao.CustomerConsolidationDao;
import com.secuve.agentInfo.dao.License5Dao;
import com.secuve.agentInfo.dao.License5FileJpaDao;
import com.secuve.agentInfo.vo.CustomerConsolidation;
import com.secuve.agentInfo.vo.License5;
import com.secuve.agentInfo.vo.License5File;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class License5Service {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	@Autowired License5Dao license5Dao;
	@Autowired CategoryService categoryService;
	@Autowired License5UidLogService license5UidLogService;
	@Autowired License5FileJpaDao license5FileJpaDao;
	@Autowired CustomerConsolidationDao customerConsolidationDao;

	public List<License5> getLicenseList(License5 search) {
		List<License5> license5List = license5Dao.getLicenseList(licenseSearch(search));
		for (License5 license5 : license5List) {
			if("(구)".equals(license5.getLicenseType())) {
				license5.setNetworkCount(null);
				license5.setAixCount(null);
				license5.setHpuxCount(null);
				license5.setSolarisCount(null);
				license5.setLinuxCount(null);
				license5.setWindowsCount(null);
			}
		}
		return license5List;
	}

	public int getLicenseListCount(License5 search) {
		return license5Dao.getLicenseListCount(licenseSearch(search));
	}
	
	public License5 licenseSearch(License5 search) {
		search.setLicenseTypeArr(search.getLicenseType().split(","));
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
		String route = "";
		if(license.getLicenseTypeView().equals("(신)"))
			if(!isValidMacAddress(license.getMacAddressView())) {
				return "NotMacAddress";
			}
			route = license5Dao.getRoute("linuxLicense50Route");
		if(license.getLicenseTypeView().equals("(구)"))
			route = license5Dao.getRoute("linuxLicense50OldRoute");
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
				if(license.getLicenseTypeView().equals("(신)"))
					resault = LinuxLicenseIssued50(ip, route, license).replaceAll("\"", "");
				if(license.getLicenseTypeView().equals("(구)"))
					resault = LinuxLicenseIssued50Old(ip, route, license).replaceAll("\"", "");
				license.setSerialNumberView(resault);
			} catch (Exception e) {
				System.out.println(e);
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			int check = license5Dao.serialNumberCheck(license.getSerialNumberView());
			if(check > 0) {
				LOGGER.debug("시리얼 넘버 중복 ERROR");
				return "Duplication";
			}
			license = licenseInputFormat(license);
			license.setLicenseState("issued");
			int sucess = license5Dao.issuedLicense(license);
			categoryCheck(license, principal);
			categoryService.insertCustomerBusinessMapping(license.getCustomerNameView(), license.getBusinessNameView());
		
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
	
	public static boolean isValidMacAddress(String macAddress) {
        // MAC 주소의 패턴을 정의합니다. 콜론(:) 또는 하이픈(-)으로 구분된 12자리의 16진수 패턴입니다.
        String macPattern = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$";

        // 정규 표현식을 이용하여 패턴 검사를 수행합니다.
        Pattern pattern = Pattern.compile(macPattern);
        Matcher matcher = pattern.matcher(macAddress);

        return matcher.matches();
    }
	
	public String linuxUpdateLicense50(License5 license, Principal principal) throws ParseException {
		String resault = "OK";
		String route = "";
		if(license.getLicenseTypeView().equals("(신)"))
			if(!isValidMacAddress(license.getMacAddressView())) {
				return "NotMacAddress";
			}
			route = license5Dao.getRoute("linuxLicense50Route");
		if(license.getLicenseTypeView().equals("(구)"))
			route = license5Dao.getRoute("linuxLicense50OldRoute");
		String ip = license5Dao.getRoute("licenseSettingIP");
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		license.setMacAddressView(license.getMacAddressView().replaceAll("-", ":"));
		
		if("on".equals(license.getChkLicenseIssuance())) {
			try {
				if(license.getLicenseTypeView().equals("(신)"))
					resault = LinuxLicenseIssued50(ip, route, license).replaceAll("\"", "");
				if(license.getLicenseTypeView().equals("(구)"))
					resault = LinuxLicenseIssued50Old(ip, route, license).replaceAll("\"", "");
				license.setSerialNumberView(resault);
			} catch (Exception e) {
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			int check = license5Dao.serialNumberCheck(license.getSerialNumberView());
			if(!license5Dao.getLicenseOne(license.getLicenseKeyNum()).getSerialNumber().equals(license.getSerialNumberView())) {
				if(check > 0) {
					LOGGER.debug("시리얼 넘버 중복 ERROR");
					return "Duplication";
				}
			}
			license = licenseInputFormat(license);
			int sucess = license5Dao.updateLicense(license);
			categoryCheck(license, principal);
			categoryService.insertCustomerBusinessMapping(license.getCustomerNameView(), license.getBusinessNameView());
		
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
	
	public String LinuxLicenseIssued50(String ip, String route, License5 license) throws UnsupportedEncodingException {
		String url = "http://"+ip+":8080/linuxLicenseIssued50";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("route", route)
        		.queryParam("productType", license.getProductTypeView())
        		.queryParam("customerName", URLEncoder.encode(license.getCustomerNameView(), "UTF-8"))
        		.queryParam("businessName", URLEncoder.encode(license.getBusinessNameView(), "UTF-8"))
        		.queryParam("additionalInformation", URLEncoder.encode(license.getAdditionalInformationView(), "UTF-8"))
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
        		.queryParam("licenseFilePath", URLEncoder.encode(license.getLicenseFilePathView(), "UTF-8"))
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
	
	public String LinuxLicenseIssued50Old(String ip, String route, License5 license) throws UnsupportedEncodingException {
		String url = "http://"+ip+":8080/linuxLicenseIssued50Old";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        if(!license.getExpirationDaysView().isEmpty() && license.getExpirationDaysView().length() < 4) {
        	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			try {
				cal.setTime(formatter.parse(license.getIssueDateView()));
			} catch (ParseException e) {
				System.out.println("만료일 날짜 변경 중 에러 발생!");
				System.out.println(e);
			}
			cal.add(Calendar.DATE, Integer.parseInt(license.getExpirationDaysView()));
			Date date = new Date(cal.getTimeInMillis());
			
			license.setExpirationDaysView(formatter.format(date));
        }
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("route", route)
        		.queryParam("productType", license.getProductTypeView())
        		.queryParam("customerName", URLEncoder.encode(license.getCustomerNameView(), "UTF-8"))
        		.queryParam("macAddress", license.getMacAddressView())
        		.queryParam("issueDate", license.getIssueDateView())
        		.queryParam("expirationDays", license.getExpirationDaysView())
        		.queryParam("igriffinAgentCount", license.getIgriffinAgentCountView())
        		.queryParam("tos5AgentCount", license.getTos5AgentCountView())
        		.queryParam("tos2AgentCount", license.getTos2AgentCountView())
        		.queryParam("dbmsCount", license.getDbmsCountView())
        		.queryParam("managerOsType", license.getManagerOsTypeView())
        		.queryParam("managerDbmsType", license.getManagerDbmsTypeView())
        		.queryParam("country", license.getCountryView())
        		.queryParam("productVersion", license.getProductVersionView())
        		.queryParam("licenseFilePath", URLEncoder.encode(license.getLicenseFilePathView(), "UTF-8"))
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

	public ResponseEntity<?> fileDownload(String licenseFilePath, String licenseType) throws UnsupportedEncodingException {
		String ip = license5Dao.getRoute("licenseSettingIP");
		String url = "http://"+ip+":8080/fileDownload";
		RestTemplate restTemplate = new RestTemplate();
		String route = "";
		if(licenseType.equals("(신)"))
			route = license5Dao.getRoute("linuxLicense50Route");
		if(licenseType.equals("(구)"))
			route = license5Dao.getRoute("linuxLicense50OldRoute");
		String[] routeArr = route.split("/");
		String routeStr = "";
		for (int i=0; i<routeArr.length-1; i++) {
			routeStr += routeArr[i]+"/";
		}
		
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("fileName", URLEncoder.encode(licenseFilePath, "UTF-8"))
				.queryParam("filePath", URLEncoder.encode(routeStr, "UTF-8"))
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
		if(license.getExpirationDaysView() == "" || license.getExpirationDaysView() == null) {
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
		
		if(license.getExpirationDaysView() == "" || license.getExpirationDaysView() == null) {
			license.setExpirationDaysView("무제한");
		}
		
		if(license.getIgriffinAgentCountView() == "" || license.getIgriffinAgentCountView() == null) {
			license.setIgriffinAgentCountView("무제한");
		}
		if(license.getTos5AgentCountView() == "" || license.getTos5AgentCountView() == null) {
			license.setTos5AgentCountView("무제한");
		}
		if(license.getTos2AgentCountView() == "" || license.getTos2AgentCountView() == null) {
			license.setTos2AgentCountView("무제한");
		}
		if(license.getDbmsCountView() == "" || license.getDbmsCountView() == null) {
			license.setDbmsCountView("무제한");
		}
		if(license.getNetworkCountView() == "" || license.getNetworkCountView() == null) {
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
			file_reader.readLine();
			if(file_reader.readLine().contains("<licenses>")) {
				while ((line = file_reader.readLine()) != null) {
					license.setLicenseTypeView("(신)");
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
				 if (line.contains("quantity_AIX")) 
					 license.setAixCountView(Integer.parseInt(line.replace("<quantity_AIX>", "").replace("</quantity_AIX>","").replace(" ", "")));
				 if (line.contains("quantity_HPUX")) 
					 license.setHpuxCountView(Integer.parseInt(line.replace("<quantity_HPUX>", "").replace("</quantity_HPUX>","").replace(" ", "")));
				 if (line.contains("quantity_Solaris")) 
					 license.setSolarisCountView(Integer.parseInt(line.replace("<quantity_Solaris>", "").replace("</quantity_Solaris>","").replace(" ", "")));
				 if (line.contains("quantity_Linux")) 
					 license.setLinuxCountView(Integer.parseInt(line.replace("<quantity_Linux>", "").replace("</quantity_Linux>","").replace(" ", "")));
				 if (line.contains("quantity_Windows")) 
					 license.setWindowsCountView(Integer.parseInt(line.replace("<quantity_Windows>", "").replace("</quantity_Windows>","").replace(" ", "")));
				}
			} else {
				while ((line = file_reader.readLine()) != null) {
					license.setLicenseTypeView("(구)");
				 if (line.contains("serialNumber")) 
					 license.setSerialNumberView(line.replace("<serialNumber>", "").replace("</serialNumber>","").replace(" ", ""));
				 if (line.contains("productType")) 
					 license.setProductTypeView(line.replace("<productType>", "").replace("</productType>","").replace(" ", ""));
				 if (line.contains("companyName")) 
					 license.setCustomerNameView(line.replace("<companyName>", "").replace("</companyName>","").replace(" ", ""));
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
				}
			}
			file_reader.close();
		} catch (Exception e) {
			return 0;
		}
		license.setLicenseFilePathView(xmlFile.getOriginalFilename());
		int check = license5Dao.serialNumberCheck(license.getSerialNumberView());
		if(check > 0) {
			LOGGER.debug("시리얼 넘버 중복 ERROR");
			return -1;
		}
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
			if(sucess == -1) {
				map.put("result", "Duplication");
				return map;
			}
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
		List<String> list = new ArrayList<String>();
		if(!isValidMacAddress(license.getMacAddressView())) {
			list.add("NotMacAddress");
			return list;
		}
		list = license5Dao.existenceCheckInsert(license);
		return list;
	}

	public List<String> existenceCheckUpdate(License5 license) {
		List<String> list = new ArrayList<String>();
		if(!isValidMacAddress(license.getMacAddressView())) {
			list.add("NotMacAddress");
			return list;
		}
		list = license5Dao.existenceCheckUpdate(license);
		return list;
	}

	public List<String> getSeriaNumber(int[] licenseKeyNumList) {
		List<String> list = new ArrayList<String>();
		for (int licenseKeyNum : licenseKeyNumList) {
			list.add(license5Dao.getLicenseOne(licenseKeyNum).getSerialNumber());
		}
		return list;
	}

	public ResponseEntity<Resource> singleDownLoad(List<String> serialNumber) {
		License5File fileEntity = license5FileJpaDao.findBySerialNumber(serialNumber.get(0));

	    ByteArrayResource resource = new ByteArrayResource(fileEntity.getFileData());

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    try {
	        String encodedFileName = URLEncoder.encode(fileEntity.getFileName(), StandardCharsets.UTF_8.toString());
	        headers.setContentDispositionFormData("attachment", encodedFileName);
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }

	    return ResponseEntity.ok().headers(headers).body(resource);
	}
	
	public ResponseEntity<Resource> multiDownLoad(List<String> serialNumberList) {
		List<License5File> fileEntities = new ArrayList<License5File>();
		for(String serialNumber : serialNumberList) {
			fileEntities.add(license5FileJpaDao.findBySerialNumber(serialNumber));
		}
		
		for(License5File license5File : fileEntities) {
			if (license5File == null) {
		        // 파일이 존재하지 않을 경우 예외 처리
		        // return ResponseEntity with error response
				return null;
		    }
		}
		

	    // 임시 폴더 생성
	    File tempFolder = new File("temp");
	    tempFolder.mkdirs();

	    try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream("download.zip"))) {
	        // 가져온 파일들을 임시 폴더에 저장하고 압축 파일에 추가
	        for (License5File fileEntity : fileEntities) {
	            String fileName = fileEntity.getFileName();
	            byte[] fileData = fileEntity.getFileData();
	            File tempFile = new File(tempFolder.getAbsolutePath() + File.separator + fileName);
	            try (FileOutputStream fos = new FileOutputStream(tempFile)) {
	                fos.write(fileData);
	            }
	            ZipEntry zipEntry = new ZipEntry(fileName);
	            zos.putNextEntry(zipEntry);
	            Files.copy(tempFile.toPath(), zos);
	            zos.closeEntry();
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        // 예외 처리
	        // return ResponseEntity with error response
	    }

	    // 압축 파일을 리소스로 변환
	    FileSystemResource resource = new FileSystemResource("download.zip");

	    // 다운로드를 위한 헤더 설정
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    headers.setContentDispositionFormData("attachment", "download.zip");

	    // 압축 파일 다운로드 응답 반환
	    return ResponseEntity.ok()
	            .headers(headers)
	            .body(resource);
	}

	public String downLoadCheck(int[] chkList) {
		for (int licenseKeyNum : chkList) {
			if(license5FileJpaDao.findBySerialNumber(license5Dao.getLicenseOne(licenseKeyNum).getSerialNumber()) == null) {
				return "Empty";
			}
		}
		return "OK";
	}

	public List<License5> getCustomerConsolidationList(CustomerConsolidation customerConsolidation) {
		return license5Dao.getCustomerConsolidationList(customerConsolidation);
	}

	public String issuedRequest(License5 license) throws ParseException {
		CustomerConsolidation customerConsolidation = customerConsolidationDao.getCustomerConsolidationOne(license.getCustomerConsolidationKeyNum());
		license.setCustomerNameView(customerConsolidation.getCustomerConsolidationCustomer());
		license.setBusinessNameView(customerConsolidation.getCustomerConsolidationBusiness());
		license.setAdditionalInformationView(customerConsolidation.getCustomerConsolidationLocation());
		license.setSerialNumberView("");
		license.setLicenseFilePathView("");
		license.setLicenseState("request");
		license = licenseInputFormat(license);
		int sucess = license5Dao.issuedLicense(license);
		if (sucess <= 0) {
			return "FALSE";
		}
		return "OK";
	}
	
}

