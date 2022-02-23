package com.secuve.agentInfo.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.secuve.agentInfo.vo.Users;

public interface UsersJpaDao extends JpaRepository<Users, String>{
	Optional<Users> findByUsersId(String usersId);
}
