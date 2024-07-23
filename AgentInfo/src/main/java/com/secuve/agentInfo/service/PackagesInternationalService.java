package com.secuve.agentInfo.service;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
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

import com.secuve.agentInfo.dao.CustomerInfoDao;
import com.secuve.agentInfo.dao.PackageUidLogDao;
import com.secuve.agentInfo.dao.PackagesInternationalDao;
import com.secuve.agentInfo.dao.SendPackageDao;
import com.secuve.agentInfo.dao.TrashDao;
import com.secuve.agentInfo.vo.CustomerInfo;
import com.secuve.agentInfo.vo.PackageUidLog;
import com.secuve.agentInfo.vo.PackagesInternational;
import com.secuve.agentInfo.vo.SendPackage;
import com.secuve.agentInfo.vo.Trash;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class PackagesInternationalService {
	@Autowired PackagesInternationalDao packagesInternationalDao;
	@Autowired CategoryService categoryService;
	@Autowired PackagesInternational packagesInternational;
	@Autowired PackageUidLogDao packageUidLogDao;
	@Autowired TrashDao trashDao;
	@Autowired CustomerInfoDao customerInfoDao;
	@Autowired CustomerInfoService customerInfoService;
	@Autowired SendPackageDao sendPackageDao;
	@Autowired SendPackageService sendPackageService;

	/**
	 * 패키지 리스트 조회
	 * 
	 * @param search
	 * @return
	 */
	public List<PackagesInternational> getPackagesInternationalList(PackagesInternational search) {
		return packagesInternationalDao.getPackagesInternationalList(packagesInternationalSearch(search));
	}

	/**
	 * 패키지 Key Num 조회
	 * 
	 * @param search
	 * @return
	 */
	public int getPackagesInternationalListCount(PackagesInternational search) {
		return packagesInternationalDao.getPackagesInternationalListCount(packagesInternationalSearch(search));
	}

	/**
	 * 패키지 삭제
	 * 
	 * @param chkList
	 * @param principal
	 * @return
	 */
	public String delPackagesInternational(int[] chkList, Principal principal) {
		for (int packagesInternationalKeyNum : chkList) {
			PackagesInternational packagesInternational = packagesInternationalDao.getPackagesInternationalOne(packagesInternationalKeyNum);
			int sucess = packagesInternationalDao.delPackagesInternational(packagesInternationalKeyNum);
			List<SendPackage> sendPackageList =  sendPackageDao.getSendPackageListPackages(packagesInternationalKeyNum);
			for(SendPackage sendPackage : sendPackageList) {
				sendPackageService.updateDelete(sendPackage.getSendPackageKeyNum());
			}

			// uid 로그 기록
			if (sucess > 0) {
				packageUidLog(packagesInternational, principal, "DELETE");
				trash(packagesInternational, principal);
			}

			if (sucess <= 0)
				return "FALSE";
		}
		return "OK";
	}

	/**
	 * 패키지 추가
	 * 
	 * @param packagesInternational
	 * @param principal
	 * @return
	 */
	public String insertPackagesInternational(PackagesInternational packagesInternational, Principal principal) {
		if (packagesInternational.getCustomerNameSelf().length() > 0) {
			packagesInternational.setCustomerNameView(packagesInternational.getCustomerNameSelf());
		}
		if (packagesInternational.getCustomerNameView().equals("") || packagesInternational.getCustomerNameView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		selfInput(packagesInternational);
		packagesInternational.setState("배포완료");
		packagesInternational.setPackagesInternationalKeyNumOrigin(PackagesInternationalKeyNumOrigin());
		int sucess = packagesInternationalDao.insertPackagesInternational(packagesInternational);

		// uid 로그 기록 & 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			categoryService.insertCustomerBusinessMapping(packagesInternational.getCustomerNameView(), packagesInternational.getBusinessNameView());
			categoryCheck(packagesInternational, principal);
			packageUidLog(packagesInternational, principal, "INSERT");
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public int PackagesInternationalKeyNumOrigin() {
		int packagesInternationalKeyNumOrigin = 1;
		try {
			packagesInternationalKeyNumOrigin = packagesInternationalDao.getPackagesInternationalKeyNumOrigin();
		} catch (Exception e) {
			return packagesInternationalKeyNumOrigin;
		}
		return ++packagesInternationalKeyNumOrigin;
	}

	/**
	 * 리스트 복사
	 * @param packagesInternational
	 * @param principal
	 * @return
	 */
	public String copyPackagesInternational(PackagesInternational packagesInternational, Principal principal) {
		if (packagesInternational.getCustomerNameSelf().length() > 0) {
			packagesInternational.setCustomerNameView(packagesInternational.getCustomerNameSelf());
		}
		if (packagesInternational.getCustomerNameView().equals("") || packagesInternational.getCustomerNameView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomerName";
		}
		packagesInternationalDao.plusPackagesInternationalKeyNumOrigin(packagesInternational.getPackagesInternationalKeyNumOrigin()); // 복사 대상 윗 데이터 +1
		packagesInternational.setPackagesInternationalKeyNumOrigin(packagesInternational.getPackagesInternationalKeyNumOrigin() + 1); // 빈 공간 값 저장
		selfInput(packagesInternational);
		int sucess = packagesInternationalDao.insertPackagesInternational(packagesInternational);

		// uid 로그 기록 & 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			categoryService.insertCustomerBusinessMapping(packagesInternational.getCustomerNameView(), packagesInternational.getBusinessNameView());
			categoryCheck(packagesInternational, principal);
			packageUidLog(packagesInternational, principal, "INSERT");
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	/**
	 * 패키지 Key Num으로 하나의 정보 조회
	 * 
	 * @param packagesInternationalKeyNum
	 * @return
	 */
	public PackagesInternational getPackagesInternationalOne(int packagesInternationalKeyNum) {
		return packagesInternationalDao.getPackagesInternationalOne(packagesInternationalKeyNum);
	}

	/**
	 * 패키지 업데이트
	 * 
	 * @param packagesInternational
	 * @param principal
	 * @return
	 */
	public String updatePackagesInternational(PackagesInternational packagesInternational, Principal principal) {
		if (packagesInternational.getCustomerNameSelf().length() > 0) {
			packagesInternational.setCustomerNameView(packagesInternational.getCustomerNameSelf());
		}
		if (packagesInternational.getCustomerNameView().equals("") || packagesInternational.getCustomerNameView() == "") { // 사원 이름이 비어있을 경우 리턴
			return "NotCustomerName";
		}
		selfInput(packagesInternational);
		int sucess = packagesInternationalDao.updatePackagesInternational(packagesInternational);

		// uid 로그 기록 & 카테고리 추가 & 고객사 비즈니스 매핑
		if (sucess > 0) {
			categoryService.insertCustomerBusinessMapping(packagesInternational.getCustomerNameView(), packagesInternational.getBusinessNameView());
			categoryCheck(packagesInternational, principal);
			packageUidLog(packagesInternational, principal, "UPDATE");
		}
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	/**
	 * 패키지 리스트 전체 조회
	 * 
	 * @param packagesInternational
	 * @return
	 */
	public List<PackagesInternational> listAll(PackagesInternational packagesInternational) {
		return packagesInternationalDao.getPackagesInternationalListAll(packagesInternationalSearch(packagesInternational));
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
	public String importPackagesInternationalXlxs2019(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;

		XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		XSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 6; i < sheet.getLastRowNum() + 1; i++) {
			PackagesInternational packagesInternational = new PackagesInternational();
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
				packagesInternational.setCustomerNameView(cell.getStringCellValue());
				if (categoryService.getCategory("customerName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("customerName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setBusinessNameView(cell.getStringCellValue());
			}
			// 행의 4번째 열(요청일자) 데이터 손실로 주석 처리
			// cell = row.getCell(3);
			// if (null != cell) {
			// 	date = cell.getDateCellValue();
			// 	String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
			// 	packagesInternational.setRequestDateView(cellString);
			// }
			// 행의 5번째 열(전달일자)
			cell = row.getCell(4);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packagesInternational.setDeliveryDataView(cellString);
			}
			// 행의 6번째 열(기존/신규)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setExistingNewView(cell.getStringCellValue());
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
				packagesInternational.setManagementServerView(cell.getStringCellValue());
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
				packagesInternational.setAgentOSView(cell.getStringCellValue());
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
				packagesInternational.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 10번째 열(OS종류)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setOsTypeView(cell.getStringCellValue());
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
				packagesInternational.setAgentVerView(cell.getStringCellValue());
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
				packagesInternational.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 13번째 열(담당자)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setManagerView(cell.getStringCellValue());
			}
			// 행의 14번째 열(요청 제품구분)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setRequestProductCategoryView(cell.getStringCellValue());
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
				packagesInternational.setDeliveryMethodView(cell.getStringCellValue());
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
				packagesInternational.setNoteView(cell.getStringCellValue());
			}

			// 키값 저장
			packagesInternational.setPackagesInternationalKeyNumOrigin(PackagesInternationalKeyNumOrigin());
			// 로그인 사용자 아이디
			packagesInternational.setPackagesInternationalRegistrant(principal.getName());
			packagesInternational.setPackagesInternationalRegistrationDate(nowDate());

			// 패키지 데이터 저장
			packagesInternationalDao.insertPackagesInternational(packagesInternational);
			// uid 로그 기록
			packageUidLog(packagesInternational, principal, "INSERT");
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
	public String importPackagesInternationalXlxs2021(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;

		XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		XSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 4; i < sheet.getLastRowNum() + 1; i++) {
			PackagesInternational packagesInternational = new PackagesInternational();
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
				packagesInternational.setCustomerNameView(cell.getStringCellValue());
				if (categoryService.getCategory("customerName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("customerName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				cell.setCellType(Cell.CELL_TYPE_STRING);
			}
			packagesInternational.setBusinessNameView(cell.getStringCellValue());
			// 행의 4번째 열(요청일자)
			cell = row.getCell(3);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packagesInternational.setRequestDateView(cellString);
			}
			// 행의 5번째 열(전달일자)
			cell = row.getCell(4);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packagesInternational.setDeliveryDataView(cellString);
			}
			// 행의 6번째 열(기존/신규)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
					packagesInternational.setExistingNewView(cell.getStringCellValue());
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
				packagesInternational.setManagementServerView(cell.getStringCellValue());
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
				packagesInternational.setAgentOSView(cell.getStringCellValue());
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
				packagesInternational.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 10번째 열(OS종류)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setOsTypeView(cell.getStringCellValue());
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
				packagesInternational.setAgentVerView(cell.getStringCellValue());
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
				packagesInternational.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 13번째 열(담당자)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setManagerView(cell.getStringCellValue());
			}
			// 행의 14번째 열(요청 제품구분)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setRequestProductCategoryView(cell.getStringCellValue());
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
				packagesInternational.setDeliveryMethodView(cell.getStringCellValue());
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
				packagesInternational.setNoteView(cell.getStringCellValue());
			}

			// 키값 저장
			packagesInternational.setPackagesInternationalKeyNumOrigin(PackagesInternationalKeyNumOrigin());
			// 로그인 사용자 아이디
			packagesInternational.setPackagesInternationalRegistrant(principal.getName());
			// 저장 시간(현재 시간)
			packagesInternational.setPackagesInternationalRegistrationDate(nowDate());

			// 패키지 데이터 저장
			packagesInternationalDao.insertPackagesInternational(packagesInternational);
			// uid 로그 기록
			packageUidLog(packagesInternational, principal, "INSERT");
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
	public String importPackagesInternationalXlxs2022(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;

		XSSFWorkbook workbook = new XSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		XSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 4; i < sheet.getLastRowNum() + 1; i++) {
			PackagesInternational packagesInternational = new PackagesInternational();
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
				packagesInternational.setCustomerNameView(cell.getStringCellValue());
				if (categoryService.getCategory("customerName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("customerName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				cell.setCellType(Cell.CELL_TYPE_STRING);
			}
			packagesInternational.setBusinessNameView(cell.getStringCellValue());
			// 행의 4번째 열(요청일자)
			cell = row.getCell(3);
			if (null != cell) {
				date = cell.getDateCellValue();
				String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
				packagesInternational.setRequestDateView(cellString);
			}
			// 행의 5번째 열(전달일자)
			cell = row.getCell(4);
			if (null != cell)
				date = cell.getDateCellValue();
			String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
			packagesInternational.setDeliveryDataView(cellString);
			// 행의 6번째 열(기존/신규)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setExistingNewView(cell.getStringCellValue());
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
				packagesInternational.setManagementServerView(cell.getStringCellValue());
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
				packagesInternational.setAgentOSView(cell.getStringCellValue());
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
				packagesInternational.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 10번째 열(일반/커스텀)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setGeneralCustomView(cell.getStringCellValue());
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
				packagesInternational.setOsTypeView(cell.getStringCellValue());
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
				packagesInternational.setAgentVerView(cell.getStringCellValue());
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
				packagesInternational.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 14번째 열(담당자)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setManagerView(cell.getStringCellValue());
			}
			// 행의 15번째 열(요청 제품구분)
			cell = row.getCell(14);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setRequestProductCategoryView(cell.getStringCellValue());
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
				packagesInternational.setDeliveryMethodView(cell.getStringCellValue());
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
				packagesInternational.setNoteView(cell.getStringCellValue());
			}

			// 키값 저장
			packagesInternational.setPackagesInternationalKeyNumOrigin(PackagesInternationalKeyNumOrigin());
			// 로그인 사용자 아이디
			packagesInternational.setPackagesInternationalRegistrant(principal.getName());
			// 저장 시간(현재 시간)
			packagesInternational.setPackagesInternationalRegistrationDate(nowDate());

			packagesInternationalDao.insertPackagesInternational(packagesInternational);
			// 고객사 사업명 매핑
			categoryService.insertCustomerBusinessMapping(packagesInternational.getCustomerNameView(), packagesInternational.getBusinessNameView());
			// uid 로그 기록
			packageUidLog(packagesInternational, principal, "INSERT");
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
	public String importPackagesInternationalCSV(MultipartFile mfile, Principal principal) throws IOException {
		Date date = null;
		String cellString;

		// OPCPackage opcPackage = OPCPackage.open(mfile.getInputStream());
		HSSFWorkbook workbook = new HSSFWorkbook(mfile.getInputStream());
		// 첫번째 시트 불러오기
		HSSFSheet sheet = workbook.getSheetAt(0);

		// 4번 째 행부터 조회
		for (int i = 1; i < sheet.getLastRowNum() + 1; i++) {
			PackagesInternational packagesInternational = new PackagesInternational();
			HSSFRow row = sheet.getRow(i);

			// 행이 존재하기 않으면 패스
			if (null == row) {
				continue;
			}

			// 행의 2번째 열(고객사 명)
			HSSFCell cell = row.getCell(1);

			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				if (cell.getStringCellValue() == "" || cell.getStringCellValue() == null) {
					return "OK";
				}
				packagesInternational.setCustomerNameView(cell.getStringCellValue());
				if (categoryService.getCategory("customerName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("customerName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 3번째 열(사업명)
			cell = row.getCell(2);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setBusinessNameView(cell.getStringCellValue());
				if (categoryService.getCategory("businessName", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("businessName", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 4번째 열(망 구분)
			cell = row.getCell(3);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setNetworkClassificationView(cell.getStringCellValue());
			}
			// 행의 5번째 열(요청일자)
			cell = row.getCell(4);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setRequestDateView(cell.getStringCellValue());
			}
			// 행의 6번째 열(전달일자)
			cell = row.getCell(5);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setDeliveryDataView(cell.getStringCellValue());
			}
			// 행의 7번째 열(상태)
			cell = row.getCell(6);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setStateView(cell.getStringCellValue());
			}
			// 행의 8번째 열(패키지 종류)
			cell = row.getCell(7);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setManagementServerView(cell.getStringCellValue());
				if (categoryService.getCategory("managementServer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("managementServer", cell.getStringCellValue(), principal.getName(),	nowDate());
				}
			}
			// 행의 9번째 열(일반/커스텀)
			cell = row.getCell(8);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setGeneralCustomView(cell.getStringCellValue());
				if (categoryService.getCategory("generalCustom", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("generalCustom", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 10번째 열(Agent ver)
			cell = row.getCell(9);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setAgentVerView(cell.getStringCellValue());
				if (categoryService.getCategory("agentVer", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentVer", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 11번째 열(패키지명)
			cell = row.getCell(10);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setPackageNameView(cell.getStringCellValue());
			}
			// 행의 12번째 열(담당자)
			cell = row.getCell(11);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setManagerView(cell.getStringCellValue());
			}
			// 행의 13번째 열(OS종류)
			cell = row.getCell(12);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setOsTypeView(cell.getStringCellValue());
				if (categoryService.getCategory("osType", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("osType", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 14번째 열(패키지 상세버전)
			cell = row.getCell(13);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setOsDetailVersionView(cell.getStringCellValue());
			}
			// 행의 15번째 열(Agent OS)
			cell = row.getCell(14);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setAgentOSView(cell.getStringCellValue());
				if (categoryService.getCategory("agentOS", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("agentOS", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 16번째 열(기존/신규)
			cell = row.getCell(15);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setExistingNewView(cell.getStringCellValue());
				if (categoryService.getCategory("existingNew", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("existingNew", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 17번째 열(요청 제품구분)
			cell = row.getCell(16);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setRequestProductCategoryView(cell.getStringCellValue());
				if (categoryService.getCategory("requestProductCategory", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("requestProductCategory", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 18번째 열(전달 방법)
			cell = row.getCell(17);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setDeliveryMethodView(cell.getStringCellValue());
				if (categoryService.getCategory("deliveryMethod", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("deliveryMethod", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 19번째 열(구매구분)
			cell = row.getCell(18);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setPurchaseCategoryView(cell.getStringCellValue());
				if (categoryService.getCategory("purchaseCategory", cell.getStringCellValue()) == 0) {
					categoryService.setCategory("purchaseCategory", cell.getStringCellValue(), principal.getName(), nowDate());
				}
			}
			// 행의 20번째 열(비고)
			cell = row.getCell(19);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setNoteView(cell.getStringCellValue());
			}
			
			// 행의 20번째 열(상태변경의견)
			cell = row.getCell(20);
			if (null != cell) {
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cell.setCellType(Cell.CELL_TYPE_STRING);
				}
				packagesInternational.setStatusComment(cell.getStringCellValue());
			}

			// 키값 저장
			packagesInternational.setPackagesInternationalKeyNumOrigin(PackagesInternationalKeyNumOrigin());
			// 로그인 사용자 아이디
			packagesInternational.setPackagesInternationalRegistrant(principal.getName());
			packagesInternational.setPackagesInternationalRegistrationDate(nowDate());

			packagesInternationalDao.insertPackagesInternational(packagesInternational);
			// 고객사 사업명 매핑
			categoryService.insertCustomerBusinessMapping(packagesInternational.getCustomerNameView(), packagesInternational.getBusinessNameView());
			
			// uid 로그 기록
			packageUidLog(packagesInternational, principal, "INSERT");
		}
		return "OK";
	}

	/**
	 * UPDATE, INSERT, DELETE 이벤트 로그 저장
	 * 
	 * @param packagesInternational
	 * @param principal
	 * @param event
	 */
	public void packageUidLog(PackagesInternational packagesInternational, Principal principal, String event) {
		PackageUidLog packageUidLog = new PackageUidLog();
		packageUidLog.setPackagesKeyNum(packagesInternational.getPackagesInternationalKeyNum());
		if(event == "DELETE" || event.equals("적용") || event.equals("대기") || event.equals("배포완료")) {
			packageUidLog.setUidCustomerName(packagesInternational.getCustomerName());
			packageUidLog.setUidOsDetailVersion(packagesInternational.getOsDetailVersion());
			packageUidLog.setUidPackageName(packagesInternational.getPackageName());
		} else {
			packageUidLog.setUidCustomerName(packagesInternational.getCustomerNameView());
			packageUidLog.setUidOsDetailVersion(packagesInternational.getOsDetailVersionView());
			packageUidLog.setUidPackageName(packagesInternational.getPackageNameView());
		}
		packageUidLog.setPackagesKeyNum(packagesInternational.getPackagesInternationalKeyNum());
		packageUidLog.setUidEvent(event);
		packageUidLog.setUidUser(principal.getName());
		packageUidLog.setUidTime(nowDate());
		packageUidLogDao.insertPackageUidLog(packageUidLog);
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
	 * @param packagesInternational
	 * @return
	 */
	public PackagesInternational selfInput(PackagesInternational packagesInternational) {
		if(packagesInternational.getManagementServerSelf().length() > 0) 
			packagesInternational.setManagementServerView(packagesInternational.getManagementServerSelf());
		if(packagesInternational.getGeneralCustomSelf().length() > 0)
			packagesInternational.setGeneralCustomView(packagesInternational.getGeneralCustomSelf());
		if(packagesInternational.getAgentVerSelf().length() > 0)
			packagesInternational.setAgentVerView(packagesInternational.getAgentVerSelf());
		if(packagesInternational.getOsTypeSelf().length() > 0)
			packagesInternational.setOsTypeView(packagesInternational.getOsTypeSelf());
		if(packagesInternational.getAgentOSSelf().length() > 0)
			packagesInternational.setAgentOSView(packagesInternational.getAgentOSSelf());
		if(packagesInternational.getExistingNewSelf().length() > 0)
			packagesInternational.setExistingNewView(packagesInternational.getExistingNewSelf());
		if(packagesInternational.getRequestProductCategorySelf().length() > 0)
			packagesInternational.setRequestProductCategoryView(packagesInternational.getRequestProductCategorySelf());
		if(packagesInternational.getDeliveryMethodSelf().length() > 0)
			packagesInternational.setDeliveryMethodView(packagesInternational.getDeliveryMethodSelf());
		if(packagesInternational.getPurchaseCategorySelf().length() > 0)
			packagesInternational.setPurchaseCategoryView(packagesInternational.getPurchaseCategorySelf());
		if(packagesInternational.getCustomerNameSelf().length() > 0)
			packagesInternational.setCustomerNameView(packagesInternational.getCustomerNameSelf());
		if(packagesInternational.getBusinessNameSelf().length() > 0)
			packagesInternational.setBusinessNameView(packagesInternational.getBusinessNameSelf());
		
		return packagesInternational;
	}
	
	/**
	 * 직접 입력 시 카테고리가 없을 경우 추가
	 * @param packagesInternational
	 * @param principal
	 */
	public void categoryCheck(PackagesInternational packagesInternational, Principal principal) {
		if (categoryService.getCategory("managementServer", packagesInternational.getManagementServerView()) == 0) {
			categoryService.setCategory("managementServer", packagesInternational.getManagementServerView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("generalCustom", packagesInternational.getGeneralCustomView()) == 0) {
			categoryService.setCategory("generalCustom", packagesInternational.getGeneralCustomView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("agentVer", packagesInternational.getAgentVerView()) == 0) {
			categoryService.setCategory("agentVer", packagesInternational.getAgentVerView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("osType", packagesInternational.getOsTypeView()) == 0) {
			categoryService.setCategory("osType", packagesInternational.getOsTypeView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("agentOS", packagesInternational.getAgentOSView()) == 0) {
			categoryService.setCategory("agentOS", packagesInternational.getAgentOSView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("existingNew", packagesInternational.getExistingNewView()) == 0) {
			categoryService.setCategory("existingNew", packagesInternational.getExistingNewView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("requestProductCategory", packagesInternational.getRequestProductCategoryView()) == 0) {
			categoryService.setCategory("requestProductCategory", packagesInternational.getRequestProductCategoryView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("deliveryMethod", packagesInternational.getDeliveryMethodView()) == 0) {
			categoryService.setCategory("deliveryMethod", packagesInternational.getDeliveryMethodView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("purchaseCategory", packagesInternational.getPurchaseCategoryView()) == 0) {
			categoryService.setCategory("purchaseCategory", packagesInternational.getPurchaseCategoryView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("customerName", packagesInternational.getCustomerNameView()) == 0) {
			categoryService.setCategory("customerName", packagesInternational.getCustomerNameView(), principal.getName(), nowDate());
		}
		if (categoryService.getCategory("businessName", packagesInternational.getBusinessNameView()) == 0) {
			categoryService.setCategory("businessName", packagesInternational.getBusinessNameView(), principal.getName(), nowDate());
		}
	}
	
	/**
	 * 검색 엔진 배열로 변경
	 * @param search
	 * @return
	 */
	public PackagesInternational packagesInternationalSearch(PackagesInternational search) {
		search.setCustomerNameArr(search.getCustomerName().split(","));
		search.setBusinessNameArr(search.getBusinessName().split(","));
		search.setNetworkClassificationArr(search.getNetworkClassification().split(","));;
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
		search.setPurchaseCategoryArr(search.getPurchaseCategory().split(","));
		if(search.getCustomerId() != "" && search.getCustomerId() != null) {
			search.setCustomerIdArr(search.getCustomerId().split(","));
			for(int i=0; i<search.getCustomerIdArr().length; i++) {
				search.getCustomerIdArr()[i] = String.valueOf(Integer.parseInt(search.getCustomerIdArr()[i].substring(2)));
			}
		}
		
		return search;
	}

	/**
	 * 패키지 배포 현황 차트
	 * @return
	 */
	public List<Integer> getChartManagementServer(String managementServerYear) {
		int count = 0;
		List<Integer> list = new ArrayList<Integer>();
		List<PackagesInternational> packagesInternationalList = packagesInternationalDao.getChartManagementServer(managementServerYear);
		Map<String, Integer> map = new HashMap<String, Integer>();
		for(PackagesInternational packagesInternational: packagesInternationalList) {
			map.put(packagesInternational.getChartName(), packagesInternational.getChartCount());
			if(!packagesInternational.getChartName().equals("관리서버") && !packagesInternational.getChartName().equals("Agent") && !packagesInternational.getChartName().equals("Portal") && !packagesInternational.getChartName().equals("TOSRF")) {
				count += packagesInternational.getChartCount();
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
	public List<Integer> getOsType(String osTypeYear) {
		List<Integer> list = new ArrayList<Integer>();
		List<PackagesInternational> packagesInternationalList = packagesInternationalDao.getOsType(osTypeYear);
		Map<String, Integer> map = new HashMap<String, Integer>();
		for(PackagesInternational packagesInternational: packagesInternationalList) {
			map.put(packagesInternational.getChartName(), packagesInternational.getChartCount());
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
	public List<Integer> getChartRequestProductCategory(String requestProductCategoryYear) {
		List<Integer> list = new ArrayList<Integer>();
		PackagesInternational packagesInternational = packagesInternationalDao.getChartRequestProductCategory(requestProductCategoryYear);
		
		list.add(packagesInternational.getChartColumn1());
		list.add(packagesInternational.getChartColumn2());
		list.add(packagesInternational.getChartColumn3());
		list.add(packagesInternational.getChartColumn4());
		list.add(packagesInternational.getChartColumn5());
		
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
			topAgentVer = packagesInternationalDao.getTopAgentVer(osType);
			if(topAgentVer == null)
				topAgentVer = "Not Exist";
			topAgentVerArr = topAgentVer.split("-");
			PackagesInternational packagesInternational = new PackagesInternational();
			try {
				packagesInternational = packagesInternationalDao.getAgentVer(topAgentVerArr[0]);
				topAgentVerArr = packagesInternational.getChartName().split("-");
			} catch (Exception e) {
				packagesInternational.setChartName("Not Exist");
			}
			
			name.add(osType+". " + topAgentVerArr[0]);
			count.add(packagesInternational.getChartCount());
		}
		
		map.put("name", name);
		map.put("count", count);
		
		return map;
	}

	/**
	 * 월별 배포 현황(금년) 차트
	 * @param deliveryDataYear 
	 * @return
	 */
	public List<Integer> getDeliveryData(String deliveryDataYear) {
		List<Integer> list = new ArrayList<Integer>();
		List<PackagesInternational> packagesInternationalList = packagesInternationalDao.getDeliveryData(deliveryDataYear);
		Map<String, Integer> map = new HashMap<String, Integer>();
		String str = null;
		for(PackagesInternational packagesInternational: packagesInternationalList) {
			map.put(packagesInternational.getChartName(), packagesInternational.getChartCount());
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
	
	public List<Integer> getDeliveryAvgData() {
		LocalDate currentDate = LocalDate.now();
		int currentYear = currentDate.getYear();
		
		List<Integer> list = new ArrayList<Integer>();
		List<PackagesInternational> packagesInternationalList = packagesInternationalDao.getDeliveryAvgData(currentYear-2013);
		Map<String, Integer> map = new HashMap<String, Integer>();
		String str = null;
		for(PackagesInternational packagesInternational: packagesInternationalList) {
			map.put(packagesInternational.getChartName(), packagesInternational.getChartCount());
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
	public Map<String, List> getCustomerName(String customerNameYear) {
		Map<String, List> map = new HashMap();
		List<String> name = new ArrayList<String>();
		List<Integer> count = new ArrayList<Integer>();
		
		List<PackagesInternational> packagesInternationalList = packagesInternationalDao.getCustomerName(customerNameYear);
		
		for(PackagesInternational packagesInternational: packagesInternationalList) {
			name.add(packagesInternational.getChartName());
			count.add(packagesInternational.getChartCount());
		}
		map.put("name", name);
		map.put("count", count);

		return map;
	}
	
	/**
	 * 패키지 휴지통
	 * @param packagesInternational
	 * @param principal
	 */
	public void trash(PackagesInternational packagesInternational, Principal principal) {
		Trash trash = new Trash();

		trash.setTrashCustomerName(packagesInternational.getCustomerName());
		trash.setTrashBusinessName(packagesInternational.getBusinessName());
		trash.setTrashNetworkClassification(packagesInternational.getNetworkClassification());
		trash.setTrashRequestDate(packagesInternational.getRequestDate());
		trash.setTrashDeliveryData(packagesInternational.getDeliveryData());
		trash.setTrashExistingNew(packagesInternational.getExistingNew());
		trash.setTrashManagementServer(packagesInternational.getManagementServer());
		trash.setTrashAgentOS(packagesInternational.getAgentOS());
		trash.setTrashOsDetailVersion(packagesInternational.getOsDetailVersion());
		trash.setTrashAgentVer(packagesInternational.getAgentVer());
		trash.setTrashPackageName(packagesInternational.getPackageName());
		trash.setTrashOsType(packagesInternational.getOsType());
		trash.setTrashManager(packagesInternational.getManager());
		trash.setTrashGeneralCustom(packagesInternational.getGeneralCustom());
		trash.setTrashRequestProductCategory(packagesInternational.getRequestProductCategory());
		trash.setTrashDeliveryMethod(packagesInternational.getDeliveryMethod());
		trash.setTrashPurchaseCategory(packagesInternational.getPurchaseCategory());
		trash.setTrashNote(packagesInternational.getNote());
		trash.setTrashUser(principal.getName());
		trash.setTrashTime(nowDate());
		
		trashDao.insertTrash(trash);
	}

	public String stateChange(int[] chkList, String statusComment, String stateView, Principal principal) {
		for (int packagesInternationalKeyNum : chkList) {
			PackagesInternational packagesInternational = packagesInternationalDao.getPackagesInternationalOne(packagesInternationalKeyNum);
			int sucess = packagesInternationalDao.stateChange(packagesInternationalKeyNum, statusComment, stateView);

			// uid 로그 기록
			if (sucess > 0) {
				packageUidLog(packagesInternational, principal, stateView);
			} else {
				return "FALSE";
			}
		}
		return "OK";
	}

	public void updateProduct(int[] chkList, Principal principal) {
		for (int packagesInternationalKeyNum : chkList) {
			CustomerInfo customerInfo = new CustomerInfo();
			PackagesInternational packagesInternational = packagesInternationalDao.getPackagesInternationalOne(packagesInternationalKeyNum);
			customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
			if(customerInfo == null) {
				CustomerInfo customerInfoSub = new CustomerInfo();
				customerInfoSub.setCustomerName(packagesInternational.getCustomerName());
				customerInfoSub.setBusinessName(packagesInternational.getBusinessName());
				customerInfoSub.setNetworkClassification(packagesInternational.getNetworkClassification());
				customerInfoDao.insertCustomerInfo(customerInfoSub);
				customerInfo = customerInfoSub;
			}
			if(packagesInternational.getManagementServer().equals("관리서버")) {
				customerInfoDao.updateTOSMS(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				updateProductCheck(packagesInternational, customerInfo.getProductCheck(), "tosms");
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(TOSMS)");
			} else if(packagesInternational.getManagementServer().equals("TOSRF")) {
				customerInfoDao.updateTOSRF(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				updateProductCheck(packagesInternational, customerInfo.getProductCheck(), "tosrf");
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(TOSRF)");
			} else if(packagesInternational.getManagementServer().equals("Portal")) {
				customerInfoDao.updatePORTAL(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				updateProductCheck(packagesInternational, customerInfo.getProductCheck(), "portal");
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(PORTAL)");
			} else if(packagesInternational.getManagementServer().equals("LogServer")) {
				customerInfoDao.updateLogServer(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(LogServer)");
			} else if(packagesInternational.getManagementServer().equals("ScvEA")) {
				customerInfoDao.updateScvEA(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(ScvEA)");
			} else if(packagesInternational.getManagementServer().equals("ScvCA")) {
				customerInfoDao.updateScvCA(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(ScvCA)");
			} else if(packagesInternational.getManagementServer().equals("Authclient")) {
				customerInfoDao.updateAuthclient(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), packagesInternational.getPackageName(), packagesInternational.getOsType());
				customerInfo = customerInfoDao.getCustomerInfoMapping(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification());
				customerInfoService.customerUidLog(customerInfo, principal, "UPDATE(Auth/PKI )");
			}
			
		}
	}
	
	public void updateProductCheck(PackagesInternational packagesInternational, String productCheck, String product) {
		if(productCheck == "" || productCheck == null) {
			customerInfoDao.updateProductCheck(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), product);
		} else {
			if(!productCheck.contains(product)) {
				customerInfoDao.updateProductCheck(packagesInternational.getCustomerName(), packagesInternational.getBusinessName(), packagesInternational.getNetworkClassification(), productCheck+","+product);
			}
		}
	}

	public List<PackagesInternational> getPackagesInternationalAll() {
		return packagesInternationalDao.getPackagesInternationalAll();
	}
	
}