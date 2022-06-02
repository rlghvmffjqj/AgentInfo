package com.secuve.agentInfo.service;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.secuve.agentInfo.dao.PackagesDao;
import com.secuve.agentInfo.dao.TrashDao;
import com.secuve.agentInfo.dao.UIDLogDao;
import com.secuve.agentInfo.vo.Packages;
import com.secuve.agentInfo.vo.Trash;
import com.secuve.agentInfo.vo.UIDLog;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class PackagesService {
	@Autowired PackagesDao packagesDao;
	@Autowired CategoryService categoryService;
	@Autowired Packages packages;
	@Autowired UIDLogDao uidLogDao;
	@Autowired TrashDao trashDao;
	@Autowired CustomerBusinessMappingService customerBusinessMappingService;

	/**
	 * 패키지 리스트 조회
	 * 
	 * @param search
	 * @return
	 */
	public List<Packages> getPackagesList(Packages search) {
		return packagesDao.getPackagesList(packagesSearch(search));
	}

	/**
	 * 패키지 Key Num 조회
	 * 
	 * @param search
	 * @return
	 */
	public int getPackagesListCount(Packages search) {
		return packagesDao.getPackagesListCount(packagesSearch(search));
	}

	/**
	 * 패키지 삭제
	 * 
	 * @param chkList
	 * @param principal
	 * @return
	 */
	public String delPackages(int[] chkList, Principal principal) {
		for (int packagesKeyNum : chkList) {
			Packages packages = packagesDao.getPackagesOne(packagesKeyNum);
			int sucess = packagesDao.delPackages(packagesKeyNum);

			// uid 로그 기록
			if (sucess > 0) {
				uidLog(packages, principal, "DELETE");
				trash(packages, principal);
			}

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	/**
	 * 패키지 추가
	 * 
	 * @param packages
	 * @param principal
	 * @return
	 */
	public String insertPackages(Packages packages, Principal principal) {
		if (packages.getCustomerNameSelf().length() > 0) {
			packages.setCustomerNameView(packages.getCustomerNameSelf());
		}
		if (packages.getCustomerNameView().equals("") || packages.getCustomerNameView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		selfInput(packages);
		packages.setState("배포완료");
		packages.setPackagesKeyNum(packagesKeyNum());
		packages.setPackagesKeyNumOrigin(packagesKeyNum());
		int sucess = packagesDao.insertPackages(packages);

		// uid 로그 기록 & 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(packages.getCustomerNameView(), packages.getBusinessNameView());
			categoryCheck(packages, principal);
			uidLog(packages, principal, "INSERT");
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	/**
	 * 패키지 키값 증가
	 * @return
	 */
	public int packagesKeyNum() {
		int packagesKeyNum = 0;
		try {
			packagesKeyNum = packagesDao.getPackagesKeyNum();
		} catch (Exception e) {
			return packagesKeyNum;
		}
		return ++packagesKeyNum;
	}

	/**
	 * 리스트 복사
	 * @param packages
	 * @param principal
	 * @return
	 */
	public String copyPackages(Packages packages, Principal principal) {
		if (packages.getCustomerNameSelf().length() > 0) {
			packages.setCustomerNameView(packages.getCustomerNameSelf());
		}
		if (packages.getCustomerNameView().equals("") || packages.getCustomerNameView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		packagesDao.plusPackagesKeyNumOrigin(packages.getPackagesKeyNumOrigin()); // 복사 대상 윗 데이터 +1
		packages.setPackagesKeyNumOrigin(packages.getPackagesKeyNumOrigin() + 1); // 빈 공간 값 저장
		packages.setPackagesKeyNum(packagesKeyNum());
		selfInput(packages);
		int sucess = packagesDao.insertPackages(packages);

		// uid 로그 기록 & 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(packages.getCustomerNameView(), packages.getBusinessNameView());
			categoryCheck(packages, principal);
			uidLog(packages, principal, "INSERT");
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	/**
	 * 패키지 Key Num으로 하나의 정보 조회
	 * 
	 * @param packagesKeyNum
	 * @return
	 */
	public Packages getPackagesOne(int packagesKeyNum) {
		return packagesDao.getPackagesOne(packagesKeyNum);
	}

	/**
	 * 패키지 업데이트
	 * 
	 * @param packages
	 * @param principal
	 * @return
	 */
	public String updatePackages(Packages packages, Principal principal) {
		if (packages.getCustomerNameSelf().length() > 0) {
			packages.setCustomerNameView(packages.getCustomerNameSelf());
		}
		if (packages.getCustomerNameView().equals("") || packages.getCustomerNameView() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		selfInput(packages);
		int sucess = packagesDao.updatePackages(packages);

		// uid 로그 기록 & 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			customerBusinessMappingService.customerBusinessMapping(packages.getCustomerNameView(), packages.getBusinessNameView());
			categoryCheck(packages, principal);
			uidLog(packages, principal, "UPDATE");
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	/**
	 * 패키지 리스트 전체 조회
	 * 
	 * @param packages
	 * @return
	 */
	public List<Packages> listAll(Packages packages) {
		return packagesDao.getPackagesListAll(packagesSearch(packages));
	}

	/**
	 * Excel 2019 Import
	 * 
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "deprecation", "resource" })
	public String importPackagesXlxs2019(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;

		XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		XSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 6; i < sheet.getLastRowNum() + 1; i++) {
			Packages packages = new Packages();
			XSSFRow row = sheet.getRow(i);

			// 행이 존재하기 않으면 패스
			if (null == row) {
				continue;
			}

			// 1번째 열을 사용하지 않음.
			// 행의 2번째 열(고객사 명)
			XSSFCell cell = row.getCell(1);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				if (cell.getStringCellValue() == "" || cell.getStringCellValue() == null) {
					return "OK";
				}
				packages.setCustomerNameView(cell.getStringCellValue());
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setBusinessNameView(cell.getStringCellValue());
			}
			// 행의 4번째 열(요청일자) 데이터 손실로 주석 처리
			// cell = row.getCell(3);
			// if (null != cell) {
			// 	date = cell.getDateCellValue();
			// 	String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
			// 	packages.setRequestDateView(cellString);
			// }
			// 행의 5번째 열(전달일자)
			cell = row.getCell(4);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packages.setDeliveryDataView(cellString);
			}
			// 행의 6번째 열(기존/신규)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setExistingNewView(cell.getStringCellValue());
				if (categoryService.getCategory("existingNew", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("existingNew", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 7번째 열(패키지 종류)
			cell = row.getCell(6);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagementServerView(cell.getStringCellValue());
				if (categoryService.getCategory("managementServer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("managementServer", cell.getStringCellValue(), principal.getName(),
							nowDate());
				}
			}
			// 행의 8번째 열(Agent OS)
			cell = row.getCell(7);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentOSView(cell.getStringCellValue());
				if (categoryService.getCategory("agentOS", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentOS", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 9번째 열(패키지 상세버전)
			cell = row.getCell(8);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 10번째 열(OS종류)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsTypeView(cell.getStringCellValue());
				if (categoryService.getCategory("osType", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("osType", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 11번째 열(Agent ver)
			cell = row.getCell(10);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentVerView(cell.getStringCellValue());
				if (categoryService.getCategory("agentVer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentVer", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 12번째 열(패키지명)
			cell = row.getCell(11);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 13번째 열(담당자)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagerView(cell.getStringCellValue());
			}
			// 행의 14번째 열(요청 제품구분)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setRequestProductCategoryView(cell.getStringCellValue());
				if (categoryService.getCategory("requestProductCategory", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("requestProductCategory", cell.getStringCellValue(), principal.getName(),
							nowDate());
				}
			}
			// 행의 15번째 열(전달 방법)
			cell = row.getCell(14);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setDeliveryMethodView(cell.getStringCellValue());
				if (categoryService.getCategory("deliveryMethod", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("deliveryMethod", cell.getStringCellValue(), principal.getName(),
							nowDate());
				}
			}
			// 행의 22번째 열(비고)
			cell = row.getCell(21);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setNoteView(cell.getStringCellValue());
			}

			// 키값 저장
			packages.setPackagesKeyNum(packagesKeyNum());
			packages.setPackagesKeyNumOrigin(packagesKeyNum());
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
	 * 
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "deprecation", "resource" })
	public String importPackagesXlxs2021(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;

		XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		XSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 4; i < sheet.getLastRowNum() + 1; i++) {
			Packages packages = new Packages();
			XSSFRow row = sheet.getRow(i);

			// 행이 존재하기 않으면 패스
			if (null == row) {
				continue;
			}

			// 1번째 열을 사용하지 않음.
			// 행의 2번째 열(고객사 명)
			XSSFCell cell = row.getCell(1);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				if (cell.getStringCellValue() == "" || cell.getStringCellValue() == null) {
					return "OK";
				}
				packages.setCustomerNameView(cell.getStringCellValue());
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				cell.setCellType(Cell.CELL_TYPE_STRING);
			}
			packages.setBusinessNameView(cell.getStringCellValue());
			// 행의 4번째 열(요청일자)
			cell = row.getCell(3);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packages.setRequestDateView(cellString);
			}
			// 행의 5번째 열(전달일자)
			cell = row.getCell(4);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packages.setDeliveryDataView(cellString);
			}
			// 행의 6번째 열(기존/신규)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
					packages.setExistingNewView(cell.getStringCellValue());
					if (categoryService.getCategory("existingNew", cell.getStringCellValue()) == 0) {
						categoryService.setCategory("existingNew", cell.getStringCellValue(), principal.getName(), nowDate());
					}
				}
			}
			// 행의 7번째 열(패키지 종류)
			cell = row.getCell(6);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagementServerView(cell.getStringCellValue());
				if (categoryService.getCategory("managementServer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("managementServer", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 8번째 열(Agent OS)
			cell = row.getCell(7);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentOSView(cell.getStringCellValue());
				if (categoryService.getCategory("agentOS", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentOS", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 9번째 열(패키지 상세버전)
			cell = row.getCell(8);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 10번째 열(OS종류)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsTypeView(cell.getStringCellValue());
				if (categoryService.getCategory("osType", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("osType", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 11번째 열(Agent ver)
			cell = row.getCell(10);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentVerView(cell.getStringCellValue());
				if (categoryService.getCategory("agentVer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentVer", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 12번째 열(패키지명)
			cell = row.getCell(11);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 13번째 열(담당자)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagerView(cell.getStringCellValue());
			}
			// 행의 14번째 열(요청 제품구분)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setRequestProductCategoryView(cell.getStringCellValue());
				if (categoryService.getCategory("requestProductCategory", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("requestProductCategory", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 15번째 열(전달 방법)
			cell = row.getCell(14);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setDeliveryMethodView(cell.getStringCellValue());
				if (categoryService.getCategory("deliveryMethod", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("deliveryMethod", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 21번째 열(비고)
			cell = row.getCell(20);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setNoteView(cell.getStringCellValue());
			}

			// 키값 저장
			packages.setPackagesKeyNum(packagesKeyNum());
			packages.setPackagesKeyNumOrigin(packagesKeyNum());
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
	 * 
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "deprecation", "resource" })
	public String importPackagesXlxs2022(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;

		XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		XSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 4; i < sheet.getLastRowNum() + 1; i++) {
			Packages packages = new Packages();
			XSSFRow row = sheet.getRow(i);

			// 행이 존재하기 않으면 패스
			if (null == row) {
				continue;
			}

			// 1번째 열을 사용하지 않음.
			// 행의 2번째 열(고객사 명)
			XSSFCell cell = row.getCell(1);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				if (cell.getStringCellValue() == "" || cell.getStringCellValue() == null) {
					return "OK";
				}
				packages.setCustomerNameView(cell.getStringCellValue());
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				cell.setCellType(Cell.CELL_TYPE_STRING);
			}
			packages.setBusinessNameView(cell.getStringCellValue());
			// 행의 4번째 열(요청일자)
			cell = row.getCell(3);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packages.setRequestDateView(cellString);
			}
			// 행의 5번째 열(전달일자)
			cell = row.getCell(4);
			if (null != cell)
				date = cell.getDateCellValue();
			String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
			packages.setDeliveryDataView(cellString);
			// 행의 6번째 열(기존/신규)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setExistingNewView(cell.getStringCellValue());
				if (categoryService.getCategory("existingNew", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("existingNew", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 7번째 열(패키지 종류)
			cell = row.getCell(6);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagementServerView(cell.getStringCellValue());
				if (categoryService.getCategory("managementServer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("managementServer", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 8번째 열(Agent OS)
			cell = row.getCell(7);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentOSView(cell.getStringCellValue());
				if (categoryService.getCategory("agentOS", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentOS", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 9번째 열(패키지 상세버전)
			cell = row.getCell(8);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 10번째 열(일반/커스텀)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setGeneralCustomView(cell.getStringCellValue());
				if (categoryService.getCategory("generalCustom", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("generalCustom", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 11번째 열(OS종류)
			cell = row.getCell(10);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsTypeView(cell.getStringCellValue());
				if (categoryService.getCategory("osType", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("osType", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 12번째 열(Agent ver)
			cell = row.getCell(11);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentVerView(cell.getStringCellValue());
				if (categoryService.getCategory("agentVer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentVer", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 13번째 열(패키지명)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 14번째 열(담당자)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagerView(cell.getStringCellValue());
			}
			// 행의 15번째 열(요청 제품구분)
			cell = row.getCell(14);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setRequestProductCategoryView(cell.getStringCellValue());
				if (categoryService.getCategory("requestProductCategory", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("requestProductCategory", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 16번째 열(전달 방법)
			cell = row.getCell(15);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setDeliveryMethodView(cell.getStringCellValue());
				if (categoryService.getCategory("deliveryMethod", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("deliveryMethod", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 22번째 열(비고)
			cell = row.getCell(21);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setNoteView(cell.getStringCellValue());
			}

			// 키값 저장
			packages.setPackagesKeyNum(packagesKeyNum());
			packages.setPackagesKeyNumOrigin(packagesKeyNum());
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
	 * 
	 * @param mfile
	 * @param principal
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "deprecation", "resource" })
	public String importPackagesCSV(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;
		String cellString;

		// OPCPackage opcPackage = OPCPackage.open(mfile.getInputStream());
		HSSFWorkbook workbook = new HSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		HSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 1; i < sheet.getLastRowNum() + 1; i++) {
			Packages packages = new Packages();
			HSSFRow row = sheet.getRow(i);

			// 행이 존재하기 않으면 패스
			if (null == row) {
				continue;
			}

			// 행의 1번째 열(고객사 명)
			HSSFCell cell = row.getCell(0);

			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				if (cell.getStringCellValue() == "" || cell.getStringCellValue() == null) {
					return "OK";
				}
				packages.setCustomerNameView(cell.getStringCellValue());
				if (categoryService.getCategory("customerName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("customerName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 2번째 열(사업명)
			cell = row.getCell(1);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setBusinessNameView(cell.getStringCellValue());
				if (categoryService.getCategory("businessName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("businessName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 3번째 열(요청일자)
			cell = row.getCell(2);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setRequestDateView(cell.getStringCellValue());
			}
			// 행의 4번째 열(전달일자)
			cell = row.getCell(3);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setDeliveryDataView(cell.getStringCellValue());
			}
			// 행의 5번째 열(상태)
			cell = row.getCell(4);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setStateView(cell.getStringCellValue());
			}
			// 행의 6번째 열(패키지 종류)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagementServerView(cell.getStringCellValue());
				if (categoryService.getCategory("managementServer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("managementServer", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 7번째 열(일반/커스텀)
			cell = row.getCell(6);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setGeneralCustomView(cell.getStringCellValue());
				if (categoryService.getCategory("generalCustom", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("generalCustom", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 8번째 열(Agent ver)
			cell = row.getCell(7);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentVerView(cell.getStringCellValue());
				if (categoryService.getCategory("agentVer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentVer", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 9번째 열(패키지명)
			cell = row.getCell(8);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 10번째 열(담당자)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setManagerView(cell.getStringCellValue());
			}
			// 행의 11번째 열(OS종류)
			cell = row.getCell(10);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsTypeView(cell.getStringCellValue());
				if (categoryService.getCategory("osType", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("osType", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 12번째 열(패키지 상세버전)
			cell = row.getCell(11);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 13번째 열(Agent OS)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setAgentOSView(cell.getStringCellValue());
				if (categoryService.getCategory("agentOS", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentOS", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 14번째 열(기존/신규)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setExistingNewView(cell.getStringCellValue());
				if (categoryService.getCategory("existingNew", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("existingNew", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 15번째 열(요청 제품구분)
			cell = row.getCell(14);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setRequestProductCategoryView(cell.getStringCellValue());
				if (categoryService.getCategory("requestProductCategory", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("requestProductCategory", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 16번째 열(전달 방법)
			cell = row.getCell(15);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setDeliveryMethodView(cell.getStringCellValue());
				if (categoryService.getCategory("deliveryMethod", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("deliveryMethod", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 17번째 열(비고)
			cell = row.getCell(16);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setNoteView(cell.getStringCellValue());
			}
			
			// 행의 18번째 열(상태변경의견)
			cell = row.getCell(17);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packages.setStatusComment(cell.getStringCellValue());
			}

			// 키값 저장
			packages.setPackagesKeyNum(packagesKeyNum());
			packages.setPackagesKeyNumOrigin(packagesKeyNum());
			// 로그인 사용자 아이디
			packages.setPackagesRegistrant(principal.getName());
			packages.setPackagesRegistrationDate(nowDate());

			packagesDao.insertPackages(packages);
			// 고객사 사업명 매핑
			customerBusinessMappingService.customerBusinessMapping(packages.getCustomerNameView(), packages.getBusinessNameView());
			// uid 로그 기록
			uidLog(packages, principal, "INSERT");
		}
		return "OK";
	}

	/**
	 * UPDATE, INSERT, DELETE 이벤트 로그 저장
	 * 
	 * @param packages
	 * @param principal
	 * @param event
	 */
	public void uidLog(Packages packages, Principal principal, String event) {
		int uidLogKeyNum = 0;

		UIDLog uidLog = new UIDLog();
		try {
			uidLogKeyNum = uidLogDao.uidLogKeyNum();
		} catch (Exception e) {
		}

		uidLog.setUidKeyNum(++uidLogKeyNum);
		if(event == "DELETE" || event.equals("적용") || event.equals("대기") || event.equals("배포완료")) {
			uidLog.setUidCustomerName(packages.getCustomerName());
			uidLog.setUidOsDetailVersion(packages.getOsDetailVersion());
			uidLog.setUidPackageName(packages.getPackageName());
		} else {
			uidLog.setUidCustomerName(packages.getCustomerNameView());
			uidLog.setUidOsDetailVersion(packages.getOsDetailVersionView());
			uidLog.setUidPackageName(packages.getPackageNameView());
		}
		uidLog.setPackagesKeyNum(Integer.toString(packages.getPackagesKeyNum()));
		uidLog.setUidEvent(event);
		uidLog.setUidUser(principal.getName());
		uidLog.setUidTime(nowDate());
		uidLogDao.insertUIDLog(uidLog);
	}

	/**
	 * 현재 시간 년-월-일 시-분-초 형식으로 리턴(중복 제거)
	 * 
	 * @return
	 */
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}
	
	/**
	 * Select box를 Input로 변경 시 Input 갑을 기존 변수에 넣어주기
	 * @param packages
	 * @return
	 */
	public Packages selfInput(Packages packages) {
		if(packages.getManagementServerSelf().length() > 0) 
			packages.setManagementServerView(packages.getManagementServerSelf());
		if(packages.getGeneralCustomSelf().length() > 0)
			packages.setGeneralCustomView(packages.getGeneralCustomSelf());
		if(packages.getAgentVerSelf().length() > 0)
			packages.setAgentVerView(packages.getAgentVerSelf());
		if(packages.getOsTypeSelf().length() > 0)
			packages.setOsTypeView(packages.getOsTypeSelf());
		if(packages.getAgentOSSelf().length() > 0)
			packages.setAgentOSView(packages.getAgentOSSelf());
		if(packages.getExistingNewSelf().length() > 0)
			packages.setExistingNewView(packages.getExistingNewSelf());
		if(packages.getRequestProductCategorySelf().length() > 0)
			packages.setRequestProductCategoryView(packages.getRequestProductCategorySelf());
		if(packages.getDeliveryMethodSelf().length() > 0)
			packages.setDeliveryMethodView(packages.getDeliveryMethodSelf());
		if(packages.getCustomerNameSelf().length() > 0)
			packages.setCustomerNameView(packages.getCustomerNameSelf());
		if(packages.getBusinessNameSelf().length() > 0)
			packages.setBusinessNameView(packages.getBusinessNameSelf());
		
		return packages;
	}
	
	/**
	 * 직접 입력 시 카테고리가 없을 경우 추가
	 * @param packages
	 * @param principal
	 */
	public void categoryCheck(Packages packages, Principal principal) {
		if (categoryService.getCategory("managementServer", packages.getManagementServerView()) == 0) {
			categoryService.setCategory("managementServer", packages.getManagementServerView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("generalCustom", packages.getGeneralCustomView()) == 0) {
			categoryService.setCategory("generalCustom", packages.getGeneralCustomView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("agentVer", packages.getAgentVerView()) == 0) {
			categoryService.setCategory("agentVer", packages.getAgentVerView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("osType", packages.getOsTypeView()) == 0) {
			categoryService.setCategory("osType", packages.getOsTypeView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("agentOS", packages.getAgentOSView()) == 0) {
			categoryService.setCategory("agentOS", packages.getAgentOSView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("existingNew", packages.getExistingNewView()) == 0) {
			categoryService.setCategory("existingNew", packages.getExistingNewView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("requestProductCategory", packages.getRequestProductCategoryView()) == 0) {
			categoryService.setCategory("requestProductCategory", packages.getRequestProductCategoryView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("deliveryMethod", packages.getDeliveryMethodView()) == 0) {
			categoryService.setCategory("deliveryMethod", packages.getDeliveryMethodView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("customerName", packages.getCustomerNameView()) == 0) {
			categoryService.setCategory("customerName", packages.getCustomerNameView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", packages.getBusinessNameView()) == 0) {
			categoryService.setCategory("businessName", packages.getBusinessNameView(), principal.getName(), nowDate());
		}
	}
	
	/**
	 * 검색 엔진 배열로 변경
	 * @param search
	 * @return
	 */
	public Packages packagesSearch(Packages search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setStateArr(search.getState().split(","));
		search.setExistingNewArr(search.getExistingNew().split(","));
		search.setManagementServerArr(search.getManagementServer().split(","));
		search.setAgentOSArr(search.getAgentOS().split(","));
		search.setOsDetailVersionArr(search.getOsDetailVersion().split(","));
		search.setGeneralCustomArr(search.getGeneralCustom().split(","));
		search.setOsTypeArr(search.getOsType().split(","));
		search.setAgentVerArr(search.getAgentVer().split(","));
		search.setPackageNameArr(search.getPackageName().split(","));
		search.setManagerArr(search.getManager().split(","));
		search.setRequestProductCategoryArr(search.getRequestProductCategory().split(","));
		search.setDeliveryMethodArr(search.getDeliveryMethod().split(","));
		
		return search;
	}

	/**
	 * 패키지 배포 현황 차트
	 * @return
	 */
	public List<Integer> getChartManagementServer() {
		int count = 0;
		List<Integer> list = new ArrayList<Integer>();
		List<Packages> packagesList = packagesDao.getChartManagementServer();
		Map<String, Integer> map = new HashMap<String, Integer>();
		for(Packages packages: packagesList) {
			map.put(packages.getChartName(), packages.getChartCount());
			if(!packages.getChartName().equals("관리서버") && !packages.getChartName().equals("Agent") && !packages.getChartName().equals("Portal") && !packages.getChartName().equals("TOSRF")) {
				count += packages.getChartCount();
			}
		}
		list.add(map.get("관리서버"));
		list.add(map.get("Agent"));
		list.add(map.get("Portal"));
		list.add(map.get("TOSRF"));
		list.add(count);
		
		return list;
	}

	/**
	 * OS종류 별 Agent배포 현황 차트
	 * @return
	 */
	public List<Integer> getOsType() {
		List<Integer> list = new ArrayList<Integer>();
		List<Packages> packagesList = packagesDao.getOsType();
		Map<String, Integer> map = new HashMap<String, Integer>();
		for(Packages packages: packagesList) {
			map.put(packages.getChartName(), packages.getChartCount());
		}
		list.add(map.get("Linux"));
		list.add(map.get("Windows"));
		list.add(map.get("HP-UX"));
		list.add(map.get("AIX"));
		list.add(map.get("Solaris"));
		
		return list;
	}

	/**
	 * Agent 종류별 배포현황 차트
	 * @return
	 */
	public List<Integer> getChartRequestProductCategory() {
		List<Integer> list = new ArrayList<Integer>();
		Packages packages = packagesDao.getChartRequestProductCategory();
		
		list.add(packages.getChartColumn1());
		list.add(packages.getChartColumn2());
		list.add(packages.getChartColumn3());
		list.add(packages.getChartColumn4());
		list.add(packages.getChartColumn5());
		
		return list;
	}

	/**
	 * OS종류별 최대 배포 Agent 버전 차트
	 * @return
	 */
	public Map<String,List> getAgentVer() {
		Map<String, List> map = new HashMap();
		List<String> name = new ArrayList<String>();
		List<Integer> count = new ArrayList<Integer>();
		String topAgentVer;
		String topAgentVerArr[];
		String osType = null;
		for(int i=0; i<5; i++) {
			if(osType == "" || osType == null)
				osType = "Linux";
			else if(osType == "Linux")
				osType = "Windows";
			else if(osType == "Windows")
				osType = "AIX";
			else if(osType == "AIX")
				osType = "HP-UX";
			else if(osType == "HP-UX")
				osType = "Solaris";
			topAgentVer = packagesDao.getTopAgentVer(osType);
			if(topAgentVer == null)
				topAgentVer = "Not Exist";
			topAgentVerArr = topAgentVer.split("-");
			Packages packages = new Packages();
			try {
				packages = packagesDao.getAgentVer(topAgentVerArr[0]);
				topAgentVerArr = packages.getChartName().split("-");
			} catch (Exception e) {
				packages.setChartName("Not Exist");
			}
			
			name.add(osType+". " + topAgentVerArr[0]);
			count.add(packages.getChartCount());
		}
		
		map.put("name", name);
		map.put("count", count);
		
		return map;
	}

	/**
	 * 월별 배포 현황(금년) 차트
	 * @return
	 */
	public List<Integer> getDeliveryData() {
		List<Integer> list = new ArrayList<Integer>();
		List<Packages> packagesList = packagesDao.getDeliveryData();
		Map<String, Integer> map = new HashMap<String, Integer>();
		String str = null;
		for(Packages packages: packagesList) {
			map.put(packages.getChartName(), packages.getChartCount());
		}

		for(int i=1; i<=12; i++) {
			if(i<10)
				str = "0"+Integer.toString(i);
			else 
				str = Integer.toString(i);
			if(map.get(str) != null)
				list.add(map.get(str));
			else 
				list.add(0);
		}
		
		return list;
	}

	/**
	 * 고객사별 패키지 배포 수량 TOP 7
	 * @return
	 */
	public Map<String, List> getCustomerName() {
		Map<String, List> map = new HashMap();
		List<String> name = new ArrayList<String>();
		List<Integer> count = new ArrayList<Integer>();
		
		List<Packages> packagesList = packagesDao.getCustomerName();
		
		for(Packages packages: packagesList) {
			name.add(packages.getChartName());
			count.add(packages.getChartCount());
		}
		map.put("name", name);
		map.put("count", count);

		return map;
	}
	
	/**
	 * 패키지 휴지통
	 * @param packages
	 * @param principal
	 */
	public void trash(Packages packages, Principal principal) {
		int trashKeyNum = 0;
		
		Trash trash = new Trash();

		try {
			trashKeyNum = trashDao.trashKeyNum();
		} catch (Exception e) {
		}

		trash.setTrashKeyNum(++trashKeyNum);
		trash.setTrashCustomerName(packages.getCustomerName());
		trash.setTrashBusinessName(packages.getBusinessName());
		trash.setTrashRequestDate(packages.getRequestDate());
		trash.setTrashDeliveryData(packages.getDeliveryData());
		trash.setTrashExistingNew(packages.getExistingNew());
		trash.setTrashManagementServer(packages.getManagementServer());
		trash.setTrashAgentOS(packages.getAgentOS());
		trash.setTrashOsDetailVersion(packages.getOsDetailVersion());
		trash.setTrashAgentVer(packages.getAgentVer());
		trash.setTrashPackageName(packages.getPackageName());
		trash.setTrashOsType(packages.getOsType());
		trash.setTrashManager(packages.getManager());
		trash.setTrashGeneralCustom(packages.getGeneralCustom());
		trash.setTrashRequestProductCategory(packages.getRequestProductCategory());
		trash.setTrashDeliveryMethod(packages.getDeliveryMethod());
		trash.setTrashNote(packages.getNote());
		trash.setTrashUser(principal.getName());
		trash.setTrashTime(nowDate());
		
		trashDao.insertTrash(trash);
	}

	public String stateChange(int[] chkList, String statusComment, String stateView, Principal principal) {
		for (int packagesKeyNum : chkList) {
			Packages packages = packagesDao.getPackagesOne(packagesKeyNum);
			int sucess = packagesDao.stateChange(packagesKeyNum, statusComment, stateView);

			// uid 로그 기록
			if (sucess > 0) {
				uidLog(packages, principal, stateView);
			} else {
				return "FALSE";
			}
		}
		return "OK";
	}
}