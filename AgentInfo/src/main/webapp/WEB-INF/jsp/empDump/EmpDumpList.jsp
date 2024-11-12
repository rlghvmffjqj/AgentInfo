<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','empDump');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var siteName = $('#empDumpCustomer').val();

				$("#nhlifeList").jqGrid({
				    url: "<c:url value='/nhlifeData'/>", // 데이터를 가져올 서버 URL
				    mtype: 'POST',   
					postData: {'siteName': siteName},                    // 요청 방식 (GET 또는 POST)
				    datatype: 'json',                    // 데이터 형식
				    colNames: [
				        'User ID','사원번호', '사원명', '휴대폰', '내선번호', 
				        '이메일', '사용자타입', /*'USER_TYPE_NAME',*/ /* 'User Position ID',*/ 
				        /*'User Position Name',*/ /*'User Title ID',*/ '직위', 
				        '상태', /*'User Status Name',*/ '부서코드', '부서명', 
				        /*'Hierarchy ID',*/ '부서경로'
				    ],
				    colModel: [
				        { name: 'user_id', index: 'user_id', align: 'center', hidden: true},
				        { name: 'user_number', index: 'user_number', align: 'center'},
				        { name: 'user_name', index: 'user_name', align: 'center'},
				        { name: 'user_phone', index: 'user_phone', align: 'center'},
				        { name: 'user_office', index: 'user_office', align: 'center'},
				        { name: 'user_email', index: 'user_email', align: 'center'},
				        { name: 'user_type_id', index: 'user_type_id', align: 'center'},
				        // { name: 'user_type_name', index: 'user_type_name', align: 'center'},
				        // { name: 'user_position_id', index: 'user_position_id', align: 'center'},
				        // { name: 'user_position_name', index: 'user_position_name', align: 'center'},
				        // { name: 'user_title_id', index: 'user_title_id', align: 'center'},
				        { name: 'user_title_name', index: 'user_title_name', align: 'center'},
				        { name: 'user_status_id', index: 'user_status_id', align: 'center'},
				        // { name: 'user_status_name', index: 'user_status_name', align: 'center'},
				        { name: 'dept_id', index: 'dept_id', align: 'center'},
				        { name: 'dept_name', index: 'dept_name', align: 'center'},
				        // { name: 'hierarchy_id', index: 'hierarchy_id', align: 'center'},
				        { name: 'hierarchy_name', index: 'hierarchy_name', align: 'center'}
				    ],
				    jsonReader: {
				        repeatitems: false,
				        id: 'user_id' // 서버 데이터의 primary key 필드
				    },
				    pager: '#nhlifePager',
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'user_id',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: true,				// 라인 강조
				});


				$("#kbankList").jqGrid({
				    url: "<c:url value='/kbankData'/>", // 데이터를 가져올 서버 URL
				    mtype: 'POST',
				    datatype: 'json', // 데이터 형식
				    colNames: [
					    'User ID', 'User Name', 'Email', 'Phone', 'Mobile', 'Department Code', 
					    'Department Name', 'Position Code', 'Position Name', 'User Type', 
					    'Approval Type', 'Other Group ID', 'Custom Field 1', 'Custom Field 2', 
					    'Custom Field 3'
					],
					colModel: [
					    { name: 'user_id', index: 'user_id', align: 'center' },
					    { name: 'user_name', index: 'user_name', align: 'center' },
					    { name: 'user_email', index: 'user_email', align: 'center' },
					    { name: 'user_tel', index: 'user_tel', align: 'center' },
					    { name: 'user_mobile', index: 'user_mobile', align: 'center' },
					    { name: 'user_dept', index: 'user_dept', align: 'center' },
					    { name: 'user_dept_name', index: 'user_dept_name', align: 'center' },
					    { name: 'pos_code', index: 'pos_code', align: 'center' },
					    { name: 'pos_name', index: 'pos_name', align: 'center' },
					    { name: 'user_type_sub', index: 'user_type_sub', align: 'center' },
					    { name: 'approv_type', index: 'approv_type', align: 'center' },
					    { name: 'other_group_id', index: 'other_group_id', align: 'center' },
					    { name: 'user_custom01', index: 'user_custom01', align: 'center' },
					    { name: 'user_custom02', index: 'user_custom02', align: 'center' },
					    { name: 'user_custom03', index: 'user_custom03', align: 'center' }
				    ],
				    jsonReader: {
				        repeatitems: false,
				        id: 'user_id' // 서버 데이터의 primary key 필드
				    },
				    pager: '#kbankPager',
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'user_id',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: true,				// 라인 강조
				});

			});
			
			$(window).on('resize.nhlifeList', function () {
			    jQuery("#nhlifeList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			});

			$(window).on('resize.kbankList', function () {
			    jQuery("#kbankList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
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
									            <h5 class="m-b-10">고객사 인사정보 파일</h5>
									            <p class="m-b-0">Customer Employee File</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">고객사 인사정보 파일</a>
									            </li>
									        </ul>
									    </div>
									</div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
	                                	
			                           	 	<table style="width:99%;">
												<tbody><tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="width: 110px; background: white; border-radius: 25px;">
																	<select class="form-control" id="empDumpCount" name="empDumpCount" data-size="5"  data-actions-box="true">
																		<option value="10">10개</option>
																		<option value="25">25개</option>
																		<option value="50">50개</option>
																		<option value="100">100개</option>
																		<option value="500">500개</option>
																		<option value="1000">1000개</option>
																	</select>
																</td>
																<td style="width: 170px; background: white; border-radius: 25px;">
																	<select class="form-control" id="empDumpCustomer" name="empDumpCustomer" data-size="5" data-actions-box="true">
																		<option value="">--- 고객사 선택 ---</option>
																		<option value="nhlife">NH농협생명</option>
																		<option value="kbank">KB카드</option>
																		<option value="nhqv">NH투자증권</option>
																		<option value="btckorea">비티씨코리아닷컴</option>
																	</select>
																</td>
																<td>
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert" style="height: 34px;">생성</button>
																</td>
															</tr>
															<tr>
																<td class="border1" colspan="3">
																	<!------- Grid ------->
																	<div class="jqGrid_wrapper" id="nhlifeId">
																		<table id="nhlifeList"></table>
																		<div id="nhlifePager"></div>
																	</div>
																	<!------- Grid ------->

																	<!------- Grid ------->
																	<div class="jqGrid_wrapper" id="kbankId" style="display: none;">
																		<table id="kbankList"></table>
																		<div id="kbankPager"></div>
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
		$('#empDumpCustomer').change(function () {
			var empDumpCustomer = $('#empDumpCustomer').val();
			jQuery("#kbankList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			jQuery("#nhlifeList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			if(empDumpCustomer == "") {
				Swal.fire(
				  '실패!',
				  '고객사를 선택 바랍니다.',
				  'error'
				)
				return false;
			}

			$(".jqGrid_wrapper").hide();

			if(empDumpCustomer == "nhlife") {
				$("#nhlifeId").show();
			} else if(empDumpCustomer == "btckorea") {
				$("#nhlifeId").show();
			} else if(empDumpCustomer == "kbank") {
				$("#kbankId").show();
			}
		});


		/* =========== 더미데이터 생성 ========= */
		$('#BtnInsert').click(function() {
			var empDumpCount = $('#empDumpCount').val();
			var empDumpCustomer = $('#empDumpCustomer').val();
			
			if(empDumpCustomer == "") {
				Swal.fire(
				  '실패!',
				  '고객사를 선택 바랍니다.',
				  'error'
				)
				return false;
			}

			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/empDump/create'/>",
			    data: {
					"empDumpCount": empDumpCount,
					"empDumpCustomer": empDumpCustomer
				},
			    async: false,
			    success: function (data) {
			    	if(data == "OK") {
						Swal.fire(
						  '성공!',
						  '인사정보 생성 완료!',
						  'success'
						)
					} else if(data == "nhlifeOk") {
						Swal.fire(
						  'NH농협생명 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>NH농협생명은 Tibero를 사용하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshNH();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "btckoreaOK") {
						Swal.fire(
						  '비티씨코리아닷컴 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>비티씨코리아닷컴은 Tibero를 사용하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshNH();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					}else if(data == "kbankOk") {
						Swal.fire(
						  'K뱅크 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshKbank();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else {
						Swal.fire(
						  '실패!',
						  '실패하였습니다.',
						  'error'
						)
					}

			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		function tableRefreshNH() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#nhlifeList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}

		function tableRefreshKbank() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#kbankList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}
		
	</script>
</html>