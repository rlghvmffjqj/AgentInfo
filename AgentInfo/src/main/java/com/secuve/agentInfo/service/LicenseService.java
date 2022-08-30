package com.secuve.agentInfo.service;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.secuve.agentInfo.dao.LicenseDao;
import com.secuve.agentInfo.vo.License;
import com.secuve.agentInfo.vo.LicenseSetting;


@Service
public class LicenseService {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
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
		search.setKernelVersionArr(search.getKernelVersion().split(","));
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
				LOGGER.debug("라이센스 KEY NULL ERROR");
				return "FALSE";
			}
		} catch (Exception e) {
			LOGGER.debug("라이센스 KEY SELECT ERROR");
			return "FALSE";
		}
		return result;
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String linuxIssuedLicense20(License license, Principal principal) {
		String resault = null;
		String answer = "";
		String firstStr = license.getOsTypeView().toUpperCase()+" "+license.getOsVersionView()+" "+license.getKernelVersionView();
		String lastStr = period(license.getPeriodView(), Integer.parseInt(license.getPeriodYearSelf()), Integer.parseInt(license.getPeriodMonthSelf()), Integer.parseInt(license.getPeriodDaySelf()))+" "+license.getMacUmlHostIdView();
		String route = licenseDao.getRoute("linuxLicense20Route", principal.getName());
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		resault = LinuxLicenseIssued20(route, firstStr, lastStr);
		// 대괄호 외 대괄호 제거
		for(int i=1; i<resault.length()-1; i++) {
			answer += resault.charAt(i);
		}
		// 라이센스 발급 후 메시지에서 불필요 내용 제거
		try {
			answer = answer.substring(32);
		} catch (Exception e) {
			LOGGER.debug("리눅스 라이센스 2.0 발급 결과값 CUTTING ERROR");
			return "FALSE";
		}
		
		if(!answer.equals("FALSE")) {
			license.setLicenseIssueCommand("./gen_serial "+firstStr+" "+'"'+"Secuve TOS"+'"'+" 2.0i "+lastStr);
			license = BtnTypeKeyManagement(license);
			license.setLicenseIssueKey(answer);
			license.setPeriodView(periodSelf(license.getPeriodView(), Integer.parseInt(license.getPeriodYearSelf()), Integer.parseInt(license.getPeriodMonthSelf()), Integer.parseInt(license.getPeriodDaySelf())));
			int sucess = licenseDao.issuedLicense(license);
		
			// 로그 기록
			if (sucess > 0) {
				licenseUidLogService.insertLicenseUidLog(license, principal, "INSERT", "LINUX");
			} else {
				LOGGER.debug("리눅스 라이센스 2.0 발급 INSERT ERROR");
				return "FALSE";
			}
		} else {
			LOGGER.debug("리눅스 라이센스 2.0 발급 ERROR");
			return "FALSE";
		}
		return answer;
	}
	
	public License BtnTypeKeyManagement(License license) {
		if(license.getBtnType().equals("issued")) {
			license.setLicenseKeyNum(LicenseKeyNum());
			license.setLicenseKeyNumOrigin(LicenseKeyNumOrigin());
		} else {
			licenseDao.plusLicenseKeyNumOrigin(license.getLicenseKeyNumOrigin()); // 복사 대상 윗 데이터 +1
			license.setLicenseKeyNumOrigin(license.getLicenseKeyNumOrigin() + 1); // 빈 공간 값 저장
			license.setLicenseKeyNum(LicenseKeyNum());
		}
		return license;
	}
	
	public String linuxIssuedLicense50(License license, Principal principal) {
		String resault = null;
		String answer = "";
		String route = licenseDao.getRoute("linuxLicense50Route", principal.getName());
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		resault = LinuxLicenseIssued50(route);
		// 대괄호 외 대괄호 제거
		for(int i=1; i<resault.length()-1; i++) {
			answer += resault.charAt(i);
		}
		// 라이센스 발급 후 메시지에서 불필요 내용 제거
		try {
			answer = answer.substring(32);
		} catch (Exception e) {
			LOGGER.debug("리눅스 라이센스 5.0 발급 결과값 CUTTING ERROR");
			return "FALSE";
		}
		
		if(!answer.equals("FALSE")) {
			license.setLicenseIssueCommand("");
			license = BtnTypeKeyManagement(license);
			license.setLicenseIssueKey(answer);
			license.setLicenseIssueKey("LINUX5.0");
			license.setPeriodView(periodSelf(license.getPeriodView(), Integer.parseInt(license.getPeriodYearSelf()), Integer.parseInt(license.getPeriodMonthSelf()), Integer.parseInt(license.getPeriodDaySelf())));
			int sucess = licenseDao.issuedLicense(license);
		
			// 로그 기록
			if (sucess > 0) {
				licenseUidLogService.insertLicenseUidLog(license, principal, "INSERT", "LINUX");
			} else {
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
	
	public String periodSelf(String period, int periodYear, int periodMonth, int periodDay) {
		if(period == null) period = "";
		if(periodYear > 0) { 
			period = periodYear + "년";
		}
		if(periodMonth > 0) {
			period += periodMonth + "월";
		}
		if(periodDay > 0) {
			period += periodDay + "일";
		}
		return period;
	}
	
	public String period(String period, int periodYear, int periodMonth, int periodDay) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		if(periodYear <= 0 && periodMonth <= 0 && periodDay <= 0) { 
			if(period.equals("무제한")) {
				return "00000000";
	 		} else if(period.equals("1년")) {
	 			cal.add(Calendar.YEAR, 1);
			} else if(period.equals("5년")) {
				cal.add(Calendar.YEAR, 5);
			} else if(period.equals("10년")) {
				cal.add(Calendar.YEAR, 10);
			} 
		} else {
			cal.add(Calendar.YEAR, periodYear);
			cal.add(Calendar.MONTH, periodMonth);
			cal.add(Calendar.DATE, periodDay+1);
		}
		cal.add(Calendar.DATE, -1);
		return formatter.format(cal.getTime());
	}
	
	public String LinuxLicenseIssued20(String route, String firstStr, String lastStr) {
		String url = "http://172.16.50.182:8080/linuxLicenseIssued20";
        HashMap<String, Object> result = new HashMap<String, Object>();
        String jsonInString = "";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders header = new HttpHeaders();
        HttpEntity<?> entity = new HttpEntity<>(header);
        
        UriComponents uri = UriComponentsBuilder.fromHttpUrl(url)
        		.queryParam("route", route)
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
        
        return jsonInString;
	}
	
	public int windowIssuedLicense(License license, Principal principal, HttpServletRequest request) {
		// 닫기 버튼으로 뒤로 이동한 경우 중첩 추가를 막기위해 삭제 후 추가한다.
		if(license.getViewType() == "issuedback" || license.getViewType().equals("issuedback") || license.getViewType() == "copyback" || license.getViewType().equals("copyback")) {
			licenseDao.licensCancel(license.getLicenseKeyNum());
		}
		
		license = BtnTypeKeyManagement(license);
		license.setLicenseIssueKey("none");
		license.setPeriodView(periodSelf(license.getPeriodView(), Integer.parseInt(license.getPeriodYearSelf()), Integer.parseInt(license.getPeriodMonthSelf()), Integer.parseInt(license.getPeriodDaySelf())));
		int sucess = licenseDao.issuedLicense(license);
		String route = licenseDao.getRoute("windowsLicenseRoute", principal.getName());
		// 로그 기록
		if (sucess > 0) {
			WindowsLicenseIssued(request, route);
			return license.getLicenseKeyNum();
		} else {
			return 0;
		}
	}
	
	
	
	public void WindowsLicenseIssued(HttpServletRequest request, String route) {
		String ip = request.getHeader("X-Forwarded-For");
	    if (ip == null) ip = request.getRemoteAddr();
	    
		String url = "http://"+ip+":8080/windowsLicenseIssued";
        HashMap<String, Object> result = new HashMap<String, Object>();
        // 결과 전달할 경우 사용
        //String jsonInString = "";

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
        //ObjectMapper mapper = new ObjectMapper();
        //try {
		//	jsonInString = mapper.writeValueAsString(resultMap.getBody());
		//} catch (JsonProcessingException e) {
		//	// TODO Auto-generated catch block
		//	e.printStackTrace();
		//}
        
	}
	
	public int LicenseKeyNum() {
		int licenseKeyNum = 1;
		try {
			licenseKeyNum = licenseDao.getLicenseKeyNum();
		} catch (Exception e) {
			return licenseKeyNum;
		}
		return ++licenseKeyNum;
	}
	
	public int LicenseKeyNumOrigin() {
		int licenseKeyNumOrigin = 1;
		try {
			licenseKeyNumOrigin = licenseDao.getLicenseKeyNumOrigin();
		} catch (Exception e) {
			return licenseKeyNumOrigin;
		}
		return ++licenseKeyNumOrigin;
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int licenseKeyNum : chkList) {
			License license = licenseDao.getLicenseOne(licenseKeyNum);
			int sucess = licenseDao.delLicense(licenseKeyNum);

			// 로그 기록
			if (sucess > 0) {
				licenseUidLogService.insertLicenseUidLog(license, principal, "DELETE", "ALL");
			} else if (sucess <= 0) {
				LOGGER.debug("라이센스 DELETE ERROR");
				return "FALSE";
			}
		}
		return "OK";
	}

	public String saveLicenseKey(String licenseIssueKey, int licenseKeyNum, Principal principal) {
		int sucess = licenseDao.saveLicenseKey(licenseIssueKey, licenseKeyNum);
		if(sucess <= 0) {
			LOGGER.debug("라이센스 INSERT ERROR");
			return "FALSE";
		} 
		License license = licenseDao.getLicenseOne(licenseKeyNum);
		licenseUidLogService.insertLicenseUidLog(license, principal, "INSERT", "WINDOWS");
		return "OK";
	}

	public void licensCancel(int licenseKeyNum) {
		licenseDao.licensCancel(licenseKeyNum);
	}

	public License insertLicenseView(String licenseKeyNum) {
		License license = new License();
		if(licenseKeyNum != null) {
			license = licenseDao.getLicenseOne(Integer.parseInt(licenseKeyNum));
		}
		return license;
	}

	public String txtSave(int[] chkList, String fileName) {
		try {
		    OutputStream output = new FileOutputStream("C:/AgentInfo/license/"+fileName+".txt");
		    String str = contents(chkList);
		    byte[] by=str.getBytes();
		    output.write(by);
		} catch (Exception e) {
	            e.getStackTrace();
	            return "FALSE";
		}
		return "OK";
	}
	
	public String contents(int[] chkList) {
		License license = new License();
		String contents = "";
		for (int licenseKeyNum : chkList) {
			license = licenseDao.getLicenseOne(licenseKeyNum);
			if(license.getLicenseType().equals("Linux20")) {
				contents += license.getOsType() + "\n";
				contents += license.getLicenseIssueCommand() + "\n";
				contents += license.getLicenseIssueKey() + "\n\n";
			} else if(license.getLicenseType().equals("Linux50")) {
				
			} else {
				contents += license.getOsType() + "\n";
				contents += "MAC : " + license.getMacUmlHostId() + "\n";
				contents += "License : " + license.getLicenseIssueKey() + "\n\n";
			}
		}
		return contents;
	}

	public LicenseSetting getlicenseSetting(String employeeId) {
		return licenseDao.getlicenseSetting(employeeId);
	}

	public String RouteChange(LicenseSetting licenseSetting) {
		int count = 0;
		if(licenseDao.getSettingCount(licenseSetting.getEmployeeId()) > 0) {
			count = licenseDao.RouteChange(licenseSetting);
		} else {
			count = licenseDao.RouteInsert(licenseSetting);
		}
		
		if(count > 0) {
			return "OK";
		}
		return "FALSE";
	}

	public License getLicenseOne(int licenseKeyNum) {
		return licenseDao.getLicenseOne(licenseKeyNum);
	}

	public String getRoute(String column, String employeeId) {
		String route = licenseDao.getRoute(column, employeeId);
		if(route == null || route.equals("") || route == "") {
			return "NotRoute";
		}
		return "OK";
	}

}
