package com.secuve.agentInfo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
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
import com.secuve.agentInfo.dao.LogGriffinDao;
import com.secuve.agentInfo.dao.LogGriffinFileJpaDao;
import com.secuve.agentInfo.vo.LogGriffin;
import com.secuve.agentInfo.vo.LogGriffinFile;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class LogGriffinService {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	@Autowired LogGriffinDao logGriffinDao;
	@Autowired LogGriffinFileJpaDao logGriffinFileJpaDao;

	public LogGriffin insertLicenseView(Integer logGriffinKeyNum) {
		LogGriffin license = new LogGriffin();
		if(logGriffinKeyNum != null) {
			license = logGriffinDao.getLicenseOne(logGriffinKeyNum);
		}
		return license;
	}

	public List<String> getSelectInput(String selectInput) {
		return logGriffinDao.getSelectInput(selectInput);
	}

	public List<LogGriffin> getLicenseList(LogGriffin search) {
		return logGriffinDao.getLicenseList(licenseSearch(search));
	}

	public int getLicenseListCount(LogGriffin search) {
		return logGriffinDao.getLicenseListCount(licenseSearch(search));
	}

	public List<String> existenceCheckInsert(LogGriffin license) {
		List<String> list = new ArrayList<String>();
		if(!isValidMacAddress(license.getMacAddressView())) {
			list.add("NotMacAddress");
			return list;
		}
		if("off".equals(license.getChkLicenseIssuance())) {
			if(license.getSerialNumberView() == "") {
				list.add("NotSeriaNumber");
				return list;
			}
		}
		list = logGriffinDao.existenceCheckInsert(license);
		return list;
	}
	
	public static boolean isValidMacAddress(String macAddress) {
        // MAC 주소의 패턴을 정의합니다. 콜론(:) 또는 하이픈(-)으로 구분된 12자리의 16진수 패턴입니다.
        String macPattern = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$";

        // 정규 표현식을 이용하여 패턴 검사를 수행합니다.
        Pattern pattern = Pattern.compile(macPattern);
        Matcher matcher = pattern.matcher(macAddress);

        return matcher.matches();
    }
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String loggriffinUpdate(LogGriffin license, Principal principal) throws ParseException {
		String resault = "OK";
		if(!isValidMacAddress(license.getMacAddressView())) {
			return "NotMacAddress";
		}
		String route = logGriffinDao.getRoute("logGriffinRoute");
		String ip = logGriffinDao.getRoute("logGriffinIP");
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		license.setMacAddressView(license.getMacAddressView().replaceAll("-", ":"));
		
		if("on".equals(license.getChkLicenseIssuance())) {
			try {
				resault = logGriffinIssued(ip, route, license).replaceAll("\"", "");
				license.setSerialNumberView(resault);
			} catch (Exception e) {
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			int check = logGriffinDao.serialNumberCheck(license.getSerialNumberView());
			if(logGriffinDao.getLicenseOne(license.getLogGriffinKeyNum()).getSerialNumber() != license.getSerialNumberView()) {
				if(check > 0) {
					LOGGER.debug("시리얼 넘버 중복 ERROR");
					return "Duplication";
				}
			}
			license = licenseInputFormat(license);
			int sucess = logGriffinDao.updateLicense(license);
		
			// 로그 기록
			if (sucess <= 0) {
				LOGGER.debug("LogGRIFFIN 라이선스 발급 INSERT ERROR");
				return "FALSE";
			}
		} else {
			LOGGER.debug("LogGRIFFIN 라이선스 발급 ERROR");
			return "FALSE";
		}
		return resault;
		
	}
	
	private String logGriffinIssued(String ip, String route, LogGriffin license) throws UnsupportedEncodingException {
		String url = "http://"+ip+":8080/logGriffinLicenseIssued";
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
        		.queryParam("customerName", URLEncoder.encode(license.getCustomerNameView(), "UTF-8"))
        		.queryParam("businessName", license.getBusinessNameView())
        		.queryParam("macAddress", license.getMacAddressView())
        		.queryParam("issueDate", license.getIssueDateView())
        		.queryParam("expirationDays", license.getExpirationDaysView())
        		.queryParam("productName", license.getProductNameView())
        		.queryParam("productVersion", license.getProductVersionView())
        		.queryParam("agentCount", license.getAgentCountView())
        		.queryParam("agentLisCount", license.getAgentLisCountView())
        		.queryParam("additionalInformation", license.getAdditionalInformationView())
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

	public LogGriffin licenseInputFormat(LogGriffin license) throws ParseException {
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
		
		if(license.getAgentCountView() == "" || license.getAgentCountView() == null) {
			license.setAgentCountView("무제한");
		}
		if(license.getAgentLisCountView() == "" || license.getAgentLisCountView() == null) {
			license.setAgentLisCountView("무제한");
		}
		
		return license;
	}

	public String loggriffinIssued(LogGriffin license, Principal principal) throws ParseException {
		String resault = "OK";
		if(!isValidMacAddress(license.getMacAddressView())) {
			return "NotMacAddress";
		}
		String route = logGriffinDao.getRoute("logGriffinRoute");
		String ip = logGriffinDao.getRoute("logGriffinIP");
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		if(ip == null || ip.equals("") || ip == "") {
			return "NotIp";
		}
		license.setMacAddressView(license.getMacAddressView().replaceAll("-", ":"));
		
		if("on".equals(license.getChkLicenseIssuance())) {
			try {
				resault = logGriffinIssued(ip, route, license).replaceAll("\"", "");
				license.setSerialNumberView(resault);
			} catch (Exception e) {
				System.out.println(e);
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			int check = logGriffinDao.serialNumberCheck(license.getSerialNumberView());
			if(check > 0) {
				LOGGER.debug("시리얼 넘버 중복 ERROR");
				return "Duplication";
			}
			license = licenseInputFormat(license);
			int sucess = logGriffinDao.issuedLicense(license);
		
			// 로그 기록
			if (sucess <= 0) {
				LOGGER.debug("LogGRIFFIN 라이선스 발급 INSERT ERROR");
				return "FALSE";
			}
		} else {
			LOGGER.debug("LogGRIFFIN 라이선스 발급 ERROR");
			return "FALSE";
		}
		return resault;
	}

	public LogGriffin getLicenseOne(int logGriffinKeyNum) {
		return logGriffinDao.getLicenseOne(logGriffinKeyNum);
	}

	public List<String> existenceCheckUpdate(LogGriffin license) {
		List<String> list = new ArrayList<String>();
		if(!isValidMacAddress(license.getMacAddressView())) {
			list.add("NotMacAddress");
			return list;
		}
		list = logGriffinDao.existenceCheckUpdate(license);
		return list;
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int logGriffinKeyNum : chkList) {
			int sucess = logGriffinDao.delLicense(logGriffinKeyNum);

			// 로그 기록
			if (sucess > 0) {
			} else if (sucess <= 0) {
				LOGGER.debug("라이선스 DELETE ERROR");
				return "FALSE";
			}
		}
		return "OK";
	}

	public List listAll(LogGriffin license) {
		return logGriffinDao.getLicenseListAll(licenseSearch(license));
	}
	
	
	public LogGriffin licenseSearch(LogGriffin search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setRequesterArr(search.getRequester().split(","));;
		search.setMacAddressArr(search.getMacAddress().split(","));
		search.setProductNameArr(search.getProductName().split(","));
		search.setProductVersionArr(search.getProductVersion().split(","));
		search.setLicenseFilePathArr(search.getLicenseFilePath().split(","));
		search.setSerialNumberArr(search.getSerialNumber().split(","));
		
		return search;
	}

	public ResponseEntity<?> fileDownload(String licenseFilePath) throws UnsupportedEncodingException {
		String ip = logGriffinDao.getRoute("logGriffinIP");
		String url = "http://"+ip+":8080/logGriffinFileDownload";
		RestTemplate restTemplate = new RestTemplate();
		String route = logGriffinDao.getRoute("logGriffinRoute");
		String[] routeArr = route.split("/");
		String routeStr = "";
		for (int i=0; i<routeArr.length; i++) {
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

	public String downLoadCheck(int[] chkList) {
		for (int logGriffinKeyNum : chkList) {
			if(logGriffinFileJpaDao.findBySerialNumber(logGriffinDao.getLicenseOne(logGriffinKeyNum).getSerialNumber()) == null) {
				return "Empty";
			}
		}
		return "OK";
	}

	public List<String> getSeriaNumber(int[] logGriffinKeyNumList) {
		List<String> list = new ArrayList<String>();
		for (int licenseKeyNum : logGriffinKeyNumList) {
			list.add(logGriffinDao.getLicenseOne(licenseKeyNum).getSerialNumber());
		}
		return list;
	}

	public ResponseEntity<Resource> singleDownLoad(List<String> serialNumber) {
		LogGriffinFile fileEntity = logGriffinFileJpaDao.findBySerialNumber(serialNumber.get(0));

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
		List<LogGriffinFile> fileEntities = new ArrayList<LogGriffinFile>();
		for(String serialNumber : serialNumberList) {
			fileEntities.add(logGriffinFileJpaDao.findBySerialNumber(serialNumber));
		}
		
		for(LogGriffinFile logGriffinFile : fileEntities) {
			if (logGriffinFile == null) {
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
	        for (LogGriffinFile fileEntity : fileEntities) {
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

	public Map<String, Object> licenseYmlImport(List<MultipartFile> fileList, Principal principal) {
		int sucess = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		
		for (MultipartFile ymlFile : fileList) {
			LogGriffin license = new LogGriffin();
			license.setLogGriffinRegistrant(principal.getName());
			license.setLogGriffinRegistrationDate(nowDate());
			sucess += licenseYmlInsert(license, ymlFile);
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
	
	@Value("${spring.servlet.multipart.location}")
	String filePath;
	
	public int licenseYmlInsert(LogGriffin license, MultipartFile ymlFile) {
		try {
			String fileName = ymlFile.getOriginalFilename();
		    String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
		    if(!extension.equals("yml")) {
		    	return 0;
		    }
		    
			File newFileName = new File(filePath + File.separator + "logGriffin", ymlFile.getOriginalFilename());
			ymlFile.transferTo(newFileName);
			
			BufferedReader file_reader = new BufferedReader(new InputStreamReader(new FileInputStream(newFileName), "utf-8"));
			String line;
			file_reader.readLine();
			while ((line = file_reader.readLine()) != null) {
				if (line.contains("agentCount")) 
					 license.setAgentCountView(Integer.toString(Integer.parseInt(line.replace("agentCount:", "").replace(" ", "").replace("'", ""))));
				if (line.contains("agentlessCount")) 
					 license.setAgentLisCountView(Integer.toString(Integer.parseInt(line.replace("agentlessCount:", "").replace(" ", "").replace("'", ""))));
				if (line.contains("customer")) 
					 license.setCustomerNameView(line.replace("customer:", "").replace(" ", ""));
				if (line.contains("expirationDate")) 
					 license.setExpirationDaysView(line.replace("expirationDate:", "").replace(" ", "").replace("'", ""));
				if (line.contains("info")) 
					 license.setAdditionalInformationView(line.replace("info:", "").replace(" ", "").replace("'", ""));
				if (line.contains("issueDate")) 
					 license.setIssueDateView(line.replace("issueDate:", "").replace(" ", "").replace("'", ""));
				if (line.contains("key")) 
					 license.setSerialNumberView(line.replace("key:", "").replace(" ", ""));
				if (line.contains("mac")) 
					 license.setMacAddressView(line.replace("mac:", "").replace(" ", "").replace("'", ""));
				if (line.contains("product")) 
					 license.setProductNameView(line.replace("product:", "").replace(" ", ""));
				if (line.contains("project")) 
					 license.setBusinessNameView(line.replace("project:", "").replace(" ", ""));
				if (line.contains("version")) 
					 license.setProductVersionView(line.replace("version:", "").replace(" ", "").replace("'", ""));
			}
			file_reader.close();
		} catch (Exception e) {
			return 0;
		}
		license.setLicenseFilePathView(ymlFile.getOriginalFilename());
		int check = logGriffinDao.serialNumberCheck(license.getSerialNumberView());
		if(check > 0) {
			LOGGER.debug("시리얼 넘버 중복 ERROR");
			return -1;
		}
		return logGriffinDao.issuedLicense(license);
	}

}
