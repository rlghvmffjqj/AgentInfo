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
		    	$.cookie('name','packagesInternational');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/packagesInternational'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key',/* 'OriginKey', */'고객사ID','고객사 명','사업명','망 구분','요청일자','전달일자','상태','패키지 종류','일반/커스텀','Agent ver','패키지명','담당자','OS종류','패키지 상세버전','OS버전','기존/신규','요청 제품구분','전달 방법','구매구분','비고','상태 변경 의견'],
					colModel:[
						{name:'packagesInternationalKeyNum', index:'packagesInternationalKeyNum', align:'center', width: 35, hidden:true },
						/* {name:'packagesInternationalKeyNumOrigin', index:'packagesInternationalKeyNumOrigin', align:'center', width: 50, hidden:true }, */
						{name:'categoryKeyNum', index:'categoryKeyNum', align:'center', width: 70, formatter: strFormatter },
						{name:'customerName', index:'customerName', align:'center', width: 200, formatter: linkFormatter},
						{name:'businessName', index:'businessName', align:'center', width: 180},
						{name:'networkClassification', index:'networkClassification', align:'center', width: 70},
						{name:'requestDate', index:'requestDate', align:'center', width: 70},
						{name:'deliveryData', index:'deliveryData',align:'center', width: 70},
						{name:'state', index:'state',align:'center', width: 50, formatter: stateFormatter, sortable:false},
						{name:'managementServer', index:'managementServer', align:'center', width: 80},
						{name:'generalCustom', index:'generalCustom', align:'center', width: 60},
						{name:'agentVer', index:'agentVer', align:'center', width: 170},
						{name:'packageName', index:'packageName', align:'center', width: 630},
						{name:'manager', index:'manager', align:'center', width: 80},
						{name:'osType', index:'osType', align:'center', width: 80},
						{name:'osDetailVersion', index:'osDetailVersion', align:'center', width: 350},
						{name:'agentOS', index:'agentOS', align:'center', width: 120},
						{name:'existingNew', index:'existingNew', align:'center', width: 70},
						{name:'requestProductCategory', index:'requestProductCategory', align:'center', width: 90},
						{name:'deliveryMethod', index:'deliveryMethod', align:'center', width: 60},
						{name:'purchaseCategory', index:'purchaseCategory', align:'center', width: 100},
						{name:'note', index:'note', align:'center', width: 600},
						{name:'statusComment', index:'statusComment', align:'center', width: 400},
					],
					jsonReader : {
			        	id: 'packagesInternationalKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'packagesInternationalKeyNumOrigin',	// 기본 정렬 
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
				loadColumns('#list','packagesInternationalList');
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
							                <h5 class="m-b-10">패키지 배포 관리</h5>
							                <p class="m-b-0">Package Deployment Management</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">패키지 배포 관리</a>
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
	                      							<label class="labelFontSize">전달일자</label>
	                      							<div>
														<input class="form-control" style="width: 12%; float: left;" type="date" id="deliveryDateStart" name="deliveryDateStart" max="9999-12-31">
														<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														<input class="form-control" style="width: 12%; float: left;" type="date" id="deliveryDateEnd" name="deliveryDateEnd" max="9999-12-31">
													</div>
													<div style="padding-left: 50px; float: left;">
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="packageDate" id="toDay" value="0">
														  <label class="form-check-label" for="toDay">
														    당일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="packageDate" id="oneWeek" value="7">
														  <label class="form-check-label" for="oneWeek">
														    1주일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="packageDate" id="oneMonth" value="30">
														  <label class="form-check-label" for="oneMonth">
														    1개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="packageDate" id="threeMonth" value="90">
														  <label class="form-check-label" for="threeMonth">
														    3개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="packageDate" id="dateFull" value="full" checked>
														  <label class="form-check-label" for="threeMonth">
														    전체
														  </label>
														</div>
													</div>
	                      						</div>
												  <div class="col-lg-2">
													<label class="labelFontSize">고객사ID</label>
													  <select class="form-control selectpicker" id="customerIdMulti" name="customerIdMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														  <c:forEach var="item" items="${customerId}">
															  <option value="${item}"><c:out value="${item}"/></option>
														  </c:forEach>
													  </select>
												  </div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">고객사명</label>
													<select class="form-control selectpicker" id="customerNameMulti" name="customerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${customerName}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">사업명</label>
													<select class="form-control selectpicker" id="businessNameMulti" name="businessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${businessName}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">망 구분</label>
	                      							<input type="text" id="networkClassification" name="networkClassification" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">요청일자</label>
													<input class="form-control" type="date" id="requestDate" name="requestDate" max="9999-12-31"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">상태</label>
													<select class="form-control selectpicker" id="stateMulti" name="stateMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="배포완료">배포완료</option>
														<option value="적용">적용</option>
														<option value="대기">대기</option>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지 종류</label>
													<select class="form-control selectpicker" id="managementServerMulti" name="managementServerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${managementServer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">일반/커스텀</label>
													<select class="form-control selectpicker" id="generalCustomMulti" name="generalCustomMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${generalCustom}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">Agent ver</label>
													<select class="form-control selectpicker" id="agentVerMulti" name="agentVerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${agentVer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지명</label>
	                      							<input type="text" id="packageName" name="packageName" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">담당자</label>
	                      							<input type="text" id="manager" name="manager" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">OS종류</label>
													<select class="form-control selectpicker" id="osTypeMulti" name="osTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${osType}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지 상세버전</label>
	                      							<input type="text" id="osDetailVersion" name="osDetailVersion" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">OS버전</label>
													<select class="form-control selectpicker" id="agentOSMulti" name="agentOSMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${agentOS}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">기존/신규</label>
													<select class="form-control selectpicker" id="existingNewMulti" name="existingNewMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${existingNew}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">요청 제품구분</label>
		                      							<select class="form-control selectpicker" id="requestProductCategoryMulti" name="requestProductCategoryMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${requestProductCategory}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">전달 방법</label>
		                      							<select class="form-control selectpicker" id="deliveryMethodMulti" name="deliveryMethodMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${deliveryMethod}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
													  <div class="col-lg-2">
														<label class="labelFontSize">구매구분</label>
														<select class="form-control selectpicker" id="purchaseCategoryMulti" name="purchaseCategoryMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														  <c:forEach var="item" items="${purchaseCategory}">
															  <option value="${item}"><c:out value="${item}"/></option>
														  </c:forEach>
													  </select>
													</div>
		                      						<input type="hidden" id="managementServer" name="managementServer" class="form-control">
		                      						<input type="hidden" id="generalCustom" name="generalCustom" class="form-control">
		                      						<input type="hidden" id="agentVer" name="agentVer" class="form-control">
		                      						<input type="hidden" id="osType" name="osType" class="form-control">
		                      						<input type="hidden" id="agentOS" name="agentOS" class="form-control">
		                      						<input type="hidden" id="state" name="state" class="form-control">
		                      						<input type="hidden" id="existingNew" name="existingNew" class="form-control">
		                      						<input type="hidden" id="requestProductCategory" name="requestProductCategory" class="form-control">
		                      						<input type="hidden" id="deliveryMethod" name="deliveryMethod" class="form-control">
													<input type="hidden" id="purchaseCategory" name="purchaseCategory" class="form-control">
		                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
		                      						<input type="hidden" id="businessName" name="businessName" class="form-control">
													<input type="hidden" id="customerId" name="customerId" class="form-control">
		                      						<div class="col-lg-12 text-right">
													<p class="search-btn" style="margin-top: 10px;">
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
																<td style="font-weight:bold;">패키지 관리 :
																	<sec:authorize access="hasRole('ADMIN')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnCopy">복사</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'packagesInternationalList');">컬럼 선택</button>
																	<sec:authorize access="hasRole('ADMIN')">
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnImport">Excel 가져오기</button>
																		<button class="btn btn-outline-info-nomal myBtn" onClick="doExportExec()">Excel 내보내기</button>
																	</sec:authorize>
																	<sec:authorize access="hasAnyRole('ENGINEER','ADMIN')">
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnState" onClick="btnState()">상태 변경</button>
																	</sec:authorize>
																	<sec:authorize access="hasRole('ADMIN')">
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnDomestic" onClick="btnDomestic()">국내 이동</button>
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
		/* =========== Excel Import Modal ========= */
	  	$('#BtnImport').click(function() {
	  		$.ajax({
			    type: 'POST',
			    url: "<c:url value='/packagesInternational/importView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 's'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});	
	  	})
	  	
		/* =========== 패키지 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/packagesInternational/insertView'/>",
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'packagesInternational'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});			
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var deliveryDateStart = $("#deliveryDateStart").val();
			var deliveryDateEnd = $("#deliveryDateEnd").val();
			
			if(deliveryDateStart == "" && deliveryDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(deliveryDateEnd == "" && deliveryDateStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 종료일을 입력해주세요.',    
					});
			} else if(deliveryDateStart > deliveryDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일이 종료일자 보다 큽니다.',    
				}); 
			} else {
				tableRefresh();	
			}
			
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#managementServer').val($('#managementServerMulti').val().join());
			$('#generalCustom').val($('#generalCustomMulti').val().join());
			$('#agentVer').val($('#agentVerMulti').val().join());
			$('#osType').val($('#osTypeMulti').val().join());
			$('#agentOS').val($('#agentOSMulti').val().join());
			$('#state').val($('#stateMulti').val().join());
			$('#existingNew').val($('#existingNewMulti').val().join());
			$('#requestProductCategory').val($('#requestProductCategoryMulti').val().join());
			$('#deliveryMethod').val($('#deliveryMethodMulti').val().join());
			$('#purchaseCategory').val($('#purchaseCategoryMulti').val().join());
			$('#customerName').val($('#customerNameMulti').val().join());
			$('#businessName').val($('#businessNameMulti').val().join());
			$('#customerId').val($('#customerIdMulti').val().join());
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesInternationalKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function stateFormatter(value, options, row) {
			var state = row.state.toUpperCase();
			if(state == "배포완료") {
				return '<div><img src="/AgentInfo/images/distribute.png" style="width:50px;"></div';
			} else if(state == "적용") {
				return '<div><img src="/AgentInfo/images/apply.png" style="width:50px;"></div';
			} else if(state == "대기") {
				return '<div><img src="/AgentInfo/images/waiting.png" style="width:50px;"></div';
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
		
		/* =========== 패키지 삭제 ========= */
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
					  text: "선택한 패키지를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/packagesInternational/delete'/>",
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
		
		/* =========== 데이터 복사 Modal ========= */
		$('#BtnCopy').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var packagesInternationalKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/packagesInternational/copyView'/>",
		            data: {"packagesInternationalKeyNum" : packagesInternationalKeyNum},
		            async: false,
		            success: function (data) {
		            	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
		                $.modal(data, 'packagesInternational'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '복사를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});
		
		/* =========== 패키지 수정 Modal ========= */
		function updateView(data) {
			<sec:authorize access="hasRole('ADMIN')">
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/packagesInternational/updateView'/>",
		            data: {"packagesInternationalKeyNum" : data},
		            async: false,
		            success: function (data) {
		            	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
		                $.modal(data, 'packagesInternational'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			</sec:authorize>
		}
		
		/* =========== 상태 변경 ========= */
		function btnState() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/packagesInternational/stateView'/>",
		            async: false,
		            success: function (data) {
		            	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
		                $.modal(data, 'r'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			}
		}
		
		/* =========== 전달일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#deliveryDateStart").val("");
	        	$("#deliveryDateEnd").val("");
	        } else {
	        	$("#deliveryDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#deliveryDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="packageDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});

		function strFormatter(cellValue, options, rowdata, action) {
			var code = "S_";
			for(var i=cellValue.toString().length; i < 5; i++) {
				code = code + "0";
			}
			return code + cellValue;
		}

		function btnDomestic() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '이동!',
					  text: "선택한 패키지를 국내로 이동하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/packagesInternational/domesticMove'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '이동 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '이동 실패하였습니다.',
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
		}

	</script>
</html>