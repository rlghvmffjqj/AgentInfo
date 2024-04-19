package com.secuve.agentInfo.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.engine.jdbc.internal.BasicFormatterImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.secuve.agentInfo.vo.SqlExecution;

@Controller
public class SqlExecutionController {
	
	@GetMapping(value = "/sqlExecution/write")
	public String SqlExecutionWrite() {
		return "sqlExecution/SqlExecution";
	}
	
	@ResponseBody
	@PostMapping(value = "/sqlExecution/excute", produces = "text/plain")
	public String Excute(SqlExecution sqlExecution) {
		StringBuilder resultBuilder = new StringBuilder();
		int count = 0;
		try {
			String url = "";
			if(sqlExecution.getSqlType().equals("tibero")) {
				Class.forName("com.tmax.tibero.jdbc.TbDriver");
				url = "jdbc:tibero:thin:@" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ":" + sqlExecution.getSqlSid();
			} else if(sqlExecution.getSqlType().equals("mysql")) {
				Class.forName("com.mysql.jdbc.Driver");
				url = "jdbc:mysql://" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + "/" + sqlExecution.getSqlSid();
			} else if(sqlExecution.getSqlType().equals("oracle")) {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				url = "jdbc:oracle:thin:@" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ":" + sqlExecution.getSqlSid();
				sqlExecution.setSqlQuery(sqlExecution.getSqlQuery().replaceAll(";", ""));
			} else if(sqlExecution.getSqlType().equals("mariadb")) {
				Class.forName("org.mariadb.jdbc.Driver");
				url = "jdbc:mariadb://" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + "/" + sqlExecution.getSqlSid();
			} else if(sqlExecution.getSqlType().equals("mssql")) {
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				url = "jdbc:sqlserver://" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ";DatabaseName=" + sqlExecution.getSqlSid();
			}
			DriverManager.setLoginTimeout(3);
            Connection conn = DriverManager.getConnection(url, sqlExecution.getSqlUser(), sqlExecution.getSqlPasswd());

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sqlExecution.getSqlQuery());
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();

            // 테이블 헤더 추가
            resultBuilder.append("<table><tr>");
            for (int i = 1; i <= columnCount; i++) {
            	resultBuilder.append("<th class='resultTh'>").append(rsmd.getColumnLabel(i)).append("</th>");
            }
            resultBuilder.append("</tr>");

            // 결과 행 추가
            while (rs.next() && count < 200) {
            	resultBuilder.append("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                	resultBuilder.append("<td class='resultTd'>").append(rs.getString(i)).append("</td>");
                }
                resultBuilder.append("</tr>");
            	count++;
            }

            // 테이블 종료
            resultBuilder.append("</table>");
            conn.close();
		 } catch (SQLException e) {
		     // SQL 에러 처리
		     //e.printStackTrace();
			 resultBuilder.append("<div class='errorDiv'>");
			 resultBuilder.append("<span class='errorSpan'>");
			 resultBuilder.append("SQL Error: " + e.getMessage());
			 resultBuilder.append("</span>");
			 resultBuilder.append("</div>");
		 } catch (Exception e) {
		     // 기타 에러 처리
		     //e.printStackTrace();
			 resultBuilder.append("<div class='errorDiv'>");
			 resultBuilder.append("<span class='errorSpan'>");
			 resultBuilder.append("Error executing SQL: " + e.getMessage());
			 resultBuilder.append("</span>");
			 resultBuilder.append("</div>");
		 }
		 return resultBuilder.toString();
	}
	
	@ResponseBody
	@PostMapping(value = "/sqlExecution/connect")
	public String Connect(SqlExecution sqlExecution) {
				ExecutorService executor = Executors.newSingleThreadExecutor();
        Future<String> future = executor.submit(() -> {
        	String url = "";
    		if(sqlExecution.getSqlType().equals("tibero")) {
    			url = "jdbc:tibero:thin:@" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ":" + sqlExecution.getSqlSid();
    		} else if(sqlExecution.getSqlType().equals("mysql")) {
    			url = "jdbc:mysql://" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + "/" + sqlExecution.getSqlSid();
    		} else if(sqlExecution.getSqlType().equals("oracle")) {
    			url = "jdbc:oracle:thin:@" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ":" + sqlExecution.getSqlSid();
    			sqlExecution.setSqlQuery(sqlExecution.getSqlQuery().replaceAll(";", ""));
    		} else if(sqlExecution.getSqlType().equals("mariadb")) {
    			url = "jdbc:mariadb://" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + "/" + sqlExecution.getSqlSid();
    		} else if(sqlExecution.getSqlType().equals("mssql")) {
    			url = "jdbc:sqlserver://" + sqlExecution.getSqlIp() + ":" + sqlExecution.getSqlPort() + ";DatabaseName=" + sqlExecution.getSqlSid();
    		}

            try {
                // DB 접속 시도
                Connection connection = DriverManager.getConnection(url, sqlExecution.getSqlUser(), sqlExecution.getSqlPasswd());
                connection.close(); // 연결 종료
                return "OK"; // 접속 성공 시 OK 반환
            } catch (SQLException e) {
                //e.printStackTrace();
                return "FALSE"; // 접속 실패 시 FALSE 반환
            }
        });

        try {
            // 2초 안에 응답이 오지 않으면 작업 종료
        	return future.get(2, TimeUnit.SECONDS);
        } catch (Exception e) {
            //e.printStackTrace();
            return "FALSE"; // 예외 발생 시 FALSE 반환
        } finally {
            executor.shutdown(); // 작업 종료
        }
	}
	
	@ResponseBody
	@PostMapping(value = "/sqlExecution/format")
	public String Format(String sqlQuery) {
		if(!sqlQuery.contains("Parameters")) {
			return "FALSE";
		}
		String[] sqlQueryArr = sqlQuery.split("\n");
		List<Object> parametersArr = extractParameters(sqlQueryArr[1]);
		for (Object parameter : parametersArr) {
			if (parameter instanceof String) {
		        sqlQueryArr[0] = sqlQueryArr[0].replaceFirst("\\?", "'" + parameter + "'");
		    } else if (parameter instanceof Integer) {
		        sqlQueryArr[0] = sqlQueryArr[0].replaceFirst("\\?", parameter.toString());
		    }
        }
		//return SqlFormatter.format(sqlQueryArr[0]);
		return new BasicFormatterImpl().format(sqlQueryArr[0]);
	}
	
	public static List<Object> extractParameters(String logEntry) {
        List<Object> parameters = new ArrayList<>();

        // "Parameters:" 이후의 문자열을 찾기 위한 정규 표현식 패턴
        Pattern pattern = Pattern.compile("Parameters: (.+)");
        Matcher matcher = pattern.matcher(logEntry);

        if (matcher.find()) {
            // 캡쳐된 그룹에서 파라미터 문자열을 가져옴
            String paramsString = matcher.group(1);
            // 파라미터를 쉼표로 분리하여 배열로 변환
            String[] rawParams = paramsString.split(",\\s*");

            for (String rawParam : rawParams) {
                // 각 파라미터에서 값을 추출 (타입 정보 포함)
                String[] parts = rawParam.split("\\(");
                String value = parts[0].trim();
                String type = parts[1].replace(")", "").trim();

                // 타입에 따라 적절한 처리를 함
                switch (type) {
                    case "Integer":
                        parameters.add(Integer.parseInt(value));
                        break;
                    case "String":
                        parameters.add(value);
                        break;
                    default:
                        throw new IllegalArgumentException("Unsupported parameter type: " + type);
                }
            }
        }

        return parameters;
    }
	
}
