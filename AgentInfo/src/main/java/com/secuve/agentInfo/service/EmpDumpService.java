package com.secuve.agentInfo.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.EmpDumpDao;
import com.secuve.agentInfo.vo.empDump.IfUser;
import com.secuve.agentInfo.vo.empDump.ViewNac;
import com.secuve.agentInfo.vo.empDump.ViewSamsung;
import com.secuve.agentInfo.vo.empDump.VwUser;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class EmpDumpService {
	@Autowired EmpDumpDao empDempDao;
	
	private Random random = new Random();

	public String create(int empDumpCount, String empDumpCustomer) {
		try {
			if(empDumpCustomer.equals("nhlife")) {
				nhlife(empDumpCount);
				return "nhlifeOK";
			} else if(empDumpCustomer.equals("btckorea")){
				nhlife(empDumpCount);
				return "btckoreaOK";
			} else if(empDumpCustomer.equals("kbank")){
				kbank(empDumpCount);
				return "kbankOK";
			} else if(empDumpCustomer.equals("nhqv")) {
				nhqv(empDumpCount);
				return "nhqvOK";
			} else if(empDumpCustomer.equals("samsunglife")) {
				samsunglife(empDumpCount);
				return "samsunglifeOK";
			}
		} catch (Exception e) {
			return "FALSE";
		}
		return "OK";
	}
	
	public void nhlife(int empDumpCount) throws IOException {
		empDempDao.nhLifeDelete();
		for (int i = 0; i < empDumpCount; i++) {
            IfUser user = new IfUser();
            user.setUser_id("E" + String.format("%03d", i + 1));
            user.setUser_number(UUID.randomUUID().toString().substring(0, 5));
            user.setUser_name("User " + (i + 1));
            user.setUser_phone(generateRandomPhoneNumber());
            user.setUser_office(generateRandomOffice());
            user.setUser_email("user" + (i + 1) + "@secuve.com");
            user.setUser_type_id(generateRandomUserTypeId());
            user.setUser_type_name(generateRandomUserType());
            user.setUser_position_id("P" + (random.nextInt(5) + 1));
            user.setUser_position_name(generateRandomPosition());
            user.setUser_title_id("T" + (random.nextInt(5) + 1));
            user.setUser_title_name(generateRandomTitle());
            user.setUser_status_id(generateRandomStatus());
            user.setUser_status_name("S" + (random.nextInt(3) + 1));
            user.setDept_id("D" + (random.nextInt(5) + 1));
            user.setDept_name(generateRandomDept());
            user.setHierarchy_id("H" + (random.nextInt(5) + 1));
            user.setHierarchy_name("Level " + (random.nextInt(5) + 1));
            empDempDao.nhLifeInsert(user);
        }
	}
	
	public void kbank(int empDumpCount) {
		empDempDao.kbankDelete();
		for (int i = 1; i <= empDumpCount; i++) {
			VwUser user = new VwUser();
			user.setUser_id("E" + String.format("%03d", i));  // 예시: E001, E002, ...
			user.setUser_name("User " + i);
			user.setUser_email("user" + i + "@secuve.com");
			user.setUser_tel(generateRandomPhoneNumber());
			user.setUser_mobile("02-" + String.format("%04d", random.nextInt(10000)) + "-" + String.format("%04d", random.nextInt(10000)));
			user.setUser_dept(generateRandomDept());
			user.setUser_dept_name(user.getUser_dept());
			user.setPos_code("P" + (random.nextInt(5) + 1));
			user.setPos_name("Job " + (random.nextInt(5) + 1));
			user.setUser_type_sub(random.nextBoolean() ? "0" : "1");
			user.setApprov_type("Approval Type " + (random.nextInt(5) + 1));
			user.setOther_group_id("OG" + (random.nextInt(5) + 1));
			user.setUser_custom01("CustomField01-" + (random.nextInt(5) + 1));
			user.setUser_custom02("CustomField02-" + (random.nextInt(5) + 1));
			user.setUser_custom03("CustomField03-" + (random.nextInt(5) + 1));
            empDempDao.kbankInsert(user);
		}
	}
	
	public void nhqv(int empDumpCount) {
		empDempDao.nhqvDelete();
        for (int i = 1; i <= empDumpCount; i++) {
        	ViewNac user = new ViewNac();
        	user.setSabun(sabunRandomTitle() + "EMP" + String.format("%03d", i));
            user.setJumin_no(generateRandomJuminNo());
            user.setNAME("User " + i);
            user.setStatus(nhqvRandomStatus());
            user.setOffice_tel(generateRandomPhoneNumber());
            user.setMail_id("user" + i + "@secuve.com");
            user.setOrg_cd("ORG" + String.format("%03d", random.nextInt(5) + 1));
            user.setOrg_nm(orgNm(user.getOrg_cd()));
            user.setPos_cd("POS" + String.format("%03d", random.nextInt(5) + 1));
            user.setPos_nm(posNm(user.getPos_cd()));
            empDempDao.nhqvInsert(user);
        }
	}
	
	public void samsunglife(int empDumpCount) {
		empDempDao.samsunglifeDelete();
		for (int i = 1; i <= empDumpCount; i++) {
			ViewSamsung user = new ViewSamsung();
			if(i%2 == 1) {
				user.setEmployeeid("EMP"+String.format("%03d", i));
				user.setAccountname("Account"+String.format("%02d", i));
				user.setKoreanname("삼성"+i);
				user.setJobresponsibility("Job " + String.format("%02d", random.nextInt(10)));
		        user.setJobduty("Duty " + String.format("%02d", random.nextInt(10)));
		        user.setEmail("user" + i + "@secuve.com");
		        user.setMobilephone(generateRandomPhoneNumber());
		        user.setTelephonenumber(generateRandomOffice());
		        user.setDepartmentcode("ORG" + String.format("%03d", random.nextInt(5) + 1));
		        user.setEmployeestatus(generateRandomStatus());
		        user.setCompanyname("Company " + (random.nextInt(5) + 1));
		        empDempDao.empSamsunglifeInsert(user);
			} else {
				user.setEmpnum("PARTNER" + String.format("%03d", i));
		        user.setAccountname("Account" + String.format("%03d", i));
		        user.setKoreanname("외주 " + i);
		        user.setJobposition("Position " + String.format("%02d", random.nextInt(10) + 1));
		        user.setEmail("user" + i + "@secuve.com");
		        user.setMobilephone(generateRandomPhoneNumber());
		        user.setOfficephone(generateRandomOffice());
		        user.setCompanyname("Secuve " + (random.nextInt(5) + 1));
		        user.setEmployeestatus(generateRandomStatus());
		        empDempDao.partnerSamsunglifeInsert(user);
			}
		}
	}
	
	
	
	private String sabunRandomTitle() {
    	String[] title = {"3_", "9_"};
        return title[random.nextInt(title.length)];
    }
	
	private String orgNm(String orgCd) {
		if(orgCd.equals("ORG001")) 
			return "인사부";
		else if(orgCd.equals("ORG002"))
			return "기획부";
		else if(orgCd.equals("ORG003"))
			return "영업부";
		else if(orgCd.equals("ORG004"))
			return "엔지니어부";
		else if(orgCd.equals("ORG005"))
			return "개발부";
		return "";
	}
	
	private String posNm(String posCd) {
		if(posCd.equals("POS001")) 
			return "사원";
		else if(posCd.equals("POS002"))
			return "대리";
		else if(posCd.equals("POS003"))
			return "차장";
		else if(posCd.equals("POS004"))
			return "과장";
		else if(posCd.equals("POS005"))
			return "대표";
		return "";
	}
        
    private String generateRandomJuminNo() {
        int birthYear = 1900 + random.nextInt(100); // Generate year between 1900 and 1999
        int birthMonth = random.nextInt(12) + 1;  // 1 to 12
        int birthDay = random.nextInt(28) + 1;    // 1 to 28
        int identifier = random.nextInt(1000000); // Last part of jumin_no
        return String.format("%02d%02d%02d-%06d", birthYear % 100, birthMonth, birthDay, identifier);
    }
	
	private String generateRandomPhoneNumber() {
        return "010-" + (random.nextInt(9000) + 1000) + "-" + (random.nextInt(9000) + 1000);
    }
	
	private String generateRandomUserTypeId() {
        String[] offices = {"EMPLOYEE","PARTNER"};
        return offices[random.nextInt(offices.length)];
    }

    private String generateRandomOffice() {
    	return "02-" + (random.nextInt(9000) + 1000) + "-" + (random.nextInt(9000) + 1000);
    }

    private String generateRandomUserType() {
        String[] types = {"Employee", "Contractor", "Intern"};
        return types[random.nextInt(types.length)];
    }

    private String generateRandomPosition() {
        String[] positions = {"Manager", "Team Lead", "Analyst", "Associate", "Consultant"};
        return positions[random.nextInt(positions.length)];
    }

    private String generateRandomTitle() {
    	String[] title = {"연구원", "전임", "선인", "책임", "대표"};
        return title[random.nextInt(title.length)];
    }
    
    private String nhqvRandomStatus() {
    	String[] statuses = {"10", "20"};
        return statuses[random.nextInt(statuses.length)];
    }

    private String generateRandomStatus() {
        String[] statuses = {"work", "leave"};
        return statuses[random.nextInt(statuses.length)];
    }

    private String generateRandomDept() {
        String[] depts = {"인사부", "기획부", "영업부", "엔지니어부", "개발부"};
        return depts[random.nextInt(depts.length)];
    }

	public List<IfUser> getNHLifeData(IfUser search) {
		return empDempDao.getNHLifeDataList(search);
	}

	public int getNHLifeDataCount() {
		return empDempDao.getNHLifeDataCount();
	}

	public ResponseEntity<Resource> downLoad(String siteName) {
		if(siteName.equals("nhlife") || siteName.equals("btckorea")) {
			return nhlifeDownLoad(siteName);
		} else if(siteName.equals("kbank")){
			return kbankDownLoad();
		} else if(siteName.equals("nhqv")) {
			return nhqvDownLoad();
		} else if(siteName.equals("nhqv")) {
			return samsunglifeDownLoad();
		}
		return null;
	}

	private ResponseEntity<Resource> kbankDownLoad() {
		List<VwUser> list = empDempDao.kbankAll();
		StringBuilder data = new StringBuilder();
		data.append("DROP TABLE IF EXISTS temp_employee; \n");
		
		data.append("CREATE TABLE temp_employee (\n")
		    .append("\tEMPTYPE VARCHAR(20) DEFAULT NULL, \n")
		    .append("\tEMPNUM VARCHAR(100) NOT NULL, \n")
		    .append("\tEMPNAME VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tEMAIL VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tMOBILE VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tPHONE VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tMSGID VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tCOMPANY VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tDEPTCODE VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tOLDDEPTCODE VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tDEPTNAME VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tDEPTFULLPATH VARCHAR(1024) DEFAULT NULL, \n")
		    .append("\tDEPTPARENTPATH VARCHAR(1024) DEFAULT NULL, \n")
		    .append("\tJOBTITLE VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tJOBLEVEL VARCHAR(10) DEFAULT NULL, \n")
		    .append("\tJOBNAME VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tEMPSTATUS VARCHAR(20) DEFAULT NULL, \n")
		    .append("\tSINGLEID VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tENEMPNAME VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tENCOMPANY VARCHAR(100) DEFAULT NULL, \n")
		    .append("\tENDEPTNAME VARCHAR(200) DEFAULT NULL, \n")
		    .append("\tENDEPTFULLPATH VARCHAR(1024) DEFAULT NULL, \n")
		    .append("\tENDEPTPARENTPATH VARCHAR(1024) DEFAULT NULL, \n")
		    .append("\tENJOBNAME VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tENJOBTITLE VARCHAR(50) DEFAULT NULL, \n")
		    .append("\tISMOVEDEPT VARCHAR(10) DEFAULT NULL, \n")
		    .append("\tDN VARCHAR(512) DEFAULT NULL, \n")
		    .append("\tSOURCE VARCHAR(10) DEFAULT NULL, \n")
		    .append("\tJOBTITLECD VARCHAR(25) DEFAULT NULL, \n")
		    .append("\tJOBPOSITIONCD VARCHAR(25) DEFAULT NULL, \n")
		    .append("\tPRIMARY KEY (EMPNUM) \n")
		    .append("); \n\n\n");
		//
		data.append("DROP TABLE IF EXISTS vw_dept; \n");
		
		data.append("CREATE TABLE vw_dept (\n")
		    .append("\tDEPT_CODE VARCHAR(100) NOT NULL, \n")
		    .append("\tHI_DEPT VARCHAR(100) DEFAULT '', \n")
		    .append("\tDEPT_NAME VARCHAR(200) DEFAULT '' \n")
		    .append("); \n");
		
		data.append("INSERT INTO vw_dept VALUES('인사부', '', '인사부');\n")
		    .append("INSERT INTO vw_dept VALUES('기획부', '', '기획부');\n")
		    .append("INSERT INTO vw_dept VALUES('영업부', '', '영업부');\n")
		    .append("INSERT INTO vw_dept VALUES('엔지니어부', '', '엔지니어부');\n")
		    .append("INSERT INTO vw_dept VALUES('개발부', '', '개발부');\n\n\n");
		//
		data.append("DROP TABLE IF EXISTS vw_USER; \n");
		
		data.append("CREATE TABLE vw_USER (\n")
		    .append("\tuser_id VARCHAR(50), \n")          // EMPNUM -> user_id
		    .append("\tuser_name VARCHAR(100), \n")       // EMPNAME -> user_name
		    .append("\tuser_email VARCHAR(100), \n")      // EMAIL -> user_email
		    .append("\tuser_tel VARCHAR(20), \n")         // PHONE -> user_tel
		    .append("\tuser_mobile VARCHAR(20), \n")      // MOBILE -> user_mobile
		    .append("\tuser_dept VARCHAR(50), \n")        // DEPTCODE -> user_dept
		    .append("\tuser_dept_name VARCHAR(100), \n")  // DEPTNAME -> user_dept_name
		    .append("\tpos_code VARCHAR(20), \n")         // POS_CODE -> pos_code
		    .append("\tpos_name VARCHAR(100), \n")
		    .append("\tuser_type_sub VARCHAR(20), \n")
		    .append("\tapprov_type VARCHAR(50), \n")      // APPROV_TYPE -> approv_type
		    .append("\tother_group_id VARCHAR(50), \n")   // OTHER_GROUP_ID -> other_group_id
		    .append("\tuser_custom01 VARCHAR(100), \n")   // USER_CUSTOM01 -> user_custom01
		    .append("\tuser_custom02 VARCHAR(100), \n")   // USER_CUSTOM02 -> user_custom02
		    .append("\tuser_custom03 VARCHAR(100) \n")   // USER_CUSTOM03 -> user_custom03
		    .append(");\n\n\n");


		// 리스트에 있는 모든 사용자 데이터에 대해 INSERT 쿼리 생성
		for (VwUser user : list) {
			String insertStatement = String.format("INSERT INTO vw_USER (" +
	                "USER_ID, USER_NAME, USER_EMAIL, USER_TEL, USER_MOBILE, USER_DEPT, USER_DEPT_NAME, POS_CODE, " +
	                "USER_TYPE_SUB, APPROV_TYPE, OTHER_GROUP_ID, USER_CUSTOM01, USER_CUSTOM02, USER_CUSTOM03) " +
	                "VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', " +
	                "'%s', '%s', '%s', '%s');\n",
	            user.getUser_id(), user.getUser_name(), user.getUser_email(),
	            user.getUser_tel(), user.getUser_mobile(), user.getUser_dept(),
	            user.getUser_dept_name(), user.getPos_code(), user.getUser_type_sub(),
	            user.getApprov_type(), user.getOther_group_id(),
	            user.getUser_custom01(), user.getUser_custom02(), user.getUser_custom03());
			data.append(insertStatement);

		}

		ByteArrayResource resource = new ByteArrayResource(data.toString().getBytes());

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    try {
	        String encodedFileName = URLEncoder.encode("K뱅크_HR.sql", StandardCharsets.UTF_8.toString());
	        headers.setContentDispositionFormData("attachment", encodedFileName);
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
	    
	    return ResponseEntity.ok().headers(headers).body(resource);
	}

	private ResponseEntity<Resource> nhlifeDownLoad(String siteName) {
		String customer = "";
		if(siteName.equals("nhlife")) {
			customer = "NHLife_HR.sql";
		} else if(siteName.equals("btckorea")) {
			customer = "비티씨코리아닷컴_HR.sql";
		}
		List<IfUser> list = empDempDao.nhLifeAll();
		StringBuilder data = new StringBuilder();
		data.append("DROP TABLE IF_USER; \n\n\n");
		
		data.append("CREATE TABLE IF_USER (\n")
	    .append("\tUSER_ID VARCHAR2(50), \n")
	    .append("\tUSER_NUMBER VARCHAR2(50), \n")
	    .append("\tUSER_NAME VARCHAR2(100), \n")
	    .append("\tUSER_PHONE VARCHAR2(20), \n")
	    .append("\tUSER_OFFICE VARCHAR2(100), \n")
	    .append("\tUSER_EMAIL VARCHAR2(100), \n")
	    .append("\tUSER_TYPE_ID VARCHAR2(50), \n")
	    .append("\tUSER_TYPE_NAME VARCHAR2(100), \n")
	    .append("\tUSER_POSITION_ID VARCHAR2(50), \n")
	    .append("\tUSER_POSITION_NAME VARCHAR2(100), \n")
	    .append("\tUSER_TITLE_ID VARCHAR2(50), \n")
	    .append("\tUSER_TITLE_NAME VARCHAR2(100), \n")
	    .append("\tUSER_STATUS_ID VARCHAR2(50), \n")
	    .append("\tUSER_STATUS_NAME VARCHAR2(100), \n")
	    .append("\tDEPT_ID VARCHAR2(50), \n")
	    .append("\tDEPT_NAME VARCHAR2(100), \n")
	    .append("\tHIERARCHY_ID VARCHAR2(50), \n")
	    .append("\tHIERARCHY_NAME VARCHAR2(100)\n")
	    .append(");\n\n\n");
		for (IfUser user : list) {
		    String insertStatement = String.format("INSERT INTO if_user (" +
		                    "user_id, user_number, user_name, user_phone, user_office, user_email, " +
		                    "user_type_id, user_type_name, user_position_id, user_position_name, " +
		                    "user_title_id, user_title_name, user_status_id, user_status_name, " +
		                    "dept_id, dept_name, hierarchy_id, hierarchy_name) " +
		                    "VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', " +
		                    "'%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');\n",
		            user.getUser_id(), user.getUser_number(), user.getUser_name(),
		            user.getUser_phone(), user.getUser_office(), user.getUser_email(),
		            user.getUser_type_id(), user.getUser_type_name(),
		            user.getUser_position_id(), user.getUser_position_name(),
		            user.getUser_title_id(), user.getUser_title_name(),
		            user.getUser_status_id(), user.getUser_status_name(),
		            user.getDept_id(), user.getDept_name(),
		            user.getHierarchy_id(), user.getHierarchy_name());
		    data.append(insertStatement);
		}
		data.append("commit;");
		ByteArrayResource resource = new ByteArrayResource(data.toString().getBytes());

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    try {
	        String encodedFileName = URLEncoder.encode(customer, StandardCharsets.UTF_8.toString());
	        headers.setContentDispositionFormData("attachment", encodedFileName);
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
	    
	    return ResponseEntity.ok().headers(headers).body(resource);
	}
	
	private ResponseEntity<Resource> nhqvDownLoad() {
		List<ViewNac> list = empDempDao.nhqvAll();
		StringBuilder data = new StringBuilder();
		data.append("DROP TABLE IF EXISTS view_nac_org; \n")
		    .append("CREATE TABLE view_nac_org (\n")
		    .append("\torg_cd VARCHAR(50) NOT NULL, \n")
		    .append("\torg_nm VARCHAR(50)\n")
		    .append(");\n");
		
		data.append("INSERT INTO view_nac_org (org_cd, org_nm) VALUES('ORG001','인사부');\n")
			.append("INSERT INTO view_nac_org (org_cd, org_nm) VALUES('ORG002','기획부');\n")
			.append("INSERT INTO view_nac_org (org_cd, org_nm) VALUES('ORG003','영업부');\n")
			.append("INSERT INTO view_nac_org (org_cd, org_nm) VALUES('ORG004','엔지니어부');\n")
			.append("INSERT INTO view_nac_org (org_cd, org_nm) VALUES('ORG005','개발부');\n\n\n");
	
		data.append("DROP TABLE IF EXISTS view_nac_grd; \n")
		    .append("CREATE TABLE view_nac_grd (\n")
		    .append("\tpos_cd VARCHAR(50) NOT NULL, \n")
		    .append("\tpos_nm VARCHAR(50)\n")
		    .append(");\n");
		
		data.append("INSERT INTO view_nac_grd (pos_cd, pos_nm) VALUES('POS001','사원');\n")
			.append("INSERT INTO view_nac_grd (pos_cd, pos_nm) VALUES('POS002','대리');\n")
			.append("INSERT INTO view_nac_grd (pos_cd, pos_nm) VALUES('POS003','차장');\n")
			.append("INSERT INTO view_nac_grd (pos_cd, pos_nm) VALUES('POS004','과장');\n")
			.append("INSERT INTO view_nac_grd (pos_cd, pos_nm) VALUES('POS005','대표');\n\n\n");
	
		data.append("DROP TABLE IF EXISTS view_nac_chf; \n")
		    .append("CREATE TABLE view_nac_chf (\n")
		    .append("\tchf_sabun VARCHAR(50) NOT NULL\n")
		    .append(");\n");
		
		data.append("INSERT INTO view_nac_chf (chf_sabun) VALUES('1001');\n\n\n");
	
		data.append("DROP TABLE IF EXISTS view_nac_emp; \n")
		    .append("CREATE TABLE view_nac_emp (\n")
		    .append("\tsabun VARCHAR(50) NOT NULL, \n")
		    .append("\tjumin_no VARCHAR(50), \n")
		    .append("\tNAME VARCHAR(50), \n")
		    .append("\tstatus VARCHAR(50), \n")
		    .append("\toffice_tel VARCHAR(50), \n")
		    .append("\tmail_id VARCHAR(50), \n")
		    .append("\torg_cd VARCHAR(50), \n")
		    .append("\tpos_cd VARCHAR(50)\n")
		    .append(");\n\n\n");
		
		// 리스트에 있는 모든 사용자 데이터에 대해 INSERT 쿼리 생성
		for (ViewNac user : list) {
			String insertStatement = String.format("INSERT INTO view_nac_emp (" +
	                "sabun, jumin_no, name, status, office_tel, mail_id, org_cd, pos_cd) " +
	                "VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');\n",
	            user.getSabun(), user.getJumin_no(), user.getNAME(),
	            user.getStatus(), user.getOffice_tel(), user.getMail_id(),
	            user.getOrg_cd(), user.getPos_cd());
			data.append(insertStatement);

		}

		ByteArrayResource resource = new ByteArrayResource(data.toString().getBytes());

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    try {
	        String encodedFileName = URLEncoder.encode("NH투자증권_HR.sql", StandardCharsets.UTF_8.toString());
	        headers.setContentDispositionFormData("attachment", encodedFileName);
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
	    
	    return ResponseEntity.ok().headers(headers).body(resource);
	}
	
	private ResponseEntity<Resource> samsunglifeDownLoad() {
		List<ViewSamsung> listEmp = empDempDao.samsunglifeEmpAll();
		List<ViewSamsung> listPartner = empDempDao.samsunglifePartnerAll();
		StringBuilder data = new StringBuilder();
		data.append("DROP TABLE IF EXISTS view_secuve_partners; \n")
		    .append("CREATE TABLE view_secuve_partners (\n")
		    .append("\tempnum VARCHAR(100) PRIMARY KEY, \n")
		    .append("\taccountname VARCHAR(100) NOT NULL, \n")
		    .append("\tkoreanname VARCHAR(100) NOT NULL, \n")
		    .append("\tjobposition VARCHAR(100), \n")
		    .append("\temail VARCHAR(100), \n")
		    .append("\tmobilephone VARCHAR(20), \n")
		    .append("\tofficephone VARCHAR(20), \n")
		    .append("\tcompanyname VARCHAR(100) NOT NULL, \n")
		    .append("\temployeestatus VARCHAR(50) \n")
		    .append("); \n\n\n");
		
	    data.append("DROP TABLE IF EXISTS view_secuve_employees; \n")
		    .append("CREATE TABLE view_secuve_employees (\n")
		    .append("\temployeeid VARCHAR(100) PRIMARY KEY, \n")
		    .append("\taccountname VARCHAR(100) NOT NULL, \n")
		    .append("\tkoreanname VARCHAR(100) NOT NULL, \n")
		    .append("\tjobresponsibility VARCHAR(100), \n")
		    .append("\tjobduty VARCHAR(100), \n")
		    .append("\temail VARCHAR(100), \n")
		    .append("\tmobilephone VARCHAR(20), \n")
		    .append("\ttelephonenumber VARCHAR(20), \n")
		    .append("\tdepartmentcode VARCHAR(50), \n")
		    .append("\temployeestatus VARCHAR(50), \n")
		    .append("\tcompanyname VARCHAR(100) \n")
		    .append("); \n\n\n");
	    
	    data.append("DROP TABLE IF EXISTS view_secuve_department; \n")
		    .append("CREATE TABLE view_secuve_department (\n")
		    .append("\tdepartmentcode VARCHAR(50) PRIMARY KEY, \n")
		    .append("\tparentdepartmentcode VARCHAR(50) NULL, \n")
		    .append("\tkoreanname VARCHAR(100) NOT NULL \n")
		    .append("); \n");
	    
	    data.append("INSERT INTO view_secuve_department (departmentcode, parentdepartmentcode, koreanname) VALUES('ORG000',null,'삼성생명');\n")
		    .append("INSERT INTO view_secuve_department (departmentcode, parentdepartmentcode, koreanname) VALUES('ORG001','ORG000','인사부');\n")
		    .append("INSERT INTO view_secuve_department (departmentcode, parentdepartmentcode, koreanname) VALUES('ORG002','ORG000','기획부');\n")
		    .append("INSERT INTO view_secuve_department (departmentcode, parentdepartmentcode, koreanname) VALUES('ORG003','ORG000','영업부');\n")
		    .append("INSERT INTO view_secuve_department (departmentcode, parentdepartmentcode, koreanname) VALUES('ORG004','ORG000','엔지니어부');\n")
		    .append("INSERT INTO view_secuve_department (departmentcode, parentdepartmentcode, koreanname) VALUES('ORG005','ORG000','개발부');\n");


		
		// 리스트에 있는 모든 사용자 데이터에 대해 INSERT 쿼리 생성
		for (ViewNac user : list) {
			String insertStatement = String.format("INSERT INTO view_nac_emp (" +
	                "sabun, jumin_no, name, status, office_tel, mail_id, org_cd, pos_cd) " +
	                "VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');\n",
	            user.getSabun(), user.getJumin_no(), user.getNAME(),
	            user.getStatus(), user.getOffice_tel(), user.getMail_id(),
	            user.getOrg_cd(), user.getPos_cd());
			data.append(insertStatement);

		}

		ByteArrayResource resource = new ByteArrayResource(data.toString().getBytes());

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    try {
	        String encodedFileName = URLEncoder.encode("NH투자증권_HR.sql", StandardCharsets.UTF_8.toString());
	        headers.setContentDispositionFormData("attachment", encodedFileName);
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	    }
	    
	    return ResponseEntity.ok().headers(headers).body(resource);
	}
	
	public void nhLifeDelete() {
		empDempDao.nhLifeDelete();
	}

	public List<VwUser> getKbankData(VwUser search) {
		return empDempDao.getKbankDataList(search);
	}

	public int getKbankDataCount() {
		return empDempDao.getKbankDataCount();
	}

	public void kbankDelete() {
		empDempDao.kbankDelete();
	}

	public List<ViewNac> getNhqvData(ViewNac search) {
		return empDempDao.getNhqvData(search);
	}
	
	public void nhqvDelete() {
		empDempDao.nhqvDelete();
	}

	public List<ViewSamsung> getSamsunglifeData(ViewSamsung search) {
		return empDempDao.getSamsunglifeData(search);
	}

	public int getSamsunglifeDataCount() {
		return empDempDao.getSamsunglifeDataCount();
	}

	public void samsunglifeDelete() {
		empDempDao.samsunglifeDelete();
	}

}
