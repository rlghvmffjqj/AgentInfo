<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<div class="modelHeadFont">라이센스 발급 키 등록</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 90px;">
	<table style="margin:20px">
		<tbody>
			<tr>
				<td style="font-weight: bolder;">Windows 라이센스 발급 키 : </td>
				<td><input type="text" id="licenseIssueKey" autofocus></td>
			</tr>
			<tr>
				<td colspan='2'><span class="colorRed" id="NotLicenseIssuedKey" style="display: none; line-height: initial;">라이센스 발급 키 값을 반드시 입력 바랍니다.</span></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnLicenseSave" onClick="BtnLicenseSave()">등록</button>
</div>
<input type="hidden" id="licenseKeyNum" name="licenseKeyNum" value="${licenseKeyNum}">
<input type="hidden" id="licenseUidLogKeyNum" name="licenseUidLogKeyNum" value="${licenseUidLogKeyNum}">

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});

	/* =========== 라이센스 발급 키 저장 ========= */
	function BtnLicenseSave() {
		var licenseIssueKey = $('#licenseIssueKey').val();
		var licenseKeyNum = $('#licenseKeyNum').val();
		var licenseUidLogKeyNum = $('#licenseUidLogKeyNum').val(); 
		
		if(licenseIssueKey != "") {
			$.ajax({
				url: "<c:url value='/license/saveLicenseKey'/>",
				type: "POST",
				data: {
						"licenseIssueKey": licenseIssueKey,
						"licenseKeyNum": licenseKeyNum,
						"licenseUidLogKeyNum": licenseUidLogKeyNum,
					},
				dataType: "json",
				async: false,
				success: function(data) {
					if(data.result == "OK"){
						Swal.fire({
							icon: 'success',
							title: '라이센스 발급 키 등록 완료!',
							text: licenseIssueKey,
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
		} else {
			$('#NotLicenseIssuedKey').show();
			Swal.fire({
				icon: 'info',
				title: '확인!',
				text: '라이센스 발급 키 값을 반드시 입력 바랍니다.',
			});
		}
	}
	
	/* =========== Enter Key ========= */
	$("#licenseIssueKey").keypress(function(event) {
		if (window.event.keyCode == 13) {
			BtnLicenseSave();
		}
	});
</script>