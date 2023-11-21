<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 750px; overflow: scroll;">
	<div style="float: left; font-weight: bold; color: #012181;">${fileRute}</div>
	<div class="checkSelect">
		<input class="cssCheck" type="checkbox" id="ChkTotal">
    	<label for="ChkTotal"></label><span class="margin17">ALL</span>
		<input class="cssCheck" type="checkbox" id="ChkNormal" name="chkSelectBox" value="NORMAL">
    	<label for="ChkNormal"></label><span class="margin17">NORMAL</span>
    	<input class="cssCheck" type="checkbox" id="ChkChange" name="chkSelectBox" value="CHANGE">
    	<label for="ChkChange"></label><span class="margin17">CHANGE</span>
    	<input class="cssCheck" type="checkbox" id="ChkDelete" name="chkSelectBox" value="DELETE">
    	<label for="ChkDelete"></label><span class="margin17">DELETE</span>
		<input class="cssCheck" type="checkbox" id="ChkInsert" name="chkSelectBox" value="INSERT">
    	<label for="ChkInsert"></label><span class="margin17">INSERT</span>
	</div>
	<c:forEach var="diffRow" items="${diffRows}">
		<c:if test="${not empty diffRow.oldLine or not empty diffRow.newLine}">
			<div class="checkDiv ${diffRow.tag == 'CHANGE' ? 'changeDiv' : (diffRow.tag == 'DELETE' ? 'deleteDiv' : (diffRow.tag == 'EQUAL' ? 'equalDiv' : (diffRow.tag == 'INSERT' ? 'insertDiv' : '')))}">
        		<span class="changeType">
					<c:if test="${diffRow.tag eq 'INSERT'}">INSERT</c:if>
					<c:if test="${diffRow.tag eq 'CHANGE'}">UPDATE</c:if>
					<c:if test="${diffRow.tag eq 'DELETE'}">DELETE</c:if>
					<c:if test="${diffRow.tag eq 'EQUAL'}">NORMAL</c:if>
				</span>
				<br>
        		<span class="${diffRow.tag == 'CHANGE' ? 'change' : (diffRow.tag == 'DELETE' ? 'delete' : (diffRow.tag == 'EQUAL' ? 'equal' : (diffRow.tag == 'INSERT' ? 'insert' : '')))}">${diffRow.oldLine}</span>
				<br>
        		<span class="${diffRow.tag == 'CHANGE' ? 'change' : (diffRow.tag == 'DELETE' ? 'delete' : (diffRow.tag == 'EQUAL' ? 'equal' : (diffRow.tag == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine}</span>
				<br><br><br>
			</div>
		</c:if>
    </c:forEach>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$(function() {
		$("input:checkbox[id='ChkTotal']").prop("checked", true);
		$("input:checkbox[id='ChkNormal']").prop("checked", true);
		$("input:checkbox[id='ChkChange']").prop("checked", true);
		$("input:checkbox[id='ChkDelete']").prop("checked", true);
		$("input:checkbox[id='ChkInsert']").prop("checked", true);
	});

	/* =========== Total 체크박스 ========= */
	$("#ChkTotal").change(function(){
		if($("#ChkTotal").is(":checked")){
			$("input:checkbox[id='ChkNormal']").prop("checked", true);
			$("input:checkbox[id='ChkChange']").prop("checked", true);
			$("input:checkbox[id='ChkDelete']").prop("checked", true);
			$("input:checkbox[id='ChkInsert']").prop("checked", true);
			$('.checkDiv').show();

		}else{
			$("input:checkbox[id='ChkNormal']").prop("checked", false);
			$("input:checkbox[id='ChkChange']").prop("checked", false);
			$("input:checkbox[id='ChkDelete']").prop("checked", false);
			$("input:checkbox[id='ChkInsert']").prop("checked", false);
			$('.checkDiv').hide();
		}
	});
	 
	/* =========== NORMAL 보기 ========= */
	$("#ChkNormal").change(function(){
		selectChkView("ChkNormal","equalDiv");
	});
	
	/* =========== CHANGE 보기 ========= */
	$("#ChkChange").change(function(){
		selectChkView("ChkChange","changeDiv");
	});
	
	/* =========== DELETE 보기 ========= */
	$("#ChkDelete").change(function(){
		selectChkView("ChkDelete","deleteDiv");
	});

	/* =========== INSERT 보기 ========= */
	$("#ChkInsert").change(function(){
		selectChkView("ChkInsert","insertDiv");
	});
	
	/* =========== NORMAL, CHANGE, DELETE 보기/숨기기 기능 ========= */
	function selectChkView(id, classDiv) {
		if($("#"+id).is(":checked")) {
			$('.'+classDiv).show();
		}else{
			$('.'+classDiv).hide();
		}
	}
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

	.insert {
		color: green;
	}

	.changeType {
		color: black;
		font-weight: bold;
    	text-decoration: underline;
	}

	.checkSelect { 
		width: 100%;
    	height: 30px;
    	border-bottom: 1px dashed;
    	text-align: right;
    	margin-bottom: 10px;
	}
</style>