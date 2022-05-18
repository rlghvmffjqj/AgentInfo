package com.secuve.agentInfo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.dao.DepartmentDao;
import com.secuve.agentInfo.dao.EmployeeDao;
import com.secuve.agentInfo.vo.Department;


@Service
public class DepartmentService {
	@Autowired DepartmentDao departmentDao;
	@Autowired EmployeeDao employeeDao;

	public List<Department> getDepartmentList(String parentPath) {
		List<Department> departmentList = departmentDao.getDepartmentList(parentPath);
		return departmentList;
	}

	public String insertDepartment(Department department) {
		int sucess = 0;
		if(department.getDepartmentParentPath().equals("/")) {
			department.setDepartmentFullPath("/"+department.getDepartmentName());
		} else {
			department.setDepartmentFullPath(department.getDepartmentParentPath() + "/"+department.getDepartmentName());
		}
		Department overlap = departmentDao.getDepartmentFullPath(department.getDepartmentFullPath());
		if(department.getDepartmentName() == "" || department.getDepartmentName() == null) {
			return "Empty";
		}
		if(overlap == null) {
			sucess = departmentDao.insertDepartment(department);
		} else {
			return "Overlap";
		}
		return resultReturn(sucess);
	}

	public String deleteDepartment(Department department) {
		int sucess = 0;
		List<Department> subDepartment = departmentDao.getDepartmentParentPath(department.getDepartmentFullPath());
		if(subDepartment.size() == 0) {
			sucess = departmentDao.deleteDepartment(department);
		} else {
			return "SubDepartment";
		}
		return resultReturn(sucess);
	}
	
	public String updateDepartment(Department department) {
		if(department.getNewDepartmentName() == "" || department.getNewDepartmentName() == null) {
			return "Empty";
		}
		Department ordDepartment = (Department) departmentDao.getDepartmentFullPath(department.getDepartmentFullPath());
		if(ordDepartment.getDepartmentParentPath().equals("/")) {
			department.setNewDepartmentFullPath("/"+department.getNewDepartmentName());
		} else {
			department.setNewDepartmentFullPath(ordDepartment.getDepartmentParentPath()+"/"+department.getNewDepartmentName());
		}
		
		Department overlap = departmentDao.getDepartmentFullPath(department.getNewDepartmentFullPath());
		if(overlap == null) {
			ArrayList<Department> departmentFullPathList = new ArrayList<>(departmentDao.getDepartmentFullPathList(ordDepartment.getDepartmentFullPath()));
			for (Department newDepartment : departmentFullPathList) {
				String ordDepartmentFullPath = newDepartment.getDepartmentFullPath();
				String newDepartmentFullPath = ordDepartmentFullPath.replaceFirst(department.getDepartmentFullPath(), department.getNewDepartmentFullPath());
				ordDepartment = parseFullPath(newDepartmentFullPath, ordDepartment);
				
				// 부서 테이블 변경
				departmentDao.updateDept(ordDepartmentFullPath, ordDepartment.getDepartmentFullPath(), ordDepartment.getDepartmentParentPath(), ordDepartment.getDepartmentName());

				// 해당 부서의 사원정보 모두 변경
				employeeDao.updateDept(ordDepartmentFullPath, ordDepartment.getDepartmentFullPath(), ordDepartment.getDepartmentParentPath(), ordDepartment.getDepartmentName());
			}
			
		} else {
			return "Overlap";
		}
		return "OK";
	}
	
	public Department parseFullPath(String newDepartmentFullPath, Department ordDepartment) {
		if (newDepartmentFullPath.startsWith("/")) {
			ordDepartment.setDepartmentFullPath(newDepartmentFullPath);
			int pos = newDepartmentFullPath.lastIndexOf('/');
			if (pos > 0) {
				ordDepartment.setDepartmentParentPath(newDepartmentFullPath.substring(0, pos));
				ordDepartment.setDepartmentName(newDepartmentFullPath.substring(pos + 1));
			} else {
				ordDepartment.setDepartmentParentPath("/");
				ordDepartment.setDepartmentName(newDepartmentFullPath.substring(pos + 1));
			}
		} else {
		}
		return ordDepartment;
	}
	
	public String resultReturn(int sucess) {
		if(sucess > 0) {
			return "OK";
		}
		return "FAIL";
	}

	
}
