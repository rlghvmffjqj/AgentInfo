package com.secuve.agentInfo.schedule;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;

import com.secuve.agentInfo.service.ServiceControlService;

@Component
public class ServiceControlSchedule  extends QuartzJobBean {
	@Autowired ServiceControlService serviceControlService;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		serviceControlService.serviceControlSynchronization();
	}
}
