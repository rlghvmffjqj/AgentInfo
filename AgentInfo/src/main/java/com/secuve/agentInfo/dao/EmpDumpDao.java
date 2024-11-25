package com.secuve.agentInfo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.empDump.IfUser;
import com.secuve.agentInfo.vo.empDump.NACView;
import com.secuve.agentInfo.vo.empDump.Shinhanlife;
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
		return sqlSession.selectList("empDump.samsunglifeEmpAll");
	}

	public List<ViewSamsung> samsunglifePartnerAll() {
		return sqlSession.selectList("empDump.samsunglifePartnerAll");
	}

	public List<Shinhanlife> getShinhanlifeData(Shinhanlife search) {
		return sqlSession.selectList("empDump.getShinhanlifeData", search);
	}

	public int getShinhanlifeDataCount() {
		return sqlSession.selectOne("empDump.getShinhanlifeDataCount");
	}

	public void shinhanlifeDelete() {
		sqlSession.delete("empDump.shinhanlifeDelete");
	}

	public void shinhanlifeInsert(Shinhanlife user) {
		sqlSession.insert("empDump.shinhanlifeInsert", user);
	}

	public List<Shinhanlife> shinhanlifeAll() {
		return sqlSession.selectList("empDump.shinhanlifeAll");
	}

	public List<NACView> getFinnqData(NACView search) {
		return sqlSession.selectList("empDump.getFinnqData", search);
	}

	public int getFinnqDataCount() {
		return sqlSession.selectOne("empDump.getFinnqDataCount");
	}

	public void finnqDelete() {
		sqlSession.delete("empDump.finnqDelete");
	}

	public void finnqInsert(NACView user) {
		sqlSession.insert("empDump.finnqInsert", user);
	}

	public List<NACView> finnqAll() {
		return sqlSession.selectList("empDump.finnqAll");
	}
}
