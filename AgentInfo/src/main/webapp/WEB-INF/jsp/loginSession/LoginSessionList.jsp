<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name',"loginSession");
		    });
	    </script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/loginSession'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['접속시간','접속주소','아이디','계정 마지막 접근 시간','마지막 접근한 URL','세션ID'],
					colModel:[
						{name:'loginTime', index:'loginTime', align:'center', width: 200},
						{name:'loginIp', index:'loginIp', align:'center' ,width: 200},
						{name:'loginId', index:'loginId', align:'center' ,width: 200},
						{name:'lastRequestTime', index:'lastRequestTime', align:'center' ,width: 200},
						{name:'lastRequestURL', index:'lastRequestURL', align:'center' ,width: 400},
						{name:'sessionId', index:'sessionId', align:'center' ,width: 300},
					],
					jsonReader : {
			        	id: 'sessionId',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        //sortname: 'categoryValue', 	// 기본 정렬 
			        //sortorder: 'asc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
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
									            <h5 class="m-b-10">접속 세션 목록</h5>
									            <p class="m-b-0">Login Session List</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">접속 세션</a>
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
			                           	 	<table style="width:99%;">
												<tbody>
													<tr>
														<td style="padding:0px 0px 0px 0px;" class="box">
															<table style="width:100%">
																<tbody>
																	<tr>
																		<td style="font-weight:bold;">세션 관리 :
																			<button class="btn btn-outline-info-del myBtn" id="BtnDelect">세션 종료</button>
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
													</tr>
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
	</body>

	<script>
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== 세션 종료 ========= */
		$('#BtnDelect').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			console.log(chkList.length);
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '세션 종료!',
					  text: "선택한 사용자의 세션을 종료하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: '예'
				}).then((result) => {
				  if (result.isConfirmed) {
					var result = "";
					for(var i=0; i < chkList.length; i++)
					{
						var rowid = chkList[i];
						result = killSession(rowid);
						if ( result != "OK" )
							break;
					}
					if(result == "OK") {
						Swal.fire({               
							icon: 'success',          
							title: '성공!',           
							text: '정상적으로 세션 종료하였습니다.',    
						});	
					} else {
						Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: result,    
						});	
					}
					tableRefresh();
				  }
				})
			}
		});
		
		/* =========== 세션 종료 로직 ========= */
		function killSession(sessionId)
		{
			var result = "";

			$.ajax({
				type: "POST",
				url: "<c:url value='/loginSession/killSession'/>",
				data: {sessionId: sessionId},
				dataType: "json",
				async: false, // 동기 작업
				success: function(data) {
					result = data.result;
				}
			});
			return result;
		}
	</script>
</html>