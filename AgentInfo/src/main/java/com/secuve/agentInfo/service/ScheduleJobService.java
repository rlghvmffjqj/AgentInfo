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

import com.secuve.agentInfo.dao.ScheduleJobDao;
import com.secuve.agentInfo.vo.ScheduleJob;

@Service
public class ScheduleJobService{
	@Autowired ScheduleJobDao scheduleJobDao;
	@Autowired SchedulerFactoryBean schedulerFactory;
	
	JobKey packagesJobKey;
	JobKey employeeJobKey;
	
	TriggerKey packagesTriggerKey;
	TriggerKey employeeTriggerKey;

	public List<ScheduleJob> getScheduleJobList(ScheduleJob search) {
		Scheduler scheduler = schedulerFactory.getScheduler();
		Trigger packagesTrigger = null;
		Trigger employeeTrigger = null;
		List<ScheduleJob> scheduleJobList = scheduleJobDao.getScheduleJobList(search);
		getTriggerKey();
		try {
			packagesTrigger = scheduler.getTrigger(packagesTriggerKey);
			employeeTrigger = scheduler.getTrigger(employeeTriggerKey);
			for (ScheduleJob scheduleJob : scheduleJobList) {
				if(scheduleJob.getScheduleName().equals("packages") && scheduleJob.getScheduleState().equals("사용")) {
					try {
						scheduleJob.setScheduleStartTime(fromatterDate(packagesTrigger.getStartTime()));
						scheduleJob.setScheduleNextTime(fromatterDate(packagesTrigger.getNextFireTime()));
						scheduleJob.setScheduleLastTime(fromatterDate(packagesTrigger.getPreviousFireTime()));
						scheduleJob.setScheduleResult(scheduler.getTriggerState(packagesTriggerKey).toString());
					} catch (Exception e) {
						scheduleJob.setScheduleResult("Wait");
					}
				} else if(scheduleJob.getScheduleName().equals("employee") && scheduleJob.getScheduleState().equals("사용")) {
					try {
						scheduleJob.setScheduleStartTime(fromatterDate(employeeTrigger.getStartTime()));
						scheduleJob.setScheduleNextTime(fromatterDate(employeeTrigger.getNextFireTime()));
						scheduleJob.setScheduleLastTime(fromatterDate(employeeTrigger.getPreviousFireTime()));
						scheduleJob.setScheduleResult(scheduler.getTriggerState(employeeTriggerKey).toString());
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
				if(scheduleJob.getScheduleName() == "packages" || scheduleJob.getScheduleName().equals("packages")) {
					scheduler.resumeJob(packagesJobKey);
				} else if(scheduleJob.getScheduleName() == "employee" || scheduleJob.getScheduleName().equals("employee")) {
					scheduler.resumeJob(employeeJobKey);
				}
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
				if(scheduleJob.getScheduleName() == "packages" || scheduleJob.getScheduleName().equals("packages")) {
					scheduler.pauseJob(packagesJobKey);
				} else if(scheduleJob.getScheduleName() == "employee" || scheduleJob.getScheduleName().equals("employee")) {
					scheduler.pauseJob(employeeJobKey);
				}
				scheduleJobDao.setScheduleStateNotUse(scheduleJob.getScheduleName());
			}
		} catch (SchedulerException e) {
			return "FALSE";
		}
		return "OK";
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
	       		}
	       	}
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}
	
	private String fromatterDate(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(date);
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
	       		}
	       	}
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

	public String scheduleRun(String scheduleName) {
		getScheduleKey();
		Scheduler scheduler = schedulerFactory.getScheduler();
		try {
			if(scheduleName.equals("EMPLOYEE")) {
				scheduler.triggerJob(employeeJobKey);
			} else if(scheduleName.equals("PACKAGES")) {
				scheduler.triggerJob(packagesJobKey);
			}
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
		TriggerKey triggerKey = null;
		JobKey jobKey = null;
		try {
			if(scheduleName.equals("packages")) {
				triggerKey = packagesTriggerKey;
				jobKey = packagesJobKey;
			} else if(scheduleName.equals("employee")) {
				triggerKey = employeeTriggerKey;
				jobKey = employeeJobKey;
			}
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
	
}
