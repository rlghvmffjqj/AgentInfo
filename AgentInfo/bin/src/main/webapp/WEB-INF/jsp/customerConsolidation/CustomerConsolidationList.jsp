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
		    	$.cookie('name','customerConsolidation');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/customerConsolidation'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','사업명','사용처','수량','사업기간','계약일','담당 엔지니어','고객사 담당자','이메일','전화번호'],
					colModel:[
						{name:'customerConsolidationKeyNum', index:'customerConsolidationKeyNum', align:'center', width: 35, hidden:true },
						{name:'customerConsolidationCustomer', index:'customerConsolidationCustomer', align:'center', width: 200, formatter: linkFormatter},
						{name:'customerConsolidationBusiness', index:'customerConsolidationBusiness', align:'center', width: 200},
						{name:'customerConsolidationLocation', index:'customerConsolidationLocation', align:'center', width: 150},
						{name:'customerConsolidationQuantity', index:'customerConsolidationQuantity', align:'center', width: 70},
						{name:'customerConsolidationBusinessPeriod', index:'customerConsolidationBusinessPeriod',align:'center', width: 200, formatter: periodFormatter},
						{name:'customerConsolidationContractDate', index:'customerConsolidationContractDate',align:'center', width: 100},
						{name:'customerConsolidationEngineer', index:'customerConsolidationEngineer', align:'center', width: 150},
						{name:'customerConsolidationCustomerManager', index:'customerConsolidationCustomerManager', align:'center', width: 150},
						{name:'customerConsolidationEmail', index:'customerConsolidationEmail', align:'center', width: 200},
						{name:'customerConsolidationContact', index:'customerConsolidationContact', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'customerConsolidationKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 11,					// 보여중 행의 수
			        sortname: 'customerConsolidationKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '303',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#list','customerConsolidation');
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
							                <h5 class="m-b-10">고객사 통합 관리</h5>
							                <p class="m-b-0">Customer Management</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">고객사 통합 관리</a>
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
	                      							<label class="labelFontSize">계약일</label>
	                      							<div>
														<input class="form-control" style="width: 14.9%; float: left;" type="date" id="customerConsolidationContractDateStart" name="customerConsolidationContractDateStart" max="9999-12-31">
														<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														<input class="form-control" style="width: 14.9%; float: left;" type="date" id="customerConsolidationContractDateEnd" name="customerConsolidationContractDateEnd" max="9999-12-31">
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
	                      							<label class="labelFontSize">고객사</label>
													<select class="form-control selectpicker" id="customerConsolidationCustomerMulti" name="customerConsolidationCustomerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="고객사"><c:out value="고객사"/></option>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">사업명</label>
													<select class="form-control selectpicker" id="customerConsolidationBusinessMulti" name="customerConsolidationBusinessMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="사업명"><c:out value="사업명"/></option>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">사용처</label>
	                      							<select class="form-control selectpicker" id="customerConsolidationLocationMulti" name="customerConsolidationLocationMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="사용처"><c:out value="사용처"/></option>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">수량</label>
													<input class="form-control" type="number" id="customerConsolidationQuantity" name="customerConsolidationQuantity"> 
	                      						</div>
	                      						<!-- <div class="col-lg-2">
	                      							<label class="labelFontSize">사업기간</label>
													  <input class="form-control" type="date" id="customerConsolidationBusinessPeriod" name="customerConsolidationBusinessPeriod" max="9999-12-31"> 
												</div> -->
												<div class="col-lg-2">
	                      							<label class="labelFontSize">담당 엔지니어</label>
													<select class="form-control selectpicker" id="customerConsolidationEngineerMulti" name="customerConsolidationEngineerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="엔지니어">엔지니어</option>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">고객사 담당자</label>
													<select class="form-control selectpicker" id="customerConsolidationCustomerManagerMulti" name="customerConsolidationCustomerManagerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="고객"><c:out value="고객"/></option>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">이메일</label>
													<select class="form-control selectpicker" id="customerConsolidationEmailMulti" name="customerConsolidationEmailMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="이메일"><c:out value="이메일"/></option>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">전화번호</label>
													<select class="form-control selectpicker" id="customerConsolidationContactMulti" name="customerConsolidationContactMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<option value="전화번호"><c:out value="전화번호"/></option>
													</select>
	                      						</div>
												  <div class="col-lg-2">
													<label class="labelFontSize">부서</label>
												  <select class="form-control selectpicker" id="customerConsolidationDepartmentMulti" name="customerConsolidationDepartmentMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
													  <option value="영업본부"><c:out value="영업본부"/></option>
													  <option value="보안기술사업본부"><c:out value="보안기술사업본부"/></option>
													  <!-- <option value="평가 인증실"><c:out value="평가 인증실"/></option> -->
												  </select>
											  </div>
												  	<input type="hidden" id="customerConsolidationCustomer" name="customerConsolidationCustomer" class="form-control">
													<input type="hidden" id="customerConsolidationBusiness" name="customerConsolidationBusiness" class="form-control">
													<input type="hidden" id="customerConsolidationLocation" name="customerConsolidationLocation" class="form-control">
													<input type="hidden" id="customerConsolidationEngineer" name="customerConsolidationEngineer" class="form-control">
		                      						<input type="hidden" id="customerConsolidationCustomerManager" name="customerConsolidationCustomerManager" class="form-control">
													<input type="hidden" id="customerConsolidationEmail" name="customerConsolidationEmail" class="form-control">
													<input type="hidden" id="customerConsolidationContact" name="customerConsolidationContact" class="form-control">
													<input type="hidden" id="customerConsolidationDepartment" name="customerConsolidationDepartment" class="form-control">

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
			                           	<table style="width:100%;">
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="font-weight:bold;">고객사 통합 관리 :
																	<sec:authorize access="hasAnyRole('ADMIN','SALES')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnSalesInsert">신규 등록</button>
																	</sec:authorize>
																	<sec:authorize access="hasAnyRole('ADMIN','ENGINEERLEADER')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnEngineerLeaderInsert">엔지니어 배정</button>
																	</sec:authorize>
																	<sec:authorize access="hasAnyRole('ADMIN','ENGINEERLEADER','ENGINEER')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnEngineerInsert">라이선스 발급 요청</button>
																	</sec:authorize>
																	<sec:authorize access="hasAnyRole('ADMIN','LICENSE')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnLicenseInsert">라이선스 발급</button>
																	</sec:authorize>
																	<sec:authorize access="hasAnyRole('ADMIN','ENGINEERLEADER','SALES')">
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">제거</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'customerConsolidation');">컬럼 선택</button>
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
										<div class="searchbos" style="margin-top: 1%; background: white;">
											<table style="width:100%">
												<tr id="licenseTr" style="border-bottom: 1px solid #cba7a7;">
													<th class="licenseTh"><span class="licenseSpan">일련번호</span></th>
													<th class="licenseTh"><span class="licenseSpan">시작일</span></th>
													<th class="licenseTh"><span class="licenseSpan">만료일</span></th>
													<th class="licenseTh"><span class="licenseSpan">MAC주소</span></th>
													<th class="licenseTh"><span class="licenseSpan">제품유형</span></th>
													<th class="licenseTh"><span class="licenseSpan">iGRIFFIN Agent수량</span></th>
													<th class="licenseTh"><span class="licenseSpan">TOS 5.0 Agent 수량</span></th>
													<th class="licenseTh"><span class="licenseSpan">TOS 2.0 Agent 수량</span></th>
													<th class="licenseTh"><span class="licenseSpan">관리서버 OS</span></th>
													<th class="licenseTh"><span class="licenseSpan">관리서버 DBMS</span></th>
													<th class="licenseTh"><span class="licenseSpan">국가</span></th>
													<th class="licenseTh"><span class="licenseSpan">제품버전</span></th>
													<th class="licenseTh"><span class="licenseSpan">라이선스 파일명</span></th>
													<th class="licenseTh"><span class="licenseSpan">발급 상태</span></th>
												</tr>
												
											</table>
											</div>
										</div>
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
			return '<a onclick="updateView('+"'"+rowdata.customerConsolidationKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var customerConsolidationContractDateStart = $("#customerConsolidationContractDateStart").val();
			var customerConsolidationContractDateEnd = $("#customerConsolidationContractDateEnd").val();
			
			if(customerConsolidationContractDateStart == "" && customerConsolidationContractDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(customerConsolidationContractDateEnd == "" && customerConsolidationContractDateStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 종료일을 입력해주세요.',    
					});
			} else if(customerConsolidationContractDateStart > customerConsolidationContractDateEnd) {
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
			setTimerSessionTimeoutCheck(); // 세션 타임아웃 리셋
			$('#customerConsolidationCustomer').val($('#customerConsolidationCustomerMulti').val().join());
			$('#customerConsolidationBusiness').val($('#customerConsolidationBusinessMulti').val().join());
			$('#customerConsolidationLocation').val($('#customerConsolidationLocationMulti').val().join());
			$('#customerConsolidationEngineer').val($('#customerConsolidationEngineerMulti').val().join());
			$('#customerConsolidationCustomerManager').val($('#customerConsolidationCustomerManagerMulti').val().join());
			$('#customerConsolidationEmail').val($('#customerConsolidationEmailMulti').val().join());
			$('#customerConsolidationContact').val($('#customerConsolidationContactMulti').val().join());
			$('#customerConsolidationDepartment').val($('#customerConsolidationDepartmentMulti').val().join());
						
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
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
		
		function updateView(data) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/customerConsolidation/updateView'/>",
		        async: false,
				data: {"customerConsolidationKeyNum" : data},
		        success: function (data) {
		            $.modal(data, 'customerConsolidation');
		        },
		        error: function(e) {
					console.log(e);
		        }
		    });
		}
		
		$('#BtnSalesInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/customerConsolidation/insertSalesView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'customerConsolidation'); 
			    },
			    error: function(e) {
			        alert(e);
			    }
			});
		});

		$('#BtnEngineerLeaderInsert').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var customerConsolidationKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '하나의 행을 선택 바랍니다.'
				});    
			} else if(chkList.length == 1) {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/customerConsolidation/insertEngineerLeaderView'/>",
				    async: false,
					data: {"customerConsolidationKeyNum" : customerConsolidationKeyNum},
				    success: function (data) {
				    	$.modal(data, 'customerConsolidation'); 
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


		$('#BtnEngineerInsert').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var customerConsolidationKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '하나의 행을 선택 바랍니다.'
				});    
			} else if(chkList.length == 1) {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/customerConsolidation/insertEngineerView'/>",
				    async: false,
					data: {"customerConsolidationKeyNum" : customerConsolidationKeyNum},
				    success: function (data) {
				    	$.modal(data, 'customerConsolidation'); 
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
					  text: "선택한 고객사 정보를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/customerConsolidation/delete'/>",
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
							else if(data == "SalesMISMATCH")
								Swal.fire(
								  '성공!',
								  '보안기술사업본부 데이터를 제외한 데이터 삭제 완료! ',
								  'success'
								)
							else if(data == "EngineerLeaderMISMATCH")
								Swal.fire(
								  '성공!',
								  '영업본부 데이터를 제외한 데이터 삭제 완료! ',
								  'success'
								)
							tableRefresh();
						},
						error: function(error) {
							console.log(error);
							Swal.fire(
							  '실패!',
							  '삭제 실패하였습니다.',
							  'error'
							)
						}
					  });
				  	}
				})
			}
		});

		// 클릭한 행의 데이터 가져오기
		$("#list").on("click", "tr.jqgrow", function() {
    		var rowData = $("#list").jqGrid("getRowData", $(this).attr("id"));

			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/customerConsolidation/licenseList'/>",
			    async: false,
				data: {"customerConsolidationKeyNum" : rowData.customerConsolidationKeyNum},
			    success: function (result) {
					$('.licenseData').remove();
			    	result.forEach(function(license, index) {
						console.log(license);
						var table = $("#licenseTr");
						var rowItem = "<tr class='licenseData'>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.serialNumber+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.issueDate+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.expirationDays+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.macAddress+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.productType+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.igriffinAgentCount+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.tos5AgentCount+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.tos2AgentCount+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.managerOsType+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.managerDbmsType+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.country+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.productVersion+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>"+license.licenseFilePath+"</span></td>";
						rowItem += "<td	class='licenseTd'><span class='licenseSpan'>요청</span></td>";
						rowItem += "</tr>";
						table.after(rowItem);
					});
			    },
			    error: function(e) {
			        console.log(e);
			    }
			});

    	});

		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function periodFormatter(value, options, row) {
			return row.customerConsolidationBusinessPeriodStart + '~' + row.customerConsolidationBusinessPeriodEnd;
		}
	</script>

	<style>
		.licenseSpan {
			font-size: 12px;
		}

		.licenseTd {
			padding-top: 5px;
			text-align: center;
		}

		.licenseTh {
			padding-bottom: 10px;
			text-align: center;
		}
	</style>
</html>