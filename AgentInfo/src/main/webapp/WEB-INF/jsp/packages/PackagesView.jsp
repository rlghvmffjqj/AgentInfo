<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	/* =========== ajax _csrf 전송 ========= */
	/* $(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	}); */
</script>
<div class="modal-body" style="width: 100%; height: 550px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="packagesKeyNum" name=packagesKeyNum class="form-control viewForm" value="${packages.packagesKeyNum}"> 
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
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
					  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="customerNameViewSelf">
				         	<select class="form-control viewForm selectpicker" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.customerName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.customerName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${customerName}">
									<option value="${item}" <c:if test="${item eq packages.customerName}">selected</c:if>><c:out value="${item}"/></option>
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
				         	<select class="form-control viewForm selectpicker" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.businessName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.businessName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${businessName}">
									<option value="${item}" <c:if test="${item eq packages.businessName}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
		 		</c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">요청일자</label>
	         	<input type="date" id="requestDateView" name="requestDateView" class="form-control viewForm" value="${packages.requestDate}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">전달일자</label>
	         	<input type="date" id="deliveryDataView" name="deliveryDataView" class="form-control viewForm" value="${packages.deliveryData}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">패키지 종류</label>
					  		<a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="managementServerViewSelf">
						  	<select class="form-control selectpicker selectForm" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${managementServer}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">일반/커스텀</label>
					  		<a href="#" class="selfInput" id="generalCustomChange" onclick="selfInput('generalCustomChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="generalCustomSelf" name="generalCustomSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="generalCustomViewSelf">
						  	<select class="form-control viewForm selectpicker" id="generalCustomView" name="generalCustomView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${generalCustom}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">Agent ver</label>
					  		<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentVerViewSelf">
						  	<select class="form-control viewForm selectpicker" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${agentVer}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">패키지 종류</label>
					  		<a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="managementServerViewSelf">
				         	<select class="form-control viewForm selectpicker" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.managementServer ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.managementServer eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${managementServer}">
									<option value="${item}" <c:if test="${item eq packages.managementServer}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">일반/커스텀</label>
					  		<a href="#" class="selfInput" id="generalCustomChange" onclick="selfInput('generalCustomChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="generalCustomSelf" name="generalCustomSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="generalCustomViewSelf">
				         	<select class="form-control viewForm selectpicker" id="generalCustomView" name="generalCustomView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.generalCustom ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.generalCustom eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${generalCustom}">
									<option value="${item}" <c:if test="${item eq packages.generalCustom}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">Agent ver</label>
					  		<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentVerViewSelf">
				         	<select class="form-control viewForm selectpicker" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.agentVer ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.agentVer eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${agentVer}">
									<option value="${item}" <c:if test="${item eq packages.agentVer}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			    </c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">패키지명</label>
	         	<input type="text" id="packageNameView" name="packageNameView" class="form-control viewForm" value="${packages.packageName}">
	         </div>
	     </div>
         <div class="rightDiv">
         	<div class="pading5Width450">
	         	<label class="labelFontSize">담당자</label>
	         	<input type="text" id="managerView" name="managerView" class="form-control viewForm" value="${packages.manager}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">OS종류</label>
					  		<a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="osTypeViewSelf">
			                <select class="form-control viewForm selectpicker" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5">
			                	<option value=""></option>
								<c:forEach var="item" items="${osType}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">OS종류</label>
					  		<a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="osTypeViewSelf">
			                <select class="form-control viewForm selectpicker" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5">
			                	<c:if test="${packages.osType ne ''}"><option value=""></option></c:if>
			                	<c:if test="${packages.osType eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${osType}">
									<option value="${item}" <c:if test="${item eq packages.osType}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			    </c:when>
			 </c:choose>
			 <div class="pading5Width450">
	         	<label class="labelFontSize">패키지 상세버전</label>
	         	<input type="text" id="osDetailVersionView" name="osDetailVersionView" class="form-control viewForm" value="${packages.osDetailVersion}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">Agent OS</label>
					  		<a href="#" class="selfInput" id="agentOSChange" onclick="selfInput('agentOSChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentOSSelf" name="agentOSSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentOSViewSelf">
						  	<select class="form-control viewForm selectpicker" id="agentOSView" name="agentOSView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${agentOS}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">기존/신규</label>
					  		<a href="#" class="selfInput" id="existingNewChange" onclick="selfInput('existingNewChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="existingNewSelf" name="existingNewSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="existingNewViewSelf">
						  	<select class="form-control viewForm selectpicker" id="existingNewView" name="existingNewView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${existingNew}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">요청 제품 구분</label>
					  		<a href="#" class="selfInput" id="requestProductCategoryChange" onclick="selfInput('requestProductCategoryChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="requestProductCategorySelf" name="requestProductCategorySelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="requestProductCategoryViewSelf">
						  	<select class="form-control viewForm selectpicker" id="requestProductCategoryView" name="requestProductCategoryView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${requestProductCategory}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">전달 방법</label>
					  		<a href="#" class="selfInput" id="deliveryMethodChange" onclick="selfInput('deliveryMethodChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="deliveryMethodSelf" name="deliveryMethodSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="deliveryMethodViewSelf">
			                <select class="form-control viewForm selectpicker" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5">
			                	<option value=""></option>
								<c:forEach var="item" items="${deliveryMethod}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">Agent OS</label>
					  		<a href="#" class="selfInput" id="agentOSChange" onclick="selfInput('agentOSChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentOSSelf" name="agentOSSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentOSViewSelf">
				         	<select class="form-control viewForm selectpicker" id="agentOSView" name="agentOSView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.agentOS ne ''}"><option value=""></option></c:if>	
				         		<c:if test="${packages.agentOS eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${agentOS}">
									<option value="${item}" <c:if test="${item eq packages.agentOS}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">기존/신규</label>
					  		<a href="#" class="selfInput" id="existingNewChange" onclick="selfInput('existingNewChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="existingNewSelf" name="existingNewSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="existingNewViewSelf">
				         	<select class="form-control viewForm selectpicker" id="existingNewView" name="existingNewView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.existingNew ne ''}"><option value=""></option></c:if>	
				         		<c:if test="${packages.existingNew eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${existingNew}">
									<option value="${item}" <c:if test="${item eq packages.existingNew}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">요청 제품 구분</label>
					  		<a href="#" class="selfInput" id="requestProductCategoryChange" onclick="selfInput('requestProductCategoryChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="requestProductCategorySelf" name="requestProductCategorySelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="requestProductCategoryViewSelf">
				         	<select class="form-control viewForm selectpicker" id="requestProductCategoryView" name="requestProductCategoryView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.requestProductCategory ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.requestProductCategory eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${requestProductCategory}">
									<option value="${item}" <c:if test="${item eq packages.requestProductCategory}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">전달 방법</label>
					  		<a href="#" class="selfInput" id="deliveryMethodChange" onclick="selfInput('deliveryMethodChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="deliveryMethodSelf" name="deliveryMethodSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="deliveryMethodViewSelf">
			                <select class="form-control viewForm selectpicker" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5">
			                	<c:if test="${packages.deliveryMethod ne ''}"><option value=""></option></c:if>
			                	<c:if test="${packages.deliveryMethod eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${deliveryMethod}">
									<option value="${item}" <c:if test="${item eq packages.deliveryMethod}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			    </c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">비고</label>
	         	<input type="text" id="noteView" name="noteView" class="form-control viewForm" value="${packages.note}">
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
		<c:when test="${viewType eq 'copy'}">
			<button class="btn btn-default btn-outline-info-add" id="copyBtn">복사</button>
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
    
