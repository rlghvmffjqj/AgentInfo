<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${viewType eq 'insert'}">
	<div class="modal-body" style="width: 100%; height: 170px;">
</c:if>
<c:if test="${viewType eq 'update'}">
	<div class="modal-body" style="width: 100%; height: 280px;">
</c:if>
	<form id="modalForm" name="form" method ="post"> 
		<input type="hidden" id="categoryKeyNum" name=categoryKeyNum class="form-control viewForm" value="${category.categoryKeyNum}">
		<div class="pading5">
			<label class="labelFontSize">카테고리</label><label class="colorRed">*</label>
			<input type="text" id="categoryName" name="categoryName" class="form-control viewForm" value="${category.categoryName}" readonly> 
		</div>
		<div class="pading5">
		   	<label class="labelFontSize">이름</label>
			<input type="text" id="categoryValueView" name="categoryValueView" class="form-control viewForm" value="${category.categoryValue}" autofocus>
			<span class="colorRed" id="NotCategory" style="display: none; font-size: 12px;">카테고리 이름을 입력해주세요.</span>
		</div>
		<c:if test="${viewType eq 'update'}">
			<div class="pading5">
				<label class="labelFontSize">비고</label>
				<textarea type="text" id="categoryNoteView" name="categoryNoteView" class="form-control" style="height:100px;">${category.categoryNote}</textarea>
			</div>
		</c:if>
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="insertBtn" onClick="existenceCheck()">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateBtn" onClick="existenceCheck()">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});

	$("#categoryValueView").keypress(function(event) {
		if (window.event.keyCode == 13) {
			existenceCheck();
		}
	});

	function existenceCheck() {
		var postData = $('#modalForm').serializeObject();
		var swalText = "<span style='font-weight: 600;'>카테고리 목록에 유사한 데이터가 존재합니다.</span> <br><br>";
		var urlType = "";
		if("${viewType}" == 'insert') {
			urlType = "<c:url value='/category/existenceCheckInsert'/>";
		}
		if("${viewType}" == 'update') {
			urlType = "<c:url value='/category/existenceCheckUpdate'/>";
		}
		$.ajax({
			url: urlType,
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(items) {
	        	if(items.length != 0) {
		        	$.each(items, function (i, item) {
		        		swalText += item+"<br>";
		        	});
		        	Swal.fire({
		  			  title: ' 추가를 계속 진행하시겠습니까?',
		  			  html: swalText,
		  			  icon: 'warning',
		  			  showCancelButton: true,
		  			  confirmButtonColor: '#7066e0',
		  			  cancelButtonColor: '#FF99AB',
		  			  confirmButtonText: 'OK'
			  		}).then((result) => {
			  			if (result.isConfirmed) {
			  				<c:choose>
								<c:when test="${viewType eq 'insert'}">
									insertBtn();
								</c:when>
								<c:when test="${viewType eq 'update'}">
									updateBtn();
								</c:when>
				    		</c:choose> 
			  			}
			  		});
	        	} else {
	        		<c:choose>
						<c:when test="${viewType eq 'insert'}">
							insertBtn();
						</c:when>
						<c:when test="${viewType eq 'update'}">
							updateBtn();
						</c:when>
	    			</c:choose> 	
	        	}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}
	
	/* =========== 카테고리 추가 ========= */
	function insertBtn() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/category/insert'/>",
	           type: 'post',
	           data: postData,
	           async: false,
	           success: function(result) {
		           	if(result.result == "NotCategory") { 
						$('#NotCategory').show();
		           		true;
					} else if (result.result != "NotCategory"){
						$('#NotCategory').hide();
					} 
		           	
					if(result.result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$('#modal').modal("hide"); // 모달 닫기
		           		$('#modal').on('hidden.bs.modal', function () {
		           			tableRefresh();
		           		});
					} else if(result.result == "duplicateCheck") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '동일한 카테고리 이름이 존재합니다.',
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
	}
	
	/* =========== 카테고리 수정 ========= */
	function updateBtn() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
            url: 'update',
            type: 'post',
            data: postData,
            async: false,
            success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
            		$('#modal').on('hidden.bs.modal', function () {
            			tableRefresh();
            		});
				} else if(result.result == "duplicateCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '동일한 카테고리 이름이 존재합니다.',
					});
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
				if(result.result == "NotCategory") { 
					$('#NotCategory').show();
	           		true;
				} else if (result.result != "NotCategory"){
					$('#NotCategory').hide();
				} 
				
			},
			error: function(error) {
				console.log(error);
			}
        });
	}
</script>