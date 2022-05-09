<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 300px;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="generalPackageKeyNum" name=generalPackageKeyNum class="form-control viewForm" value="${generalPackage.generalPackageKeyNum}">
		<c:choose>
			<c:when test="${viewType eq 'insert'}">
				<div class="pading5Width320">
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
					 <span class="colorRed" id="NotManagementServer" style="display: none; line-height: initial;">패키지 종류를 선택 또는 입력해주세요.</span>
				 </div>
				 <div class="pading5Width320">
					 <div>
					 	<label class="labelFontSize">Agent ver</label>
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
					 	<label class="labelFontSize">릴리즈 노트</label>
					 </div>
					 <input class="form-control viewForm" type="file" name="releaseNotesView" id="releaseNotesView" />
					 <span class="colorRed" id="NotreleaseNotesView" style="display: none; line-height: initial;">파일을 선택해 주세요.</span>
				 </div>
			</c:when>
			<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
				<div class="pading5Width320">
					<div>
						<label class="labelFontSize">패키지 종류</label>
						<a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a>
					</div>
					<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					<div id="managementServerViewSelf">
				     	<select class="form-control selectForm selectpicker" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
				     		<c:if test="${generalpackage.managementServer ne ''}"><option value=""></option></c:if>
				     		<c:if test="${generalpackage.managementServer eq ''}"><option value=""></option></c:if>
				     		<c:forEach var="item" items="${managementServer}">
								<option value="${item}" <c:if test="${item eq generalPackage.managementServer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotManagementServer" style="display: none; line-height: initial;">패키지 종류를 선택 또는 입력해주세요.</span>
				</div>
				<div class="pading5Width320">
				    <div>
						<label class="labelFontSize">Agent ver</label>
						<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					</div>
					<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					<div id="agentVerViewSelf">
				     	<select class="form-control selectForm selectpicker" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
				     		<c:if test="${generalpackage.agentVer ne ''}"><option value=""></option></c:if>
				     		<c:if test="${generalpackage.agentVer eq ''}"><option value=""></option></c:if>
							<c:forEach var="item" items="${agentVer}">
								<option value="${item}" <c:if test="${item eq generalPackage.agentVer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
					<span class="colorRed" id="NotAgentVer" style="display: none; line-height: initial;">Version을 선택 또는 입력해주세요.</span>
				</div>
				<div class="pading5Width320">
					 <div>
					 	<label class="labelFontSize">릴리즈 노트</label>
					 </div>
					 <input class="form-control viewForm" type="file" name="releaseNotesView" id="releaseNotesView" />
					 <span class="colorRed" id="NotreleaseNotesView" style="display: none; line-height: initial;">파일을 선택해 주세요.</span>
				 </div>
			 </c:when>
		</c:choose>
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
	
	/* =========== 일반 패키지 추가 ========= */
	$('#insertBtn').click(function() {
		var releaseNotesView = $('#releaseNotesView')[0];
		var managementServerView = $('#managementServerView').val();
		var managementServerSelf = $('#managementServerSelf').val();
		var agentVerView = $('#agentVerView').val();
		var agentVerSelf = $('#agentVerSelf').val();
		const postData = new FormData();
		
		postData.append('managementServerView',managementServerView);
		postData.append('managementServerSelf',managementServerSelf);
		postData.append('agentVerView',agentVerView);
		postData.append('agentVerSelf',agentVerSelf);
		postData.append('releaseNotesView',releaseNotesView.files[0]);
		
		if (form.releaseNotesView.value == "") {  
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '파일을 업로드해주세요.',
			});
			$('#NotreleaseNotesView').show();
		 	return false;  
		} 
		$('#NotreleaseNotesView').hide();
		
		$.ajax({
			url: "<c:url value='/generalPackage/insert'/>",
	           type: 'post',
	           data: postData,
	           async: false,
	           processData: false,
	           contentType: false,
	           success: function(result) {
		           	if(result.result == "NotManagementServer") { 
						$('#NotManagementServer').show();
						$('#NotAgentVer').hide();
					} else if (result.result == "NotAgentVer"){
						$('#NotManagementServer').hide();
						$('#NotAgentVer').show();
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
	});
	
	/* =========== 일반패키지 수정 ========= */
	$('#updateBtn').click(function() {
		var releaseNotesView = $('#releaseNotesView')[0];
		var managementServerView = $('#managementServerView').val();
		var managementServerSelf = $('#managementServerSelf').val();
		var agentVerView = $('#agentVerView').val();
		var agentVerSelf = $('#agentVerSelf').val();
		var generalPackageKeyNum = $('#generalPackageKeyNum').val();
		const postData = new FormData();
		
		postData.append('managementServerView',managementServerView);
		postData.append('managementServerSelf',managementServerSelf);
		postData.append('agentVerView',agentVerView);
		postData.append('agentVerSelf',agentVerSelf);
		postData.append('generalPackageKeyNum', generalPackageKeyNum);
		postData.append('releaseNotesView',releaseNotesView.files[0]);
		
		if (form.releaseNotesView.value == "") {  
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '파일을 업로드해주세요.',
			});
			$('#NotreleaseNotesView').show();
		 	return false;  
		} 
		$('#NotreleaseNotesView').hide();
		
		$.ajax({
            url: "<c:url value='/generalPackage/update'/>",
            type: 'post',
            data: postData,
            async: false,
            processData: false,
	        contentType: false,
            success: function(result) {
            	if(result.result == "NotManagementServer") { 
					$('#NotManagementServer').show();
					$('#NotAgentVer').hide();
				} else if (result.result == "NotAgentVer"){
					$('#NotManagementServer').hide();
					$('#NotAgentVer').show();
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
	});
	
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
		}
	}
	
</script>
	
