<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	/* =========== ajax _csrf 전송 ========= */
	/* $(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	}); */
</script>

<div class="modal-body" style="width: 100%; height: 170px;">
	<form id="modalForm" name="form" method ="post"> 
		<input type="hidden" id="categoryKeyNum" name=categoryKeyNum class="form-control viewForm" value="${category.categoryKeyNum}">
		<div class="pading5">
			<label class="labelFontSize">카테고리</label><label class="colorRed">*</label>
			<input type="text" id="categoryName" name="categoryName" class="form-control viewForm" value="${category.categoryName}" readonly> 
		</div>
		<div class="pading5">
		   	<label class="labelFontSize">이름</label>
			<input type="text" id="categoryValue" name="categoryValue" class="form-control viewForm" value="${category.categoryValue}"> 
			<span class="colorRed" id="NotCategory" style="display: none">카테고리 이름을 입력해주세요.</span>
		</div>
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
	/* =========== 카테고리 추가 ========= */
	$('#insertBtn').click(function() {
		var categoryCheck = $('#categoryValue').val();
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/category/insert'/>",
	           type: 'post',
	           data: postData,
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
	});
	
	/* =========== 카테고리 수정 ========= */
	$('#updateBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
            url: 'update',
            type: 'post',
            data: postData,
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
	});

</script>
	
	
	
	
	