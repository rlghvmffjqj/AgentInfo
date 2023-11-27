<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-content animated fadeIn">
	<div class="modal-header noticeHeader">
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">닫기</span></button>
		<h4 class="modal-title" style="color: black; font-size: 22px; font-weight: bold;">즐겨찾기(<span style="font-size: 24px; color: #007bff;	font-weight: bold;">바로가기 링크</span>)</h4>
	</div>
	<div class="modal-body" style="height: auto;">
		<div style="margin: 15px 70px;">
			<c:if test="${favoritePageList ne '[]'}">
				<% int num = 1; %>
				<c:forEach var="favoritePage" items="${favoritePageList}">
					<a href="${favoritePage.favoritePageUrl}" id="appr" style="text-decoration:none;color:#000000;">
						<span class="cnt"><%= num %>. ${favoritePage.favoritePageName}</span>
					</a>
					<br><br>
					<% num++; %>
				</c:forEach>
			</c:if>
			<c:if test="${favoritePageList eq '[]'}">
				방문한 페이지가 존재 하지 않습니다.
			</c:if>
		</div>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-primary" id="hideTodayBtn" onClick="hideTodayBtn()"><i class="fa fa-check"></i> 오늘 하루 보지 않기</button>
		<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
	</div>
</div>

<script>
	/* =========== 오늘 하루 보지 않기 ========= */
	$('#hideTodayBtn').click(function() {
		$.cookie('favorite','no', {expires: 1});
		$('#modal').modal("hide"); // 모달 닫기
	});
</script>
<style>
	.cnt {
		font-size: 20px;
		border-bottom: 1px solid;
		color: #2671ff;
	}
</style>

