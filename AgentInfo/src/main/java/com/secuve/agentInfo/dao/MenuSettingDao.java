package com.secuve.agentInfo.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Compatibility;
import com.secuve.agentInfo.vo.MenuSetting;
import com.secuve.agentInfo.vo.ProductVersion;

@Repository
public class MenuSettingDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<MenuSetting> getMainMenuSettingList(MenuSetting search) {
		return sqlSession.selectList("menuSetting.getMainMenuSetting",search);
	}

	public int getMainMenuSettingListCount(MenuSetting search) {
		return sqlSession.selectOne("menuSetting.getMainMenuSettingCount", search);
	}

	public List<MenuSetting> getSubMenuSettingList(MenuSetting search) {
		return sqlSession.selectList("menuSetting.getSubMenuSetting",search);
	}

	public int getSubMenuSettingListCount(MenuSetting search) {
		return sqlSession.selectOne("menuSetting.getSubMenuSettingCount", search);
	}

	public int insertMenuSetting(MenuSetting menuSetting) {
		return sqlSession.insert("menuSetting.insertMenuSetting", menuSetting);
	}

	public MenuSetting getMenuSettingOne(int menuKeyNum) {
		return sqlSession.selectOne("menuSetting.getMenuSettingOne", menuKeyNum);
	}

	public int updateMenuSetting(MenuSetting menuSetting) {
		return sqlSession.update("menuSetting.updateMenuSetting", menuSetting);
	}

	public int delMenuSetting(int menuKeyNum) {
		return sqlSession.delete("menuSetting.delMenuSetting", menuKeyNum);
	}

	public List<MenuSetting> getMenuList() {
		return sqlSession.selectList("menuSetting.getMenuList");
	}

	public int getMenuSortCheck(MenuSetting menuSetting) {
		return sqlSession.selectOne("menuSetting.getMenuSortCheck", menuSetting);
	}

	public int getMenuTitleCheck(MenuSetting menuSetting) {
		return sqlSession.selectOne("menuSetting.getMenuTitleCheck", menuSetting);
	}

	public int getItemCheck(int mainKeyNum) {
		return sqlSession.selectOne("menuSetting.getItemCheck", mainKeyNum);
	}

	public List<MenuSetting> getItmeMenuSettingList(MenuSetting search) {
		return sqlSession.selectList("menuSetting.getItmeMenuSetting",search);
	}

	public int getItmeMenuSettingListCount(MenuSetting search) {
		return sqlSession.selectOne("menuSetting.getItmeMenuSettingListCount",search);
	}

	public List<MenuSetting> getMenuSettingItemList(int menuParentKeyNum) {
		return sqlSession.selectList("menuSetting.getMenuSettingItemList",menuParentKeyNum);
	}

	public List<Map<String,Object>> getMenuSettingItemListJoin(MenuSetting menuSetting) {
		return sqlSession.selectList("menuSetting.getMenuSettingItemListJoin",menuSetting);
	}

	public int getSortNumMax(MenuSetting menuSetting) {
		return sqlSession.selectOne("menuSetting.getSortNumMax",menuSetting);
	}

	public int getItemExistCheck(int menuKeyNum) {
		return sqlSession.selectOne("menuSetting.getItemExistCheck",menuKeyNum);
	}

	public int getSubExistCheck(int menuKeyNum) {
		return sqlSession.selectOne("menuSetting.getSubExistCheck",menuKeyNum);
	}

	public int getMaxMainSort() {
		return sqlSession.selectOne("menuSetting.getMaxMainSort");
	}

	public int getMaxSubSort(MenuSetting menuSetting) {
		return sqlSession.selectOne("menuSetting.getMaxSubSort", menuSetting);
	}

	public void setMenuItemSort(MenuSetting menuSetting) {
		sqlSession.update("menuSetting.setMenuItemSort", menuSetting);
	}


}
