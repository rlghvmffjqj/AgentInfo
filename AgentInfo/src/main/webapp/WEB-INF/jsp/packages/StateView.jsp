<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<!-- SummerNote -->
<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
<div class="modelHead">
	<div class="modelHeadFont">상태 변경</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 360px;">
	<table>
		<tbody>
			<tr class="hight60">
				<td style="width: 50px;">상태 : </td>
				<td style="width: 100px;">
					<select class="form-control selectpicker" id="stateView" name="stateView" data-size="5" data-actions-box="true">
						<option value='적용' class="backGreen">적용</option>
						<option value="배포완료" class="backRed">배포완료</option>
					</select>
				</td>
				<td>
			</tr>
			<tr>
				<td colspan='3'>비고 : </td>
			</tr>
			<tr>
				<td colspan='3'><textarea class="summerNoteSize" id="summernote" name="summernote"></textarea></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnStateChange" onClick="btnStateChange()">변경</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 섬머노트 ========= */
	$(function() {
		$('#summernote').summernote({
			height:200,
			placeholder:"상태 변경 시 특이 사항입력 바랍니다.(예시: 고객사 사정으로 **년 **월 **일 까지 대기 합니다.)"
		});
	});
	
	/* =========== 상태 변경 ========= */
	function btnStateChange() {
		var chkList = $("#list").getGridParam('selarrrow');
		var statusComment = $('#summernote').val();
		var stateView = $("#stateView").val();
		
		$.ajax({
			url: "<c:url value='/packages/stateChange'/>",
			type: "POST",
			data: {
					chkList: chkList,
					"statusComment" : statusComment,
					"stateView" : stateView
				},
			dataType: "json",
			async: false,
			traditional: true,
			success: function(data) {
				if(data.result == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						reloadView();
					});
					tableRefresh();
				} else{
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(e) {
		    	console.log(e);
		    }
		});
	}
</script>