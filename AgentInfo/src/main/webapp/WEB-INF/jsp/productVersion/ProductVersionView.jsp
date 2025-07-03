<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: auto;">
	<form id="modalForm" name="form" method ="post">
		<c:forEach var="item" items="${menuSettingItemList}">
		    <div class="pading5Width370">
		        <div>
		            <label class="labelFontSize">${item.menuTitleKor}</label>
		        </div>
		        <input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm" <c:if test="${viewType eq 'update'}">value="${item[item.menuTitle]}"</c:if>>
		    </div>
		</c:forEach>
		<input type="hidden" id="menuKeyNum" name="menuKeyNum" value="${menuSetting.menuKeyNum}">
		<input type="hidden" id="menuTitle" name="menuTitle" value="${menuSetting.menuTitle}">
		<input type="hidden" id="productVersionKeyNum" name="productVersionKeyNum" value="${menuSetting.productVersionKeyNum}">
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
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		
		$.ajax({
			url: "<c:url value='/productVersion/productVersionInsert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
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
		var postData = $('#modalForm').serializeObject();
		
		$.ajax({
			url: "<c:url value='/productVersion/productVersionUpdate'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
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