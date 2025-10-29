<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" id="modalConfirm" style="width: 100%; height: 340px;">
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">고객사명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.customerNameView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">사업명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.businessNameView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">추가정보 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.additionalInformationView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">MAC주소 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.macAddressView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">제품명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.productNameView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">제품 버전 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.productVersionView}</span></div></div>

	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">에이전트 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.agentCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.agentCountView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">에이전트리스 수량 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.agentLisCountView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.agentLisCountView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">발급일 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.issueDateView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">만료일 : </span></div><div class="confirmRightDiv"><c:if test="${empty license.expirationDaysView}"><span class="confirmText">무제한</span></c:if><span class="confirmText">${license.expirationDaysView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">라이선스 파일명 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.licenseFilePathView}</span></div></div>
	<div class="confirmDiv"><div class="confirmLeftDiv"><span class="confirmTitle">요청자 : </span></div><div class="confirmRightDiv"><span class="confirmText">${license.requesterView}</span></div></div>
	
	<form id="confirmForm" name="form" method ="post">
		<input type="hidden" id="logGriffinKeyNum" name="logGriffinKeyNum" value="${license.logGriffinKeyNum}">
		<input type="hidden" id="customerNameView" name="customerNameView" value="${license.customerNameView}">
		<input type="hidden" id="businessNameView" name="businessNameView" value="${license.businessNameView}">
		<input type="hidden" id="additionalInformationView" name="additionalInformationView" value="${license.additionalInformationView}">
		<input type="hidden" id="productNameView" name="productNameView" value="${license.productNameView}">
		<input type="hidden" id="productVersionView" name="productVersionView" value="${license.productVersionView}">
		<input type="hidden" id="macAddressView" name="macAddressView" value="${license.macAddressView}">

		<input type="hidden" id="agentCountView" name="agentCountView" value="${license.agentCountView}">
		<input type="hidden" id="agentLisCountView" name="agentLisCountView" value="${license.agentLisCountView}">
		<input type="hidden" id="issueDateView" name="issueDateView" value="${license.issueDateView}">
		<input type="hidden" id="expirationDaysView" name="expirationDaysView" value="${license.expirationDaysView}">
		<input type="hidden" id="licenseFilePathView" name="licenseFilePathView" value="${license.licenseFilePathView}">
		<input type="hidden" id="requesterView" name="requesterView" value="${license.requesterView}">
		<input type="hidden" id="requesterId" name="requesterId" value="${license.requesterId}">
		<input type="hidden" id="salesManagerId" name="salesManagerId" value="${license.salesManagerId}">
		<input type="hidden" id="serialNumberView" name="serialNumberView" value="${license.serialNumberView}">
		<input type="hidden" id="chkLicenseIssuance" name="chkLicenseIssuance" value="${license.chkLicenseIssuance}">
		<input type="hidden" id="licenseTypeView" name="licenseTypeView" value="${license.licenseTypeView}">

		<input type="hidden" id="viewType" name="viewType" value="issuedback">
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'issued'}">
			<button class="btn btn-default btn-outline-info-add" onClick="BtnConfirmInsert()">발급</button>
			<button class="btn btn-default btn-outline-info-nomal" onClick="BtnIssuedConfirmCancel()">닫기</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" onClick="BtnConfirmUpdate()">발급</button>
			<button class="btn btn-default btn-outline-info-nomal" onClick="BtnUpdateConfirmCancel()">닫기</button>
		</c:when>
    </c:choose>
</div>

<script>
	function BtnConfirmInsert() {
		var postData = $('#confirmForm').serializeObject();
		var licenseFilePath = $('#licenseFilePathView').val();
		var chkLicenseIssuance = $('#chkLicenseIssuance').val();
		var licenseType = $('#licenseTypeView').val();
		$.ajax({
			url: "<c:url value='/loggriffin/loggriffinIssued'/>",
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
		    				location.href="<c:url value='/loggriffin/fileDownload'/>?licenseFilePath="+encodeURIComponent(licenseFilePath);
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
		    url: "<c:url value='/loggriffin/issuedBackView'/>",
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'll'); //modal창 호출
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
			url: "<c:url value='/loggriffin/loggriffinUpdate'/>",
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
		    				location.href="<c:url value='/loggriffin/fileDownload'/>?licenseFilePath="+encodeURIComponent(licenseFilePath);
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
		    url: "<c:url value='/loggriffin/updateBackView'/>",
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'll'); //modal창 호출
		    	},300)
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});		
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
