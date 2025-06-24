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
		    	$.cookie('name','automatedTesting');
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
							                <h5 class="m-b-10">자동화 테스트</h5>
							                <p class="m-b-0">Automated Testing</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">자동화 테스트</a>
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
	                                	<div class="searchbos">
											<button id="addAccount">계정 신규신청</button>
	                     				</div>
	                                </div>
									<div>
										<div class="testingResultTitle">자동화 테스트 결과</div>
										<textarea spellcheck="false" style="width: 100%; height: 500px;" id="testingResult"></textarea>
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
		$(function() {
		    $('#addAccount').click(function() {
		        $.ajax({
		            url: '<c:url value="/automatedTesting/addAccount"/>',
		            method: 'POST',
					async: false,
		            success: function(response) {
						$('#testingResult').text("성공\n" + response);
		            },
		            error: function(xhr) {
						$('#testingResult').text("실패\n" + xhr.responseText);
		            }
		        });
		    });
		});		
	</script>

	<style>
		#addAccount {
		  background: linear-gradient(135deg, #D46A45, #B45230);
		  color: #FFF5E6;
		  border: none;
		  padding: 12px 32px;
		  font-size: 16px;
		  font-weight: 700;
		  border-radius: 10px;
		  cursor: pointer;
		  box-shadow: 0 6px 15px rgba(212, 106, 69, 0.7);
		  transition: background 0.3s ease, box-shadow 0.3s ease, transform 0.2s ease;
		}

		#addAccount:hover {
		  background: linear-gradient(135deg, #E67E53, #C35A2F);
		  box-shadow: 0 10px 25px rgba(195, 90, 47, 0.9);
		  transform: translateY(-3px);
		}

		#addAccount:active {
		  transform: translateY(-1px);
		  box-shadow: 0 6px 12px rgba(212, 106, 69, 0.8);
		}

		.testingResultTitle {
			text-align: center;
    		height: 50px;
    		width: 100%;
    		background: #2A4C67;
    		padding-top: 1%;
    		color: white;
    		font-size: 17px;
    		font-weight: bold;
		}

		#testingResult {
			padding: 10px;
    		font-size: 15px;
    		word-spacing: 5px;
    		line-height: 20px;
			font-family: none;
		}





	</style>
</html>