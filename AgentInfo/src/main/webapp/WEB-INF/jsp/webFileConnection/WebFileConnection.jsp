<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','webFileConnection');
		    });
		</script>	
	</head>
	<body>
	<div id="pcoded" class="pcoded iscollapsed">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
			<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
			<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
			<div class="pcoded-main-container" style="margin-top: 56px;">
				<div class="pcoded-wrapper">
					<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
					<div class="pcoded-content" id="page-wrapper">
						<div class="page-header">
							<div class="page-block">
							    <div class="row align-items-center">
							        <div class="col-md-8">
							            <div class="page-header-title" >
							                <h5 class="m-b-10">웹 파일 실시간 통신</h5>
							                <p class="m-b-0">Run web command</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">웹 파일 실시간 통신</a>
							                </li>
							            </ul>
							        </div>
							    </div>
							</div>
						</div>
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                	<div class="ibox">
										<form id="form" name="form" method ="post">
											<div class="divInput">
												<label class="labelFontSize">서버 IP</label>
												<input class="form-control" type="text" id="connectIp" name="connectIp" style="height: 35px;" placeholder="127.0.0.1" value="172.16.50.174"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize">서버 타입</label>
												<select class="form-control selectpicker selectForm" id="connectType" name="connectType">
													<option value="linux">Linux</option>
													<option value="windows">Windows</option>
												</select>
											</div>
											<div class="divInput">
												<label class="labelFontSize">사용자 이름</label>
												<input class="form-control" type="text" id="connectUser" name="connectUser" placeholder="root" value="root"> 
											</div>
											<div class="divInput">
	                                			<label class="labelFontSize">암호</label>
												<input class="form-control" type="password" id="connectPasswd" name="connectPasswd" value="secuve00."> 
											</div>
											<div class="divInput" style="width: 100%">
												<label class="labelFontSize">파일 경로</label>
												<input class="form-control" type="text" id="connectRoot" name="connectRoot" style="height: 35px;" placeholder="/sw/tomcat/logs/catalina.out" value="/sw/tomcat/logs/catalina.out"> 
											</div>
											
											<button type="button" class="btn btn-outline-info-nomal myBtn webBtn" id="btnConnectTest">연결 테스트</button>
											<button type="button" class="btn btn-outline-info-nomal myBtn webBtn" id="btnRemove">지우기</button>
											<button type="button" class="btn btn-outline-info-del myBtn webBtn" id="btnDisconnect">연결 해제</button>
											<button type="button" class="btn btn-outline-info-add myBtn webBtn" id="btnConnect">연결</button>
											<br>
											<button type="button" class="btn btn-outline-info-nomal darkBtn" id="btnDark">Dark</button>
											<button type="button" class="btn btn-outline-info-nomal whiteBtn" id="btnWhite">White</button>
											<div style="width: 70px; margin-left: 10px; float: left;">
												<select class="form-control selectpicker selectForm" id="selectFont" name="selectFont" data-size="5">
													<option value="10">10px</option>
													<option value="11">11px</option>
													<option value="12">12px</option>
													<option value="13">13px</option>
													<option value="14" selected>14px</option>
													<option value="15">15px</option>
													<option value="16">16px</option>
													<option value="17">17px</option>
													<option value="18">18px</option>
													<option value="19">19px</option>
													<option value="20">20px</option>
										 		</select>
											</div>
											<div id="resultDiv" class="resultDiv"></div>
										</form>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>

	<script>
		$('#btnConnectTest').click(function() {
			var postDate = $("#form").serializeArray();
			const connectType = $('#connectType').val();

			var connectUrl = '';
			if(connectType == 'linux') {
				connectUrl = "<c:url value='/webFileConnection/connectTest'/>";
			} else {
				connectUrl = "<c:url value='/webFileConnection/connectTestWin'/>";
			}
			
			$.ajax({
		        type: 'POST',
		        url: connectUrl,
				data: postDate,
		        async: false,
		        success: function (result) {
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '연결 성공했습니다.',
						});
					} else if(result == "FALSE") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '연결 실패 하였습니다.',
						});
					}
		        },
		        error: function(e) {
		            Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업에 실패하였습니다.',
					});
		        }
		    });
		});

		
		$('#btnRemove').click(function() {
			$('#resultDiv').html('');
		});

	
        $('#btnConnect').click(function() {
            connect();
        });
        $('#btnDisconnect').click(function() {
            disconnect();
        });

		let socket = null;
		let connectionId = null;
		let stateType = 0;

        function connect() {
            const host = $('#connectIp').val();
            const user = $('#connectUser').val();
            const password = $('#connectPasswd').val();
            const filePath = $('#connectRoot').val();
			const connectType = $('#connectType').val();
			var port = 0;
			if(connectType == 'linux') {
				port = 22;
			} else {
				port = 22;
			}

			// 고유한 식별자 생성 (예: 현재 타임스탬프 사용)
			connectionId = new Date().getTime().toString();

			var parameters = host+','+port+','+user+','+password+','+filePath+','+connectType+','+connectionId;
            socket = new WebSocket('wss://' + window.location.host + '/AgentInfo/webFileConnection');
			stateType = 1;
            socket.onopen = () => {
				$('#resultDiv').html('');
                console.log('WebSocket connection opened');
				Swal.fire({
					icon: 'success',
					title: '연결!',
					html: host+'서버<br>'+filePath+'파일 연결하였습니다.',
				});
                
                socket.send(parameters);
            };
            socket.onmessage = (event) => {
                const resultDiv = $('#resultDiv');
				if(event.data.includes("exception") || event.data.includes("Exception") || event.data.includes("false") || event.data.includes("False") || event.data.includes("FALSE") || event.data.includes("error") || event.data.includes("Error")) {
                	resultDiv.append('<div style="color: #ff6969;">' + event.data + '</div>');
				} else if(event.data.includes("success")) {
					resultDiv.append('<div style="color: #70ff5a;">' + event.data + '</div>');
				} else {
					resultDiv.append('<div>' + event.data + '</div>');
				}
				scrollToBottom();
            };

            socket.onclose = (event) => {
    		    console.log('WebSocket connection closed');
				if(stateType == 1) {
    		    	Swal.fire({
    		    	    icon: 'info',
    		    	    title: '연결해제!',
    		    	    text: '설정 시간이 초과하여 자동 연결해제합니다.(5분)',
    		    	});
				}
    		    console.log('Close event:', event);
    		};
		
    		socket.onerror = (error) => {
    		    console.error('WebSocket error:', error);
    		};
        }

        function disconnect() {
            if (socket && socket.readyState === WebSocket.OPEN) {
				stateType = 2;
        		Swal.fire({
        		    icon: 'success',
        		    title: '연결해제!',
        		    text: '정상적으로 연결 해제 되었습니다.',
        		});
        		console.log("WebSocket closed: ", event);
				socket.close();
            }
        }

		function scrollToBottom() {
		    var scrollBox = $('#resultDiv');
		    scrollBox.scrollTop(scrollBox.prop("scrollHeight"));
		}

		$('#btnDark').click(function() {
			$('#resultDiv').css('background', 'black');
			$('#resultDiv').css('color', 'white');
			$('#resultDiv').css('font-weight', '100');
		});

		$('#btnWhite').click(function() {
			$('#resultDiv').css('background', 'white');
			$('#resultDiv').css('color', 'black');
			$('#resultDiv').css('font-weight', 'normal');
			
		});

		$("#selectFont").change(function() {
			var selectFont = $("#selectFont").val();
			$('#resultDiv').css('font-size', selectFont+"px");
		});

		$("#connectType").change(function() {
			var connectType = $("#connectType").val();
			if(connectType == 'linux') {
				$('#connectUser').val("root");
				$('#connectIp').val("172.16.50.174");
				$('#connectRoot').val("/sw/tomcat/logs/catalina.out");
			} else {
				$('#connectUser').val("Administrator");
				$('#connectIp').val("172.16.50.192");
				$('#connectRoot').val("C:/Program Files/Apache Software Foundation/Tomcat 8.5/bin/logs/tosms/debug.log");
			}
		});
		
	</script>
	<style>
		.ibox {
			background: white;
    		padding: 46px;
    		border-radius: 10px;
    		border: 1px solid #dbdbdb;
		}

		.form-control:hover {
			border: none;
    		border-bottom: 3px solid #cccccc;
		}

		.form-control:focus {
			border: none;
    		border-bottom: 3px solid #cccccc;
		}

		.form-control {
			border: none;
    		border-bottom: 1px solid #cccccc;
		}

		.dropdown-toggle {
			border: none !important;
    		border-bottom: 1px solid #cccccc !important;
			border: 1px solid black !important;
		}

		.dropdown-toggle:hover {
			border-bottom: 0px !important;
		}

		.divInput {
			width: 50%;
			float: left;
			height: 75px;
		}

		.resultDiv {
			width: 100%; 
			height: 800px; 
			border: 1px solid; 
			overflow: scroll;
			background: black;
			color: white;
			padding: 1%;
			font-size: 14px;
    		line-height: 20px;
			font-weight: 100;
		}

		.webBtn {
			float: right; 
			border-bottom: none; 
			border-right: none;
		}

		.darkBtn {
			border-radius: 0 !important;
    		float: left;
			background-color: black;
			color: white;
		}

		.darkBtn:hover {
			background-color: gray;
		}

		.whiteBtn {
			border-radius: 0 !important;
    		float: left;
		}

		.whiteBtn:hover {
			background-color: rgb(231, 231, 231);
			color: black;
		}

		.dropdown-toggle {
			border: none !important;
    		border-bottom: 1px solid #cccccc !important;
		}
	</style>
</html>