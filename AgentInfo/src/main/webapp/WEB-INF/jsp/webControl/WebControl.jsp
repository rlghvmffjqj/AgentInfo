<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','webControl');
		    });
		</script>
		<script>
			
		</script>
	</head>
	<body>
	<div id="pcoded" class="pcoded iscollapsed">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
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
							                <h5 class="m-b-10">웹 명령어 실행</h5>
							                <p class="m-b-0">Run web command</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">웹 명령어 실행</a>
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
											<div class="divInput" style="width: 100%">
												<label class="labelFontSize">서버 IP</label>
												<input class="form-control" type="text" id="cmdIp" name="cmdIp" style="height: 35px;" placeholder="127.0.0.1" value="172.16.50.174"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize">사용자 이름</label>
												<input class="form-control" type="text" id="cmdUser" name="cmdUser" placeholder="root" value="root"> 
											</div>
											<div class="divInput">
	                                			<label class="labelFontSize">암호</label>
												<input class="form-control" type="password" id="cmdPasswd" name="cmdPasswd" value="secuve00."> 
											</div>
											<label class="labelFontSize">Command 명령어(프로세스 경로 : /usr/sbin/sshd 지정하고 테스트 진행)</label>
											<button type="button" class="btn btn-outline-info-nomal myBtn" id="btnConnect" style="float: right; border-bottom: none; border-right: none;">연결 테스트</button>
											<textarea class="textCmd" rows="10" id="command" name="command" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="ip a" spellcheck="false">ip a</textarea>
											<br><br>
											<div style="width: 100%; text-align: center;">
												<button type="button" class="btn btn-default btn-outline-info-add" id="btnExecute">전송</button>
											</div>
											<br>
											<div id="resultCmd" class="resultDiv"></div>
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
		/* =========== TextArea 범위 초과시 크기 증가 ========= */
		function resize(obj) {
			obj.style.height = "200px";
			obj.style.height = (17+obj.scrollHeight)+"px";
		}

		// 값이 할당될 때마다 textarea의 높이를 조절
		$('#sqlQuery').on('input', function() {
		    autoResize(this);
		});

		$('#btnConnect').click(function() {
			var postDate = $("#form").serializeArray();
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/webControl/connect'/>",
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
		})


		$('#btnExecute').click(function() {
			if($('#sqlQuery').val() == "") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '명령어를 입력해주세요.',
				});
				return true;
			}
			var postDate = $("#form").serializeArray();
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/webControl/excute'/>",
				data: postDate,
		        async: false,
		        success: function (result) {
					$("#resultCmd").empty();
					$('#resultCmd').append(result);
		        },
		        error: function(e) {
		            Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업에 실패하였습니다.',
					});
		        }
		    });
		})
		
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
		}

		.textCmd {
			width: 100%;
			min-height: 150px;
			height: auto;
			padding: 10px;
			line-height: 1.2;
			font-family: 'themify';
		}

		.divInput {
			width: 50%;
			float: left;
			height: 75px;
		}

		.resultDiv {
			width: 100%; 
			height: 300px; 
			border: 1px solid; 
			overflow: scroll;
			background: #f6f8ff;
			padding: 1%;
			font-size: 15px;
    		line-height: 20px;
		}

		.resultTh {
			border: 1px solid;
 		    padding: 7px;
			background: #77aaff4d;
		}

		.resultTd {
			padding: 1px;
			padding-right: 20px;
		}

		.errorDiv {
			padding: 10px;
		}

		.errorSpan {
			color: red;
			font-size: 17px;
		}
	</style>
</html>