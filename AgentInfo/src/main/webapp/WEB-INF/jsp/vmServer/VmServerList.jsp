<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','vmServer');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/vmServer'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','호스트서버','VM서버명','VM서버 메모리','VM서버 동작시간','VM서버 상태'],
					colModel:[
						{name:'vmServerKeyNum', index:'vmServerKeyNum', align:'center', width: 35, hidden:true },
						{name:'vmServerHostName', index:'vmServerHostName', align:'center', width: 180},
						{name:'vmServerName', index:'vmServerName', align:'left', width: 700},
						{name:'vmServerMemory', index:'vmServerMemory', align:'right', width: 100},
						{name:'vmServerTime', index:'vmServerTime', align:'center', width: 150},
						{name:'vmServerStatus', index:'vmServerStatus', align:'center', width: 150},
					],
					jsonReader : {
			        	id: 'vmServerKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
					rowList: [25, 50, 100, 255],
			        sortname: 'vmServerName',	// 기본 정렬 
			        sortorder: 'asc',			// 정렬 방식
			        
			        //multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#list','vmServer');
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
									            <h5 class="m-b-10">서버 목록</h5>
									            <p class="m-b-0">Server List</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">서버 목록</a>
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
		                      							<label class="labelFontSize">호스트서버</label>
														<select class="form-control selectpicker" id="vmServerHostNameMulti" name="vmServerHostNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${vmServerHostName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">vm서버명</label>
														<select class="form-control selectpicker" id="vmServerNameMulti" name="vmServerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${vmServerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">vm서버 상태</label>
														<select class="form-control selectpicker" id="vmServerStatusMulti" name="vmServerStatusMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${vmServerStatus}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
										
		                      						<input type="hidden" id="vmServerHostName" name="vmServerHostName" class="form-control">
		                      						<input type="hidden" id="vmServerName" name="vmServerName" class="form-control">
		                      						<input type="hidden" id="vmServerStatus" name="vmServerStatus" class="form-control">
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
															    <td>
																
															        <div class="work-toolbar">
																	
															            <div class="toolbar-title">🖥 서버 관리</div>
																	
															            <sec:authorize access="hasAnyRole('ADMIN','QA')">
																	
															                <!-- 기본 작업 -->
															                <div class="toolbar-group">
															                    <div class="group-label">기본 작업</div>
																			
															                    <button class="btn2 btn-primary myBtn" id="BtnInsert">➕ 호스트 추가</button>
															                    <button class="btn2 btn-danger myBtn" id="BtnDelect">🗑 호스트 삭제</button>
															                </div>
																		
															                <!-- 서버 -->
															                <div class="toolbar-group">
															                    <div class="group-label">서버</div>
																			
															                    <button class="btn2 btn-warning myBtn" id="BtnSynchronization">🔄 동기화</button>
															                </div>
																		
															                <!-- 데이터 -->
															                <div class="toolbar-group">
															                    <div class="group-label">데이터</div>
																			
															                    <button class="btn2 btn-light2 myBtn" onclick="doExportExec()">📤 Excel 내보내기</button>
															                </div>
																		
															            </sec:authorize>
																	
															            <!-- 공통 -->
															            <div class="toolbar-group">
															                <div class="group-label">설정</div>
																		
															                <button class="btn2 btn-light2 myBtn" onclick="selectColumns('#list', 'vmServer');">⚙ 컬럼 선택</button>
															            </div>
																	
															        </div>
																
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
		<div id="loadingDiv" style="display:none;">
			<div id="loadingImgDiv">
				<img id="loadingImage" src="/AgentInfo/images/secuve_loading.gif" alt="Loading..." />
			</div>
		</div>
	</body>
	
	<script>
		/* =========== 호스트 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/vmServer/insertView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'ssl'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();	
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			//setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
		
			$('#vmServerHostName').val($('#vmServerHostNameMulti').val().join());
			$('#vmServerName').val($('#vmServerNameMulti').val().join());
			$('#vmServerStatus').val($('#vmServerStatusMulti').val().join());
			
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
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
	        
	        $('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
			
			tableRefresh();
		});
		
		/* =========== 호스트 삭제 ========= */
		$('#BtnDelect').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/vmServer/deleteView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'ssl'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});	
		});

		$('#BtnSynchronization').click(function() {
			showLoadingImage();
			$.ajax({
				url: "<c:url value='/vmServer/synchronization'/>",
			    type: 'post',
			    traditional: true,
			    success: function(result) {
					hideLoadingImage();
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '동기화 완료했습니다.',
						});
			    		tableRefresh();
					} else {
						hideLoadingImage();
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '작업을 실패하였습니다.',
						});
					}
				},
				error: function(error) {
					hideLoadingImage();
					console.log(error);
				}
			});
		});

		// 로딩 이미지를 보여주는 함수
		function showLoadingImage() {
		    $('#loadingDiv').show();
		}
	
		// 로딩 이미지를 숨기는 함수
		function hideLoadingImage() {
		    $('#loadingDiv').hide();
		}
	</script>
	<style>
		#loadingDiv {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0, 0, 0, 0.5); /* 반투명한 검은 배경 */
			justify-content: center;
			align-items: center;
			z-index: 9999; /* 다른 요소 위에 표시되도록 함 */
		}
	
		#loadingImage {
			width: 50px; /* 로딩 이미지의 너비 */
			height: 50px; /* 로딩 이미지의 높이 */
			background: url('secuve_loading.gif') no-repeat center center; /* 로딩 이미지 설정 */
			background-size: cover;
		}
		#loadingImgDiv {
			width: 100%;
			height: 100%;
			top: 50%;
			left: 50%;
			position: absolute;
		}
	</style>
	<style>
		.work-toolbar{
		    display:flex;
		    align-items:center;
		    gap:15px;
		    flex-wrap:wrap;
		
		    padding:5px;
		    background:#fafafa;
		    border:1px solid #e5e7eb;
		    border-radius:12px;
		}

		.toolbar-title{
		    font-size:18px;
		    font-weight:700;
		    color:#111827;
		    margin-right:10px;
		}

		.toolbar-group{
		    display:flex;
		    align-items:center;
		    gap:8px;
		
		    padding:10px 15px;
		
		    background:#fff;
		    border:1px solid #e5e7eb;
		    border-radius:10px;
		
		    box-shadow:0 1px 3px rgba(0,0,0,0.05);
		}

		.group-label{
		    font-size:12px;
		    color:#6b7280;
		    font-weight:600;
		    margin-right:5px;
		    white-space:nowrap;
		}

		.work-toolbar .btn2{
		    border-radius:8px !important;
		    font-size:12px !important;
		    font-weight:600 !important;
		    padding:6px 12px;
		    border:none;
		    transition:all 0.2s ease;
		}

		.work-toolbar .btn2:hover{
		    transform:translateY(-1px);
		}

		/* 추가 */
		.btn-primary{
		    background:#2563eb !important;
		    color:#fff !important;
		}

		/* 삭제 */
		.btn-danger{
		    background:#dc2626 !important;
		    color:#fff !important;
		}

		/* 처리완료 */
		.btn-success{
		    background:#22c55e !important;
		    color:#fff !important;
		}

		/* 상태변경 */
		.btn-warning{
		    background:#f59e0b !important;
		    color:#fff !important;
		}

		/* 국내/국외 이동 */
		.btn-info{
		    background:#0891b2 !important;
		    color:#fff !important;
		}

		/* 일반 버튼 */
		.btn-light2{
		    background:#ffffff !important;
		    color:#374151 !important;
		    border:1px solid #d1d5db !important;
		}

		/* 복사 */
		.btn-copy{
		    background:#8b5cf6 !important;
		    color:#fff !important;
		}

		/* 자동화 */
		.btn-automation{
		    background:#6366f1 !important;
		    color:#fff !important;
		}

		/* 보고서 조회 */
		.btn-report{
		    background:#10b981 !important;
		    color:#fff !important;
		}

		/* 템플릿 */
		.btn-template{
		    background:#f59e0b !important;
		    color:#fff !important;
		}

		/* 삭제 보고서 */
		.btn-delete-report{
		    background:#ef4444 !important;
		    color:#fff !important;
		}

		/* 국내/국외 이동 */
		.btn-move{
		    background:#0ea5e9 !important;
		    color:#fff !important;
		}

		.btn-primary:hover{
		    background:#1d4ed8 !important;
		}

		.btn-danger:hover{
		    background:#b91c1c !important;
		}

		.btn-success:hover{
		    background:#16a34a !important;
		}

		.btn-warning:hover{
		    background:#d97706 !important;
		}

		.btn-copy:hover{
		    background:#7c3aed !important;
		}

		.btn-automation:hover{
		    background:#4f46e5 !important;
		}

		.btn-report:hover{
		    background:#059669 !important;
		}

		.btn-template:hover{
		    background:#d97706 !important;
		}

		.btn-delete-report:hover{
		    background:#dc2626 !important;
		}

		.btn-move:hover{
		    background:#0284c7 !important;
		}
	</style>
</html>