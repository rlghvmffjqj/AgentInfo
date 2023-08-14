<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','customerLog');
		    });
	    </script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/customerUidLog'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사명','사업명','망 구분','담당자 이름','담당자 부서','담당자 전화번호','고객사 주소','엔지니어 이름','영업사원 이름','TOSMS','TOSRF','PORTAL','OS타입','JAVA','WebServer','Database','LogServer','ScvEA','ScvCA','Auth/PKI','이벤트','사용자','시간'],
					colModel:[
						{name:'customerUidLogKeyNum', index:'customerUidLogKeyNum', align:'center', width: 50, hidden:true},
						{name:'customerUidLogCustomerName', index:'customerUidLogCustomerName',align:'center', width: 280},
						{name:'customerUidLogBusinessName', index:'customerUidLogBusinessName',align:'center', width: 180},
						{name:'customerUidLogNetworkClassification', index:'customerUidLogNetworkClassification', align:'center', width: 70},
						{name:'customerUidLogCustomerManagerName', index:'customerUidLogCustomerManagerName', align:'center', width: 80},
						{name:'customerUidLogCustomerDept', index:'customerUidLogCustomerDept', align:'center', width: 100},
						{name:'customerUidLogCustomerPhoneNumber', index:'customerUidLogCustomerPhoneNumber', align:'center', width: 100},
						{name:'customerUidLogCustomerFullAddress', index:'customerUidLogCustomerFullAddress', align:'center', width: 200},
						{name:'customerUidLogEmployeeSeName', index:'customerUidLogEmployeeSeName', align:'center', width: 80},
						{name:'customerUidLogEmployeeSalesName', index:'customerUidLogEmployeeSalesName', width: 180, align:'center', width: 80},
						{name:'customerUidLogTosmsVer', index:'customerUidLogTosmsVer', align:'center', width: 230},
						{name:'customerUidLogTosrfVer', index:'customerUidLogTosrfVer', align:'center', width: 230},
						{name:'customerUidLogPortalVer', index:'customerUidLogPortalVer', align:'center', width: 230},
						{name:'customerUidLogOsType', index:'customerUidLogOsType', align:'center', width: 100},
						{name:'customerUidLogJavaVer', index:'customerUidLogJavaVer', align:'center', width: 230},
						{name:'customerUidLogWebServerVer', index:'customerUidLogWebServerVer', align:'center', width: 230},
						{name:'customerUidLogDatabaseVer', index:'customerUidLogDatabaseVer', align:'center', width: 230},
						{name:'customerUidLogLogServerVer', index:'customerUidLogLogServerVer', align:'center', width: 230},
						{name:'customerUidLogScvEaVer', index:'customerUidLogScvEaVer', align:'center', width: 230},
						{name:'customerUidLogScvCaVer', index:'customerUidLogScvCaVer', align:'center', width: 230},
						{name:'customerUidLogAuthPkiVer', index:'customerUidLogAuthPkiVer', align:'center', width: 230},
						{name:'customerUidEvent', index:'customerUidEvent', align:'center', width: 110},
						{name:'customerUidUser', index:'customerUidUser', align:'center', width: 100},
						{name:'customerUidTime', index:'customerUidTime', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'customerUidLogKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'customerUidLogKeyNum', 		// 기본 정렬 
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
				loadColumns('#list','customerUidLogList');
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
	                                          <h5 class="m-b-10">고객사 정보 로그</h5>
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
		                      						<div style="padding-left:15px; width:100%; float: left;">
		                      							<label class="labelFontSize">시간</label>
		                      							<div>
															<input class="form-control" style="width: 14.9%; float: left;" type="date" id="customerUidDateStart" name="customerUidDateStart" max="9999-12-31">
															<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
															<input class="form-control" style="width: 14.9%; float: left;" type="date" id="customerUidDateEnd" name="customerUidDateEnd" max="9999-12-31">
														</div>
														<div style="padding-left: 50px; float: left;">
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="customerUidDate" id="toDay" value="0">
															  <label class="form-check-label" for="toDay">
															    당일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="customerUidDate" id="oneWeek" value="7">
															  <label class="form-check-label" for="oneWeek">
															    1주일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="customerUidDate" id="oneMonth" value="30">
															  <label class="form-check-label" for="oneMonth">
															    1개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="customerUidDate" id="threeMonth" value="90">
															  <label class="form-check-label" for="threeMonth">
															    3개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="customerUidDate" id="dateFull" value="full" checked>
															  <label class="form-check-label" for="threeMonth">
															    전체
															  </label>
															</div>
														</div>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">고객사명</label>
														<select class="form-control selectpicker" id="customerUidLogCustomerNameMulti" name="customerUidLogCustomerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${customerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사업명</label>
														<select class="form-control selectpicker" id="customerUidLogBusinessNameMulti" name="customerUidLogBusinessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${businessName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">망 구분</label>
														<input type="text" id="customerUidLogNetworkClassification" name="customerUidLogNetworkClassification" class="form-control">
													</div>
		                      						
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">이벤트</label>
														<select class="form-control selectpicker" id="customerUidEventMulti" name="customerUidEventMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="INSERT">INSERT</option>
															<option value="UPDATE">UPDATE</option>
															<option value="DELETE">DELETE</option>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자</label>
		                      							<input type="text" id="customerUidUser" name="customerUidUser" class="form-control">
		                      						</div>
		                      						<div class="col-lg-12 text-right">
		                      							<input type="hidden" id="customerUidLogCustomerName" name="customerUidLogCustomerName" class="form-control">
		                      							<input type="hidden" id="customerUidLogBusinessName" name="customerUidLogBusinessName" class="form-control">
		                      							<input type="hidden" id="customerUidEvent" name="customerUidEvent" class="form-control">
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
																<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'customerUidLogList');">컬럼 선택</button>
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
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#customerUidLogCustomerName').val($('#customerUidLogCustomerNameMulti').val().join());
			$('#customerUidLogBusinessName').val($('#customerUidLogBusinessNameMulti').val().join());
			$('#customerUidEvent').val($('#customerUidEventMulti').val().join());
			
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
		
		/* =========== 시간 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#customerUidDateStart").val("");
	        	$("#customerUidDateEnd").val("");
	        } else {
	        	$("#customerUidDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#customerUidDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 시간 라디오 버튼 클릭 ========= */
		$(function() {
			$('input[name="customerUidDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
	</script>
</html>