<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="sessionTimeOut" expression="@environment.getProperty('sessionTimeOut')" />


<script>
	/* =========== config.yml에 등록한 세션 유효 시간(분) ========= */
	var loginSession = ${sessionTimeOut};
	
	$(function() {
		/* =========== 세션 검사주기 체크 ========= */
		setTimerSessionTimeoutCheck();
	});
	
	/* =========== 세션 검사 주기 ========= */
	function setTimerSessionTimeoutCheck()
	{
		// 검사주기 범위 [1~60]분, 0 이면 세션타임아웃 사용안함.
		if ( loginSession > 0 && loginSession <= 60 ) {
			setTimeout("sessionTimeoutCheck()", 10*60*1000); // 10분에 한번씩 체크
		}
	}
	
	/* =========== 검사주기 시간이 초과할 경우 실행 ========= */
	function sessionTimeoutCheck() {
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
				} else {
					setTimerSessionTimeoutCheck();
				}
			},
			error: function(error) {
				console.log(error);
			}
        });
	}
</script>