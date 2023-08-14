<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
    <div class="modelHeadFont">테스트 케이스 복사</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
    <table style="margin:20px">
        <tbody>
            <input type="text" id="testCaseRouteCustomerView" name="testCaseRouteCustomerView" style="width: 100%; margin-top: 5%;" value="${testCase.testCaseFormName}" placeholder="고객사" autofocus>
			<input type="text" id="testCaseRouteNoteView" name="testCaseRouteNoteView" style="width: 100%; margin-top: 7%;" value="${testCase.testCaseFormName}" placeholder="비고">
            <input type="hidden" id="testCaseRouteGroupNum" name="testCaseRouteGroupNum" value="${testCaseRouteGroupNum}">
        </tbody>
    </table>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-add" id="copyBtn" onclick="copyBtn();">복사</button>	
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});
	
	/* =========== Enter Key ========= */
	$("#fileName").keypress(function(event) {
		if (window.event.keyCode == 13) {
			copyBtn();
		}
	});
	
    $('#copyBtn').click(function() {
        var testCaseRouteGroupNum = $('#testCaseRouteGroupNum').val();
        var testCaseRouteCustomer = $('#testCaseRouteCustomerView').val();
		var testCaseRouteNote = $('#testCaseRouteNoteView').val();
		var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();

		if(testCaseRouteCustomer == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '고객사를 입력해주세요.',
			});
			return false;
		}

		if(testCaseRouteNote == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '비고를 입력해주세요.',
			});
			return false;
		}

		Swal.fire({
			  title: '복사!',
			  text: "복사 이후 고객사 및 비고를 변동 할 수 없습니다. 계속 진행하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#7066e0',
			  cancelButtonColor: '#FF99AB',
			  confirmButtonText: 'OK'
		}).then((result) => {
		  	if (result.isConfirmed) {
        		$.ajax({
					url: "<c:url value='/testCase/copy'/>",
	    		    type: 'post',
	    		    data: {
						"testCaseRouteGroupNum" : testCaseRouteGroupNum,
						"testCaseRouteCustomer" : testCaseRouteCustomer,
						"testCaseRouteNote" : testCaseRouteNote,
						"testCaseFormKeyNum" : testCaseFormKeyNum,
					},
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
        		        } else if(result == "Duplication") {
        		            Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '동일한 고객사 및 비고가 존재합니다.',
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
		});
    });
</script>
