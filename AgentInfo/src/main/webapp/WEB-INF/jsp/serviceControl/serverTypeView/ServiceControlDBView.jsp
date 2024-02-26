<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 600px; padding-top: 3%;">
	<div class="card-block margin10">
		 <form class="modalForm form-material" name="modalForm" id="modalForm" method ="post">
			<input type="hidden" id="serviceControlKeyNum" name="serviceControlKeyNum" value="${serviceControl.serviceControlKeyNum}">
			<input type="hidden" id="serviceControlScvEAPath" name="serviceControlScvEAPath" value="${serviceControl.serviceControlScvEAPath}">
			<input type="hidden" id="serviceControlScvCAPath" name="serviceControlScvCAPath" value="${serviceControl.serviceControlScvCAPath}">
			<input type="hidden" id="serviceControlLogServerPath" name="serviceControlLogServerPath" value="${serviceControl.serviceControlLogServerPath}">
			<div class="form-group form-default form-static-label form-view">
				<select class="form-control" id="serviceControlServerType" name="serviceControlServerType">
					<option value="managerServer" <c:if test="${'managerServer' eq serviceControl.serviceControlServerType}">selected</c:if>>관리 서버</option>
					<option value="dbServer" <c:if test="${'dbServer' eq serviceControl.serviceControlServerType}">selected</c:if>>DB 서버</option>
					<option value="hostServer" <c:if test="${'hostServer' eq serviceControl.serviceControlServerType}">selected</c:if>>Host 서버</option>
				</select>
				<span class="form-bar"></span>
				<label class="float-label headLabel">서버종류</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlPurpose" name="serviceControlPurpose" class="form-control" value="${serviceControl.serviceControlPurpose}">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">사용 목적</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlIp" name="serviceControlIp" class="form-control" value="${serviceControl.serviceControlIp}">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">서버 IP</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
				<select class="form-control" id="serviceControlHostIp" name="serviceControlHostIp">
					<option value="90" <c:if test="${'90' eq serviceControl.serviceControlHostIp}">selected</c:if>>#90</option>
					<option value="160" <c:if test="${'160' eq serviceControl.serviceControlHostIp}">selected</c:if>>#160</option>
				</select>
				<span class="form-bar"></span>
				<label class="float-label headLabel">호스트 서버</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
				<select class="form-control" id="serviceControlDbType" name="serviceControlDbType">
					<option value="none" <c:if test="${'none' eq serviceControl.serviceControlDbType}">selected</c:if>>미설치</option>
					<option value="tibero" <c:if test="${'tibero' eq serviceControl.serviceControlDbType}">selected</c:if>>Tibero</option>
					<option value="oracle" <c:if test="${'oracle' eq serviceControl.serviceControlDbType}">selected</c:if>>Oracle</option>
					<option value="mysql" <c:if test="${'mysql' eq serviceControl.serviceControlDbType}">selected</c:if>>Mysql</option>
					<option value="mariaDB" <c:if test="${'mariaDB' eq serviceControl.serviceControlDbType}">selected</c:if>>MariaDB</option>
					<option value="mssql" <c:if test="${'mssql' eq serviceControl.serviceControlDbType}">selected</c:if>>MSSQL</option>
					<option value="db2" <c:if test="${'db2' eq serviceControl.serviceControlDbType}">selected</c:if>>DB2</option>
				</select>
				<span class="form-bar"></span>
				<label class="float-label headLabel">DB 구분</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
				<div class="statusDiv form-control">
					<c:if test="${'on' eq serviceControl.serviceControlPcPower}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'off' eq serviceControl.serviceControlPcPower}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'on' eq serviceControl.serviceControlPcPower}">실행</c:if>
						<c:if test="${'off' eq serviceControl.serviceControlPcPower}">종료</c:if>
					</span>
				</div>
				<span class="form-bar"></span>
				<label class="float-label headLabel">PC 전원</label>
			</div>
			<div class="form-group form-default form-static-label form-view borderBotton">
				<div class="statusDiv">
					<c:if test="${'execution' eq serviceControl.serviceControlDB}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'notRunning' eq serviceControl.serviceControlDB}"><img src="/AgentInfo/images/yellowcircle.png" style="width:20px;"></c:if>
					<c:if test="${'notInstalled' eq serviceControl.serviceControlDB}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<c:if test="${'unableConfirm' eq serviceControl.serviceControlDB}"><img src="/AgentInfo/images/graycircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'execution' eq serviceControl.serviceControlDB}">실행</c:if>
						<c:if test="${'notRunning' eq serviceControl.serviceControlDB}">미실행</c:if>
						<c:if test="${'notInstalled' eq serviceControl.serviceControlDB}">미설치</c:if>
						<c:if test="${'unableConfirm' eq serviceControl.serviceControlDB}">확인불가</c:if>
					</span>
				</div>
				<div class="dropdown form-control">
					<c:if test="${'on' eq serviceControl.serviceControlPcPower}">
						<button class="btn custom-btn" type="button" id="dbToggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						  	상태 변경
						</button>
						<div class="dropdown-menu" aria-labelledby="dbToggle">
						  	<!-- Dropdown items go here -->
						  	<a class="dropdown-item dbToggle" href="#" data-value="run">실행</a>
						  	<a class="dropdown-item dbToggle" href="#" data-value="stop">중지</a>
						</div>
					</c:if>
				</div>
				<span class="form-bar"></span>
				<label class="float-label headLabel">Database 상태</label>
			</div>
			<div class="form-group form-default form-static-label form-view borderBotton">
				<div class="statusDiv">
					<c:if test="${'execution' eq serviceControl.serviceControlFirewall}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'notRunning' eq serviceControl.serviceControlFirewall}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<c:if test="${'unableConfirm' eq serviceControl.serviceControlFirewall}"><img src="/AgentInfo/images/graycircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'execution' eq serviceControl.serviceControlFirewall}">실행</c:if>
						<c:if test="${'notRunning' eq serviceControl.serviceControlFirewall}">중지</c:if>
						<c:if test="${'unableConfirm' eq serviceControl.serviceControlFirewall}">확인불가</c:if>
					</span>
				</div>
				<div class="dropdown form-control">
					<c:if test="${'on' eq serviceControl.serviceControlPcPower}">
						<button class="btn custom-btn" type="button" id="firewallToggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						  	상태 변경
						</button>
						<div class="dropdown-menu" aria-labelledby="firewallToggle">
						  	<!-- Dropdown items go here -->
						  	<a class="dropdown-item firewallToggle" href="#" data-value="run">실행</a>
						  	<a class="dropdown-item firewallToggle" href="#" data-value="stop">중지</a>
						</div>
					</c:if>
				</div>
				<span class="form-bar"></span>
				<label class="float-label headLabel">방화벽</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlJavaVersion" name="serviceControlJavaVersion" class="form-control" value="${serviceControl.serviceControlJavaVersion}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">자바 버전</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlDisk" name="serviceControlDisk" class="form-control" value="${serviceControl.serviceControlDisk}%" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">디스크 사용량</label>
			</div>
			<div class="form-group form-default form-static-label form-view" style="width: 100%;">
			    <input type="text" id="serviceControlMemory" name="serviceControlMemory" class="form-control" value="${serviceControl.serviceControlMemory}%" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">메모리 사용량</label>
			</div>
			<div class="form-group form-default form-static-label form-view" style="width: 100%;">
			    <input type="text" id="serviceControlRelease" name="serviceControlRelease" class="form-control" value="${serviceControl.serviceControlRelease}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">릴리즈 정보</label>
			</div>
			<div class="form-group form-default form-static-label form-view" style="width: 100%;">
			    <input type="text" id="serviceControlKernel" name="serviceControlKernel" class="form-control" value="${serviceControl.serviceControlKernel}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">커널 정보</label>
			</div>
		 </form>
		 
     </div>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal" id="close">닫기</button>
