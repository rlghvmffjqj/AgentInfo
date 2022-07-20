<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','employeeLog');
		    });
	    </script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/employeeUidLog'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','로그인 아이디','사용자 이름','사용자 부서','사용자 타입','사용자 직급','로그인 시간'],
					colModel:[
						{name:'employeeUidLogKeyNum', index:'employeeUidLogKeyNum', align:'center', width: 50, hidden:true},
						{name:'employeeUidLogEmployeeId', index:'employeeUidLogEmployeeId',align:'center', width: 200},
						{name:'employeeUidLogEmployeeName', index:'employeeUidLogBusinessName',align:'center', width: 200},
						{name:'employeeUidLogDepartmentName', index:'employeeUidLogDepartmentName', align:'center', width: 150},
						{name:'employeeUidLogEmployeeType', index:'employeeUidLogEmployeeType', align:'center', width: 150},
						{name:'employeeUidLogEmployeeRank', index:'employeeUidLogLoginTime', align:'center', width: 150},
						{name:'employeeUidLogLoginTime', index:'employeeUidLogLoginTime', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'employeeUidLogKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'employeeUidLogKeyNum', 		// 기본 정렬 
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
				loadColumns('#list','employeeUidLogList');
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
	                                          <h5 class="m-b-10">사용자 접속 로그</h5>
	                                          <p class="m-b-0">Customer Log Information</p>
	                                      </div>
	                                  </div>
	                                  <div class="col-md-4">
	                                      <ul class="breadcrumb-title">
	                                          <li class="breadcrumb-item">
	                                              <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
	                                          </li>
	                                          <li class="breadcrumb-item"><a href="#!">로그</a>
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
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자 아이디</label>
														<select class="form-control selectpicker" id="employeeUidLogEmployeeIdMulti" name="employeeUidLogEmployeeIdMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${employeeId}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자 이름</label>
														<input type="text" id="employeeUidLogEmployeeName" name="employeeUidLogEmployeeName" class="form-control">
													</div>
		                      						<div class="col-lg-12 text-right">
		                      							<input type="hidden" id="employeeUidLogEmployeeId" name="employeeUidLogEmployeeId" class="form-control">
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
														<tbody><tr>
															<td style="font-weight:bold;">로그 관리 :
																<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'employeeUidLogList');">컬럼 선택</button>
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
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			$('#employeeUidLogEmployeeId').val($('#employeeUidLogEmployeeIdMulti').val().join());
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: $("#form").serializeObject() });
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
			$("#dateFull").prop("checked",true);
	        
	        $('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
	</script>
</html>