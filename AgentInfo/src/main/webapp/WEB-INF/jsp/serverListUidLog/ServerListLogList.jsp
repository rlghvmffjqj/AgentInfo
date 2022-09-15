<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
			    $.cookie('name','serverListLog');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/serverListUidLog'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','구분','IP','상태','MAC','자산번호','HostName','용도','운영체제','서버구분','랙 위치','사용기간','사용자','관리자','최종 수정일','비고'],
					colModel:[
						{name:'serverListUidLogKeyNum', index:'serverListUidLogKeyNum', align:'center', width: 35, hidden:true },
						{name:'serverListUidLogDivision', index:'serverListUidLogDivision', align:'center', width: 80},
						{name:'serverListUidLogIp', index:'serverListUidLogIp', align:'center', width: 100, formatter: linkFormatter},
						{name:'serverListUidLogState', index:'serverListUidLogState', align:'center', width: 70, formatter: stateFormatter},
						{name:'serverListUidLogMac', index:'serverListUidLogMac', align:'center', width: 110},
						{name:'serverListUidLogAssetNum', index:'serverListUidLogAssetNum', align:'center', width: 120},
						{name:'serverListUidLogHostName', index:'serverListUidLogHostName',align:'center', width: 110},
						{name:'serverListUidLogPurpose', index:'serverListUidLogPurpose',align:'center', width: 150},
						{name:'serverListUidLogOs', index:'serverListUidLogOs', align:'center', width: 150},
						{name:'serverListUidLogServerClass', index:'serverListUidLogServerClass', align:'center', width: 80},
						{name:'serverListUidLogRackPosition', index:'serverListUidLogRackPosition', align:'center', width: 50},
						{name:'serverListUidLogPeriodUse', index:'serverListUidLogPeriodUse', align:'center', width: 80},
						{name:'serverListUidLogUser', index:'serverListUidLogUser', align:'center', width: 80},
						{name:'serverListUidLogManager', index:'serverListUidLogManager', align:'center', width: 80},
						{name:'serverListUidLogLastModifiedDate', index:'serverListUidLogLastModifiedDate', align:'center', width: 80},
						{name:'serverListUidLogNote', index:'serverListUidLogNote', align:'center', width: 300},
					],
					jsonReader : {
			        	id: 'serverListUidLogKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'serverListUidLogKeyNum',	// 기본 정렬 
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
				loadColumns('#list','serverListUidLog');
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
									            <h5 class="m-b-10">서버 목록 로그</h5>
									            <p class="m-b-0">Server List</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">서버 목록 로그</a>
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
		                      							<label class="labelFontSize">구분</label>
														<select class="form-control selectpicker" id="serverListUidLogDivisionMulti" name="serverListUidLogDivisionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="Linux">Linux</option>
															<option value="Windows">Windows</option>
															<option value="AIX">AIX</option>
															<option value="HP-UX">HP-UX</option>
															<option value="Solaris">Solaris</option>
															<option value="기타">기타</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">IP</label>
														<select class="form-control selectpicker" id="serverListUidLogIpMulti" name="serverListUidLogIpMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogIp}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">상태</label>
														<select class="form-control selectpicker" id="serverListUidLogStateMulti" name="serverListUidLogStateMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="정상작동">정상작동</option>
															<option value="접속불가">접속불가</option>
															<option value="업데이트">업데이트</option>
															<option value="외부반출">외부반출</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC</label>
														<select class="form-control selectpicker" id="serverListUidLogMacMulti" name="serverListUidLogMacMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogMac}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">자산번호</label>
														<select class="form-control selectpicker" id="serverListUidLogAssetNumMulti" name="serverListUidLogAssetNumMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogAssetNum}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">HostName</label>
														<select class="form-control selectpicker" id="serverListUidLogHostNameMulti" name="serverListUidLogHostNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogHostName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">용도</label>
														<select class="form-control selectpicker" id="serverListUidLogPurposeMulti" name="serverListUidLogPurposeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogPurpose}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">운영체제</label>
														<select class="form-control selectpicker" id="serverListUidLogOsMulti" name="serverListUidLogOsMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogOs}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">서버구분</label>
														<select class="form-control selectpicker" id="serverListUidLogServerClassMulti" name="serverListUidLogServerClassMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListUidLogServerClass}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">랙 위치</label>
														<select class="form-control selectpicker" id="serverListUidLogRackPositionMulti" name="serverListUidLogRackPositionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="P1">P1</option>
															<option value="Q1">Q1</option>
															<option value="Q2">Q2</option>
															<option value="Q3">Q3</option>
															<option value="Q4">Q4</option>
															<option value="W1">W1</option>
															<option value="S1">S1</option>
															<option value="D1">D1</option>
															<option value="D2">D2</option>
															<option value="D3">D3</option>
															<option value="D4">D4</option>
															<option value="D5">D5</option>
															<option value="D6">D6</option>
															<option value="D7">D7</option>
															<option value="D8">D8</option>
															<option value="D9">D9</option>
															<option value="D10">D10</option>
															<option value="D11">D11</option>
															<option value="Q1">Q1</option>
															<option value="#90">#90</option>
															<option value="#160">#160</option>
															<option value="#210">#210</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사용 기간</label>
		                      							<input type="date" id="serverListUidLogPeriodUse" name="serverListUidLogPeriodUse" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자</label>
		                      							<input type="text" id="serverListUidLogUser" name="serverListUidLogUser" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">관리자</label>
		                      							<input type="text" id="serverListUidLogManager" name="serverListUidLogManager" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">최종 수정일</label>
		                      							<input type="date" id="serverListUidLogLastModifiedDate" name="serverListUidLogLastModifiedDate" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">비고</label>
		                      							<input type="text" id="serverListUidLogNote" name="serverListUidLogNote" class="form-control">
		                      						</div>
		                      						<input type="hidden" id="serverListUidLogDivision" name="serverListUidLogDivision" class="form-control">
		                      						<input type="hidden" id="serverListUidLogIp" name="serverListUidLogIp" class="form-control">
		                      						<input type="hidden" id="serverListUidLogState" name="serverListUidLogState" class="form-control">
		                      						<input type="hidden" id="serverListUidLogMac" name="serverListUidLogMac" class="form-control">
		                      						<input type="hidden" id="serverListUidLogAssetNum" name="serverListUidLogAssetNum" class="form-control">
		                      						<input type="hidden" id="serverListUidLogHostName" name="serverListUidLogHostName" class="form-control">
		                      						<input type="hidden" id="serverListUidLogPurpose" name="serverListUidLogPurpose" class="form-control">
		                      						<input type="hidden" id="serverListUidLogOs" name="serverListUidLogOs" class="form-control">
		                      						<input type="hidden" id="serverListUidLogServerClass" name="serverListUidLogServerClass" class="form-control">
		                      						<input type="hidden" id="serverListUidLogRackPosition" name="serverListUidLogRackPosition" class="form-control">
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
																<td style="font-weight:bold;">서버 관리 :
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'serverListUidLog');">컬럼 선택</button>
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
			$('#serverListUidLogDivision').val($('#serverListUidLogDivisionMulti').val().join());
			$('#serverListUidLogIp').val($('#serverListUidLogIpMulti').val().join());
			$('#serverListUidLogState').val($('#serverListUidLogStateMulti').val().join());
			$('#serverListUidLogMac').val($('#serverListUidLogMacMulti').val().join());
			$('#serverListUidLogAssetNum').val($('#serverListUidLogAssetNumMulti').val().join());
			$('#serverListUidLogHostName').val($('#serverListUidLogHostNameMulti').val().join());
			$('#serverListUidLogPurpose').val($('#serverListUidLogPurposeMulti').val().join());
			$('#serverListUidLogOs').val($('#serverListUidLogOsMulti').val().join());
			$('#serverListUidLogServerClass').val($('#serverListUidLogServerClassMulti').val().join());
			$('#serverListUidLogRackPosition').val($('#serverListUidLogRackPositionMulti').val().join());
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.serverListUidLogKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function stateFormatter(value, options, row) {
			var state = row.serverListUidLogState.toUpperCase();
			if(state == "정상작동") {
				return '<div><img src="/AgentInfo/images/serverListOk.png" style="width:50px;"></div';
			} else if(state == "접속불가") {
				return '<div><img src="/AgentInfo/images/serverListFail.png" style="width:50px;"></div';
			} else if(state == "외부반출") {
				return '<div><img src="/AgentInfo/images/serverListOut.png" style="width:50px;"></div';
			} else if(state == "업데이트") {
				return '<div><img src="/AgentInfo/images/serverListUpdate.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
			}
		});
		
		/* =========== 갤린더 검색 ========= */
		$("#requestDate").change(function() {
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
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
	</script>
</html>