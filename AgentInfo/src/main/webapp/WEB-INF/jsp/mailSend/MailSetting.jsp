<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">Mail 발송 설정</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 400px;">
	<form id="mailSettingForm" name="form" method ="post">
		<input type="hidden" id="sendMailSettingTarget" name="sendMailSettingTarget" value="${sendMailSetting.sendMailSettingTarget}">
		<table style="margin:20px">
			<tbody>
				<tr><td style="font-weight: bolder;">발신자</td></tr>
				<tr><td><input type="text" class="width550" id="sendMailSettingManager" name="sendMailSettingManager" value="${sendMailSetting.sendMailSettingManager}" placeholder="iamdev"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">메일 제목</td></tr>
				<tr><td><input type="text" class="width550" id="sendMailSettingSubject" name="sendMailSettingSubject" value="${sendMailSetting.sendMailSettingSubject}" placeholder="[알림] 라이선스 5.0 만료 안내"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">N일 전 1회</td></tr>
				<tr><td><input type="number" class="width550" id="sendMailSettingSingle" name="sendMailSettingSingle" value="${sendMailSetting.sendMailSettingSingle}" placeholder="30"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">N일 이내 매일 발송</td></tr>
				<tr><td><input type="number" class="width550" id="sendMailSettingDaily" name="sendMailSettingDaily" value="${sendMailSetting.sendMailSettingDaily}" placeholder="7"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">수신자(발송 여부)</td></tr>
				<tr>
					<td style="text-align: center; padding-top: 15px;">
						<div style="width: 55%; float: left;">
							요청자(엔지니어) : 
							<input type="checkbox" id="sendMailSettingRequester" name="sendMailSettingRequester" ${sendMailSetting.sendMailSettingRequester == 'on' ? 'checked' : ''}>
						</div>
						<div style="width: 70%;">
							담당 영업 :
							<input type="checkbox" id="sendMailSettingSalesManager" name="sendMailSettingSalesManager" ${sendMailSetting.sendMailSettingSalesManager == 'on' ? 'checked' : ''}>
						</div>
					</td>
				</tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">참조</td></tr>
				<tr><td><input type="text" class="width550" id="sendMailSettingIssuance" name="sendMailSettingIssuance" value="${sendMailSetting.sendMailSettingIssuance}" placeholder="라이선스 발급 관리자"></td></tr>
				<tr class="height15"></tr>
			</tbody>
		</table>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnMailSetting" onClick="BtnMailSetting()">설정</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== TXT 저장 ========= */
	function BtnMailSetting() {
		var postData = $('#mailSettingForm').serializeObject();
		$.ajax({
			url: "<c:url value='/mailSend/mailSettingChange'/>",
			type: "POST",
			data: postData,
			dataType: "text",
			async: false,
			traditional: true,
			success: function(data) {
				if(data == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: 'Mail 발송 설정 완료!',
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