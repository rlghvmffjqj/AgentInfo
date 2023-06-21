<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>체크리스트 테스트 방법</title>
		
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	</head>
	<body>
		<form id="form">
			<input type="hidden" name='functionTestSettingFormKeyNum' value='${functionTestSetting.functionTestSettingFormKeyNum}'>
			<input type="hidden" name='functionTestSettingCategoryKeyNum' value='${functionTestSetting.functionTestSettingCategoryKeyNum}'>
			<input type="hidden" name='functionTestSettingSubCategoryKeyNum' value='${functionTestSetting.functionTestSettingSubCategoryKeyNum}'>
			<input type="hidden" name='functionTestSettingDetailKeyNum' value='${functionTestSettingDetail.functionTestSettingDetailKeyNum}'>
			<textarea class="summerNoteSize" rows="5" id="functionTestSettingDetailMethod" name="functionTestSettingDetailMethod">${functionTestSettingDetail.functionTestSettingDetailMethod}</textarea>
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
				url: "<c:url value='/functionTestSetting/detailSave'/>",
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
	</style>

</html>