<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>기능 테스트 방법</title>
		
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	</head>
	<body style="background: white">
		<c:if test="${functionTestSettingDetail.functionTestSettingDetailMethod eq null && functionTestSettingDetail.functionTestSettingDetailProcedure eq null && functionTestSettingDetail.functionTestSettingDetailExpectation eq null}">
			<div class='noneDetail'>테스트 방법이 작성 되지 않았습니다.</div>
		</c:if>


		<c:if test="${functionTestSettingDetail.functionTestSettingDetailProcedure ne '' && functionTestSettingDetail.functionTestSettingDetailProcedure ne null}">
			<div class="functionSpanDiv">
				<span class="functionSpan">- 사전 테스트 준비 -</span>
			</div>
			<textarea class="textNoteSize" disabled>${functionTestSettingDetail.functionTestSettingDetailProcedure}</textarea>
		</c:if>
		<c:if test="${functionTestSettingDetail.functionTestSettingDetailMethod ne null}">
			<div class="functionSpanDiv">
				<span class="functionSpan">- 테스트 절차 -</span>
			</div>
			<div class="functionTextareaDiv">${functionTestSettingDetail.functionTestSettingDetailMethod}</div>
		</c:if>
		<c:if test="${functionTestSettingDetail.functionTestSettingDetailExpectation ne null}">
			<div class="functionSpanDiv">
				<span class="functionSpan">- 예상 테스트 결과 -</span>
			</div>
			<div class="functionTextareaDiv">${functionTestSettingDetail.functionTestSettingDetailExpectation}</div>
		</c:if>
		<div class="functionSpanDiv"></div>
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
			background-color: white;
		}
		
		.noneDetail {
			width: 100%;
		    text-align: center;
		    height: 200px;
		    padding-top: 100px;
		    font-size: 18px;
		    font-weight: 700;
			background-color: white;
		}

		img {
			border: 1px solid black !important;
		}

		p {
			color: black !important;
		}

		.detailSaveDiv {
			width: 100%;
		    text-align: center;
		    padding-top: 10px;
			padding-bottom: 30px;
		}

		.functionSpanDiv {
			padding: 15px;
			background: white;
		}

		.functionSpan {
			font-size: 15px;
    		font-weight: bold;
    		color: #a75d28;
		}

		.textNoteSize {
			width: 100%; 
			height: 100px; 
			border: 1px solid #c5c5c5; 
			padding: 10px;
			background-color: white;
			resize: none;
		}

		p {
			margin: 0;
		}

		.functionTextareaDiv {
			border: 1px solid #c5c5c5; 
			background-color: white; 
			min-height: 200px;
			padding: 5px;
		}
	</style>
	
	

</html>