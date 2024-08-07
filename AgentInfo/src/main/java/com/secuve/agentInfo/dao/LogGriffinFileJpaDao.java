package com.secuve.agentInfo.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.secuve.agentInfo.vo.LogGriffinFile;

public interface LogGriffinFileJpaDao  extends JpaRepository<LogGriffinFile, Long>{

	LogGriffinFile findBySerialNumber(String serialNumber);

}
