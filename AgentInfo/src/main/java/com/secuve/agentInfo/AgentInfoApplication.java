package com.secuve.agentInfo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(basePackageClasses = AgentInfoApplication.class)
@SpringBootApplication
public class AgentInfoApplication {
	
	private static Logger logger = LogManager.getLogger(AgentInfoApplication.class);

	public static void main(String[] args) {
		logger.info("Starting Spring Boot application..");
		SpringApplication.run(AgentInfoApplication.class, args);
	}

}
