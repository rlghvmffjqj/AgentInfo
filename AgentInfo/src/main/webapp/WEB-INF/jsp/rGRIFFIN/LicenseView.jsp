<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 330px;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 25px; border-bottom: dashed 1px silver; float:left"></div>
		<div class="leftDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">고객사명</label>
			 	<input type="text" id="rGRIFFINCompanyView" name="rGRIFFINCompanyView" class="form-control viewForm" value="${license.rGRIFFINCompany}">
			</div>
			<div class="pading5Width450">
				<label class="labelFontSize">카테고리</label>
			 	<input type="text" id="rGRIFFINCategoryView" name="rGRIFFINCategoryView" class="form-control viewForm" value="${license.rGRIFFINCategory}">
			</div>
	        <div class="pading5Width450">
				<label class="labelFontSize">만료일</label>
				<input type="text" id="rGRIFFINExpireView" name="rGRIFFINExpireView" class="form-control viewForm" value="${license.rGRIFFINExpire}" placeholder="YYYY-MM-DD hh:mm:ss">
		    </div>
			 <div class="pading5Width450">
				<label class="labelFontSize">수량</label>
				 <div style="width: 100%">
					<input type="number" id="rGRIFFINQuantityView" name="rGRIFFINQuantityView" class="form-control viewForm" maxlength="4" pattern="\d{4}" placeholder="YYMM" value="${license.rGRIFFINQuantity}">
				 </div>
			 </div>
	    </div>
        <div class="rightDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">RGMSID</label>
				<input type="text" id="rGRIFFINRgmsidView" name="rGRIFFINRgmsidView" class="form-control viewForm" value="${license.rGRIFFINRgmsid}">
		   </div>
		   <div class="pading5Width450">
				<label class="labelFontSize">비밀번호</label>
				<input type="text" id="rGRIFFINPasswordView" name="rGRIFFINPasswordView" class="form-control viewForm" value="zaq1@WSX3">
		   </div>
			<div class="pading5Width450">
				<label class="labelFontSize">라이선스 파일명</label>
				<input type="text" id="rGRIFFINFilePathView" name="rGRIFFINFilePathView" class="form-control viewForm" placeholder="파일명.xml(yml)" value="${license.rGRIFFINFilePath}">
		   </div>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="rGRIFFINRequesterView" name="rGRIFFINRequesterView" class="form-control viewForm" value="${license.rGRIFFINRequester}">
	        </div>
        </div>
        <input type="hidden" id="rGRIFFINKeyNum" name="rGRIFFINKeyNum" value="${license.rGRIFFINKeyNum}">
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
			url: "<c:url value='/rGRIFFIN/licenseIssuance'/>",
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
			url: "<c:url value='/rGRIFFIN/licenseUpdate'/>",
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