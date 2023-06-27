<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','license5');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/license5'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사명','사업명','추가정보','시작일','만료일','일련번호','MAC주소','제품유형','iGRIFFIN Agent 수량','TOS 5.0 Agent 수량','TOS 2.0 Agent 수량','DBMS 수량','Network 수량','AIX(OS) 수량','HPUX(OS) 수량','Solaris(OS) 수량','Linux(OS) 수량','Windows(OS) 수량','관리서버 OS','관리서버 DBMS','국가','제품버전','라이선스 파일명','요청자'],
					colModel:[
						{name:'licenseKeyNum', index:'licenseKeyNum', align:'center', width: 35, hidden:true },
						{name:'customerName', index:'customerName', align:'center', width: 200},
						{name:'businessName', index:'businessName', align:'center', width: 250},
						{name:'additionalInformation', index:'additionalInformation', align:'center', width: 200},
						{name:'issueDate', index:'issueDate', align:'center', width: 80},
						{name:'expirationDays', index:'expirationDays', align:'center', width: 80},
						{name:'serialNumber', index:'serialNumber',align:'center', width: 250},
						{name:'macAddress', index:'macAddress',align:'center', width: 300},
						{name:'productType', index:'productType', align:'center', width: 80},						
						{name:'igriffinAgentCount', index:'igriffinAgentCount', align:'center', width: 120},
						{name:'tos5AgentCount', index:'tos5AgentCount', align:'center', width: 120},
						{name:'tos2AgentCount', index:'tos2AgentCount', align:'center', width: 120},
						{name:'dbmsCount', index:'dbmsCount', align:'center', width: 120},
						{name:'networkCount', index:'networkCount', align:'center', width: 120},
						{name:'aixCount', index:'aixCount', align:'center', width: 100},
						{name:'hpuxCount', index:'hpuxCount', align:'center', width: 100},
						{name:'solarisCount', index:'solarisCount', align:'center', width: 100},
						{name:'linuxCount', index:'linuxCount', align:'center', width: 100},
						{name:'windowsCount', index:'windowsCount', align:'center', width: 100},
						{name:'managerOsType', index:'managerOsType', align:'center', width: 80},
						{name:'managerDbmsType', index:'managerDbmsType', align:'center', width: 80},
						{name:'country', index:'country', align:'center', width: 50},
						{name:'productVersion', index:'productVersion', align:'center', width: 100},
						{name:'licenseFilePath', index:'licenseFilePath', align:'center', width: 250},
						{name:'requester', index:'requester', align:'center', width: 80},
					],
					jsonReader : {
			        	id: 'licenseKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'licenseKeyNum',	// 기본 정렬 
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
				loadColumns('#list','licenseList');
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
									            <h5 class="m-b-10">라이선스 5.0</h5>
									            <p class="m-b-0">License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">라이선스 발급</a>
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
			                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
			                      						<input type="hidden" id="businessName" name="businessName" class="form-control">
			                      						<input type="hidden" id="additionalInformation" name="additionalInformation" class="form-control">
			                      						<input type="hidden" id="productType" name="productType" class="form-control">
			                      						<input type="hidden" id="serialNumber" name="serialNumber" class="form-control">
			                      						<input type="hidden" id="macAddress" name="macAddress" class="form-control">
			                      						<input type="hidden" id="managerOsType" name="managerOsType" class="form-control">
			                      						<input type="hidden" id="managerDbmsType" name="managerDbmsType" class="form-control">
			                      						<input type="hidden" id="country" name="country" class="form-control">
			                      						<input type="hidden" id="productVersion" name="productVersion" class="form-control">
			                      						<input type="hidden" id="licenseFilePath" name="licenseFilePath" class="form-control">
			                      						<input type="hidden" id="requester" name="requester" class="form-control">
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
																<td style="font-weight:bold;">라이선스 관리 :
																	<sec:authorize access="hasRole('ADMIN')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">발급</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">제거</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnUpdate">수정</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnRoute">경로설정</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnImport">XML Import</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'licenseList');">컬럼 선택</button>
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
		/* =========== 라이선스 발급 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/license5/issuedView'/>",
			    data: {
		    		"viewType" : "issued"
		    	},
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'license5'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});		
		});
		
		$('#BtnImport').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/license5/licenseXmlImportView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'xmlImport'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});
		});
		
		/* =========== 라이선스 발급 정보 제거 ========= */
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
					  text: "선택한 라이선스를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/license5/delete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '제거 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '제거 실패하였습니다.',
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
		
		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="issueDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
		
		/* =========== 라이선스 발급 Key 확인 버튼 ========= */
		function licenseNumFormatter(value, options, row) {
			var licenseKeyNum = row.licenseKeyNum;
			return '<button class="btn btn-outline-info-nomal myBtn" onClick="licenseNumber(' + "'" + licenseKeyNum + "'"  + ')">라이선스 발급</button>';
		}
		
		/* =========== 라이선스 Key 확인 ========= */
		function licenseNumber(licenseKeyNum) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/license5/issueKey'/>",
	            data: {"licenseKeyNum" : licenseKeyNum},
	            async: false,
	            success: function (data) {
	            	if(data == "FALSE") {
	            		Swal.fire(
	      					  '실패!',
	      					  '라이선스 발급 Key가 존재하지 않습니다.',
	      					  'error'
	      					)
	            	} else {
		            	Swal.fire(
						  '라이선스 발급 Key!',
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
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			$('#customerName').val($('#customerNameMulti').val().join());
			$('#businessName').val($('#businessNameMulti').val().join());
			$('#additionalInformation').val($('#additionalInformationMulti').val().join());
			$('#productType').val($('#productTypeMulti').val().join());
			$('#serialNumber').val($('#serialNumberMulti').val().join());
			$('#macAddress').val($('#macAddressMulti').val().join());
			$('#managerOsType').val($('#managerOsTypeMulti').val().join());
			$('#managerDbmsType').val($('#managerDbmsTypeMulti').val().join());
			$('#country').val($('#countryMulti').val().join());
			$('#productVersion').val($('#productVersionMulti').val().join());
			$('#licenseFilePath').val($('#licenseFilePathMulti').val().join());
			$('#requester').val($('#requesterMulti').val().join());
			
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
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$("input[type='date']").val("");
	        $('.selectpicker').val('');
			
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();	
		});
		
		
		/* =========== 경로 설정 ========= */
		$('#BtnRoute').click(function() {
			$.ajax({
				url: "<c:url value='/license/setting'/>",
				data: {"licenseVersion" : "5"},
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
		});
		
		/* =========== 데이터 수정 Modal ========= */
		$('#BtnUpdate').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var licenseKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/license5/updateView'/>",
		            data: {"licenseKeyNum" : licenseKeyNum},
		            async: false,
		            success: function (data) {
		                $.modal(data, 'license5'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '수정를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});
	</script>
	<script>
		/* jqgrid 테이블 드래그 체크박스 선택 (부족하고 불편한 점이 있어 계속 수정할것) */
		$("#list").on('click','tr', function () {
			var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
			$("#list").jqGrid('setSelection', checkbox, true);
		});
		
		$("#list").on('mousedown','tr', function () {
			var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
			$("#list").jqGrid('setSelection', checkbox, true);
			var move = true;
			
			$("#list").on('mouseover','tr', function () {
				if(move) {
					var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
					$("#list").jqGrid('setSelection', checkbox, true);
				}
			});
			$("#list").on('mouseup', 'tr', function () {
				move = false;				
			});
			$("body").on('mouseup', function () {
				move = false;				
			});
		});
		
	</script>
</html>