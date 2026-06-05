<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">메일 발송 이력</div>
</div>

<!-- 💡 데이터가 많아질 경우를 대비해 스크롤(overflow-y: auto)을 추가했습니다 -->
<div class="modal-body modalBody" style="width: 100%; height: 280px; overflow-y: auto;">
	<table class="table table-bordered table-striped table-hover" style="width: 100%; text-align: center;">
		<thead>
			<tr style="background-color: #f8f9fa;">
				<th style="width: 15%;">번호</th>
				<th style="width: 45%;">등록자</th>
				<th style="width: 40%;">생성일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty mailSendList}">
					<c:forEach items="${mailSendList}" var="mail" varStatus="status">
						<tr>
							<!-- 순번 (1부터 시작) -->
							<td>${status.count}</td>
							<!-- 등록자 -->
							<td><c:out value="${mail.employeeName}" /></td>
							<!-- 생성일 -->
							<td><c:out value="${mail.mailSendListRegistrationDate}" /></td>
						</tr>
					</c:forEach>
				</c:when>
				
				<c:otherwise>
					<tr>
						<td colspan="3" style="padding: 20px 0; color: #888;">메일 발송 이력이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>

<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>
