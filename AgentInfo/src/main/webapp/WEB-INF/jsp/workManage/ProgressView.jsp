<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- SummerNote -->
<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
<div class="modelHead">
	<div class="modelHeadFont">상태 변경</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 360px; margin-left: 25px;">
	<table>
		<tbody>
			<tr class="hight60">
				<td style="width: 50px;">진행률 : </td>
				<td class="percent-wrap" style="width: 100px;">
					<input type="number" id="workManageProgressView" name="workManageProgressView" class="form-control viewForm" min="0" max="100" value="${workManage.workManageProgress}" style="text-align: right; font-weight: bold;">
					<span style="top: 50%;">%</span>
				</td>
				<td>
			</tr>
			<tr>
				<td colspan='3'>비고 : </td>
			</tr>
			<tr>
				<td colspan='3'><textarea class="summerNoteSize" id="summernote" name="summernote">${workManage.workManageComment}</textarea></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnProgressChange" onClick="btnProgressChange()">변경</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 섬머노트 ========= */
	$(function() {
		$('#summernote').summernote({
			height:200,
			placeholder:"테스트 중 발생한 특이사항 및 진행 상황을 입력합니다."
		});
	});
	
	/* =========== 상태 변경 ========= */
	function btnProgressChange() {
		var chkList = $("#list").getGridParam('selarrrow');
		var workManageCommentView = $('#summernote').val();
		var workManageProgressView = $("#workManageProgressView").val();
		
		$.ajax({
			url: "<c:url value='/workManage/progressChange'/>",
			type: "POST",
			data: {
					chkList: chkList,
					"workManageCommentView" : workManageCommentView,
					"workManageProgressView" : workManageProgressView
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
						tableRefresh();
					});
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
<style>
	.percent-wrap{
	    position:relative;
	    width:200px;
	}

	.percent-wrap input{
	    padding-right:30px;
	}

	.percent-wrap span{
	    position:absolute;
	    right:10px;
	    top:50%;
	    transform:translateY(-50%);
	}
</style>