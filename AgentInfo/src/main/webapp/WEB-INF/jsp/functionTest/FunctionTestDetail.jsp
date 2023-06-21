<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>체크리스트 테스트 방법</title>
		
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	</head>
	<body style="background: white; padding: 2%;">
		<c:if test="${functionTestSettingDetail.functionTestSettingDetailMethod eq null}">
			<div class='noneDetail'>테스트 방법이 작성 되지 않았습니다.</div>
		</c:if>
		<c:if test="${functionTestSettingDetail.functionTestSettingDetailMethod ne ''}">
			<div>${functionTestSettingDetail.functionTestSettingDetailMethod}</div>
		</c:if>
		<div class='detailSaveDiv'><button class="btn btn-outline-info-add myBtn" onClick="btnClose();">닫기</button></div>
	</body>
	
	<script>
		function btnClose() {
			window.close();
		}
	</script>
	<style>
		.detailSaveDiv {
			width: 100%;
		    text-align: center;
		    padding-top: 10px;
		    padding-top: 5%;
		}
		
		.noneDetail {
			width: 100%;
		    text-align: center;
		    height: 200px;
		    padding-top: 100px;
		    font-size: 18px;
		    font-weight: 700;
		}
	</style>
	
	

</html>