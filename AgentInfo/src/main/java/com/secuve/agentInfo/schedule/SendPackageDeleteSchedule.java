package com.secuve.agentInfo.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.secuve.agentInfo.service.SendPackageService;

@Component
public class SendPackageDeleteSchedule extends QuartzJobBean {
	@Autowired SendPackageService sendPackageService;

	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		sendPackageService.deleteSendPackageSchedule();
	}

}
