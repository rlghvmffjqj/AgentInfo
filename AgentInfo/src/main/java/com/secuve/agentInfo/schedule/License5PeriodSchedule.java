package com.secuve.agentInfo.schedule;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
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
import com.secuve.agentInfo.vo.License5;

@Component
public class License5PeriodSchedule  extends QuartzJobBean {
	@Autowired License5Dao license5Dao;
	@Autowired MailSendController mailSendController;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		int period = 7;
		List<License5> list = license5Dao.getLicenseListPeriod(period);
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("licenseManager", "iamdev");
		
		for(License5 license5: list) {
			paramMap.put("target", license5.getRequesterId());
			long remainingDays = getRemainingDays(license5.getExpirationDays());
			paramMap.put("subject", "[알림] 라이선스 5.0 만료 "+remainingDays+"일 전 안내");
			String mailContent =
					"[라이선스 만료 안내]<br><br>"
					+ "담당 고객에서 사용 중인 라이선스 5.0의 만료일이 "+remainingDays+"일 남았음을 알려드립니다.<br>"
					+ "서비스 중단이 발생하지 않도록 만료 전에 갱신 절차를 진행해주시기 바랍니다.<br><br>"
					+ "- 고객사 명 : "+license5.getCustomerName()+"<br>"
					+ "- 사업 명 : "+license5.getBusinessName()+"<br>"
					+ "- 라이선스 명 : License 5.0<br>"
					+ "- 만료 예정일 : "+license5.getExpirationDays()+"<br>"
					+ "- 남은 기간 : "+remainingDays+"일<br><br>"
					+ "관련 문의는 시스템 관리자(litsong@secuve.com)에게 연락해주시기 바랍니다.<br><br>"
					+ "※ 본 메일은 시스템에서 자동으로 발송되었습니다. 회신하지 마십시오.";
			paramMap.put("text", mailContent);
			mailSendController.MailSendPeriodScheduleJob(paramMap);
		}
		
	}
	
	public static long getRemainingDays(String expirationStr) {
        // 문자열을 LocalDate로 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate expirationDate = LocalDate.parse(expirationStr, formatter);

        // 오늘 날짜
        LocalDate today = LocalDate.now();

        // 남은 일수 계산
        return ChronoUnit.DAYS.between(today, expirationDate);
    }
}
