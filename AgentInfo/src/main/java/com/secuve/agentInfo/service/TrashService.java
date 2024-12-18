package com.secuve.agentInfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.TrashDao;
import com.secuve.agentInfo.vo.Trash;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class TrashService {
	@Autowired TrashDao trashDao;

	public List<Trash> getTrashList(Trash search) {
		return trashDao.getTrashList(search);
	}

	public int getTrashListCount() {
		return trashDao.getTrashListCount();
	}
}