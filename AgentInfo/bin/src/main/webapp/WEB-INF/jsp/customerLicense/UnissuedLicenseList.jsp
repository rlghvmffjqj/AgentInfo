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
		    	$.cookie('name','unissuedLicense');
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
					colNames:['Key','고객사','사업명','품목','수량','OS','관리서버DBMS','관리서버 Mac','설치일자','납품 확인서 서명 일자','납품 업체명','납품 당당자 명','확인 고객명','확인 담당자 정보'],
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
				loadColumns('#list','unissuedLicense');
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
		                      							<label class="labelFontSize">추가정보</label>
														<select class="form-control selectpicker" id="additionalInformationMulti" name="additionalInformationMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${additionalInformation}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>		                      							
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">제품유형</label>
														<select class="form-control selectpicker" id="productTypeMulti" name="productTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${productType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select> 
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">일련번호</label>
														<select class="form-control selectpicker" id="serialNumberMulti" name="serialNumberMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serialNumber}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select> 
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC 주소</label>
														<select class="form-control selectpicker" id="macAddressMulti" name="macAddressMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${macAddress}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													
													<div class="col-lg-2">
		                      							<label class="labelFontSize">시작일</label>
														<input class="form-control" type="date" id="issueDate" name="issueDate" max="9999-12-31">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">만료일</label>
														<input class="form-control" type="date" id="expirationDays" name="expirationDays" max="9999-12-31">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">iGRIFFIN Agent 수량</label>
		                      							<input type="number" id="igriffinAgentCount" name="igriffinAgentCount" class="form-control">
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">TOS 5.0 Agent 수량</label>
		                      							<input type="number" id="tos5AgentCount" name="tos5AgentCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">TOS 2.0 Agent 수량</label>
		                      							<input type="number" id="tos2AgentCount" name="tos2AgentCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">DBMS 수량</label>
		                      							<input type="number" id="dbmsCount" name="dbmsCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Network 수량</label>
		                      							<input type="number" id="networkCount" name="networkCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">AIX(OS) 수량</label>
		                      							<input type="number" id="aixCount" name="aixCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">HPUX(OS) 수량</label>
		                      							<input type="number" id="hpuxCount" name="hpuxCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Solaris(OS) 수량</label>
		                      							<input type="number" id="solarisCount" name="solarisCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Linux(OS) 수량</label>
		                      							<input type="number" id="linuxCount" name="linuxCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Windows(OS) 수량</label>
		                      							<input type="number" id="windowsCount" name="windowsCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">관리서버 OS</label>
		                      							<select class="form-control selectpicker" id="managerOsTypeMulti" name="managerOsTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${managerOsType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">관리서버 DBMS</label>
														<select class="form-control selectpicker" id="managerDbmsTypeMulti" name="managerDbmsTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${managerDbmsType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
			                      						<label class="labelFontSize">국가</label>
			                      						<select class="form-control selectpicker" id="countryMulti" name="countryMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="메일">메일</option>
															<option value="대용량 메일">대용량 메일</option>
															<option value="CD">CD</option>
															<option value="점프호스트">점프호스트</option>
														</select>
			                      					</div>
			                      					<div class="col-lg-2">
		                      							<label class="labelFontSize">제품 버전</label>
		                      							<select class="form-control selectpicker" id="productVersionMulti" name="productVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${productVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">라이선스 파일명</label>
		                      							<select class="form-control selectpicker" id="licenseFilePathMulti" name="licenseFilePathMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseFilePath}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">요청자</label>
		                      							<select class="form-control selectpicker" id="requesterMulti" name="requesterMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${requester}">
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
																<td style="font-weight:bold;">라이선스 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">라이선스 발급</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'unissuedLicense');">컬럼 선택</button>
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
		        url: "<c:url value='/unissuedLicense/updateView'/>",
		        async: false,
		        success: function (data) {
		        	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
		            $.modal(data, 'unissuedLicense'); //modal창 호출
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
			} else if(chkList.length == 1) {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/customerLicense/unissuedLicense/insertView'/>",
				    async: false,
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				    	$.modal(data, 'license5'); //modal창 호출
				    },
				    error: function(e) {
				        alert(e);
				    }
				});
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '하나의 행만 선택 가능합니다.',    
				}); 
			}
		});
	</script>
</html>