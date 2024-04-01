<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
<div class="modal-body" style="width: 100%; height: auto; min-height: 300px;">
	<label>이슈 제목</label>
	<input type="text" id="issueConfirm" name="issueConfirm" class="form-control viewForm" value="${issueConfirm}" readonly>
	<textarea class="summerNoteSize" rows="5" id="issueRelayDetail" name="issueRelayDetail" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="수정 사항 및 기타 사항을 입력해주세요.">${issueRelayDetail}</textarea>
</div>
<div class="modal-footer">
	<c:if test="${viewType eq 'insert'}">
		<button class="btn btn-default btn-outline-info-add" id="relayBtn">등록</button>
	</c:if>
	<c:if test="${viewType eq 'update'}">
		<button class="btn btn-default btn-outline-info-add" id="relayUpdateBtn">수정</button>
	</c:if>
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
				"issueRelayType": "${issueRelayType}"
			},
	        async: false,
	        success: function(result) {
				console.log(result);
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
				} else if(result == "UrlExport") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: 'URL Export 생성 후 답글 입력 바랍니다.',    
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
	})

	$('#relayUpdateBtn').click(function() {
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
			url: "<c:url value='/issueRelay/relayUpdate'/>",
	        type: 'post',
	        data: {
				"issueRelayDetail": issueRelayDetail,
				"issueRelayKeyNum": "${issueRelayKeyNum}"
			},
	        async: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '답변 수정 완료!',
						text: '해당 이슈에 답변이 수정되었습니다.',
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


	$(function () {
		/* =========== SummerNote 설정 ========= */
		$('.summerNoteSize').summernote({
			minHeight:130,
			placeholder:"장애내용",
			callbacks: {
				onKeyup: function(e) {
					var pCount = e.currentTarget.childElementCount;
					if(pCount > 41) {
					    if (e.which != 8 && e.which != 46 && e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {  
							Swal.fire({
								icon: 'error',
								title: '범위 초과!',
								text: '입력 범위를 초과하였습니다.',
							});
					    }
					}
			    }
			}
		});
	})
</script>