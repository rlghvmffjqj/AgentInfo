<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<div class="modelHeadFont">테스트 그룹 추가</div>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<div class="modelHeadFont">테스트 그룹 수정</div>
		</c:when>
	</c:choose>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
	<table>
		<tbody>
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<tr class="hight60">
						<td>그룹 경로 :</td><td><span id="seleniumGroupParentsView">${seleniumGroupFullPath}</span></td>
					</tr>
					<tr>
						<td style="width: 70px;">그룹명 : </td><td><input type="text" id="seleniumGroupNameView" autofocus></td>
					</tr>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<tr class="hight60">
						<td>그룹 경로 :</td><td><span id="seleniumGroupNameChangeView">${seleniumGroupFullPath}</span></td>	
					</tr>
					<tr>
						<td style="width: 70px;">그룹명 변경 : </td><td><input type="text" id="seleniumGroupNameView" autofocus></td>											
					</tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnSeleniumGroupViewInsert" onClick="BtnSeleniumGroupViewInsert()">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnSeleniumGroupViewUpdate" onClick="BtnSeleniumGroupViewUpdate()">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});

	/* =========== 테스트 그룹 추가 ========= */
	function BtnSeleniumGroupViewInsert() {
		var seleniumGroupParentPath = getCurrentPath();
		var seleniumGroupName = $('#seleniumGroupNameView').val();
		$("#seleniumGroupFullPath").val(seleniumGroupParentPath);
		$.ajax({
			url: "<c:url value='/seleniumGroup/insert'/>",
			type: "POST",
			data: {
					"seleniumGroupParentPath": seleniumGroupParentPath,
					"seleniumGroupName" : seleniumGroupName
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
						text: '해당 테스트 그룹에 동일한 테스트 그룹이 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '테스트 그룹명을 입력해주세요.',
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
	
	/* =========== 테스트 그룹 수정 ========= */
	function BtnSeleniumGroupViewUpdate() {
		var node = $("#tree").dynatree("getActiveNode");
		var path = node.data.key; // 선택 테스트 그룹 풀 경로
		var title = node.data.title; // 선택 테스트 그룹
		var newSeleniumGroupName = $('#seleniumGroupNameView').val();
		
		$.ajax({
			url: "<c:url value='/seleniumGroup/update'/>",
			type: "POST",
			data: {"seleniumGroupFullPath": path, "newSeleniumGroupName": newSeleniumGroupName},
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
						text: '해당 테스트 그룹에 동일한 테스트 그룹이 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '테스트 그룹명을 입력해주세요.',
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
	$("#seleniumGroupNameView").keypress(function(event) {
		if (window.event.keyCode == 13) {
			console.log("${viewType}");
			if("${viewType}" == "insert") {
				BtnseleniumGroupViewInsert();
			} else if("${viewType}" == "update") {
				BtnSeleniumGroupViewUpdate();
			}
		}
	});
</script>