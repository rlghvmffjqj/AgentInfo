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
				var formData = $('#imPackagesListForm').serializeObject();
				$("#imPackagesList").jqGrid({
					url: "<c:url value='/imPackagesList'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사명','사업명','패키지 종류','패키지명'],
					colModel:[
						{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 30, hidden:true },
						{name:'customerName', index:'customerName', align:'center', width: 200, formatter: packagesFormatter},
						{name:'businessName', index:'businessName', align:'center', width: 150},
						{name:'managementServer', index:'managementServer', align:'center', width: 70},
						{name:'packageName', index:'packageName', align:'center', width: 320},
					],
					jsonReader : {
			        	id: 'packagesKeyNum',
			        	repeatitems: false
			        },
			        pager: '#releaseLPager',			// 페이징
			        rowNum: 21,					// 보여중 행의 수
			        sortname: 'packagesKeyNumOrigin',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
				
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '591',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#imPackagesList','imPackagesList');
			});

			$(window).on('resize.list', function () {
			    jQuery("#imPackagesList").jqGrid( 'setGridWidth', $(".integratedManagementDiv").width() );
			});


			$(document).ready(function(){
				var formData = $('#imProductVersionListForm').serializeObject();
				console.log(formData);
				$("#imProductVersionList").jqGrid({
					url: "<c:url value='/imProductVersionList/TOSMS5.0.22'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','패키지명','전달위치','날짜'],
					colModel:[
						{name:'productVersionKeyNum', index:'productVersionKeyNum', align:'center', width: 30, hidden:true },
						{name:'packagesName', index:'packagesName', align:'center', width: 200, formatter: productVersionFormatter},
						{name:'location', index:'location', align:'center', width: 150},
						{name:'packageDate', index:'packageDate', align:'center', width: 70},
					],
					jsonReader : {
			        	id: 'productVersionKeyNum',
			        	repeatitems: false
			        },
			        pager: '#releaseLPager',			// 페이징
			        rowNum: 21,					// 보여중 행의 수
			        sortname: 'productVersionKeyNumOrigin',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
				
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '591',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#improductVersionList','improductVersionList');
			});

			$(window).on('resize.list', function () {
			    jQuery("#improductVersionList").jqGrid( 'setGridWidth', $(".integratedManagementDiv").width() );
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
											<div class="searchbos" style="height: 730px;">
			                           			<div class="integratedManagementDiv" style="height: 100%; border: none;">
													<span style="font-weight:bold;">패키지 배포 관리 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnInsert">매핑</button>
													<form id="imPackagesListForm" name="imPackagesListForm" method ="post" style="float: right;"><input class="form-control" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사명'></form>
													<!------- Grid ------->
													<div class="jqGrid_wrapper" style="padding-top: 30px;">
														<table id="imPackagesList"></table>
														<div id="releaseLPager"></div>
													</div>
													<!------- Grid ------->
												</div>
												<div class="integratedManagementDiv" style="height: 33.33%;">
													<span style="font-weight:bold;">패키지 릴리즈 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnInsert">매핑</button>
													<form id="improductVersionListForm" name="improductVersionListForm" method ="post" style="float: right;"><input class="form-control" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사명'></form>
													<!------- Grid ------->
													<div class="jqGrid_wrapper" style="padding-top: 30px;">
														<table id="improductVersionList"></table>
														<div id="releaseLPager"></div>
													</div>
													<!------- Grid ------->
												</div>
												<div class="integratedManagementDiv" style="height: 33.33%;">
													<span style="font-weight:bold;">이슈목록 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnInsert">매핑</button>
												</div>
												<div class="integratedManagementDiv" style="height: 33.33%; border-bottom: none;">
													<span style="font-weight:bold;">결과보고서 : </span>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnDelect">제거</button>
													<button class="btn btn-outline-info-nomal myBtn" style="float: right;" id="BtnInsert">매핑</button>
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
		/* =========== 제품 통합 관리 Modal ========= */
		$('#BtnInsert').click(function() {
			location.href="<c:url value='/integratedManagement/insertView'/>";			
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
			var integratedManagementStart = $("#integratedManagementStart").val();
			var integratedManagementEnd = $("#integratedManagementEnd").val();
			
			if(integratedManagementStart == "" && integratedManagementEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의 시작날짜를 입력해주세요.',    
					});
			} else if(integratedManagementEnd == "" && integratedManagementStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의  종료 날짜를 입력해주세요.',    
					});
			} else if(integratedManagementStart > integratedManagementEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '시작일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else {
				tableRefresh();	
			}
		});


		/* =========== jpgrid의 formatter 함수 ========= */
		function packagesFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function productVersionFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		
	</script>
	<style>
		.integratedManagementDiv {
			border-left: 1px solid #e99b9b;
			border-bottom: 1px solid #e99b9b;
			width: 50%;
    		float: left;
			padding: 10px;
		}
	</style>
</html>