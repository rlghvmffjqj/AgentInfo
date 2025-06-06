<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>기능 테스트 결과</title>
		
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	</head>
	<body>
		<form id="form">
			<input type="hidden" id='functionTestKeyNum' name='functionTestKeyNum' value='${functionTest.functionTestKeyNum}'>
			<input type="hidden" id='functionTestSettingSubCategoryKeyNum' name='functionTestSettingSubCategoryKeyNum' value='${functionTest.functionTestSettingSubCategoryKeyNum}'>
			<textarea class="summerNoteSize" rows="5" id="functionTestResult" name="functionTestResult">${functionTest.functionTestResult}</textarea>
			<div class='detailSaveDiv'><button class="btn btn-outline-info-add myBtn" onClick="btnSave();">저장</button></div>
		</form>
	</body>
	
	<script>
		$(function (){
			/* =========== 섬머노트 ========= */
			$('.summerNoteSize').summernote({
				minHeight:690,
				placeholder:"여기에 내용을 입력 주세요."
			});
		});
		
		function btnSave() {
			var formData = $("#form").serializeObject();
			$.ajax({
				url: "<c:url value='/functionTest/resultSave'/>",
				data: formData,
				type: "POST",
				async: false,
				success: function(data) {
					if(data == "OK") {
						Swal.fire({
							icon: 'success',
							title: '저장!',
							text: '저장 완료 되었습니다!',
						}).then((result) => {
							window.close();
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '저장 실패 하였습니다!',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
			event.preventDefault();
		}
	</script>
	<style>
		.detailSaveDiv {
			width: 100%;
		    text-align: center;
		    padding-top: 10px;
		}

		p {
			color: black;
			font-size: 15px;
		}
	</style>

</html>