<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 330px;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 25px; border-bottom: dashed 1px silver; float:left"></div>
		<div class="leftDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">발급날짜</label>
			 	<input type="text" id="secuveOTPCreatedView" name="secuveOTPCreatedView" class="form-control viewForm" placeholder="YYYY-MM-DD hh:mm:ss" value="${license.secuveOTPCreated}">
			</div>
			<div class="pading5Width450">
				<label class="labelFontSize">사이트</label>
			 	<input type="text" id="secuveOTPSiteView" name="secuveOTPSiteView" class="form-control viewForm" value="${license.secuveOTPSite}">
			</div>
	        <div class="pading5Width450">
				<label class="labelFontSize">MAC</label>
				<input type="text" id="secuveOTPMacView" name="secuveOTPMacView" class="form-control viewForm" value="${license.secuveOTPMac}" placeholder="00:1A:2B:3C:4D:5E">
		    </div>
			 <div class="pading5Width450">
				<label class="labelFontSize">만료일</label>
				 <div style="width: 100%">
					<input type="text" id="secuveOTPExpireymView" name="secuveOTPExpireymView" class="form-control viewForm" maxlength="4" pattern="\d{4}" placeholder="YYMM" value="${license.secuveOTPExpireym}">
				 </div>
			 </div>
	    </div>
        <div class="rightDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">라이선스</label>
				<input type="text" id="secuveOTPLicenseView" name="secuveOTPLicenseView" class="form-control viewForm" value="${license.secuveOTPLicense}">
		   </div>
		   <div class="pading5Width450">
				<label class="labelFontSize">비고</label>
				<input type="text" id="secuveOTPBigoView" name="secuveOTPBigoView" class="form-control viewForm" value="${license.secuveOTPBigo}">
		   </div>
			<div class="pading5Width450">
				<label class="labelFontSize">라이선스 파일명</label>
				<input type="text" id="secuveOTPFilePathView" name="secuveOTPFilePathView" class="form-control viewForm" placeholder="파일명.xml(yml)" value="${license.secuveOTPFilePath}">
		   </div>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="secuveOTPRequesterView" name="secuveOTPRequesterView" class="form-control viewForm" value="${license.secuveOTPRequester}">
	        </div>
        </div>
        <input type="hidden" id="secuveOTPKeyNum" name="secuveOTPKeyNum" value="${license.secuveOTPKeyNum}">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
	</form>
</div>
<div class="modal-footer">
	<c:if test="${viewType eq 'insert'}">
		<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert()">발급</button>
	</c:if>
	<c:if test="${viewType eq 'update'}">
		<button class="btn btn-default btn-outline-info-add" onClick="BtnUpdate()">수정</button>
	</c:if>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>	
	/* =========== 라이선스 발급 ========= */
	function BtnInsert() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/secuveOTP/licenseIssuance'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (result) {
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
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
		    },
			error: function(error) {
				console.log(error);
			}
		});
	};
	
	
	function BtnUpdate() {	
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/secuveOTP/licenseUpdate'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (result) {
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
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
		    },
			error: function(error) {
				console.log(error);
			}
		});
	}
</script>