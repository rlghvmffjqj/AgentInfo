<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<div class="modelHeadFont">부서 추가</div>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<div class="modelHeadFont">부서 수정</div>
		</c:when>
	</c:choose>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
	<table>
		<tbody>
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<tr class="hight60">
						<td>부서 경로 :</td><td><span id="departmentParentsView">${departmentFullPath}</span></td>
					</tr>
					<tr>
						<td style="width: 70px;">부서명 : </td><td><input type="text" id="departmentNameView"></td>
					</tr>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<tr class="hight60">
						<td>부서 경로 :</td><td><span id="departmentNameChangeView">${departmentFullPath}</span></td>	
					</tr>
					<tr>
						<td style="width: 70px;">부서명 변경 : </td><td><input type="text" id="departmentNameView"></td>											
					</tr>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnDepartmentViewInsert" onClick="BtnDepartmentViewInsert()">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="BtnDepartmentViewUpdate" onClick="BtnDepartmentViewUpdate()">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== 부서 추가 ========= */
	function BtnDepartmentViewInsert() {
		var departmentParentPath = getCurrentPath();
		var departmentName = $('#departmentNameView').val();
		$("#departmentFullPath").val(departmentParentPath);
		$.ajax({
			url: "<c:url value='/department/insert'/>",
			type: "POST",
			data: {
					"departmentParentPath": departmentParentPath,
					"departmentName" : departmentName
				},
			dataType: "json",
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
						text: '해당 부서의 동일한 부서가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '부서명을 입력해주세요.',
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
	
	/* =========== 부서 수정 ========= */
	function BtnDepartmentViewUpdate() {
		var node = $("#tree").dynatree("getActiveNode");
		var path = node.data.key; // 선택 부서 풀 경로
		var title = node.data.title; // 선택 부서
		var newDepartmentName = $('#departmentNameView').val();
		
		$.ajax({
			url: "<c:url value='/department/update'/>",
			type: "POST",
			data: {"departmentFullPath": path, "newDepartmentName": newDepartmentName},
			dataType: "json",
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
						text: '해당 부서의 동일한 부서가 존재합니다.',
					});
				} else if(data.result == "Empty") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '부서명을 입력해주세요.',
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
	$("#departmentNameView").keypress(function(event) {
		if (window.event.keyCode == 13) {
			console.log("${viewType}");
			if("${viewType}" == "insert") {
				BtnDepartmentViewInsert();
			} else if("${viewType}" == "update") {
				BtnDepartmentViewUpdate();
			}
		}
	});
	
</script>
	
