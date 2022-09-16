package com.secuve.agentInfo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerKey;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.secuve.agentInfo.dao.ScheduleJobDao;
import com.secuve.agentInfo.vo.ScheduleJob;

@Service
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Exception.class, RuntimeException.class})
public class ScheduleJobService{
	@Autowired ScheduleJobDao scheduleJobDao;
	@Autowired SchedulerFactoryBean schedulerFactory;
	
	JobKey packagesJobKey;
	JobKey employeeJobKey;
	JobKey serverListJobKey;
	
	TriggerKey packagesTriggerKey;
	TriggerKey employeeTriggerKey;
	TriggerKey serverListTriggerKey;
	
	public List<ScheduleJob> getScheduleJobList(ScheduleJob search) {
		Scheduler scheduler = schedulerFactory.getScheduler();
		Trigger trigger = null;
		List<ScheduleJob> scheduleJobList = scheduleJobDao.getScheduleJobList(search);
		getTriggerKey();
		try {
			for (ScheduleJob scheduleJob : scheduleJobList) {
				TriggerKey triggerKey = unityTriggerKey(scheduleJob.getScheduleName());
				trigger =  scheduler.getTrigger(triggerKey);
				if(scheduleJob.getScheduleState().equals("사용")) {
					try {
						scheduleJob.setScheduleStartTime(fromatterDate(trigger.getStartTime()));
						scheduleJob.setScheduleNextTime(fromatterDate(trigger.getNextFireTime()));
						scheduleJob.setScheduleLastTime(fromatterDate(trigger.getPreviousFireTime()));
						scheduleJob.setScheduleResult(scheduler.getTriggerState(triggerKey).toString());
					} catch (Exception e) {
						scheduleJob.setScheduleResult("Wait");
					}
				} 
			}
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		return scheduleJobList;
	}

	public ScheduleJob getScheduleOne(String scheduleName) {
		return scheduleJobDao.getScheduleOne(scheduleName);
	}

	public int getScheduleJobListCount() {
		return scheduleJobDao.getScheduleJobListCount();
	}

	public String schedulerUse(int[] chkList) {
		Scheduler scheduler = schedulerFactory.getScheduler();
		getScheduleKey();
		try {
			for (int scheduleKeyNum : chkList) {
				ScheduleJob scheduleJob = scheduleJobDao.getScheduleOneKeyNum(scheduleKeyNum);
				JobKey  jobKey = unityJobKey(scheduleJob.getScheduleName());
				scheduler.resumeJob(jobKey);
				scheduleJobDao.setScheduleStateUse(scheduleJob.getScheduleName());
			}
		} catch (SchedulerException e) {
			return "FALSE";
		}
		return "OK";
	}

	public String scheduleNotUse(int[] chkList) {
		Scheduler scheduler = schedulerFactory.getScheduler();
		getScheduleKey();
		try {
			for (int scheduleKeyNum : chkList) {
				ScheduleJob scheduleJob = scheduleJobDao.getScheduleOneKeyNum(scheduleKeyNum);
				JobKey jobKey = unityJobKey(scheduleJob.getScheduleName());
				scheduler.pauseJob(jobKey);
				scheduleJobDao.setScheduleStateNotUse(scheduleJob.getScheduleName());
			}
		} catch (SchedulerException e) {
			return "FALSE";
		}
		return "OK";
	}
	
	private String fromatterDate(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(date);
	}

	public String scheduleRun(String scheduleName) {
		getScheduleKey();
		JobKey jobKey = unityJobKey(scheduleName);
		Scheduler scheduler = schedulerFactory.getScheduler();
		try {
			scheduler.triggerJob(jobKey);
		} catch (SchedulerException e) {
			return "FALSE";
		}
		return "OK";
	}

	public String updateSchedule(String scheduleName, String scheduleState, String scheduleCron) throws Exception {
		Scheduler scheduler = schedulerFactory.getScheduler();
		getTriggerKey();
		getScheduleKey();
		CronTriggerImpl trigger = new CronTriggerImpl();
		try {
			JobKey jobKey = unityJobKey(scheduleName);
			TriggerKey triggerKey = unityTriggerKey(scheduleName);
			if(scheduleState.equals("사용")) {
				scheduler.resumeJob(jobKey);
			} else {
				scheduler.pauseJob(jobKey);
			}
			Trigger oldTrigger = scheduler.getTrigger(triggerKey);
			trigger.setName(scheduleName);
			trigger.setGroup("DEFAULT");
			trigger.setCronExpression(scheduleCron);
			trigger.setJobName(scheduleName);
			trigger.setDescription(oldTrigger.getDescription());
			scheduler.rescheduleJob(triggerKey, trigger);
			
			scheduleJobDao.updateScheduleJob(scheduleName, scheduleState, scheduleCron);
		} catch (SchedulerException e) {
			return "FALSE";
		}
		return "OK";
	}
	
	public JobKey unityJobKey(String scheduleName) {
		JobKey jobKey = null;
		if(scheduleName.equals("PACKAGES") || scheduleName.equals("packages")) {
			jobKey = packagesJobKey;
		} else if(scheduleName.equals("EMPLOYEE") || scheduleName.equals("employee")) {
			jobKey = employeeJobKey;
		} else if(scheduleName.equals("SERVERLIST") || scheduleName.equals("serverList")) {
			jobKey = serverListJobKey;
		}
		return jobKey;
	}
	
	public TriggerKey unityTriggerKey(String scheduleName) {
		TriggerKey triggerKey = null;
		if(scheduleName.equals("PACKAGES") || scheduleName.equals("packages")) {
			triggerKey = packagesTriggerKey;
		} else if(scheduleName.equals("EMPLOYEE") || scheduleName.equals("employee")) {
			triggerKey = employeeTriggerKey;
		} else if(scheduleName.equals("SERVERLIST") || scheduleName.equals("serverList")) {
			triggerKey = serverListTriggerKey;
		}
		return triggerKey;
	}
	
	public void getScheduleKey() {
		Scheduler scheduler = schedulerFactory.getScheduler();
		Set<JobKey> jobkey;
		try {
			jobkey = scheduler.getJobKeys(null);
	       	for(JobKey key: jobkey) {
	       		if(key.toString().equals("DEFAULT.packages")) {
	       			packagesJobKey = key;
	       		} else if(key.toString().equals("DEFAULT.employee")) {
	       			employeeJobKey = key;
	       		} else if(key.toString().equals("DEFAULT.serverList")) {
	       			serverListJobKey = key;
	       		}
	       	}
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	public void getTriggerKey() {
		Scheduler scheduler = schedulerFactory.getScheduler();
		Set<TriggerKey> jobkey;
		try {
			jobkey = scheduler.getTriggerKeys(null);
	       	for(TriggerKey key: jobkey) {
	       		if(key.toString().equals("DEFAULT.packages")) {
	       			packagesTriggerKey = key;
	       		} else if(key.toString().equals("DEFAULT.employee")) {
	       			employeeTriggerKey = key;
	       		} else if(key.toString().equals("DEFAULT.serverList")) {
	       			serverListTriggerKey = key;
	       		}
	       	}
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
}
