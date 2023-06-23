package com.secuve.agentInfo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.secuve.agentInfo.service.TestCaseCategoryService;

@Controller
public class TestCaseCategoryController {
	@Autowired TestCaseCategoryService testCaseCategoryService;

}
