<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">경로 설정<span style="font-size: 14px; color: #ff4d4d;">(서비스 경로가 서로 다를 경우 입력 바랍니다.)</span></div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 260px;">
	<form class="modalForm form-material" name="modalForm" id="modalForm" method ="post">
		<div class="form-group form-default form-static-label form-view" style="margin-top: 7%;">
			<input type="text" id="serviceControlLogServerPath" name="serviceControlLogServerPath" class="form-control" value="${serviceControl.serviceControlLogServerPath}">
			<span class="form-bar"></span>
			<label class="float-label headLabel">LogServer 설치 경로</label>
		</div>
		<div class="form-group form-default form-static-label form-view">
			<input type="text" id="serviceControlScvEAPath" name="serviceControlScvEAPath" class="form-control" value="${serviceControl.serviceControlScvEAPath}">
			<span class="form-bar"></span>
			<label class="float-label headLabel">ScvEA 설치 경로</label>
		</div>
		<div class="form-group form-default form-static-label form-view">
			<input type="text" id="serviceControlScvCAPath" name="serviceControlScvCAPath" class="form-control" value="${serviceControl.serviceControlScvCAPath}">
			<span class="form-bar"></span>
			<label class="float-label headLabel">ScvCA 설치 경로</label>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" type="button" id="BtnStateChange" onClick="btnStateChange()">변경</button>	
    <button class="btn btn-default btn-outline-info-nomal" type="button" id="routeSettingClose">닫기</button>
</div>

<script>
	/* =========== 상태 변경 ========= */
	function btnStateChange() {
		var serviceControlLogServerPath = $('#serviceControlLogServerPath').val();
		var serviceControlScvCAPath = $('#serviceControlScvCAPath').val();
		var serviceControlScvEAPath = $("#serviceControlScvEAPath").val();
		var serviceControlIp = "${serviceControl.serviceControlIp}";
		
		$.ajax({
			url: "<c:url value='/serviceControl/routeSetting'/>",
			type: "POST",
			data: {
					"serviceControlLogServerPath": serviceControlLogServerPath,
					"serviceControlScvCAPath" : serviceControlScvCAPath,
					"serviceControlScvEAPath" : serviceControlScvEAPath,
					"serviceControlIp" : serviceControlIp
				},
			async: false,
			traditional: true,
			success: function(result) {
				if(result == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					setTimeout(() => {
						updateView('${serviceControl.serviceControlIp}',"managerServer");
					}, 200);
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

	$('#routeSettingClose').click(function() {
		$('#modal').modal("hide");
		$('#modal').on('hidden.bs.modal', function () {
			updateView('${serviceControl.serviceControlIp}',"managerServer");
		})
	});
</script>