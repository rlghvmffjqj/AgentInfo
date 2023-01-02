package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.IndividualNoteDao;
import com.secuve.agentInfo.dao.IndividualNoteTreeDao;
import com.secuve.agentInfo.vo.IndividualNoteTree;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class IndividualNoteTreeService {
	@Autowired IndividualNoteTreeDao individualNoteTreeDao;
	@Autowired IndividualNoteDao individualNoteDao;

	public List<IndividualNoteTree> getIndividualNoteTreeList(String parentPath, String individualNoteTreeRegistrant) {
		List<IndividualNoteTree> individualNoteTreeList = individualNoteTreeDao.getIndividualNoteTreeList(parentPath, individualNoteTreeRegistrant);
		return individualNoteTreeList;
	}

	public String insertIndividualNoteTree(IndividualNoteTree individualNoteTree) {
		int sucess = 0;
		if(individualNoteTree.getIndividualNoteTreeName().contains("/")) {
			return "Slash";
		}
		if(individualNoteTree.getIndividualNoteTreeParentPath().equals("/")) {
			individualNoteTree.setIndividualNoteTreeFullPath("/"+individualNoteTree.getIndividualNoteTreeName());
		} else {
			individualNoteTree.setIndividualNoteTreeFullPath(individualNoteTree.getIndividualNoteTreeParentPath() + "/"+individualNoteTree.getIndividualNoteTreeName());
		}
		IndividualNoteTree overlap = individualNoteTreeDao.getIndividualNoteTreeFullPath(individualNoteTree.getIndividualNoteTreeFullPath(), individualNoteTree.getIndividualNoteTreeRegistrant());
		if(individualNoteTree.getIndividualNoteTreeName() == "" || individualNoteTree.getIndividualNoteTreeName() == null) {
			return "Empty";
		}
		if(overlap == null) {
			sucess = individualNoteTreeDao.insertIndividualNoteTree(individualNoteTree);
		} else {
			return "Overlap";
		}
		return resultReturn(sucess);
	}

	public String deleteIndividualNoteTree(IndividualNoteTree individualNoteTree) {
		int sucess = 0;
		List<IndividualNoteTree> subIndividualNoteTree = individualNoteTreeDao.getIndividualNoteTreeParentPath(individualNoteTree);
		if(subIndividualNoteTree.size() == 0) {
			sucess = individualNoteTreeDao.deleteIndividualNoteTree(individualNoteTree);
		} else {
			return "SubIndividualNoteTree";
		}
		return resultReturn(sucess);
	}
	
	public String updateIndividualNoteTree(IndividualNoteTree individualNoteTree) {
		if(individualNoteTree.getNewIndividualNoteTreeName() == "" || individualNoteTree.getNewIndividualNoteTreeName() == null) {
			return "Empty";
		}
		if(individualNoteTree.getNewIndividualNoteTreeName().contains("/")) {
			return "Slash";
		}
		IndividualNoteTree ordIndividualNoteTree = (IndividualNoteTree) individualNoteTreeDao.getIndividualNoteTreeFullPath(individualNoteTree.getIndividualNoteTreeFullPath(), individualNoteTree.getIndividualNoteTreeRegistrant());
		if(ordIndividualNoteTree.getIndividualNoteTreeParentPath().equals("/")) {
			individualNoteTree.setNewIndividualNoteTreeFullPath("/"+individualNoteTree.getNewIndividualNoteTreeName());
		} else {
			individualNoteTree.setNewIndividualNoteTreeFullPath(ordIndividualNoteTree.getIndividualNoteTreeParentPath()+"/"+individualNoteTree.getNewIndividualNoteTreeName());
		}
		
		IndividualNoteTree overlap = individualNoteTreeDao.getIndividualNoteTreeFullPath(individualNoteTree.getNewIndividualNoteTreeFullPath(), individualNoteTree.getIndividualNoteTreeRegistrant());
		if(overlap == null) {
			ArrayList<IndividualNoteTree> individualNoteTreeFullPathList = new ArrayList<>(individualNoteTreeDao.getIndividualNoteTreeFullPathList(ordIndividualNoteTree.getIndividualNoteTreeFullPath()));
			for (IndividualNoteTree newIndividualNoteTree : individualNoteTreeFullPathList) {
				String ordIndividualNoteTreeFullPath = newIndividualNoteTree.getIndividualNoteTreeFullPath();
				String newIndividualNoteTreeFullPath = ordIndividualNoteTreeFullPath.replaceFirst(individualNoteTree.getIndividualNoteTreeFullPath(), individualNoteTree.getNewIndividualNoteTreeFullPath());
				ordIndividualNoteTree = parseFullPath(newIndividualNoteTreeFullPath, ordIndividualNoteTree);
				
				// 부서 테이블 변경
				individualNoteTreeDao.updateTree(ordIndividualNoteTreeFullPath, ordIndividualNoteTree.getIndividualNoteTreeFullPath(), ordIndividualNoteTree.getIndividualNoteTreeParentPath(), ordIndividualNoteTree.getIndividualNoteTreeName(), individualNoteTree.getIndividualNoteTreeModifier(), individualNoteTree.getIndividualNoteTreeModifiedDate(), individualNoteTree.getIndividualNoteTreeRegistrant());

				// 해당 부서의 사원정보 모두 변경
				individualNoteDao.updateTree(ordIndividualNoteTreeFullPath, ordIndividualNoteTree.getIndividualNoteTreeFullPath(), ordIndividualNoteTree.getIndividualNoteTreeParentPath(), ordIndividualNoteTree.getIndividualNoteTreeName(), individualNoteTree.getIndividualNoteTreeModifier(), individualNoteTree.getIndividualNoteTreeModifiedDate(), individualNoteTree.getIndividualNoteTreeRegistrant());
			}
			
		} else {
			return "Overlap";
		}
		return "OK";
	}
	
	public IndividualNoteTree parseFullPath(String newIndividualNoteTreeFullPath, IndividualNoteTree ordIndividualNoteTree) {
		if (newIndividualNoteTreeFullPath.startsWith("/")) {
			ordIndividualNoteTree.setIndividualNoteTreeFullPath(newIndividualNoteTreeFullPath);
			int pos = newIndividualNoteTreeFullPath.lastIndexOf('/');
			if (pos > 0) {
				ordIndividualNoteTree.setIndividualNoteTreeParentPath(newIndividualNoteTreeFullPath.substring(0, pos));
				ordIndividualNoteTree.setIndividualNoteTreeName(newIndividualNoteTreeFullPath.substring(pos + 1));
			} else {
				ordIndividualNoteTree.setIndividualNoteTreeParentPath("/");
				ordIndividualNoteTree.setIndividualNoteTreeName(newIndividualNoteTreeFullPath.substring(pos + 1));
			}
		} else {
		}
		return ordIndividualNoteTree;
	}
	
	public String resultReturn(int sucess) {
		if(sucess > 0) {
			return "OK";
		}
		return "FAIL";
	}

	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
}
