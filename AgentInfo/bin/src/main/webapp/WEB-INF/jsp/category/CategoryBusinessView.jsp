<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 170px;">
	<form id="modalForm" name="form" method ="post">
		<c:choose>
			<c:when test="${viewType eq 'insert'}">
				<div class="pading5">
					<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
					<select class="form-control selectpicker selectForm" id="categoryCustomerNameView" name="categoryCustomerNameView" data-live-search="true" data-size="5">
						<option value=""></option>
						<c:forEach var="item" items="${customerName}">
							<option value="${item}"><c:out value="${item}"/></option>
						</c:forEach>
					</select>
					<span class="colorRed businessCheck" id="NotCategoryCustomerName" style="display: none; font-size: 12px;">고객사명을 입력해주세요.</span>
				</div>
				<div class="pading5">
				   	<label class="labelFontSize">사업명</label>
					<input type="text" id="categoryBusinessNameView" name="categoryBusinessNameView" class="form-control viewForm">
					<span class="colorRed businessCheck" id="NotCategoryBusinessName" style="display: none; font-size: 12px;">사업명을 입력해주세요.</span>
				</div>
			</c:when>
			<c:when test="${viewType eq 'update'}">
				<input type="hidden" id="categoryBusinessKeyNum" name="categoryBusinessKeyNum" value="${category.categoryBusinessKeyNum}">
				<div class="pading5">
					<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
					<select class="form-control selectpicker selectForm" id="categoryCustomerNameView" name="categoryCustomerNameView" data-live-search="true" data-size="5">
				    	<c:if test="${category.categoryCustomerName ne ''}"><option value=""></option></c:if>
				    	<c:if test="${category.categoryCustomerName eq ''}"><option value=""></option></c:if>
				    	<c:forEach var="item" items="${customerName}">
							<option value="${item}" <c:if test="${item eq category.categoryCustomerName}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
					<span class="colorRed businessCheck" id="NotCategoryCustomerName" style="display: none; font-size: 12px;">고객사명을 입력해주세요.</span>
				</div>
				<div class="pading5">
				   	<label class="labelFontSize">사업명</label>
					<input type="text" id="categoryBusinessNameView" name="categoryBusinessNameView" class="form-control viewForm" value="${category.categoryBusinessName}" autofocus>
					<span class="colorRed businessCheck" id="NotCategoryBusinessName" style="display: none; font-size: 12px;">사업명을 입력해주세요.</span>
				</div>
			</c:when>
		</c:choose>
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
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});

	$("#categoryBusinessNameView").keypress(function(event) {
		if (window.event.keyCode == 13) {
			existenceCheck();
		}
	});

	function existenceCheck() {
		$(".businessCheck").hide();
		var postData = $('#modalForm').serializeObject();
		var swalText = "<span style='font-weight: 600;'>카테고리 목록에 유사한 데이터가 존재합니다.</span> <br><br>";
		$.ajax({
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					url: "<c:url value='/categoryBusiness/existenceCheckInsert'/>",
				</c:when>
				<c:when test="${viewType eq 'update'}">
					url: "<c:url value='/categoryBusiness/existenceCheckUpdate'/>",
				</c:when>
	    	</c:choose>
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
			url: "<c:url value='/categoryBusiness/insert'/>",
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
				} else if(result == "duplicateCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '동일한 카테고리 이름이 존재합니다.',
					});
				} else if(result == "NotCategoryCustomerName") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '고객사명은 필수 입력 사항입니다.',
					});
					$('#NotCategoryCustomerName').show();
				} else if(result == "NotCategoryBusinessName") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '사업명은 필수 입력 사항입니다.',
					});
					$('#NotCategoryBusinessName').show();
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
			url: "<c:url value='/categoryBusiness/update'/>",
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
				} else if(result == "duplicateCheck") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '동일한 카테고리 이름이 존재합니다.',
					});
				} else if(result == "NotCategoryCustomerName") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '고객사명은 필수 입력 사항입니다.',
					});
					$('#NotCategoryCustomerName').show();
				} else if(result == "NotCategoryBusinessName") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '사업명은 필수 입력 사항입니다.',
					});
					$('#NotCategoryBusinessName').show();
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
			},
			error: function(error) {
				console.log(error);
			}
        });
	}
</script>