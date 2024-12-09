<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="sessionTimeOut" expression="@environment.getProperty('sessionTimeOut')" />

<script>
	var loginSession = "${sessionTimeOut}";
	var sessionCheckInterval = 2 * 60 * 1000;  // 2분 간격으로 체크 (밀리초)
	var warningTime = 1 * 60 * 1000;  // 1분 전 알림 (밀리초)
	var localStorageKey = "sessionExpirationTime";  // 로컬스토리지 키

	$(function () {
	    // 세션 만료 시간 초기화
	    setTimerSessionTimeoutCheck();

	    // 정기적인 세션 상태 확인
	    setInterval(checkSessionTimeout, sessionCheckInterval);
	});

	// 세션 만료 시간 초기화 함수
	function setTimerSessionTimeoutCheck() {
	    const expirationTime = localStorage.getItem(localStorageKey);  // 기존 저장된 세션 만료 시간 가져오기
	    const currentTime = Date.now();  // 현재 시간

	    // 만약 세션 시간이 이미 존재하면, 기존 만료 시간을 그대로 두고, 10분 연장
	    if (expirationTime) {
	        const remainingTime = expirationTime - currentTime;  // 남은 시간 계산
	        let newExpirationTime = currentTime + remainingTime;  // 남은 시간 그대로 유지

	        // 만약 남은 시간이 10분 이하라면 10분으로 설정
        	if (remainingTime <= 10 * 60 * 1000) {
        	    newExpirationTime = currentTime + 10 * 60 * 1000;  // 10분으로 변경
        	}

	        localStorage.setItem(localStorageKey, newExpirationTime);
	    } else {
	        // 최초 로그인 시 세션 만료 시간을 설정 (60분 후)
	        const newExpirationTime = currentTime + loginSession * 60 * 1000;
	        localStorage.setItem(localStorageKey, newExpirationTime);
	    }
	}

	// 세션 상태 확인 함수
	function checkSessionTimeout() {
	    const expirationTime = localStorage.getItem(localStorageKey);  // 저장된 만료 시간
	    const currentTime = Date.now();  // 현재 시간

	    // 세션 만료 확인
	    if (expirationTime && currentTime > expirationTime) {
	        sessionExpiration();  // 세션 만료 시 로그아웃 처리
	    } else if (expirationTime && expirationTime - currentTime <= warningTime) {
	        // 세션 만료 1분 전
	        showSessionExtensionNotification();  // 세션 연장 알림
	    }
	}

	// 세션 만료 처리
	function sessionExpiration() {
		localStorage.removeItem(localStorageKey);  // 로컬 스토리지에서 세션 만료 시간 삭제
    	sessionStorage.clear();  // 세션 스토리지에서 모든 데이터 삭제 (필요한 경우)
	    location.href="<c:url value='/users/logout' />";
	}

	// 세션 연장 알림
	function showSessionExtensionNotification() {
	    Swal.fire({
	        icon: "info",
	        title: "세션 만료!",
	        text: "기한을 연장하시겠습니까? (10분)",
	        confirmButtonColor: "#D8D800",
	        confirmButtonText: "연장",
	    }).then((result) => {
	        if (result.isConfirmed) {
	            extendSession();  // 세션 연장
	        }
	    });
	}

	// 세션 연장
	function extendSession() {
	    const expirationTime = localStorage.getItem(localStorageKey);  // 기존 만료 시간 가져오기
	    const currentTime = Date.now();  // 현재 시간

	    // 기존 만료 시간이 있다면 그 값을 기반으로 연장
	    if (expirationTime) {
	        const remainingTime = expirationTime - currentTime;  // 남은 시간 계산
	        let newExpirationTime = currentTime + remainingTime;  // 기존 남은 시간 그대로 두고 10분 추가

	        // 10분 연장
	        newExpirationTime += 10 * 60 * 1000;  // 10분 추가
	        localStorage.setItem(localStorageKey, newExpirationTime);  // 로컬스토리지에 저장
	    }
	}

</script>
