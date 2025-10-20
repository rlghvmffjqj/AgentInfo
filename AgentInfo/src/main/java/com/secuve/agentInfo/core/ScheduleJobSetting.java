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

import com.secuve.agentInfo.schedule.EmployeeDeleteSchedule;
import com.secuve.agentInfo.schedule.EmployeeSchedule;
import com.secuve.agentInfo.schedule.License5PeriodSchedule;
import com.secuve.agentInfo.schedule.License5Schedule;
import com.secuve.agentInfo.schedule.PackagesDeleteSchedule;
import com.secuve.agentInfo.schedule.PackagesSchedule;
import com.secuve.agentInfo.schedule.SendPackageDeleteSchedule;
import com.secuve.agentInfo.schedule.SendPackageExpirationSchedule;
import com.secuve.agentInfo.schedule.ServerListDeleteSchedule;
import com.secuve.agentInfo.schedule.ServerListSchedule;
import com.secuve.agentInfo.schedule.ServiceControlSchedule;
import com.secuve.agentInfo.service.ScheduleJobService;
import com.secuve.agentInfo.vo.ScheduleJob;

@Configuration
public class ScheduleJobSetting {
	@Autowired private Scheduler scheduler;
	@Autowired ScheduleJobService scheduleJobService;
	@Autowired PackagesSchedule packagesSchedule;
	@Autowired EmployeeSchedule employeeSchedule;
	@Autowired ServerListSchedule serverListSchedule;
	@Autowired PackagesDeleteSchedule packagesDeleteSchedule;
	@Autowired EmployeeDeleteSchedule employeeDeleteSchedule;
	@Autowired ServerListDeleteSchedule serverListDeleteSchedule;
	@Autowired SendPackageDeleteSchedule sendPackageDeleteSchedule;
	@Autowired SendPackageExpirationSchedule sendPackageExpirationSchedule;

