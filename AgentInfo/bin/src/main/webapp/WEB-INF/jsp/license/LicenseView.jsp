<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 650px;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%;height: 30px; text-align: center;">
			<c:choose>
				<c:when test="${viewType eq 'issued'}">
					<div class="form-check radioDate">
						<input class="form-check-input" type="radio" name="licenseType" id="Windows" value="Windows" checked>
						<label class="form-check-label" for="Window">
							Windows
						</label>
					</div>
					<div class="form-check radioDate">
						<input class="form-check-input" type="radio" name="licenseType" id="Linux20" value="Linux20" >
						<label class="form-check-label" for="Linux20">
							Linux 2.0
						</label>
					</div>
					<!-- <div class="form-check radioDate">
						<input class="form-check-input" type="radio" name="licenseType" id="Linux50" value="Linux50" >
						<label class="form-check-label" for="Linux50">
							Linux 5.0
						</label>
					</div> -->
				</c:when>
				<c:when test="${viewType eq 'issuedback' || viewType eq 'copyback' || viewType eq 'copy'}">
					<div class="form-check radioDate">
						<input class="form-check-input" type="radio" name="licenseType" id="Windows" value="Windows" <c:if test="${'Windows' eq license.licenseType}">checked</c:if>>
						<label class="form-check-label" for="Window">
							Windows
						</label>
					</div>
					<div class="form-check radioDate">
						<input class="form-check-input" type="radio" name="licenseType" id="Linux20" value="Linux20" <c:if test="${'Linux20' eq license.licenseType}">checked</c:if>>
						<label class="form-check-label" for="Linux20">
							Linux 2.0
						</label>
					</div>
					<%-- <div class="form-check radioDate">
						<input class="form-check-input" type="radio" name="licenseType" id="Linux50" value="Linux50" <c:if test="${'Linux50' eq license.licenseType}">checked</c:if>>
						<label class="form-check-label" for="Linux50">
							Linux 5.0
						</label>
					</div> --%>
				</c:when>
			</c:choose>
		</div>
		<div class="leftDiv">
			 <div class="pading5Width450">
	         	<label class="labelFontSize">업체명</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotCustomerName" style="display: none; line-height: initial; float: right;">업체명을 입력해주세요.</span>
	         	<input type="text" id="customerNameView" name="customerNameView" class="form-control viewForm" value="${license.customerName}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">사업명 / 설치 사유</label>
	         	<input type="text" id="businessNameView" name="businessNameView" class="form-control viewForm" value="${license.businessName}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">발급일자</label>
	         	<input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm" value="${license.issueDate}" max="9999-12-31">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">협력사</label>
	         	<input type="text" id="partnersView" name="partnersView" class="form-control viewForm" value="${license.partners}">
	         </div>
	         <div style="height: 10px; border-bottom: darkgray 1px dashed;"></div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">기간</label><label class="colorRed">*</label>
	         	<a href="#" class="selfInput" id="periodChange" onclick="selfInput('periodChange');">직접입력</a>
	         	<span class="colorRed licenseShow" id="NotPeriod" style="display: none; line-height: initial; float: right;">기간을 입력해주세요.</span>
	         	<div id="periodViewSelf" style="display:none; width: 100%">
	         		<div style="width: 33%; float: left;">
		         		<span>년</span>
		         		<input type="number" id="periodYearSelf" name="periodYearSelf" class="form-control viewForm selfPeriod"  value="0">
		         	</div>
		         	<div style="width: 33%; float: left;">
		         		<span>월</span>
		         		<input type="number" id="periodMonthSelf" name="periodMonthSelf" class="form-control viewForm selfPeriod" value="0">
		         	</div>
		         	<div style="width: 34%; float: left;">
		         		<span>일</span>
		         		<input type="number" id="periodDaySelf" name="periodDaySelf" class="form-control viewForm selfPeriod" style="width: 100%;"  value="0">
		         	</div>
	         	</div>
	         	<div id="periodViewSelect">
		         	<select class="form-control selectpicker selectForm" id="periodView" name="periodView" data-live-search="true" data-size="5" data-actions-box="true">
						<option value="무제한" <c:if test="${'무제한' eq license.period}">selected</c:if>>무제한</option>
						<option value="1년" <c:if test="${'1년' eq license.period}">selected</c:if>>1년</option>
						<option value="5년" <c:if test="${'5년' eq license.period}">selected</c:if>>5년</option>
						<option value="10년" <c:if test="${'10년' eq license.period}">selected</c:if>>10년</option>
					</select>
				</div>
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">MAC / UML / HostId</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotMacUmlHostId" style="display: none; line-height: initial; float: right;">정보를 입력해주세요.</span>
	         	<input type="text" id="macUmlHostIdView" name="macUmlHostIdView" class="form-control viewForm" value="${license.macUmlHostId}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">릴리즈 타입</label>
				<select class="form-control selectpicker" id="releaseTypeView" name="releaseTypeView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="Normal" <c:if test="${'Normal' eq license.releaseType}">selected</c:if>>Normal</option>
					<option value="Test" <c:if test="${'Test' eq license.releaseType}">selected</c:if>>Test</option>
					<option value="Disable" <c:if test="${'Disable' eq license.releaseType}">selected</c:if>>Disable</option>
				</select>
			</div>
			<div class="pading5Width450">
		    	<label class="labelFontSize">전달 방법</label>
		    	<select class="form-control selectpicker" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="메일" <c:if test="${'메일' eq license.deliveryMethod}">selected</c:if>>메일</option>
					<option value="대용량 메일" <c:if test="${'대용량 메일' eq license.deliveryMethod}">selected</c:if>>대용량 메일</option>
					<option value="CD" <c:if test="${'CD' eq license.deliveryMethod}">selected</c:if>>CD</option>
					<option value="점프호스트" <c:if test="${'점프호스트' eq license.deliveryMethod}">selected</c:if>>점프호스트</option>
				</select>
		    </div>
	    </div>
        <div class="rightDiv">
		    <div class="pading5Width450">
				<label class="labelFontSize">OS</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotOsType" style="display: none; line-height: initial; float: right;">OS종류를 선택해주세요.</span>
				<select class="form-control selectpicker" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="Linux" <c:if test="${'Linux' eq license.osType}">selected</c:if>>Linux</option>
					<option value="Windows" <c:if test="${'Windows' eq license.osType}">selected</c:if>>Windows</option>
					<option value="AIX" <c:if test="${'AIX' eq license.osType}">selected</c:if>>AIX</option>
					<option value="HP-UX" <c:if test="${'HP-UX' eq license.osType}">selected</c:if>>HP-UX</option>
					<option value="MAC" <c:if test="${'MAC' eq license.osType}">selected</c:if>>MAC</option>
					<option value="Solaris" <c:if test="${'Solaris' eq license.osType}">selected</c:if>>Solaris</option>
				</select>
			</div>
			<div class="pading5Width450">
	         	<label class="labelFontSize">OS 버전</label>
	         	<input type="text" id="osVersionView" name="osVersionView" class="form-control viewForm" value="${license.osVersion}">
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">커널버전</label><label class="colorRed">*</label>
	        	<span class="colorRed licenseShow" id="NotKernelVersionView" style="display: none; line-height: initial; float: right;">커널버전을 입력해주세요.</span>
	        	<input type="text" id="kernelVersionView" name="kernelVersionView" class="form-control viewForm" value="${license.kernelVersion}">
			</div>
			<div class="pading5Width450">
				<label class="labelFontSize">커널비트</label><label class="colorRed">*</label>
				<select class="form-control selectpicker" id="kernelBitView" name="kernelBitView" data-live-search="true" data-size="5" data-actions-box="true">
					<option value="64" <c:if test="${'64' eq license.kernelBit}">selected</c:if>>64</option>
					<option value="32" <c:if test="${'32' eq license.kernelBit}">selected</c:if>>32</option>
				</select>
			</div>
			<div class="pading5Width450">
	         	<label class="labelFontSize">TOS 버전</label>
	         	<input type="text" id="tosVersionView" name="tosVersionView" class="form-control viewForm" value="${license.tosVersion}">
	        </div>
        </div>
        <input type="hidden" id="licenseKeyNum" name="licenseKeyNum" value="${license.licenseKeyNum}">
        <input type="hidden" id="licenseKeyNumOrigin" name="licenseKeyNumOrigin" class="form-control viewForm" value="${license.licenseKeyNumOrigin}">
        <input type="hidden" id="btnType" name="btnType">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'issued'}">
			<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert('issued')">발급</button>
			<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
		</c:when>
		<c:when test="${viewType eq 'copy'}">
			<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert('copy')">발급</button>
			<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
		</c:when>
    	<c:when test="${viewType eq 'issuedback'}">
    		<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert('issued')">발급</button>
    		<button class="btn btn-default btn-outline-info-nomal" onClick="BtnCancel()">닫기</button>
    	</c:when>
    	<c:when test="${viewType eq 'copyback'}">
    		<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert('copy')">발급</button>
    		<button class="btn btn-default btn-outline-info-nomal" onClick="BtnCancel()">닫기</button>
    	</c:when>
    </c:choose>
