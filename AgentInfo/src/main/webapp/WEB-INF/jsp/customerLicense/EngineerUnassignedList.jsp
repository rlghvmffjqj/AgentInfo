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
		    	$.cookie('name','engineerUnassigned');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/packages'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','사업명','설치장소','사업(계약)기간','제품명','고객 담당자 정보','요청 근거','계약(납품)금액','계약(납품)업체','기타사항','계약일','검수일(계산서)','검수 종류'],
					colModel:[
						{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 35, hidden:true },
						{name:'customerName', index:'customerName', align:'center', width: 200, formatter: linkFormatter},
						{name:'businessName', index:'businessName', align:'center', width: 180},
						{name:'networkClassification', index:'networkClassification', align:'center', width: 120},
						{name:'requestDate', index:'requestDate', align:'center', width: 120},
						{name:'deliveryData', index:'deliveryData',align:'center', width: 120},
						{name:'state', index:'state',align:'center', width: 100},
						{name:'managementServer', index:'managementServer', align:'center', width: 80},
						{name:'generalCustom', index:'generalCustom', align:'center', width: 120},
						{name:'agentVer', index:'agentVer', align:'center', width: 120},
						{name:'packageName', index:'packageName', align:'center', width: 630},
						{name:'manager', index:'manager', align:'center', width: 125},
						{name:'osType', index:'osType', align:'center', width: 120},
						{name:'osDetailVersion', index:'osDetailVersion', align:'center', width: 350},
						
					],
					jsonReader : {
			        	id: 'packagesKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'packagesKeyNumOrigin',	// 기본 정렬 
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
				loadColumns('#list','engineerUnassigned');
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
							                <h5 class="m-b-10">고객사 관리</h5>
							                <p class="m-b-0">Customer Management</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">고객사 관리</a>
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
	                      							<label class="labelFontSize">설치일자</label>
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
	                      							<label class="labelFontSize">고객사명</label>
													<select class="form-control selectpicker" id="customerNameMulti" name="customerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="시큐브"><c:out value="시큐브"/></option>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">사업명</label>
													<select class="form-control selectpicker" id="businessNameMulti" name="businessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="시큐브"><c:out value="시큐브"/></option>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">품목</label>
	                      							<input type="text" id="networkClassification" name="networkClassification" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">수량</label>
													<input class="form-control" type="date" id="requestDate" name="requestDate" max="9999-12-31"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">OS</label>
													<select class="form-control selectpicker" id="stateMulti" name="stateMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="Linux">Linux</option>
														<option value="Windows">Windows</option>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">관리서버 DBMS</label>
													<select class="form-control selectpicker" id="test" name="test" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="tibero">tibero</option>
														<option value="oracle">oracle</option>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">관리서버 Mac</label>
													<input type="text" id="test" name="test" class="form-control">
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">설치일자</label>
	                      							<input type="text" id="packageName" name="packageName" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">납품 확인 서명 일자</label>
	                      							<input type="text" id="manager" name="manager" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">납품 업체명</label>
	                      							<input type="text" id="test" name="test" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">납품 담당자 명</label>
	                      							<input type="text" id="test" name="test" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">확인 고객명</label>
	                      							<input type="text" id="test" name="test" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">확인 담당자 정보</label>
	                      							<input type="text" id="test" name="test" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">에이전트 OS 종류별 수량</label>
	                      							<input type="text" id="test" name="test" class="form-control">
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
		                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
		                      						<input type="hidden" id="businessName" name="businessName" class="form-control">
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
																<td style="font-weight:bold;">엔지니어 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">엔지니어 배정</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'engineerUnassigned');">컬럼 선택</button>
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
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView()" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		function updateView() {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/engineerUnassigned/updateView'/>",
		        async: false,
		        success: function (data) {
		        	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
		            $.modal(data, 'engineerUnassigned'); //modal창 호출
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		}
		
		$('#BtnInsert').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var packagesKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '하나의 행을 선택 바랍니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/customerLicense/engineerUnassigned/insertView'/>",
				    async: false,
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				    	$.modal(data, 'engineerUnassigned'); //modal창 호출
				    },
				    error: function(e) {
				        alert(e);
				    }
				});
			} 
		});
	</script>
</html>