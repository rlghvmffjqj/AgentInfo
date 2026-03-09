<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 700px;">
	<div id="loadImage" style="position:absolute; top:50%; left:50%;width:0px;height:0px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; text-align:center; display:none;">
		<img src="/AgentInfo/images/loding.gif" style="width:100px; height:100px;">
	</div>
	<form id="modalForm" name="modalForm" method="post" enctype="multipart/form-data">
		<h4 style="text-align: center;"><strong>자동화 테스트</strong></h4>
		<div class="pading5">
	    	<label class="labelFontSize">제목</label>
	    	<input type="text" id="seleniumTitleView" name="seleniumTitleView" class="form-control viewForm" placeholder="TOSMS 5.0.22 서버관리/서버목록" value="${selenium.seleniumTitle}">
	    </div>
		<div class="pading5">
	    	<label class="labelFontSize">주소</label>
	    	<input type="text" id="seleniumAddressView" name="seleniumAddressView" class="form-control viewForm" placeholder="https://172.16.50.0:8443/TOSMS/LoginText" value="${selenium.seleniumAddress}">
	    </div>
		<div class="pading5">
			<label class="labelFontSize">행동 단계</label>
			<textarea class="form-control" id="seleniumActionStepsView" name="seleniumActionStepsView" spellcheck="false">${selenium.seleniumActionSteps}</textarea>
		</div>
		<input class="form-control" type="hidden" id="seleniumKeyNum" name="seleniumKeyNum" value="${selenium.seleniumKeyNum}">
		<div style="height: 20px"></div>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="startButton">녹화</button>
	<button class="btn btn-default btn-outline-info-del" id="stopButton">중지</button>
	<button class="btn btn-default btn-outline-info-nomal" id="saveButton">저장</button>
	<button class="btn btn-default btn-outline-info-nomal" id="runButton">재생</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#startButton').click(function() {
		var seleniumTitleView = $('#seleniumTitleView').val();
		var seleniumAddressView = $('#seleniumAddressView').val();

		if(seleniumTitleView == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '자동화 테스트 제목을 입력해주세요.',
			});
			return false;
		}

		if(seleniumAddressView == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '자동화 테스트 주소를 입력해주세요.',
			});
			return false;
		}
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/selenium/start'/>",
			data: {
				"seleniumTitleView": seleniumTitleView,
				"seleniumAddressView": seleniumAddressView
			},
		    async: false,
		    success: function (data) {
				
		    },
		    error: function(e) {
		        alert(e);
		    }
		});	
	});

	$('#stopButton').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/selenium/stop'/>",
		    async: false,
		    success: function (data) {
				$('#seleniumActionStepsView').val(data);
		    },
		    error: function(e) {
		        alert(e);
		    }
		});	
	});

	$('#runButton').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/selenium/run'/>",
		    async: false,
		    success: function (data) {
				
		    },
		    error: function(e) {
		        alert(e);
		    }
		});	
	});

	
	$('#saveButton').click(function() {
		var seleniumTitleView = $('#seleniumTitleView').val();
		var seleniumAddressView = $('#seleniumAddressView').val();
		var seleniumActionStepsView = $('#seleniumActionStepsView').val();

		if(seleniumTitleView == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '자동화 테스트 제목을 입력해주세요.',
			});
			return false;
		}

		if(seleniumAddressView == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '자동화 테스트 주소를 입력해주세요.',
			});
			return false;
		}

		if(seleniumActionStepsView == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '행동 단계 값이 비어 있습니다. 녹화 완료 후 저장 바랍니다.',
			});
			return false;
		}

		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/selenium/insert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});
</script>

<style>
	#seleniumActionStepsView {
		height: 490px;
		background: #1F1F1F;
		color: #DCDC8B;
		resize: none;
		padding: 10px;
    	font-size: 13px;
    	font-family: Arial, sans-serif;
    	line-height: 1.5;
    	border: 1px solid rgb(204, 204, 204);
    	border-radius: 5px;
	}

	textarea {
	    -webkit-user-modify: read-write-plaintext-only; /* Chrome / Safari */
	    -moz-appearance: none; /* 일부 Firefox */
	}
</style>
