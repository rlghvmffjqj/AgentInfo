<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="sessionTimeOut" expression="@environment.getProperty('sessionTimeOut')" />


<script>
	$(function() {
		loginSession = ${sessionTimeOut};
		$.ajax({
			url: "<c:url value='/employee/loginSession'/>",
            type: 'post',
            data: {"loginSession":loginSession},
            async: false,
            success: function(result) {
				if(result == "TimeOut") {
					Swal.fire({
						icon: 'info',
						title: '세션 만료!',
						text: '세션이 만료되어 자동 로그아웃 됩니다.',
					}).then((result) => {
						location.href="<c:url value='/logout' />";
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
        });
	});
</script>