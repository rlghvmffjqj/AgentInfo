<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="modal-body" style="width: 100%; height: 220px; padding-top: 5%;">
	<div class="card-block margin10">
		<button class="btn btn-default btn-outline-info-add serviceControlTypeBtn serviceBtnBoldColor" id="managerServerBtn">관리 서버</button>
		<button class="btn btn-default btn-outline-info-add serviceControlTypeBtn serviceBtnBoldColor" id="DbServerBtn">DB 서버</button>
		<button class="btn btn-default btn-outline-info-add serviceControlTypeBtn serviceBtnBoldColor" id="HostServerBtn">Host 서버</button>
     </div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#managerServerBtn').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/serviceControl/serviceControlManager'/>",
			data: {"serviceControlServerType":"managerServer"},
		    async: false,
		    success: function (data) {
				$('#modal').modal("hide");
				$('#modal').on('hidden.bs.modal', function () {
					$.modal(data, 'serviceControlManager'); //modal창 호출
				})
		    },
		    error: function(e) {
		        alert(e);
		    }
		});		
	});

	$('#DbServerBtn').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/serviceControl/serviceControlDB'/>",
			data: {"serviceControlServerType":"dbServer"},
		    async: false,
		    success: function (data) {
				$('#modal').modal("hide");
				$('#modal').on('hidden.bs.modal', function () {
		    		$.modal(data, 'serviceControlDB'); //modal창 호출
				})
		    },
		    error: function(e) {
		        alert(e);
		    }
		});		
	});

	$('#HostServerBtn').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/serviceControl/serviceControlHost'/>",
			data: {"serviceControlServerType":"hostServer"},
		    async: false,
		    success: function (data) {
				$('#modal').modal("hide");
				$('#modal').on('hidden.bs.modal', function () {
		    		$.modal(data, 'serviceControlHost'); //modal창 호출
				})
		    },
		    error: function(e) {
		        alert(e);
		    }
		});		
	});

</script>

<style>
	.serviceControlTypeBtn {
		width: 100%;
		height: 38px;
		margin-bottom: 5%;
		font-size: 14px;
	}

	.serviceBtnBoldColor {
		border-color: #003eff4f;
	}

	.serviceBtnBoldColor:hover {
		background-color: #0000ffa3;
		border-color: white;
	}
</style>

