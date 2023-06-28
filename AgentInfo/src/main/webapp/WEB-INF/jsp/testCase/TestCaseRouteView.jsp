<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<div class="modelHeadFont">경로 추가</div>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<div class="modelHeadFont">경로 수정</div>
		</c:when>
	</c:choose>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
	<table>
		<tbody>
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<tr class="hight60">
						<td>경로 경로 :</td><td><span id="testCaseRouteParentPathView">${testCaseRouteFullPath}</span></td>
					</tr>
					<tr>
						<td style="width: 70px;">경로명 : </td><td><input type="text" id="testCaseRouteNameView" autofocus></td>
					</tr>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<tr class="hight60">
						<td>경로 경로 :</td><td><span id="testCaseRouteNameChangeView">${testCaseRouteFullPath}</span></td>	
					</tr>
					<tr>
						<td style="width: 70px;">경로명 변경 : </td><td><input type="text" id="testCaseRouteNameView" autofocus></td>											
					</tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnTestCaseRouteViewInsert" onClick="BtnTestCaseRouteViewInsert()">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnTestCaseRouteViewUpdate" onClick="BtnTestCaseRouteViewUpdate()">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});

	/* =========== 경로 추가 ========= */
	function BtnTestCaseRouteViewInsert() {
		var testCaseRouteParentPath = getCurrentPath();
		var testCaseRouteName = $('#testCaseRouteNameView').val();
		var testCaseRouteCustomer = $('#testCaseRouteCustomer').val();
		var testCaseRouteNote = $('#testCaseRouteNote').val();
		var testCaseFormName = $('#testCaseFormName').val();

		$("#testCaseRouteFullPath").val(testCaseRouteParentPath);
		$.ajax({
			url: "<c:url value='/testCase/insertRoute'/>",
			type: "POST",
			data: {
					"testCaseRouteParentPath": testCaseRouteParentPath,
					"testCaseRouteName" : testCaseRouteName,
					"testCaseRouteCustomer" : testCaseRouteCustomer,
					"testCaseRouteNote" : testCaseRouteNote,
					"testCaseFormName" : testCaseFormName,
				},
			dataType: "json",
			async: false,
			success: function(data) {
				if(data.result == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						reloadView();
					});
				} else if(data.result == "Overlap") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 경로의 동일한 경로가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '경로명을 입력해주세요.',
					});
				}else{
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(e) {
		    	console.log(e);
		    }
		});
	}
	
	/* =========== 경로 수정 ========= */
	function BtnTestCaseRouteViewUpdate() {
		var node = $("#tree").dynatree("getActiveNode");
		var path = node.data.key; // 선택 경로 풀 경로
		var title = node.data.title; // 선택 경로
		var newtestCaseRouteName = $('#testCaseRouteNameView').val();
		
		$.ajax({
			url: "<c:url value='/testCase/updateRoute'/>",
			type: "POST",
			data: {"testCaseRouteFullPath": path, "newTestCaseRouteName": newtestCaseRouteName},
			dataType: "json",
			async: false,
			success: function(data) {
				if(data.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						reloadParent();
					});
				} else if(data.result == "Overlap") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 경로의 동일한 경로가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '경로명을 입력해주세요.',
					});
				}else{
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(e) {
		    	console.log(e);
		    }
		});
	}
	
	/* =========== Enter Key ========= */
	$("#testCaseRouteNameView").keypress(function(event) {
		if (window.event.keyCode == 13) {
			console.log("${viewType}");
			if("${viewType}" == "insert") {
				BtnTestCaseRouteViewInsert();
			} else if("${viewType}" == "update") {
				BtnTestCaseRouteViewUpdate();
			}
		}
	});
</script>