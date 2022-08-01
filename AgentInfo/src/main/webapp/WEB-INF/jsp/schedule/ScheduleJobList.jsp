<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','schedule');
		    });
	    </script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/schedule'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','스케줄러명','설명','상태','시작 시간','다음 실행시간','마지막 실행시간','CronExpression','실행결과','로그보기','작업실행'],
					colModel:[
						{name:'scheduleKeyNum', index:'scheduleKeyNum', align:'center', width: 35, hidden:true },
						{name:'scheduleName', index:'scheduleName', align:'center', width: 200, formatter: linkFormatter},
						{name:'scheduleExplantion', index:'scheduleExplantion', align:'center', width: 250},
						{name:'scheduleState', index:'scheduleState', align:'center', width: 100},
						{name:'scheduleStartTime', index:'scheduleStartTime', align:'center', width: 100},
						{name:'scheduleNextTime', index:'scheduleNextTime',align:'center', width: 100},
						{name:'scheduleLastTime', index:'scheduleLastTime',align:'center', width: 100},
						{name:'scheduleCron', index:'scheduleCron', align:'center', width: 100},
						{name:'scheduleResult', index:'scheduleResult', align:'center', width: 100},
						{name:'scheduleLog', index:'scheduleLog', align:'center', width: 100},
						{name:'scheduleName', index:'scheduleName', align:'center', width: 150, formatter: scheduleRunFormatter, sortable:false},
					],
					jsonReader : {
			        	id: 'scheduleKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'scheduleName',	// 기본 정렬 
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
				loadColumns('#list','scheduleList');
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
									            <h5 class="m-b-10">스케줄러 목록</h5>
									            <p class="m-b-0">Schedule List</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">스케줄러 목록</a>
									            </li>
									        </ul>
									    </div>
									</div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
			                           	 <table style="width:99%;">
											<tbody><tr>
												<td style="padding:0px 0px 0px 0px;" class="box">
													<table style="width:100%">
														<tbody>
															<tr>
																<td style="font-weight:bold;">스케줄러 관리 :
																	<sec:authorize access="hasAnyRole('ENGINEER','ADMIN')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnUse">사용</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnNotUse">사용안함</button>
																	</sec:authorize>
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
	</body>

	<script>
	/* =========== 스케줄러 사용안함 ========= */
		$('#BtnNotUse').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			console.log(chkList);
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/schedule/scheduleNotUse'/>",
				    data: {chkList: chkList},
				    traditional: true,
					async: false,
				    success: function (data) {
				    	if(data == "OK")
							Swal.fire(
							  '성공!',
							  '작업 완료하였습니다.',
							  'success'
							)
						else
							Swal.fire(
							  '실패!',
							  '작업 실패하였습니다.',
							  'error'
							)
						tableRefresh();
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});
			}			
		});
		
		/* =========== 스케줄러 사용 ========= */
		$('#BtnUse').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			console.log(chkList);
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/schedule/scheduleUse'/>",
				    data: {chkList: chkList},
				    traditional: true,
					async: false,
				    success: function (data) {
				    	if(data == "OK")
							Swal.fire(
							  '성공!',
							  '작업 완료하였습니다.',
							  'success'
							)
						else
							Swal.fire(
							  '실패!',
							  '작업 실패하였습니다.',
							  'error'
							)
						tableRefresh();
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});
			}
		});
	
		/* =========== 스케줄러 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/schedule/insertView'/>",
			    async: false,
			    success: function (data) {
			        $.modal(data, 'ls'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		/* =========== 스케줄러 포멧털 ========= */
		function scheduleRunFormatter(value, options, row) {
			var scheduleName = row.scheduleName.toUpperCase();
			return '<button class="btn btn-outline-info-nomal myBtn" onClick="scheduleRun(' + "'" + scheduleName + "'"  + ')">즉시실행</button>';
		}
		
		/* =========== 스케줄러 즉시 실행 ========= */
		function scheduleRun(scheduleName) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/schedule/scheduleRun'/>",
		        data: {"scheduleName" : scheduleName},
		        async: false,
		        success: function (data) {
		        	if(data == "OK")
						Swal.fire(
						  '성공!',
						  '작업 완료하였습니다.',
						  'success'
						)
					else
						Swal.fire(
						  '실패!',
						  '작업 실패하였습니다.',
						  'error'
						)
					tableRefresh();
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		}
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.scheduleName+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== 스케줄러 삭제 ========= */
		$('#BtnDelect').click(function() {
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
					  text: "선택한 스케줄러를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: '예'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/schedule/delete'/>",
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
		
		/* =========== 스케줄러 수정 Modal ========= */
		function updateView(scheduleName) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/schedule/updateView'/>",
		        data: {"scheduleName" : scheduleName},
		        async: false,
		        success: function (data) {
		            $.modal(data, 's'); //modal창 호출
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		}
		
	</script>
</html>