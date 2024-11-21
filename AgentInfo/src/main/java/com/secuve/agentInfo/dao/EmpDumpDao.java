package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.empDump.IfUser;
import com.secuve.agentInfo.vo.empDump.ViewNac;
import com.secuve.agentInfo.vo.empDump.ViewSamsung;
import com.secuve.agentInfo.vo.empDump.VwUser;

@Repository
public class EmpDumpDao {
	@Autowired SqlSessionTemplate sqlSession;


	public List<IfUser> getNHLifeDataList(IfUser search) {
		return sqlSession.selectList("empDump.getNHLifeDataList",search);
	}


	public int getNHLifeDataCount() {
		return sqlSession.selectOne("empDump.getNHLifeDataCount");
	}


	public void nhLifeInsert(IfUser user) {
		sqlSession.insert("empDump.nhLifeInsert",user);
	}


	public void nhLifeDelete() {
		sqlSession.delete("empDump.nhLifeDelete");
	}


	public List<IfUser> nhLifeAll() {
		return sqlSession.selectList("empDump.nhLifeAll");
	}


	public List<VwUser> getKbankDataList(VwUser search) {
		return sqlSession.selectList("empDump.getKbankDataList",search);
	}


	public int getKbankDataCount() {
		return sqlSession.selectOne("empDump.getKbankDataCount");
	}


	public void kbankInsert(VwUser user) {
		sqlSession.insert("empDump.kbankInsert",user);
	}


	public void kbankDelete() {
		sqlSession.delete("empDump.kbankDelete");
	}


	public List<VwUser> kbankAll() {
		return sqlSession.selectList("empDump.kbankAll");
	}


	public void nhqvDelete() {
		sqlSession.delete("empDump.nhqvDelete");
	}


	public void nhqvInsert(ViewNac user) {
		sqlSession.insert("empDump.nhqvInsert",user);
	}


	public List<ViewNac> getNhqvData(ViewNac search) {
		return sqlSession.selectList("empDump.getNhqvData",search);
	}


	public List<ViewNac> nhqvAll() {
		return sqlSession.selectList("empDump.nhqvAll");
	}


	public void samsunglifeDelete() {
		sqlSession.delete("empDump.samsunglifeDeleteEmp");
		sqlSession.delete("empDump.samsunglifeDeletePart");
	}


	public void empSamsunglifeInsert(ViewSamsung user) {
		sqlSession.insert("empDump.empSamsunglifeInsert",user);
	}


	public void partnerSamsunglifeInsert(ViewSamsung user) {
		sqlSession.insert("empDump.partnerSamsunglifeInsert",user);
	}


	public List<ViewSamsung> getSamsunglifeData(ViewSamsung search) {
		return sqlSession.selectList("empDump.getSamsunglifeData",search);
	}


	public int getSamsunglifeDataCount() {
		return sqlSession.selectOne("empDump.getSamsunglifeDataCount");
	}


	public List<ViewSamsung> samsunglifeEmpAll() {
		// TODO Auto-generated method stub
		return null;
	}
}
