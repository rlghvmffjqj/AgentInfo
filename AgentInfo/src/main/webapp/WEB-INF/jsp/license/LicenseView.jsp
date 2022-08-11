<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 650px;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%;height: 30px; text-align: center;">
			<div class="form-check radioDate">
			<input class="form-check-input" type="radio" name="licenseType" id="Linux" value="Linux" checked>
			  <label class="form-check-label" for="Linux">
			    Linux
			  </label>
			</div>
			<div class="form-check radioDate">
			  <input class="form-check-input" type="radio" name="licenseType" id="Window" value="Window">
			  <label class="form-check-label" for="Window">
			    Window
			  </label>
			</div>
		</div>
		<div class="leftDiv">
			 <div class="pading5Width450">
	         	<label class="labelFontSize">업체명</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotCustomerName" style="display: none; line-height: initial; float: right;">업체명을 입력해주세요.</span>
	         	<input type="text" id="customerNameView" name="customerNameView" class="form-control viewForm">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">사업명 / 설치 사유</label>
	         	<input type="text" id="businessNameView" name="businessNameView" class="form-control viewForm">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">발급일자</label>
	         	<input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="requesterView" name="requesterView" class="form-control viewForm">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">협력사</label>
	         	<input type="text" id="partnersView" name="partnersView" class="form-control viewForm">
	         </div>
	         <div style="height: 10px; border-bottom: darkgray 1px dashed;"></div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">기간</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotPeriod" style="display: none; line-height: initial; float: right;">기간을 입력해주세요.</span>
	         	<input type="text" id="periodView" name="periodView" class="form-control viewForm">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">MAC / UML / HostId</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotMacUmlHostId" style="display: none; line-height: initial; float: right;">정보를 입력해주세요.</span>
	         	<input type="text" id="macUmlHostIdView" name="macUmlHostIdView" class="form-control viewForm">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">릴리즈 타입</label>
				<select class="form-control selectpicker" id="releaseTypeView" name="releaseTypeView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="Normal">Normal</option>
					<option value="Test">Test</option>
					<option value="Disable">Disable</option>
				</select>
			</div>
			<div class="pading5Width450">
		    	<label class="labelFontSize">전달 방법</label>
		    	<select class="form-control selectpicker" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="메일">메일</option>
					<option value="대용량 메일">대용량 메일</option>
					<option value="CD">CD</option>
					<option value="점프호스트">점프호스트</option>
				</select>
		    </div>
	    </div>
        <div class="rightDiv">
        	<div class="pading5Width450">
	        	<label class="labelFontSize">OS</label><label class="colorRed">*</label>
	        	<span class="colorRed licenseShow" id="NotOsType" style="display: none; line-height: initial; float: right;">OS종류를 선택해주세요.</span>
				<select class="form-control selectpicker" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="Linux">Linux</option>
					<option value="Windows">Windows</option>
					<option value="AIX">AIX</option>
					<option value="HP-UX">HP-UX</option>
					<option value="MAC">MAC</option>
					<option value="Solaris">Solaris</option>
				</select>
			</div>
			<div class="pading5Width450">
	         	<label class="labelFontSize">OS 버전</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotOsVersion" style="display: none; line-height: initial; float: right;">OS 버전을 입력해주세요.</span>
	         	<input type="text" id="osVersionView" name="osVersionView" class="form-control viewForm">
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">커널버전</label><label class="colorRed">*</label>
	        	<span class="colorRed licenseShow" id="NotKernelVersion" style="display: none; line-height: initial; float: right;">커널 버전을 선택해주세요.</span>
				<select class="form-control selectpicker" id="kernelVersionView" name="kernelVersionView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="64">64</option>
					<option value="32">32</option>
				</select>
			</div>
			<div class="pading5Width450">
	         	<label class="labelFontSize">TOS 버전</label>
	         	<input type="text" id="tosVersionView" name="tosVersionView" class="form-control viewForm">
	        </div>
        </div>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn">발급</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 라이센스 발급 ========= */
	$('#insertBtn').click(function() {
		var customerName = $('#customerNameView').val();
		var osType = $('#osTypeView').val();
		var osVersion = $('#osVersionView').val();
		var kernelVersion = $('#kernelVersionView').val();
		var period = $('#periodView').val();
		var macUmlHostId = $('#macUmlHostIdView').val();
		
		var licenseType = $('input[name=licenseType]:checked').val();
		
		$('.licenseShow').hide();
		if(customerName == "") {
			$('#NotCustomerName').show();
		} else if(osType == ""){
			$('#NotOsType').show();
		} else if(osVersion == ""){
			$('#NotOsVersion').show();
		} else if(kernelVersion == ""){
			$('#NotKernelVersion').show();
		} else if(period == ""){
			$('#NotPeriod').show();
		} else if(macUmlHostId == ""){
			$('#NotMacUmlHostId').show();
		} else { 
			var postData = $('#modalForm').serializeObject();
			console.log(licenseType);
			if(licenseType == 'Linux') {
				$.ajax({
					url: "<c:url value='/license/linuxIssued'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
						if(result.result == "FALSE") {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '라이센스 발급에 실패하였습니다.',
							});
						} else {
							Swal.fire({
								icon: 'success',
								title: '라이센스 발급!',
								text: result.result,
							});
							$('#modal').modal("hide"); // 모달 닫기
			        		$('#modal').on('hidden.bs.modal', function () {
			        			tableRefresh();
			        		});
						}
					},
					error: function(error) {
						console.log(error);
					}
			    });
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/license/windowIssued'/>",
				    data: postData,
				    async: false,
				    success: function (data) {
				    	$('#modal').modal("hide"); // 모달 닫기
				    	setTimeout(function() {
				        	$.modal(data, 'ssl'); //modal창 호출
				    	},300)
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});		
			}
		}
	});
</script>