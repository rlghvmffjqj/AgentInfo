<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: auto; min-height: 600px; max-height: 800px; overflow-y: scroll; color: black; font-size: 14px; line-height: 1.2; font-family: emoji;">
	<div class="card-block margin10">
		<span>
			<c:out value="${serviceControlLog}" escapeXml="false" />
		</span>
     </div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" id="close" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#close').click(function() {
		//location.reload(true);
		//tableRefresh();
		$('#modal').modal("hide"); // 모달 닫기
		setTimeout(() => {
			updateView('172.16.50.182');
		}, 200);
	});
</script>

