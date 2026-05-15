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
				$('#workManageProceStatus').val($('#workManageProceStatusMulti').val().join());
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/workManage'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','담당자','작성자','테스터','요청일자','요청구분','제품종류','진행상태','테스트일정'],
					colModel:[
						{name:'workManageKeyNum', index:'workManageKeyNum', align:'center', width: 35, hidden:true },
						{name:'workManageCustomer', index:'workManageCustomer', align:'center', width: 200, formatter: linkFormatter},
						{name:'workManageTitle', index:'workManageTitle', align:'center', width: 200},
						{name:'workManageTarget', index:'workManageTarget', align:'center', width: 80},
						{name:'workManageSubTarget', index:'workManageSubTarget', align:'center', width: 150, formatter: subTargetFormatter},
						{name:'workManageFirstWriter', index:'workManageFirstWriter', align:'center', width: 80},
						{name:'workManageTester', index:'workManageTester', align:'center', width: 120},
						{name:'workManageFirstDate', index:'workManageFirstDate', align:'center', width: 80},
						{name:'workManageDate', index:'workManageDate', align:'center', width: 80},
						{name:'workManageProceStatus', index:'workManageProceStatus', align:'center', width: 80, formatter: stateFormatter},
						{name:'workManageManagerServerStatus', index:'workManageManagerServerStatus', align:'center', width: 100, formatter: managerStateFormatter},
						{name:'total', index:'total', align:'center', width: 50},
						{name:'solution', index:'solution', align:'center', width: 50},
						{name:'unresolved', index:'unresolved', align:'center', width: 50},
						{name:'hold', index:'hold', align:'center', width: 50},
						{name:'workManageTosms', index:'workManageTosms', align:'center', width: 200},
						{name:'workManageTosrf', index:'workManageTosrf',align:'center', width: 200},
						{name:'workManagePortal', index:'workManagePortal',align:'center', width: 200},
						{name:'workManageJava', index:'workManageJava', align:'center', width: 200},
						{name:'workManageWas', index:'workManageWas', align:'center', width: 200},
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
														<input class="form-control" style="width: 12.5%; float: left;" type="date" id="workManageDateStart" name="workManageDateStart" max="9999-12-31">
														<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														<input class="form-control" style="width: 12.5%; float: left;" type="date" id="workManageDateEnd" name="workManageDateEnd" max="9999-12-31">
													</div>
													<div style="padding-left: 50px; float: left;">
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageDate" id="toDay" value="0">
														  <label class="form-check-label" for="toDay">
														    당일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageDate" id="oneWeek" value="7">
														  <label class="form-check-label" for="oneWeek">
														    1주일
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageDate" id="oneMonth" value="30">
														  <label class="form-check-label" for="oneMonth">
														    1개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageDate" id="threeMonth" value="90">
														  <label class="form-check-label" for="threeMonth">
														    3개월
														  </label>
														</div>
														<div class="form-check radioDate">
														  <input class="form-check-input" type="radio" name="workManageDate" id="dateFull" value="full" checked>
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
	                      							<label class="labelFontSize">Title</label>
													<select class="form-control selectpicker" id="workManageTitleMulti" name="workManageTitleMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageTitle}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
													<label class="labelFontSize">Target</label>
												  <select class="form-control selectpicker" id="workManageTarget" name="workManageTarget" data-live-search="true" data-size="5" data-actions-box="true">
														<option value=""></option>
														<option value="TOSMS">TOSMS</option>
														<option value="Agent">Agent</option>
														<option value="기타">기타</option>
												  </select>
											    </div>
												<div class="col-lg-2">
													<label class="labelFontSize">작성자</label>
												  <select class="form-control selectpicker" id="workManageFirstWriterMulti" name="workManageFirstWriterMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
													  <c:forEach var="item" items="${workManageFirstWriter}">
														  <option value="${item}"><c:out value="${item}"/></option>
													  </c:forEach>
												  </select>
											    </div>
												<div class="col-lg-2">
													<label class="labelFontSize">진행 상태</label>
													<select class="form-control selectpicker" id="workManageProceStatusMulti" name="workManageProceStatusMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<!-- <option value=""><c:out value=""/></option> -->
															<option value="progress" selected>진행 중</option>
															<option value="request" selected>처리 완료 요청</option>
															<option value="complete">처리 완료</option>
													</select>
											  </div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">TOSMS</label>
													<select class="form-control selectpicker" id="workManageTosmsMulti" name="workManageTosmsMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageTosms}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">TOSRF</label>
													<select class="form-control selectpicker" id="workManageTosrfMulti" name="workManageTosrfMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageTosrf}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">PORTAL</label>
													<select class="form-control selectpicker" id="workManagePortalMulti" name="workManagePortalMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManagePortal}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">JAVA</label>
													<select class="form-control selectpicker" id="workManageJavaMulti" name="workManageJavaMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageJava}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">WAS</label>
													<select class="form-control selectpicker" id="workManageWasMulti" name="workManageWasMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${workManageWas}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">내용</label>
	                      							<input type="text" id="workManageObstacle" name="workManageObstacle" class="form-control">
	                      						</div>
		                      					<input type="hidden" id="workManageCustomer" name="workManageCustomer" class="form-control">
		                      					<input type="hidden" id="workManageTitle" name="workManageTitle" class="form-control">
												<input type="hidden" id="workManageFirstWriter" name="workManageFirstWriter" class="form-control">
												<input type="hidden" id="workManageProceStatus" name="workManageProceStatus" class="form-control">
		                      					<input type="hidden" id="workManageTosms" name="workManageTosms" class="form-control">
		                      					<input type="hidden" id="workManageTosrf" name="workManageTosrf" class="form-control">
		                      					<input type="hidden" id="workManagePortal" name="workManagePortal" class="form-control">
		                      					<input type="hidden" id="workManageJava" name="workManageJava" class="form-control">
		                      					<input type="hidden" id="workManageWas" name="workManageWas" class="form-control">
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
																<td style="font-weight:bold;">이슈 관리 :
																	<sec:authorize access="hasAnyRole('ADMIN','QA')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		<!-- <button class="btn btn-outline-info-nomal myBtn" id="BtnCopy">복사</button> -->
																		<!-- <button class="btn btn-outline-info-nomal myBtn" id="BtnMerge">병합</button> -->
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnComplete">처리완료</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'workManageKeyNum');">컬럼 선택</button>
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
		/* =========== 이슈 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			location.href="<c:url value='/workManage/workManageWrite'/>";		
		});
		
		/* =========== 이슈 병합 ========= */
		$('#BtnMerge').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList.length > 1 && chkList.length < 4) {
				$.ajax({
					url: "<c:url value='/workManage/merge'/>",
					type: "POST",
					data: {chkList: chkList},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						if(data == "OK")
							Swal.fire(
							  '성공!',
							  '병합 완료하였습니다.',
							  'success'
							)
						else if(data == "NotMatch")
							Swal.fire(
							  '불일치!',
							  '고객사, Title, 전달일자, TOSMS, TOSRF, PORTAL, JAVA, WAS 정보가 일치해야합니다.',
							  'error'
							)
						else
							Swal.fire(
							  '실패!',
							  '별합 실패하였습니다.',
							  'error'
							)
						tableRefresh();
					},
					error: function(error) {
						console.log(error);
					}
				});
				tableRefresh();
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '제한!',           
					text: '병합 가능한 갯수는 3개 이내로 제한합니다.',    
				});
			}
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var workManageDateStart = $("#workManageDateStart").val();
			var workManageDateEnd = $("#workManageDateEnd").val();
			if(workManageDateStart > workManageDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일이 종료일자 보다 큽니다.',    
				});
			} else if(workManageDateStart == "" && workManageDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(workManageDateEnd == "" && workManageDateStart != "") {
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
			$('#workManageTitle').val($('#workManageTitleMulti').val().join());
			$('#workManageFirstWriter').val($('#workManageFirstWriterMulti').val().join());
			$('#workManageProceStatus').val($('#workManageProceStatusMulti').val().join());
			$('#workManageTosms').val($('#workManageTosmsMulti').val().join());
			$('#workManageTosrf').val($('#workManageTosrfMulti').val().join());
			$('#workManagePortal').val($('#workManagePortalMulti').val().join());
			$('#workManageJava').val($('#workManageJavaMulti').val().join());
			$('#workManageWas').val($('#workManageWasMulti').val().join());
			
			
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
			$('#workManageProceStatusMulti').val(['progress','request']);
			$('#workManageProceStatusMulti').selectpicker('refresh');
			
			tableRefresh();
		});
		
		/* =========== 이슈 삭제 ========= */
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
					  text: "선택한 이슈를 삭제하시겠습니까?",
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
					  text: "선택한 이슈를 처리완료 처리하시겠습니까?",
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
		
		/* =========== 데이터 복사 Modal ========= */
		$('#BtnCopy').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var workManageKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				location.href="<c:url value='/workManage/copyView'/>?workManageKeyNum="+workManageKeyNum;
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '복사를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});
		
		/* =========== 이슈 수정 Modal ========= */
		function updateView(data) {
			location.href="<c:url value='/workManage/updateView'/>?workManageKeyNum="+data;
		}
		
		/* =========== 전달일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#workManageDateStart").val("");
	        	$("#workManageDateEnd").val("");
	        } else {
	        	$("#workManageDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#workManageDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="workManageDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});

		function urlOpen(url) {
			window.open(url, '_blank');
		}

	</script>

	<sec:authorize access="hasAnyRole('ADMIN','QA')">
	<script>
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.workManageKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
	</script>
	</sec:authorize>
	<sec:authorize access="hasRole('UI')">
		<script>
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return cellValue;
		}

		$(function() {
		    $("#workManageTarget").selectpicker("val", "TOSMS");
				
		    setTimeout(function(){
		        tableRefresh();
		    }, 50);
		});
	</script>
	</sec:authorize>
</html>