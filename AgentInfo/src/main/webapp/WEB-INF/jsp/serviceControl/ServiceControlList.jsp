<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
		<script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
	    	$(function() {
	    		$.cookie('name','serviceControl');
	    	});
    	</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/serviceControl'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','사용 목적','서버 IP','Tomcat','LogServer','EA','CA','Agent','DB','Disk','Memory','방화벽','서비스 설치 경로','Tomcat 설치 경로','DB 구분'],
					colModel:[
						{name:'requestsKeyNum', index:'requestsKeyNum', align:'center', width: 40, hidden:true },
						{name:'employeeId', index:'employeeId', align:'center', width: 150, formatter: linkFormatter},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150},
						{name:'requestsTitle', index:'requestsTitle', align:'center', width: 150},
						{name:'requestsDetail', index:'requestsDetail', align:'left', width: 150},
						{name:'requestsState', index:'requestsState',align:'center', width: 150, formatter: stateFormatter},
						{name:'requestsDate', index:'requestsDate',align:'center', width: 150},
					],
					jsonReader : {
			        	id: 'requestsKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'requestsKeyNum', 		// 기본 정렬 
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
				loadColumns('#list','requestsList');
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
								                <h5 class="m-b-10">서비스 제어</h5>
								                <p class="m-b-0">Service Control</p>
								            </div>
								        </div>
								        <div class="col-md-4">
								            <ul class="breadcrumb-title">
								                <li class="breadcrumb-item">
								                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
								                </li>
								                <li class="breadcrumb-item"><a href="#!">서비스 제어</a>
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
		                      						<sec:authorize access="hasRole('ADMIN')">
			                      						<div class="col-lg-2">
			                      							<label class="labelFontSize">사용 목적</label>
															<select class="form-control selectpicker" id="employeeIdMulti" name="employeeIdMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
																<c:forEach var="item" items="${employeeId}">
																	<option value="${item}"><c:out value="${item}"/></option>
																</c:forEach>
															</select>
														</div>
														<div class="col-lg-2">
			                      							<label class="labelFontSize">서버 IP</label>
															<select class="form-control selectpicker" id="employeeNameMulti" name="employeeNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
																<c:forEach var="item" items="${employeeName}">
																	<option value="${item}"><c:out value="${item}"/></option>
																</c:forEach>
															</select>
														</div>
													</sec:authorize>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">서버 상태</label>
		                      							<input type="text" id="requestsTitle" name="requestsTitle" class="form-control">
		                      						</div>
		                      						<div class="col-lg-12 text-right">
		                      							<input type="hidden" id="employeeId" name="employeeId" class="form-control">
		                      							<input type="hidden" id="employeeName" name="employeeName" class="form-control">
		                      							<input type="hidden" id="requestsState" name="requestsState" class="form-control">
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
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
															<tbody>
																<tr>
																	<td style="font-weight:bold;">서비스 제어 :
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		<button class="btn btn-outline-info-nomal myBtn" onclick="bntConfirm();">동기화</button>
																		<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'requestsList');">컬럼 선택</button>
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
	</body>
	<script>
		/* =========== 패키지 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/serviceControl/insertView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'serviceControl'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});			
		});

		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.requestsKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== 요청사항 수정 Modal ========= */
		function updateView(data) {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/requests/updateView'/>",
			    data: {"requestsKeyNum" : data},
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'requests'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
		    });
		}
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#employeeId').val($('#employeeIdMulti').val().join());
			$('#employeeName').val($('#employeeNameMulti').val().join());
			$('#requestsState').val($('#requestsStateMulti').val().join());
			
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
	        
	        $('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		
		
		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function stateFormatter(value, options, row) {
			var requestsState = row.requestsState.toUpperCase();
			if(requestsState == "요청") {
				return '<div><img src="/AgentInfo/images/request.png" style="width:50px;"></div';
			} else if(requestsState == "확인") {
				return '<div><img src="/AgentInfo/images/confirm.png" style="width:50px;"></div';
			} else if(requestsState == "대기") {
				return '<div><img src="/AgentInfo/images/waiting.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}
	</script>
</html>