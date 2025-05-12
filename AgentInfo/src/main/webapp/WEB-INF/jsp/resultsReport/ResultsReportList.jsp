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
		    	$.cookie('name','resultsReport');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/resultsReport'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['문서 번호','고객사명','의뢰자','검증자','검토자','문서 작성일','테스트 일정'],
					colModel:[
						{name:'resultsReportNumber', index:'resultsReportNumber', align:'center', width: 250, formatter: linkFormatter},
						{name:'resultsReportCustomerName', index:'resultsReportCustomerName', align:'center', width: 250},
						{name:'resultsReportClient', index:'resultsReportClient', align:'center', width: 200},
						{name:'resultsReportVerifier', index:'resultsReportVerifier', align:'center', width: 200},
						{name:'resultsReportReviewer', index:'resultsReportReviewer', align:'center', width: 200},
						{name:'resultsReportDate', index:'resultsReportDate', align:'center', width: 200},
						{name:'resultsReportTestDate', index:'resultsReportTestDate', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'resultsReportKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'resultsReportKeyNum',	// 기본 정렬 
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
				loadColumns('#list','resultsReportList');
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
							                <h5 class="m-b-10">결과 보고서</h5>
							                <p class="m-b-0">Results Report</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">결과 보고서</a>
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
													<label class="labelFontSize">문서 작성일</label>
													<div>
													  <input class="form-control" style="width: 14.9%; float: left;" type="date" id="resultsReportDateStart" name="resultsReportDateStart" max="9999-12-31">
													  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
													  <input class="form-control" style="width: 14.9%; float: left;" type="date" id="resultsReportDateEnd" name="resultsReportDateEnd" max="9999-12-31">
												  </div>
												  <div style="padding-left: 50px; float: left;">
													  <div class="form-check radioDate">
														<input class="form-check-input" type="radio" name="reportDate" id="toDay" value="0">
														<label class="form-check-label" for="toDay">
														  당일
														</label>
													  </div>
													  <div class="form-check radioDate">
														<input class="form-check-input" type="radio" name="reportDate" id="oneWeek" value="7">
														<label class="form-check-label" for="oneWeek">
														  1주일
														</label>
													  </div>
													  <div class="form-check radioDate">
														<input class="form-check-input" type="radio" name="reportDate" id="oneMonth" value="30">
														<label class="form-check-label" for="oneMonth">
														  1개월
														</label>
													  </div>
													  <div class="form-check radioDate">
														<input class="form-check-input" type="radio" name="reportDate" id="threeMonth" value="90">
														<label class="form-check-label" for="threeMonth">
														  3개월
														</label>
													  </div>
													  <div class="form-check radioDate">
														<input class="form-check-input" type="radio" name="reportDate" id="dateFull" value="full" checked>
														<label class="form-check-label" for="threeMonth">
														  전체
														</label>
													  </div>
												  </div>
												</div>
												<div class="col-lg-2">
													<label class="labelFontSize">문서 번호</label>
												  	<select class="form-control selectpicker" id="resultsReportNumberMulti" name="resultsReportNumberMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${resultsReportNumber}">
														  <option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
												  	</select>
											  	</div>
	                                			<div class="col-lg-2">
	                      							<label class="labelFontSize">고객사명</label>
													<select class="form-control selectpicker" id="resultsReportCustomerNameMulti" name="resultsReportCustomerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${resultsReportCustomerName}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
													<label class="labelFontSize">의뢰자</label>
													<input type="text" id="resultsReportClient" name="resultsReportClient" class="form-control">
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">검증자</label>
	                      							<input type="text" id="resultsReportVerifier" name="resultsReportVerifier" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">검토자</label>
	                      							<input type="text" id="resultsReportReviewer" name="resultsReportReviewer" class="form-control">
	                      						</div>
	                      						<input type="hidden" id="resultsReportNumber" name="resultsReportNumber" class="form-control">
		                      					<input type="hidden" id="resultsReportCustomerName" name="resultsReportCustomerName" class="form-control">
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
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="font-weight:bold;">결과 보고서 관리 :
																	<sec:authorize access="hasRole('ADMIN')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'resultsReportList');">컬럼 선택</button>
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
		/* =========== 결과 보고서 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			location.href="<c:url value='/resultsReport/insertView'/>";
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();	
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#resultsReportCustomerName').val($('#resultsReportCustomerNameMulti').val().join());
			$('#resultsReportNumber').val($('#resultsReportNumberMulti').val().join());

			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.resultsReportNumber+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
			}
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$('.selectpicker').val('');
	        
			tableRefresh();
		});
		
		/* =========== 결과 보고서 삭제 ========= */
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
					  text: "선택한 결과 보고서를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/resultsReport/delete'/>",
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
		
		/* =========== 결과 보고서 수정 Modal ========= */
		function updateView(data) {
			location.href="<c:url value='/resultsReport/updateView'/>?resultsReportNumber="+data;
		}

		/* =========== 작성일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#resultsReportDateStart").val("");
	        	$("#resultsReportDateEnd").val("");
	        } else {
	        	$("#resultsReportDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#resultsReportDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 작성일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="reportDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
		
	</script>
</html>