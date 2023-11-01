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
	<body style="background: white">
		<form id="form">
			<input type="hidden" name='functionTestSettingFormKeyNum' value='${functionTestSetting.functionTestSettingFormKeyNum}'>
			<input type="hidden" name='functionTestSettingCategoryKeyNum' value='${functionTestSetting.functionTestSettingCategoryKeyNum}'>
			<input type="hidden" name='functionTestSettingSubCategoryKeyNum' value='${functionTestSetting.functionTestSettingSubCategoryKeyNum}'>
			<input type="hidden" name='functionTestSettingDetailKeyNum' value='${functionTestSettingDetail.functionTestSettingDetailKeyNum}'>
			<div class="functionSpanDiv">
				<span class="functionSpan">- 사전 테스트 준비 -</span>
			</div>
			<div>
				<textarea class="textNoteSize" id="functionTestSettingDetailProcedure" name="functionTestSettingDetailProcedure" placeholder="사전 테스트 준비 내용을 입력해주세요.">${functionTestSettingDetail.functionTestSettingDetailProcedure}</textarea>
			</div>
			<div class="functionSpanDiv">
				<span class="functionSpan">- 테스트 절차 -</span>
			</div>
			<div>
				<textarea class="summerNoteSize" rows="5" id="functionTestSettingDetailMethod" name="functionTestSettingDetailMethod">${functionTestSettingDetail.functionTestSettingDetailMethod}</textarea>
			</div>
			<div class="functionSpanDiv">
				<span class="functionSpan">- 예상 테스트 결과 -</span>
			</div>
			<div>
				<textarea class="summerNoteSize" rows="5" id="functionTestSettingDetailExpectation" name="functionTestSettingDetailExpectation">${functionTestSettingDetail.functionTestSettingDetailExpectation}</textarea>
			</div>
			<div class='detailSaveDiv'><button class="btn btn-outline-info-add myBtn" onClick="btnSave();">저장</button></div>
		</form>
	</body>
	
	<script>
		$(function (){
			/* =========== 섬머노트 ========= */
			$('#functionTestSettingDetailMethod').summernote({
				minHeight:300,
				placeholder:"테스트 절차를 입력해주세요."
			});

			$('#functionTestSettingDetailExpectation').summernote({
				minHeight:300,
				placeholder:"예상 테스트 결과를 입력해주세요."
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
			padding-bottom: 10px;
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
		}
	</style>

</html>