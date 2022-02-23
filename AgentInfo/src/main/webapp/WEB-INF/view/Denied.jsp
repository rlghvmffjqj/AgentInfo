<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<%@ include file="/WEB-INF/view/common/_Head.jsp"%>
<title>denied</title>
</head>
<body>

<div class="error-404">
    <!-- Container-fluid starts -->
    <div class="container-fluid">
        <!-- Row start -->
        <div class="row">
            <div class="text-uppercase col-xs-12">
                <h1>접근 거부</h1>
                <h5>No Access</h5>
                <p>oops! No Access</p>
                <a href="/AgentInfo/login" class="btn btn-error btn-lg waves-effect">back to home page</a>
            </div>
        </div>
        <!-- Row end -->
    </div>
    <!-- Container-fluid ends -->
</div>

</body>
</html>