package com.secuve.agentInfo.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.secuve.agentInfo.vo.License5File;

public interface License5FileJpaDao extends JpaRepository<License5File, Long>{

	License5File findBySerialNumber(String serialNumber);

}
