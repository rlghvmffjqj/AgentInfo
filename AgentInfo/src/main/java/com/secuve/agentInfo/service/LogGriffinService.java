package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.AgentInfoApplication;
import com.secuve.agentInfo.dao.LogGriffinDao;
import com.secuve.agentInfo.vo.License5;
import com.secuve.agentInfo.vo.LogGriffin;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class LogGriffinService {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	@Autowired LogGriffinDao logGriffinDao;

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
		return logGriffinDao.getLicenseList(search);
	}

	public int getLicenseListCount(LogGriffin search) {
		return logGriffinDao.getLicenseListCount(search);
	}

	public List<String> existenceCheckInsert(LogGriffin license) {
		List<String> list = new ArrayList<String>();
		if(!isValidMacAddress(license.getMacAddressView())) {
			list.add("NotMacAddress");
			return list;
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
//				resault = logGriffinIssued(ip, route, license).replaceAll("\"", "");
				resault = "OK";
			} catch (Exception e) {
				LOGGER.debug("Agent 연결 실패");
				return "NOTCONNECT";
			}
		}
		
		if(!resault.equals("FALSE")) {
			int check = logGriffinDao.serialNumberCheck(license.getSerialNumberView());
			if(!logGriffinDao.getLicenseOne(license.getLogGriffinKeyNum()).getSerialNumber().equals(license.getSerialNumberView())) {
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
				//resault = logGriffinIssued(ip, route, license).replaceAll("\"", "");
				resault = "OK";
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

}