</div>


<script>
	/* =========== 패키지 추가 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/insert'/>",
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
	
	/* =========== 패키지 정보 수정 ========= */
	$('#updateBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/update'/>",
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
	
	/* =========== 패키지 복사 ========= */
	$('#copyBtn').click(function() {
		
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/copy'/>",
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
	
	$('.selectpicker').selectpicker();
	
	/* =========== 직접입력 <--> 선택입력 변경 ========= */
	function selfInput(data) {
		if(data == "managementServerChange") {
			if($("#managementServerChange").text() == "직접입력") {
				$('#managementServerViewSelf').hide();
				$('#managementServerSelf').attr('type','text');
				$('#managementServerView').val('');
				$("#managementServerChange").text("선택입력");
			} else if($("#managementServerChange").text() == "선택입력") {
				$('#managementServerViewSelf').show();
				$('#managementServerSelf').attr('type','hidden');
				$('#managementServerSelf').val('');
				$("#managementServerChange").text("직접입력");
			}
		} else if (data == "generalCustomChange") {
			if($('#generalCustomChange').text() == "직접입력") {
				$('#generalCustomViewSelf').hide();
				$('#generalCustomSelf').attr('type','text');
				$('#generalCustomView').val('');
				$("#generalCustomChange").text("선택입력");
			} else if($('#generalCustomChange').text() == "선택입력") {
				$('#generalCustomViewSelf').show();
				$('#generalCustomSelf').attr('type','hidden');
				$('#generalCustomSelf').val('');
				$("#generalCustomChange").text("직접입력");
			}
		} else if (data == "agentVerChange") {
			if($('#agentVerChange').text() == "직접입력") {
				$('#agentVerViewSelf').hide();
				$('#agentVerSelf').attr('type','text');
				$('#agentVerView').val('');
				$("#agentVerChange").text("선택입력");
			} else if($('#agentVerChange').text() == "선택입력") {
				$('#agentVerViewSelf').show();
				$('#agentVerSelf').attr('type','hidden');
				$('#agentVerSelf').val('');
				$("#agentVerChange").text("직접입력");
			}
		} else if (data == "osTypeChange") {
			if($('#osTypeChange').text() == "직접입력") {
				$('#osTypeViewSelf').hide();
				$('#osTypeSelf').attr('type','text');
				$('#osTypeView').val('');
				$("#osTypeChange").text("선택입력");
			} else if($('#osTypeChange').text() == "선택입력") {
				$('#osTypeViewSelf').show();
				$('#osTypeSelf').attr('type','hidden');
				$('#osTypeSelf').val('');
				$("#osTypeChange").text("직접입력");
			}
		} else if (data == "agentOSChange") {
			if($('#agentOSChange').text() == "직접입력") {
				$('#agentOSViewSelf').hide();
				$('#agentOSSelf').attr('type','text');
				$('#agentOSView').val('');	
				$("#agentOSChange").text("선택입력");
			} else if($('#agentOSChange').text() == "선택입력") {
				$('#agentOSViewSelf').show();
				$('#agentOSSelf').attr('type','hidden');
				$('#agentOSSelf').val('');	
				$("#agentOSChange").text("직접입력");
			}
		} else if (data == "existingNewChange") {
			if($('#existingNewChange').text() == "직접입력") {
				$('#existingNewViewSelf').hide();
				$('#existingNewSelf').attr('type','text');
				$('#existingNewView').val('');
				$("#existingNewChange").text("선택입력");
			} else if($('#existingNewChange').text() == "선택입력") {
				$('#existingNewViewSelf').show();
				$('#existingNewSelf').attr('type','hidden');
				$('#existingNewSelf').val('');
				$("#existingNewChange").text("직접입력");
			}
		} else if (data == "requestProductCategoryChange") {
			if($('#requestProductCategoryChange').text() == "직접입력") {
				$('#requestProductCategoryViewSelf').hide();
				$('#requestProductCategorySelf').attr('type','text');
				$('#requestProductCategoryView').val('');
				$("#requestProductCategoryChange").text("선택입력");
			} else if($('#requestProductCategoryChange').text() == "선택입력") {
				$('#requestProductCategoryViewSelf').show();
				$('#requestProductCategorySelf').attr('type','hidden');
				$('#requestProductCategorySelf').val('');
				$("#requestProductCategoryChange").text("직접입력");
			}
		} else if (data == "deliveryMethodChange") {
			if($('#deliveryMethodChange').text() == "직접입력") {
				$('#deliveryMethodViewSelf').hide();
				$('#deliveryMethodSelf').attr('type','text');
				$('#deliveryMethodView').val('');	
				$("#deliveryMethodChange").text("선택입력");
			} else if($('#deliveryMethodChange').text() == "선택입력") {
				$('#deliveryMethodViewSelf').show();
				$('#deliveryMethodSelf').attr('type','hidden');
				$('#deliveryMethodSelf').val('');	
				$("#deliveryMethodChange").text("직접입력");
			}
		} else if (data == "customerNameChange") {
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
	/* =========== Select Box 선택 ========= */
	$("#customerNameView").change(function() {
		$("#businessNameView").empty();
		$("#businessNameView").selectpicker("refresh");
		var customerName = $('#customerNameView').val();
		$.ajax({
			url: "<c:url value='/category/categoryBusinessName'/>",
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
</script>

