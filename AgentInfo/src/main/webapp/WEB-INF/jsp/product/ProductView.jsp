<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 525px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="productKeyNum" name=productKeyNum class="form-control viewForm" value="${product.productKeyNum}">
		
		<div class="leftDiv">
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
				<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
					  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="customerNameViewSelf">
				         	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
				         		<c:if test="${product.customerName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${product.customerName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${customerName}">
									<option value="${item}" <c:if test="${item eq product.customerName}">selected</c:if>><c:out value="${item}"/></option>
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
					     		<c:if test="${product.businessName ne ''}"><option value=""></option></c:if>
					     		<c:if test="${product.businessName eq ''}"><option value=""></option></c:if>
					     		<c:forEach var="item" items="${businessName}">
									<option value="${item}" <c:if test="${item eq product.businessName}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
				    </div>
			    </sec:authorize>
			    <sec:authorize access="hasRole('MEMBER')">
			    	<div class="pading5Width450">
			    		<label class="labelFontSize">고객사명</label>
		    			<input type="text" id="customerName" name="customerName" class="form-control viewForm" value="${product.customerName}" readonly>
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">사업명</label>
		    			<input type="text" id="businessName" name="businessName" class="form-control viewForm" value="${product.businessName}" readonly>
				    </div>
			    </sec:authorize>
			</c:when>
			</c:choose>
			<div class="pading5Width450 marginLeft22">
				<div class="form-check checkBoxView">
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
				<div class="form-check checkBoxView">
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
				<div class="form-check checkBoxView">
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
			    		<input type="text" id="tosmsVerView" name="tosmsVerView" class="form-control viewForm marginBottom1" value="${product.tosmsVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">	
						<input type="text" id="tosmsVerView" name="tosmsVerView" class="form-control viewForm marginBottom1" value="${product.tosmsVer}" readonly>
					</sec:authorize>
			    </div>
			    <div class="pading5Width450 displayNone" id="tosrfVerDiv">
			    	<label class="labelFontSize">TOSRF</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="tosrfVerView" name="tosrfVerView" class="form-control viewForm marginBottom1" value="${product.tosrfVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="tosrfVerView" name="tosrfVerView" class="form-control viewForm marginBottom1" value="${product.tosrfVer}" readonly>
					</sec:authorize>	
			    </div>
			    <div class="pading5Width450 displayNone" id="portalVerDiv">
			    	<label class="labelFontSize">PORTAL</label>
			    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
			    		<input type="text" id="portalVerView" name="portalVerView" class="form-control viewForm marginBottom1" value="${product.portalVer}">
			    	</sec:authorize>
					<sec:authorize access="hasRole('MEMBER')">
						<input type="text" id="portalVerView" name="portalVerView" class="form-control viewForm marginBottom1" value="${product.portalVer}" readonly>
					</sec:authorize>
			    </div>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">JAVA</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="javaVerView" name="javaVerView" class="form-control viewForm" value="${product.javaVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">			    
			    	<input type="text" id="javaVerView" name="javaVerView" class="form-control viewForm" value="${product.javaVer}" readonly>
			    </sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">WebServer</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="webServerVerView" name="webServerVerView" class="form-control viewForm" value="${product.webServerVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">	
					<input type="text" id="webServerVerView" name="webServerVerView" class="form-control viewForm" value="${product.webServerVer}" readonly>
				</sec:authorize>
		    </div>
		</div>
		<div class="rightDiv">
		    <div class="pading5Width450">
		    	<label class="labelFontSize">Database</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="employeeSeNameView" name="databaseVerView" class="form-control viewForm" value="${product.databaseVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="employeeSeNameView" name="databaseVerView" class="form-control viewForm" value="${product.databaseVer}" readonly>
				</sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">LogServer</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="logServerVerView" name="logServerVerView" class="form-control viewForm" value="${product.logServerVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="logServerVerView" name="logServerVerView" class="form-control viewForm" value="${product.logServerVer}" readonly>
				</sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">ScvEA</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="scvEaVerView" name="scvEaVerView" class="form-control viewForm" value="${product.scvEaVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="scvEaVerView" name="scvEaVerView" class="form-control viewForm" value="${product.scvEaVer}" readonly>
				</sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">ScvCA</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="scvCaVerView" name="scvCaVerView" class="form-control viewForm" value="${product.scvCaVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="scvCaVerView" name="scvCaVerView" class="form-control viewForm" value="${product.scvCaVer}" readonly>
				</sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">Auth/PKI</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="authPkiVerView" name="authPkiVerView" class="form-control viewForm" value="${product.authPkiVer}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="authPkiVerView" name="authPkiVerView" class="form-control viewForm" value="${product.authPkiVer}" readonly>
				</sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">SE명</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="employeeSeNameView" name="employeeSeNameView" class="form-control viewForm" value="${product.employeeSeName}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="employeeSeNameView" name="employeeSeNameView" class="form-control viewForm" value="${product.employeeSeName}" readonly>
				</sec:authorize>
		    </div>
		    <div class="pading5Width450">
		    	<label class="labelFontSize">영업사원</label>
		    	<sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
		    		<input type="text" id="employeeSalesNameView" name="employeeSalesNameView" class="form-control viewForm" value="${product.employeeSalesName}">
		    	</sec:authorize>
				<sec:authorize access="hasRole('MEMBER')">
					<input type="text" id="employeeSalesNameView" name="employeeSalesNameView" class="form-control viewForm" value="${product.employeeSalesName}" readonly>
				</sec:authorize>
		    </div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 제품 정보 추가 ========= */
	$('#insertBtn').click(function() {
		unChecked();
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/product/insert'/>",
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
	
	/* =========== 체크 되지 않는 체크 박스 값 지우기 ========= */
	function unChecked() {
		if(!$("#tosms").is(":checked")){
			$("#tosmsVerView").val("");
		}
		if(!$("#tosrf").is(":checked")){
			$("#tosrfVerView").val("");
		}
		if(!$("#portal").is(":checked")){
			$("#portalVerView").val("");
		}
	}
	
	/* =========== 제품 정보 정보 수정 ========= */
	$('#updateBtn').click(function() {
		unChecked();
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/product/update'/>",
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
		var product = '${product.productCheck}'.split(',');
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
</script>