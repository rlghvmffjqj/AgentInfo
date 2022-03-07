package com.secuve.agentInfo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@MapperScan(basePackageClasses = AgentInfoApplication.class)
@SpringBootApplication
public class AgentInfoApplication extends SpringBootServletInitializer {
	
	public static void main(String[] args) {
		SpringApplication.run(AgentInfoApplication.class, args);
	}
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(AgentInfoApplication.class);
	}

	

}
