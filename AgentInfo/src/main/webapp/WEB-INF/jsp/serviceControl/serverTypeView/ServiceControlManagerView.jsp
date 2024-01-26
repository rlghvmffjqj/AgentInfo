<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 820px; padding-top: 3%;">
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
			    <input type="text" id="serviceControlHostIp" name="serviceControlHostIp" class="form-control" value="${serviceControl.serviceControlHostIp}">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">호스트서버</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlLogServerPath" name="serviceControlLogServerPath" class="form-control" value="${serviceControl.serviceControlLogServerPath}" style="width: 82%;" disabled>
				<div class="logLook custom-btn">
					<button class="btn custom-btn" type="button" onclick="routeSetting()">경로 설정</button>
				</div>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">서비스 설치 경로(LogServer, ScvEA, scvca)</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlTomcatPath" name="serviceControlTomcatPath" class="form-control" value="${serviceControl.serviceControlTomcatPath}">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">Tomcat 설치 경로</label>
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
			<c:if test="${'notInstalled' eq serviceControl.serviceControlTomcat || 'on' ne serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view">
					<div class="statusDiv form-control" id="tomcatDiv">
			</c:if>
			<c:if test="${'notInstalled' ne serviceControl.serviceControlTomcat && 'on' eq serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view borderBotton">
					<div class="statusDiv" id="tomcatDiv">
			</c:if>
					<c:if test="${'execution' eq serviceControl.serviceControlTomcat}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'notRunning' eq serviceControl.serviceControlTomcat}"><img src="/AgentInfo/images/yellowcircle.png" style="width:20px;"></c:if>
					<c:if test="${'notInstalled' eq serviceControl.serviceControlTomcat}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<c:if test="${'unableConfirm' eq serviceControl.serviceControlTomcat}"><img src="/AgentInfo/images/graycircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'execution' eq serviceControl.serviceControlTomcat}">실행</c:if>
						<c:if test="${'notRunning' eq serviceControl.serviceControlTomcat}">미실행</c:if>
						<c:if test="${'notInstalled' eq serviceControl.serviceControlTomcat}">미설치</c:if>
						<c:if test="${'unableConfirm' eq serviceControl.serviceControlTomcat}">확인불가</c:if>
					</span>
				</div>
				<c:if test="${'notInstalled' ne serviceControl.serviceControlTomcat && 'on' eq serviceControl.serviceControlPcPower}">
					<div class="logLook custom-btn">
						<button class="btn custom-btn" type="button" onclick="logInquiry('tomcat')">로그 보기</button>
					</div>
					<div class="dropdown form-control">
						<button class="btn custom-btn" type="button" id="tomcatToggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						  	상태 변경
						</button>
						<div class="dropdown-menu" aria-labelledby="tomcatToggle">
						  	<!-- Dropdown items go here -->
						  	<a class="dropdown-item tomcatToggle" href="#" data-value="run">실행</a>
						  	<a class="dropdown-item tomcatToggle" href="#" data-value="stop">중지</a>
						</div>
					</div>
				</c:if>
				<span class="form-bar"></span>
				<label class="float-label headLabel">Tomat 상태</label>
			</div>
			<c:if test="${'notInstalled' eq serviceControl.serviceControlLogServer || 'on' ne serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view">
					<div class="statusDiv form-control" id="logServerDiv">
			</c:if>
			<c:if test="${'notInstalled' ne serviceControl.serviceControlLogServer && 'on' eq serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view borderBotton">
					<div class="statusDiv" id="logServerDiv">
			</c:if>
					<c:if test="${'execution' eq serviceControl.serviceControlLogServer}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'notRunning' eq serviceControl.serviceControlLogServer}"><img src="/AgentInfo/images/yellowcircle.png" style="width:20px;"></c:if>
					<c:if test="${'notInstalled' eq serviceControl.serviceControlLogServer}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<c:if test="${'unableConfirm' eq serviceControl.serviceControlLogServer}"><img src="/AgentInfo/images/graycircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'execution' eq serviceControl.serviceControlLogServer}">실행</c:if>
						<c:if test="${'notRunning' eq serviceControl.serviceControlLogServer}">미실행</c:if>
						<c:if test="${'notInstalled' eq serviceControl.serviceControlLogServer}">미설치</c:if>
						<c:if test="${'unableConfirm' eq serviceControl.serviceControlLogServer}">확인불가</c:if>
					</span>
				</div>
				<c:if test="${'notInstalled' ne serviceControl.serviceControlLogServer && 'on' eq serviceControl.serviceControlPcPower}">
					<div class="logLook custom-btn">
						<button class="btn custom-btn" type="button" onclick="logInquiry('logServer')">로그 보기</button>
					</div>
					<div class="dropdown form-control">
						<button class="btn custom-btn" type="button" id="logServerToggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						  	상태 변경
						</button>
						<div class="dropdown-menu" aria-labelledby="logServerToggle">
						  	<!-- Dropdown items go here -->
						  	<a class="dropdown-item logServerToggle" href="#" data-value="run">실행</a>
						  	<a class="dropdown-item logServerToggle" href="#" data-value="stop">중지</a>
						</div>
					</div>
				</c:if>
				<span class="form-bar"></span>
				<label class="float-label headLabel">LogServer 상태</label>
			</div>
			<c:if test="${'notInstalled' eq serviceControl.serviceControlScvEA || 'on' ne serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view">
					<div class="statusDiv form-control" id="scvEADiv">
			</c:if>
			<c:if test="${'notInstalled' ne serviceControl.serviceControlScvEA && 'on' eq serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view borderBotton">
					<div class="statusDiv" id="scvEADiv">
			</c:if>
					<c:if test="${'execution' eq serviceControl.serviceControlScvEA}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'notRunning' eq serviceControl.serviceControlScvEA}"><img src="/AgentInfo/images/yellowcircle.png" style="width:20px;"></c:if>
					<c:if test="${'notInstalled' eq serviceControl.serviceControlScvEA}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<c:if test="${'unableConfirm' eq serviceControl.serviceControlScvEA}"><img src="/AgentInfo/images/graycircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'execution' eq serviceControl.serviceControlScvEA}">실행</c:if>
						<c:if test="${'notRunning' eq serviceControl.serviceControlScvEA}">미실행</c:if>
						<c:if test="${'notInstalled' eq serviceControl.serviceControlScvEA}">미설치</c:if>
						<c:if test="${'unableConfirm' eq serviceControl.serviceControlScvEA}">확인불가</c:if>
					</span>
				</div>
				<c:if test="${'notInstalled' ne serviceControl.serviceControlScvEA && 'on' eq serviceControl.serviceControlPcPower}">
					<div class="logLook custom-btn">
						<button class="btn custom-btn" type="button" onclick="logInquiry('scvEA')">로그 보기</button>
					</div>
					<div class="dropdown form-control">
						<button class="btn custom-btn" type="button" id="scvEAToggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						  	상태 변경
						</button>
						<div class="dropdown-menu" aria-labelledby="scvEAToggle">
						  	<!-- Dropdown items go here -->
						  	<a class="dropdown-item scvEAToggle" href="#" data-value="run">실행</a>
						  	<a class="dropdown-item scvEAToggle" href="#" data-value="stop">중지</a>
						</div>
					</div>
				</c:if>
				<span class="form-bar"></span>
				<label class="float-label headLabel">ScvEA 상태</label>
			</div>
			<c:if test="${'notInstalled' eq serviceControl.serviceControlScvCA || 'on' ne serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view">
					<div class="statusDiv form-control" id="scvCADiv">
			</c:if>
			<c:if test="${'notInstalled' ne serviceControl.serviceControlScvCA && 'on' eq serviceControl.serviceControlPcPower}">
				<div class="form-group form-default form-static-label form-view borderBotton">
					<div class="statusDiv" id="scvCADiv">
			</c:if>
					<c:if test="${'execution' eq serviceControl.serviceControlScvCA}"><img src="/AgentInfo/images/greencircle.png" style="width:20px;"></c:if>
					<c:if test="${'notRunning' eq serviceControl.serviceControlScvCA}"><img src="/AgentInfo/images/yellowcircle.png" style="width:20px;"></c:if>
					<c:if test="${'notInstalled' eq serviceControl.serviceControlScvCA}"><img src="/AgentInfo/images/redcircle.png" style="width:20px;"></c:if>
					<c:if test="${'unableConfirm' eq serviceControl.serviceControlScvCA}"><img src="/AgentInfo/images/graycircle.png" style="width:20px;"></c:if>
					<span>
						<c:if test="${'execution' eq serviceControl.serviceControlScvCA}">실행</c:if>
						<c:if test="${'notRunning' eq serviceControl.serviceControlScvCA}">미실행</c:if>
						<c:if test="${'notInstalled' eq serviceControl.serviceControlScvCA}">미설치</c:if>
						<c:if test="${'unableConfirm' eq serviceControl.serviceControlScvCA}">확인불가</c:if>
					</span>
				</div>
				<c:if test="${'notInstalled' ne serviceControl.serviceControlScvCA && 'on' eq serviceControl.serviceControlPcPower}">
					<div class="logLook custom-btn">
						<button class="btn custom-btn" type="button" onclick="logInquiry('scvCA')">로그 보기</button>
					</div>
					<div class="dropdown form-control">
						<button class="btn custom-btn" type="button" id="scvCAToggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						  	상태 변경
						</button>
						<div class="dropdown-menu" aria-labelledby="scvCAToggle">
						  	<!-- Dropdown items go here -->
						  	<a class="dropdown-item scvCAToggle" href="#" data-value="run">실행</a>
						  	<a class="dropdown-item scvCAToggle" href="#" data-value="stop">중지</a>
						</div>
					</div>
				</c:if>
				<span class="form-bar"></span>
				<label class="float-label headLabel">ScvCA 상태</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
				<div class="statusDiv form-control">
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
				<span class="form-bar"></span>
				<label class="float-label headLabel">Database 상태</label>
			</div>
			<div class="form-group form-default form-static-label form-view borderBotton">
				<div class="statusDiv" id="firewallDiv">
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
			    <input type="text" id="serviceControlDisk" name="serviceControlDisk" class="form-control" value="${serviceControl.serviceControlDisk}%" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">디스크 사용량</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlMemory" name="serviceControlMemory" class="form-control" value="${serviceControl.serviceControlMemory}%" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">메모리 사용량</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlJavaVersion" name="serviceControlJavaVersion" class="form-control" value="${serviceControl.serviceControlJavaVersion}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">자바 버전</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlTomcatVersion" name="serviceControlTomcatVersion" class="form-control" value="${serviceControl.serviceControlTomcatVersion}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">톰켓 버전</label>
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
    	$('.tomcatToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("tomcat", selectedValue);
    	});

		$('.logServerToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("logServer", selectedValue);
    	});

		$('.scvEAToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("scvEA", selectedValue);
    	});

		$('.scvCAToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("scvCA", selectedValue);
    	});

		$('.firewallToggle').on('click', function() {
		    var selectedValue = $(this).data('value');
			statusChange("firewall", selectedValue);
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

