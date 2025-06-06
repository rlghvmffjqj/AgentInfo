<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal-body" style="width: 100%; height: 800px;">
	<form id="modalForm" name="form" method ="post"> 
		<input type="hidden" id="departmentFullPath" name="departmentFullPath" class="form-control" value="${employee.departmentFullPath}">
		<c:choose>
			<c:when test="${viewType eq 'insert'}">
		        <div class="pading2">
		         	<label class="labelFontSize">사용자ID</label><label class="colorRed">*</label>
					<input type="text" id="employeeId" name="employeeId" class="form-control viewForm" value="${employee.employeeId}"> 
					<span class="colorRed fontSize10" id="NotEmployeeId" style="display: none">사원 번호를 입력해주세요.</span>
					<span class="colorRed fontSize10" id="duplicateCheck" style="display: none">동일한 사원 번호가 존재합니다.</span>
		         </div>
		    </c:when>
		    <c:when test="${viewType eq 'update'}">
		   		<div class="pading2">
		         	<label class="labelFontSize">사용자ID</label>
					<input type="text" id="employeeId" name="employeeId" class="form-control viewForm" value="${employee.employeeId}" readonly> 
					<span class="colorRed fontSize10" id="NotEmployeeId" style="display: none">사원 번호를 입력해주세요.</span>
		         </div>
		    </c:when>
		 </c:choose>
         <div class="pading2">
         	<label class="labelFontSize">사원명</label><label class="colorRed">*</label>
         	<input type="text" id="employeeName" name="employeeName" class="form-control viewForm" value="${employee.employeeName}">
         	<span class="colorRed fontSize10" id="NotEmployeeName" style="display: none">사원 이름을 입력해주세요.</span>
         </div>
         <c:choose>
			<c:when test="${viewType eq 'insert'}">
			     <div class="pading2">
					<label class="labelFontSize">패스워드</label><label class="colorRed">*</label>
					<input type="password" id="usersPw" name="usersPw" class="form-control viewForm" required> 
					<span class="colorRed fontSize10" id="NotUsersPw" style="display: none">패스워드를 입력해주세요.</span>
				 </div>
				 <div class="pading2">
					<label class="labelFontSize">패스워드 확인</label><label class="colorRed">*</label>
					<input type="password" id="usersPwRe" name="usersPwRe" class="form-control viewForm" required> 
					<span class="colorRed fontSize10" id="Inconsistency" style="display: none">패스워드가 일지하지 않습니다.</span>
				 </div>
			</c:when>
			<c:when test="${viewType eq 'update'}">
				<div class="pading2">
					<label class="labelFontSize">패스워드</label>
					<input type="password" id="usersPw" name="usersPw" class="form-control viewForm"> 
					<span class="fontSize10">※ 패스워드 변경 시 입력 바랍니다.</span>
				 </div>
				 <div class="pading2">
					<label class="labelFontSize">패스워드 확인</label>
					<input type="password" id="usersPwRe" name="usersPwRe" class="form-control viewForm"> 
					<span class="colorRed fontSize10" id="Inconsistency" style="display: none">패스워드가 일지하지 않습니다.</span>
				 </div>
			</c:when>
		 </c:choose>
		 <div class="pading2">
			<c:if test="${employee.usersLockStatus eq 0}">
				<label class="labelFontSize" style="width: 100%;">잠금 상태</label>
				<input type="text" id="usersLockStatus" name="usersLockStatus" class="form-control viewForm"  style="width: 83%; float: left; margin: 0;" value="사용" readonly>
				<button class="btn btn-default btn-outline-info-del" id="lock" type="button" style="float: right;	width: 17%;	margin: 0;">잠금</button>	
			</c:if>
			<c:if test="${employee.usersLockStatus eq 1}">
				<label class="labelFontSize" style="width: 100%;">잠금 상태</label>
				<input type="text" id="usersLockStatus" name="usersLockStatus" class="form-control viewForm"  style="width: 83%; float: left; margin: 0;" value="잠금" readonly>
				<button class="btn btn-default btn-outline-info-add" id="unlock" type="button" style="float: right;	width: 17%;	margin: 0;">잠금 해제</button>	
			</c:if>
		</div>
         <div class="pading2">
         	<label class="labelFontSize">부서명</label>
         	<input type="text" id="departmentName" name="departmentName" class="form-control viewForm" value="${employee.departmentName}" readonly>
         </div>
         <div class="pading2">
         	<label class="labelFontSize">전화번호</label>
         	<input type="text" id="employeePhone" name="employeePhone" class="form-control viewForm" value="${employee.employeePhone}">
         </div>
         <div class="pading2">
         	<label class="labelFontSize">이메일</label>
         	<input type="text" id="employeeEmail" name="employeeEmail" class="form-control viewForm" value="${employee.employeeEmail}">
         </div>
         <c:choose>
			<c:when test="${viewType eq 'insert'}">
				<div class="pading2">
		         	<label class="labelFontSize">직급</label>
		         	<select class="form-control viewForm selectpicker" id="employeeRank" name="employeeRank" data-live-search="true" data-size="5">
		         		<option value=""></option>
						<option value="연구원">연구원</option>
						<option value="전임">전임</option>
						<option value="선임">선임</option>
						<option value="차장">차장</option>
						<option value="책임">책임</option>
						<option value="실장">실장</option>
						<option value="소장">소장</option>
						<option value="본부장">본부장</option>
						<option value="대표">대표</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">타입</label>
		         	<select class="form-control viewForm selectpicker" id="employeeType" name="employeeType" data-live-search="true" data-size="5">
						<option value="정사원">정사원</option>
						<option value="외주">외주</option>
						<option value="인턴">인턴</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">상태</label>
		         	<select class="form-control viewForm selectpicker" id="employeeStatus" name="employeeStatus" data-live-search="true" data-size="5">
						<option value="재직">재직</option>
						<option value="퇴사">퇴사</option>
						<option value="휴직">휴직</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">역할</label>
		         	<select class="form-control viewForm selectpicker" id="usersRole" name="usersRole" data-live-search="true" data-size="5">
						<option value="USER">일반사용자</option>
						<option value="ADMIN">관리자</option>
						<option value="LICENSE">라이선스 관리자</option>
						<option value="ENGINEER">엔지니어</option>
						<option value="ENGINEERLEADER">엔지니어 팀장</option>
						<option value="SALES">영업</option>
						<option value="QA">QA</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">다음로그인시 암호변경</label><br>
		         	<input type="radio" id="pwdMustChange_yes" name="pwdChangeYn" value="YES" checked>&nbsp<label for="pwdMustChange_yes" style="margin-right: 45px;">YES</label>
		         	<input type="radio" id="pwdMustChange_no" name="pwdChangeYn" value="NO">&nbsp<label for="pwdMustChange_no">NO</label>
		        </div>
		    </c:when>
			<c:when test="${viewType eq 'update'}">
				<div class="pading2">
		         	<label class="labelFontSize">직급</label>
		         	<select class="form-control viewForm selectpicker" id="employeeRank" name="employeeRank" data-live-search="true" data-size="5">
		         		<c:if test="${packages.employeeRank ne ''}"><option value=""></option></c:if>
				        <c:if test="${packages.employeeRank eq ''}"><option value=""></option></c:if>
						<option value="연구원" <c:if test="${employee.employeeRank eq '연구원'}">selected</c:if>>연구원</option>
						<option value="전임" <c:if test="${employee.employeeRank eq '전임'}">selected</c:if>>전임</option>
						<option value="선임" <c:if test="${employee.employeeRank eq '선임'}">selected</c:if>>선임</option>
						<option value="차장" <c:if test="${employee.employeeRank eq '차장'}">selected</c:if>>차장</option>
						<option value="책임" <c:if test="${employee.employeeRank eq '책임'}">selected</c:if>>책임</option>
						<option value="실장" <c:if test="${employee.employeeRank eq '실장'}">selected</c:if>>실장</option>
						<option value="소장" <c:if test="${employee.employeeRank eq '소장'}">selected</c:if>>소장</option>
						<option value="본부장" <c:if test="${employee.employeeRank eq '본부장'}">selected</c:if>>본부장</option>
						<option value="대표" <c:if test="${employee.employeeRank eq '대표'}">selected</c:if>>대표</option>
					</select>
		         </div>
				<div class="pading2">
		         	<label class="labelFontSize">타입</label>
		         	<select class="form-control viewForm selectpicker" id="employeeType" name="employeeType" data-live-search="true" data-size="5">
						<option value="정사원" <c:if test="${employee.employeeType eq '정사원'}">selected</c:if>>정사원</option>
						<option value="외주" <c:if test="${employee.employeeType eq '외주'}">selected</c:if>>외주</option>
						<option value="인턴" <c:if test="${employee.employeeType eq '인턴'}">selected</c:if>>인턴</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">상태</label>
		         	<select class="form-control viewForm selectpicker" id="employeeStatus" name="employeeStatus" data-live-search="true" data-size="5">
						<option value="재직" <c:if test="${employee.employeeStatus eq '재직'}">selected</c:if>>재직</option>
						<option value="퇴사" <c:if test="${employee.employeeStatus eq '퇴사'}">selected</c:if>>퇴사</option>
						<option value="휴직" <c:if test="${employee.employeeStatus eq '휴직'}">selected</c:if>>휴직</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">역할</label>
		         	<select class="form-control viewForm selectpicker" id="usersRole" name="usersRole" data-live-search="true" data-size="5">
						<option value="USER" <c:if test="${employee.usersRole eq 'USER'}">selected</c:if>>일반사용자</option>
						<option value="ADMIN" <c:if test="${employee.usersRole eq 'ADMIN'}">selected</c:if>>관리자</option>
						<option value="LICENSE" <c:if test="${employee.usersRole eq 'LICENSE'}">selected</c:if>>라이선스 관리자</option>
						<option value="ENGINEER" <c:if test="${employee.usersRole eq 'ENGINEER'}">selected</c:if>>엔지니어</option>
						<option value="ENGINEERLEADER" <c:if test="${employee.usersRole eq 'ENGINEERLEADER'}">selected</c:if>>엔지니어 팀장</option>
						<option value="SALES" <c:if test="${employee.usersRole eq 'SALES'}">selected</c:if>>영업</option>
						<option value="QA" <c:if test="${employee.usersRole eq 'QA'}">selected</c:if>>QA</option>
					</select>
		         </div>
		         <div class="pading2">
		         	<label class="labelFontSize">다음로그인시 암호변경</label><br>
		         	<input type="radio" id="pwdMustChange_yes" name="pwdChangeYn" value="YES" <c:if test="${employee.pwdChangeYn eq 'YES'}">checked</c:if>>&nbsp<label for="pwdMustChange_yes" style="margin-right: 45px;">YES</label>
		         	<input type="radio" id="pwdMustChange_no" name="pwdChangeYn" value="NO" <c:if test="${employee.pwdChangeYn eq 'NO'}">checked</c:if>>&nbsp<label for="pwdMustChange_no">NO</label>
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

	/* =========== 사용자 추가 ========= */
	$('#insertBtn').click(function() {
		var pwd = $('#usersPw').val();
		var pwdRe = $('#usersPwRe').val();
		
		if(pwd != pwdRe) {
			Swal.fire({               
    			icon: 'error',          
    			title: '실패!',           
    			text: '패스워드가 일치 하지 않습니다.',    
    		}); 
			$('.colorRed').hide();
			$('#Inconsistency').show();	
		} else {
			var postData = $('#modalForm').serializeObject();
			$.ajax({
				url: "<c:url value='/employee/insert'/>",
	            type: 'post',
	            data: postData,
	            async: false,
	            success: function(result) {
	            	if(result.result == "NotEmployeeId") { // 사원 번호 미 입력 알림.
	            		$('.colorRed').hide();
						$('#NotEmployeeId').show();
	            		true;
					} else if (result.result != "NotEmployeeId"){
						$('#NotEmployeeId').hide();
					} 
					
	            	if(result.result == "NotEmployeeName") { // 사원 이름 미 입력 알림.
	            		$('.colorRed').hide();
						$('#NotEmployeeName').show();
						true;
					} else {
						$('#NotEmployeeName').hide();
					}
	            	
	            	if(result.result == "NotUsersPw") { // 패스워드 미 입력 알림.
	            		$('.colorRed').hide();
	            		$('#NotUsersPw').show();
						true;
					} else {
						$('#NotUsersPw').hide();
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
					} else if(result.result == "duplicateCheck") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '동일한 사원 번호가 존재합니다.',
						});
						$('.colorRed').hide();
						$('#duplicateCheck').show();
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
	});
	
	/* =========== 사용자 정보 수정 ========= */
	$('#updateBtn').click(function() {
		var pwd = $('#usersPw').val();
		var pwdRe = $('#usersPwRe').val();
		if(pwd != null) {
			if(pwd != pwdRe) {
				Swal.fire({               
	    			icon: 'error',          
	    			title: '실패!',           
	    			text: '패스워드가 일치 하지 않습니다.',    
	    		}); 
				$('#Inconsistency').show();	
				$('#NotEmployeeName').hide();
			} else {
				update();
			} 
		} else {
			update();
		}
	});
	
	/* =========== update 중복 코드 분리 ========= */
	function update() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
            url: 'update',
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
				if(result.result == "NotEmployeeName") {  // 사원 이름 미 입력 알림.
					$('#NotEmployeeName').show();
					$('#Inconsistency').hide();	
				} else {
					$('#NotEmployeeName').hide();
				}
			},
			error: function(error) {
				console.log(error);
			}
        });
	};

	$('#lock').click(function() {
		var employeeId = "${employee.employeeId}";
		lockChange(employeeId, "lock");
	});

	$('#unlock').click(function() {
		var employeeId = "${employee.employeeId}";
		lockChange(employeeId, "unlock");
	});

	function lockChange(employeeId, type) {
		var titleText = "잠금";
		if(type == 'unlock') {
			titleText = "잠금 해제";
		}
		Swal.fire({
			  title: titleText,
			  text: "선택한 사원을 " + titleText + "하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#7066e0',
			  cancelButtonColor: '#FF99AB',
			  confirmButtonText: 'OK'
		}).then((result) => {
		  if (result.isConfirmed) {
			  $.ajax({
				url: "<c:url value='/users/lockChange'/>",
				type: "POST",
				data: {
					"employeeId" : employeeId,
					"type" : type
				},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data != "OK") {
						Swal.fire(
						  '실패!',
						  '작업 처리 실패하였습니다.',
						  'error'
						)
					}
					$('#modal').modal("hide"); // 모달 닫기
            		$('#modal').on('hidden.bs.modal', function () {
            			tableRefresh();
						updateView(employeeId);
					});
				},
				error: function(error) {
					console.log(error);
				}
			  });
		  	}
		})
	}
</script>