</div>

<script>
	if($('#viewType').val() == "issued") {
		document.getElementById('issueDateView').valueAsDate = new Date();
	}

	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 라이선스 발급 ========= */
	function BtnInsert(btnType) {
		$('#btnType').val(btnType);
		var customerName = $('#customerNameView').val();
		var osType = $('#osTypeView').val();
		var kernelVersion = $('#kernelVersionView').val();
		var period = $('#periodView').val();
		var macUmlHostId = $('#macUmlHostIdView').val();
		
		var licenseType = $('input[name=licenseType]:checked').val();
		
		$('.licenseShow').hide();
		if(customerName == "") {
			$('#NotCustomerName').show();
		} else if(osType == "") {
			$('#NotOsType').show();
		} else if(kernelVersion == "") {
			$('#NotKernelVersionView').show();			
		} else if(period == "") {
			$('#NotPeriod').show();
		} else if(macUmlHostId == "") {
			$('#NotMacUmlHostId').show();
		} else { 
			if($("#periodChange").text() == "선택입력" && $('#periodYearSelf').val() <= 0 && $('#periodMonthSelf').val() <= 0 && $('#periodDaySelf').val() <= 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '직접 입력의 경우 1일 이상의 값을 입력 바랍니다.',    
				});
			} else {
				var postData = $('#modalForm').serializeObject();
				if(licenseType == 'Linux20') {
					$.ajax({
						url: "<c:url value='/license/linuxIssued20'/>",
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
							} else if(result.result == "NotRoute") {
								Swal.fire({
									icon: 'error',
									title: '경로 설정!',
									text: '경로 설정 후 라이선스 발급 바랍니다.',
								});
				        	} else if(result.result == "NOTCONNECT") {
				        		Swal.fire({
									icon: 'error',
									title: '연결 실패!',
									text: '서버 연결에 실패하였습니다.',
								});
				        	} else {
								Swal.fire({
									icon: 'success',
									title: '라이선스 발급!',
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
				} else if(licenseType == 'Linux50') {
					$.ajax({
						url: "<c:url value='/license/linuxIssued50'/>",
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
							} else if(result.result == "NotRoute") {
								Swal.fire({
									icon: 'error',
									title: '경로 설정!',
									text: '경로 설정 후 라이선스 발급 바랍니다.',
								});
							} else if(result.result == "NOTCONNECT") {
					        		Swal.fire({
										icon: 'error',
										title: '연결 실패!',
										text: '서버 연결에 실패하였습니다.',
									});
							} else {
								Swal.fire({
									icon: 'success',
									title: '라이선스 발급!',
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
						url: "<c:url value='/license/routeCheck'/>",
					    type: 'post',
					    async: false,
					    success: function(result) {
					    	if(result.result == "OK") {
					    		$.ajax({
								    type: 'POST',
								    url: "<c:url value='/license/windowIssued'/>",
								    data: postData,
								    async: false,
								    success: function (data) {
								    	$('#modal').modal("hide"); // 모달 닫기
								    	setTimeout(function() {
								    		//if(data.indexOf("<!DOCTYPE html>") != -1) 
											//	location.reload();
								        	$.modal(data, 'ssl'); //modal창 호출
								    	},300)
								    },
								    error: function(e) {
								        // TODO 에러 화면
								    }
								});
					    	} else {
					    		Swal.fire({
									icon: 'error',
									title: '경로 설정!',
									text: '경로 설정 후 라이선스 발급 바랍니다.',
								});
					    	}
					    },
						error: function(error) {
							console.log(error);
						}
					});
				}	
			}
		}
	};
	
	/* =========== 직접입력 <--> 선택입력 변경 ========= */
	function selfInput(data) {
		if(data == "periodChange") {
			if($("#periodChange").text() == "직접입력") {
				$('#periodViewSelf').show();
				$('#periodViewSelect').hide();
				$('#periodYearSelf').val('0');
				$('#periodMonthSelf').val('0');
				$('#periodDaySelf').val('0');
				$('#periodView').val('');
				$("#periodChange").text("선택입력");
			} else if($("#periodChange").text() == "선택입력") {
				$('#periodViewSelf').hide();
				$('#periodViewSelect').show();
				$('#periodYearSelf').val('0');
				$('#periodMonthSelf').val('0');
				$('#periodDaySelf').val('0');
				$("#periodChange").text("직접입력");
			}
		}
	}
	
	/* =========== 닫기 후 닫기 ========= */
	function BtnCancel() {
		var licenseKeyNum = $('#licenseKeyNum').val();
		
		$.ajax({
			url: "<c:url value='/license/licensCancel'/>",
			type: "POST",
			data: {
					"licenseKeyNum": licenseKeyNum,
				},
			async: false,
			success: function() {
				$('#modal').modal("hide"); // 모달 닫기
				$('#modal').on('hidden.bs.modal', function () {
					tableRefresh();
				});
			},
			error: function(e) {
		    	console.log(e);
		    }
		});
	}
	
</script>