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
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/selenium'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','타이틀','URL 주소','상세 메모'],
					colModel:[
						{name:'seleniumKeyNum', index:'seleniumKeyNum', align:'center', width: 35, hidden:true },
						{name:'seleniumTitle', index:'seleniumTitle', align:'center', width: 300, formatter: linkFormatter},
						{name:'seleniumAddress', index:'seleniumAddress', align:'center', width: 250},
						{name:'seleniumDetailNote', index:'seleniumDetailNote', align:'center', width: 1000},
					],
					jsonReader : {
			        	id: 'seleniumKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'seleniumKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#list','seleniumList');
			});
			
			$(window).on('resize.list', function () {
			    jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
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
										<div>
											<div class="card">
												<div class="card-header" style="float: left;">
													<div style="float: left;">
														<h4>자동화 테스트 도구</h4>
														<h5 class="colorRed">그룹으로 구분하여 자동화 테스트를 제공합니다.</h5>
													</div>
												</div>
												<!-- <div class="card-block">
														<div style="width: 100%; height: 200px;">
														<div class="drop-area" id="drop-area1" style="width: 100%;">
															<button class="btn btn-default btn-outline-info-add" type="button" id="createButton" style="width: 100%;">실행</button>
														</div>
														<div class="drop-area updatePackageFile" id="drop-area2" style="width: 100%;">
															<button class="btn btn-default btn-outline-info-add" type="button" id="deleteButton" style="width: 100%;">삭제</button>
														</div>
													</div>
												</div> -->
												<form id="form" name="form" method ="post">

												</form>
												<table style="width:99%;">
													<tbody>
														<tr>
															<td style="padding:0px 0px 0px 0px;" class="box">
																<table style="width:100%">
																<tbody>
																	<tr>
																		<td style="font-weight:bold;">테스트 항목 관리 :
																			<button class="btn btn-outline-info-add myBtn" id="createButton">추가</button>
																			<button class="btn btn-outline-info-del myBtn" id="deleteButton">삭제</button>
																		</td>
																	</tr>
																	<tr>
																		<td class="border1" colspan="2">
																			<!------- Grid ------->
																			<div class="jqGrid_wrapper">
																				<table id="list"></table>
																				<div id="pager"></div>
																			</div>
																			<!------- Grid ------->
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tbody>
												</table>
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

		$('#deleteButton').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '삭제!',
					  text: "선택한 테스트 항목을 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/selenium/delete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '삭제 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '삭제 실패하였습니다.',
								  'error'
								)
							tableRefresh();
						},
						error: function(error) {
							console.log(error);
						}
					  });
				  	}
				})
			}
		});

		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.seleniumKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function updateView(seleniumKeyNum) {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/selenium/updateView'/>",
			    async: false,
				data: {"seleniumKeyNum": seleniumKeyNum},
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
		}

		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
    </script>
	<style>
		

	</style>
</html>