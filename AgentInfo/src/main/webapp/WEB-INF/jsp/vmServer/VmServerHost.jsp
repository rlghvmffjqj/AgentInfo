<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- SummerNote -->
<div class="modelHead">
	<div class="modelHeadFont">호스트 서버 추가</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 200px;">
	<form id="modalForm" name="form" method ="post">
		<table style="margin: 4%; width: 90%;">
			<tbody>
				<tr>
					<td>
						<label class="labelFontSize">호스트 서버명</label>
						<span class="colorRed" id="NotVmServerHostName" style="display: none; line-height: initial; font-size: 12px;">호스트 서버명을 입력해주세요.</span>
						<span class="colorRed" id="NotVmServerHostNameDoub" style="display: none; line-height: initial; font-size: 12px;">호스트 서버명이 존재합니다.</span>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="vmServerHostNameView" name="vmServerHostNameView" class="form-control viewForm">
					</td>
				</tr>
				<tr><td style="height: 15px;"></td></tr>
				<tr>
					<td>
						<label class="labelFontSize">호스트 IP</label>
						<span class="colorRed" id="NotVmServerHostIp" style="display: none; line-height: initial; font-size: 12px;">호스트 IP를 입력해주세요.</span>
						<span class="colorRed" id="NotVmServerHostIpDoub" style="display: none; line-height: initial; font-size: 12px;">호스트 IP가 존재합니다.</span>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="vmServerHostIpView" name="vmServerHostIpView" class="form-control viewForm">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div id="loadingDiv" style="display:none;">
		<div id="loadingImgDiv">
			<img id="loadingImage" src="/AgentInfo/images/secuve_loading.gif" alt="Loading..." />
		</div>
	</div>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn" onClick="insertBtn()">추가</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	function insertBtn() {
		var postData = $('#modalForm').serializeObject();
		var vmServerHostName = $('#vmServerHostNameView').val();
		var vmServerHostIp = $('#vmServerHostIpView').val();

		if(vmServerHostName == "") {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '호스트 서버명을 입력바랍니다.',    
			}); 
			$('#NotVmServerHostName').show();
		} else if(vmServerHostIp == "") {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '호스트 IP를 입력바랍니다.',    
			}); 
			$('#NotVmServerHostIp').show();
		} else {
			$('#NotVmServerHostName').hide();
			$('#NotVmServerHostIp').hide();
			showLoadingImage();
			$.ajax({
				url: "<c:url value='/vmServer/insert'/>",
		        type: 'post',
		        data: postData,
		        traditional: true,
		        success: function(result) {
					hideLoadingImage();
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$('#modal').modal("hide"); // 모달 닫기
		        		$('#modal').on('hidden.bs.modal', function () {
		        			tableRefresh();
		        		});
					} else if(result == "ERROR") {
						hideLoadingImage();
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '호스트 서버 연결에 실패하였습니다.',
						});
						$('#NotVmServerHostIpDoub').hide();
						$('#NotVmServerHostNameDoub').hide();
					} else if(result == "NotVmServerHostNameDoub") {
						hideLoadingImage();
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '호스트 서버명이 존재합니다.',
						});
						$('#NotVmServerHostNameDoub').show();
						$('#NotVmServerHostIpDoub').hide();
					} else if(result == "NotVmServerHostIpDoub") {
						hideLoadingImage();
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '호스트 IP가 존재합니다.',
						});
						$('#NotVmServerHostIpDoub').show();
						$('#NotVmServerHostNameDoub').hide();
					} else {
						hideLoadingImage();
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '작업을 실패하였습니다.',
						});
					}
				},
				error: function(error) {
					hideLoadingImage();
					console.log(error);
				}
		    });
		}
	}

	
</script>