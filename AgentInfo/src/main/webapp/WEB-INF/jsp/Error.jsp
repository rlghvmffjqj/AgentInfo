<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<title>에러 발생</title>
</head>
<body>
<div class="error-404">
    <div class="container-fluid">
        <div class="row" style="text-align: center; display: inline;">
            <div class="text-uppercase col-xs-12">
                <h1>에러 발생</h1>
                <br><br><br>
                <h5>Error</h5>
                <p>oops! An error has occurred.</p>
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