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
	    	$.cookie('name','testCase');
	    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/testCase'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','비고','날짜'],
					colModel:[
						{name:'testCaseKeyNum', index:'testCaseKeyNum', align:'center', width: 35, hidden:true },
						{name:'testCaseCustomer', index:'testCaseCustomer', align:'center', width: 200, formatter: linkFormatter},
						{name:'testCaseNote', index:'testCaseNote', align:'center', width: 200},
						{name:'testCaseDate', index:'testCaseDate', align:'center', width: 80},
					],
					jsonReader : {
			        	id: 'testCaseKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'testCaseKeyNum',	// 기본 정렬 
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
				loadColumns('#list','testCaseKeyNum');
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
							                <h5 class="m-b-10">테스트 케이스</h5>
							                <p class="m-b-0">Test Case List</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">테스트 케이스 목록</a>
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
	                      							<label class="labelFontSize">날짜</label>
	                      							<div>
														<input class="form-control" style="width: 18.3%; float: left;" type="date" id="testCaseDateStart" name="testCaseDateStart" max="9999-12-31">
														<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														<input class="form-control" style="width: 18.3%; float: left;" type="date" id="testCaseDateEnd" name="testCaseDateEnd" max="9999-12-31">
													</div>
													<div style="padding-left: 50px; float: left;">
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="testCaseDate" id="toDay" value="0">
														  <label class="form-check-label" for="toDay">
														    당일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="testCaseDate" id="oneWeek" value="7">
														  <label class="form-check-label" for="oneWeek">
														    1주일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="testCaseDate" id="oneMonth" value="30">
														  <label class="form-check-label" for="oneMonth">
														    1개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="testCaseDate" id="threeMonth" value="90">
														  <label class="form-check-label" for="threeMonth">
														    3개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="testCaseDate" id="dateFull" value="full" checked>
														  <label class="form-check-label" for="threeMonth">
														    전체
														  </label>
														</div>
													</div>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">고객사</label>
													<select class="form-control selectpicker" id="testCaseCustomerMulti" name="testCaseCustomerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${testCaseCustomer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">비고</label>
													<select class="form-control selectpicker" id="testCaseNoteMulti" name="testCaseNoteMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${testCaseNote}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
		                      					<input type="hidden" id="testCaseCustomer" name="testCaseCustomer" class="form-control">
		                      					<input type="hidden" id="testCaseNote" name="testCaseNote" class="form-control">
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
										  <table style="width:100%">
											<tbody>
												<tr>
													<td style="font-weight:bold;">테스트 케이스 타입 :
														<sec:authorize access="hasAnyRole('ADMIN','QA')">
															<button class="btn btn-outline-info-add myBtn" id="BtnInsertType">추가</button>
															<button class="btn btn-outline-info-del myBtn" id="BtnDelectType">삭제</button>
															<button class="btn btn-outline-info-nomal myBtn" id="BtnUpdateType">수정</button>
														</sec:authorize>
													</td>
												</tr>
											</tbody>
										</table>
	                     				 <div class="ibox">
	                     				 	<div class="searchbos" id="testCaseFormDiv">
												<input type="hidden" id="selectTestCaseFormName" value="TOSMS" class="form-control">
												<c:forEach var="testCaseForm" items="${testCaseFormList}">
													<button type="button" class='btn btn-primary formBtn' id="${testCaseForm}" style="box-shadow: 0px 3px 3px grey;" onClick="btnTestCaseForm(this)">${testCaseForm}</button>
												</c:forEach>
	                     				 	</div>
	                     				 </div>
			                           	 <table style="width:99%;">
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
															<tbody>
																<tr>
																	<td style="font-weight:bold;">테스트 케이스 관리 :
																		<sec:authorize access="hasAnyRole('ADMIN','QA')">
																			<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																			<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		</sec:authorize>
																		<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'testCaseKeyNum');">컬럼 선택</button>
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
												</tr>
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
		/* =========== 테스트 케이스 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			location.href="<c:url value='/testCase/view'/>";		
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var testCaseDateStart = $("#testCaseDateStart").val();
			var testCaseDateEnd = $("#testCaseDateEnd").val();
			if(testCaseDateStart > testCaseDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일이 종료일자 보다 큽니다.',    
				});
			} else if(testCaseDateStart == "" && testCaseDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(testCaseDateEnd == "" && testCaseDateStart != "") {
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
			$('#testCaseCustomer').val($('#testCaseCustomerMulti').val().join());
			$('#testCaseNote').val($('#testCaseNoteMulti').val().join());
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.testCaseKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
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
		
		/* =========== 테스트 케이스 삭제 ========= */
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
					  text: "선택한 테스트 케이스를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/testCase/delete'/>",
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
		
		
		/* =========== 테스트 케이스 수정 Modal ========= */
		function updateView(data) {
			location.href="<c:url value='/testCase/updateView'/>?testCaseKeyNum="+data;
		}
		
		/* =========== 전달일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#testCaseDateStart").val("");
	        	$("#testCaseDateEnd").val("");
	        } else {
	        	$("#testCaseDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#testCaseDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="testCaseDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
	</script>

	<script>
		/* =========== 테스트 케이스 추가 Modal ========= */
		$('#BtnInsertType').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/testCase/insertFormView'/>",
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'testCaseForm'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});
		});

		function btnTestCaseForm(obj) {
			var testCaseFormName = $(obj).text();
			$('#selectTestCaseFormName').val(testCaseFormName);
		}
		
		$('#BtnDelectType').click(function() {
			var testCaseFormName = $('#selectTestCaseFormName').val();
			if(testCaseFormName==='TOSMS') {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: 'TOSMS는 삭제가 불가능 합니다.',
				});
				return false;
			}
			Swal.fire({
				  title: '삭제!',
				  text: "제품("+testCaseFormName+")을 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
					    type: 'POST',
					    url: "<c:url value='/testCase/delTestCaseForm'/>",
					    async: false,
						data: { "testCaseFormName":testCaseFormName },
					    success: function (result) {
							if(result == "OK") {
								Swal.fire({
									icon: 'success',
									title: '삭제!',
									text: '삭제을 완료했습니다.',
								});
								$('#'+testCaseFormName).remove();
							} else {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '작업을 실패하였습니다.',
								});
							}
					    },
					    error: function(e) {
					        alert(e);
					    }
					});
				}
			});	
		});	

		$('#BtnUpdateType').click(function() {
			var testCaseFormName = $('#selectTestCaseFormName').val();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/testCase/updateFormView'/>",
				data: {"testCaseFormName":testCaseFormName},
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'testCaseForm'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});
		});

	</script>
	
	<style>
		.formBtn {
			width: auto;
    		min-width: 140px;
		    font-weight: bold;
		    font-size: 14px;
		    height: 55px;
			margin: 5px;
		}
	</style>
</html>