    @PostConstruct
    public void start() throws SchedulerException {
    	JobDataMap map1 = new JobDataMap(Collections.singletonMap("num", 1));
        JobDataMap map2 = new JobDataMap(Collections.singletonMap("num", 2));
        JobDataMap map3 = new JobDataMap(Collections.singletonMap("num", 3));
        JobDataMap map4 = new JobDataMap(Collections.singletonMap("num", 4));
        JobDataMap map5 = new JobDataMap(Collections.singletonMap("num", 5));
        JobDataMap map6 = new JobDataMap(Collections.singletonMap("num", 6));
        JobDataMap map7 = new JobDataMap(Collections.singletonMap("num", 7));
        JobDataMap map8 = new JobDataMap(Collections.singletonMap("num", 8));
        JobDataMap map9 = new JobDataMap(Collections.singletonMap("num", 9));
        JobDataMap map10 = new JobDataMap(Collections.singletonMap("num", 10));
        JobDataMap map11 = new JobDataMap(Collections.singletonMap("num", 11));

        ScheduleJob packagesSchedule = scheduleJobService.getScheduleOne("packages");
        JobDetail packages = jobDetail(packagesSchedule.getScheduleName(), "DEFAULT", PackagesSchedule.class, map1);
        scheduler.scheduleJob(packages, trigger(packagesSchedule.getScheduleName(), "DEFAULT", packagesSchedule.getScheduleCron()));
        
        ScheduleJob employeeSchedule = scheduleJobService.getScheduleOne("employee");
        JobDetail employee = jobDetail(employeeSchedule.getScheduleName(), "DEFAULT", EmployeeSchedule.class, map2);
       	scheduler.scheduleJob(employee, trigger(employeeSchedule.getScheduleName(), "DEFAULT", employeeSchedule.getScheduleCron()));
       	
       	ScheduleJob serverListSchedule = scheduleJobService.getScheduleOne("serverList");
        JobDetail serverList = jobDetail(serverListSchedule.getScheduleName(), "DEFAULT", ServerListSchedule.class, map3);
       	scheduler.scheduleJob(serverList, trigger(serverListSchedule.getScheduleName(), "DEFAULT", serverListSchedule.getScheduleCron()));
       	
       	ScheduleJob packagesDeleteSchedule = scheduleJobService.getScheduleOne("packagesDelete");
        JobDetail packagesDelete = jobDetail(packagesDeleteSchedule.getScheduleName(), "DEFAULT", PackagesDeleteSchedule.class, map6);
        scheduler.scheduleJob(packagesDelete, trigger(packagesDeleteSchedule.getScheduleName(), "DEFAULT", packagesDeleteSchedule.getScheduleCron()));
        
        ScheduleJob employeeDeleteSchedule = scheduleJobService.getScheduleOne("employeeDelete");
        JobDetail employeeDelete = jobDetail(employeeDeleteSchedule.getScheduleName(), "DEFAULT", EmployeeDeleteSchedule.class, map7);
       	scheduler.scheduleJob(employeeDelete, trigger(employeeDeleteSchedule.getScheduleName(), "DEFAULT", employeeDeleteSchedule.getScheduleCron()));
       	
       	ScheduleJob serverListDeleteSchedule = scheduleJobService.getScheduleOne("serverListDelete");
        JobDetail serverListDelete = jobDetail(serverListDeleteSchedule.getScheduleName(), "DEFAULT", ServerListDeleteSchedule.class, map8);
       	scheduler.scheduleJob(serverListDelete, trigger(serverListDeleteSchedule.getScheduleName(), "DEFAULT", serverListDeleteSchedule.getScheduleCron()));
       	
       	ScheduleJob sendpackageDeleteSchedule = scheduleJobService.getScheduleOne("sendpackageDelete");
        JobDetail sendpackageDelete = jobDetail(sendpackageDeleteSchedule.getScheduleName(), "DEFAULT", SendPackageDeleteSchedule.class, map4);
       	scheduler.scheduleJob(sendpackageDelete, trigger(sendpackageDeleteSchedule.getScheduleName(), "DEFAULT", sendpackageDeleteSchedule.getScheduleCron()));
       	
       	ScheduleJob sendPackageExpirationSchedule = scheduleJobService.getScheduleOne("sendPackageExpiration");
        JobDetail sendPackageExpiration = jobDetail(sendPackageExpirationSchedule.getScheduleName(), "DEFAULT", SendPackageExpirationSchedule.class, map5);
       	scheduler.scheduleJob(sendPackageExpiration, trigger(sendPackageExpirationSchedule.getScheduleName(), "DEFAULT", sendPackageExpirationSchedule.getScheduleCron()));
       	
       	ScheduleJob serviceControlSchedule = scheduleJobService.getScheduleOne("serviceControl");
        JobDetail serviceControl = jobDetail(serviceControlSchedule.getScheduleName(), "DEFAULT", ServiceControlSchedule.class, map9);
       	scheduler.scheduleJob(serviceControl, trigger(serviceControlSchedule.getScheduleName(), "DEFAULT", serviceControlSchedule.getScheduleCron()));
       	
       	ScheduleJob license5Schedule = scheduleJobService.getScheduleOne("license5");
        JobDetail license5 = jobDetail(license5Schedule.getScheduleName(), "DEFAULT", License5Schedule.class, map10);
       	scheduler.scheduleJob(license5, trigger(license5Schedule.getScheduleName(), "DEFAULT", license5Schedule.getScheduleCron()));
       	
       	ScheduleJob license5PeriodSchedule = scheduleJobService.getScheduleOne("license5Period");
        JobDetail license5Period = jobDetail(license5PeriodSchedule.getScheduleName(), "DEFAULT", License5PeriodSchedule.class, map11);
       	scheduler.scheduleJob(license5Period, trigger(license5PeriodSchedule.getScheduleName(), "DEFAULT", license5PeriodSchedule.getScheduleCron()));
       	
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
       		} else if(key.toString().equals("DEFAULT.serverList")) {
	            if(serverListSchedule.getScheduleState() == "사용안함" || serverListSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.packagesDelete")) {
	       		if(packagesDeleteSchedule.getScheduleState() == "사용안함" || packagesDeleteSchedule.getScheduleState().equals("사용안함")) {
	       			scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.employeeDelete")) {
	            if(employeeDeleteSchedule.getScheduleState() == "사용안함" || employeeDeleteSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.serverListDelete")) {
	            if(serverListDeleteSchedule.getScheduleState() == "사용안함" || serverListDeleteSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.sendpackageDelete")) {
	            if(sendpackageDeleteSchedule.getScheduleState() == "사용안함" || sendpackageDeleteSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.sendPackageExpiration")) {
	            if(sendPackageExpirationSchedule.getScheduleState() == "사용안함" || sendPackageExpirationSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.serviceControl")) {
	            if(serviceControlSchedule.getScheduleState() == "사용안함" || serviceControlSchedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.license5")) {
	            if(license5Schedule.getScheduleState() == "사용안함" || license5Schedule.getScheduleState().equals("사용안함")) {
	            	scheduler.pauseJob(key);
	            }
       		} else if(key.toString().equals("DEFAULT.license5Period")) {
	            if(license5PeriodSchedule.getScheduleState() == "사용안함" || license5PeriodSchedule.getScheduleState().equals("사용안함")) {
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
