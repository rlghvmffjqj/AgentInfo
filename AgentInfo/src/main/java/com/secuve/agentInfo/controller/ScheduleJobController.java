package com.secuve.agentInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.schedule.PackagesSchedule;
import com.secuve.agentInfo.service.ScheduleJobService;
import com.secuve.agentInfo.vo.ScheduleJob;

@Controller
public class ScheduleJobController {
	@Autowired ScheduleJobService scheduleJobService;
	
	/**
	 * 스케줄러 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/schedule/list")
	public String ScheduleJobList(Model model) {
		
		return "/schedule/ScheduleJobList";
	}
	
	/**
	 * 스케줄러 데이터 조회
	 * @param search
	 * @return
	 * @throws SchedulerException
	 */
	@ResponseBody
	@PostMapping(value = "/schedule")
	public Map<String, Object> ScheduleJob(ScheduleJob search) throws SchedulerException {
		Map<String, Object> map = new HashMap<String, Object>();
		ArrayList<ScheduleJob> list = new ArrayList<>(scheduleJobService.getScheduleJobList(search));

		int totalCount = scheduleJobService.getScheduleJobListCount();
		map.put("page", search.getPage());
		map.put("total", Math.ceil((float) totalCount / search.getRows()));
		map.put("records", totalCount);
		map.put("rows", list);
		return map;
	}
	
	/**
	 * 스케줄러 사용안함
	 * @param chkList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/schedule/scheduleNotUse")
	public String ScheduleNotUse(@RequestParam int[] chkList) {
		return scheduleJobService.scheduleNotUse(chkList);
	}
	
	/**
	 * 스케줄러 사용
	 * @param chkList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/schedule/scheduleUse")
	public String ScheduleUse(@RequestParam int[] chkList) {
		return scheduleJobService.schedulerUse(chkList);
	}
	
	/**
	 * 스케줄러 즉시 실행
	 * @param scheduleName
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/schedule/scheduleRun")
	public String ScheduleRun(@RequestParam String scheduleName) {
		return scheduleJobService.scheduleRun(scheduleName);
	}
	
	/**
	 * 스케줄러 수정 Modal
	 * @param model
	 * @param scheduleName
	 * @return
	 */
	@PostMapping(value = "/schedule/updateView")
	public String UpdateScheduleView(Model model, @RequestParam String scheduleName) {
		ScheduleJob scheduleJob = scheduleJobService.getScheduleOne(scheduleName);
		model.addAttribute("viewType","update").addAttribute("scheduleJob", scheduleJob);
		return "/schedule/ScheduleJobView";
	}
	
	/**
	 * 스케줄러 수정
	 * @param scheduleName
	 * @param scheduleState
	 * @param scheduleCron
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping(value = "/schedule/update")
	public String UpdateSchedule(@RequestParam String scheduleName, String scheduleState, String scheduleCron) throws Exception {
		return scheduleJobService.updateSchedule(scheduleName, scheduleState, scheduleCron);
	}
	
}
