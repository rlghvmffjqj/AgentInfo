<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">암호 변경</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 200px;">
	<table class="top10">
		<tbody>
			<tr>
				<td>기존 암호 : </td>
				<td style="width:100%"><input type="password" id="oldPwd" name="oldPwd" class="form-control" required></td>
			</tr>
			<tr>
				<td><span class="colorRed fontSize10" id="NotOldPwd" style="display: none">기존 암호를 입력해주세요.</span></td>
				<td><span class="colorRed fontSize10" id="NotPassword" style="display: none">기존암호가 일치하지 않습니다.</span></td>
			</tr>
			<tr>
				<td colspan='2'><span class="topBotton5">----------------------------------------------------------------------------</span></td>
			</tr>
			<tr>
				<td>새암호 : </td>
				<td><input type="password" id="changePwd" name="changePwd" class="form-control topBotton5" required></td>
			</tr>
			<tr>
				<td><span class="colorRed fontSize10" id="NotChangePwd" style="display: none">새암호를 입력해주세요.</span></td>
			</tr>
			<tr>
				<td>새암호 재입력 :</td>
				<td><input type="password" id="confirmPwd" name="confirmPwd" class="form-control" required></td>
			</tr>
			<tr>
				<td><span class="colorRed fontSize10" id="NotConfirmPwd" style="display: none">새암호 재입력을 입력해주세요.</span></td>
				<td><span class="colorRed fontSize10" id="PwdMisMatch" style="display: none">기존암호가 일치하지 않습니다.</span></td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnPwdChange" onClick="btnPwdChange()">변경</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== 패스워드 변경 ========= */
	function btnPwdChange() {
		var oldPwd = $('#oldPwd').val();
		var changePwd = $('#changePwd').val();
		var confirmPwd = $('#confirmPwd').val();
		var usersId = $('#usersId').val();
		
		
		$.ajax({
			url: "<c:url value='/users/pwdChange'/>",
			type: "POST",
			data: {
					"oldPwd" : oldPwd,
					"changePwd" : changePwd,
					"confirmPwd" : confirmPwd,
					"usersId" : usersId
				},
			async: false,
			success: function(data) {
				if(data == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#usersPw').val("");
					$('#modal').modal("hide"); // 모달 닫기
				} else if(data == "NotPassword") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '기존 패스워드가 일치하지 않습니다.',
					});
					$('.colorRed').hide();
					$('#NotPassword').show();
				} else if(data == "PwdMisMatch") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '새암호가 일치하지 않습니다.',
					});
					$('.colorRed').hide();
					$('#PwdMisMatch').show();
				} else if(data == "login") {
					
				} else if(data == "PwdMinLength") {
					Swal.fire({
						icon: 'info',
						title: '확인!',
						text: '암호 최소 길이를 8글자 이상으로 입력 바랍니다.',
					});
				} else {
					if(data == "NotOldPwd") {
						$('.colorRed').hide();
						$('#NotOldPwd').show();	
					}
					if(data == "NotConfirmPwd") {
						$('.colorRed').hide();
						$('#NotConfirmPwd').show();
					}
					if(data == "NotChangePwd") {
						$('.colorRed').hide();
						$('#NotChangePwd').show();
					}
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
	
	/* =========== Enter 검색 ========= */
	$("input[type=password]").keypress(function(event) {
		if (window.event.keyCode == 13) {
			btnPwdChange();
		}
	});
</script>
	
