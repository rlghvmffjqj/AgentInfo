<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','packageLog');
		    });
	    </script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/packageUidLog'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사 명','패키지 상세버전','패키지 명','패키지Key','이벤트','사용자','시간'],
					colModel:[
						{name:'uidKeyNum', index:'uidKeyNum', align:'center', width: 50, hidden:true},
						{name:'uidCustomerName', index:'uidCustomerName',align:'center', width: 280},
						{name:'uidOsDetailVersion', index:'uidOsDetailVersion',align:'center', width: 350},
						{name:'uidPackageName', index:'uidPackageName', align:'center', width: 650},
						{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 60},
						{name:'uidEvent', index:'uidEvent', align:'center', width: 100},
						{name:'uidUser', index:'uidUser', align:'center', width: 100},
						{name:'uidTime', index:'uidTime', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'uidKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'uidKeyNum', 		// 기본 정렬 
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
				loadColumns('#list','uidLogList');
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
	                                          <h5 class="m-b-10">패키지 배포 내용 로그</h5>
	                                          <p class="m-b-0">Package Log Information</p>
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
															<input class="form-control" style="width: 12%; float: left;" type="date" id="uidDateStart" name="uidDateStart" max="9999-12-31">
															<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
															<input class="form-control" style="width: 12%; float: left;" type="date" id="uidDateEnd" name="uidDateEnd" max="9999-12-31">
														</div>
														<div style="padding-left: 50px; float: left;">
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="uidDate" id="toDay" value="0">
															  <label class="form-check-label" for="toDay">
															    당일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="uidDate" id="oneWeek" value="7">
															  <label class="form-check-label" for="oneWeek">
															    1주일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="uidDate" id="oneMonth" value="30">
															  <label class="form-check-label" for="oneMonth">
															    1개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="uidDate" id="threeMonth" value="90">
															  <label class="form-check-label" for="threeMonth">
															    3개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="uidDate" id="dateFull" value="full" checked>
															  <label class="form-check-label" for="threeMonth">
															    전체
															  </label>
															</div>
														</div>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">고객사명</label>
														<select class="form-control selectpicker" id="uidCustomerNameMulti" name="uidCustomerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${customerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">패키지 상세버전</label>
		                      							<input type="text" id="uidOsDetailVersion" name="uidOsDetailVersion" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">패키지명</label>
		                      							<input type="text" id="uidPackageName" name="uidPackageName" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">패키지 Key</label>
		                      							<input type="number" id="packagesKeyNum" name="packagesKeyNum" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">이벤트</label>
														<select class="form-control selectpicker" id="uidEventMulti" name="uidEventMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="INSERT">INSERT</option>
															<option value="UPDATE">UPDATE</option>
															<option value="DELETE">DELETE</option>
															<option value="배포완료">배포완료</option>
															<option value="적용">적용</option>
															<option value="대기">대기</option>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자</label>
		                      							<input type="text" id="uidUser" name="uidUser" class="form-control">
		                      						</div>
		                      						<div class="col-lg-12 text-right">
		                      							<input type="hidden" id="uidCustomerName" name="uidCustomerName" class="form-control">
		                      							<input type="hidden" id="uidEvent" name="uidEvent" class="form-control">
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
																<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'uidLogList');">컬럼 선택</button>
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
			$('#uidCustomerName').val($('#uidCustomerNameMulti').val().join());
			$('#uidEvent').val($('#uidEventMulti').val().join());
			
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
	        	$("#uidDateStart").val("");
	        	$("#uidDateEnd").val("");
	        } else {
	        	$("#uidDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#uidDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 시간 라디오 버튼 클릭 ========= */
		$(function() {
			$('input[name="uidDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
	</script>
</html>