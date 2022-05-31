<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 500px;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="customPackageKeyNum" name=customPackageKeyNum class="form-control viewForm" value="${customPackage.customPackageKeyNum}">
		<c:choose>
			<c:when test="${viewType eq 'insert'}">
				<div class="pading5Width320">
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
				<div class="pading5Width320">
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
				<div class="pading5Width320">
					 <div>
					 	<label class="labelFontSize">패키지 종류</label><label class="colorRed">*</label>
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
					 <span class="colorRed" id="NotManagementServer" style="display: none; line-height: initial;">패키지 종류를 선택 또는 입력해주세요.</span>
				 </div>
				 <div class="pading5Width320">
					 <div>
					 	<label class="labelFontSize">Agent ver</label><label class="colorRed">*</label>
					 	<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					 </div>
					 <input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					 <div id="agentVerViewSelf">
					  	<select class="form-control selectForm selectpicker" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
					  		<option value=""></option>
							<c:forEach var="item" items="${agentVer}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					 </div>
					 <span class="colorRed" id="NotAgentVer" style="display: none; line-height: initial;">Version을 선택 또는 입력해주세요.</span>
				 </div>
				 <div class="pading5Width320">
					<div>
				 		<label class="labelFontSize">OS종류</label><label class="colorRed">*</label>
				 		<a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a>
				 	</div>
				 	<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
				 	<div id="osTypeViewSelf">
			        	<select class="form-control selectForm selectpicker" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5">
				           	<option value=""></option>
							<c:forEach var="item" items="${osType}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotOsType" style="display: none; line-height: initial;">OS타입을 선택 또는 입력해주세요.</span>
				</div>
			</c:when>
			<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
				<div class="pading5Width320">
					<div>
				 		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
				 		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
				 	</div>
				 	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
				 	<div id="customerNameViewSelf">
				    	<select class="form-control selectForm selectpicker" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
				    		<c:if test="${customPackage.customerName ne ''}"><option value=""></option></c:if>
				    		<c:if test="${customPackage.customerName eq ''}"><option value=""></option></c:if>
				    		<c:forEach var="item" items="${customerName}">
								<option value="${item}" <c:if test="${item eq customPackage.customerName}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
			    </div>
			    <div class="pading5Width320">
					<div>
					 	<label class="labelFontSize">사업명</label>
					 	<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
					 </div>
					 <input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					 <div id="businessNameViewSelf">
					 	<select class="form-control selectForm selectpicker" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
					 		<c:if test="${customPackage.businessName ne ''}"><option value=""></option></c:if>
					 		<c:if test="${customPackage.businessName eq ''}"><option value=""></option></c:if>
					 		<c:forEach var="item" items="${businessName}">
								<option value="${item}" <c:if test="${item eq customPackage.businessName}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
			    </div>
				<div class="pading5Width320">
					<div>
						<label class="labelFontSize">패키지 종류</label><label class="colorRed">*</label>
						<a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a>
					</div>
					<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					<div id="managementServerViewSelf">
				     	<select class="form-control selectForm selectpicker" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
				     		<c:if test="${customPackage.managementServer ne ''}"><option value=""></option></c:if>
				     		<c:if test="${customPackage.managementServer eq ''}"><option value=""></option></c:if>
				     		<c:forEach var="item" items="${managementServer}">
								<option value="${item}" <c:if test="${item eq customPackage.managementServer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotManagementServer" style="display: none; line-height: initial;">패키지 종류를 선택 또는 입력해주세요.</span>
				</div>
				<div class="pading5Width320">
				    <div>`
						<label class="labelFontSize">Agent ver</label><label class="colorRed">*</label>
						<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					</div>
					<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					<div id="agentVerViewSelf">
				     	<select class="form-control selectForm selectpicker" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
				     		<c:if test="${customPackage.agentVer ne ''}"><option value=""></option></c:if>
				     		<c:if test="${customPackage.agentVer eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${agentVer}">
								<option value="${item}" <c:if test="${item eq customPackage.agentVer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotAgentVer" style="display: none; line-height: initial;">Version을 선택 또는 입력해주세요.</span>
				</div>
				<div class="pading5Width320">
			    	<div>
				 		<label class="labelFontSize">OS종류</label><label class="colorRed">*</label>
				 		<a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a>
				 	</div>
				 	<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
				 	<div id="osTypeViewSelf">
			           <select class="form-control selectForm selectpicker" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5">
				           	<c:if test="${customPackage.osType ne ''}"><option value=""></option></c:if>
				           	<c:if test="${customPackage.osType eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${osType}">
								<option value="${item}" <c:if test="${item eq customPackage.osType}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotOsType" style="display: none; line-height: initial;">OS타입을 선택 또는 입력해주세요.</span>
				</div>
			 </c:when>
		</c:choose>
		<div class="pading5Width320">
			<div>
				<label class="labelFontSize">릴리즈 노트</label><label class="colorRed">*</label>
			</div>
			<input class="form-control viewForm" type="file" name="releaseNotesView" id="releaseNotesView" />
			<span class="colorRed" id="NotreleaseNotesView" style="display: none; line-height: initial;">파일을 선택해 주세요.</span>
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
	
	/* =========== 커스텀 패키지 추가 ========= */
	$('#insertBtn').click(function() {
		var releaseNotesView = $('#releaseNotesView')[0];
		var managementServerView = $('#managementServerView').val();
		var managementServerSelf = $('#managementServerSelf').val();
		var agentVerView = $('#agentVerView').val();
		var agentVerSelf = $('#agentVerSelf').val();
		var osTypeView = $('#osTypeView').val();
		var osTypeSelf = $('#osTypeSelf').val();
		var customerNameView = $('#customerNameView').val();
		var customerNameSelf = $('#customerNameSelf').val();
		var businessNameView = $('#businessNameView').val();
		var businessNameSelf = $('#businessNameSelf').val();
		const postData = new FormData();
		
		postData.append('managementServerView',managementServerView);
		postData.append('managementServerSelf',managementServerSelf);
		postData.append('agentVerView',agentVerView);
		postData.append('agentVerSelf',agentVerSelf);
		postData.append('osTypeView',osTypeView);
		postData.append('osTypeSelf',osTypeSelf);
		postData.append('customerNameView',customerNameView);
		postData.append('customerNameSelf',customerNameSelf);
		postData.append('businessNameView',businessNameView);
		postData.append('businessNameSelf',businessNameSelf);
		postData.append('releaseNotesView',releaseNotesView.files[0]);
		
		if (releaseNotesView.value == "") {  
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '파일을 업로드해주세요.',
			});
			$('#NotreleaseNotesView').show();
		 	return false;  
		} 
		$('#NotreleaseNotesView').hide();
		
		// 파일 존재 유무 확인
		$.ajax({
            type: 'post',
            url: "<c:url value='/customPackage/existenceConfirmation'/>",
            async: false,
            processData: false,
	        contentType: false,
            data: postData,
            success: function (data) {
            	existenceConfirmation = data;
            },
        });
		
		// 동일한 이름의 파일이 존재할 경우 덮어쓰기 선택
		if(existenceConfirmation == "existence") {
			Swal.fire({
				  title: '덮어쓰기!',
				  text: "선택한 파일과 동일한 이름의 파일이 존재합니다. 덮어쓰기 하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
				if (result.isConfirmed) {
					insert(postData);	// insert
				}
			});
		} else {
			insert(postData);		// insert
		}
		
		
	});
	
	/* =========== 추가(중복 분리) ========= */
	function insert(postData) {
		$.ajax({
			url: "<c:url value='/customPackage/insert'/>",
	           type: 'post',
	           data: postData,
	           async: false,
	           processData: false,
	           contentType: false,
	           success: function(result) {
	        	    if(result.result == "NotCustomerName") {
	        	    	$('#NotCustomerName').show();
						$('#NotManagementServer').hide();
						$('#NotAgentVer').hide();
						$('#NotOsType').hide();
	        	    } else if(result.result == "NotManagementServer") { 
						$('#NotManagementServer').show();
						$('#NotAgentVer').hide();
						$('#NotCustomerName').hide();
						$('#NotOsType').hide();
					} else if (result.result == "NotAgentVer"){
						$('#NotAgentVer').show();
						$('#NotManagementServer').hide();
						$('#NotCustomerName').hide();
						$('#NotOsType').hide();
					} else if (result.result == "NotOsType"){
						$('#NotManagementServer').hide();
						$('#NotAgentVer').hide();
						$('#NotCustomerName').hide();
						$('#NotOsType').show();
					} 
		           	
					if(result.result == "OK") {
						$('#NotAgentVer').hide();
						$('#NotManagementServer').hide();
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
	}
	
	/* =========== 커스텀 패키지 수정 ========= */
	$('#updateBtn').click(function() {
		var releaseNotesView = $('#releaseNotesView')[0];
		var managementServerView = $('#managementServerView').val();
		var managementServerSelf = $('#managementServerSelf').val();
		var agentVerView = $('#agentVerView').val();
		var agentVerSelf = $('#agentVerSelf').val();
		var osTypeView = $('#osTypeView').val();
		var osTypeSelf = $('#osTypeSelf').val();
		var customerNameView = $('#customerNameView').val();
		var customerNameSelf = $('#customerNameSelf').val();
		var businessNameView = $('#businessNameView').val();
		var businessNameSelf = $('#businessNameSelf').val();
		var customPackageKeyNum = $('#customPackageKeyNum').val();
		const postData = new FormData();
		
		postData.append('managementServerView',managementServerView);
		postData.append('managementServerSelf',managementServerSelf);
		postData.append('agentVerView',agentVerView);
		postData.append('agentVerSelf',agentVerSelf);
		postData.append('osTypeView',osTypeView);
		postData.append('osTypeSelf',osTypeSelf);
		postData.append('customerNameView',customerNameView);
		postData.append('customerNameSelf',customerNameSelf);
		postData.append('businessNameView',businessNameView);
		postData.append('businessNameSelf',businessNameSelf);
		postData.append('customPackageKeyNum', customPackageKeyNum);
		postData.append('releaseNotesView',releaseNotesView.files[0]);
		
		if (releaseNotesView.value == "") {  
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '파일을 업로드해주세요.',
			});
			$('#NotreleaseNotesView').show();
		 	return false;  
		} 
		$('#NotreleaseNotesView').hide();
		
		// 파일 존재 유무 확인
		$.ajax({
            type: 'post',
            url: "<c:url value='/customPackage/existenceConfirmation'/>",
            async: false,
            processData: false,
	        contentType: false,
            data: postData,
            success: function (data) {
            	existenceConfirmation = data;
            },
        });
		
		// 동일한 이름의 파일이 존재할 경우 덮어쓰기 선택
		if(existenceConfirmation == "existence") {
			Swal.fire({
				  title: '덮어쓰기!',
				  text: "선택한 파일과 동일한 이름의 파일이 존재합니다. 덮어쓰기 하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
				if (result.isConfirmed) {
					update(postData);	// update
				}
			});
		} else {
			update(postData);		// update
		}
	});
	
	/* =========== 수정(중복 분리) ========= */
	function update(postData) {
		$.ajax({
            url: "<c:url value='/customPackage/update'/>",
            type: 'post',
            data: postData,
            async: false,
            processData: false,
	        contentType: false,
            success: function(result) {
            	if(result.result == "NotCustomerName") {
        	    	$('#NotCustomerName').show();
					$('#NotManagementServer').hide();
					$('#NotAgentVer').hide();
        	    } else if(result.result == "NotManagementServer") { 
					$('#NotManagementServer').show();
					$('#NotAgentVer').hide();
					$('#NotCustomerName').hide();
				} else if (result.result == "NotAgentVer"){
					$('#NotAgentVer').show();
					$('#NotManagementServer').hide();
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
						text: '작업을 실패했습니다.',    
					});  
				}
			},
			error: function(error) {
				console.log(error);
			}
        });
	}
	
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
		}
	}
	
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
</script>