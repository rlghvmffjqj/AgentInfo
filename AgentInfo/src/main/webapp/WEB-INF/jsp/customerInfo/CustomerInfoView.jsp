<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 390px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="customerInfoKeyNum" name="customerInfoKeyNum" class="form-control viewForm" value="${customerInfo.customerInfoKeyNum}">
		<div id="customer">
			<div class="leftDivNonBord">
				<c:choose>
					<c:when test="${viewType eq 'insert'}">
						<div class="pading5Width450">
						 	<div>
						  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
						  		<!-- <a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a> -->
						  	</div>
						  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
						  	<div id="customerNameViewSelf">
							  	<select class="form-control selectpicker selectForm" id="customerName" name="customerName" data-live-search="true" data-size="5">
							  		<option value=""></option>
									<c:forEach var="item" items="${customerName}">
										<option value="${item}"><c:out value="${item}"/></option>
									</c:forEach>
								</select>
							</div>
							<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
						 </div>
						 <div class="pading5Width450">
						 	<div>
						  		<label class="labelFontSize">사업명</label>
						  		<!-- <a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a> -->
						  	</div>
						  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
						  	<div id="businessNameViewSelf">
							  	<select class="form-control selectpicker selectForm" id="businessName" name="businessName" data-live-search="true" data-size="5">
							  		<option value=""></option>
								</select>
							</div>
						 </div>
					</c:when>
					<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
						<div class="pading5Width450">
							<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
								<div>
							  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
							  		<!-- <a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a> -->
							  	</div>
							  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
							  	<div id="customerNameViewSelf">
						         	<select class="form-control selectpicker selectForm" id="customerName" name="customerName" data-live-search="true" data-size="5">
						         		<c:if test="${customerInfo.customerName ne ''}"><option value=""></option></c:if>
						         		<c:if test="${customerInfo.customerName eq ''}"><option value=""></option></c:if>
						         		<c:forEach var="item" items="${customerName}">
											<option value="${item}" <c:if test="${item eq customerNameView}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
								<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
					    	</sec:authorize>
					    	<sec:authorize access="hasRole('MEMBER')">
					    		<label class="labelFontSize">고객사명</label>
					    		<input type="text" id="customerName" name="customerName" class="form-control viewForm" value="${customerInfo.customerName}" readonly>
					    	</sec:authorize>
						</div>
					    <div class="pading5Width450">
					    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
					    		<div>
							  		<label class="labelFontSize">사업명</label>
							  		<!-- <a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a> -->
							  	</div>
							  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
							  	<div id="businessNameViewSelf">
							     	<select class="form-control selectpicker selectForm" id="businessName" name="businessName" data-live-search="true" data-size="5">
							     		<c:if test="${customerInfo.businessName ne ''}"><option value=""></option></c:if>
							     		<c:if test="${customerInfo.businessName eq ''}"><option value=""></option></c:if>
							     		<c:forEach var="item" items="${businessName}">
											<option value="${item}" <c:if test="${item eq businessNameView}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
					    	</sec:authorize>
					    	<sec:authorize access="hasRole('MEMBER')">
					    		<input type="text" id="businessName" name="businessName" class="form-control viewForm" value="${customerInfo.businessName}" readonly>
					    	</sec:authorize>
					    </div>
					</c:when>
				</c:choose>
				<div class="pading5Width450">
			    	<label class="labelFontSize">망 구분</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}" readonly>
			    	</sec:authorize>
			    </div>
			    <span class="colorRed" id="Overlap" style="display: none; line-height: initial;">동일한 사업명 및 망 구분이 존재합니다. 등록된 고객정보를 수정하여 사용 바랍니다.</span>
				<div class="pading5Width450">
			    	<label class="labelFontSize">고객사 담당자 이름</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="customerManagerName" name="customerManagerName" class="form-control viewForm" value="${customerInfo.customerManagerName}">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="customerManagerName" name="customerManagerName" class="form-control viewForm" value="${customerInfo.customerManagerName}" readonly>
			    	</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">고객사 담당자 부서</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="customerDept" name="customerDept" class="form-control viewForm" value="${customerInfo.customerDept}">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="customerDept" name="customerDept" class="form-control viewForm" value="${customerInfo.customerDept}" readonly>
			    	</sec:authorize>
			    </div>
			</div>
			<div class="rightDiv">
			    <div class="pading5Width450">
			    	<label class="labelFontSize">고객사 담당자 전화번호</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="customerPhoneNumber" name="customerPhoneNumber" class="form-control viewForm" value="${customerInfo.customerPhoneNumber}">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="customerPhoneNumber" name="customerPhoneNumber" class="form-control viewForm" value="${customerInfo.customerPhoneNumber}" readonly>
			    	</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize width100">고객사 주소</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="customerZipCode" name="customerZipCode" class="form-control viewForm zipCodeForm" value="${customerInfo.customerZipCode}" placeholder="우편번호" readonly>
			    		<input type="text" id="customerAddress" name="customerAddress" class="form-control viewForm addressFom" value="${customerInfo.customerAddress}" placeholder="주소" readonly>
			    		<button class="btn btn-primary addressButton" type="button" id="btnAddress">주소 찾기</button>
			    		<input type="text" id="customerFullAddress" name="customerFullAddress" class="form-control viewForm" value="${customerInfo.customerFullAddress}" placeholder="상세주소">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="customerZipCode" name="customerZipCode" class="form-control viewForm zipCodeForm" value="${customerInfo.customerZipCode}" placeholder="우편번호" readonly>
			    		<input type="text" id="customerAddress" name="customerAddress" class="form-control viewForm addressFom" style="width:365px" value="${customerInfo.customerAddress}" placeholder="주소" readonly>
			    		<input type="text" id="customerFullAddress" name="customerFullAddress" class="form-control viewForm" value="${customerInfo.customerFullAddress}" placeholder="상세주소" readonly>
			    	</sec:authorize>
			    	
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">엔지니어 이름</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="employeeSeName" name="employeeSeName" class="form-control viewForm" value="${customerInfo.employeeSeName}">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="employeeSeName" name="employeeSeName" class="form-control viewForm" value="${customerInfo.employeeSeName}" readonly>
			    	</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">영업사원 이름</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="employeeSalesName" name="employeeSalesName" class="form-control viewForm" value="${customerInfo.employeeSalesName}">
			    	</sec:authorize>
			    	<sec:authorize access="hasRole('MEMBER')">
			    		<input type="text" id="employeeSalesName" name="employeeSalesName" class="form-control viewForm" value="${customerInfo.employeeSalesName}" readonly>
			    	</sec:authorize>
			    </div>
			</div>
		</div>
		<div id="product" style="display:none">
			<div class="leftDivNonBord">
				<div class="marginLeft22 displayFlex">
					<div class="form-check checkBox">
						<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
							<input class="form-check-input" type="checkbox" value="tosms" id="tosms" name="productCheck" checked>
						</sec:authorize>
						<sec:authorize access="hasRole('MEMBER')">
							<input class="form-check-input" type="checkbox" value="tosms" id="tosms" name="productCheck" checked disabled>
						</sec:authorize>
						<label class="form-check-label" for="productCheck">
							TOSMS
						</label>
					</div>
					<div class="form-check checkBox marginLeft55">
						<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
							<input class="form-check-input" type="checkbox" value="tosrf" id="tosrf" name="productCheck">
						</sec:authorize>
						<sec:authorize access="hasRole('MEMBER')">
							<input class="form-check-input" type="checkbox" value="tosrf" id="tosrf" name="productCheck" disabled>
						</sec:authorize>
						<label class="form-check-label" for="productCheck">
							TOSRF
						</label>
					</div>
					<div class="form-check checkBox marginLeft55">
						<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
							<input class="form-check-input" type="checkbox" value="portal" id="portal" name="productCheck">
						</sec:authorize>
						<sec:authorize access="hasRole('MEMBER')">
							<input class="form-check-input" type="checkbox" value="portal" id="portal" name="productCheck" disabled>
						</sec:authorize>
						<label class="form-check-label" for="productCheck">
							PORTAL
						</label>
					</div>
				</div>
				<div class="outLine">
					<div class="pading5Width450" id="tosmsVerDiv">
				    	<label class="labelFontSize">TOSMS</label>
				    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
				    		<input type="text" id="tosmsVer" name="tosmsVer" class="form-control viewForm marginBottom1" value="${customerInfo.tosmsVer}">
				    	</sec:authorize>
						<sec:authorize access="hasRole('MEMBER')">	
							<input type="text" id="tosmsVer" name="tosmsVer" class="form-control viewForm marginBottom1" value="${customerInfo.tosmsVer}" readonly>
						</sec:authorize>
				    </div>
				    <div class="pading5Width450 displayNone" id="tosrfVerDiv">
				    	<label class="labelFontSize">TOSRF</label>
				    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
				    		<input type="text" id="tosrfVer" name="tosrfVer" class="form-control viewForm marginBottom1" value="${customerInfo.tosrfVer}">
				    	</sec:authorize>
						<sec:authorize access="hasRole('MEMBER')">
							<input type="text" id="tosrfVer" name="tosrfVer" class="form-control viewForm marginBottom1" value="${customerInfo.tosrfVer}" readonly>
						</sec:authorize>	
				    </div>
				    <div class="pading5Width450 displayNone" id="portalVerDiv">
				    	<label class="labelFontSize">PORTAL</label>
				    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
				    		<input type="text" id="portalVer" name="portalVer" class="form-control viewForm marginBottom1" value="${customerInfo.portalVer}">
				    	</sec:authorize>
						<sec:authorize access="hasRole('MEMBER')">
							<input type="text" id="portalVer" name="portalVer" class="form-control viewForm marginBottom1" value="${customerInfo.portalVer}" readonly>
						</sec:authorize>
				    </div>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">OS타입</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="osType" name="osType" class="form-control viewForm" value="${customerInfo.osType}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">			    
				    	<input type="text" id="osType" name="osType" class="form-control viewForm" value="${customerInfo.osType}" readonly>
				    </sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">JAVA</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="javaVer" name="javaVer" class="form-control viewForm" value="${customerInfo.javaVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">			    
				    	<input type="text" id="javaVer" name="javaVer" class="form-control viewForm" value="${customerInfo.javaVer}" readonly>
				    </sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">WebServer</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="webServerVer" name="webServerVer" class="form-control viewForm" value="${customerInfo.webServerVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">	
						<input type="text" id="webServerVer" name="webServerVer" class="form-control viewForm" value="${customerInfo.webServerVer}" readonly>
					</sec:authorize>
			    </div>
			</div>
			<div class="rightDiv">
			    <div class="pading5Width450">
			    	<label class="labelFontSize">Database</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="employeeSeName" name="databaseVer" class="form-control viewForm" value="${customerInfo.databaseVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="employeeSeName" name="databaseVer" class="form-control viewForm" value="${customerInfo.databaseVer}" readonly>
					</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">LogServer</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="logServerVer" name="logServerVer" class="form-control viewForm" value="${customerInfo.logServerVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="logServerVer" name="logServerVer" class="form-control viewForm" value="${customerInfo.logServerVer}" readonly>
					</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">ScvEA</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="scvEaVer" name="scvEaVer" class="form-control viewForm" value="${customerInfo.scvEaVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="scvEaVer" name="scvEaVer" class="form-control viewForm" value="${customerInfo.scvEaVer}" readonly>
					</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">ScvCA</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="scvCaVer" name="scvCaVer" class="form-control viewForm" value="${customerInfo.scvCaVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="scvCaVer" name="scvCaVer" class="form-control viewForm" value="${customerInfo.scvCaVer}" readonly>
					</sec:authorize>
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">Auth/PKI</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="authPkiVer" name="authPkiVer" class="form-control viewForm" value="${customerInfo.authPkiVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="authPkiVer" name="authPkiVer" class="form-control viewForm" value="${customerInfo.authPkiVer}" readonly>
					</sec:authorize>
			    </div>
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<sec:authorize access="hasAnyRole('ENGINEER','ADMIN')">
				<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
			</sec:authorize>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
				<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>
			</sec:authorize>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<!-- 고객사 스크립트 -->
<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 고객사 추가 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/customerInfo/insert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result.result == "NotCustomerName") { // 고객사명 미 입력 시
	        		$('.colorRed').hide();
					$('#NotCustomerName').show();
				} else {
					$('#NotCustomerName').hide();
				}
	        	
	        	if(result.result == "Overlap") { // 사업명이 중복될 경우
	        		$('.colorRed').hide();
					$('#Overlap').show();
				} else {
					$('#Overlap').hide();
				} 
	        	
				if(result.result == "OK") {
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
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});
	
	/* =========== 고객사 정보 수정 ========= */
	$('#updateBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/customerInfo/update'/>",
            type: 'post',
            data: postData,
            async: false,
            success: function(result) {
				if(result.result == "OK") {
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
				
				if(result.result == "NotCustomerName") {  // 고객사명 미 입력 시
					$('#NotCustomerName').show();
				} else {
					$('#NotCustomerName').hide();
				}
				
				if(result.result == "Overlap") { // 사업명이 중복될 경우
	        		$('.colorRed').hide();
					$('#Overlap').show();
				} else {
					$('#Overlap').hide();
				} 
			},
			error: function(error) {
				console.log(error);
			}
        });
	});
	
	/* =========== 고객사명 Select Box 선택 ========= */
	$("#customerName").change(function() {
		$("#businessName").empty();
		$("#businessName").selectpicker("refresh");
		var customerName = $('#customerName').val();
		$.ajax({
			url: "<c:url value='/category/customerBusinessName'/>",
	        type: 'post',
	        data: {'customerName':customerName},
	        async: false,
	        success: function(items) {
	        	$("#businessName").append('<option value=""></option>');
	        	$.each(items, function (i, item) {
	        		$("#businessName").append('<option value="'+item+'">'+item+'</option>');
	        		$("#businessName").selectpicker("refresh");
	        	});
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});
	
	/* =========== 직접입력 <--> 선택입력 변경 ========= */
	function selfInput(data) {
		if (data == "customerNameChange") {
			if($('#customerNameChange').text() == "직접입력") {
				$('#customerNameViewSelf').hide();
				$('#customerNameSelf').attr('type','text');
				$('#customerNameView').val('');	
				$("#customerNameChange").text("선택입력");
			} else if($('#customerNameChange').text() == "선택입력") {
				$('#customerNameViewSelf').show();
				$('#customerNameSelf').attr('type','hidden');
				$('#customerNameSelf').val('');	
				$("#customerNameChange").text("직접입력");
			}
		} else if (data == "businessNameChange") {
			if($('#businessNameChange').text() == "직접입력") {
				$('#businessNameViewSelf').hide();
				$('#businessNameSelf').attr('type','text');
				$('#businessNameView').val('');	
				$("#businessNameChange").text("선택입력");
			} else if($('#businessNameChange').text() == "선택입력") {
				$('#businessNameViewSelf').show();
				$('#businessNameSelf').attr('type','hidden');
				$('#businessNameSelf').val('');	
				$("#businessNameChange").text("직접입력");
			}
		}	
	}
	
	/* =========== 주소 찾기 ========= */
	$('#btnAddress').click(function() {
		new daum.Postcode({
	        oncomplete: function(data) {
	        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	        	 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#customerZipCode').val(data.zonecode);
                $('#customerAddress').val(fullRoadAddr);
                $('#customerFullAddress').val(fullRoadAddr);
	        }
	    }).open();  
	})
</script>

<!-- 제품 스크립트 -->
<script>
	
	/* =========== 고객사 보이고 제품 숨기기 ========= */
	$('#btnCustomer').click(function() {
		$('#customer').css("display","block");
		$('#product').css("display","none");
	});
	
	/* =========== 제품 보이고 고객사 숨기기 ========= */
	$('#btnProduct').click(function() {
		$('#product').css("display","block");
		$('#customer').css("display","none");
	});
	
	/* =========== TOSMS Check 선택 ========= */
	$("#tosms").change(function() {
		if($("#tosms").is(":checked")){
			$('#tosmsVerDiv').css("display","block");
        }else{
        	$('#tosmsVerDiv').css("display","none");
        }
	});
	
	/* =========== TOSRF Check 선택 ========= */
	$("#tosrf").change(function() {
		if($("#tosrf").is(":checked")){
			$('#tosrfVerDiv').css("display","block");
        }else{
        	$('#tosrfVerDiv').css("display","none");
        }
	});
	
	/* =========== PORTAL Check 선택 ========= */
	$("#portal").change(function() {
		if($("#portal").is(":checked")){
			$('#portalVerDiv').css("display","block");
        }else{
        	$('#portalVerDiv').css("display","none");
        }
	});
	
	/* =========== 최초 실행 ========= */
	$(function() {
		var product = '${customerInfo.productCheck}'.split(',');
		// 수정일 경우 tosms가 없을 경우 제거
		if("${viewType}"=="update") {
			if(!product.includes('tosms')) {
				$('#tosms').prop("checked", false);
				$('#tosmsVerDiv').css("display","none");
			}
		}
		// tosms, portal 값이 포함 되어 잇을경우 추가
		product.forEach(function(element) { 
			$('#'+element+'VerDiv').css("display","block");
			$('#'+element).prop("checked", true);
		});
	});
	
	/* =========== 체크 되지 않는 체크 박스 값 지우기 ========= */
	function unChecked() {
		if(!$("#tosms").is(":checked")){
			$("#tosmsVer").val("");
		}
		if(!$("#tosrf").is(":checked")){
			$("#tosrfVer").val("");
		}
		if(!$("#portal").is(":checked")){
			$("#portalVer").val("");
		}
	}
</script>