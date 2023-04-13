<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','licenseLog');
		    });
	    </script>
		<script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/licenseUidLog'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','업체 명','사업명 / 설치 사유','발급일자','요청자','협력사명','OS','OS버전','커널버전','커널비트','TOS 버전','기간','MAC / UML / HostId','릴리즈타입','전달방법','라이센스 발급 Key'/*, '라이센스 발급 번호' */,'이벤트','사용자','시간'],
				colModel:[
					{name:'licenseUidLogKeyNum', index:'licenseUidLogKeyNum', align:'center', width: 35, hidden:true },
					{name:'licenseUidLogCustomerName', index:'licenseUidLogCustomerName', align:'center', width: 200},
					{name:'licenseUidLogBusinessName', index:'licenseUidLogBusinessName', align:'center', width: 250},
					{name:'licenseUidLogIssueDate', index:'licenseUidLogIssueDate', align:'center', width: 80},
					{name:'licenseUidLogRequester', index:'licenseUidLogRequester', align:'center', width: 80},
					{name:'licenseUidLogPartners', index:'licenseUidLogPartners',align:'center', width: 150},
					{name:'licenseUidLogOsType', index:'licenseUidLogOsType',align:'center', width: 80},
					{name:'licenseUidLogOsVersion', index:'licenseUidLogOsVersion', align:'center', width: 150},
					{name:'licenseUidLogKernelVersion', index:'licenseUidLogKernelVersion', align:'center', width: 70},
					{name:'licenseUidLogKernelBit', index:'licenseUidLogKernelBit', align:'center', width: 70},
					{name:'licenseUidLogTosVersion', index:'licenseUidLogTosVersion', align:'center', width: 150},
					{name:'licenseUidLogPeriod', index:'licenseUidLogPeriod', align:'center', width: 70},
					{name:'licenseUidLogMacUmlHostId', index:'licenseUidLogMacUmlHostId', align:'center', width: 200},
					{name:'licenseUidLogReleaseType', index:'licenseUidLogReleaseType', align:'center', width: 100},
					{name:'licenseUidLogDeliveryMethod', index:'licenseUidLogDeliveryMethod', align:'center', width: 100},
					{name:'licenseUidLogIssueKey', index:'licenseUidLogIssueKey', align:'center', width: 200},
					/* {name:'licenseUidLogIssueKey', index:'licenseUidLogIssueKey', align:'center', width: 150, formatter: licenseUidLogNumFormatter, sortable:false}, */
					{name:'licenseUidLogEvent', index:'licenseUidLogEvent',align:'center', width: 80},
					{name:'licenseUidUser', index:'licenseUidUser',align:'center', width: 80},
					{name:'licenseUidTime', index:'licenseUidTime',align:'center', width: 150},
				],
				jsonReader : {
		        	id: 'licenseUidLogKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'licenseUidLogKeyNum',	// 기본 정렬 
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
			loadColumns('#list','licenseUidLogList');
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
	                                          <h5 class="m-b-10">라이센스 2.0 관리 로그</h5>
	                                          <p class="m-b-0">License Issued Log</p>
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
		                      							<label class="labelFontSize">발급일자</label>
		                      							<div>
															<input class="form-control" style="width: 18.3%; float: left;" type="date" id="licenseUidLogIssueDateStart" name="licenseUidLogIssueDateStart" max="9999-12-31">
															<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
															<input class="form-control" style="width: 18.3%; float: left;" type="date" id="licenseUidLogIssueDateEnd" name="licenseUidLogIssueDateEnd" max="9999-12-31">
														</div>
														<div style="padding-left: 50px; float: left;">
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="toDay" value="0">
															  <label class="form-check-label" for="toDay">
															    당일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="oneWeek" value="7">
															  <label class="form-check-label" for="oneWeek">
															    1주일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="oneMonth" value="30">
															  <label class="form-check-label" for="oneMonth">
															    1개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="threeMonth" value="90">
															  <label class="form-check-label" for="threeMonth">
															    3개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="dateFull" value="full" checked>
															  <label class="form-check-label" for="threeMonth">
															    전체
															  </label>
															</div>
														</div>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">업체명</label>
														<select class="form-control selectpicker" id="customerNameMulti" name="customerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogCustomerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사업명 / 설치 사유</label>
														<select class="form-control selectpicker" id="businessNameMulti" name="businessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogBusinessName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													
													<div class="col-lg-2">
		                      							<label class="labelFontSize">요청자</label>
														<select class="form-control selectpicker" id="requesterMulti" name="requesterMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogRequester}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>		                      							
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">협력사명</label>
														<select class="form-control selectpicker" id="partnersMulti" name="partnersMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogPartners}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select> 
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">OS</label>
														<select class="form-control selectpicker" id="osTypeMulti" name="osTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="Linux">Linux</option>
															<option value="Windows">Windows</option>
															<option value="AIX">AIX</option>
															<option value="HP-UX">HP-UX</option>
															<option value="MAC">MAC</option>
															<option value="Solaris">Solaris</option>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">OS버전</label>
														<select class="form-control selectpicker" id="osVersionMulti" name="osVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogOsVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">커널버전</label>
														<select class="form-control selectpicker" id="kernelVersionMulti" name="kernelVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogKernelVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">커널비트</label>
														<select class="form-control selectpicker" id="licenseUidLogKernelBit" name="licenseUidLogKernelBit" data-live-search="true" data-size="5" data-actions-box="true">
															<option value=""></option>
															<option value="64">64</option>
															<option value="32">32</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">TOS 버전</label>
														<select class="form-control selectpicker" id="tosVersionMulti" name="tosVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogTosVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">기간</label>
		                      							<input type="text" id="licenseUidLogPeriod" name="licenseUidLogPeriod" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC / UML / HostId</label>
		                      							<select class="form-control selectpicker" id="macUmlHostIdMulti" name="macUmlHostIdMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseUidLogMacUmlHostId}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">릴리즈 타입</label>
														<select class="form-control selectpicker" id="releaseTypeMulti" name="releaseTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="Normal">Normal</option>
															<option value="Test">Test</option>
															<option value="Disable">Disable</option>
														</select>
													</div>
													<div class="col-lg-2">
			                      						<label class="labelFontSize">전달 방법</label>
			                      						<select class="form-control selectpicker" id="deliveryMethodMulti" name="deliveryMethodMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="메일">메일</option>
															<option value="대용량 메일">대용량 메일</option>
															<option value="CD">CD</option>
															<option value="점프호스트">점프호스트</option>
														</select>
			                      					</div>
			                      					<div class="col-lg-2">
		                      							<label class="labelFontSize">라이센스 발급 Key</label>
		                      							<input type="text" id="licenseUidLogIssueKey" name="licenseUidLogIssueKey" class="form-control">
		                      						</div>
			                      					<div class="col-lg-2">
		                      							<label class="labelFontSize">이벤트</label>
														<select class="form-control selectpicker" id="licenseUidLogEventMulti" name="licenseUidLogEventMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="INSERT">INSERT</option>
															<option value="DELETE">DELETE</option>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자</label>
		                      							<input type="text" id="licenseUidUser" name="licenseUidUser" class="form-control">
		                      						</div>
			                      						<input type="hidden" id="licenseUidLogCustomerName" name="licenseUidLogCustomerName" class="form-control">
			                      						<input type="hidden" id="licenseUidLogBusinessName" name="licenseUidLogBusinessName" class="form-control">
			                      						<input type="hidden" id="licenseUidLogRequester" name="licenseUidLogRequester" class="form-control">
			                      						<input type="hidden" id="licenseUidLogPartners" name="licenseUidLogPartners" class="form-control">
			                      						<input type="hidden" id="licenseUidLogOsType" name="licenseUidLogOsType" class="form-control">
			                      						<input type="hidden" id="licenseUidLogOsVersion" name="licenseUidLogOsVersion" class="form-control">
			                      						<input type="hidden" id="licenseUidLogKernelVersion" name="licenseUidLogKernelVersion" class="form-control">
			                      						<input type="hidden" id="licenseUidLogTosVersion" name="licenseUidLogTosVersion" class="form-control">
			                      						<input type="hidden" id="licenseUidLogMacUmlHostId" name="licenseUidLogMacUmlHostId" class="form-control">
			                      						<input type="hidden" id="licenseUidLogReleaseType" name="licenseUidLogReleaseType" class="form-control">
			                      						<input type="hidden" id="licenseUidLogDeliveryMethod" name="licenseUidLogDeliveryMethod" class="form-control">
			                      						<input type="hidden" id="licenseUidLogEvent" name="licenseUidLogEvent" class="form-control">
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
														<tbody><tr>
															<td style="font-weight:bold;">로그 관리 :
																<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'licenseUidLogList');">컬럼 선택</button>
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
			$('#licenseUidLogCustomerName').val($('#customerNameMulti').val().join());
			$('#licenseUidLogBusinessName').val($('#businessNameMulti').val().join());
			$('#licenseUidLogRequester').val($('#requesterMulti').val().join());
			$('#licenseUidLogPartners').val($('#partnersMulti').val().join());
			$('#licenseUidLogOsType').val($('#osTypeMulti').val().join());
			$('#licenseUidLogOsVersion').val($('#osVersionMulti').val().join());
			$('#licenseUidLogKernelVersion').val($('#kernelVersionMulti').val().join());
			$('#licenseUidLogTosVersion').val($('#tosVersionMulti').val().join());
			$('#licenseUidLogMacUmlHostId').val($('#macUmlHostIdMulti').val().join());
			$('#licenseUidLogReleaseType').val($('#releaseTypeMulti').val().join());
			$('#licenseUidLogDeliveryMethod').val($('#deliveryMethodMulti').val().join());
			$('#licenseUidLogEvent').val($('#licenseUidLogEventMulti').val().join());
			
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
		
		/* =========== 라이센스 발급 Key 확인 버튼 ========= */
		function licenseUidLogNumFormatter(value, options, row) {
			var licenseUidLogKeyNum = row.licenseUidLogKeyNum;
			return '<button class="btn btn-outline-info-nomal myBtn" onClick="licenseNumber(' + "'" + licenseUidLogKeyNum + "'"  + ')">라이센스 발급</button>';
		}
		
		/* =========== 라이센스 Key 확인 ========= */
		function licenseNumber(licenseUidLogKeyNum) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/licenseUidLog/issueKey'/>",
	            data: {"licenseUidLogKeyNum" : licenseUidLogKeyNum},
	            async: false,
	            success: function (data) {
	            	if(data == "FALSE") {
	            		Swal.fire(
	      					  '실패!',
	      					  '라이센스 발급 Key가 존재하지 않습니다.',
	      					  'error'
	      					)
	            	} else {
		            	Swal.fire(
						  '라이센스 발급 Key!',
						  data,
						  'success'
						)
	            	}
	            },
	            error: function(e) {
	            	Swal.fire(
					  '에러!',
					  '에러가 발생하였습니다.',
					  'error'
					)
	            }
	        });
		}
		
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