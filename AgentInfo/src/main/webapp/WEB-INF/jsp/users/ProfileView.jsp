<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 600px;">
	<form id="modalForm" name="form" method ="post"> 
		 <div class="pading5">
		  	<label class="labelFontSize">사용자ID</label>
			<input type="text" id="employeeId" name="employeeId" class="form-control viewForm" value="${employee.employeeId}" readonly> 
		 </div>
         <div class="pading5">
         	<label class="labelFontSize">사원명</label>
         	<input type="text" id="employeeName" name="employeeName" class="form-control viewForm" value="${employee.employeeName}" readonly>
         </div>
         <div class="pading5">
         	<label class="labelFontSize">부서명</label>
         	<input type="text" id="departmentName" name="departmentName" class="form-control viewForm" value="${employee.departmentName}" readonly>
         </div>
         <div class="pading5">
         	<label class="labelFontSize">전화번호</label>
         	<input type="text" id="employeePhone" name="employeePhone" class="form-control viewForm" value="${employee.employeePhone}" readonly>
         </div>
         <div class="pading5">
         	<label class="labelFontSize">이메일</label>
         	<input type="text" id="employeeEmail" name="employeeEmail" class="form-control viewForm" value="${employee.employeeEmail}" readonly>
         </div>
         <div class="pading5">
         	<label class="labelFontSize">직급</label>
			<input type="text" id="employeeRank" name="employeeRank" class="form-control viewForm" value="${employee.employeeRank}" readonly>
         </div>
		 <div class="pading5">
		 	<label class="labelFontSize">타입</label>
			<input type="text" id="employeeType" name="employeeType" class="form-control viewForm" value="${employee.employeeType}" readonly>
		  </div>
		  <div class="pading5">
		  	<label class="labelFontSize">상태</label>
			<input type="text" id="employeeStatus" name="employeeStatus" class="form-control viewForm" value="${employee.employeeStatus}" readonly>
		  </div>
		  <div class="pading5">
		  	<label class="labelFontSize">역할</label>
			<input type="text" id="usersRole" name="usersRole" class="form-control viewForm" value="${employee.usersRole}" readonly>
		 </div>
	</form>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

