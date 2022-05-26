<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 590px;">
	<div class="card-block margin10">
         <form class="modalForm form-material" name="modalForm" id="modalForm" method ="post">
         	 <input type="hidden" id="requestsKeyNum" name="requestsKeyNum" class="form-control" value="${requests.requestsKeyNum}">
             <div class="form-group form-default form-static-label">
                 <input type="text" id="requestsDate" name="requestsDate" class="form-control" required="" value="${requests.requestsDate}" disabled>
                 <span class="form-bar"></span>
                 <label class="float-label">날짜</label>
             </div>
             <div class="form-group form-default form-static-label">
                 <input type="text" id="employeeId" name="employeeId" class="form-control" required="" value="${requests.employeeId}" disabled>
                 <span class="form-bar"></span>
                 <label class="float-label">사용자ID</label>
             </div>
             <div class="form-group form-default form-static-label">
                 <input type="text" id="employeeName" name="employeeName" class="form-control" required="" value="${requests.employeeName}" disabled>
                 <span class="form-bar"></span>
                 <label class="float-label">사원명</label>
             </div>
             <div class="form-group form-default form-static-label">
                 <input type="text" id="requestsTitle" name="requestsTitle" class="form-control" required="" value="${requests.requestsTitle}" disabled>
                 <span class="form-bar"></span>
                 <label class="float-label">제목</label>
             </div>
             <div class="form-group form-default form-static-label">
                 <textarea id="requestsDetail" name="requestsDetail" class="form-control view" required="" style="height:190px !important" disabled>${requests.requestsDetail}</textarea>
                 <span class="form-bar"></span>
                 <label class="float-label">내용</label>
             </div>
             <div class="form-group form-default form-static-label">
                 <select class="form-control" id="requestsState" name="requestsState">
                     <option value="요청" <c:if test="${'요청' eq requests.requestsState}">selected</c:if>>요청</option>
                     <option value="확인" <c:if test="${'확인' eq requests.requestsState}">selected</c:if>>확인</option>
                     <option value="대기" <c:if test="${'대기' eq requests.requestsState}">selected</c:if>>대기</option>
                 </select>
                 <span class="form-bar"></span>
                 <label class="float-label">상태</label>
             </div>
         </form>
     </div>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="updateBtn">상태 변경</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#updateBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/requests/update'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	console.log(result);
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

