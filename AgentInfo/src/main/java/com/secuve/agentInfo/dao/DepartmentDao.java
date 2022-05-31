package com.secuve.agentInfo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.secuve.agentInfo.vo.Department;

@Repository
public class DepartmentDao {
	@Autowired SqlSessionTemplate sqlSession;

	public List<Department> getDepartmentList(String parentPath) {
		return sqlSession.selectList("department.getDepartmentList", parentPath);
	}

	public int insertDepartment(Department department) {
		return sqlSession.insert("department.insertDepartment", department);
	}

	public Department getDepartmentFullPath(String departmentFullPath) {
		return sqlSession.selectOne("department.getDepartmentFullPath",departmentFullPath);
	}

	public List<Department> getDepartmentParentPath(String departmentFullPath) {
		return sqlSession.selectList("department.getDepartmentParentPath",departmentFullPath);
	}

	public int deleteDepartment(Department department) {
		return sqlSession.delete("department.deleteDepartment",department);
	}

	public List<Department> getDepartmentFullPathList(String departmentFullPath) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("departmentFullPath", departmentFullPath);
		parameters.put("departmentParentPath", departmentFullPath + "/%");
		return sqlSession.selectList("department.getDepartmentFullPathList", parameters);
	}

	public int updateDept(String ordDepartmentFullPath, String departmentFullPath, String departmentParentPath, String departmentName) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("ordDepartmentFullPath", ordDepartmentFullPath);
		parameters.put("departmentFullPath", departmentFullPath);
		parameters.put("departmentParentPath", departmentParentPath);
		parameters.put("departmentName", departmentName);
		return sqlSession.insert("department.updateDept", parameters);
	}
}