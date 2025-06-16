<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">삭제 사유</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 200px; margin-left: 10px;">
	<table>
		<tbody>
			<tr class="hight60">
				<td colspan='3'>사유 : </td>
			</tr>
			<tr>
				<td colspan='3'><textarea  id="resultsreportDelNoteView" name="resultsreportDelNoteView" rowspan="3" style="width: 17vw; height: 100px; font-size: 12px;"></textarea></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" onClick="btnDeleteNote()">입력</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 상태 변경 ========= */
	function btnDeleteNote() {
		var resultsreportDelNote = $('#resultsreportDelNoteView').val();
		if(resultsreportDelNote != '') {
			$('#resultsreportDelNote').val(resultsreportDelNote);
			$('#modal').modal("hide"); // 모달 닫기
			$('#modal').on('hidden.bs.modal', function () {
				deletelst();
			});
		} else {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '삭제 사유를 입력 바랍니다.',    
			}); 
		}
	}
</script>

<style>
	textarea {
			width: 100%;
			height: 200px;
			padding: 10px;
			box-sizing: border-box;
			border: solid 2px #ffba1e;
			border-radius: 5px;
			font-size: 16px;
			resize: both;
		}
</style>