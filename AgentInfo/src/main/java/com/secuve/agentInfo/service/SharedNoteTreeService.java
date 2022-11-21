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

import com.secuve.agentInfo.dao.SharedNoteDao;
import com.secuve.agentInfo.dao.SharedNoteTreeDao;
import com.secuve.agentInfo.vo.SharedNoteTree;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class SharedNoteTreeService {
	@Autowired SharedNoteTreeDao sharedNoteTreeDao;
	@Autowired SharedNoteDao sharedNoteDao;

	public List<SharedNoteTree> getSharedNoteTreeList(String parentPath, String sharedNoteTreeRegistrant) {
		List<SharedNoteTree> sharedNoteTreeList = sharedNoteTreeDao.getSharedNoteTreeList(parentPath, sharedNoteTreeRegistrant);
		return sharedNoteTreeList;
	}

	public String insertSharedNoteTree(SharedNoteTree sharedNoteTree) {
		int sucess = 0;
		if(sharedNoteTree.getSharedNoteTreeParentPath().equals("/")) {
			sharedNoteTree.setSharedNoteTreeFullPath("/"+sharedNoteTree.getSharedNoteTreeName());
		} else {
			sharedNoteTree.setSharedNoteTreeFullPath(sharedNoteTree.getSharedNoteTreeParentPath() + "/"+sharedNoteTree.getSharedNoteTreeName());
		}
		SharedNoteTree overlap = sharedNoteTreeDao.getSharedNoteTreeFullPath(sharedNoteTree.getSharedNoteTreeFullPath(), sharedNoteTree.getSharedNoteTreeRegistrant());
		if(sharedNoteTree.getSharedNoteTreeName() == "" || sharedNoteTree.getSharedNoteTreeName() == null) {
			return "Empty";
		}
		if(overlap == null) {
			sucess = sharedNoteTreeDao.insertSharedNoteTree(sharedNoteTree);
		} else {
			return "Overlap";
		}
		return resultReturn(sucess);
	}

	public String deleteSharedNoteTree(SharedNoteTree sharedNoteTree) {
		int sucess = 0;
		List<SharedNoteTree> subSharedNoteTree = sharedNoteTreeDao.getSharedNoteTreeParentPath(sharedNoteTree);
		if(subSharedNoteTree.size() == 0) {
			sucess = sharedNoteTreeDao.deleteSharedNoteTree(sharedNoteTree);
		} else {
			return "SubSharedNoteTree";
		}
		return resultReturn(sucess);
	}
	
	public String updateSharedNoteTree(SharedNoteTree sharedNoteTree) {
		if(sharedNoteTree.getNewSharedNoteTreeName() == "" || sharedNoteTree.getNewSharedNoteTreeName() == null) {
			return "Empty";
		}
		SharedNoteTree ordSharedNoteTree = (SharedNoteTree) sharedNoteTreeDao.getSharedNoteTreeFullPath(sharedNoteTree.getSharedNoteTreeFullPath(), sharedNoteTree.getSharedNoteTreeRegistrant());
		if(ordSharedNoteTree.getSharedNoteTreeParentPath().equals("/")) {
			sharedNoteTree.setNewSharedNoteTreeFullPath("/"+sharedNoteTree.getNewSharedNoteTreeName());
		} else {
			sharedNoteTree.setNewSharedNoteTreeFullPath(ordSharedNoteTree.getSharedNoteTreeParentPath()+"/"+sharedNoteTree.getNewSharedNoteTreeName());
		}
		
		SharedNoteTree overlap = sharedNoteTreeDao.getSharedNoteTreeFullPath(sharedNoteTree.getNewSharedNoteTreeFullPath(), sharedNoteTree.getSharedNoteTreeRegistrant());
		if(overlap == null) {
			ArrayList<SharedNoteTree> sharedNoteTreeFullPathList = new ArrayList<>(sharedNoteTreeDao.getSharedNoteTreeFullPathList(ordSharedNoteTree.getSharedNoteTreeFullPath()));
			for (SharedNoteTree newSharedNoteTree : sharedNoteTreeFullPathList) {
				String ordSharedNoteTreeFullPath = newSharedNoteTree.getSharedNoteTreeFullPath();
				String newSharedNoteTreeFullPath = ordSharedNoteTreeFullPath.replaceFirst(sharedNoteTree.getSharedNoteTreeFullPath(), sharedNoteTree.getNewSharedNoteTreeFullPath());
				ordSharedNoteTree = parseFullPath(newSharedNoteTreeFullPath, ordSharedNoteTree);
				
				// 부서 테이블 변경
				sharedNoteTreeDao.updateTree(ordSharedNoteTreeFullPath, ordSharedNoteTree.getSharedNoteTreeFullPath(), ordSharedNoteTree.getSharedNoteTreeParentPath(), ordSharedNoteTree.getSharedNoteTreeName(), sharedNoteTree.getSharedNoteTreeModifier(), sharedNoteTree.getSharedNoteTreeModifiedDate(), sharedNoteTree.getSharedNoteTreeRegistrant());

				// 해당 부서의 사원정보 모두 변경
				sharedNoteDao.updateTree(ordSharedNoteTreeFullPath, ordSharedNoteTree.getSharedNoteTreeFullPath(), ordSharedNoteTree.getSharedNoteTreeParentPath(), ordSharedNoteTree.getSharedNoteTreeName(), sharedNoteTree.getSharedNoteTreeModifier(), sharedNoteTree.getSharedNoteTreeModifiedDate(), sharedNoteTree.getSharedNoteTreeRegistrant());
			}
			
		} else {
			return "Overlap";
		}
		return "OK";
	}
	
	public SharedNoteTree parseFullPath(String newSharedNoteTreeFullPath, SharedNoteTree ordSharedNoteTree) {
		if (newSharedNoteTreeFullPath.startsWith("/")) {
			ordSharedNoteTree.setSharedNoteTreeFullPath(newSharedNoteTreeFullPath);
			int pos = newSharedNoteTreeFullPath.lastIndexOf('/');
			if (pos > 0) {
				ordSharedNoteTree.setSharedNoteTreeParentPath(newSharedNoteTreeFullPath.substring(0, pos));
				ordSharedNoteTree.setSharedNoteTreeName(newSharedNoteTreeFullPath.substring(pos + 1));
			} else {
				ordSharedNoteTree.setSharedNoteTreeParentPath("/");
				ordSharedNoteTree.setSharedNoteTreeName(newSharedNoteTreeFullPath.substring(pos + 1));
			}
		} else {
		}
		return ordSharedNoteTree;
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
