package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.TrashDao;
import com.secuve.agentInfo.vo.Trash;

@Service
public class TrashService {
	@Autowired TrashDao trashDao;

	public List<Trash> getTrashList(Trash serach) {
		return trashDao.getTrashList(serach);
	}

	public int getTrashListCount() {
		return trashDao.getTrashListCount();
	}

}
