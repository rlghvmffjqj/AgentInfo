package com.secuve.agentInfo.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.SendMailSetting;

@Repository
public class MailSendDao {
	@Autowired SqlSessionTemplate sqlSession;

	public SendMailSetting getTargetSetting(String sendMailSettingTarget) {
		return sqlSession.selectOne("mainSend.getTargetSetting", sendMailSettingTarget);
	}

	public int setMailSettingChange(SendMailSetting sendMailSetting) {
		return sqlSession.update("mainSend.setMailSettingChange", sendMailSetting);
	}

}
