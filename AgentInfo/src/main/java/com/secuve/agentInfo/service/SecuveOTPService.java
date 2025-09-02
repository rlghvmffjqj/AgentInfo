package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.SecuveOTPDao;
import com.secuve.agentInfo.vo.LogGriffin;
import com.secuve.agentInfo.vo.SecuveOTP;

@Service
public class SecuveOTPService {
	@Autowired SecuveOTPDao secuveOTPDao;

	public String licenseInsert(SecuveOTP license) {
		int success = secuveOTPDao.licenseInsert(license);
		if(success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public List<SecuveOTP> getLicenseList(SecuveOTP search) {
		 return secuveOTPDao.getLicenseList(search);
	}

	public int getLicenseListCount(SecuveOTP search) {
		return secuveOTPDao.getLicenseListCount(search);
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int secuveOTPKeyNum : chkList) {
			int success = secuveOTPDao.delLicense(secuveOTPKeyNum);

			// 로그 기록
			if (success > 0) {
			} else if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}

	public SecuveOTP getLicenseOne(int secuveOTPKeyNum) {
		return secuveOTPDao.getLicenseOne(secuveOTPKeyNum);
	}

	public String updateLicense(SecuveOTP license, Principal principal) {
		int success = secuveOTPDao.updateLicense(license);
		if(success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}

	public List listAll(SecuveOTP license) {
		return secuveOTPDao.listAll(license);
	}

}
