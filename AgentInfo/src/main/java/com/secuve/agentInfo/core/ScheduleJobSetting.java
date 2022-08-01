package com.secuve.agentInfo.core;

import java.util.Collections;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import com.secuve.agentInfo.schedule.EmployeeSchedule;
import com.secuve.agentInfo.schedule.PackagesSchedule;
import com.secuve.agentInfo.service.ScheduleJobService;
import com.secuve.agentInfo.vo.ScheduleJob;

@Configuration
public class ScheduleJobSetting {
	@Autowired private Scheduler scheduler;
	@Autowired ScheduleJobService scheduleJobService;
	@Autowired PackagesSchedule packagesSchedule;
	@Autowired EmployeeSchedule employeeSchedule;

    @PostConstruct
    public void start() throws SchedulerException {
    	JobDataMap map1 = new JobDataMap(Collections.singletonMap("num", 1));
        JobDataMap map2 = new JobDataMap(Collections.singletonMap("num", 2));

        ScheduleJob packagesSchedule = scheduleJobService.getScheduleOne("packages");
        JobDetail packages = jobDetail(packagesSchedule.getScheduleName(), "DEFAULT", PackagesSchedule.class, map1);
        scheduler.scheduleJob(packages, trigger(packagesSchedule.getScheduleName(), "DEFAULT", packagesSchedule.getScheduleCron()));
        
        ScheduleJob employeeSchedule = scheduleJobService.getScheduleOne("employee");
        JobDetail employee = jobDetail(employeeSchedule.getScheduleName(), "DEFAULT", EmployeeSchedule.class, map2);
       	scheduler.scheduleJob(employee, trigger(employeeSchedule.getScheduleName(), "DEFAULT", employeeSchedule.getScheduleCron()));
       	
       	Set<JobKey> jobkey = scheduler.getJobKeys(null);
       	for(JobKey key: jobkey) {
       		if(key.toString().equals("DEFAULT.packages")) {
	       		if(packagesSchedule.getScheduleState() == "사용안함" || packagesSchedule.getScheduleState().equals("사용안함")) {
	       			scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.employee")) {
	            if(employeeSchedule.getScheduleState() == "사용안함" || employeeSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		}
       	}
    }
    
    public JobDetail jobDetail(String name, String group, Class jobClass, JobDataMap dataMap) {
        JobDetail job = JobBuilder.newJob(jobClass)
                .withIdentity(name, group)
                .usingJobData(dataMap)
                .build();
        return job;
    }
    
    public Trigger trigger(String name, String group, String scheduleExp) {
    	Trigger trigger = TriggerBuilder.newTrigger()
                .withIdentity(name, group)
                .withSchedule(CronScheduleBuilder.cronSchedule(scheduleExp))
                .build();
        return trigger;
    }

}
