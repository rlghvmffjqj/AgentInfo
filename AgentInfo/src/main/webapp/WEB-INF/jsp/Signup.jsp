<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<script>
		// ajax _csrf 전송
		/* $(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		}); */
	</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="form" name="form" method ="post"> 
	<input type="text" id="usersId" name="usersId">
	<input type="text" id="usersPw" name="usersPw">
	<button onClick="signup()">회원가입</button>
	</form>
</body>

<script>
	function signup() {
		alert("접근");
		var postData = $('#form').serializeArray();
		console.log(postData);
		alert("확인 전");
		$.ajax({
			url: "<c:url value='/signup'/>",
			method : 'POST',
			dataType:'json',
			data: postData,
		    success: function (data) {
		        alert(data);
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
	}
</script>
</html>