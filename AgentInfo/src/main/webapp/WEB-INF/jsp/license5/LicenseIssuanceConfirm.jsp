<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" id="modalConfirm" style="width: 100%; height: 600px;">
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">고객사명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.customerNameView}</span></div></div>
	<div class="oldLicense">
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">사업명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.businessNameView}</span></div></div>
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">추가정보 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.additionalInformationView}</span></div></div>
	</div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">제품유형 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.productTypeView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">MAC주소 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.macAddressView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">시작일 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.issueDateView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">만료일 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.expirationDaysView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.expirationDaysView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">iGRIFFIN Agent 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.igriffinAgentCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.igriffinAgentCountView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">TOS 5.0 Agent 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.tos5AgentCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.tos5AgentCountView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">TOS 2.0 Agent 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.tos2AgentCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.tos2AgentCountView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">DBMS 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.dbmsCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.dbmsCountView}</span></div></div>
	<div class="oldLicense">
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">Network 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.networkCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.networkCountView}</span></div></div>
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">AIX(OS) 수량 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.aixCountView}</span></div></div>
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">HPUX(OS) 수량 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.hpuxCountView}</span></div></div>
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">Solaris(OS) 수량 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.solarisCountView}</span></div></div>
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">Linux(OS) 수량 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.linuxCountView}</span></div></div>
		<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">Windows(OS) 수량 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.windowsCountView}</span></div></div>
	</div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">관리서버 OS : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.managerOsTypeView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">관리서버 DBMS : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.managerDbmsTypeView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">국가 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.countryView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">제품번호 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.productVersionView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">라이선스 파일명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.licenseFilePathView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">요청자 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.requesterView}</span></div></div>
	
	<form id="confirmForm" name="form" method ="post">
		<input type="hidden" id="licenseKeyNum" name="licenseKeyNum" value="${license.licenseKeyNum}">
		<input type="hidden" id="customerNameView" name="customerNameView" value="${license.customerNameView}">
		<input type="hidden" id="businessNameView" name="businessNameView" value="${license.businessNameView}">
		<input type="hidden" id="additionalInformationView" name="additionalInformationView" value="${license.additionalInformationView}">
		<input type="hidden" id="productTypeView" name="productTypeView" value="${license.productTypeView}">
		<input type="hidden" id="macAddressView" name="macAddressView" value="${license.macAddressView}">
		<input type="hidden" id="issueDateView" name="issueDateView" value="${license.issueDateView}">
		<input type="hidden" id="expirationDaysView" name="expirationDaysView" value="${license.expirationDaysView}">
		<input type="hidden" id="igriffinAgentCountView" name="igriffinAgentCountView" value="${license.igriffinAgentCountView}">
		<input type="hidden" id="tos5AgentCountView" name="tos5AgentCountView" value="${license.tos5AgentCountView}">
		<input type="hidden" id="tos2AgentCountView" name="tos2AgentCountView" value="${license.tos2AgentCountView}">
		<input type="hidden" id="dbmsCountView" name="dbmsCountView" value="${license.dbmsCountView}">
		<input type="hidden" id="networkCountView" name="networkCountView" value="${license.networkCountView}">
		<input type="hidden" id="aixCountView" name="aixCountView" value="${license.aixCountView}">
		<input type="hidden" id="hpuxCountView" name="hpuxCountView" value="${license.hpuxCountView}">
		<input type="hidden" id="solarisCountView" name="solarisCountView" value="${license.solarisCountView}">
		<input type="hidden" id="linuxCountView" name="linuxCountView" value="${license.linuxCountView}">
		<input type="hidden" id="windowsCountView" name="windowsCountView" value="${license.windowsCountView}">
		<input type="hidden" id="managerOsTypeView" name="managerOsTypeView" value="${license.managerOsTypeView}">
		<input type="hidden" id="managerDbmsTypeView" name="managerDbmsTypeView" value="${license.managerDbmsTypeView}">
		<input type="hidden" id="countryView" name="countryView" value="${license.countryView}">
		<input type="hidden" id="productVersionView" name="productVersionView" value="${license.productVersionView}">
		<input type="hidden" id="licenseFilePathView" name="licenseFilePathView" value="${license.licenseFilePathView}">
		<input type="hidden" id="requesterView" name="requesterView" value="${license.requesterView}">
		<input type="hidden" id="chkLicenseIssuance" name="chkLicenseIssuance" value="${license.chkLicenseIssuance}">
		<input type="hidden" id="serialNumberView" name="serialNumberView" value="${license.serialNumberView}">
		<input type="hidden" id="licenseTypeView" name="licenseTypeView" value="${license.licenseTypeView}">
		<input type="hidden" id="viewType" name="viewType" value="issuedback">
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'issued'}">
			<c:if test="${license.licenseTypeView eq '(신)'}">
				<button class="btn btn-default btn-outline-info-add" onClick="BtnConfirmInsert()">발급</button>
			</c:if>
			<c:if test="${license.licenseTypeView eq '(구)'}">
				<button class="btn btn-default btn-outline-info-add" onClick="BtnConfirmInsert()">발급</button>
			</c:if>
			<button class="btn btn-default btn-outline-info-nomal" onClick="BtnIssuedConfirmCancel()">닫기</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<c:if test="${license.licenseTypeView eq '(신)'}">
				<button class="btn btn-default btn-outline-info-add" onClick="BtnConfirmUpdate()">발급</button>
			</c:if>
			<c:if test="${license.licenseTypeView eq '(구)'}">
				<button class="btn btn-default btn-outline-info-add" onClick="BtnConfirmUpdate()">발급</button>
			</c:if>
			<button class="btn btn-default btn-outline-info-nomal" onClick="BtnUpdateConfirmCancel()">닫기</button>
		</c:when>
    </c:choose>
