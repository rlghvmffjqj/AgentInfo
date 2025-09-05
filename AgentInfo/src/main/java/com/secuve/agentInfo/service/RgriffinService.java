package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.RgriffinDao;
import com.secuve.agentInfo.vo.Rgriffin;

@Service
public class RgriffinService {
	@Autowired RgriffinDao rgriffinDao;

	public String licenseInsert(Rgriffin license) {
		int success = rgriffinDao.licenseInsert(license);
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

	public List<Rgriffin> getLicenseList(Rgriffin search) {
		 return rgriffinDao.getLicenseList(search);
	}

	public int getLicenseListCount(Rgriffin search) {
		return rgriffinDao.getLicenseListCount(search);
	}

	public String delLicense(int[] chkList, Principal principal) {
		for (int rgriffinKeyNum : chkList) {
			int success = rgriffinDao.delLicense(rgriffinKeyNum);

			// 로그 기록
			if (success > 0) {
			} else if (success <= 0) {
				return "FALSE";
			}
		}
		return "OK";
	}

	public Rgriffin getLicenseOne(int rgriffinKeyNum) {
		return rgriffinDao.getLicenseOne(rgriffinKeyNum);
	}

	public String updateLicense(Rgriffin license, Principal principal) {
		int success = rgriffinDao.updateLicense(license);
		if(success > 0) {
			return "OK";
		} else {
			return "FALSE";
		}
	}

	public List listAll(Rgriffin license) {
		return rgriffinDao.listAll(license);
	}

}
