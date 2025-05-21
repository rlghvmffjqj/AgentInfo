<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<div class="modelHeadFont">분류 추가</div>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<div class="modelHeadFont">분류 수정</div>
		</c:when>
	</c:choose>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
	<table>
		<tbody>
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<tr class="hight60">
						<td>분류 :</td><td><span id="testCaseRouteParentPathView">${testCase.testCaseRouteFullPath}</span></td>
					</tr>
					<tr>
						<td style="width: 70px;">분류명 : </td><td><input type="text" id="testCaseRouteNameView" autofocus></td>
					</tr>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<tr class="hight60">
						<td>분류 :</td><td><span id="testCaseRouteNameChangeView">${testCase.testCaseRouteFullPath}</span></td>	
					</tr>
					<tr>
						<td style="width: 70px;">분류명 변경 : </td><td><input type="text" id="testCaseRouteNameView" autofocus></td>											
					</tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
	<input type="hidden" id="testCaseFormKeyNum" name="testCaseFormKeyNum" class="form-control" value="${testCase.testCaseFormKeyNum}">
	<input type="hidden" id="testCaseFormName" name="testCaseFormName" class="form-control" value="${testCase.testCaseFormName}">
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

	/* =========== 분류 추가 ========= */
	function BtnTestCaseRouteViewInsert() {
		var testCaseRouteParentPath = getCurrentPath();
		var testCaseRouteName = $('#testCaseRouteNameView').val();
		var testCaseRouteCustomer = $('#testCaseRouteCustomer').val();
		var testCaseRouteNote = $('#testCaseRouteNote').val();
		var testCaseFormName = $('#testCaseFormName').val();
		var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();
		var testCaseRouteGroupNum = $('#testCaseRouteGroupNum').val();

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
					"testCaseFormKeyNum" : testCaseFormKeyNum,
					"testCaseRouteGroupNum" : testCaseRouteGroupNum,
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
						remakeIcon();
					});
					$('#testCaseRouteGroupNum').val(data.testCaseRouteGroupNum);
				} else if(data.result == "Overlap") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 분류의 동일한 분류가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '분류명을 입력해주세요.',
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
	
	/* =========== 분류 수정 ========= */
	function BtnTestCaseRouteViewUpdate() {
		var node = $("#tree").dynatree("getActiveNode");
		var path = node.data.key; // 선택 분류 풀 분류
		var title = node.data.title; // 선택 분류
		var testCaseRouteKeyNum = node.data.KeyNum;
		var newTestCaseRouteName = $('#testCaseRouteNameView').val();
		var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();
		var testCaseRouteGroupNum = $('#testCaseRouteGroupNum').val();
		var testCaseRouteCustomer = $('#testCaseRouteCustomer').val();
		var testCaseRouteNote = $('#testCaseRouteNote').val();
		
		$.ajax({
			url: "<c:url value='/testCase/updateRoute'/>",
			type: "POST",
			data: {
				"testCaseRouteFullPath": path, 
				"newTestCaseRouteName": newTestCaseRouteName,
				"testCaseFormKeyNum" : testCaseFormKeyNum,
				"testCaseRouteCustomer" : testCaseRouteCustomer,
				"testCaseRouteNote" : testCaseRouteNote,
				"testCaseRouteGroupNum" : testCaseRouteGroupNum,
				"testCaseRouteKeyNum" : testCaseRouteKeyNum,
			},
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
						remakeIcon();
					});
				} else if(data.result == "Overlap") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 분류의 동일한 분류가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '분류명을 입력해주세요.',
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