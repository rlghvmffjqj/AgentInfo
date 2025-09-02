<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','secuveOTP');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/secuveOTP'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','발급날짜','사이트','MAC','만료일','라이선스','비고','라이선스 파일명','요청자'],
					colModel:[
						{name:'secuveOTPKeyNum', index:'secuveOTPKeyNum', align:'center', width: 35, hidden:true },
						{name:'secuveOTPCreated', index:'secuveOTPCreated', align:'center', width: 150},
						{name:'secuveOTPSite', index:'secuveOTPSite', align:'center', width: 200},
						{name:'secuveOTPMac', index:'secuveOTPMac', align:'center', width: 150},
						{name:'secuveOTPExpireym', index:'secuveOTPExpireym', align:'center', width: 150},
						{name:'secuveOTPLicense', index:'secuveOTPLicense', align:'center', width: 200},
						{name:'secuveOTPBigo', index:'secuveOTPBigo',align:'center', width: 300},
						{name:'secuveOTPFilePath', index:'secuveOTPFilePath',align:'center', width: 250},
						{name:'secuveOTPRequester', index:'secuveOTPRequester',align:'center', width: 150}
					],
					jsonReader : {
			        	id: 'secuveOTPKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'secuveOTPKeyNum',	// 기본 정렬 
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
				loadColumns('#list','secuveOTPList');
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
									            <h5 class="m-b-10">SecuveOTP 라이선스 발급</h5>
									            <p class="m-b-0">SecuveOTP License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">SecuveOTP 라이선스 발급</a>
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
													<div style="padding-left:15px; width:28.5%; display: table;">
														<label class="labelFontSize">발급날짜</label>
														<div>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="secuveOTPCreatedStart" name="secuveOTPCreatedStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="secuveOTPCreatedEnd" name="secuveOTPCreatedEnd" max="9999-12-31">
													  	</div>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사이트</label>
														<input type="text" id="secuveOTPSite" name="secuveOTPSite" class="form-control">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC</label>
														<input type="text" id="secuveOTPMac" name="secuveOTPMac" class="form-control">
													</div>
													<div class="col-lg-2">
														<label class="labelFontSize">만료일</label>
														<input type="text" id="secuveOTPExpireym" name="secuveOTPExpireym" class="form-control">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">라이선스</label>
														<input type="text" id="secuveOTPLicense" name="secuveOTPLicense" class="form-control">		                      							
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">비고</label>
														<input type="text" id="secuveOTPBigo" name="secuveOTPBigo" class="form-control">
		                      						</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">라이선스 파일명</label>
														<input type="text" id="secuveOTPFilePath" name="secuveOTPFilePath" class="form-control">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">요청자</label>
														<input type="text" id="secuveOTPRequester" name="secuveOTPRequester" class="form-control">
													</div>
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
																	<!-- <button class="btn btn-outline-info-nomal myBtn" id="BtnDownload" title="선택한 테이블 행의 YML 파일을 다운로드합니다.">YML 다운로드</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnImport" title="YML 파일을 첨부하여 데이터를 추가합니다.">YML Import</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnRoute" title="라이선스 발급 설정 경로를 지정합니다.">경로설정</button> -->
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnExcelExport" onClick="doExportExec()" title="현제 테이블 조회된 데이터를 Excel로 Export합니다.">Excel 내보내기</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'secuveOTPList');">컬럼 선택</button>
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
			    url: "<c:url value='/secuveOTP/issuedView'/>",
			    data: {
		    		"viewType" : "issued"
		    	},
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
						url: "<c:url value='/secuveOTP/delete'/>",
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
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {		
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
			var secuveOTPCreatedStart = $("#secuveOTPCreatedStart").val();
			var secuveOTPCreatedEnd = $("#secuveOTPCreatedEnd").val();
			var expirationDaysStart = $("#expirationDaysStart").val();
			var expirationDaysEnd = $("#expirationDaysEnd").val();
			
			if(secuveOTPCreatedStart == "" && secuveOTPCreatedEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의 시작날짜를 입력해주세요.',    
					});
			} else if(secuveOTPCreatedEnd == "" && secuveOTPCreatedStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의  종료 날짜를 입력해주세요.',    
					});
			} else if(secuveOTPCreatedStart > secuveOTPCreatedEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '시작일의 시작 날짜가 종료 날짜 보다 큽니다.',    
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
				data: {"licenseVersion" : "secuveOTP"},
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
			var secuveOTPKeyNum = chkList[0];
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
		            data: {"secuveOTPKeyNum" : secuveOTPKeyNum},
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
			var secuveOTPKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/secuveOTP/updateView'/>",
		            data: {"secuveOTPKeyNum" : secuveOTPKeyNum},
		            async: false,
		            success: function (data) {
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
					url: "<c:url value='/secuveOTP/secuveOTPDownLoadCheck'/>",
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
							location.href="<c:url value='/secuveOTP/secuveOTPSingleDownLoad'/>?secuveOTPKeyNum="+chkList;
						} else {
							location.href="<c:url value='/secuveOTP/secuveOTPMultiDownLoad'/>?secuveOTPKeyNum="+chkList;
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
			    url: "<c:url value='/secuveOTP/licenseYmlImportView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'xmlImport'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
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
		
	</script>
</html>