</div>

<script>
	$('#close').click(function() {
		//location.reload(true);
		tableRefresh();
	});

	$(document).keydown(function(e) {
        if (e.which === 27) {
            tableRefresh();
        }
    });

	$('#updateBtn').click(function() {
		showLoadingImage();
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/serviceControl/update'/>",
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

	$(document).ready(function() {
		$('.firewallToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("firewall", selectedValue);
    	});

		$('.dbToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("db", selectedValue);
    	});
 	});

	function statusChange(service, status) {
		var serviceControlIp = "${serviceControl.serviceControlIp}";
		showLoadingImage();
		$.ajax({
			url: "<c:url value='/serviceControl/executionChange'/>",
	        type: 'post',
	        data: {
				"service": service,
				"status": status,
				"serviceControlIp": serviceControlIp
			},
	        success: function(result) {
				hideLoadingImage();
				if(result === 'OK') {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					}).then((result) => {
						if (result.isConfirmed) {
							$('#modal').modal("hide"); // 모달 닫기
							setTimeout(() => {
								updateView(serviceControlIp);
							}, 200);
							
						}
					})
					
				} else {
					Swal.fire({
						icon: 'success',
						title: '디버그',
						text: result,
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
	}

	function logInquiry(service) {
		var serviceControlIp = "${serviceControl.serviceControlIp}";
		showLoadingImage();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/serviceControl/logInquiryView'/>",
			data: {
				"serviceControlIp": serviceControlIp,
				"service": service
			},
		    success: function (data) {
				$('#modal').modal("hide"); // 모달 닫기
				setTimeout(() => {
		    		$.modal(data, 'logInquiry'); //modal창 호출
					hideLoadingImage();
				}, 200);
		    },
		    error: function(e) {
				hideLoadingImage();
		        alert(e);
		    }
		});			
	}

	function routeSetting() {
		var serviceControlIp = "${serviceControl.serviceControlIp}";
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/serviceControl/routeSettingView'/>",
			data: {
				"serviceControlIp": serviceControlIp
			},
		    async: false,
		    success: function (data) {
				$('#modal').modal("hide"); // 모달 닫기
				setTimeout(() => {
					$.modal(data, 'sr'); //modal창 호출
				}, 200);
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});
	}

</script>

<style>
	.form-view {
		width: 50%;
    	float: left;
	}

	.form-group > .dropdown {
		float: right;
    	width: auto !important;;
    	border: none !important;;
	}

	.statusDiv {
		float: left;
    	padding-top: 2% !important;
	}

	.borderBotton {
		border-bottom: 1px solid #ccc;
	}

	.custom-btn {
		margin-right: 7px;
		background: bisque;
	}

	.logLook {
		float: right;
		width: 75px;
	}

	.form-group {
		height: 44px;
		border-bottom: 1px solid #ccc;
	}

	.form-group > .form-control {
		border-bottom: none !important;
	}

</style>

