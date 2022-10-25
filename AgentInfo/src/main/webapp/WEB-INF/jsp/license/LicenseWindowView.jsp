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
				<td><input type="text" id="licenseIssueKeyView" autofocus></td>
			</tr>
			<tr>
				<td colspan='2'><span class="colorRed" id="NotLicenseIssuedKey" style="display: none; line-height: initial;">라이센스 발급 키 값을 반드시 입력 바랍니다.</span></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnLicenseSave" onClick="BtnLicenseSave()">등록</button>
	<button class="btn btn-default btn-outline-info-nomal" onClick="BtnCancel()">닫기</button>
</div>
<input type="hidden" id="licenseKeyNum" name="licenseKeyNum" value="${licenseKeyNum}">

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});
	
	//function BtnCancel() {
	//	var licenseKeyNum = $('#licenseKeyNum').val();
	//	
	//	$.ajax({
	//		url: "<c:url value='/license/licensCancel'/>",
	//		type: "POST",
	//		data: {
	//				"licenseKeyNum": licenseKeyNum,
	//			},
	//		async: false,
	//		success: function() {
	//			$('#modal').modal("hide"); // 모달 닫기
	//			$('#modal').on('hidden.bs.modal', function () {
	//				tableRefresh();
	//			});
	//		},
	//		error: function(e) {
	//	    	console.log(e);
	//	    }
	//	});
	//}
	
	/* =========== 닫기 버튼 ========= */
	function BtnCancel() {
		var licenseKeyNum = $('#licenseKeyNum').val();
		var viewType = "${viewType}";
		if(!viewType.includes("back")) {
			viewType = viewType + "back";
		}
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/license/issuedView'/>",
		    data: {
		    		"licenseKeyNum" : licenseKeyNum,
		    		"viewType" : viewType
		    		
		    	},
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
			    	$.modal(data, 'll'); //modal창 호출
		    	},300)
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});
	}

	/* =========== 라이센스 발급 키 저장 ========= */
	function BtnLicenseSave() {
		var licenseIssueKey = $('#licenseIssueKeyView').val();
		var licenseKeyNum = $('#licenseKeyNum').val();
		
		if(licenseIssueKey != "") {
			$.ajax({
				url: "<c:url value='/license/saveLicenseKey'/>",
				type: "POST",
				data: {
						"licenseIssueKey": licenseIssueKey,
						"licenseKeyNum": licenseKeyNum,
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