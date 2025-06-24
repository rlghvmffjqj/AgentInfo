package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.MenuSetting;

@Repository
public class MenuSettingDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<MenuSetting> getMainMenuSettingList(MenuSetting search) {
		return sqlSession.selectList("menuSetting.getMainMenuSetting",search);
	}

	public int getMainMenuSettingListCount() {
		return sqlSession.selectOne("menuSetting.getMainMenuSettingCount");
	}

	public List<MenuSetting> getSubMenuSettingList(MenuSetting search) {
		return sqlSession.selectList("menuSetting.getSubMenuSetting",search);
	}

	public int getSubMenuSettingListCount() {
		return sqlSession.selectOne("menuSetting.getSubMenuSettingCount");
	}

}
