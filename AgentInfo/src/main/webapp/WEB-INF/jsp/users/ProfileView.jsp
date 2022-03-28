<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	/* =========== ajax _csrf 전송 ========= */
	/* $(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	}); */
</script>

<div class="modal-body" style="width: 100%; height: 720px;">
	<form id="modalForm" name="form" method ="post"> 
		 <div class="pading5">
		  	<label class="labelFontSize">사원번호</label>
			<input type="text" id="employeeId" name="employeeId" class="form-control viewForm" value="${employee.employeeId}" readonly> 
		 </div>
         <div class="pading5">
         	<label class="labelFontSize">사원명</label>
         	<input type="text" id="employeeName" name="employeeName" class="form-control viewForm" value="${employee.employeeName}">
         </div>
         <div class="pading5">
         	<label class="labelFontSize">부서명</label>
         	<input type="text" id="departmentName" name="departmentName" class="form-control viewForm" value="${employee.departmentName}">
         </div>
         <div class="pading5">
         	<label class="labelFontSize">전화번호</label>
         	<input type="text" id="employeePhone" name="employeePhone" class="form-control viewForm" value="${employee.employeePhone}">
         </div>
         <div class="pading5">
         	<label class="labelFontSize">이메일</label>
         	<input type="text" id="employeeEmail" name="employeeEmail" class="form-control viewForm" value="${employee.employeeEmail}">
         </div>
         <div class="pading5">
         	<label class="labelFontSize">직급</label>
			<input type="text" id="employeeRank" name="employeeRank" class="form-control viewForm" value="${employee.employeeRank}">
         </div>
		 <div class="pading5">
		 	<label class="labelFontSize">타입</label>
			<input type="text" id="employeeType" name="employeeType" class="form-control viewForm" value="${employee.employeeType}">
		  </div>
		  <div class="pading5">
		  	<label class="labelFontSize">상태</label>
			<input type="text" id="employeeStatus" name="employeeStatus" class="form-control viewForm" value="${employee.employeeStatus}">
		  </div>
		  <div class="pading5">
		  	<label class="labelFontSize">역할</label>
			<input type="text" id="usersRole" name="usersRole" class="form-control viewForm" value="${employee.usersRole}">
		 </div>
	</form>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>


	
	
	
	