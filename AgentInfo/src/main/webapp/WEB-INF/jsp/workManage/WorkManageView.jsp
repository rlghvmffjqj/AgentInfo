<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 730px;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="workManageKeyNum" name="workManageKeyNum" class="form-control viewForm" value="${workManage.workManageKeyNum}">
		<div style="display: flow-root; padding-bottom: 10px;">
			<div class="pading5Width50">
				 <div>
				 	<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
				  	<select class="form-control selectpicker selectForm" id="workManageCustomerView" name="workManageCustomerView" data-live-search="true" data-size="5">
				  		<option value=""></option>
						<c:forEach var="item" items="${workManageCustomer}">
							<option value="${item}"><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				 </div>
				 <span class="colorRed" id="NotWorkManageCustomer" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
			 </div>
			 <div class="pading5Width50">
				 <div>
				 	<label class="labelFontSize">패키지명</label><label class="colorRed">*</label>
					<input type="text" id="workManageProductNameView" name="workManageProductNameView" class="form-control viewForm" value="${workManage.workManageProductName}">
				 </div>
				 <span class="colorRed" id="NotworkManageProductNameNameType" style="display: none; line-height: initial;">제품종류를 입력해주세요.</span>
			 </div>
			 <div class="pading5Width50">
				<div>
			 		<label class="labelFontSize">엔지니어</label>
					<input type="text" id="workManageEngineerView" name="workManageEngineerView" class="form-control viewForm" value="${workManage.workManageEngineer}">
				</div>
			</div>
			<div class="pading5Width50">
				<label class="labelFontSize">요청구분</label>
				<div>
					<select class="form-control selectpicker" id="workManageDivisionView" name="workManageDivisionView" data-size="5" data-actions-box="true">
						<option value="이메일" <c:if test="${'이메일' eq workManage.workManageDivision}">selected</c:if>>이메일</option>
						<option value="전화" <c:if test="${'전화' eq workManage.workManageDivision}">selected</c:if>>전화</option>
						<option value="방문" <c:if test="${'방문' eq workManage.workManageDivision}">selected</c:if>>방문</option>
					</select>
				</div>
			</div>
			<div class="pading5Width50">
				<div>
					<label class="labelFontSize">요청일자</label>
	    		    <input type="date" id="workManageRequestDateView" name="workManageRequestDateView" class="form-control viewForm" value="${workManage.workManageRequestDate}" max="9999-12-31">
				</div>
			</div>
		</div>
		<div style="border-top: 1px solid #d17c7c; padding-top: 10px;">
			<div class="pading5Width50">
				<div>
					<label class="labelFontSize">작성자</label>
	    		    <input type="text" id="workManageAuthorView" name="workManageAuthorView" class="form-control viewForm" value="${workManage.workManageAuthor}">
				</div>
			</div>
			<div class="pading5Width50">
				<div>
					<label class="labelFontSize">테스터</label>
	    		    <input type="text" id="workManageTesterView" name="workManageTesterView" class="form-control viewForm" value="${workManage.workManageTester}">
				</div>
			</div>
			<div class="pading5Width50">
				<label class="labelFontSize">진행상태</label>
				<div>
					<select class="form-control selectpicker" id="workManageProgressStatusView" name="workManageProgressStatusView" data-size="5" data-actions-box="true">
						<option value="진행중" <c:if test="${'진행중' eq workManage.workManageProgressStatus}">selected</c:if>>진행중</option>
						<option value="보류" <c:if test="${'보류' eq workManage.workManageProgressStatus}">selected</c:if>>보류</option>
						<option value="완료" <c:if test="${'완료' eq workManage.workManageProgressStatus}">selected</c:if>>완료</option>
					</select>
				</div>
			</div>
			<div class="pading5Width50">
				<div class="percent-wrap" style="width: 100%;">
					<label class="labelFontSize">진행률</label>
	    		    <input type="number" id="workManageProgressView" name="workManageProgressView" class="form-control viewForm" min="0" max="100" value="0" style="text-align: right; font-weight: bold;">
					<span style="top: 65%;">%</span>
				</div>
			</div>
			<div class="pading5Width50">
				<label class="labelFontSize">테스트일정</label>
				<div style="display: ruby-text;">
	    		    <input type="date" id="workManageTestScheduleStart" name="workManageTestScheduleStart" class="form-control viewForm" value="${workManage.workManageTestScheduleStart}" max="9999-12-31">
					~
					<input type="date" id="workManageTestScheduleEnd" name="workManageTestScheduleEnd" class="form-control viewForm" value="${workManage.workManageTestScheduleEnd}" max="9999-12-31">
				</div>
			</div>
			<div class="pading5Width50" style="width: 100%;">
				<div>
					<label class="labelFontSize">한줄설명</label>
	    		    <input type="text" id="workManageOneLineView" name="workManageOneLineView" class="form-control viewForm" value="${workManage.workManageOneLine}" placeholder="주간 업무 적용을 위한 한줄 설명 입력 바랍니다.">
				</div>
			</div>
			<div class="pading5Width50" style="width: 100%;">
	    		<label class="labelFontSize">상세 내용</label>
	    		<textarea class="form-control" id="workManageDetailNoteView" name="workManageDetailNoteView" spellcheck="false" value="${workManage.workManageDetailNote}" placeholder="테스트 내용을 자세히 입력 바랍니다."></textarea>
			</div>
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
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 추가 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/workManage/insert'/>",
	       	type: 'post',
	       	data: postData,
	       	async: false,
	       	processData: false,
	       	contentType: false,
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
	
	
	
	/* =========== 수정 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
            url: "<c:url value='/workManage/update'/>",
            type: 'post',
            data: postData,
            async: false,
            processData: false,
	        contentType: false,
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
	});
	
	$("#workManageTesterView").autocomplete({
	    minLength: 1,

	    source: function(request, response) {

	        // 마지막 검색어만 추출
	        let term = request.term.split(",").pop().trim();

	        $.ajax({
	            url: "<c:url value='/employee/inputSearch'/>",
	            type: "post",
	            dataType: "json",
	            data: { keyword: term },

	            success: function(data) {
	                response($.map(data, function(item) {
	                    return {
	                        label: item.employeeName + "(" + item.employeeId + ")",
	                        value: item.employeeName + "(" + item.employeeId + ")"
	                    };
	                }));
	            }
	        });
	    },

	    focus: function() {
	        return false;
	    },

	    select: function(event, ui) {

	        let current = $(this).val();

	        // 기존 값 배열화
	        let arr = current.split(",");

	        // 마지막 검색중인 값 제거
	        arr.pop();

	        // 새 값 추가
	        arr.push(ui.item.value);

	        // 마지막 콤마 추가 (다음 검색 가능)
	        arr.push("");

	        $(this).val(arr.join(", "));

	        return false;
	    }
	});
</script>
<style>
	.pading5Width50 {
		padding: 5px;
    	margin-bottom: 15px;
    	width: 50%;
		float: left;
		height: 55px;
	}

	.percent-wrap{
	    position:relative;
	    width:200px;
	}

	.percent-wrap input{
	    padding-right:30px;
	}

	.percent-wrap span{
	    position:absolute;
	    right:10px;
	    top:50%;
	    transform:translateY(-50%);
	}

	#workManageDetailNoteView {
		border: 1px solid #dab17d;
    	height: 150px;
	}
</style>