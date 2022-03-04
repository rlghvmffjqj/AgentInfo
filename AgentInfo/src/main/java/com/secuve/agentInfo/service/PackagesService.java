package com.secuve.agentInfo.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.secuve.agentInfo.core.excel.ExcelRead;
import com.secuve.agentInfo.dao.PackagesDao;
import com.secuve.agentInfo.vo.ExcelReadOption;
import com.secuve.agentInfo.vo.Packages;

@Service
public class PackagesService {
	@Autowired PackagesDao packagesDao;
	@Autowired Packages packages;
	
	private XSSFWorkbook workbook;
    private XSSFSheet sheet;
    private List<Packages> listUsers;
     

	public List<Packages> getPackagesList(Packages search) {
		return packagesDao.getPackagesList(search);
	}

	public int getPackagesListCount(Packages search) {
		return packagesDao.getPackagesListCount(search);
	}

	public String delPackages(int[] chkList) {
		for(int packagesKeyNum: chkList) {
			int sucess = packagesDao.delPackages(packagesKeyNum);
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	public String insertPackages(Packages packages) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "" ) { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		} 
		
		packages.setPackagesKeyNum(packagesDao.getPackagesKeyNum()+1);
		int sucess = packagesDao.insertPackages(packages);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	public Packages getPackagesOne(int packagesKeyNum) {
		return packagesDao.getPackagesOne(packagesKeyNum);
	}

	public String updatePackages(Packages packages) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		int sucess = packagesDao.updatePackages(packages);
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}
	
	
	
	
	
	public void excelUpload(File destFile) {
       ExcelReadOption excelReadOption = new ExcelReadOption();
       
       //파일경로 추가
       excelReadOption.setFilePath(destFile.getAbsolutePath());
       
       //추출할 컬럼명 추가
       excelReadOption.setOutputColumns("A", "B", "C");
       
       //시작행
       excelReadOption.setStartRow(2);
       
       List<Map<String, String>>excelContent  = ExcelRead.read(excelReadOption);
       
       Map<String, Object> paramMap = new HashMap<String, Object>();
       paramMap.put("excelContent", excelContent);
       
       try {
           //sampleDAO.insertExcel(paramMap);
    	   System.out.println(paramMap);
       }catch(Exception e) {
           e.printStackTrace();
       }
   }

	   


	public List<Packages> listAll(Packages packages) {
		return packagesDao.getPackagesListAll(packages);
	}


}
