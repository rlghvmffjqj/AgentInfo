<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','selenium');
		    });
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
										<div>
											<div class="card">
												<div class="card-header" style="float: left;">
													<div style="float: left;">
														<h4>자동화 테스트 도구</h4>
														<h5 class="colorRed">그룹으로 구분하여 자동화 테스트를 제공합니다.</h5>
													</div>
												</div>
												<div class="card-block">
														<div style="width: 100%; height: 200px;">
														<div class="drop-area" id="drop-area1" style="width: 100%;">
															<button class="btn btn-default btn-outline-info-add" type="button" id="createButton" style="width: 100%;">실행</button>
														</div>
														<div class="drop-area updatePackageFile" id="drop-area2" style="width: 100%;">
															<button class="btn btn-default btn-outline-info-add" type="button" id="deleteButton" style="width: 100%;">삭제</button>
														</div>
													</div>
												</div>
												<span id="resultSpan" style="padding-left: 30px; font-weight: bold; font-size: 1.1rem; border-top: 1px solid #ababab; padding-top: 20px; display: none;">패키지 분석 결과</span>
												<div class="card-block" id="resultFile">
													
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

	<script>
		$('#createButton').click(function() {	
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/selenium/startView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'selenium'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
					console.log(e);
			    }
			});	
		});
    </script>
	<style>
		

	</style>
</html>