<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body scroll box1" style="width: 100%; height: auto;">
	<form id="modalForm" name="form" method ="post">
		<c:forEach var="item" items="${menuSettingItemList}">
		    <div class="pading5Width770">
		        <div>
		            <label class="labelFontSize">${item.menuTitleKor}</label>
		        </div>
				<c:choose>
					<c:when test="${item.menuItemType eq 'INT'}">
						<input type="number" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm" placeholder="0" spellcheck="false" <c:if test="${viewType eq 'update'}">value="${item[item.menuTitle]}"</c:if>>
					</c:when>
					<c:when test="${item.menuItemType eq 'VARCHAR(500)'}">
						<textarea id="${item.menuTitle}" name="${item.menuTitle}" class="form-control itemArea auto-height" placeholder="${item.menuTitleKor}" spellcheck="false" oninput="autoResize(this)"><c:if test="${viewType eq 'update'}">${item[item.menuTitle]}</c:if></textarea>
					</c:when>
					<c:when test="${item.menuItemType eq 'TEXT'}">
						<textarea id="${item.menuTitle}" name="${item.menuTitle}" class="form-control itemArea auto-height" placeholder="${item.menuTitleKor}" spellcheck="false" oninput="autoResize(this)"><c:if test="${viewType eq 'update'}">${item[item.menuTitle]}</c:if></textarea>
					</c:when>
					<c:otherwise>
						<input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm" placeholder="${item.menuTitleKor}" <c:if test="${viewType eq 'update'}">value="${item[item.menuTitle]}"</c:if>>
					</c:otherwise>
				</c:choose>
		        
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

	function autoResize(textarea) {
    $(textarea).css('height', 'auto');
    $(textarea).css('height', textarea.scrollHeight + 'px');
}

// 마우스 오버 시 높이 재조절
$(document).on('mouseenter', 'textarea.auto-height', function () {
    autoResize(this);
});

</script>
<style>
	.scroll{
	  display: inline-block;
	  height: 710px !important;  
	  overflow-x: hidden;
	  box-sizing: border-box;
	  max-height: 770px;
	}

	/* 스크롤바 막대 설정*/
	.box1::-webkit-scrollbar-thumb{
	  background-color: #8500005e;
	  /* 스크롤바 둥글게 설정    */
	  border-radius: 10px; 
	}

	.box1::-webkit-scrollbar {
	  width: 7px;  /* 세로 스크롤 두께 */
	  height: 12px; /* 가로 스크롤 두께 */
	}

	.itemArea {
		min-height: 100px;
		border: 1px solid #dab17d !important;
		resize: none;
  		line-height: 1.5;
		font-size: 12px !important;
    	margin-bottom: -3px;
	}

	.itemArea:hover {
		border: 2px solid #ffa700 !important;
	}


	textarea {
        width: 100%;
        box-sizing: border-box;
        overflow: hidden; /* 스크롤바 숨김 */
        resize: none; /* 사용자가 수동으로 크기 조절하지 못하게 함 */
    }

</style>