package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.RGRIFFINDao;
import com.secuve.agentInfo.vo.LogGriffin;
import com.secuve.agentInfo.vo.RGRIFFIN;

@Service
public class RGRIFFINService {
	@Autowired RGRIFFINDao rGRIFFINDao;

	public String licenseInsert(RGRIFFIN license) {
		int success = rGRIFFINDao.licenseInsert(license);
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

	public List<RGRIFFIN> getLicenseList(RGRIFFIN search) {
		 return rGRIFFINDao.getLicenseList(search);
	}

	public int getLicenseListCount(RGRIFFIN search) {
		return rGRIFFINDao.getLicenseListCount(search);
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int rGRIFFINKeyNum : chkList) {
			int success = rGRIFFINDao.delLicense(rGRIFFINKeyNum);

			// 로그 기록
			if (success > 0) {
			} else if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}

	public RGRIFFIN getLicenseOne(int rGRIFFINKeyNum) {
		return rGRIFFINDao.getLicenseOne(rGRIFFINKeyNum);
	}

	public String updateLicense(RGRIFFIN license, Principal principal) {
		int success = rGRIFFINDao.updateLicense(license);
		if(success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}

	public List listAll(RGRIFFIN license) {
		return rGRIFFINDao.listAll(license);
	}

}
