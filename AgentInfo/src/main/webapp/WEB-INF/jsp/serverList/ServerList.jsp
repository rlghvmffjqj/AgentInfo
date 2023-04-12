<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	if("${serverListType}" == "externalEquipment") {
			    	$.cookie('name','externalEquipment');
		    	} else if("${serverListType}" == "internalEquipment") {
		    		$.cookie('name','internalEquipment');
		    	} else if("${serverListType}" == "hyperV") {
		    		$.cookie('name','hyperV');
		    	}
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/serverList'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','구분','IP','상태','MAC','자산번호','HostName','용도','운영체제','서버구분','랙 위치','사용기간','사용자','관리자','최종 수정일','비고'],
					colModel:[
						{name:'serverListKeyNum', index:'serverListKeyNum', align:'center', width: 35, hidden:true },
						{name:'serverListDivision', index:'serverListDivision', align:'center', width: 80},
						{name:'serverListIp', index:'serverListIp', align:'center', width: 100},
						{name:'serverListState', index:'serverListState', align:'center', width: 70, formatter: stateFormatter},
						{name:'serverListMac', index:'serverListMac', align:'center', width: 110},
						{name:'serverListAssetNum', index:'serverListAssetNum', align:'center', width: 180, formatter: linkFormatter},
						{name:'serverListHostName', index:'serverListHostName',align:'center', width: 110},
						{name:'serverListPurpose', index:'serverListPurpose',align:'center', width: 150},
						{name:'serverListOs', index:'serverListOs', align:'center', width: 150},
						{name:'serverListServerClass', index:'serverListServerClass', align:'center', width: 80},
						{name:'serverListRackPosition', index:'serverListRackPosition', align:'center', width: 50},
						{name:'serverListPeriodUse', index:'serverListPeriodUse', align:'center', width: 130},
						{name:'serverListUser', index:'serverListUser', align:'center', width: 80},
						{name:'serverListManager', index:'serverListManager', align:'center', width: 80},
						{name:'serverListLastModifiedDate', index:'serverListLastModifiedDate', align:'center', width: 80},
						{name:'serverListNote', index:'serverListNote', align:'center', width: 300},
					],
					jsonReader : {
			        	id: 'serverListKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'serverListKeyNum',	// 기본 정렬 
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
				loadColumns('#list','serverList');
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
		                      							<label class="labelFontSize">구분</label>
														<select class="form-control selectpicker" id="serverListDivisionMulti" name="serverListDivisionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="Linux">Linux</option>
															<option value="Windows">Windows</option>
															<option value="AIX">AIX</option>
															<option value="HP-UX">HP-UX</option>
															<option value="Solaris">Solaris</option>
															<option value="기타">기타</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">IP</label>
														<select class="form-control selectpicker" id="serverListIpMulti" name="serverListIpMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListIp}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">상태</label>
														<select class="form-control selectpicker" id="serverListStateMulti" name="serverListStateMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="정상작동">정상작동</option>
															<option value="접속불가">접속불가</option>
															<option value="업데이트">업데이트</option>
															<option value="외부반출">외부반출</option>
															<option value="장비대여">장비대여</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC</label>
														<select class="form-control selectpicker" id="serverListMacMulti" name="serverListMacMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListMac}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">자산번호</label>
														<select class="form-control selectpicker" id="serverListAssetNumMulti" name="serverListAssetNumMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListAssetNum}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">HostName</label>
														<select class="form-control selectpicker" id="serverListHostNameMulti" name="serverListHostNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListHostName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">용도</label>
														<select class="form-control selectpicker" id="serverListPurposeMulti" name="serverListPurposeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListPurpose}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">운영체제</label>
														<select class="form-control selectpicker" id="serverListOsMulti" name="serverListOsMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListOs}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">서버구분</label>
														<select class="form-control selectpicker" id="serverListServerClassMulti" name="serverListServerClassMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serverListServerClass}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">랙 위치</label>
														<select class="form-control selectpicker" id="serverListRackPositionMulti" name="serverListRackPositionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:if test="${serverListType eq 'externalEquipment'}">
																<option value="P1">P1</option>
																<option value="Q1">Q1</option>
																<option value="Q2">Q2</option>
																<option value="Q3">Q3</option>
																<option value="Q4">Q4</option>
																<option value="W1">W1</option>
																<option value="S1">S1</option>
															</c:if>
															<c:if test="${serverListType eq 'internalEquipment'}">
																<option value="D1">D1</option>
																<option value="D2">D2</option>
																<option value="D3">D3</option>
																<option value="D4">D4</option>
																<option value="D5">D5</option>
																<option value="D6">D6</option>
																<option value="D7">D7</option>
																<option value="D8">D8</option>
																<option value="D9">D9</option>
																<option value="D10">D10</option>
																<option value="D11">D11</option>
																<option value="Q1">Q1</option>
															</c:if>
															<c:if test="${serverListType eq 'hyperV'}">
																<option value="#90">#90</option>
																<option value="#160">#160</option>
																<option value="#210">#210</option>
															</c:if>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사용 기간</label>
		                      							<input type="date" id="serverListPeriodUseEnd" name="serverListPeriodUseEnd" class="form-control" max="9999-12-31">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자</label>
		                      							<input type="text" id="serverListUser" name="serverListUser" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">관리자</label>
		                      							<input type="text" id="serverListManager" name="serverListManager" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">최종 수정일</label>
		                      							<input type="date" id="serverListLastModifiedDate" name="serverListLastModifiedDate" class="form-control" max="9999-12-31">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">비고</label>
		                      							<input type="text" id="serverListNote" name="serverListNote" class="form-control">
		                      						</div>
		                      						<input type="hidden" id="serverListDivision" name="serverListDivision" class="form-control">
		                      						<input type="hidden" id="serverListIp" name="serverListIp" class="form-control">
		                      						<input type="hidden" id="serverListState" name="serverListState" class="form-control">
		                      						<input type="hidden" id="serverListMac" name="serverListMac" class="form-control">
		                      						<input type="hidden" id="serverListAssetNum" name="serverListAssetNum" class="form-control">
		                      						<input type="hidden" id="serverListHostName" name="serverListHostName" class="form-control">
		                      						<input type="hidden" id="serverListPurpose" name="serverListPurpose" class="form-control">
		                      						<input type="hidden" id="serverListOs" name="serverListOs" class="form-control">
		                      						<input type="hidden" id="serverListServerClass" name="serverListServerClass" class="form-control">
		                      						<input type="hidden" id="serverListRackPosition" name="serverListRackPosition" class="form-control">
		                      						<input type="hidden" id="serverListType" name="serverListType" class="form-control" value="${serverListType}">
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
																<td style="font-weight:bold;">서버 관리 :
																	<sec:authorize access="hasAnyRole('ADMIN','QA')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnState" onClick="btnState()">상태 변경</button>
																		<button class="btn btn-outline-info-nomal myBtn" onClick="doExportExec()">Excel 내보내기</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'serverList');">컬럼 선택</button>
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
		/* =========== 서버목록 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/serverList/insertView'/>",
			    data: {"serverListType": "${serverListType}"},
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'll'); //modal창 호출
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
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#serverListDivision').val($('#serverListDivisionMulti').val().join());
			$('#serverListIp').val($('#serverListIpMulti').val().join());
			$('#serverListState').val($('#serverListStateMulti').val().join());
			$('#serverListMac').val($('#serverListMacMulti').val().join());
			$('#serverListAssetNum').val($('#serverListAssetNumMulti').val().join());
			$('#serverListHostName').val($('#serverListHostNameMulti').val().join());
			$('#serverListPurpose').val($('#serverListPurposeMulti').val().join());
			$('#serverListOs').val($('#serverListOsMulti').val().join());
			$('#serverListServerClass').val($('#serverListServerClassMulti').val().join());
			$('#serverListRackPosition').val($('#serverListRackPositionMulti').val().join());
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.serverListKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function stateFormatter(value, options, row) {
			var state = row.serverListState.toUpperCase();
			if(state == "정상작동") {
				return '<div><img src="/AgentInfo/images/serverListOk.png" style="width:50px;"></div';
			} else if(state == "접속불가") {
				return '<div><img src="/AgentInfo/images/serverListFail.png" style="width:50px;"></div';
			} else if(state == "외부반출") {
				return '<div><img src="/AgentInfo/images/serverListOut.png" style="width:50px;"></div';
			} else if(state == "업데이트") {
				return '<div><img src="/AgentInfo/images/serverListUpdate.png" style="width:50px;"></div';
			} else if(state == "장비대여") {
				return '<div><img src="/AgentInfo/images/serverListRental.png" style="width:50px;"></div';
			}
			return '<div></div>';
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
		
		/* =========== 서버목록 삭제 ========= */
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
					  text: "선택한 패키지를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/serverList/delete'/>",
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
		
		/* =========== 서버목록 수정 Modal ========= */
		function updateView(data) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/serverList/updateView'/>",
		        data: {"serverListKeyNum" : data},
		        async: false,
		        success: function (data) {
		        	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
		            $.modal(data, 'll'); //modal창 호출
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		}
		
		/* =========== 상태 변경 ========= */
		function btnState() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/serverList/stateView'/>",
		            async: false,
		            success: function (data) {
		            	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
		                $.modal(data, 'rs'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			}
		}
		
	</script>
</html>