<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 750px;">
	<div style="float: left; font-weight: bold; color: #012181;">${fileRute}</div>
	<div class="checkSelect">
		<input class="cssCheck" type="checkbox" id="ChkChangeLine">
    	<label for="ChkChangeLine"></label><span class="margin17">변경 코드 조회</span>
	</div>
	<div style="overflow: scroll; height: 690px;">

		<c:forEach var="diffRow" items="${diffRows}">
			<c:if test="${not empty diffRow.oldLine1 or not empty diffRow.newLine1}">
				<c:choose>
    				<c:when test="${diffRow.newLine2 eq '' && diffRow.newLine3 eq '' }">
						<div class="checkDiv ${diffRow.tag1 == 'CHANGE' ? 'changeDiv' : (diffRow.tag1 == 'INSERT' ? 'changeDiv' : (diffRow.tag1 == 'DELETE' ? 'changeDiv' : 'normalDiv'))}">
							<span class="changeType">
								${diffRow.tag1 == 'CHANGE' ? '변경 코드' : (diffRow.tag1 == 'INSERT' ? '변경 코드' : (diffRow.tag1 == 'DELETE' ? '변경 코드' : '일반 코드'))}
							</span>
							<br>
    	    				<label class="resultLabel">기존 패키지(${diffRow.tag1}) &nbsp;&nbsp;: &nbsp;</label>
							<span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.oldLine1}</span>
							<br>
    	    				<label class="resultLabel">변경 패키지1(${diffRow.tag1}) : &nbsp;</label>
							<span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine1}</span>
							<br><br><br>
						</div>
					</c:when>
					<c:when test="${diffRow.newLine2 ne '' && diffRow.newLine3 eq ''}">
						<div class="checkDiv ${diffRow.tag1 == 'CHANGE' ? 'changeDiv' : (diffRow.tag2 == 'CHANGE' ? 'changeDiv' : (diffRow.tag1 == 'INSERT' ? 'changeDiv' : (diffRow.tag2 == 'INSERT' ? 'changeDiv' : (diffRow.tag1 == 'DELETE' ? 'changeDiv' : (diffRow.tag2 == 'DELETE' ? 'changeDiv' : 'normalDiv')))))}">
							<span class="changeType">
								${diffRow.tag1 == 'CHANGE' ? '변경 코드' : (diffRow.tag2 == 'CHANGE' ? '변경 코드' : (diffRow.tag1 == 'INSERT' ? '변경 코드' : (diffRow.tag2 == 'INSERT' ? '변경 코드' : (diffRow.tag1 == 'DELETE' ? '변경 코드' : (diffRow.tag2 == 'DELETE' ? '변경 코드' : '일반 코드')))))}
							</span>
							<br>
    	    				<label class="resultLabel">기존 패키지(${diffRow.tag1}) &nbsp;&nbsp;: &nbsp;</label>
							<span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.oldLine1}</span>
							<br>
    	    				<label class="resultLabel">변경 패키지1(${diffRow.tag1}) : &nbsp;</label>
							<span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine1}</span>
							<c:if test="${diffRow.newLine2 ne ''}">
								<br>
								<label class="resultLabel">변경 패키지2(${diffRow.tag2}) : &nbsp;</label>
								<span class="${diffRow.tag2 == 'CHANGE' ? 'change' : (diffRow.tag2 == 'DELETE' ? 'delete' : (diffRow.tag2 == 'EQUAL' ? 'equal' : (diffRow.tag2 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine2}</span>
							</c:if>
							<br><br><br>
						</div>
					</c:when>
					<c:otherwise>
						<div class="checkDiv ${diffRow.tag1 == 'CHANGE' ? 'changeDiv' : (diffRow.tag2 == 'CHANGE' ? 'changeDiv' : (diffRow.tag3 == 'CHANGE' ? 'changeDiv' : (diffRow.tag1 == 'INSERT' ? 'changeDiv' : (diffRow.tag2 == 'INSERT' ? 'changeDiv' : (diffRow.tag3 == 'INSERT' ? 'changeDiv' : (diffRow.tag1 == 'DELETE' ? 'changeDiv' : (diffRow.tag2 == 'DELETE' ? 'changeDiv' : (diffRow.tag3 == 'DELETE' ? 'changeDiv' : 'normalDiv'))))))))}">
							<span class="changeType">
								${diffRow.tag1 == 'CHANGE' ? '변경 코드' : (diffRow.tag2 == 'CHANGE' ? '변경 코드' : (diffRow.tag3 == 'CHANGE' ? '변경 코드' : (diffRow.tag1 == 'INSERT' ? '변경 코드' : (diffRow.tag2 == 'INSERT' ? '변경 코드' : (diffRow.tag3 == 'INSERT' ? '변경 코드' : (diffRow.tag1 == 'DELETE' ? '변경 코드' : (diffRow.tag2 == 'DELETE' ? '변경 코드' : (diffRow.tag3 == 'DELETE' ? '변경 코드' : '일반 코드'))))))))}
							</span>
							<br>
    	    				<label class="resultLabel">기존 패키지(${diffRow.tag1}) &nbsp;&nbsp;: &nbsp;</label>
							<span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.oldLine1}</span>
							<br>
    	    				<label class="resultLabel">변경 패키지1(${diffRow.tag1}) : &nbsp;</label>
							<span class="${diffRow.tag1 == 'CHANGE' ? 'change' : (diffRow.tag1 == 'DELETE' ? 'delete' : (diffRow.tag1 == 'EQUAL' ? 'equal' : (diffRow.tag1 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine1}</span>
							<c:if test="${diffRow.newLine2 ne '' && diffRow.newLine2 ne null}">
								<br>
								<label class="resultLabel">변경 패키지2(${diffRow.tag2}) : &nbsp;</label>
								<span class="${diffRow.tag2 == 'CHANGE' ? 'change' : (diffRow.tag2 == 'DELETE' ? 'delete' : (diffRow.tag2 == 'EQUAL' ? 'equal' : (diffRow.tag2 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine2}</span>
							</c:if>
							<c:if test="${diffRow.newLine3 ne '' && diffRow.newLine3 ne null}">
								<br>
								<label class="resultLabel">변경 패키지3(${diffRow.tag3}) : &nbsp;</label>
								<span class="${diffRow.tag3 == 'CHANGE' ? 'change' : (diffRow.tag3 == 'DELETE' ? 'delete' : (diffRow.tag3 == 'EQUAL' ? 'equal' : (diffRow.tag3 == 'INSERT' ? 'insert' : '')))}">${diffRow.newLine3}</span>
							</c:if>
							<br><br><br>
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>
    	</c:forEach>
	</div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script> 
	/* =========== 변경 라인 보기 ========= */
	$("#ChkChangeLine").change(function(){
		if($("#ChkChangeLine").is(":checked")) {
			$(".normalDiv").hide();
		}else{
			$(".normalDiv").show();
		}
	});
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