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
import com.secuve.agentInfo.vo.empDump.VwUser;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class EmpDumpService {
	@Autowired EmpDumpDao empDempDao;
	
	private Random random = new Random();

	public String create(int empDumpCount, String empDumpCustomer) throws IOException {
		if(empDumpCustomer.equals("nhlife")) {
			nhlife(empDumpCount);
			return "nhlifeOk";
		} else if(empDumpCustomer.equals("btckorea")){
			nhlife(empDumpCount);
			return "btckoreaOK";
		} else if(empDumpCustomer.equals("kbank")){
			kbank(empDumpCount);
			return "kbankOk";
		} else if(empDumpCustomer.equals("nhqv")) {
			nhqv();
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
            user.setUser_email("user" + (i + 1) + "@example.com");
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
			user.setUser_email("user" + i + "@example.com");
			user.setUser_tel(generateRandomPhoneNumber());
			user.setUser_mobile("02-" + String.format("%04d", random.nextInt(10000)) + "-" + String.format("%04d", random.nextInt(10000)));
			user.setUser_dept("D" + (random.nextInt(5) + 1));
			user.setUser_dept_name("Department " + (random.nextInt(5) + 1));
			user.setPos_code("P" + (random.nextInt(5) + 1));
			user.setPos_name("Job " + (random.nextInt(5) + 1));
			user.setUser_type_sub(random.nextBoolean() ? "partner" : "employee");
			user.setApprov_type("Approval Type " + (random.nextInt(5) + 1));
			user.setOther_group_id("OG" + (random.nextInt(5) + 1));
			user.setUser_custom01("CustomField01-" + (random.nextInt(5) + 1));
			user.setUser_custom02("CustomField02-" + (random.nextInt(5) + 1));
			user.setUser_custom03("CustomField03-" + (random.nextInt(5) + 1));
            empDempDao.kbankInsert(user);
		}
	}
	
	public void nhqv() {
		
	}
	
	private String generateRandomPhoneNumber() {
        return "010-" + (random.nextInt(9000) + 1000) + "-" + (random.nextInt(9000) + 1000);
    }
	
	private String generateRandomUserTypeId() {
        String[] offices = {"employee","partner"};
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

    private String generateRandomStatus() {
        String[] statuses = {"WORKING", "RETIRE", "ABSENCE"};
        return statuses[random.nextInt(statuses.length)];
    }

    private String generateRandomDept() {
        String[] depts = {"HR", "Finance", "IT", "Marketing", "R&D"};
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
			nhqv();
		}
		return null;
	}

	private ResponseEntity<Resource> kbankDownLoad() {
		List<VwUser> list = empDempDao.kbankAll();
		StringBuilder data = new StringBuilder();
		data.append("CREATE TABLE vw_USER (\n")
		    .append("\tuser_id VARCHAR2(50), \n")          // EMPNUM -> user_id
		    .append("\tuser_name VARCHAR2(100), \n")       // EMPNAME -> user_name
		    .append("\tuser_email VARCHAR2(100), \n")      // EMAIL -> user_email
		    .append("\tuser_tel VARCHAR2(20), \n")         // PHONE -> user_tel
		    .append("\tuser_mobile VARCHAR2(20), \n")      // MOBILE -> user_mobile
		    .append("\tuser_dept VARCHAR2(50), \n")        // DEPTCODE -> user_dept
		    .append("\tuser_dept_name VARCHAR2(100), \n")  // DEPTNAME -> user_dept_name
		    .append("\tpos_code VARCHAR2(20), \n")         // POS_CODE -> pos_code
		    .append("\tpos_name VARCHAR2(100), \n")
		    .append("\tuser_type_sub VARCHAR2(20), \n")
		    .append("\tapprov_type VARCHAR2(50), \n")      // APPROV_TYPE -> approv_type
		    .append("\tother_group_id VARCHAR2(50), \n")   // OTHER_GROUP_ID -> other_group_id
		    .append("\tuser_custom01 VARCHAR2(100), \n")   // USER_CUSTOM01 -> user_custom01
		    .append("\tuser_custom02 VARCHAR2(100), \n")   // USER_CUSTOM02 -> user_custom02
		    .append("\tuser_custom03 VARCHAR2(100) \n")   // USER_CUSTOM03 -> user_custom03
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

		data.append("commit;");
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
	
	

}
