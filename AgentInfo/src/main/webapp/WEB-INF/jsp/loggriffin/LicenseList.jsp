<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','loggriffin');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/loggriffin'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','구분','고객사명','사업명','MAC주소','제품명','제품버전','에이전트 수량','에이전트리스 수량','발급일','시작일','만료일','추가정보','KEY','라이선스 파일명','요청자','메일 발송'],
					colModel:[
						{name:'logGriffinKeyNum', index:'logGriffinKeyNum', align:'center', width: 35, hidden:true },
						{name:'licenseType', index:'licenseType', align:'center', width: 70},
						{name:'customerName', index:'customerName', align:'center', width: 200},
						{name:'businessName', index:'businessName', align:'center', width: 200},
						{name:'macAddress', index:'macAddress', align:'center', width: 150},
						{name:'productName', index:'productName', align:'center', width: 150},
						{name:'productVersion', index:'productVersion', align:'center', width: 80},
						{name:'agentCount', index:'agentCount',align:'center', width: 100},
						{name:'agentLisCount', index:'agentLisCount',align:'center', width: 100},
						{name:'writeDate', index:'writeDate', align:'center', width: 120},
						{name:'issueDate', index:'issueDate', align:'center', width: 120},
						{name:'expirationDays', index:'expirationDays', align:'center', width: 120},
						{name:'additionalInformation', index:'additionalInformation', align:'center', width: 200},
						{name:'serialNumber', index:'serialNumber', align:'center', width: 250},
						{name:'licenseFilePath', index:'licenseFilePath', align:'center', width: 250},
						{name:'requester', index:'requester', align:'center', width: 100},
						{name:'logGriffinKeyNum', index:'logGriffinKeyNum', align:'center', width: 80, formatter: individualMailSendFormatter},
					],
					jsonReader : {
			        	id: 'logGriffinKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'logGriffinKeyNum',	// 기본 정렬 
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
									            <h5 class="m-b-10">LogGRIFFIN / tGRIFFIN 라이선스 발급</h5>
									            <p class="m-b-0">LogGRIFFIN / tGRIFFIN License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">LogGRIFFIN / tGRIFFIN 라이선스 발급</a>
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
													<div style="padding-left:15px; width:28.3%; float: left;">
														<label class="labelFontSize">시작일</label>
														<div>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="issueDateStart" name="issueDateStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="issueDateEnd" name="issueDateEnd" max="9999-12-31">
													  	</div>
													</div>
													<div style="padding-left:15px; width:60%; float: left;">
														<label class="labelFontSize">만료일</label>
														<div>
														  <input class="form-control" style="width: 21%; float: left;" type="date" id="expirationDaysStart" name="expirationDaysStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 21%; float: left;" type="date" id="expirationDaysEnd" name="expirationDaysEnd" max="9999-12-31">
													  	</div>
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
														<input type="text" id="additionalInformation" name="additionalInformation" class="form-control">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC주소</label>
														<select class="form-control selectpicker" id="macAddressMulti" name="macAddressMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${macAddress}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>		                      							
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">제품명</label>
														<select class="form-control selectpicker" id="productNameMulti" name="productNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${productName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
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
														<label class="labelFontSize">에이전트 수량</label>
														<input type="number" id="agentCount" name="agentCount" class="form-control">
													</div>
													<div class="col-lg-2">
														<label class="labelFontSize">에이전트리스 수량</label>
														<input type="number" id="agentLisCount" name="agentLisCount" class="form-control">
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">KEY</label>
														<select class="form-control selectpicker" id="serialNumberMulti" name="serialNumberMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serialNumber}">
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
			                      						<input type="hidden" id="macAddress" name="macAddress" class="form-control">
			                      						<input type="hidden" id="productName" name="productName" class="form-control">
			                      						<input type="hidden" id="productVersion" name="productVersion" class="form-control">
			                      						<input type="hidden" id="serialNumber" name="serialNumber" class="form-control">
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
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">발급</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnDelect">제거</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnUpdate">수정</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnDownload" title="선택한 테이블 행의 YML 파일을 다운로드합니다.">라이선스 다운로드</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnImport" title="YML 파일을 첨부하여 데이터를 추가합니다.">YML Import</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnRoute" title="라이선스 발급 설정 경로를 지정합니다.">경로설정</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnMailSetting" title="라이선스 만료 메일발송 관련 설정을 등록합니다.">메일발송설정</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnExcelExport" onClick="doExportExec()" title="현제 테이블 조회된 데이터를 Excel로 Export합니다.">Excel 내보내기</button>
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
			    url: "<c:url value='/loggriffin/issuedView'/>",
			    data: {
		    		"viewType" : "issued"
		    	},
			    async: false,
			    success: function (data) {
			    	//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
			    	$.modal(data, 'loggriffinLicense'); //modal창 호출
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
						url: "<c:url value='/loggriffin/delete'/>",
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
		
		
		/* =========== 라이선스 발급 Key 확인 버튼 ========= */
		function licenseNumFormatter(value, options, row) {
			var logGriffinKeyNum = row.logGriffinKeyNum;
			return '<button class="btn btn-outline-info-nomal myBtn" onClick="licenseNumber(' + "'" + logGriffinKeyNum + "'"  + ')">라이선스 발급</button>';
		}
		
		/* =========== 라이선스 Key 확인 ========= */
		function licenseNumber(logGriffinKeyNum) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/license/issueKey'/>",
	            data: {"logGriffinKeyNum" : logGriffinKeyNum},
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
			$('#requester').val($('#requesterMulti').val().join());
			$('#macAddress').val($('#macAddressMulti').val().join());
			$('#productName').val($('#productNameMulti').val().join());
			$('#productVersion').val($('#productVersionMulti').val().join());
			$('#serialNumber').val($('#serialNumberMulti').val().join());
			$('#licenseFilePath').val($('#licenseFilePathMulti').val().join());
			
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
	        $('.filter-option-inner-inner').text('');
			
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var issueDateStart = $("#issueDateStart").val();
			var issueDateEnd = $("#issueDateEnd").val();
			var expirationDaysStart = $("#expirationDaysStart").val();
			var expirationDaysEnd = $("#expirationDaysEnd").val();
			
			if(issueDateStart == "" && issueDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의 시작날짜를 입력해주세요.',    
					});
			} else if(issueDateEnd == "" && issueDateStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의  종료 날짜를 입력해주세요.',    
					});
			} else if(issueDateStart > issueDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '시작일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else if(expirationDaysStart == "" && expirationDaysEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '만료일의 시작 날짜를 입력해주세요.',    
					});
			} else if(expirationDaysEnd == "" && expirationDaysStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '만료일의 종료 날짜를 입력해주세요.',    
					});
			} else if(expirationDaysStart > expirationDaysEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '만료일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else {
				tableRefresh();	
			}
		});
		
		
		/* =========== TXT 저장 ========= */
		$('#BtnTxt').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				url: "<c:url value='/license/txtTitle'/>",
				type: "POST",
				data: {chkList: chkList},
				traditional: true,
				async: false,
				success: function(data) {
					//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
				});
			}
		});
		
		/* =========== 경로 설정 ========= */
		$('#BtnRoute').click(function() {
			$.ajax({
				url: "<c:url value='/license/setting'/>",
				data: {"licenseVersion" : "loggriffin"},
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
		});
		
		/* =========== 데이터 복사 Modal ========= */
		$('#BtnCopy').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var logGriffinKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/license/copyView'/>",
		            data: {"logGriffinKeyNum" : logGriffinKeyNum},
		            async: false,
		            success: function (data) {
		            	//if(data.indexOf("<!DOCTYPE html>") != -1) 
						//	location.reload();
		                $.modal(data, 'll'); //modal창 호출
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

		/* =========== 데이터 수정 Modal ========= */
		$('#BtnUpdate').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var logGriffinKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/loggriffin/updateView'/>",
		            data: {"logGriffinKeyNum" : logGriffinKeyNum},
		            async: false,
		            success: function (data) {
		                $.modal(data, 'loggriffinLicense'); //modal창 호출
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

		$('#BtnDownload').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList.length === 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});  
			} else {
				$.ajax({
					url: "<c:url value='/loggriffin/loggriffinDownLoadCheck'/>",
					type: "POST",
					data: {chkList: chkList},
					traditional: true,
					async: false,
					success: function(result) {
	            		if(result==="Empty") {
							Swal.fire(
							  '에러!',
							  'YML 파일이 존재하지 않거나, <br>존재하지 않는 리스트가 포함되어 있습니다.',
							  'error'
							)
						} else if(chkList.length === 1) {
							location.href="<c:url value='/loggriffin/loggriffinSingleDownLoad'/>?logGriffinKeyNum="+chkList;
						} else {
							location.href="<c:url value='/loggriffin/loggriffinMultiDownLoad'/>?logGriffinKeyNum="+chkList;
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
			
		});

		$('#BtnImport').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/loggriffin/licenseYmlImportView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'xmlImport'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});
		});

		$('#BtnMailSetting').click(function() {
			$.ajax({
				url: "<c:url value='/loggriffin/mailSetting'/>",
				data: "",
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					$.modal(data, 'mailSetting'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
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
		
		function individualMailSendFormatter(cellValue, options, rowdata, action) {
			if(cellValue == '' || cellValue == null) {
				return '';
			}
			if(rowdata.expirationDays != "무제한") {
				return '<button type="button" class="btn btn-outline-info-nomal myBtn" onclick="individualMailSend('+"'"+cellValue+"'"+');">발송</button>';
			} else {
				return "";
			}
		}

		function individualMailSend(keyNum) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/loggriffin/individualMailSend'/>",
		        data: {"licenseKeyNum" : keyNum},
		        async: false,
		        success: function (data) {
		            if(data == "OK")
						Swal.fire(
						  '발송!',
						  'Mail 발송하였습니다.',
						  'success'
						)
					else
						Swal.fire(
						  '실패!',
						  'Mail 발송 실패하였습니다.',
						  'error'
						)
		        },
		        error: function(e) {
		            Swal.fire(
					  '실패!',
					  '에러가 발생하였습니다.',
					  'error'
					)
		        }
		    });
		}
	</script>
</html>