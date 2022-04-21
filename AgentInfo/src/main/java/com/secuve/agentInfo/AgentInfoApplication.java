package com.secuve.agentInfo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@MapperScan(basePackageClasses = AgentInfoApplication.class)
@SpringBootApplication
public class AgentInfoApplication extends SpringBootServletInitializer {
	private static final Logger LOGGER = LogManager.getLogger(AgentInfoApplication.class);
	
	public static void main(String[] args) {
		SpringApplication.run(AgentInfoApplication.class, args);
		
		LOGGER.info("Spring boot Start...");
	}
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(AgentInfoApplication.class);
	}
}
