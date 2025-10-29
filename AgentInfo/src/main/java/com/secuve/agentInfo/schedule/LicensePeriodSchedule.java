package com.secuve.agentInfo.schedule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.secuve.agentInfo.controller.MailSendController;
import com.secuve.agentInfo.dao.License5Dao;
import com.secuve.agentInfo.dao.LogGriffinDao;
import com.secuve.agentInfo.dao.RgriffinDao;
import com.secuve.agentInfo.service.MailSendService;
import com.secuve.agentInfo.vo.License5;
import com.secuve.agentInfo.vo.LogGriffin;
import com.secuve.agentInfo.vo.Rgriffin;
import com.secuve.agentInfo.vo.SendMailSetting;

@Component
public class LicensePeriodSchedule  extends QuartzJobBean {
	@Autowired License5Dao license5Dao;
	@Autowired MailSendController mailSendController;
	@Autowired MailSendService mailSendService;
	@Autowired LogGriffinDao logGriffinDao;
	@Autowired RgriffinDao rgriffinDao;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		license5();
		loggriffin();
		rgriffin();
	}
	
	public void license5() {
		SendMailSetting sendMailSetting = mailSendService.getTargetSetting("license");
		List<License5> singleList = license5Dao.getLicenseListPeriodSingle(sendMailSetting.getSendMailSettingSingle());
		List<License5> dailyList = license5Dao.getLicenseListPeriodDaily(sendMailSetting.getSendMailSettingDaily());
		List<String> toList = new ArrayList<>();
		String[] cc = sendMailSetting.getSendMailSettingIssuance().split(",");
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("licenseManager", sendMailSetting.getSendMailSettingManager());
		paramMap.put("cc", sendMailSetting.getSendMailSettingIssuance());
		for(License5 license5: dailyList) {
			cc = sendMailSetting.getSendMailSettingIssuance().split(",");
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(license5.getRequesterId()) && license5.getRequesterId() != null) {
				toList.add(license5.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(license5.getSalesManagerId()) && license5.getSalesManagerId() != null) {
				toList.add(license5.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(license5.getExpirationDays());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 "+license5.getProductType()+" 라이선스 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+license5.getCustomerName()+"<br>"
					+ "- 사업 명 : "+license5.getBusinessName()+"<br>"
					+ "- 제품 명 : "+license5.getProductType()+"<br>"
					+ "- 라이선스 파일명 : : "+license5.getLicenseFilePath()+"<br>"
					+ "- 만료 예정일 : "+license5.getExpirationDays()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		}
		
		cc = sendMailSetting.getSendMailSettingIssuance().split(",");
		for(License5 license5: singleList) {
			cc = sendMailSetting.getSendMailSettingIssuance().split(",");
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(license5.getRequesterId()) && license5.getRequesterId() != null) {
				toList.add(license5.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(license5.getSalesManagerId()) && license5.getSalesManagerId() != null) {
				toList.add(license5.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(license5.getExpirationDays());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 "+license5.getProductType()+" 라이선스 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+license5.getCustomerName()+"<br>"
					+ "- 사업 명 : "+license5.getBusinessName()+"<br>"
					+ "- 제품 명 : "+license5.getProductType()+"<br>"
					+ "- 라이선스 파일명 : : "+license5.getLicenseFilePath()+"<br>"
					+ "- 만료 예정일 : "+license5.getExpirationDays()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		}
	}
	
	public void loggriffin() {
		SendMailSetting sendMailSetting = mailSendService.getTargetSetting("loggriffin");
		List<LogGriffin> singleList = logGriffinDao.getLicenseListPeriodSingle(sendMailSetting.getSendMailSettingSingle());
		List<LogGriffin> dailyList = logGriffinDao.getLicenseListPeriodDaily(sendMailSetting.getSendMailSettingDaily());
		List<String> toList = new ArrayList<>();
		String[] cc = sendMailSetting.getSendMailSettingIssuance().split(",");
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("licenseManager", sendMailSetting.getSendMailSettingManager());
		paramMap.put("cc", sendMailSetting.getSendMailSettingIssuance());
		for(LogGriffin logGriffin: dailyList) {
			cc = sendMailSetting.getSendMailSettingIssuance().split(",");
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(logGriffin.getRequesterId()) && logGriffin.getRequesterId() != null) {
				toList.add(logGriffin.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(logGriffin.getSalesManagerId()) && logGriffin.getSalesManagerId() != null) {
				toList.add(logGriffin.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(logGriffin.getExpirationDays());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 "+logGriffin.getProductName()+" "+logGriffin.getProductVersion()+" 라이선스 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+logGriffin.getCustomerName()+"<br>"
					+ "- 사업 명 : "+logGriffin.getBusinessName()+"<br>"
					+ "- 제품 명 : "+logGriffin.getProductName()+"<br>"
					+ "- 라이선스 파일명 : : "+logGriffin.getLicenseFilePath()+"<br>"
					+ "- 만료 예정일 : "+logGriffin.getExpirationDays()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		}
		
		for(LogGriffin logGriffin: singleList) {
			cc = sendMailSetting.getSendMailSettingIssuance().split(",");
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(logGriffin.getRequesterId()) && logGriffin.getRequesterId() != null) {
				toList.add(logGriffin.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(logGriffin.getSalesManagerId()) && logGriffin.getSalesManagerId() != null) {
				toList.add(logGriffin.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(logGriffin.getExpirationDays());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 "+logGriffin.getProductName()+" "+logGriffin.getProductVersion()+" 라이선스 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+logGriffin.getCustomerName()+"<br>"
					+ "- 사업 명 : "+logGriffin.getBusinessName()+"<br>"
					+ "- 제품 명 : "+logGriffin.getProductName()+"<br>"
					+ "- 라이선스 파일명 : : "+logGriffin.getLicenseFilePath()+"<br>"
					+ "- 만료 예정일 : "+logGriffin.getExpirationDays()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		}
	}
	
	public void rgriffin() {
		SendMailSetting sendMailSetting = mailSendService.getTargetSetting("rgriffin");
		List<Rgriffin> singleList = rgriffinDao.getLicenseListPeriodSingle(sendMailSetting.getSendMailSettingSingle());
		List<Rgriffin> dailyList = rgriffinDao.getLicenseListPeriodDaily(sendMailSetting.getSendMailSettingDaily());
		List<String> toList = new ArrayList<>();
		String[] cc = sendMailSetting.getSendMailSettingIssuance().split(",");
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("licenseManager", sendMailSetting.getSendMailSettingManager());
		paramMap.put("cc", sendMailSetting.getSendMailSettingIssuance());
		for(Rgriffin rgriffin: dailyList) {
			cc = sendMailSetting.getSendMailSettingIssuance().split(",");
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(rgriffin.getRequesterId()) && rgriffin.getRequesterId() != null) {
				toList.add(rgriffin.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(rgriffin.getSalesManagerId()) && rgriffin.getSalesManagerId() != null) {
				toList.add(rgriffin.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(rgriffin.getRgriffinExpire());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 rGRIFFIN 라이선스의 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+rgriffin.getRgriffinCompany()+"<br>"
					+ "- 카테고리 명 : "+rgriffin.getRgriffinCategory()+"<br>"
					+ "- 제품 명 : rGRIFFIN <br>"
					+ "- 라이선스 파일명 : : "+rgriffin.getRgriffinFilePath()+"<br>"
					+ "- 만료 예정일 : "+rgriffin.getRgriffinExpire()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		}
		
		cc = sendMailSetting.getSendMailSettingIssuance().split(",");
		for(Rgriffin rgriffin: singleList) {
			cc = sendMailSetting.getSendMailSettingIssuance().split(",");
			if("on".equals(sendMailSetting.getSendMailSettingRequester()) && !"".equals(rgriffin.getRequesterId()) && rgriffin.getRequesterId() != null) {
				toList.add(rgriffin.getRequesterId());
			}
			if("on".equals(sendMailSetting.getSendMailSettingSalesManager()) && !"".equals(rgriffin.getSalesManagerId()) && rgriffin.getSalesManagerId() != null) {
				toList.add(rgriffin.getSalesManagerId());
			}
			long remainingDays = mailSendService.getRemainingDays(rgriffin.getRgriffinExpire());
			paramMap.put("licenseSubject", sendMailSetting.getSendMailSettingSubject());
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 rGRIFFIN 라이선스의 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+rgriffin.getRgriffinCompany()+"<br>"
					+ "- 카테고리 명 : "+rgriffin.getRgriffinCategory()+"<br>"
					+ "- 제품 명 : rGRIFFIN <br>"
					+ "- 라이선스 파일명 : : "+rgriffin.getRgriffinFilePath()+"<br>"
					+ "- 만료 예정일 : "+rgriffin.getRgriffinExpire()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendService.mailSendPeriodScheduleJob(paramMap, toList, cc);
		}
	}
}
