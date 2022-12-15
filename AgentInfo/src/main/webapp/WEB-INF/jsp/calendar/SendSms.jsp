<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <h1>텍스트 메일 보내기</h1>
 
    <form id="smsForm" name="form" method ="post"> 
        <table>
            <tr class="form-group">
                <td>발송할 전화번호</td>
                <td>
                    <input type="text" class="form-control" name="to" placeholder="이메일 주소를 입력하세요">
                </td>
            </tr>
            <tr class="form-group">        
                <td>내용</td>
                <td>
                    <textarea class="form-control" name="content" placeholder="보낼 내용을 입력하세요"> </textarea>
                </td>
            </tr>
        </table>
        <input type="button" class="btn btn-default" id="smsClick" value="발송">
    </form>
</body>

<script>
$('#smsClick').click(function(e) {
	var postData = $('#smsForm').serializeObject();
	$.ajax({
		url: "<c:url value='/mail/send'/>",
		type: 'post',
		//data : postData,
		async: false,
		success : function(result) {
			console.log(result);
		},
			error: function(error) {
			console.log(error);
		}
	});
});
</script>
</html>