<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
<script>
	$(document).ready(function(){
		var formData = $('#formHost').serializeObject();
		$("#listHost").jqGrid({
			url: "<c:url value='/serviceControlHost'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['Key','서버종류','사용 목적','서버 IP'],
			colModel:[
				{name:'serviceControlMemory', index:'serviceControlMemory', align:'center', width: 80},
				{name:'serviceControlFirewall', index:'serviceControlFirewall', align:'center', width: 70, formatter: firewallFormatter},
				{name:'serviceControlJavaVersion', index:'serviceControlJavaVersion',align:'center', width: 100},
				{name:'serviceControlTomcatVersion', index:'serviceControlTomcatVersion',align:'center', width: 100}
			],
			jsonReader : {
				id: 'serviceControlKeyNum',
				repeatitems: false
			},
			pager: '#pager',			// 페이징
			rowNum: 25,					// 보여중 행의 수
			sortname: 'serviceControlKeyNum', 		// 기본 정렬 
			sortorder: 'desc',			// 정렬 방식
			
			multiselect: true,			// 체크박스를 이용한 다중선택
			viewrecords: false,			// 시작과 끝 레코드 번호 표시
			gridview: true,				// 그리드뷰 방식 랜더링
			sortable: true,				// 컬럼을 마우스 순서 변경
			height : '670',
			autowidth:true,				// 가로 넒이 자동조절
			shrinkToFit: false,			// 컬럼 폭 고정값 유지
			altRows: false,				// 라인 강조
		}); 
	 });
	
	$(window).on('resize.list', function () {
		jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
	});
</script>

<div class="modal-body" style="width: 100%; height: 770px; padding-top: 3%;">
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
			    <input type="text" id="serviceControlRelease" name="serviceControlRelease" class="form-control" value="${serviceControl.serviceControlRelease}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">릴리즈 정보</label>
			</div>
			<div class="form-group form-default form-static-label form-view">
			    <input type="text" id="serviceControlKernel" name="serviceControlKernel" class="form-control" value="${serviceControl.serviceControlKernel}" disabled>
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">커널 정보</label>
			</div>
			<div class="hostListDiv" style="overflow: auto;">
				<c:forEach var="serviceControlHost" items="${serviceControlHostList}">
        		    <div class="form-check leftMargin">
						<label class="form-check-label" style="width: 50%;">${serviceControlHost.vmName}</label>
						<label class="form-check-label" style="width: 15%;">${serviceControlHost.memoryAssigned}</label>
						<label class="form-check-label" style="width: 15%;">${serviceControlHost.uptime}</label>
						<select class="form-control viewForm" id="state" name="state">
							<option value="Running" <c:if test="${serviceControlHost.state eq 'Running'}">selected</c:if>>실행</option>
							<option value="Saved" <c:if test="${serviceControlHost.state eq 'Saved'}">selected</c:if>>저장</option>
							<option value="Off" <c:if test="${serviceControlHost.state eq 'Off'}">selected</c:if>>꺼짐</option>
						</select>
        		    </div>
        		</c:forEach>
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

	$("select").change(function() {
		var vmName = $(this).siblings("label:first").text();
		var state = $(this).val();
		var ip = "${serviceControl.serviceControlIp}";
		
		Swal.fire({
			  title: '변경!',
			  text: "가상 서버 상태를 변경하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#7066e0',
			  cancelButtonColor: '#FF99AB',
			  confirmButtonText: 'OK'
		}).then((result) => {
		  	if (result.isConfirmed) {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/serviceControl/hostRunModChange'/>",
					data: {
						"vmName": vmName,
						"state": state,
						"ip": ip
					},
				    async: false,
				    success: function (data) {
						if(data == "FALSE") {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: "작업 실패 하였습니다.",
							});
						} else {
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: "가상 서버 상태 변경 완료!",
							});
						}
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});
			}
		})
	});

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

	.hostListDiv {
		width: 100%;
    	height: 350px;
    	float: inline-start;
	}
 
	.leftMargin {
		padding-left: 20px;
	}

	.leftMargin:hover {
		background-color: #d3b57e;
		color: white;
	}

	.form-check {
		margin-bottom: 0;
		padding-bottom: 0.1rem;
		padding-top: 0.1rem;
	}

	.viewForm {
		margin-bottom: 0px;
    	width: 12% !important;
    	text-align: center;
	}
</style>

