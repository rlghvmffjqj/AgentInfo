package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SendPackage;

@Repository
public class SendPackageDao {
	@Autowired SqlSessionTemplate sqlSession;

	public int insertSendPackage(SendPackage sendPackage) {
		return sqlSession.insert("sendPackage.insertSendPackage", sendPackage);
	}

	public List<SendPackage> getSendPackage(SendPackage search) {
		return sqlSession.selectList("sendPackage.getSendPackage", search);
	}

	public int getSendPackageCount(SendPackage search) {
		return sqlSession.selectOne("sendPackage.getSendPackageCount", search);
	}

	public void downloadCount(String sendPackageName, String sendPackageRandomUrl) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sendPackageName", sendPackageName);
		parameters.put("sendPackageRandomUrl", sendPackageRandomUrl);
		sqlSession.update("sendPackage.downloadCount", parameters);
	}

	public int deleteSendPackage(int sendPackageKeyNum) {
		return sqlSession.delete("sendPackage.deleteSendPackage",sendPackageKeyNum);
	}

	public SendPackage getSendPackageOne(int sendPackageKeyNum) {
		return sqlSession.selectOne("sendPackage.getSendPackageOne", sendPackageKeyNum);
	}

	public List<SendPackage> getSendPackageListOne(String sendPackageRandomUrl) {
		return sqlSession.selectList("sendPackage.getSendPackageListOne", sendPackageRandomUrl);
	}

	public int downloadLimitCount(String sendPackageName, String sendPackageRandomUrl) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sendPackageName", sendPackageName);
		parameters.put("sendPackageRandomUrl", sendPackageRandomUrl);
		return sqlSession.selectOne("sendPackage.downloadLimitCount", parameters);
	}

	public void deleteSendPackageCountOver(String sendPackageName, String sendPackageRandomUrl) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sendPackageName", sendPackageName);
		parameters.put("sendPackageRandomUrl", sendPackageRandomUrl);
		sqlSession.delete("sendPackage.deleteSendPackageCountOver", parameters);
		
	}

	public void updateSendPackageFlag(String sendPackageName, String sendPackageRandomUrl) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("sendPackageName", sendPackageName);
		parameters.put("sendPackageRandomUrl", sendPackageRandomUrl);
		sqlSession.update("sendPackage.updateSendPackageFlag", parameters);
	}

	public int getRandomUrlCheck(String sendPackageRandomUrl) {
		return sqlSession.selectOne("sendPackage.getRandomUrlCheck", sendPackageRandomUrl);
	}

	public int updateSendPackageFlagKey(int sendPackageKeyNum) {
		return sqlSession.update("sendPackage.updateSendPackageFlagKey",sendPackageKeyNum);
	}

	public int updateSendPackage(SendPackage sendPackage) {
		return sqlSession.update("sendPackage.updateSendPackage",sendPackage);
	}

}
