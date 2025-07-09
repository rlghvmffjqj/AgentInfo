<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 170px;">
	<form id="modalForm" name="form" method ="post">
		<div class="pading5Width370">
			<div>
		 		<label class="labelFontSize">순서</label>
		 	</div>
			<c:if test="${viewType eq 'insert'}">
				<input type="number" id="menuSort" name="menuSort" class="form-control viewForm" value="${maxSort}">	
			</c:if>
			<c:if test="${viewType eq 'update'}">
		 		<input type="number" id="menuSort" name="menuSort" class="form-control viewForm" value="${menuSetting.menuSort}">
			</c:if>
		</div>
		<div class="pading5Width370">
			<div>
		 		<label class="labelFontSize">타이틀</label>
		 	</div>
		 	<input type="text" id="menuTitle" name="menuTitle" class="form-control viewForm" placeholder="타이틀" value="${menuSetting.menuTitle}">
		</div>
		<input type="hidden" id="menuType" name="menuType" value="${menuSetting.menuType}">
		<input type="hidden" id="menuKeyNum" name="menuKeyNum" value="${menuSetting.menuKeyNum}">
		<input type="hidden" id="menuParentKeyNum" name="menuParentKeyNum" value="${menuSetting.menuParentKeyNum}">
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$(function() {
		var viewType = "${viewType}";
		if(viewType == "update") {
			$('#menuSort').val('${menuSetting.menuSort}');
		}
	})

	$('#insertBtn').click(function() {
		if($('#menuSort').val() == "" && $('#menuTitle').val() == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '순서 및 타이틀을 필수 입력 바랍니다.',
			});
			return false;
		} 
		
		var postData = $('#modalForm').serializeObject();
		
		$.ajax({
			url: "<c:url value='/menuSetting/menuInsert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "MenuInsertCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 메뉴에 동일한 타이틀 또는 순서를 입력할 수 없습니다.',
					});	
					return;
				}

				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
						var menuType = "${menuSetting.menuType}";
						if (menuType === 'main') {
		        			mainTableRefresh();
						} else if (menuType === 'sub') {
							subTableRefresh();
						}
		        	});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});

	$('#updateBtn').click(function() {
		if($('#menuSort').val() == "" && $('#menuTitle').val() == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '순서 및 타이틀을 필수 입력 바랍니다.',
			});
			return false;
		} 
		
		var postData = $('#modalForm').serializeObject();
		
		$.ajax({
			url: "<c:url value='/menuSetting/menuUpdate'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "MenuUpdateCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 메뉴에 동일한 타이틀 또는 순서를 입력할 수 없습니다.',
					});	
					return;
				}

				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		var menuType = "${menuSetting.menuType}";
						if (menuType === 'main') {
		        			mainTableRefresh();
						} else if (menuType === 'sub') {
							subTableRefresh();
						}
		        	});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});
</script>
<style>
	
</style>