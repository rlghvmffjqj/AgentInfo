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
				<input type="text" id="customerName" name="customerName" class="form-control viewForm" value="${packages.customerName}"> 
				<span class="colorRed" id="NotCustomerName" style="display: none">고객사명을 입력해주세요.</span>
			 </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">요청일자</label>
	         	<input type="date" id="requestDate" name="requestDate" class="form-control viewForm" value="${packages.requestDate}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">전달일자</label>
	         	<input type="date" id="deliveryData" name="deliveryData" class="form-control viewForm" value="${packages.deliveryData}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					<div class="pading5Width450">
					  	<label class="labelFontSize">패키지 종류</label>
					  	<select class="form-control viewForm selectpicker" id="managementServer" name="managementServer" data-live-search="true" data-size="5" data-actions-box="true">
					  		<option value=""></option>
							<c:forEach var="item" items="${managementServer}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
					 <div class="pading5Width450">
					  	<label class="labelFontSize">일반/커스텀</label>
					  	<select class="form-control viewForm" id="generalCustom" name="generalCustom">
					  		<option value=""></option>
							<c:forEach var="item" items="${generalCustom}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
					 <div class="pading5Width450">
					  	<label class="labelFontSize">Agent ver</label>
					  	<select class="form-control viewForm" id="agentVer" name="agentVer">
					  		<option value=""></option>
							<c:forEach var="item" items="${agentVer}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
					<div class="pading5Width450">
			         	<label class="labelFontSize">패키지 종류</label>
			         	<select class="form-control viewForm" id="managementServer" name="managementServer">
			         		<c:if test="${packages.managementServer ne ''}"><option value=""></option></c:if>
			         		<c:if test="${packages.managementServer eq ''}"><option value=""></option></c:if>
			         		<c:forEach var="item" items="${managementServer}">
								<option value="${item}" <c:if test="${item eq packages.managementServer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
			         </div>
			         <div class="pading5Width450">
			         	<label class="labelFontSize">일반/커스텀</label>
			         	<select class="form-control viewForm" id="generalCustom" name="generalCustom">
			         		<c:if test="${packages.generalCustom ne ''}"><option value=""></option></c:if>
			         		<c:if test="${packages.generalCustom eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${generalCustom}">
								<option value="${item}" <c:if test="${item eq packages.generalCustom}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
			         </div>
			         <div class="pading5Width450">
			         	<label class="labelFontSize">Agent ver</label>
			         	<select class="form-control viewForm" id="agentVer" name="agentVer">
			         		<c:if test="${packages.agentVer ne ''}"><option value=""></option></c:if>
			         		<c:if test="${packages.agentVer eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${agentVer}">
								<option value="${item}" <c:if test="${item eq packages.agentVer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
			         </div>
			    </c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">패키지명</label>
	         	<input type="text" id="packageName" name="packageName" class="form-control viewForm" value="${packages.packageName}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">담당자</label>
	         	<input type="text" id="manager" name="manager" class="form-control viewForm" value="${packages.manager}">
	         </div>
	     </div>
         <div class="rightDiv">
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					 <div class="pading5Width450">
					 	<label class="labelFontSize">OS종류</label>
		                <select class="form-control viewForm" id="osType" name="osType">
		                	<option value=""></option>
							<c:forEach var="item" items="${osType}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
			         <div class="pading5Width450">
					 	<label class="labelFontSize">OS종류</label>
		                <select class="form-control viewForm" id="osType" name="osType">
		                	<c:if test="${packages.osType ne ''}"><option value=""></option></c:if>
		                	<c:if test="${packages.osType eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${osType}">
								<option value="${item}" <c:if test="${item eq packages.osType}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
			    </c:when>
			 </c:choose>
			 <div class="pading5Width450">
	         	<label class="labelFontSize">패키지 상세버전</label>
	         	<input type="text" id="osDetailVersion" name="osDetailVersion" class="form-control viewForm" value="${packages.osDetailVersion}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					<div class="pading5Width450">
					  	<label class="labelFontSize">Agent OS</label>
					  	<select class="form-control viewForm" id="agentOS" name="agentOS">
					  		<option value=""></option>
							<c:forEach var="item" items="${agentOS}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
					<div class="pading5Width450">
					  	<label class="labelFontSize">기존/신규</label>
					  	<select class="form-control viewForm" id="existingNew" name="existingNew">
					  		<option value=""></option>
							<c:forEach var="item" items="${existingNew}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
			         <div class="pading5Width450">
					  	<label class="labelFontSize">요청 제품 구분</label>
					  	<select class="form-control viewForm" id="requestProductCategory" name="requestProductCategory">
					  		<option value=""></option>
							<c:forEach var="item" items="${requestProductCategory}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
					 <div class="pading5Width450">
					 	<label class="labelFontSize">전달 방법</label>
		                <select class="form-control viewForm" id="deliveryMethod" name="deliveryMethod">
		                	<option value=""></option>
							<c:forEach var="item" items="${deliveryMethod}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
					<div class="pading5Width450">
			         	<label class="labelFontSize">Agent OS</label>
			         	<select class="form-control viewForm" id="agentOS" name="agentOS">
			         		<c:if test="${packages.agentOS ne ''}"><option value=""></option></c:if>	
			         		<c:if test="${packages.agentOS eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${agentOS}">
								<option value="${item}" <c:if test="${item eq packages.agentOS}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
			         </div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">기존/신규</label>
			         	<select class="form-control viewForm" id="existingNew" name="existingNew">
			         		<c:if test="${packages.existingNew ne ''}"><option value=""></option></c:if>	
			         		<c:if test="${packages.existingNew eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${existingNew}">
								<option value="${item}" <c:if test="${item eq packages.existingNew}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
			         </div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">요청 제품 구분</label>
			         	<select class="form-control viewForm" id="requestProductCategory" name="requestProductCategory">
			         		<c:if test="${packages.requestProductCategory ne ''}"><option value=""></option></c:if>
			         		<c:if test="${packages.requestProductCategory eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${requestProductCategory}">
								<option value="${item}" <c:if test="${item eq packages.requestProductCategory}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
			         </div>
			         <div class="pading5Width450">
					 	<label class="labelFontSize">전달 방법</label>
		                <select class="form-control viewForm" id="deliveryMethod" name="deliveryMethod">
		                	<c:if test="${packages.deliveryMethod ne ''}"><option value=""></option></c:if>
		                	<c:if test="${packages.deliveryMethod eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${deliveryMethod}">
								<option value="${item}" <c:if test="${item eq packages.deliveryMethod}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
			    </c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">비고</label>
	         	<input type="text" id="note" name="note" class="form-control viewForm" value="${packages.note}">
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

</script>
	
	
	
	
	