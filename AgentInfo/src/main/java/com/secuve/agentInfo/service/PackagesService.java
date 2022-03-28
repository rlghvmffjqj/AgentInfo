package com.secuve.agentInfo.service;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.PackagesDao;
import com.secuve.agentInfo.vo.Packages;
import com.secuve.agentInfo.vo.UIDLog;

@Service
public class PackagesService {
	@Autowired PackagesDao packagesDao;
	@Autowired Packages packages;
	
	/**
	 * 패키지 리스트 조회
	 * @param search
	 * @return
	 */
	public List<Packages> getPackagesList(Packages search) {
		return packagesDao.getPackagesList(search);
	}

	/**
	 * 패키지 Key Num 조회
	 * @param search
	 * @return
	 */
	public int getPackagesListCount(Packages search) {
		return packagesDao.getPackagesListCount(search);
	}

	/**
	 * 패키지 삭제
	 * @param chkList
	 * @param principal 
	 * @return
	 */
	public String delPackages(int[] chkList, Principal principal) {
		for(int packagesKeyNum: chkList) {
			Packages packages = packagesDao.getPackagesOne(packagesKeyNum);
			int sucess = packagesDao.delPackages(packagesKeyNum);
			
			// uid 로그 기록
			if(sucess > 0) 
				uidLog(packages, principal, "DELETE");
			
			if(sucess <= 0) 
				return "FALSE";
		}
		return "OK";
	}

