<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" style="width: 100%; height: 700px;">
	<div id="loadImage" style="position:absolute; top:50%; left:50%;width:0px;height:0px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; text-align:center; display:none;">
		<img src="/AgentInfo/images/loding.gif" style="width:100px; height:100px;">
	</div>
	<form id="modalForm" name="form" method ="post">
		<h4 style="text-align: center;"><strong>자동화 테스트</strong></h4>
		<div class="pading5">
	    	<label class="labelFontSize">타이틀</label>
	    	<input type="text" id="seleniumTitleView" name="seleniumTitleView" class="form-control viewForm" placeholder="TOSMS 5.0.22 서버관리/서버목록" value="${selenium.seleniumTitle}">
	    </div>
		<div class="pading5">
	    	<label class="labelFontSize">URL 주소</label>
	    	<input type="text" id="seleniumAddressView" name="seleniumAddressView" class="form-control viewForm" placeholder="https://172.16.50.0:8443/TOSMS/LoginText" value="${selenium.seleniumAddress}">
	    </div>
		<div class="pading5">
	    	<label class="labelFontSize">상세 메모</label>
	    	<textarea class="form-control" id="seleniumDetailNoteView" name="seleniumDetailNoteView" spellcheck="false" placeholder="내용을 상세히 입력 바랍니다.">${selenium.seleniumDetailNote}</textarea>
	    </div>
		<div class="pading5">
			<label class="labelFontSize">행동 단계</label>
			<textarea class="form-control" id="seleniumActionStepsView" name="seleniumActionStepsView" spellcheck="false">${selenium.seleniumActionSteps}</textarea>
		</div>
		<input class="form-control" type="hidden" id="seleniumKeyNum" name="seleniumKeyNum" value="${selenium.seleniumKeyNum}">
		<input class="form-control" type="hidden" id="seleniumGroupName" name="seleniumGroupName" value="${selenium.seleniumGroupName}">
		<input class="form-control" type="hidden" id="seleniumGroupFullPath" name="seleniumGroupFullPath" value="${selenium.seleniumGroupFullPath}">
		<div style="height: 20px"></div>
	</form>
</div>
<div class="modal-footer">
	<dis style="width: 33%;">
		<button class="btn btn-default btn-outline-info-add" id="startButton">시작</button>
		<button class="btn btn-default btn-outline-info-del" id="stopButton">중지</button>
		<button class="btn btn-default btn-outline-info-nomal" id="saveButton">저장</button>
		<button class="btn btn-default btn-outline-info-nomal" id="runButton">재생</button>
	</dis>
	
	<dis style="width: 33%; text-align: center;">
		<button class="control-btn" id="toggleBtn">⏸</button>
		<button class="control-btn" id="toggleNextBtn" style="font-weight: bold;">≫</button>
	</dis>
		
	
	<dis style="width: 34%;">
		<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal" style="float: right;">닫기</button>
	</dis>
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
				if(data == "FALSE") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '현재 에이전트가 정상적으로 실행 중인지 확인해 주세요',    
					});  
				}
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
				if(data == "FALSE") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '현재 에이전트가 정상적으로 실행 중인지 확인해 주세요',    
					});  
				} else if(data == "Empty") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '값이 존재하지 않습니다.',    
					});  
				} else {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '정상 중지 하였습니다.',
					});
					$('#seleniumActionStepsView').val(data);
				}
				
		    },
		    error: function(e) {
		        alert(e);
		    }
		});	
	});

	$('#runButton').click(function() {	
		$('#toggleBtn').text('⏸');
		isPlaying = true;
		
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

		var postData = $('#modalForm').serializeObject();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/selenium/run'/>",
			data: postData,
		    async: false,
		    success: function (data) {
				if(data.result == "OK") {
					tableRefresh();
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '현재 에이전트가 정상적으로 실행 중인지 확인해 주세요',    
					});  
				}
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
				if(result.result == "OK") {
					tableRefresh();
					$('#seleniumKeyNum').val(result.seleniumKeyNum);
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '데이터 추가에 실패하였습니다.',    
					});  
				}
			},
			error: function(error) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '작업을 실패했습니다.',    
				});  
			}
	    });
	});

  	let isPlaying = true;

  	$('#toggleBtn').on('click', function() {
    	isPlaying = !isPlaying;

    	$(this).text(isPlaying ? '⏸' : '▶');

		console.log(isPlaying);
    	if (isPlaying) {
    	  	console.log('재생 시작');
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/selenium/reRun'/>",
			    async: false,
			    success: function (result) {
					if(result == "OK") {
						tableRefresh();
						Swal.fire({
							icon: 'success',
							title: '재생!',
							text: '이어서 재생하였습니다.',
						});
					} else {
						Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: '현재 에이전트가 정상적으로 실행 중인지 확인해 주세요',    
						});  
					}
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
    	} else {
    	  	console.log('일시 정지');
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/selenium/pause'/>",
			    async: false,
			    success: function (result) {
					if(result == "OK") {
						tableRefresh();
						Swal.fire({
							icon: 'success',
							title: '일시 정지!',
							text: '일시 정지 하였습니다.',
						});
					} else {
						Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: '현재 에이전트가 정상적으로 실행 중인지 확인해 주세요',    
						});  
					}
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
    	}
		
 	});


	$('#toggleNextBtn').on('click', function() {
		console.log(isPlaying);
		if(!isPlaying) {
			console.log('1 STEP 재생');
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/selenium/nextRun'/>",
			    async: false,
			    success: function (result) {
					if(result == "OK") {
						tableRefresh();
						Swal.fire({
							icon: 'success',
							title: '재생!',
							text: '1 STEP 재생 완료.',
						});
					} else {
						Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: '현재 에이전트가 정상적으로 실행 중인지 확인해 주세요',    
						});  
					}
			    },
			    error: function(e) {
			        alert(e);
			    }
			});		
		} else {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '재생 상태가 중지인 상태에서만 사용 가능합니다.',    
			});  
		}
		
	});
</script>

<style>
	#seleniumActionStepsView {
		height: 350px;
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

	#seleniumDetailNoteView {
		height: 100px;
		resize: none;
		padding: 10px;
    	font-size: 13px;
    	font-family: Arial, sans-serif;
    	line-height: 1.5;
    	border: 1px solid #dab17d;
    	border-radius: 5px;
	}

	textarea {
	    -webkit-user-modify: read-write-plaintext-only; /* Chrome / Safari */
	    -moz-appearance: none; /* 일부 Firefox */
	}

  	.control-btn {
    	width: 30px;
    	height: 30px;
    	border-radius: 50%;
    	border: none;
    	background: linear-gradient(145deg, #ffffff, #f36464);
    	color: #8a005f;
    	font-size: 20px;
    	cursor: pointer;
    	box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    	transition: all 0.2s ease;
 	}

  	.control-btn:hover {
  	  	transform: translateY(-3px) scale(1.05);
  	  	box-shadow: 0 12px 25px rgba(0,0,0,0.2);
  	}

  	.c	ontrol-btn:active {
  	  	transform: scale(0.95);
  	  	box-shadow: 0 5px 10px rgba(0,0,0,0.2);
  	}
</style>
