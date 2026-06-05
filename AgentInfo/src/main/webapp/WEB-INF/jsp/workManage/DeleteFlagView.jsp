<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- SummerNote -->
<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
<div class="modelHead">
	<div class="modelHeadFont">업무 삭제</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 280px;">
	<table style="width: 100%;">
		<tbody>
			<tr>
				<td><textarea class="summerNoteSize" id="summernote" name="summernote"></textarea></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnDeleteFlag" onClick="btnDeleteFlag()">삭제</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 섬머노트 ========= */
	$(function() {
		$('#summernote').summernote({
			height:200,
			placeholder:"삭제 사유를 입력 바랍니다."
		});
	});
	
	/* =========== 상태 변경 ========= */
	function btnDeleteFlag() {
		var chkList = $("#list").getGridParam('selarrrow');
		var workManageDelReaon = $('#summernote').val();
		
		$.ajax({
			url: "<c:url value='/workManage/deleteFlag'/>",
			type: "POST",
			data: {
					chkList: chkList,
					"workManageDelReaon": workManageDelReaon,
				},
			dataType: "text",
			async: false,
			traditional: true,
			success: function(result) {
				console.log(result);
				if(result == "OK"){
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