</div>
<script>
	if("${license.licenseTypeView}" == "(구)") {
		$('.oldLicense').css("display","none");
		$('#modalConfirm').css('height','420px');
	}
</script>
<style>
	.confirmTitle {
		font-size : 12px;
		font-weight: 600;
	}
	
	.confirmText {
		font-size : 12px;
	}	
	
	.confirmLeftDiv {
		float : left;
		width: 40%;
	}
	
	.confirmRightDiv {
		float : right;
		width: 60%;
	}
	
	.confirmDiv {
		height: 25px;
	}
</style>

<script>
	function BtnConfirmInsert() {
		var postData = $('#confirmForm').serializeObject();
		var licenseFilePath = $('#licenseFilePathView').val();
		var chkLicenseIssuance = $('#chkLicenseIssuance').val();
		var licenseType = $('#licenseTypeView').val();
		$.ajax({
			url: "<c:url value='/license5/linuxIssued50'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function(result) {
				if(result.result == "FALSE") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '라이선스 발급에 실패하였습니다.',
					});
				} else if(result.result == "NotRoute" || result.result == "NotIp") {
					Swal.fire({
						icon: 'error',
						title: '경로 설정!',
						text: '경로 및 IP 설정 후 라이선스 발급 바랍니다.',
					});
				} else if(result.result == "NOTCONNECT") {
		        		Swal.fire({
							icon: 'error',
							title: '연결 실패!',
							text: '서버 연결에 실패하였습니다.',
						});
				} else if(result.result == "Duplication") {
		        	Swal.fire({
						icon: 'error',
						title: '일련번호 중복!',
						text: '일련번호가 동일한 데이터가 존재합니다.',
					});
				} else if(result.result == "NotMacAddress") {
		        	Swal.fire({
						icon: 'error',
						title: 'MAC 주소 확인!',
						text: 'MAC주소가 형식에 어긋납니다.',
					});
				} else {
					Swal.fire({
						icon: 'success',
						title: '라이선스 발급!',
						text: result.result,
					});
					$('#modal').modal("hide"); // 모달 닫기
		    		$('#modal').on('hidden.bs.modal', function () {
		    			if(chkLicenseIssuance == "on")
		    				location.href="<c:url value='/license5/fileDownload'/>?licenseFilePath="+encodeURIComponent(licenseFilePath)+"&licenseType="+licenseType;
		    			tableRefresh();
		    		});
				}
			},
			error: function(error) {
				console.log(error);
			}
		});
	}
	
	function BtnIssuedConfirmCancel() {
		var postData = $('#confirmForm').serializeObject();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/license5/issuedBackView'/>",
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'license5'); //modal창 호출
		    	},300)
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});		
	}
	
	function BtnConfirmUpdate() {
		var postData = $('#confirmForm').serializeObject();
		var licenseFilePath = $('#licenseFilePathView').val();
		var chkLicenseIssuance = $('#chkLicenseIssuance').val();
		var licenseType = $('#licenseTypeView').val();
		$.ajax({
			url: "<c:url value='/license5/linuxUpdate50'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function(result) {
				if(result.result == "FALSE") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '라이선스 발급에 실패하였습니다.',
					});
				} else if(result.result == "NotRoute" || result.result == "NotIp") {
					Swal.fire({
						icon: 'error',
						title: '경로 설정!',
						text: '경로 및 IP 설정 후 라이선스 발급 바랍니다.',
					});
				} else if(result.result == "NOTCONNECT") {
		        		Swal.fire({
							icon: 'error',
							title: '연결 실패!',
							text: '서버 연결에 실패하였습니다.',
						});
				} else if(result.result == "Duplication") {
		        	Swal.fire({
						icon: 'error',
						title: '일련번호 중복!',
						text: '일련번호가 동일한 데이터가 존재합니다.',
					});
				} else if(result.result == "NotMacAddress") {
		        	Swal.fire({
						icon: 'error',
						title: 'MAC 주소 확인!',
						text: 'MAC주소가 형식에 어긋납니다.',
					});
				} else {
					Swal.fire({
						icon: 'success',
						title: '라이선스 수정 발급!',
						text: result.result,
					});
					$('#modal').modal("hide"); // 모달 닫기
		    		$('#modal').on('hidden.bs.modal', function () {
		    			if(chkLicenseIssuance == "on")
		    				location.href="<c:url value='/license5/fileDownload'/>?licenseFilePath="+encodeURIComponent(licenseFilePath)+"&licenseType="+licenseType;
		    			tableRefresh();
		    		});
				}
			},
			error: function(error) {
				console.log(error);
			}
		});
	}
	
	function BtnUpdateConfirmCancel() {
		var postData = $('#confirmForm').serializeObject();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/license5/updateBackView'/>",
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'license5'); //modal창 호출
		    	},300)
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});		
	}

	function BtnConfirmOldInsert() {
		
	}
</script>
