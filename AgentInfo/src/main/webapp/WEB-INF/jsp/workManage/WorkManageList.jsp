<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','workManage');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/workManage'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','패키지명','엔지니어','요청구분','요청일자','작성자','테스터','진행상태','테스트일정'],
					colModel:[
						{name:'workManageKeyNum', index:'workManageKeyNum', align:'center', width: 35, hidden:true },
						{name:'workManageCustomer', index:'workManageCustomer', align:'center', width: 200, formatter: linkFormatter},
						{name:'workManageProductName', index:'workManageProductName', align:'center', width: 400},
						{name:'workManageEngineer', index:'workManageEngineer', align:'center', width: 100},
						{name:'workManageDivision', index:'workManageDivision', align:'center', width: 100},
						{name:'workManageRequestDate', index:'workManageRequestDate', align:'center', width: 100},
						{name:'workManageAuthor', index:'workManageAuthor', align:'center', width: 100},
						{name:'workManageTester', index:'workManageTester', align:'center', width: 150},
						{name:'workManageProgressStatus', index:'workManageProgressStatus', align:'center', width: 100},
						{name:'workManageTestSchedule', index:'workManageTestSchedule', align:'center', width: 200, formatter: testScheduleFormatter},
					],
					jsonReader : {
			        	id: 'workManageKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'workManageKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '650',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#list','workManageKeyNum');
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
							                <h5 class="m-b-10">업무 관리</h5>
							                <p class="m-b-0">workManage List</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">업무 관리</a>
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
	                      							<label class="labelFontSize">요청일자</label>
	                      							<div>
														<input class="form-control" style="width: 12.5%; float: left;" type="date" id="workManageRequestDateStart" name="workManageRequestDateStart" max="9999-12-31">
														<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														<input class="form-control" style="width: 12.5%; float: left;" type="date" id="workManageRequestDateEnd" name="workManageRequestDateEnd" max="9999-12-31">
													</div>
													<div style="padding-left: 50px; float: left;">
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageRequestDate" id="toDay" value="0">
														  <label class="form-check-label" for="toDay">
														    당일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageRequestDate" id="oneWeek" value="7">
														  <label class="form-check-label" for="oneWeek">
														    1주일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageRequestDate" id="oneMonth" value="30">
														  <label class="form-check-label" for="oneMonth">
														    1개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageRequestDate" id="threeMonth" value="90">
														  <label class="form-check-label" for="threeMonth">
														    3개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageRequestDate" id="dateFull" value="full" checked>
														  <label class="form-check-label" for="dateFull">
														    전체
														  </label>
														</div>
													</div>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">고객사</label>
													<select class="form-control selectpicker" id="workManageCustomerMulti" name="workManageCustomerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageCustomer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지명</label>
													<select class="form-control selectpicker" id="workManageProductNameMulti" name="workManageProductNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageProductName}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
													<label class="labelFontSize">엔지니어</label>
													<input type="text" id="workManageEngineer" name="workManageEngineer" class="form-control">
											    </div>
												<div class="col-lg-2">
													<label class="labelFontSize">요청구분</label>
													<select class="form-control selectpicker" id="workManageDivisionMulti" name="workManageDivisionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="" selected><c:out value=""/></option>
															<option value="email">이메일</option>
															<option value="phoine">전화</option>
															<option value="visit">방문</option>
													</select>
											  </div>
												<div class="col-lg-2">
													<label class="labelFontSize">작성자</label>
													<input type="text" id="workManageAuthor" name="workManageAuthor" class="form-control">
											    </div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">테스터</label>
													<input type="text" id="workManageTester" name="workManageTester" class="form-control">
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">진행상태</label>
													<select class="form-control selectpicker" id="workManageProgressStatusMulti" name="workManageProgressStatusMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageProgressStatus}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
										
		                      					<input type="hidden" id="workManageCustomer" name="workManageCustomer" class="form-control">
		                      					<input type="hidden" id="workManageProductName" name="workManageProductName" class="form-control">
												<input type="hidden" id="workManageDivision" name="workManageDivision" class="form-control">
		                      					<input type="hidden" id="workManageProgressStatus" name="workManageProgressStatus" class="form-control">
		
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
																<td style="font-weight:bold;">작업 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnComplete">진행상태 변경</button>
																	<!-- <button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'workManageKeyNum');">컬럼 선택</button> -->
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
		/* =========== 작업 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/workManage/insertView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'workManage'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});				
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var workManageRequestDateStart = $("#workManageRequestDateStart").val();
			var workManageRequestDateEnd = $("#workManageRequestDateEnd").val();
			if(workManageRequestDateStart > workManageRequestDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일이 종료일자 보다 큽니다.',    
				});
			} else if(workManageRequestDateStart == "" && workManageRequestDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(workManageRequestDateEnd == "" && workManageRequestDateStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 종료일을 입력해주세요.',    
					});
			} else {
				tableRefresh();	
			}
			
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#workManageCustomer').val($('#workManageCustomerMulti').val().join());
			$('#workManageProductName').val($('#workManageProductNameMulti').val().join());
			$('#workManageDivision').val($('#workManageDivisionMulti').val().join());
			$('#workManageProgressStatus').val($('#workManageProgressStatusMulti').val().join());
			
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
		
		/* =========== 작업 삭제 ========= */
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
					  text: "선택한 작업를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/workManage/delete'/>",
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
							else
								Swal.fire(
								  '실패!',
								  '삭제 실패하였습니다.',
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

		
		$('#BtnComplete').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '처리완료!',
					  text: "선택한 작업를 처리완료 처리하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/workManage/complete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '처리완료 처리하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '처리완료 처리에 실패하였습니다.',
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
		})
		
		/* =========== 작업 수정 Modal ========= */
		function updateView(data) {
			location.href="<c:url value='/workManage/updateView'/>?workManageKeyNum="+data;
		}
		
		/* =========== 전달일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#workManageRequestDateStart").val("");
	        	$("#workManageRequestDateEnd").val("");
	        } else {
	        	$("#workManageRequestDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#workManageRequestDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="workManageRequestDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});

		function urlOpen(url) {
			window.open(url, '_blank');
		}

		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.workManageKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function testScheduleFormatter(cellValue, options, rowdata, action) {
			return rowdata.workManageTestScheduleStart + ' ~ ' + rowdata.workManageTestScheduleEnd;
		}
	</script>
</html>