<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 725px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="customerKeyNum" name=customerKeyNum class="form-control viewForm" value="${customer.customerKeyNum}">
		<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<div class="pading5Width450">
			 	<div>
			  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
			  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
			  	</div>
			  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
			  	<div id="customerNameViewSelf">
				  	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
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
			  		<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
			  	</div>
			  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
			  	<div id="businessNameViewSelf">
				  	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
				  		<option value=""></option>
					</select>
				</div>
			 </div>
		</c:when>
		<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
			<div class="pading5Width450">
				<div>
			  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
			  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
			  	</div>
			  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
			  	<div id="customerNameViewSelf">
		         	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
		         		<c:if test="${customer.customerName ne ''}"><option value=""></option></c:if>
		         		<c:if test="${customer.customerName eq ''}"><option value=""></option></c:if>
		         		<c:forEach var="item" items="${customerName}">
							<option value="${item}" <c:if test="${item eq customer.customerName}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
				<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
		        </div>
		        <div class="pading5Width450">
				<div>
			  		<label class="labelFontSize">사업명</label>
			  		<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
			  	</div>
			  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
			  	<div id="businessNameViewSelf">
		         	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
		         		<c:if test="${customer.businessName ne ''}"><option value=""></option></c:if>
		         		<c:if test="${customer.businessName eq ''}"><option value=""></option></c:if>
		         		<c:forEach var="item" items="${businessName}">
							<option value="${item}" <c:if test="${item eq customer.businessName}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
		        </div>
		</c:when>
		</c:choose>
		<div class="pading5Width450">
	    	<label class="labelFontSize">고객사 담당자명</label>
	    	<input type="text" id="customerManagerNameView" name="customerManagerNameView" class="form-control viewForm" value="${customer.customerManagerName}">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize">고객사 담당자 부서</label>
	    	<input type="text" id="customerDeptView" name="customerDeptView" class="form-control viewForm" value="${customer.customerDept}">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize">고객사 담당자 전화번호</label>
	    	<input type="text" id="customerPhoneNumberView" name="customerPhoneNumberView" class="form-control viewForm" value="${customer.customerPhoneNumber}">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize width100">고객사 주소</label>
	    	<input type="text" id="customerZipCodeView" name="customerZipCodeView" class="form-control viewForm zipCodeForm" value="${customer.customerZipCode}" placeholder="우편번호" readonly>
	    	<input type="text" id="customerAddressView" name="customerAddressView" class="form-control viewForm addressFom" value="${customer.customerAddress}" placeholder="주소" readonly>
	    	<button class="btn btn-primary addressButton" type="button" id="btnAddress">주소 찾기</button>
	    	<input type="text" id="customerFullAddressView" name="customerFullAddressView" class="form-control viewForm" value="${customer.customerFullAddress}" placeholder="상세주소">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize">제품</label>
	    	<input type="text" id="packageNameView" name="packageNameView" class="form-control viewForm" value="${customer.packageName}">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize">OS종류</label>
	    	<input type="text" id="osTypeView" name="osTypeView" class="form-control viewForm" value="${customer.osType}">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize">SE명</label>
	    	<input type="text" id="employeeSeNameView" name="employeeSeNameView" class="form-control viewForm" value="${customer.employeeSeName}">
	    </div>
	    <div class="pading5Width450">
	    	<label class="labelFontSize">영업사원명</label>
	    	<input type="text" id="employeeSalesNameView" name="employeeSalesNameView" class="form-control viewForm" value="${customer.employeeSalesName}">
	    </div>
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
				<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>
			</sec:authorize>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 고객사 추가 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/customer/insert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result.result == "NotCustomerName") { // 고객사명 미 입력 시
					$('#NotCustomerName').show();
				} else {
					$('#NotCustomerName').hide();
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
			url: "<c:url value='/customer/update'/>",
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
			},
			error: function(error) {
				console.log(error);
			}
        });
	});
	
	/* =========== 고객사명 Select Box 선택 ========= */
	$("#customerNameView").change(function() {
		$("#businessNameView").empty();
		$("#businessNameView").selectpicker("refresh");
		var customerName = $('#customerNameView').val();
		$.ajax({
			url: "<c:url value='/category/customerBusinessName'/>",
	        type: 'post',
	        data: {'customerName':customerName},
	        async: false,
	        success: function(items) {
	        	$("#businessNameView").append('<option value=""></option>');
	        	$.each(items, function (i, item) {
	        		$("#businessNameView").append('<option value="'+item+'">'+item+'</option>');
	        		$("#businessNameView").selectpicker("refresh");
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
                $('#customerZipCodeView').val(data.zonecode);
                $('#customerAddressView').val(fullRoadAddr);
                $('#customerFullAddressView').val(fullRoadAddr);
	        }
	    }).open();  
	})
</script>