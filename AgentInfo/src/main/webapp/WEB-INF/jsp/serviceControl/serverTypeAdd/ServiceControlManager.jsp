<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 480px; padding-top: 10%;">
	<div class="card-block margin10">
		 <form class="modalForm form-material" name="modalForm" id="modalForm" method ="post">	
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlPurpose" name="serviceControlPurpose" class="form-control" value="" placeholder="고객사 전용">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">사용 목적</label>
			</div>
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlIp" name="serviceControlIp" class="form-control" value="" placeholder="172.16.0.0">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">서버 IP</label>
			</div>
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlHostIp" name="serviceControlHostIp" class="form-control" value="" placeholder="172.16.0.0">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">호스트 IP</label>
			</div>
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlServicePath" name="serviceControlServicePath" class="form-control" value="/usr/local/secuve">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">서비스 설치 경로(LogServer, ScvEA, scvca, TOSSuite)</label>
			</div>
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlTomcatPath" name="serviceControlTomcatPath" class="form-control" value="/sw/tomcat">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">Tomcat 설치 경로</label>
			</div>
			<div class="form-group form-default form-static-label">
				<select class="form-control" id="serviceControlDbType" name="serviceControlDbType">
					<option value="none">미설치</option>
					<option value="tibero">Tibero</option>
					<option value="oracle">Oracle</option>
					<option value="mysql">Mysql</option>
					<option value="mariadb">MariaDB</option>
					<option value="mssql">MSSQL</option>
					<option value="db2">DB2</option>
				</select>
				<span class="form-bar"></span>
				<label class="float-label headLabel">DB 구분</label>
			</div>
			<input id="serviceControlServerType" name="serviceControlServerType" type="hidden" value="${serviceControlServerType}">
		 </form>
     </div>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		if(postData.serviceControlPurpose == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: "사용 목적 필수 입력 바랍니다.",
			});
			return;
		}
		if(postData.serviceControlIp == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: "서버 IP 필수 입력 바랍니다.",
			});
			return;
		}
		
		showLoadingImage();
		$.ajax({
			url: "<c:url value='/serviceControl/insert'/>",
	        type: 'post',
	        data: postData,
	        success: function(result) {
				hideLoadingImage();
				if(result === 'OK') {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
	        		$('#modal').on('hidden.bs.modal', function () {
	        			tableRefresh();
	        		});
				} else if(result == "duplication") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: "동일한 서버가 존재 합니다.",
					});
				} else if(result == "pcOff") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: "서비스 등록은 완료 하였지만, PC전원이 종료 되어 있습니다.",
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
		        	});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: "작업 실패 하였습니다.",
					});
				}
			},
			error: function(error) {
				hideLoadingImage();
				Swal.fire({
					icon: 'error',
					title: '에러!',
					text: "작업 처리 중 에러가 발생하였습니다. 관리자에게 문의 바랍니다.",
				})
				console.log(error);
			}
	    });
	});

	
</script>

