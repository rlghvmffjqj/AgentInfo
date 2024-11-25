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

				$("#nhqvList").jqGrid({
				    url: "<c:url value='/nhqvData'/>", // 데이터를 가져올 서버 URL
				    mtype: 'POST',
				    datatype: 'json', // 데이터 형식
				    colNames: [
					    '사번', '주민번호', '이름', '상태', '사무실 전화번호', '이메일', 
					    '부서코드', '부서명', '직급코드', '직급'
					],
					colModel: [
					    { name: 'sabun', index: 'sabun', align: 'center' },
					    { name: 'jumin_no', index: 'jumin_no', align: 'center' },
					    { name: 'name', index: 'name', align: 'center' },
					    { name: 'status', index: 'status', align: 'center' },
					    { name: 'office_tel', index: 'office_tel', align: 'center' },
					    { name: 'mail_id', index: 'mail_id', align: 'center' },
					    { name: 'org_cd', index: 'org_cd', align: 'center' },
					    { name: 'org_nm', index: 'org_nm', align: 'center' },
					    { name: 'pos_cd', index: 'pos_cd', align: 'center' },
					    { name: 'pos_nm', index: 'pos_nm', align: 'center' }
				    ],
				    jsonReader: {
				        repeatitems: false,
				        id: 'sabun' // 서버 데이터의 primary key 필드
				    },
				    pager: '#nhqvPager',
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'sabun',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: true,				// 라인 강조
				});


				$("#samsunglifeList").jqGrid({
				    url: "<c:url value='/samsunglifeData'/>", // 데이터를 가져올 서버 URL
				    mtype: 'POST',
				    datatype: 'json', // 데이터 형식
				    colNames: [
					    '타입', '사번', '계정명', '사원명', '직무 책임', '직무', '이메일', '휴대폰번호',
					    '전화번호', '부서경로', '상위부서', '부서명', '상태', '회사'
					],
					colModel: [
					    { name: 'empType', index: 'empType', align: 'center' },
					    { name: 'empnum', index: 'empnum', align: 'center' },
					    { name: 'accountname', index: 'accountname', align: 'center' },
					    { name: 'empName', index: 'empName', align: 'center' },
					    { name: 'jobTitle', index: 'jobTitle', align: 'center' },
					    { name: 'jobName', index: 'jobName', align: 'center' },
					    { name: 'email', index: 'email', align: 'center' },
					    { name: 'mobile', index: 'mobile', align: 'center' },
					    { name: 'phone', index: 'phone', align: 'center' },
					    { name: 'deptFullPath', index: 'deptFullPath', align: 'center' },
						{ name: 'deptParentPath', index: 'deptParentPath', align: 'center' },
						{ name: 'deptName', index: 'deptName', align: 'center' },
						{ name: 'empStatus', index: 'empStatus', align: 'center' },
						{ name: 'company', index: 'company', align: 'center' },
				    ],
				    jsonReader: {
				        repeatitems: false,
				        id: 'accountname' // 서버 데이터의 primary key 필드
				    },
				    pager: '#samsunglifePager',
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'accountname',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: true,				// 라인 강조
				});


				$("#shinhanlifeList").jqGrid({
				    url: "<c:url value='/shinhanlifeData'/>", // 데이터를 가져올 서버 URL
				    mtype: 'POST',
				    datatype: 'json', // 데이터 형식
					colNames: [
					    '사원번호', '부서코드', '부서명', '상태'
					],
					colModel: [
					    { name: 'empNum', index: 'empNum', align: 'center' },
					    { name: 'deptCode', index: 'deptCode', align: 'center' },
					    { name: 'deptName', index: 'deptName', align: 'center' },
					    { name: 'appointedStatus', index: 'appointedStatus', align: 'center' },
				    ],
				    jsonReader: {
				        repeatitems: false,
				        id: 'empNum' // 서버 데이터의 primary key 필드
				    },
				    pager: '#shinhanlifePager',
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'empNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: true,				// 라인 강조
				});


				$("#finnqList").jqGrid({
				    url: "<c:url value='/finnqData'/>", // 데이터를 가져올 서버 URL
				    mtype: 'POST',
				    datatype: 'json', // 데이터 형식
					colNames: [
					    '아이디', '이름', '패스워드', '부서명','직위','레벨','타입','상태'
					],
					colModel: [
					    { name: 'user_id', index: 'user_id', align: 'center' },
					    { name: 'user_name', index: 'user_name', align: 'center' },
					    { name: 'user_password', index: 'user_password', align: 'center' },
					    { name: 'dept_name', index: 'dept_name', align: 'center' },
						{ name: 'position_name', index: 'position_name', align: 'center' },
						{ name: 'joblevel', index: 'joblevel', align: 'center' },
						{ name: 'emptype', index: 'emptype', align: 'center' },
						{ name: 'empstatus', index: 'empstatus', align: 'center' },
				    ],
				    jsonReader: {
				        repeatitems: false,
				        id: 'USER_ID' // 서버 데이터의 primary key 필드
				    },
				    pager: '#finnqPager',
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'USER_ID',	// 기본 정렬 
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

			$(window).on('resize.nhqvList', function () {
			    jQuery("#nhqvList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			});

			$(window).on('resize.samsunglifeList', function () {
			    jQuery("#samsunglifeList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			});

			$(window).on('resize.shinhanlifeList', function () {
			    jQuery("#shinhanlifeList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			});

			$(window).on('resize.finnqList', function () {
			    jQuery("#finnqList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
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
																		<option value="kbank">K뱅크</option>
																		<option value="nhqv">NH투자증권</option>
																		<option value="btckorea">비티씨코리아닷컴</option>
																		<option value="samsunglife">삼성생명</option>
																		<option value="shinhanlife">신한생명</option>
																		<option value="finnq">핀크</option>
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
																	
																	<!------- Grid ------->
																	<div class="jqGrid_wrapper" id="nhqvId" style="display: none;">
																		<table id="nhqvList"></table>
																		<div id="nhqvPager"></div>
																	</div>
																	<!------- Grid ------->

																	<!------- Grid ------->
																	<div class="jqGrid_wrapper" id="samsunglifeId" style="display: none;">
																		<table id="samsunglifeList"></table>
																		<div id="samsunglifePager"></div>
																	</div>
																	<!------- Grid ------->

																	<!------- Grid ------->
																	<div class="jqGrid_wrapper" id="shinhanlifeId" style="display: none;">
																		<table id="shinhanlifeList"></table>
																		<div id="shinhanlifePager"></div>
																	</div>
																	<!------- Grid ------->

																	<!------- Grid ------->
																	<div class="jqGrid_wrapper" id="finnqId" style="display: none;">
																		<table id="finnqList"></table>
																		<div id="finnqPager"></div>
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
			jQuery("#nhqvList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			jQuery("#samsunglifeList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			jQuery("#shinhanlifeList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			jQuery("#finnqList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			
			
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
			} else if(empDumpCustomer == "nhqv") {
				$("#nhqvId").show();
			} else if(empDumpCustomer == "samsunglife") {
				$("#samsunglifeId").show();
			} else if(empDumpCustomer == "shinhanlife") {
				$("#shinhanlifeId").show();
			} else if(empDumpCustomer == "finnq") {
				$("#finnqId").show();
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
					} else if(data == "nhlifeOK") {
						Swal.fire(
						  'NH농협생명 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>NH농협생명은 <span style="color:red">Tibero</span>를 사용하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshNH();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "btckoreaOK") {
						Swal.fire(
						  '비티씨코리아닷컴 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>비티씨코리아닷컴은 <span style="color:red">Tibero</span>를 사용하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshNH();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					}else if(data == "kbankOK") {
						Swal.fire(
						  'K뱅크 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>K뱅크는 <span style="color:red">MySQL, MariaDB</span> 사용가능하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.<br><span style="color:red">!! K뱅크의 경우 TOSMS 20, 22 코드가 달라 전용 패키지로 재확인 필요</span>',
						  'success'
						)
						tableRefreshKbank();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "nhqvOK") {
						Swal.fire(
						  'NH투자증권 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>NH투자증권은 <span style="color:red">MSSQL</span>을 사용가능하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshNhqv();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "samsunglifeOK") {
						Swal.fire(
						  '삼성생명 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>삼성생명은 <span style="color:red">MSSQL</span>을 사용가능하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.',
						  'success'
						)
						tableRefreshSamsunglife();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "shinhanlifeOK") {
						Swal.fire(
						  '신한생명 인사정보 생성 완료!',
						  '다운로드된 파일을 설정 경로에 배치바랍니다.<br>신한생명은 <span style="color:red">DB가 아닌 파일에서 데이터를 수집합니다.</span><br>파일은 TOSMS.conf의 hrSyncPath 경로의 파일을 사용하며 값이 없을 경우 "/home/eaiftp/hr/userlist.txt" 파일을 읽어 옵니다.<br><span style="color:blue">또 한, 신한생명의 경우 INSERT는 하지않고 UPDATE만 존재합니다. 즉, 동일한 사번 동일한 부서 코드가 존재해야 수정여부 확인이 가능합니다.</span>',
						  'success'
						)
						tableRefreshShinhanlife();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "finnqOK") {
						Swal.fire(
						  '핀크 인사정보 생성 완료!',
						  '다운로드된 SQL 파일을 실행바랍니다.<br>핀크는 <span style="color:red">모든 DB 호환</span> 가능하며, jdbc.conf 파일의 HR에 JDBC 설정 정보를 입력해야 합니다.<br><span style="color:blue">다운로드된 쿼리는 MySQL 기준으로 생성된 쿼리입니다.</span>',
						  'success'
						)
						tableRefreshFinnq();
						location.href="<c:url value='/empDump/empDumpDownLoad?siteName="+empDumpCustomer+"'/>";
					} else if(data == "FALSE") {
						Swal.fire(
						  '에러!',
						  '테이블 생성 중 문제가 발생하였습니다.',
						  'error'
						)
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

		function tableRefreshNhqv() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#nhqvList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}

		function tableRefreshSamsunglife() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#samsunglifeList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}

		function tableRefreshShinhanlife() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#shinhanlifeList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}

		function tableRefreshFinnq() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#finnqList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}
		
		
	</script>
</html>