	/**
	 * 패키지 추가
	 * @param packages
	 * @param principal 
	 * @return
	 */
	public String insertPackages(Packages packages, Principal principal) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "" ) { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		} 
		int packageKeyNum = 0;
		try {
			packageKeyNum = packagesDao.getPackagesKeyNum();
		} catch (Exception e) {
		}
		packages.setPackagesKeyNum(++packageKeyNum);
		int sucess = packagesDao.insertPackages(packages);
		
		// uid 로그 기록
		if(sucess > 0) 
			uidLog(packages, principal, "INSERT");
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}
	
	public String copyPackages(Packages packages, Principal principal) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "" ) { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		} 
		packagesDao.plusPackagesKeyNum(packages.getPackagesKeyNum()); // 복사 대상 이상의 키값을 +1 해준다.
		
		packages.setPackagesKeyNum(packages.getPackagesKeyNum()+1); // 복사 대상의 윗 번호로 값 변경
		int sucess = packagesDao.insertPackages(packages);
		
		// uid 로그 기록
		if(sucess > 0) 
			uidLog(packages, principal, "INSERT");
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	/**
	 * 패키지 Key Num으로 하나의 정보 조회
	 * @param packagesKeyNum
	 * @return
	 */
	public Packages getPackagesOne(int packagesKeyNum) {
		return packagesDao.getPackagesOne(packagesKeyNum);
	}

	/**
	 * 패키지 업데이트
	 * @param packages
	 * @param principal 
	 * @return
	 */
	public String updatePackages(Packages packages, Principal principal) {
		if(packages.getCustomerName().equals("") || packages.getCustomerName() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		int sucess = packagesDao.updatePackages(packages);
		
		// uid 로그 기록
		if(sucess > 0) 
			uidLog(packages, principal, "UPDATE");
		
		if(sucess <= 0) 
			return "FALSE";
		return "OK";
	}

	/**
	 * 패키지 리스트 전체 조회
	 * @param packages
	 * @return
	 */
	public List<Packages> listAll(Packages packages) {
		return packagesDao.getPackagesListAll(packages);
	}


	/**
	 * Excel 2019 Import
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	public String importPackagesXlxs2019(MultipartFile mfile, Principal principal) throws IOException {
		Packages packages = new Packages();
		Date date = null;
		int packagesKeyNum = 0;
		
        XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
        // 첫번째 시트 불러오기
        XSSFSheet sheet = workbook.getSheetAt(0);
        
        try {
            // 마지막 키 번호 가져오기
        	packagesKeyNum = packagesDao.getPackagesKeyNum();
        } catch (Exception e) {}
        
        // 4번 째 행부터 조회
        for(int i=6; i<sheet.getLastRowNum() + 1; i++) {
            XSSFRow row = sheet.getRow(i);
            
            // 행이 존재하기 않으면 패스
            if(null == row) {
                continue;
            }
            
            // 행의 1번째 열(No) 
            XSSFCell cell = row.getCell(0);
            
            if(row.getCell(1).getStringCellValue() == "" || row.getCell(1).getStringCellValue() == null) {
            	return "OK";
            }
            
            if(null != cell) 
            	// 1번째 열을 사용하지 않음.
            // 행의 2번째 열(고객사 명)
            cell = row.getCell(1);
            if(null != cell) 
            	packages.setCustomerName(cell.getStringCellValue());
            // 행의 3번째 열(요청일자)
            cell = row.getCell(2);
            if(null != cell) {
            	date = cell.getDateCellValue();
            	String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
            	packages.setRequestDate(cellString);
            }
            // 행의 4번째 열(전달일자)
            cell = row.getCell(3);
            if(null != cell) 
            	date = cell.getDateCellValue();
        		String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
            	packages.setDeliveryData(cellString);
            // 행의 5번째 열(기존/신규)
            cell = row.getCell(4);
            if(null != cell) 
            	packages.setExistingNew(cell.getStringCellValue());
            // 행의 6번째 열(패키지 종류)
            cell = row.getCell(5);
            if(null != cell) 
            	packages.setManagementServer(cell.getStringCellValue());
            // 행의 7번째 열(Agent OS)
            cell = row.getCell(6);
            if(null != cell) 
            	packages.setAgentOS(cell.getStringCellValue());
            // 행의 8번째 열(패키지 상세버전)
            cell = row.getCell(7);
            if(null != cell) 
            	packages.setOsDetailVersion(cell.getStringCellValue());
            // 행의 9번째 열(OS종류)
            cell = row.getCell(8);
            if(null != cell) 
              	packages.setOsType(cell.getStringCellValue());
            // 행의 10번째 열(Agent ver)
            cell = row.getCell(9);
            if(null != cell) 
              	packages.setAgentVer(cell.getStringCellValue());
            // 행의 11번째 열(패키지명)
            cell = row.getCell(10);
            if(null != cell) 
              	packages.setPackageName(cell.getStringCellValue());
            // 행의 12번째 열(담당자)
            cell = row.getCell(11);
            if(null != cell) 
              	packages.setManager(cell.getStringCellValue());
            // 행의 13번째 열(요청 제품구분)
            cell = row.getCell(12);
            if(null != cell) 
            	packages.setRequestProductCategory(cell.getStringCellValue());
            // 행의 14번째 열(전달 방법)
            cell = row.getCell(13);
            if(null != cell) 
              	packages.setDeliveryMethod(cell.getStringCellValue());
            // 행의 21번째 열(비고)
            cell = row.getCell(20);
            if(null != cell) 
              	packages.setNote(cell.getStringCellValue());
            
            // 키값 저장
            packages.setPackagesKeyNum(++packagesKeyNum);
            // 로그인 사용자 아이디
            packages.setPackagesRegistrant(principal.getName());
    		packages.setPackagesRegistrationDate(nowDate());

    		// 패키지 데이터 저장
            packagesDao.insertPackages(packages);
            // uid 로그 기록
            uidLog(packages, principal, "INSERT");
        }
		return "OK";
	}
	
	/**
	 * Excel 2021 Import
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	public String importPackagesXlxs2021(MultipartFile mfile, Principal principal) throws IOException {
		Packages packages = new Packages();
		Date date = null;
		int packagesKeyNum = 0;
		
        XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
        // 첫번째 시트 불러오기
        XSSFSheet sheet = workbook.getSheetAt(0);
        
        try {
            // 마지막 키 번호 가져오기
        	packagesKeyNum = packagesDao.getPackagesKeyNum();
        } catch (Exception e) {
    	}
        
        // 4번 째 행부터 조회
        for(int i=4; i<sheet.getLastRowNum() + 1; i++) {
            XSSFRow row = sheet.getRow(i);
            
            // 행이 존재하기 않으면 패스
            if(null == row) {
                continue;
            }
            
            // 행의 1번째 열(No) 
            XSSFCell cell = row.getCell(0);
            
            if(row.getCell(1).getStringCellValue() == "" || row.getCell(1).getStringCellValue() == null) {
            	return "OK";
            }
            
            if(null != cell) 
            	// 1번째 열을 사용하지 않음.
            // 행의 2번째 열(고객사 명)
            cell = row.getCell(1);
            if(null != cell) 
            	packages.setCustomerName(cell.getStringCellValue());
            // 행의 3번째 열(요청일자)
            cell = row.getCell(2);
            if(null != cell) {
            	date = cell.getDateCellValue();
            	String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
            	packages.setRequestDate(cellString);
            }
            // 행의 4번째 열(전달일자)
            cell = row.getCell(3);
            if(null != cell) 
            	date = cell.getDateCellValue();
        		String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
            	packages.setDeliveryData(cellString);
            // 행의 5번째 열(기존/신규)
            cell = row.getCell(4);
            if(null != cell) 
            	packages.setExistingNew(cell.getStringCellValue());
            // 행의 6번째 열(패키지 종류)
            cell = row.getCell(5);
            if(null != cell) 
            	packages.setManagementServer(cell.getStringCellValue());
            // 행의 7번째 열(Agent OS)
            cell = row.getCell(6);
            if(null != cell) 
            	packages.setAgentOS(cell.getStringCellValue());
            // 행의 8번째 열(패키지 상세버전)
            cell = row.getCell(7);
            if(null != cell) 
            	packages.setOsDetailVersion(cell.getStringCellValue());
            // 행의 9번째 열(OS종류)
            cell = row.getCell(8);
            if(null != cell) 
              	packages.setOsType(cell.getStringCellValue());
            // 행의 10번째 열(Agent ver)
            cell = row.getCell(9);
            if(null != cell) 
              	packages.setAgentVer(cell.getStringCellValue());
            // 행의 11번째 열(패키지명)
            cell = row.getCell(10);
            if(null != cell) 
              	packages.setPackageName(cell.getStringCellValue());
            // 행의 12번째 열(담당자)
            cell = row.getCell(11);
            if(null != cell) 
              	packages.setManager(cell.getStringCellValue());
            // 행의 13번째 열(요청 제품구분)
            cell = row.getCell(12);
            if(null != cell) 
            	packages.setRequestProductCategory(cell.getStringCellValue());
            // 행의 14번째 열(전달 방법)
            cell = row.getCell(13);
            if(null != cell) 
              	packages.setDeliveryMethod(cell.getStringCellValue());
            // 행의 20번째 열(비고)
            cell = row.getCell(19);
            if(null != cell) 
              	packages.setNote(cell.getStringCellValue());
            
            // 키값 저장
            packages.setPackagesKeyNum(++packagesKeyNum);
            // 로그인 사용자 아이디
            packages.setPackagesRegistrant(principal.getName());
    		// 저장 시간(현재 시간)
    		packages.setPackagesRegistrationDate(nowDate());

    		// 패키지 데이터 저장
            packagesDao.insertPackages(packages);
            // uid 로그 기록
            uidLog(packages, principal, "INSERT");
        }
		return "OK";
	}
	
	/**
	 * Excel 2022 Import
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	public String importPackagesXlxs2022(MultipartFile mfile, Principal principal) throws IOException {
		Packages packages = new Packages();
		Date date = null;
		int packagesKeyNum = 0;
		
        XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
        // 첫번째 시트 불러오기
        XSSFSheet sheet = workbook.getSheetAt(0);
        
        try {
            // 마지막 키 번호 가져오기
        	packagesKeyNum = packagesDao.getPackagesKeyNum();
        } catch (Exception e) {}
        
        // 4번 째 행부터 조회
        for(int i=4; i<sheet.getLastRowNum() + 1; i++) {
            XSSFRow row = sheet.getRow(i);
            
            // 행이 존재하기 않으면 패스
            if(null == row) {
                continue;
            }
            
            // 행의 1번째 열(No) 
            XSSFCell cell = row.getCell(0);
            
            if(row.getCell(1).getStringCellValue() == "" || row.getCell(1).getStringCellValue() == null) {
            	return "OK";
            }
            
            if(null != cell) 
            	// 1번째 열을 사용하지 않음.
            // 행의 2번째 열(고객사 명)
            cell = row.getCell(1);
            if(null != cell) 
            	packages.setCustomerName(cell.getStringCellValue());
            // 행의 3번째 열(요청일자)
            cell = row.getCell(2);
            if(null != cell) {
            	date = cell.getDateCellValue();
            	String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
            	packages.setRequestDate(cellString);
            }
            // 행의 4번째 열(전달일자)
            cell = row.getCell(3);
            if(null != cell) 
            	date = cell.getDateCellValue();
        		String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
            	packages.setDeliveryData(cellString);
            // 행의 5번째 열(기존/신규)
            cell = row.getCell(4);
            if(null != cell) 
            	packages.setExistingNew(cell.getStringCellValue());
            // 행의 6번째 열(패키지 종류)
            cell = row.getCell(5);
            if(null != cell) 
            	packages.setManagementServer(cell.getStringCellValue());
            // 행의 7번째 열(Agent OS)
            cell = row.getCell(6);
            if(null != cell) 
            	packages.setAgentOS(cell.getStringCellValue());
            // 행의 8번째 열(패키지 상세버전)
            cell = row.getCell(7);
            if(null != cell) 
            	packages.setOsDetailVersion(cell.getStringCellValue());
            // 행의 9번째 열(일반/커스텀)
            cell = row.getCell(8);
            if(null != cell) 
            	packages.setGeneralCustom(cell.getStringCellValue());
            // 행의 10번째 열(OS종류)
            cell = row.getCell(9);
            if(null != cell) 
              	packages.setOsType(cell.getStringCellValue());
            
            // 행의 11번째 열(Agent ver)
            cell = row.getCell(10);
            if(null != cell) 
              	packages.setAgentVer(cell.getStringCellValue());
            // 행의 12번째 열(패키지명)
            cell = row.getCell(11);
            if(null != cell) 
              	packages.setPackageName(cell.getStringCellValue());
            // 행의 13번째 열(담당자)
            cell = row.getCell(12);
            if(null != cell) 
              	packages.setManager(cell.getStringCellValue());
            // 행의 14번째 열(요청 제품구분)
            cell = row.getCell(13);
            if(null != cell) 
            	packages.setRequestProductCategory(cell.getStringCellValue());
            // 행의 15번째 열(전달 방법)
            cell = row.getCell(14);
            if(null != cell) 
              	packages.setDeliveryMethod(cell.getStringCellValue());
            // 행의 21번째 열(비고)
            cell = row.getCell(20);
            if(null != cell) 
              	packages.setNote(cell.getStringCellValue());
            
            // 키값 저장
            packages.setPackagesKeyNum(++packagesKeyNum);
            // 로그인 사용자 아이디
            packages.setPackagesRegistrant(principal.getName());
    		// 저장 시간(현재 시간)
    		packages.setPackagesRegistrationDate(nowDate());
             
            packagesDao.insertPackages(packages);
            // uid 로그 기록
            uidLog(packages, principal, "INSERT");
        }
		return "OK";
	}
	
	/**
	 * Excel CSV Import
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	public String importPackagesCSV(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;
		String cellString;
		int packagesKeyNum = 0;
		
		//OPCPackage opcPackage = OPCPackage.open(mfile.getInputStream());
        HSSFWorkbook workbook = new HSSFWorkbook(mfile.getInputStream());
        // 첫번째 시트 불러오기
        HSSFSheet sheet = workbook.getSheetAt(0);
        
        try {
        	// 마지막 키 번호 가져오기
        	packagesKeyNum = packagesDao.getPackagesKeyNum();
        } catch (Exception e) {}
        
        // 4번 째 행부터 조회
        for(int i=1; i<sheet.getLastRowNum() + 1; i++) {
            HSSFRow row = sheet.getRow(i);
            
            // 행이 존재하기 않으면 패스
            if(null == row) {
                continue;
            }
            
            // 행의 1번째 열(고객사 명) 
            HSSFCell cell = row.getCell(0);
            
            if(row.getCell(0).getStringCellValue() == "" || row.getCell(0).getStringCellValue() == null) {
            	return "OK";
            }
            
            if(null != cell) 
            	packages.setCustomerName(cell.getStringCellValue());
            // 행의 2번째 열(요청일자)
            cell = row.getCell(1);
            if(null != cell) 
        		packages.setRequestDate(cell.getStringCellValue());
            // 행의 3번째 열(전달일자)
            cell = row.getCell(2);
            if(null != cell) {
            	packages.setDeliveryData(cell.getStringCellValue());
            }
            // 행의 4번째 열(패키지 종류)
            cell = row.getCell(3);
            if(null != cell) 
            	packages.setManagementServer(cell.getStringCellValue());
            // 행의 5번째 열(일반/커스텀)
            cell = row.getCell(4);
            if(null != cell) 
            	packages.setGeneralCustom(cell.getStringCellValue());
            // 행의 6번째 열(Agent ver)
            cell = row.getCell(5);
            if(null != cell) 
            	packages.setAgentVer(cell.getStringCellValue());
            // 행의 7번째 열(패키지명)
            cell = row.getCell(6);
            if(null != cell) 
            	packages.setPackageName(cell.getStringCellValue());
            // 행의 8번째 열(담당자)
            cell = row.getCell(7);
            if(null != cell) 
            	packages.setManager(cell.getStringCellValue());
            // 행의 9번째 열(OS종류)
            cell = row.getCell(8);
            if(null != cell) 
            	packages.setOsType(cell.getStringCellValue());
            // 행의 10번째 열(패키지 상세버전)
            cell = row.getCell(9);
            if(null != cell) 
            	packages.setOsDetailVersion(cell.getStringCellValue());
            // 행의 11번째 열(Agent OS)
            cell = row.getCell(10);
            if(null != cell) 
            	packages.setAgentOS(cell.getStringCellValue());
            // 행의 12번째 열(기존/신규)
            cell = row.getCell(11);
            if(null != cell) 
            	packages.setExistingNew(cell.getStringCellValue());
            // 행의 13번째 열(요청 제품구분)
            cell = row.getCell(12);
            if(null != cell) 
            	packages.setRequestProductCategory(cell.getStringCellValue());
            // 행의 14번째 열(전달 방법)
            cell = row.getCell(13);
            if(null != cell) 
            	packages.setDeliveryMethod(cell.getStringCellValue());
            // 행의 15번째 열(비고)
            cell = row.getCell(14);
            if(null != cell) 
            	packages.setNote(cell.getStringCellValue());
              	
            // 키값 저장
            packages.setPackagesKeyNum(++packagesKeyNum);
            // 로그인 사용자 아이디
            packages.setPackagesRegistrant(principal.getName());
    		packages.setPackagesRegistrationDate(nowDate());

            packagesDao.insertPackages(packages);
            // uid 로그 기록
            uidLog(packages, principal, "INSERT");
        }
		return "OK";
	}
	
	/**
	 * UPDATE, INSERT, DELETE 이벤트 로그 저장
	 * @param packages
	 * @param principal 
	 * @param event
	 */
	public void uidLog(Packages packages, Principal principal, String event) {
		int uidLogKeyNum = 0;

		UIDLog uidLog = new UIDLog();
		try {
			uidLogKeyNum = packagesDao.uidLogKeyNum();
		}catch (Exception e) {}
		
		uidLog.setUidKeyNum(++uidLogKeyNum);
		uidLog.setUidCustomerName(packages.getCustomerName());
		uidLog.setUidOsDetailVersion(packages.getOsDetailVersion());
		uidLog.setUidPackageName(packages.getPackageName());
		uidLog.setUidEvent(event);
		uidLog.setUidUser(principal.getName());
		uidLog.setUidTime(nowDate());
		packagesDao.uidLog(uidLog);
	}
	
	/**
	 * 현재 시간 년-월-일 시-분-초 형식으로 리턴(중복 제거)
	 * @return
	 */
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	


}
