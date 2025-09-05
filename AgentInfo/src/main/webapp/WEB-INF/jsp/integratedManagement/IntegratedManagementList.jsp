<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','integratedManagement');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/integratedManagement'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사명','날짜'],
					colModel:[
						{name:'integratedManagementKeyNum', index:'integratedManagementKeyNum', align:'center', width: 35, hidden:true },
						{name:'integratedManagementCustomerName', index:'integratedManagementCustomerName', align:'center', width: 300},
						{name:'integratedManagementDate', index:'integratedManagementDate', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'integratedManagementKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'integratedManagementKeyNum',	// 기본 정렬 
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
				loadColumns('#list','integratedManagementList');
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
									            <h5 class="m-b-10">Integrated Management 제품 통합 관리</h5>
									            <p class="m-b-0">Integrated Management License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">Integrated Management 제품 통합 관리</a>
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
	                                			<form id="form" name="form" method ="post">
													<div style="padding-left:15px; width:28.5%; display: inline-block;">
														<label class="labelFontSize">날짜</label>
														<div>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="integratedManagementStart" name="integratedManagementStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="integratedManagementEnd" name="integratedManagementEnd" max="9999-12-31">
													  	</div>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">고객사명</label>
														<input type="text" id="integratedManagementCustomerName" name="integratedManagementCustomerName" class="form-control">
													</div>
			                      						<div class="col-lg-12 text-right">
														<p class="search-btn">
															<button class="btn btn-primary btnm" type="button" id="btnSearch">
																<i class="fa fa-search"></i>&nbsp;<span>검색</span>
															</button>
															<button class="btn btn-default btnm" type="button" id="btnReset">
																<span>초기화</span>
															</button>
														</p>
													</div>
												</form>
		                     				</div>
	                     				 </div>
			                           	 	<table style="width:99%;">
												<tbody><tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="font-weight:bold;">통합 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">매핑</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnDelect">제거</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnUpdate">수정</button>
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
		/* =========== 제품 통합 관리 Modal ========= */
		$('#BtnInsert').click(function() {
			location.href="<c:url value='/integratedManagement/insertView'/>";			
		});
		
		/* =========== 제품 통합 관리 정보 제거 ========= */
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
					  text: "선택한 라이선스를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/integratedManagement/delete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '제거 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '제거 실패하였습니다.',
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
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {		
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
			}
		});
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$("input[type='date']").val("");
	        
	        $('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
			
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var integratedManagementStart = $("#integratedManagementStart").val();
			var integratedManagementEnd = $("#integratedManagementEnd").val();
			
			if(integratedManagementStart == "" && integratedManagementEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의 시작날짜를 입력해주세요.',    
					});
			} else if(integratedManagementEnd == "" && integratedManagementStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의  종료 날짜를 입력해주세요.',    
					});
			} else if(integratedManagementStart > integratedManagementEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '시작일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else {
				tableRefresh();	
			}
		});
		
		
		
	</script>
</html>