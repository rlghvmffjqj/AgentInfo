<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: auto;">
	<form id="modalForm" name="form" method ="post">
		<div class="pading5Width370">
			<div>
		 		<label class="labelFontSize">순서</label>
		 	</div>
		 	<input type="number" id="menuSort" name="menuSort" class="form-control viewForm" value="${sortNumMax}">
		</div>
		<div class="pading5Width370">
			<div>
		 		<label class="labelFontSize">컬럼명(한글)</label>
		 	</div>
		 	<input type="text" id="menuTitleKor" name="menuTitleKor" class="form-control viewForm" placeholder="이름" value="${menuSetting.menuTitleKor}">
		</div>
		<div class="pading5Width370">
			<div>
		 		<label class="labelFontSize">컬럼명(영문)</label>
		 	</div>
		 	<input type="text" id="menuTitle" name="menuTitle" class="form-control viewForm" placeholder="name" value="${menuSetting.menuTitle}">
		</div>
		<div class="pading5Width370">
	        <label class="labelFontSize">타입</label>
	        <select class="form-control selectpicker selectForm" id="menuItemType" name="menuItemType" data-size="5">
				<option value="INT">INT</option>
				<option value="VARCHAR(10)" <c:if test="${menuSetting.menuItemType eq 'VARCHAR(10)'}">selected</c:if>>VARCHAR(10)</option>
				<option value="VARCHAR(100)" <c:if test="${menuSetting.menuItemType eq 'VARCHAR(100)'}">selected</c:if> <c:if test="${viewType eq 'insert'}">selected</c:if>>VARCHAR(100)</option>
				<option value="VARCHAR(500)" <c:if test="${menuSetting.menuItemType eq 'VARCHAR(500)'}">selected</c:if>>VARCHAR(500)</option>
				<option value="VARCHAR(1000)" <c:if test="${menuSetting.menuItemType eq 'VARCHAR(500)'}">selected</c:if>>VARCHAR(1000)</option>
				<option value="TEXT" <c:if test="${menuSetting.menuItemType eq 'TEXT'}">selected</c:if>>TEXT</option>
				<option value="DATE" <c:if test="${menuSetting.menuItemType eq 'DATE'}">selected</c:if>>DATE</option>
			</select>
	    </div>
		<div class="pading5Width370">
	        <label class="labelFontSize">정렬 컬럼</label>
	        <select class="form-control selectpicker selectForm" id="menuItemSort" name="menuItemSort" data-size="5">
				<option value="productVersionKeyNum" <c:if test="${menuSetting.menuTitle eq 'productVersionKeyNum'}">selected</c:if>>기본 값</option>
				<c:forEach var="item" items="${menuSettingList}">
					<option value="${item.menuTitle}" <c:if test="${menuSetting.menuItemSort eq item.menuTitle}">selected</c:if>>${item.menuTitleKor}</option>
				</c:forEach>
			</select>
	    </div>
		<div class="pading5Width370">
			<div>
		 		<label class="labelFontSize">필수</label>
		 	</div>
		 	<input type="checkbox" id="menuRequired" name="menuRequired" class="form-control viewForm" style="width: 15px; margin-left: 13px;" <c:if test="${menuSetting.menuRequired eq 'on'}">checked</c:if>>
		</div>
		<input type="hidden" id="menuType" name="menuType" value="${menuSetting.menuType}">
		<input type="hidden" id="mainKeyNum" name="mainKeyNum" value="${menuSetting.mainKeyNum}">
		<input type="hidden" id="subKeyNum" name="subKeyNum" value="${menuSetting.subKeyNum}">
		<input type="hidden" id="menuKeyNum" name="menuKeyNum" value="${menuSetting.menuKeyNum}">
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
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	$(function() {
		var viewType = "${viewType}";
		if(viewType == "update") {
			$('#menuSort').val('${menuSetting.menuSort}');
		}
	})

	$('#insertBtn').click(function() {
		if($('#menuSort').val() == "" || $('#menuTitle').val() == "" || $('#menuTitleKor').val() == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '순서 및 컬럼명을 필수 입력 바랍니다.',
			});
			return false;
		} 
		
		var postData = $('#modalForm').serializeObject();
		
		$.ajax({
			url: "<c:url value='/menuSetting/menuItemInsert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "ItemInsertCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 메뉴에 동일한 컬럼명 또는 순서를 입력할 수 없습니다.',
					});	
					return;
				} else if(result == "OnlyEnglish") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '컬럼명(영문)에는 영문만 입력 바랍니다.',
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
		        		itemTableRefresh();
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
			url: "<c:url value='/menuSetting/menuItemUpdate'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "ItemUpdateCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '해당 메뉴에 동일한 컬럼명 또는 순서를 입력할 수 없습니다.',
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
		        		itemTableRefresh();
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