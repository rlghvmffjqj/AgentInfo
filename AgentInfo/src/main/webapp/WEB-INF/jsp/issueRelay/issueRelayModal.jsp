<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
<div class="modal-body" style="width: 100%; height: 300px;">
	<label>이슈 제목</label>
	<input type="text" id="issueConfirm" name="issueConfirm" class="form-control viewForm" value="${issueConfirm}" readonly>
	<textarea class="form-control" id="issueRelayDetail" name="issueRelayDetail" style="height: 200px;" placeholder="수정 사항 및 기타 사항을 입력해주세요."></textarea>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="relayBtn">등록</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#relayBtn').click(function() {
		var issueRelayDetail = $('#issueRelayDetail').val();
		if(issueRelayDetail == "" || issueRelayDetail == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '답변을 입력해주세요.',    
			});  
			return false;
		}

		$.ajax({
			url: "<c:url value='/issueRelay/relay'/>",
	        type: 'post',
	        data: {
				"issueRelayDetail": issueRelayDetail,
				"issuePrimaryKeyNum": "${issuePrimaryKeyNum}",
				"issueKeyNum": "${issueKeyNum}",
				"issueRelayType": "개발"
			},
	        async: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '답변 완료!',
						text: '해당 이슈에 답변이 등록되었습니다.',
					}).then((result) => {
						if (result.isConfirmed) {
							$('#modal').modal("hide"); // 모달 닫기
	            			$('#modal').on('hidden.bs.modal', function () {
	            				location.reload();
	            			});	
						}
					})
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
	})
</script>