<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<div class="modelHeadFont">TXT 파일명</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 90px;">
	<table style="margin:20px">
		<tbody>
			<tr>
				<td style="font-weight: bolder;">FileName : </td>
				<td><input type="text" class="width300" id="fileName" autofocus></td>
			</tr>
			<tr>
				<td colspan='2'><span class="colorRed" id="NotTextFileName" style="display: none; line-height: initial;">파일명을 반드시 입력바랍니다.</span></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnTxtSave" onClick="BtnTxtSave()">저장</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});
	
	/* =========== Enter Key ========= */
	$("#fileName").keypress(function(event) {
		if (window.event.keyCode == 13) {
			BtnTxtSave();
		}
	});
	
	/* =========== TXT 저장 ========= */
	function BtnTxtSave() {
		var chkList = $("#list").getGridParam('selarrrow');
		var fileName = $('#fileName').val();
		
		if(fileName != "") {
			$.ajax({
				url: "<c:url value='/license/txtSave'/>",
				type: "POST",
				data: {
						"fileName": fileName,
						"chkList": chkList,
					},
				dataType: "text",
				async: false,
				traditional: true,
				success: function(data) {
					if(data == "OK"){
						window.location ="<c:url value='/license/fileDownload?fileName="+fileName+"'/>";
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '파일 다운로드 완료',
						});
						$('#modal').modal("hide"); // 모달 닫기
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
		} else {
			$('#NotTextFileName').show();
			Swal.fire({
				icon: 'info',
				title: '확인!',
				text: '파일명을 반드시 입력 바랍니다.',
			});
		}
	}
</script>