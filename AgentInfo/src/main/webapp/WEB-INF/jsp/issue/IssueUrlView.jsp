<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<!-- SummerNote -->
<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
<div class="modelHead">
	<div class="modelHeadFont">이슈 상세 URL</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 155px;">
	<div style="text-align: center; margin-top: 7%;">
		<a href="${url}" style="font-size: 19px; font-weight: bold;" onclick="copyToClipboard('${url}\n\n고객사 : ${issueCustomer}\n타이틀 : ${issueTitle}'); return false;">${url}</a><br><br>
		<span id="titleSpan">고객사 : ${issueCustomer}</span><br><br>
		<span id="titleSpan">타이틀 : ${issueTitle}</span>
		<div id="copyMessage">URL이 클립보드에 복사되었습니다.</div>
	</div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	function copyToClipboard(text) {
		navigator.clipboard.writeText(text).then(function() {
            $("#copyMessage").fadeIn(200).delay(2000).fadeOut(200);
        }).catch(function(err) {
            console.error('복사 실패: ', err);
        });
    }

</script>
<style>
	#copyMessage {
		display: none;
    	position: fixed;
    	top: -25%;
    	left: 50%;
    	transform: translate(-50%, -50%);
    	background-color: #ffffff;
    	padding: 10px;
    	border: 1px solid #ccc;
    	border-radius: 5px;
    	color: deeppink;
	}

	#titleSpan {
		float: left;
    	margin-left: 15px;
    	font-size: 17px;
    	color: black;
    	font-weight: bold;
	}

</style>