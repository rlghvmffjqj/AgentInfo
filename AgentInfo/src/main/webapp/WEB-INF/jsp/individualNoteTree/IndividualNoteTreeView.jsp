<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<div class="modelHeadFont">폴더 추가</div>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<div class="modelHeadFont">폴더 수정</div>
		</c:when>
	</c:choose>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
	<table>
		<tbody>
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<tr class="hight60">
						<td>폴더 경로 :</td><td><span id="individualNoteTreeParentsView">${individualNoteTreeFullPath}</span></td>
					</tr>
					<tr>
						<td style="width: 70px;">폴더명 : </td><td><input type="text" id="individualNoteTreeNameView" autofocus></td>
					</tr>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<tr class="hight60">
						<td>폴더 경로 :</td><td><span id="individualNoteTreeNameChangeView">${individualNoteTreeFullPath}</span></td>	
					</tr>
					<tr>
						<td style="width: 70px;">폴더명 변경 : </td><td><input type="text" id="individualNoteTreeNameView" autofocus></td>											
					</tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnIndividualNoteTreeViewInsert" onClick="BtnIndividualNoteTreeViewInsert()">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnIndividualNoteTreeViewUpdate" onClick="BtnIndividualNoteTreeViewUpdate()">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});

	/* =========== 트리 추가 ========= */
	function BtnIndividualNoteTreeViewInsert() {
		var individualNoteTreeParentPath = getCurrentPath();
		var individualNoteTreeName = $('#individualNoteTreeNameView').val();
		$("#individualNoteTreeFullPath").val(individualNoteTreeParentPath);
		$.ajax({
			url: "<c:url value='/individualNoteTree/insert'/>",
			type: "POST",
			data: {
					"individualNoteTreeParentPath": individualNoteTreeParentPath,
					"individualNoteTreeName" : individualNoteTreeName
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
						text: '해당 폴더의 동일한 폴더가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '폴더명을 입력해주세요.',
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
	
	/* =========== 트리 수정 ========= */
	function BtnIndividualNoteTreeViewUpdate() {
		var node = $("#tree").dynatree("getActiveNode");
		var path = node.data.key; // 선택 폴더 풀 경로
		var title = node.data.title; // 선택 폴더
		var newIndividualNoteTreeName = $('#individualNoteTreeNameView').val();
		
		$.ajax({
			url: "<c:url value='/individualNoteTree/update'/>",
			type: "POST",
			data: {"individualNoteTreeFullPath": path, "newIndividualNoteTreeName": newIndividualNoteTreeName},
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
						text: '해당 폴더의 동일한 폴더가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '폴더명을 입력해주세요.',
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
	$("#individualNoteTreeNameView").keypress(function(event) {
		if (window.event.keyCode == 13) {
			console.log("${viewType}");
			if("${viewType}" == "insert") {
				BtnIndividualNoteTreeViewInsert();
			} else if("${viewType}" == "update") {
				BtnIndividualNoteTreeViewUpdate();
			}
		}
	});
</script>