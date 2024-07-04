<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
<div class="modal-body" style="width: 100%; height: auto; min-height: 300px;">
	<label>이슈 제목</label>
	<input type="text" id="issueConfirm" name="issueConfirm" class="form-control viewForm" value="${issueConfirm}" style="font-weight: bold; font-size: 14px !important; background: aliceblue; color: #0c0067ba;" readonly>
	<textarea class="summerNoteSize" rows="5" id="issueRelayDetail" name="issueRelayDetail" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="수정 사항 및 기타 사항을 입력해주세요.">${issueRelayDetail}</textarea>
	<c:if test="${issueRelayType eq '개발'}">
		<div class="radio-container">
    	    <div class="radio-group">
    	        <label>
    	            <input type="radio" id="issueRelayStatus" name="issueRelayStatus" value="해결" <c:if test="${'해결' eq issueRelayStatus || null eq issueRelayStatus || '' eq issueRelayStatus}">checked</c:if>>
    	            <span class="checkmark"></span>
    	            해결
    	        </label>
    	        <label>
    	            <input type="radio" id="issueRelayStatus" name="issueRelayStatus" value="오탐" <c:if test="${'오탐' eq issueRelayStatus}">checked</c:if>>
    	            <span class="checkmark"></span>
    	            오탐
    	        </label>
    	        <label>
    	            <input type="radio" id="issueRelayStatus" name="issueRelayStatus" value="대기" <c:if test="${'대기' eq issueRelayStatus}">checked</c:if>>
    	            <span class="checkmark"></span>
    	            대기
    	        </label>
    	    </div>
    	</div>
	</c:if>
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
		var issueRelayStatus = $('#issueRelayStatus:checked').val();
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
				"issueRelayType": "${issueRelayType}",
				"issueRelayStatus": issueRelayStatus
			},
	        async: false,
	        success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '답변 완료!',
						text: '해당 이슈에 답변이 등록되었습니다.',
					}).then((result2) => {
						if (result2.isConfirmed) {
							$('#modal').modal("hide"); // 모달 닫기
	            			$('#modal').on('hidden.bs.modal', function () {
	            				//location.reload();
								$(document).trigger('issueRelayComplete', { 
									issueRelayDetail: issueRelayDetail,
									issueRelayKeyNum: result.issueRelayKeyNum,
									issuePrimaryKeyNum: "${issuePrimaryKeyNum}",
									issueRelayStatus: issueRelayStatus
								});
	            			});	
						}
					})
				} else if(result.result == "UrlExport") {
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
		var issueRelayStatus = $('#issueRelayStatus:checked').val();
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
				"issueRelayKeyNum": "${issueRelayKeyNum}",
				"issuePrimaryKeyNum": "${issuePrimaryKeyNum}",
				"issueRelayType": "개발",
				"issueRelayStatus": issueRelayStatus
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
	            				//location.reload();
								$(document).trigger('issueRelayCompleteUpdate', { 
									issueRelayDetail: issueRelayDetail,
									issueRelayKeyNum: "${issueRelayKeyNum}",
									issuePrimaryKeyNum: "${issuePrimaryKeyNum}",
									issueRelayStatus: issueRelayStatus
								});
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
			placeholder:"수정내용!",
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
<style>
	.radio-container {
		width: 100%;
		padding: 20px;
		padding-bottom: 30px;
		background-color: #ffffff;
		border-radius: 10px;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	}

	.radio-group {
		flex-direction: column;
	}

	.radio-group label {
		display: flex;
		align-items: center;
		margin-bottom: 10px;
		cursor: pointer;
		position: relative;
		padding-left: 35px;
		user-select: none;
		font-size: 16px;
		color: #333;
		width: 33%;
		float: left;
	}

	.radio-group input[type="radio"] {
		position: absolute;
		opacity: 0;
		cursor: pointer;
	}

	.radio-group .checkmark {
		position: absolute;
		top: 0;
		left: 0;
		height: 15px;
		width: 15px;
		background-color: #ccc;
		border-radius: 50%;
	}

	.radio-group input:checked ~ .checkmark {
		background-color: #2196F3;
	}

	.radio-group .checkmark:after {
		content: "";
		position: absolute;
		display: none;
	}

	.radio-group input:checked ~ .checkmark:after {
		display: block;
	}

	.radio-group .checkmark:after {
		top: 5px;
		left: 5px;
		width: 5px;
		height: 5px;
		border-radius: 50%;
		background: white;
	}
</style>