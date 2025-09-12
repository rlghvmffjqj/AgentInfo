<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','integratedManagement');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var packagesData = $('#imPackagesListForm').serializeObject();
				$("#imPackagesList").jqGrid({
					url: "<c:url value='/imPackagesList'/>",
					mtype: 'POST',
					postData: packagesData,
					datatype: 'json',
					colNames:['Key','고객사ID','고객사 명','사업명','망 구분','요청일자','전달일자','패키지 종류','일반/커스텀','Agent ver','패키지명','담당자','OS종류','패키지 상세버전','OS버전','기존/신규','요청 제품구분','전달 방법','구매구분','비고','상태 변경 의견'],
					colModel:[
						{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 35, hidden:true },
						{name:'categoryKeyNum', index:'categoryKeyNum', align:'center', width: 70, formatter: strFormatter },
						{name:'customerName', index:'customerName', align:'center', width: 200, formatter: packagesFormatter},
						{name:'businessName', index:'businessName', align:'center', width: 180},
						{name:'networkClassification', index:'networkClassification', align:'center', width: 70},
						{name:'requestDate', index:'requestDate', align:'center', width: 70},
						{name:'deliveryData', index:'deliveryData',align:'center', width: 70},
						{name:'managementServer', index:'managementServer', align:'center', width: 80},
						{name:'generalCustom', index:'generalCustom', align:'center', width: 70},
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
			        	id: 'packagesKeyNum',
			        	repeatitems: false
			        },
			        pager: '#imPackagesPager',			// 페이징
			        rowNum: 7,					// 보여중 행의 수
			        sortname: 'packagesKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
				
			        // multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '220',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
					onSelectRow: function (rowId) {
						selectReport(rowId)
  					}
				}); 
				

				var productVersionData = $('#imProductVersionListForm').serializeObject();
				$("#imProductVersionList").jqGrid({
					url: "<c:url value='/imProductVersionList/ProductVersion_125'/>",
					mtype: 'POST',
					postData: productVersionData,
					datatype: 'json',
					colNames:['Key','패키지명','전달위치','날짜'],
					colModel:[
						{name:'productVersionKeyNum', index:'productVersionKeyNum', align:'center', width: 30, hidden:true },
						{name:'packageName', index:'packageName', align:'center', width: 320, formatter: productVersionFormatter},
						{name:'location', index:'location', align:'center', width: 385},
						{name:'packageDate', index:'packageDate', align:'center', width: 70},
					],
					jsonReader : {
			        	id: 'productVersionKeyNum',
			        	repeatitems: false
			        },
			        pager: '#imProductVersionPager',			// 페이징
			        rowNum: 8,					// 보여중 행의 수
			        sortname: 'productVersionKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
				
			        // multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '265',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 


				var issueData = $('#imIssueListForm').serializeObject();
				$("#imIssueList").jqGrid({
					url: "<c:url value='/imIssueList'/>",
					mtype: 'POST',
					postData: issueData,
					datatype: 'json',
					colNames:['Key','고객사명','타이틀','작성자','전달일자'],
					colModel:[
						{name:'issueKeyNum', index:'issueKeyNum', align:'center', width: 30, hidden:true },
						{name:'issueCustomer', index:'issueCustomer', align:'center', width: 270, formatter: issueFormatter},
						{name:'issueTitle', index:'issueTitle', align:'center', width: 330},
						{name:'issueFirstWriter', index:'issueFirstWriter', align:'center', width: 100},
						{name:'issueDate', index:'issueDate', align:'center', width: 70},
					],
					jsonReader : {
			        	id: 'issueKeyNum',
			        	repeatitems: false
			        },
			        // pager: '#imIssuePager',			// 페이징
			        rowNum: 3,					// 보여중 행의 수
			        sortname: 'issueKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
				
			        // multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '90',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
			});

			

			$(window).on('resize.list', function () {
			    jQuery("#imPackagesList").jqGrid( 'setGridWidth', $(".imPackagesDiv").width() );
				jQuery("#imProductVersionList").jqGrid( 'setGridWidth', $(".improductVersionDiv").width() );
				jQuery("#imIssueList").jqGrid( 'setGridWidth', $(".imIssueDiv").width() );
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
									            <h5 class="m-b-10">제품 통합 관리</h5>
									            <p class="m-b-0">Integrated Management</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">제품 통합 관리</a>
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
											<div class="searchbos" style="height: 740px;">
												<input type="hidden" id="resultsReportKeyNum" name="resultsReportKeyNum" class="form-control">
			                           			<div class="integratedManagementDiv" style="height: 48%; width: 100%; border-top: none; border-left: none; border-right: none;">
													<span style="font-weight:bold;">패키지 배포 관리 : </span>
													<!-- <button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button> -->
													<!-- <button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnInsert">매핑</button> -->
													<form id="imPackagesListForm" name="imPackagesListForm" method ="post" style="float: right;" onsubmit="return false;"><input class="form-control integratedInput" type="text" id="customerName" name="customerName" placeholder='고객사명'></form>
													<!------- Grid ------->
													<div class="jqGrid_wrapper" style="padding-top: 20px;">
														<table id="imPackagesList"></table>
														<div id="imPackagesPager"></div>
													</div>
													<!------- Grid ------->
												</div>
												<div class="integratedManagementDiv" style="height: 50%; border-left: none; border-bottom: none;">
													<span style="font-weight:bold;">패키지 릴리즈 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnimProductVersionListInsert">매핑</button>
													<form id="imProductVersionListForm" name="imProductVersionListForm" method ="post" style="float: right;" onsubmit="return false;"><input class="form-control integratedInput" type="text" id="packageName" name="packageName" placeholder='패키지명'></form>
													<!------- Grid ------->
													<div class="jqGrid_wrapper" style="padding-top: 20px;">
														<table id="imProductVersionList"></table>
														<div id="imProductVersionPager"></div>
													</div>
													<!------- Grid ------->
												</div>
												<div class="integratedManagementDiv" style="height: 25%;">
													<span style="font-weight:bold;">이슈목록 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnInsert">매핑</button>
													<form id="imIssueListForm" name="imIssueListForm" method ="post" style="float: right;" onsubmit="return false;"><input class="form-control integratedInput" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사'></form>
													<!------- Grid ------->
													<div class="jqGrid_wrapper" style="padding-top: 20px;">
														<table id="imIssueList"></table>
														<div id="imIssuePager"></div>
													</div>
												</div>
												<div class="integratedManagementDiv" style="height: 25%; border-bottom: none;">
													<span style="font-weight:bold;">결과보고서 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnimResultsReportDelete">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnimResultsReportInsert">매핑</button>
													<div id="resultsReportDiv"></div>
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
	    </div>
	</body>

	<script>
		$('#BtnimResultsReportInsert').click(function() {
			var packagesKeyNum = $("#imPackagesList").jqGrid('getGridParam', 'selrow'); 
			if(packagesKeyNum == null) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '패키지 배포 관리를 선택하고 매핑 바랍니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/integratedManagement/resultsReportInsertView'/>",
				    data: {
						"packagesKeyNum": packagesKeyNum,
						"integratedManagementType": "resultsReport"
					},
				    async: false,
					traditional: true,
					dataType: "text",
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'imResultsReport'); //modal창 호출
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});		
			}
		});

		$('#BtnimResultsReportDelete').click(function() {
			var packagesKeyNum = $("#imPackagesList").jqGrid('getGridParam', 'selrow'); 
			if(packagesKeyNum == null) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '패키지 배포 관리를 선택하고 매핑 바랍니다.',    
				});    
			} else {
				Swal.fire({
					  title: '제거!',
					  text: "결과보고서 매핑을 제거하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  	$.ajax({
							url: "<c:url value='/integratedManagement/resultsReportDelete'/>",
							type: "POST",
							data: {
								"packagesKeyNum": packagesKeyNum,
								"integratedManagementType": "resultsReport"
							},
							dataType: "text",
							traditional: true,
							async: false,
							success: function(data) {
								if(data == "OK") {
									Swal.fire(
									  '성공!',
									  '제거 완료하였습니다.',
									  'success'
									)
									$('#resultsReportDiv').empty();
								} else {
									Swal.fire(
									  '실패!',
									  '제거 실패하였습니다.',
									  'error'
									)
								}
								imPackagesListRefresh();
							},
							error: function(error) {
								console.log(error);
							}
						  });
				  	}
				})
			}
		});
		
		$('#BtnimProductVersionListInsert').click(function() {
			var packagesKeyNum = $("#imPackagesList").jqGrid('getGridParam', 'selrow'); 
			if(packagesKeyNum == null) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '패키지 배포 관리를 선택하고 매핑 바랍니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/integratedManagement/productVersionInsertView'/>",
				    data: {
						"packagesKeyNum": packagesKeyNum,
						"integratedManagementType": "productVersion"
					},
				    async: false,
					traditional: true,
					dataType: "text",
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'imResultsReport'); //modal창 호출
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});
			}
		});
		
		
		
		/* =========== 제품 통합 관리 정보 제거 ========= */
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
						url: "<c:url value='/integratedManagement/delete'/>",
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
							imPackagesListRefresh();
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
		function imPackagesListRefresh() {		
			var _postDate = $("#imPackagesListForm").serializeObject();
			
			var jqGrid = $("#imPackagesList");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== 테이블 새로고침 ========= */
		function imProductVersionListRefresh() {		
			var _postDate = $("#imProductVersionListForm").serializeObject();
			
			var jqGrid = $("#imProductVersionList");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}

		/* =========== 테이블 새로고침 ========= */
		function imIssueListRefresh() {		
			var _postDate = $("#imIssueListForm").serializeObject();
			
			var jqGrid = $("#imIssueList");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}

		function strFormatter(cellValue, options, rowdata, action) {
			var code = "S_";
			for(var i=cellValue.toString().length; i < 5; i++) {
				code = code + "0";
			}
			return code + cellValue;
		}

		/* =========== jpgrid의 formatter 함수 ========= */
		function packagesFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function productVersionFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.productVersionKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function issueFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.issueKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function selectReport(packagesKeyNum) {
			$.ajax({
				url: "<c:url value='/integratedManagement/resultsReport'/>",
				type: "POST",
				data: {"packagesKeyNum": packagesKeyNum},
				dataType: "html",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "") {
						$('#resultsReportDiv').empty();
					} else {
						$('#resultsReportDiv').empty().append(data);
						$('#resultsReportDiv input').prop('disabled', true);
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
		}

		$('#customerName').on('input', function() {
		    let keyword = $(this).val();
		    imPackagesListRefresh();
		});

		$('#packageName').on('input', function() {
		    let keyword = $(this).val();
		    imProductVersionListRefresh();
		});

		$('#issueCustomer').on('input', function() {
		    let keyword = $(this).val();
		    imIssueListRefresh();
		});

		$('#resultsReportDiv').dblclick(function() {
			var packagesKeyNum = $("#imPackagesList").jqGrid('getGridParam', 'selrow'); 
			if(packagesKeyNum == null) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '패키지 배포 관리를 선택하고 확인 바랍니다.',    
				});    
			} else {
		    	var resultsReportDiv = $('#resultsReportDiv').text();
				if(resultsReportDiv == "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '매핑된 결과 보고서가 존재하지 않습니다.',    
					});   
				} else {
					var resultsReportKeyNum = "";
					$.ajax({
						url: "<c:url value='/integratedManagement/resultsReportOne'/>",
						type: "POST",
						data: {"packagesKeyNum": packagesKeyNum},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							resultsReportKeyNum = data;
						},
						error: function(error) {
							console.log(error);
						}
					});

        			var baseUrl = "<c:url value='/resultsReport/updateView'/>";
        			var url = baseUrl + "?resultsReportNumber=" + encodeURIComponent(resultsReportKeyNum);
        			window.open(url, '_blank');
				}
			}
		});


	</script>
	<style>
		.integratedManagementDiv {
			border-left: 1px solid #e99b9b;
			border-bottom: 1px solid #e99b9b;
			width: 50%;
    		float: left;
			padding: 10px;
		}

		#resultsReportDiv {
			background: white; 
			width: 100%; 
			height: 300px; 
			margin-top: 25px; 
			height: 145px; 
			border: 1px solid #dfa465;
			overflow-y: scroll;
			padding: 10px;
		}

		#resultsReportDiv input:disabled {
		    background-color: white; /* 배경 흰색 */
		}

		.ui-jqgrid .ui-jqgrid-htable .ui-th-div {
			font-size: 12px;
		}

		.ui-jqgrid tr.jqgrow td, .ui-jqgrid tr.jqgroup td {
			font-size: 12px;
		}

		.ui-jqgrid .ui-jqgrid-pager .ui-paging-pager, .ui-jqgrid .ui-jqgrid-toppager .ui-paging-pager {
			font-size: 11px;
		}

		.integratedInput {
			height: 26px;
		}
	</style>
	<style>
		.pageBreak {
			border-bottom: 1px dotted gray;
			margin-top: 40px;
			margin-bottom: 40px;
		}

		.borderDotted {
			/* border: 1px dotted #bababa !important; */
			width: 100%;
		}

		.myBtn {
			padding: 5px 5px;
		}

		table td.selected {
			background: #afdcff70 !important;
		}

		/* input:not([disabled]) {
			background: none !important;
		} */
	</style>

	<style id="pdfStyle">
		div {
			font-size: 13px;
		}
		
		.middleTitle {
			margin-top: 30px;
		}

		.table1 {
			border: 1px solid black;
			width: 200px;
			padding: 5px;
			
		}

		.table2 {
			border: 1px solid black;
			width: 400px;
			padding: 5px;
		}

		.tableTd {
			border: 1px solid black;
			padding: 5px;
		}

		.tableCenter {
			text-align: center;
		}

		.pageBreak {
			page-break-before: always;
		}

		#BtnPDFexport {
			text-align: -webkit-right;
    		float: left;
    		border-radius: 0 !important;
    		font-size: 15px;
    		color: #ff1500;
    		border: 1px solid #ff0000;
			padding: 5px 7px;
		}

		#BtnPDFexport:hover {
			color: white;
			background: #4451ff;
			border: 1px solid blue;
		}

		.writeDiv {
			width: 100%;
		    height: 100%;
		    background: white;
		    min-height: 700px;
		    padding: 2%;
		}

		.title1 {
			color: red;
    		border: 10px double red;
    		padding: 10px;
    		width: 170px;
    		text-align: center;
    		float: right;
			font-size: 16px;
			font-weight: bolder;
			margin-top: 10px;
			margin-right: 10px;
		}

		.title2 {
			width: 100%;
    		text-align: center;
    		font-size: 50px;
    		font-weight: bolder;
    		color: #7F7F7F;
    		font-style: italic !important;
		}

		.title3 {
			width: 100%;
    		text-align: center;
    		font-size: 50px;
    		margin-top: 25px;
    		color: #7F7F7F;
		}
		
		.title4 {
			font-size: 25px;
			color: black;
			text-align: center;
		}

		.title5 {
			font-size: 25px;
    		color: black;
    		margin-top: 15px;
			text-align: center;
		}

		.title6 {
			font-size: 35px;
    		color: black;
		}

		.title7 {
			font-size: 20px;
    		font-weight: bold;
    		color: black;
			margin-bottom: 10px;
			text-align: center;
		}

		.title8 {
			font-size: 22px;
    		font-weight: bold;
    		margin-bottom: 20px;
		}

		.titleScope1 {
			text-align: -webkit-right;
    		width: 100%;
    		height: 130px;
		}

		.titleScope3 {
			margin-top: 200px;
			text-align: center;
		}

		.titleScope4 {
			margin-top: 250px;
			text-align: center;
		}

		.titleScope5 {
			text-align: -webkit-center;
		}

		input {
			border: none;
		}

		textarea {
			border: none;
			background-color: transparent;
		}

		.inputCenter {
			text-align: center;
		}

		.textareaDouble  {
			height: 50px;
			resize: none;
			border-radius: 50px;
		}

		input {
			width: 100%
		}

		.width10p {
			width: 10%;
		}

		.width20p {
			width: 20%;
		}

		.width15p {
			width: 15%;
		}

		.width65p {
			width: 65%;
		}

		.width35p {
			width: 35%;
		}

		.width25p {
			width: 25%;
		}

		.width70p {
			width: 70%;
		}

		.width60p {
			width: 60%;
		}
	</style>
</html>