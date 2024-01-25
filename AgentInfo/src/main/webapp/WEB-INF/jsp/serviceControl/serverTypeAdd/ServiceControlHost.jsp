<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 200px; padding-top: 9%;">
	<div class="card-block margin10">
		 <form class="modalForm form-material" name="modalForm" id="modalForm" method ="post">	
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlPurpose" name="serviceControlPurpose" class="form-control" value="" placeholder="고객사 전용">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">사용 목적</label>
			</div>
			<div class="form-group form-default form-static-label">
			    <input type="text" id="serviceControlIp" name="serviceControlIp" class="form-control" value="" placeholder="172.16.0.0">
			    <span class="form-bar"></span>
			    <label class="float-label headLabel">서버 IP</label>
			</div>
			<input id="serviceControlServerType" name="serviceControlServerType" type="hidden" value="${serviceControlServerType}">
		 </form>
     </div>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#insertBtn').click(function() {
		showLoadingImage();
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/serviceControl/insert'/>",
	        type: 'post',
	        data: postData,
	        success: function(result) {
				hideLoadingImage();
				if(result === 'OK') {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
	        		$('#modal').on('hidden.bs.modal', function () {
	        			tableRefresh();
	        		});
				} else if(result == "duplication") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: "동일한 서버가 존재 합니다.",
					});
				} else if(result == "pcOff") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: "서비스 등록은 완료 하였지만, PC전원이 종료 되어 있습니다.",
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
		        	});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: "작업 실패 하였습니다.",
					});
				}
			},
			error: function(error) {
				hideLoadingImage();
				Swal.fire({
					icon: 'error',
					title: '에러!',
					text: "작업 처리 중 에러가 발생하였습니다. 관리자에게 문의 바랍니다.",
				})
				console.log(error);
			}
	    });
	});

	
</script>

