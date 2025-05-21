<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

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
											<div style="height: 75px; width: 50%; float: left;">
												<label class="labelFontSize">SQL 타입</label>
												<select class="form-control selectpicker" id="sqlType" name="sqlType" data-live-search="true" data-size="5" data-actions-box="true">
													<option value="tibero">Tibero</option>
													<option value="mysql">MySQL</option>
													<option value="mariadb">MariaDB</option>
													<option value="oracle">Oracle</option>
													<option value="mssql">MSSQL</option>
												</select>
											</div>
											<div class="divInput">
												<label class="labelFontSize">호스트 IP</label>
												<input class="form-control" type="text" id="sqlIp" name="sqlIp" style="height: 35px;" placeholder="127.0.0.1" value="172.16.50.93"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize">사용자</label>
												<input class="form-control" type="text" id="sqlUser" name="sqlUser" placeholder="TOSMS8" value="TOSMS8"> 
											</div>
											<div class="divInput">
	                                			<label class="labelFontSize">암호</label>
												<input class="form-control" type="password" id="sqlPasswd" name="sqlPasswd" value="TOSMS8"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize">포트</label>
												<input class="form-control" type="text" id="sqlPort" name="sqlPort" value="8629"> 
											</div>
											<div class="divInput">
												<label class="labelFontSize" id="sidDbname">SID</label>
												<input class="form-control" type="text" id="sqlSid" name="sqlSid" value="tibero"> 
											</div>
											<label class="labelFontSize">SQL 쿼리</label>
											<button type="button" class="btn btn-outline-info-nomal myBtn" id="btnFormat" style="float: right; border-bottom: none;">SQL Format</button>
											<button type="button" class="btn btn-outline-info-nomal myBtn" id="btnConnect" style="float: right; border-bottom: none; border-right: none;">연결 테스트</button>
											<textarea class="textQuery" rows="15" id="sqlQuery" name="sqlQuery" onkeydown="resize(this)" onkeyup="resize(this)" placeholder="- 쿼리 실행 예시 -&#10;SELECT * &#10;FROM tos_employee;&#10;&#10;&#10;- SQL Format 예시 -&#10;SELECT * FROM tos_employee WHERE empnum = ? &#10;[2024-04-19 09:12:03.419][DEBUG]base.TosLog.GetEmployeeOne[debug:139] - ==> Parameters: admin(String)" spellcheck="false"></textarea>
											<br><br>
											<div style="width: 100%; text-align: center;">
												<button type="button" class="btn btn-default btn-outline-info-add" id="btnExecute">Execute</button>
											</div>
											<br>
											<span style="color: blue">최대 데이터 200개 출력</span>
											<div id="resultSQL" class="resultDiv"></div>
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
		        url: "<c:url value='/sqlExecution/connect'/>",
				data: postDate,
		        async: false,
		        success: function (result) {
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: 'DB서버 연결에 성공했습니다.',
						});
					} else if(result == "FALSE") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: 'DB서버 연결에 실패 하였습니다.',
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

		$('#btnFormat').click(function() {
			var sqlQuery = $('#sqlQuery').val();
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/sqlExecution/format'/>",
				data: {"sqlQuery": sqlQuery},
		        async: false,
		        success: function (result) {
					if(result == "FALSE") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: 'SQL Format 문서 양식을 확인하세요.',
						});
					} else {
						var lines = result.split('\n');
						for (var i = 0; i < lines.length; i++) {
						    lines[i] = lines[i].substring(4);
						}

						// 첫 번째 줄이 공백인지 확인
						if (lines[0].trim() === "") {
						    // 공백이면 첫 번째 줄 삭제
						    lines.shift();
						}

						// 새로운 문자열로 조합
						var newStr = lines.join('\n');
						$('#sqlQuery').val(newStr);
						resize($('#sqlQuery')[0]);
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
					text: 'SQL 쿼리문을 입력해주세요.',
				});
				return true;
			}
			var postDate = $("#form").serializeArray();
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/sqlExecution/excute'/>",
				data: postDate,
		        async: false,
		        success: function (result) {
					$("#resultSQL").empty();
					$('#resultSQL').append(result);
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

		$("#sqlType").change(function() {
			var sqlType = $('#sqlType').val();
			if(sqlType == 'tibero') {
				$('#sqlIp').val('172.16.50.93');
				$('#sqlPort').val("8629");
				$('#sqlSid').val("tibero");
				$('#sidDbname').text("SID");
			} else if(sqlType == "mysql") {
				$('#sqlIp').val('172.16.50.104');
				$('#sqlPort').val("3306");
				$('#sqlSid').val("TOSMS8");
				$('#sidDbname').text("DB NAME");
			} else if(sqlType == "oracle") {
				$('#sqlIp').val('172.16.50.95');
				$('#sqlPort').val("1521");
				$('#sqlSid').val("orcl");
				$('#sidDbname').text("SID");
			} else if(sqlType == "mariadb") {
				$('#sqlIp').val('172.16.50.97');
				$('#sqlPort').val("3306");
				$('#sqlSid').val("TOSMS8");
				$('#sidDbname').text("DB NAME");
			} else if(sqlType == "mssql") {
				$('#sqlIp').val('172.16.50.172');
				$('#sqlPort').val("1433");
				$('#sqlSid').val("TOSMS8");
				$('#sidDbname').text("DB NAME");
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
		}

		.textQuery {
			width: 100%;
			min-height: 215px;
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