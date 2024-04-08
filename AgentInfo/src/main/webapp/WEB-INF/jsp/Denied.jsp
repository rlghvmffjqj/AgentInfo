<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<title>접근 거부</title>
</head>
<body>
<div class="error-404">
    <div class="container-fluid">
        <div class="row" style="text-align: center; display: inline;">
            <div class="text-uppercase col-xs-12">
                <h1>접근 권한 불충분</h1>
                <br><br><br>
                <h5>No Access</h5>
                <p>oops! No Access</p>
                <p>접근 가능한 권한을 갖추지 못했습니다. 확인 후 접속 바랍니다.</p>
                <br><br><br>
                <a href="/AgentInfo/login" class="btn btn-error btn-lg waves-effect">back to home page</a>
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