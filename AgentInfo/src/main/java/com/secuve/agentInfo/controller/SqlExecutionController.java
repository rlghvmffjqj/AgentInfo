package com.secuve.agentInfo.controller;

import java.security.Principal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itextpdf.text.log.SysoCounter;
import com.secuve.agentInfo.vo.SqlExecution;

@Controller
public class SqlExecutionController {
	
	@GetMapping(value = "/sqlExecution/write")
	public String SqlExecutionWrite() {
		return "sqlExecution/SqlExecution";
	}
	
	@ResponseBody
	@PostMapping(value = "/sqlExecution/excute", produces = "text/plain")
	public String Excute(Principal principal, SqlExecution sqlExecution) {
		String result = "";
		try {
            // Tibero JDBC 드라이버 로드
            Class.forName("com.tmax.tibero.jdbc.TbDriver");

            // JDBC URL 생성
            String url = "jdbc:tibero:thin:@" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ":tibero6";

            // 데이터베이스에 연결
            Connection conn = DriverManager.getConnection(url, sqlExecution.getSqlUser(), sqlExecution.getSqlPasswd());

            // 쿼리 실행
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sqlExecution.getSqlQuery());

            // 결과 처리
            while (rs.next()) {
            	System.out.println(rs.getString(2));
                // 여기서 결과를 문자열로 추가하거나 처리할 방법을 정의합니다.
                // 여기서는 간단하게 첫 번째 열 값을 가져와 result 문자열에 추가하는 예시를 보여줍니다.
                result += rs.getString(1) + "\n";
            }

            // 연결 종료
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            result = "Error executing SQL: " + e.getMessage();
        }
		return "OK";
	}
}
