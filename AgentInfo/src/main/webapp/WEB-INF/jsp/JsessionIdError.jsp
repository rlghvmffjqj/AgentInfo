<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<title>JSESSIONID 재사용 탐지 확인</title>
</head>
<body>
<div class="error-404">
    <div class="container-fluid">
        <div class="row" style="text-align: center; display: inline; ">
            <div class="text-uppercase col-xs-12">
                <h1>JSESSIONID 재사용 탐지가 확인되었습니다.</h1>
                <br><br><br><br><br>
                <h5>Error</h5>
                <p>oops! JSESSIONID Detection Error.</p>
                <p>JESSIONID 탈취 및 재사용은 범죄 입니다. 정상적인 방법으로 로그인 바랍니다.</p>
                <br><br><br>
                <!-- <a href="/AgentInfo/login" class="btn btn-error btn-lg waves-effect">back to home page</a> -->
            </div>
        </div>
    </div>
</div>
</body>
<style>
    .container-fluid {
        width: 90%;
        background: burlywood;
        height: 450px;
        margin-top: 100px;
        padding-top: 80px;
    }

    body {
        background: none !important;
    }

    h5 {
        color: red;
    }
</style>
</html>