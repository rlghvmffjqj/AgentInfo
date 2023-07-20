package com.secuve.agentInfo.service;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.core.MailService;
import com.secuve.agentInfo.dao.CustomerConsolidationDao;
import com.secuve.agentInfo.vo.CustomerConsolidation;


@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class CustomerConsolidationService {
	@Autowired CustomerConsolidationDao customerConsolidationDao;
	@Autowired MailService mailService;

	public List<CustomerConsolidation> getCustomerConsolidationList(CustomerConsolidation search) {
		return customerConsolidationDao.getCustomerConsolidationList(customerConsolidationSearch(search));
	}

	public int getCustomerConsolidationListCount(CustomerConsolidation search) {
		return customerConsolidationDao.getCustomerConsolidationListCount(customerConsolidationSearch(search));
	}
	
	public CustomerConsolidation customerConsolidationSearch(CustomerConsolidation search) {
		search.setCustomerConsolidationCustomerArr(search.getCustomerConsolidationCustomer().split(","));
		search.setCustomerConsolidationBusinessArr(search.getCustomerConsolidationBusiness().split(","));
		search.setCustomerConsolidationLocationArr(search.getCustomerConsolidationLocation().split(","));;
		search.setCustomerConsolidationEngineerArr(search.getCustomerConsolidationEngineer().split(","));
		search.setCustomerConsolidationCustomerManagerArr(search.getCustomerConsolidationCustomerManager().split(","));
		search.setCustomerConsolidationEmailArr(search.getCustomerConsolidationEmail().split(","));
		search.setCustomerConsolidationContactArr(search.getCustomerConsolidationContact().split(","));
		search.setCustomerConsolidationDepartmentArr(search.getCustomerConsolidationDepartment().split(","));
		
		return search;
	}
	
	public String nowDate() {
		Date now = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(now);
	}

	public String insertSales(CustomerConsolidation customerConsolidation, Principal principal) {
		if (customerConsolidation.getCustomerConsolidationCustomerView().equals("") || customerConsolidation.getCustomerConsolidationCustomerView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomer";
		}
		if (customerConsolidation.getCustomerConsolidationBusinessView().equals("") || customerConsolidation.getCustomerConsolidationBusinessView() == "") { // 고객사명 값이 비어있을 경우
			return "NotBussiness";
		}
		
		if(customerConsolidationDao.getDuplicationCustomerBusiness(customerConsolidation) > 0) {
			return "Duplication";
		}
		
		int sucess = customerConsolidationDao.insertSales(customerConsolidation);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}
	
	public String updateSales(CustomerConsolidation customerConsolidation) {
		if (customerConsolidation.getCustomerConsolidationCustomerView().equals("") || customerConsolidation.getCustomerConsolidationCustomerView() == "") { // 고객사명 값이 비어있을 경우
			return "NotCustomer";
		}
		if (customerConsolidation.getCustomerConsolidationBusinessView().equals("") || customerConsolidation.getCustomerConsolidationBusinessView() == "") { // 고객사명 값이 비어있을 경우
			return "NotBussiness";
		}
		
		CustomerConsolidation customerConsolidationOne = customerConsolidationDao.getCustomerConsolidationOne(customerConsolidation.getCustomerConsolidationKeyNum());
		if(!customerConsolidationOne.getCustomerConsolidationCustomer().equals(customerConsolidation.getCustomerConsolidationCustomerView()) && !customerConsolidationOne.getCustomerConsolidationBusiness().equals(customerConsolidation.getCustomerConsolidationBusinessView())) {
			if(customerConsolidationDao.getDuplicationCustomerBusiness(customerConsolidation) > 0) {
				return "Duplication";
			}
		}
		
		int sucess = customerConsolidationDao.updateSales(customerConsolidation);
		if (sucess <= 0)
			return "FALSE";
		return "OK";
	}

	public String delCustomerConsolidation(int[] chkList, Authentication authorities) {
		String customerConsolidationDepartment = "";
		String mismatch = "";
		if(authorities.getAuthorities().toString().equals("[ROLE_ENGINEERLEADER]")) {
			customerConsolidationDepartment = "보안기술사업본부";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_SALES]")) {
			customerConsolidationDepartment = "영업본부";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_LICENSE]")) {
			customerConsolidationDepartment = "평가 인증실";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_ADMIN]")) {
			customerConsolidationDepartment = "ADMIN";
		}
		CustomerConsolidation customerConsolidation = new CustomerConsolidation();
		for (int customerConsolidationsKeyNum : chkList) {
			customerConsolidation.setCustomerConsolidationKeyNum(customerConsolidationsKeyNum);
			customerConsolidation.setCustomerConsolidationDepartment(customerConsolidationDepartment);
			int sucess = customerConsolidationDao.delCustomerConsolidation(customerConsolidation);

			if (sucess <= 0) {
				if(customerConsolidationDepartment.equals("영업본부")) 
					mismatch = "SalesMISMATCH";
				else if(customerConsolidationDepartment.equals("보안기술사업본부"))
					mismatch = "EngineerLeaderMISMATCH";
			}
		}
		if(!mismatch.isEmpty())
			return mismatch;
		return "OK";
	}

	public CustomerConsolidation getCustomerConsolidationOne(int customerConsolidationKeyNum) {
		return customerConsolidationDao.getCustomerConsolidationOne(customerConsolidationKeyNum);
	}

	public String insertSecurityInfo(CustomerConsolidation customerConsolidation) {
		if (customerConsolidation.getCustomerConsolidationLocationView().equals("") || customerConsolidation.getCustomerConsolidationLocationView() == "") { // 사용처 값이 비어있을 경우
			return "NotLocation";
		}
		
		CustomerConsolidation customerConsolidationOne = customerConsolidationDao.getCustomerConsolidationOne(customerConsolidation.getCustomerConsolidationKeyNum());
		customerConsolidation.setCustomerConsolidationCustomerView(customerConsolidationOne.getCustomerConsolidationCustomer());
		customerConsolidation.setCustomerConsolidationBusinessView(customerConsolidationOne.getCustomerConsolidationBusiness());
		customerConsolidation.setCustomerConsolidationQuantityView(customerConsolidationOne.getCustomerConsolidationQuantity());
		customerConsolidation.setCustomerConsolidationBusinessPeriodStartView(customerConsolidationOne.getCustomerConsolidationBusinessPeriodStart());
		customerConsolidation.setCustomerConsolidationBusinessPeriodEndView(customerConsolidationOne.getCustomerConsolidationBusinessPeriodEnd());
		customerConsolidation.setCustomerConsolidationContractDateView(customerConsolidationOne.getCustomerConsolidationContractDate());
		
		if(customerConsolidationDao.getDuplicationCustomerBusinessLocation(customerConsolidation) > 0) {
			return "Duplication";
		}
		
		int sucess = customerConsolidationDao.insertSecurityInfo(customerConsolidation);
		if (sucess <= 0)
			return "FALSE";
		try {
			String customer = customerConsolidationOne.getCustomerConsolidationCustomer();
			String engineer = customerConsolidation.getCustomerConsolidationEngineerView();
			String business = customerConsolidation.getCustomerConsolidationBusinessView();
			String location = customerConsolidation.getCustomerConsolidationLocationView();
			String content = customer+" 담당 엔지니어 배정 안내드립니다. \n\n\n 고객사 : "+customer+ "\n 사업명 : "+business+"\n 사용처 : "+location+"\n 담당 엔지니어 : " +engineer+"\n\n\n 위와 같이 배정되었습니다.";
			mailService.sendNotiMail(customerConsolidation.getCustomerConsolidationEngineerIdView()+"@secuve.com", customer+" 담당 엔지니어 배정", content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "OK";
	}

	public String getRole(Authentication authorities) {
		if(authorities.getAuthorities().toString().equals("[ROLE_ENGINEERLEADER]")) {
			return "EngineerLeader";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_ENGINEER]")) {
			return "Engineer";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_SALES]")) {
			return "Sales";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_LICENSE]")) {
			return "License";
		} else if(authorities.getAuthorities().toString().equals("[ROLE_ADMIN]")) {
			return "Admin";
		}
		return null;
	}

	public String updateSecurityInfo(CustomerConsolidation customerConsolidation) {
		if (customerConsolidation.getCustomerConsolidationLocationView().equals("") || customerConsolidation.getCustomerConsolidationLocationView() == "") { // 고객사명 값이 비어있을 경우
			return "NotLocation";
		}
		
		CustomerConsolidation customerConsolidationOne = customerConsolidationDao.getCustomerConsolidationOne(customerConsolidation.getCustomerConsolidationKeyNum());
		if(!customerConsolidationOne.getCustomerConsolidationCustomer().equals(customerConsolidation.getCustomerConsolidationCustomerView()) && !customerConsolidationOne.getCustomerConsolidationBusiness().equals(customerConsolidation.getCustomerConsolidationBusinessView()) && !customerConsolidationOne.getCustomerConsolidationLocation().equals(customerConsolidation.getCustomerConsolidationLocationView())) {
			if(customerConsolidationDao.getDuplicationCustomerBusinessLocation(customerConsolidation) > 0) {
				return "Duplication";
			}
		}
		
		int sucess = customerConsolidationDao.updateSecurityInfo(customerConsolidation);
		if (sucess <= 0)
			return "FALSE";
		
		if(customerConsolidation.getCustomerConsolidationEngineerIdView().equals(customerConsolidationOne.getCustomerConsolidationEngineerId())) {
			try {
				String customer = customerConsolidationOne.getCustomerConsolidationCustomer();
				String engineerNew = customerConsolidation.getCustomerConsolidationEngineerView();
				String engineerOld = customerConsolidationOne.getCustomerConsolidationEngineer();
				String business = customerConsolidationOne.getCustomerConsolidationBusiness();
				String location = customerConsolidation.getCustomerConsolidationLocationView();
				String content = customer+" 담당 엔지니어 변경 안내드립니다. \n\n\n 고객사 : "+customer+ "\n 사업명 : "+business+"\n 사용처 : "+location+"\n 담당 엔지니어 : "+engineerNew+"\n\n\n 변경 전 : "+engineerOld+ "\n 변경 후 : "+engineerNew+"\n\n\n 위와 같이 변경되었습니다.";
				mailService.sendNotiMail(customerConsolidation.getCustomerConsolidationEngineerIdView()+"@secuve.com", customer+" 담당 엔지니어 변경", content);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "OK";
	}

	public List<CustomerConsolidation> getEngineerList(CustomerConsolidation search) {
		return customerConsolidationDao.getEngineerList(search);
	}

	public int getEngineerCount(CustomerConsolidation search) {
		return customerConsolidationDao.getEngineerCount(search);
	}


}
