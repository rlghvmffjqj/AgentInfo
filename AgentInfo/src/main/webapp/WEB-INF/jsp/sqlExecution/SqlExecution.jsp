<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- datetimepicker -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/datetimepicker/jquery.datetimepicker.min.css'/>">
		<script type="text/javascript" src="<c:url value='/datetimepicker/jquery.datetimepicker.full.min.js'/>"></script>

		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','sqlExecution');
		    });
		</script>
		<script>
			
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
							                <h5 class="m-b-10">SQL 실행</h5>
							                <p class="m-b-0">SQL Execution</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">SQL 실행</a>
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
											<div style="height: 75px;">
												<label class="labelFontSize">SQL 타입</label>
												<select class="form-control selectpicker" id="sqlType" name="sqlType" data-live-search="true" data-size="5" data-actions-box="true">
													<option value="tibero">Tibero</option>
													<option value="myaql">MySQL</option>
													<option value="oracle">Oracle</option>
													<option value="mssql">MSSQL</option>
												</select>
											</div>
											<div class="divInput">
												<label class="labelFontSize">호스트 IP</label>
												<input class="form-control" type="text" id="sqlIp" name="sqlIp" placeholder="127.0.0.1" value="172.16.50.182"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize">포트</label>
												<input class="form-control" type="text" id="sqlPort" name="sqlPort" value="8629"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize">사용자</label>
												<input class="form-control" type="text" id="sqlUser" name="sqlUser" placeholder="TOSMS8" value="TOSMS8"> 
											</div>
											<div class="divInput">
	                                			<label class="labelFontSize">암호</label>
												<input class="form-control" type="password" id="sqlPasswd" name="sqlPasswd" value="TOSMS8"> 
											</div>
											<label class="labelFontSize">SQL 쿼리</label>
											<textarea class="textQuery" rows="15" id="sqlQuery" name="sqlQuery" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
											<br><br>
											<div style="width: 100%; text-align: center;">
												<button type="button" class="btn btn-default btn-outline-info-add" id="btnExecute">Execute</button>
											</div>
											<br><br>
											<textarea class="textQuery" rows="15" id="mailText" name="mailText" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
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

		$('#btnExecute').click(function() {
			var postDate = $("#form").serializeArray();
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/sqlExecution/excute'/>",
				data: postDate,
		        async: false,
		        success: function (result) {
					alert(result);
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

		.textQuery {
			width: 100%;
			height: 215px;
		}

		.divInput {
			width: 50%;
			float: left;
			height: 75px;
		}

	</style>
</html>