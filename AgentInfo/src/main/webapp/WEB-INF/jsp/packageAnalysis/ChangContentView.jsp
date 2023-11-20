<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 750px; overflow: scroll;">
	<c:forEach var="diffRow" items="${diffRows}">
		<c:if test="${diffRow.oldLine ne '' && diffRow.newLine ne ''}">
        	<span class="changeType">
				<c:if test="${diffRow.tag eq 'CHANGE'}">UPDATE</c:if>
				<c:if test="${diffRow.tag eq 'DELETE'}">DELETE</c:if>
				<c:if test="${diffRow.tag eq 'EQUAL'}">NORMAL</c:if>
			</span>
			<br>
        	<span class="${diffRow.tag == 'CHANGE' ? 'change' : (diffRow.tag == 'DELETE' ? 'delete' : (diffRow.tag == 'EQUAL' ? 'equal' : ''))}">${diffRow.oldLine}</span>
			<br>
        	<span class="${diffRow.tag == 'CHANGE' ? 'change' : (diffRow.tag == 'DELETE' ? 'delete' : (diffRow.tag == 'EQUAL' ? 'equal' : ''))}">${diffRow.newLine}</span>
			<br><br><br>
		</c:if>
    </c:forEach>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	
</script>
<style>
	.change {
		color: blue;
	}

	.delete {
		color: red;
	}

	.equal {
		color: black;
	}

	.changeType {
		color: black;
		font-weight: bold;
    	text-decoration: underline;
	}
</style>