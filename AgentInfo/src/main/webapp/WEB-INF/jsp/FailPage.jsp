<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	<script>
		$(function() {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '아이디 또는 패스워드가 일치하지 않습니다.',    
			});	
		})
	</script>
</head>
<body>
	실패
</body>
</html>