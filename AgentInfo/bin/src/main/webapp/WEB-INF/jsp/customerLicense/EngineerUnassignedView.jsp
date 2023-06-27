<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 300px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="customerInfoKeyNum" name="customerInfoKeyNum" class="form-control viewForm" value="${customerInfo.customerInfoKeyNum}">
		<div id="sales">
			
		</div>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="updateBtn">배정</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<!-- 기본 스크립트 -->
<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	
</script>

