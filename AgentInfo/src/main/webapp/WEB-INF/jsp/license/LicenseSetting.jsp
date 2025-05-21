<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">License Issued 경로 설정</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 250px;">
	<table style="margin:20px">
		<tbody>
			
			<c:choose>
				<c:when test="${licenseVersion eq '2'}">
					<tr><td style="font-weight: bolder;">IP</td></tr>
					<tr><td><input type="text" class="width380" id="licenseSettingIP" value="${licenseSetting.licenseSettingIP}" placeholder="172.16.50.91" autofocus></td></tr>
					<tr class="height15"></tr>
					<tr><td style="font-weight: bolder;">WINDOWS</td></tr>
					<tr><td><input type="text" class="width380" id="windowsLicenseRoute" value="${licenseSetting.windowsLicenseRoute}" placeholder="C:\경로\ + exe파일" autofocus></td></tr>
					<tr class="height15"></tr>
					<tr><td style="font-weight: bolder;">LINUX 2.0</td></tr>
					<tr><td><input type="text" class="width380" id="linuxLicense20Route" value="${licenseSetting.linuxLicense20Route}" placeholder="루트경로 + 실행파일"></td></tr>
				</c:when>
	         	<c:when test="${licenseVersion eq '5'}">
					<tr><td style="font-weight: bolder;">IP</td></tr>
					<tr><td><input type="text" class="width380" id="licenseSettingIP" value="${licenseSetting.licenseSettingIP}" placeholder="172.16.50.91" autofocus></td></tr>
					<tr class="height15"></tr>
					<tr><td style="font-weight: bolder;">(구)LINUX 5.0</td></tr>
					<tr><td><input type="text" class="width380" id="linuxLicense50OldRoute" value="${licenseSetting.linuxLicense50OldRoute}" placeholder="루트경로 + 실행파일"></td></tr>
					<tr class="height15"></tr>
					<tr><td style="font-weight: bolder;">(신)LINUX 5.0</td></tr>
					<tr><td><input type="text" class="width380" id="linuxLicense50Route" value="${licenseSetting.linuxLicense50Route}" placeholder="루트경로 + 실행파일"></td></tr>
				</c:when>
				<c:when test="${licenseVersion eq 'loggriffin'}">
					<tr><td style="font-weight: bolder;">IP</td></tr>
					<tr><td><input type="text" class="width380" id="logGriffinIP" value="${licenseSetting.logGriffinIP}" placeholder="172.16.50.91" autofocus></td></tr>
					<br>
					<tr class="height15" style="height: 40px;"></tr>
					<tr><td style="font-weight: bolder;">LogGRIFFIN 경로</td></tr>
					<tr><td><input type="text" class="width380" id="logGriffinRoute" value="${licenseSetting.logGriffinRoute}" placeholder="루트경로 + 실행파일"></td></tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnTxtSave" onClick="BtnChange()">변경</button>
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
			BtnChange();
		}
	});
	
	/* =========== TXT 저장 ========= */
	function BtnChange() {
		var windowsLicenseRoute = $('#windowsLicenseRoute').val();
		var linuxLicense20Route = $('#linuxLicense20Route').val();
		var linuxLicense50Route = $('#linuxLicense50Route').val();
		var linuxLicense50OldRoute = $('#linuxLicense50OldRoute').val();
		var licenseSettingIP = $('#licenseSettingIP').val();
		var logGriffinIP = $('#logGriffinIP').val();
		var logGriffinRoute = $('#logGriffinRoute').val();
		$.ajax({
			url: "<c:url value='/license/routeChange'/>",
			type: "POST",
			data: {
					"windowsLicenseRoute": windowsLicenseRoute,
					"linuxLicense20Route": linuxLicense20Route,
					"linuxLicense50Route": linuxLicense50Route,
					"linuxLicense50OldRoute": linuxLicense50OldRoute,
					"licenseSettingIP": licenseSettingIP,
					"logGriffinIP":logGriffinIP,
					"logGriffinRoute":logGriffinRoute
				},
			dataType: "text",
			async: false,
			traditional: true,
			success: function(data) {
				if(data == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: 'License Issued 경로 변경 완료!',
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
	}
</script>