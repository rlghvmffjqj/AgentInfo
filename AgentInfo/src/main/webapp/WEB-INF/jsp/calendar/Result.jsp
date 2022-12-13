<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
  <h2>SMS 내역 조회</h2>        
  <table class="table table-bordered">
    <thead>
      <tr>
        <th>requestId</th>
        <th>요청 시간</th>
        <th>Status Code</th>
        <th>Status Name</th>
      </tr>
    </thead>
    <tbody>
      <tr >
        <td th:text="${response.requestId}"></td>
        <td th:text="${response.requestTime}"></td>
        <td th:text="${response.statusCode}"></td>
        <td th:text="${response.statusName}"></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>