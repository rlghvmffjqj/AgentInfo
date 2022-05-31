<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

	<div class="modal-content animated fadeIn">
		<div class="modal-header noticeHeader">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">닫기</span></button>
			<h4 class="modal-title">요청 사항</h4>
		</div>
		<div class="modal-body">
			<div class="margin50 alignCenter">
				<a href="<c:url value='/requests/list'/>" id="appr" style="text-decoration:none;color:#000000;">
					<span class="cnt">${request}건</span>
				</a>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" id="hideTodayBtn" onClick="hideTodayBtn()"><i class="fa fa-check"></i> 오늘만 보지 않기</button>
			<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
		</div>
	</div>

<script>
	/* =========== 오늘 하루 보지 않기 ========= */
	$('#hideTodayBtn').click(function() {
		$.cookie('notice','no', {expires: 1});
		$('#modal').modal("hide"); // 모달 닫기
	});

</script>

