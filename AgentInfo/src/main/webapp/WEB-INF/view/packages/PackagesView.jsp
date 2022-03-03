<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	/* =========== ajax _csrf 전송 ========= */
	/* $(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	}); */
</script>

<div class="modal-body" style="width: 100%; height: 510px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="packagesKeyNum" name=packagesKeyNum class="form-control viewForm" value="${packages.packagesKeyNum}"> 
		<div class="leftDiv">
			 <div class="pading5">
			 	<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
				<input type="text" id="customerName" name="customerName" class="form-control viewForm" value="${packages.customerName}"> 
				<span class="colorRed" id="NotCustomerName" style="display: none">고객사명을 입력해주세요.</span>
			 </div>
	         <div class="pading5">
	         	<label class="labelFontSize">요청일자</label>
	         	<input type="text" id="requestDate" name="requestDate" class="form-control viewForm" value="${packages.requestDate}">
	         </div>
	         <div class="pading5">
	         	<label class="labelFontSize">전달일자</label>
	         	<input type="text" id="deliveryData" name="deliveryData" class="form-control viewForm" value="${packages.deliveryData}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
			         <div class="pading5">
					  	<label class="labelFontSize">기존/신규</label>
					  	<select class="form-control viewForm" id="existingNew" name="existingNew">
					  		<option value=""></option>
							<option value="기존">기존</option>
							<option value="신규">신규</option>
						</select>
					 </div>
					 <div class="pading5">
					  	<label class="labelFontSize">관리서버/Agent</label>
					  	<select class="form-control viewForm" id="managementServer" name="managementServer">
					  		<option value=""></option>
							<option value="관리서버">관리서버</option>
							<option value="Agent">Agent</option>
						</select>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update'}">
					<div class="pading5">
			         	<label class="labelFontSize">기존/신규</label>
			         	<select class="form-control viewForm" id="existingNew" name="existingNew">
			         		<option value="" <c:if test="${packages.existingNew eq ''}">selected</c:if>></option>
							<option value="기존" <c:if test="${packages.existingNew eq '기존'}">selected</c:if>>기존</option>
							<option value="신규" <c:if test="${packages.existingNew eq '신규'}">selected</c:if>>신규</option>
						</select>
			         </div>
			         <div class="pading5">
			         	<label class="labelFontSize">관리서버/Agent</label>
			         	<select class="form-control viewForm" id="managementServer" name="managementServer">
			         		<option value="" <c:if test="${packages.managementServer eq ''}">selected</c:if>></option>
							<option value="관리서버" <c:if test="${packages.managementServer eq '관리서버'}">selected</c:if>>관리서버</option>
							<option value="Agent" <c:if test="${packages.managementServer eq 'Agent'}">selected</c:if>>Agent</option>
						</select>
			         </div>
			    </c:when>
			 </c:choose>
			 <div class="pading5">
	         	<label class="labelFontSize">Agent OS</label>
	         	<input type="text" id="agentOS" name="agentOS" class="form-control viewForm" value="${packages.agentOS}">
	         </div>
	         <div class="pading5">
	         	<label class="labelFontSize">OS 상세버전</label>
	         	<input type="text" id="osDetailVersion" name="osDetailVersion" class="form-control viewForm" value="${packages.osDetailVersion}">
	         </div>
	     </div>
         <div class="rightDiv">
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
			         <div class="pading5">
					  	<label class="labelFontSize">일반/커스텀</label>
					  	<select class="form-control viewForm" id="generalCustom" name="generalCustom">
					  		<option value=""></option>
							<option value="일반">일반</option>
							<option value="커스텀">커스텀</option>
						</select>
					 </div>
					 <div class="pading5">
					 	<label class="labelFontSize">OS종류</label>
		                <select class="form-control" id="osType" name="osType">
		                	<option value=""></option>
							<option value="Linux">Linux</option>
							<option value="Windows">Windows</option>
							<option value="Unix">Unix</option>
							<option value="UnixLinux">UnixLinux</option>
							<option value="AIX">AIX</option>
							<option value="HP-UX">HP-UX</option>
							<option value="SunOS">SunOS</option>
						</select>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update'}">
					<div class="pading5">
			         	<label class="labelFontSize">일반/커스텀</label>
			         	<select class="form-control viewForm" id="generalCustom" name="generalCustom">
			         		<option value=""></option>
							<option value="일반" <c:if test="${packages.generalCustom eq '일반'}">selected</c:if>>일반</option>
							<option value="커스텀" <c:if test="${packages.generalCustom eq '커스텀'}">selected</c:if>>커스텀</option>
						</select>
			         </div>
			         <div class="pading5">
					 	<label class="labelFontSize">OS종류</label>
		                <select class="form-control" id="osType" name="osType">
		                	<option value="" <c:if test="${packages.osType eq ''}">selected</c:if>></option>
							<option value="Linux" <c:if test="${packages.osType eq 'Linux'}">selected</c:if>>Linux</option>
							<option value="Windows" <c:if test="${packages.osType eq 'Windows'}">selected</c:if>>Windows</option>
							<option value="Unix" <c:if test="${packages.osType eq 'Unix'}">selected</c:if>>Unix</option>
							<option value="UnixLinux" <c:if test="${packages.osType eq 'UnixLinux'}">selected</c:if>>UnixLinux</option>
							<option value="AIX" <c:if test="${packages.osType eq 'AIX'}">selected</c:if>>AIX</option>
							<option value="HP-UX" <c:if test="${packages.osType eq 'HP-UX'}">selected</c:if>>HP-UX</option>
							<option value="SunOS" <c:if test="${packages.osType eq 'SunOS'}">selected</c:if>>SunOS</option>
						</select>
					 </div>
			    </c:when>
			 </c:choose>
			 <div class="pading5">
	         	<label class="labelFontSize">Agent ver</label>
	         	<input type="text" id="agentVer" name="agentVer" class="form-control viewForm" value="${packages.agentVer}">
	         </div>
         
	         <div class="pading5">
	         	<label class="labelFontSize">패키지명</label>
	         	<input type="text" id="packageName" name="packageName" class="form-control viewForm" value="${packages.packageName}">
	         </div>
	         <div class="pading5">
	         	<label class="labelFontSize">담당자</label>
	         	<input type="text" id="manager" name="manager" class="form-control viewForm" value="${packages.manager}">
	         </div>
	         <div class="pading5">
	         	<label class="labelFontSize">전달 방법</label>
	         	<input type="text" id="deliveryMethod" name="deliveryMethod" class="form-control viewForm" value="${packages.deliveryMethod}">
	         </div>
	         <div class="pading5">
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

</script>
	
	
	
	
	