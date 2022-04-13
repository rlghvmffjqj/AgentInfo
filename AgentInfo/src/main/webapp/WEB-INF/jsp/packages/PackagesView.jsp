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
			 <div class="pading5Width450">
			 	<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
				<input type="text" id="customerNameView" name="customerNameView" class="form-control viewForm" value="${packages.customerName}"> 
				<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
			 </div>
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
					  		<a href="#" class="selfInput" id="managementServerView" onclick="selfInput('managementServerView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="generalCustomView" onclick="selfInput('generalCustomView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="agentVerView" onclick="selfInput('agentVerView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="managementServerView" onclick="selfInput('managementServerView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="generalCustomView" onclick="selfInput('generalCustomView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="agentVerView" onclick="selfInput('agentVerView');">직접입력</a>
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
	         <div class="pading5Width450">
	         	<label class="labelFontSize">담당자</label>
	         	<input type="text" id="managerView" name="managerView" class="form-control viewForm" value="${packages.manager}">
	         </div>
	     </div>
         <div class="rightDiv">
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">OS종류</label>
					  		<a href="#" class="selfInput" id="osTypeView" onclick="selfInput('osTypeView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="osTypeView" onclick="selfInput('osTypeView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="agentOSView" onclick="selfInput('agentOSView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="existingNewView" onclick="selfInput('existingNewView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="requestProductCategoryView" onclick="selfInput('requestProductCategoryView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="deliveryMethodView" onclick="selfInput('deliveryMethodView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="agentOSView" onclick="selfInput('agentOSView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="existingNewView" onclick="selfInput('existingNewView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="requestProductCategoryView" onclick="selfInput('requestProductCategoryView');">직접입력</a>
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
					  		<a href="#" class="selfInput" id="deliveryMethodView" onclick="selfInput('deliveryMethodView');">직접입력</a>
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
		if(data == "managementServerView") {
			if($("#managementServerView").text() == "직접입력") {
				$('#managementServerViewSelf').hide();
				$('#managementServerSelf').attr('type','text');
				$('#managementServerView').val('');
				$("#managementServerView").text("선택입력");
			} else if($("#managementServerView").text() == "선택입력") {
				$('#managementServerViewSelf').show();
				$('#managementServerSelf').attr('type','hidden');
				$('#managementServerSelf').val('');
				$("#managementServerView").text("직접입력");
			}
		} else if (data == "generalCustomView") {
			if($('#generalCustomView').text() == "직접입력") {
				$('#generalCustomViewSelf').hide();
				$('#generalCustomSelf').attr('type','text');
				$('#generalCustomView').val('');
				$("#generalCustomView").text("선택입력");
			} else if($('#generalCustomView').text() == "선택입력") {
				$('#generalCustomViewSelf').show();
				$('#generalCustomSelf').attr('type','hidden');
				$('#generalCustomSelf').val('');
				$("#generalCustomView").text("직접입력");
			}
		} else if (data == "agentVerView") {
			if($('#agentVerView').text() == "직접입력") {
				$('#agentVerViewSelf').hide();
				$('#agentVerSelf').attr('type','text');
				$('#agentVerView').val('');
				$("#agentVerView").text("선택입력");
			} else if($('#agentVerView').text() == "선택입력") {
				$('#agentVerViewSelf').show();
				$('#agentVerSelf').attr('type','hidden');
				$('#agentVerSelf').val('');
				$("#agentVerView").text("직접입력");
			}
		} else if (data == "osTypeView") {
			if($('#osTypeView').text() == "직접입력") {
				$('#osTypeViewSelf').hide();
				$('#osTypeSelf').attr('type','text');
				$('#osTypeView').val('');
				$("#osTypeView").text("선택입력");
			} else if($('#osTypeView').text() == "선택입력") {
				$('#osTypeViewSelf').show();
				$('#osTypeSelf').attr('type','hidden');
				$('#osTypeSelf').val('');
				$("#osTypeView").text("직접입력");
			}
		} else if (data == "agentOSView") {
			if($('#agentOSView').text() == "직접입력") {
				$('#agentOSViewSelf').hide();
				$('#agentOSSelf').attr('type','text');
				$('#agentOSView').val('');	
				$("#agentOSView").text("선택입력");
			} else if($('#agentOSView').text() == "선택입력") {
				$('#agentOSViewSelf').show();
				$('#agentOSSelf').attr('type','hidden');
				$('#agentOSSelf').val('');	
				$("#agentOSView").text("직접입력");
			}
		} else if (data == "existingNewView") {
			if($('#existingNewView').text() == "직접입력") {
				$('#existingNewViewSelf').hide();
				$('#existingNewSelf').attr('type','text');
				$('#existingNewView').val('');
				$("#existingNewView").text("선택입력");
			} else if($('#existingNewView').text() == "선택입력") {
				$('#existingNewViewSelf').show();
				$('#existingNewSelf').attr('type','hidden');
				$('#existingNewSelf').val('');
				$("#existingNewView").text("직접입력");
			}
		} else if (data == "requestProductCategoryView") {
			if($('#requestProductCategoryView').text() == "직접입력") {
				$('#requestProductCategoryViewSelf').hide();
				$('#requestProductCategorySelf').attr('type','text');
				$('#requestProductCategoryView').val('');
				$("#requestProductCategoryView").text("선택입력");
			} else if($('#requestProductCategoryView').text() == "선택입력") {
				$('#requestProductCategoryViewSelf').show();
				$('#requestProductCategorySelf').attr('type','hidden');
				$('#requestProductCategorySelf').val('');
				$("#requestProductCategoryView").text("직접입력");
			}
		} else if (data == "deliveryMethodView") {
			if($('#deliveryMethodView').text() == "직접입력") {
				$('#deliveryMethodViewSelf').hide();
				$('#deliveryMethodSelf').attr('type','text');
				$('#deliveryMethodView').val('');	
				$("#deliveryMethodView").text("선택입력");
			} else if($('#deliveryMethodView').text() == "선택입력") {
				$('#deliveryMethodViewSelf').show();
				$('#deliveryMethodSelf').attr('type','hidden');
				$('#deliveryMethodSelf').val('');	
				$("#deliveryMethodView").text("직접입력");
			}
		}
	}

</script>
	
	
	
	
	