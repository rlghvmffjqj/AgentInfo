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
		<c:if test="${not empty diffRow.oldLine1 or not empty diffRow.newLine1}">
			<div class="checkDiv ${diffRow.tag1 == 'CHANGE' ? 'changeDiv' : (diffRow.tag1 == 'DELETE' ? 'deleteDiv' : (diffRow.tag1 == 'EQUAL' ? 'equalDiv' : (diffRow.tag1 == 'INSERT' ? 'insertDiv' : '')))}">
        		<span class="changeType">
					<c:if test="${diffRow.tag1 eq 'INSERT'}">INSERT</c:if>
					<c:if test="${diffRow.tag1 eq 'CHANGE'}">UPDATE</c:if>
					<c:if test="${diffRow.tag1 eq 'DELETE'}">DELETE</c:if>
					<c:if test="${diffRow.tag1 eq 'EQUAL'}">NORMAL</c:if>
				</span>
				<br>
        		<label class="resultLabel">기존 패키지 &nbsp;&nbsp;: &nbsp;</label><span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.oldLine1}</span>
				<br>
        		<label class="resultLabel">변경 패키지1 : &nbsp;</label><span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine1}</span>
				<br>
				<label class="resultLabel">변경 패키지2 : &nbsp;</label><span class="${diffRow.tag2 == 'CHANGE' ? 'change' : (diffRow.tag2 == 'DELETE' ? 'delete' : (diffRow.tag2 == 'EQUAL' ? 'equal' : (diffRow.tag2 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine2}</span>
				<br>
				<label class="resultLabel">변경 패키지3 : &nbsp;</label><span class="${diffRow.tag3 == 'CHANGE' ? 'change' : (diffRow.tag3 == 'DELETE' ? 'delete' : (diffRow.tag3 == 'EQUAL' ? 'equal' : (diffRow.tag3 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine3}</span>
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

	.resultLabel {
		margin-bottom: 0;
		margin-top: 3px;
		color: black;
	}
</style>