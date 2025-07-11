<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="modal-body" style="width: 100%; height: auto; padding-top: 5%;">
	<div class="card-block margin10" id="templateList">
		<c:forEach var="item" items="${resultsReportTemplatList}">
  		  <button class="btn btn-default btn-outline-info-add serviceControlTypeBtn serviceBtnBoldColor" id="${item.resultsReportNumber}" onclick="templatSelect('${item.resultsReportKeyNum}')">${item.resultsReportCustomerName}</button>
  		</c:forEach>
     </div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	function templatSelect(resultsReportNumber) {
		location.href="<c:url value='/resultsReport/copyView'/>?resultsReportNumber="+resultsReportNumber;		
	}

</script>

<style>
	.serviceControlTypeBtn {
		width: 100%;
		height: 38px;
		margin-bottom: 2%;
		font-size: 14px;
	}

	.serviceBtnBoldColor {
		border-color: #003eff4f;
	}

	.serviceBtnBoldColor:hover {
		background-color: #0000ffa3;
		border-color: white;
	}
</style>

