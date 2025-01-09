<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','license');
		    });
	    </script>
	    
	    <script>
	    	$(document).ready(function(){
	            $("#disconn").on("click", (e) => {
	            	disconnect();
	            })
	            
	            $("#button-send").on("click", (e) => {
	                send();
	            });
	
	            
	            const websocket = new WebSocket("wss://localhost/AgentInfo/licensSocket");
	
	            websocket.onmessage = onMessage;
	            websocket.onopen = onOpen;
	            websocket.onclose = onClose;
	
	            function send(){
	                let msg = document.getElementById("msg");
	
	                console.log(msg.value);
	                websocket.send(msg.value);
	                msg.value = '';
	            }
	            
	            //채팅창에서 나갔을 때
	            function onClose(evt) {
	            	console.log("WebSocket Disconnect!!");
	            }
	            
	            //채팅창에 들어왔을 때
	            function onOpen(evt) {
	            	console.log("WebSocket Sconnect!!");
	            }
				
	            // 메시지 받앗을 때
	            function onMessage(msg) {
	                var data = msg.data;
	                console.log(data);
	                if(data == "OK")
						Swal.fire(
							'Success!',
							'라이선스 발급 하였습니다.',
							'success'
						)
					else if(data == "FALSE")
						Swal.fire(
							'Failure!',
							'라이선스 발급에 실패하였습니다.',
							'error'
						)
	            }
            })
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
									            <h5 class="m-b-10">라이선스 발급</h5>
									            <p class="m-b-0">License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">라이선스 발급</a>
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
	                                		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">버튼</button>
	                                		
	                                		<div id="msgArea" class="col"></div>
							                <div class="col-6">
							                    <div class="input-group mb-3">
							                        <input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
							                        <div class="input-group-append">
							                            <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
							                            <button class="btn btn-outline-secondary" type="button" id="disconn">해제</button>
							                        </div>
							                    </div>
							                </div>
							                
	                                	</div>
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
		/* =========== 고객사 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/license/button'/>",
			    async: false,
			    success: function (data) {
					console.log(data);
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
	</script>
</html>