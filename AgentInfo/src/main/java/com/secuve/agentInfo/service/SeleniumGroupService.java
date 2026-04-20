package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.SeleniumGroupDao;
import com.secuve.agentInfo.dao.SeleniumDao;
import com.secuve.agentInfo.vo.SeleniumGroup;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class SeleniumGroupService {
	
	@Autowired SeleniumGroupDao seleniumGroupDao;
	@Autowired SeleniumDao seleniumDao;

	public List<SeleniumGroup> getSeleniumGroupList(String parentPath) {
		List<SeleniumGroup> seleniumGroupList = seleniumGroupDao.getSeleniumGroupList(parentPath);
		return seleniumGroupList;
	}

	public String insertSeleniumGroup(SeleniumGroup seleniumGroup) {
		int success = 0;
		if(seleniumGroup.getSeleniumGroupParentPath().equals("/")) {
			seleniumGroup.setSeleniumGroupFullPath("/"+seleniumGroup.getSeleniumGroupName());
		} else {
			seleniumGroup.setSeleniumGroupFullPath(seleniumGroup.getSeleniumGroupParentPath() + "/"+seleniumGroup.getSeleniumGroupName());
		}
		SeleniumGroup overlap = seleniumGroupDao.getSeleniumGroupFullPath(seleniumGroup.getSeleniumGroupFullPath());
		if(seleniumGroup.getSeleniumGroupName() == "" || seleniumGroup.getSeleniumGroupName() == null) {
			return "Empty";
		}
		if(overlap == null) {
			success = seleniumGroupDao.insertSeleniumGroup(seleniumGroup);
		} else {
			return "Overlap";
		}
		return resultReturn(success);
	}

	public String deleteSeleniumGroup(SeleniumGroup seleniumGroup) {
		int success = 0;
		List<SeleniumGroup> subSeleniumGroup = seleniumGroupDao.getSeleniumGroupParentPath(seleniumGroup.getSeleniumGroupFullPath());
		if(subSeleniumGroup.size() == 0) {
			success = seleniumGroupDao.deleteSeleniumGroup(seleniumGroup);
		} else {
			return "SubSeleniumGroup";
		}
		return resultReturn(success);
	}
	
	public String updateSeleniumGroup(SeleniumGroup seleniumGroup) {
		if(seleniumGroup.getNewSeleniumGroupName() == "" || seleniumGroup.getNewSeleniumGroupName() == null) {
			return "Empty";
		}
		SeleniumGroup ordSeleniumGroup = (SeleniumGroup) seleniumGroupDao.getSeleniumGroupFullPath(seleniumGroup.getSeleniumGroupFullPath());
		if(ordSeleniumGroup.getSeleniumGroupParentPath().equals("/")) {
			seleniumGroup.setNewSeleniumGroupFullPath("/"+seleniumGroup.getNewSeleniumGroupName());
		} else {
			seleniumGroup.setNewSeleniumGroupFullPath(ordSeleniumGroup.getSeleniumGroupParentPath()+"/"+seleniumGroup.getNewSeleniumGroupName());
		}
		
		SeleniumGroup overlap = seleniumGroupDao.getSeleniumGroupFullPath(seleniumGroup.getNewSeleniumGroupFullPath());
		if(overlap == null) {
			ArrayList<SeleniumGroup> seleniumGroupFullPathList = new ArrayList<>(seleniumGroupDao.getSeleniumGroupFullPathList(ordSeleniumGroup.getSeleniumGroupFullPath()));
			for (SeleniumGroup newSeleniumGroup : seleniumGroupFullPathList) {
				String ordSeleniumGroupFullPath = newSeleniumGroup.getSeleniumGroupFullPath();
				String newSeleniumGroupFullPath = ordSeleniumGroupFullPath.replaceFirst(seleniumGroup.getSeleniumGroupFullPath(), seleniumGroup.getNewSeleniumGroupFullPath());
				ordSeleniumGroup = parseFullPath(newSeleniumGroupFullPath, ordSeleniumGroup);
				
				// 부서 테이블 변경
				seleniumGroupDao.updateGroup(ordSeleniumGroupFullPath, ordSeleniumGroup.getSeleniumGroupFullPath(), ordSeleniumGroup.getSeleniumGroupParentPath(), ordSeleniumGroup.getSeleniumGroupName());

				// 해당 부서의 사원정보 모두 변경
				seleniumDao.updateGroup(ordSeleniumGroupFullPath, ordSeleniumGroup.getSeleniumGroupFullPath(), ordSeleniumGroup.getSeleniumGroupParentPath(), ordSeleniumGroup.getSeleniumGroupName());
			}
			
		} else {
			return "Overlap";
		}
		return "OK";
	}
	
	public SeleniumGroup parseFullPath(String newSeleniumGroupFullPath, SeleniumGroup ordSeleniumGroup) {
		if (newSeleniumGroupFullPath.startsWith("/")) {
			ordSeleniumGroup.setSeleniumGroupFullPath(newSeleniumGroupFullPath);
			int pos = newSeleniumGroupFullPath.lastIndexOf('/');
			if (pos > 0) {
				ordSeleniumGroup.setSeleniumGroupParentPath(newSeleniumGroupFullPath.substring(0, pos));
				ordSeleniumGroup.setSeleniumGroupName(newSeleniumGroupFullPath.substring(pos + 1));
			} else {
				ordSeleniumGroup.setSeleniumGroupParentPath("/");
				ordSeleniumGroup.setSeleniumGroupName(newSeleniumGroupFullPath.substring(pos + 1));
			}
		} else {
		}
		return ordSeleniumGroup;
	}
	
	public String resultReturn(int success) {
		if(success > 0) {
			return "OK";
		}
		return "FAIL";
	}

}
