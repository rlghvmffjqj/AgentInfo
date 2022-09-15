package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.secuve.agentInfo.service.ServerListUidLogService;

@Controller
public class ServerListUidLogController {
	@Autowired ServerListUidLogService serverListUidLogService;
}
