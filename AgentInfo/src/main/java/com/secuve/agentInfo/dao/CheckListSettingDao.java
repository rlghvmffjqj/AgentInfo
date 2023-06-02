package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.CheckListSetting;

@Repository
public class CheckListSettingDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<CheckListSetting> checkListSettingForm() {
		return sqlSession.selectList("checkListSetting.checkListSettingForm");
	}
}
