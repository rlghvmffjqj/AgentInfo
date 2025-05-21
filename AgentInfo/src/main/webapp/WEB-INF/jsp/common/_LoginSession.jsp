<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="sessionTimeOut" expression="@environment.getProperty('sessionTimeOut')" />

<script>
	var loginSession = "${sessionTimeOut}";
	var sessionCheckInterval = 3 * 60 * 1000;  // 3분 간격으로 체크 (밀리초)
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

		if (!expirationTime) {
	    	const currentTime = Date.now();  // 현재 시간
			const newExpirationTime = currentTime + loginSession * 60 * 1000;
	    	localStorage.setItem(localStorageKey, newExpirationTime);
		}
	}

	// 세션 상태 확인 함수
	function checkSessionTimeout() {
		const expirationTime = Number(localStorage.getItem(localStorageKey));  // 문자열을 숫자로 변환
		const currentTime = Date.now();  // 현재 시간
		let lastTime = "0";
		
		// 서버에서 최근 사용자 활동 시간 받아오기
		$.ajax({
			type: 'POST',
			url: "<c:url value='/users/lastTime'/>",
			traditional: true,
			async: false,
			success: function (data) {
				lastTime = data;
			},
			error: function (e) {
				console.error("lastTime 요청 실패", e);
			}
		});
	
		if (!lastTime || lastTime === "0") {
			console.warn("lastTime 값이 비어 있거나 잘못되었습니다.");
			return;
		}
	
		const isoDateString = lastTime.replace(" ", "T");
		const targetTime = new Date(isoDateString).getTime();
	
		// 1. 세션이 기본 1시간을 초과한 경우에만 판단
		if (currentTime > expirationTime) {
			const elapsedSinceLastTime = currentTime - targetTime;
		
			// 2. lastTime 기준으로 10분 이상 아무 활동이 없으면 로그아웃
			if (elapsedSinceLastTime >= 10 * 60 * 1000) {
				sessionExpiration();
			}
		} else {
			// 3. 아직 기본 세션 시간이 안 지났고, 만료까지 1분 이하라면 연장 여부 묻기
			if (expirationTime - currentTime <= warningTime) {
				showSessionExtensionNotification();
			}
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
