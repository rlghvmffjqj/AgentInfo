<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">Mail 발송 설정</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 420px;">
	<form id="mailSettingForm" name="form" method ="post">
		<input type="hidden" id="sendMailSettingTarget" name="sendMailSettingTarget" value="${sendMailSetting.sendMailSettingTarget}">
		<table style="margin:20px">
			<tbody>
				<tr><td style="font-weight: bolder;">발신자</td></tr>
				<tr><td><input type="text" class="form-control width550" id="sendMailSettingManager" name="sendMailSettingManager" value="${sendMailSetting.sendMailSettingManager}" placeholder="iamdev"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">메일 제목</td></tr>
				<tr><td><input type="text" class="form-control width550" id="sendMailSettingSubject" name="sendMailSettingSubject" value="${sendMailSetting.sendMailSettingSubject}" placeholder="[알림] 라이선스 5.0 만료 안내"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">N일 전 1회</td></tr>
				<tr><td><input type="number" class="form-control width550" id="sendMailSettingSingle" name="sendMailSettingSingle" value="${sendMailSetting.sendMailSettingSingle}" placeholder="30"></td></tr>
				<tr class="height15"></tr>
				<tr><td style="font-weight: bolder;">N일 이내 매일 발송</td></tr>
				<tr><td><input type="number" class="form-control width550" id="sendMailSettingDaily" name="sendMailSettingDaily" value="${sendMailSetting.sendMailSettingDaily}" placeholder="7"></td></tr>
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
				<tr><td><input type="text" class="form-control width550" id="sendMailSettingIssuance" name="sendMailSettingIssuance" value="${sendMailSetting.sendMailSettingIssuance}" placeholder="라이선스 발급 관리자"></td></tr>
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

	$(function() {
		function split(val) {
		    return val.split(/,\s*/);
		}

		function extractLast(term) {
		    return split(term).pop();
		}

		$("#sendMailSettingIssuance").on("keydown", function(event) {
		    if (event.keyCode === $.ui.keyCode.TAB &&
		        $(this).data("ui-autocomplete")?.menu.active) {
		        event.preventDefault();
		    }
		}).autocomplete({
		    minLength: 1,
		    source: function(request, response) {
		        const term = extractLast(request.term);
		        $.ajax({
		            url: "<c:url value='/employee/inputSearch'/>",
		            type: 'post',
		            dataType: "json",
		            data: { keyword: term },
		            success: function(data) {
		                response($.map(data, function(item) {
		                    return {
		                        label: item.employeeName + "(" + item.employeeId + ")",
		                        value: item.employeeName + "(" + item.employeeId + ")"
		                    };
		                }));
		            }
		        });
		    },
		    focus: function() {
		        return false; // 입력창에 자동 채우기 방지
		    },
		    select: function(event, ui) {
		        let terms = split(this.value);
		        terms.pop(); // 현재 입력중인 단어 제거
		        terms.push(ui.item.value);
		        terms.push(""); // 다음 입력을 위해 빈 문자열 추가
		        this.value = terms.join(", ");
		        return false;
		    }
		});

	})
</script>