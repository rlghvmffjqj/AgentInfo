<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/issueRelay'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','Title','테스터','전달일자','진행상태','TOSMS','TOSRF','PORTAL','JAVA','WAS'],
					colModel:[
						{name:'issueKeyNum', index:'issueKeyNum', align:'center', width: 35, hidden:true },
						{name:'issueCustomer', index:'issueCustomer', align:'center', width: 200, formatter: linkFormatter},
						{name:'issueTitle', index:'issueTitle', align:'center', width: 200},
						{name:'issueTester', index:'issueTester', align:'center', width: 120},
						{name:'issueDate', index:'issueDate', align:'center', width: 80},
						{name:'issueProceStatus', index:'issueProceStatus', align:'center', width: 80, formatter: stateFormatter},
						{name:'issueTosms', index:'issueTosms', align:'center', width: 300},
						{name:'issueTosrf', index:'issueTosrf',align:'center', width: 200},
						{name:'issuePortal', index:'issuePortal',align:'center', width: 200},
						{name:'issueJava', index:'issueJava', align:'center', width: 200},
						{name:'issueWas', index:'issueWas', align:'center', width: 200},
					],
					jsonReader : {
			        	id: 'issueKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'issueKeyNum',	// 기본 정렬 
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
				loadColumns('#list','issueKeyNum');
			});
			
			$(window).on('resize.list', function () {
			    jQuery("#list").jqGrid( 'setGridWidth', $(".pcoded-main-container").width() );
			});
		</script>
	</head>
	<body>
	
	<div id="pcoded" class="pcoded iscollapsed">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
			<div style="text-align: center; background: #cfa875cc; height: 60px; padding-top: 1.5vh; font-family: math;">
				<h3 style="color: white;">QA 이슈 목록</h3>
			</div>
			<div class="pcoded-main-container" style="margin-top: 56px;">
				<div class="pcoded-wrapper">
                    <div class="main-body">
                        <div class="ibox">
	                    	<div class="searchbos">
	                    		<form id="form" name="form" method ="post">
									<div style="padding-left:15px; width:100%; float: left;">
										<label class="labelFontSize">전달일자</label>
										<div>
										  <input class="form-control" style="width: 14.9%; float: left;" type="date" id="issueDateStart" name="issueDateStart" max="9999-12-31">
										  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
										  <input class="form-control" style="width: 14.9%; float: left;" type="date" id="issueDateEnd" name="issueDateEnd" max="9999-12-31">
									  </div>
									  <div style="padding-left: 50px; float: left;">
										  <div class="form-check radioDate">
											<input class="form-check-input" type="radio" name="issueDate" id="toDay" value="0">
											<label class="form-check-label" for="toDay">
											  당일
											</label>
										  </div>
										  <div class="form-check radioDate">
											<input class="form-check-input" type="radio" name="issueDate" id="oneWeek" value="7">
											<label class="form-check-label" for="oneWeek">
											  1주일
											</label>
										  </div>
										  <div class="form-check radioDate">
											<input class="form-check-input" type="radio" name="issueDate" id="oneMonth" value="30">
											<label class="form-check-label" for="oneMonth">
											  1개월
											</label>
										  </div>
										  <div class="form-check radioDate">
											<input class="form-check-input" type="radio" name="issueDate" id="threeMonth" value="90">
											<label class="form-check-label" for="threeMonth">
											  3개월
											</label>
										  </div>
										  <div class="form-check radioDate">
											<input class="form-check-input" type="radio" name="issueDate" id="dateFull" value="full" checked>
											<label class="form-check-label" for="threeMonth">
											  전체
											</label>
										  </div>
									  </div>
									</div>
	              					<div class="col-lg-2">
	              						<label class="labelFontSize">고객사</label>
										<select class="form-control selectpicker" id="issueCustomerMulti" name="issueCustomerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issueCustomer}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-2">
	              						<label class="labelFontSize">Title</label>
										<select class="form-control selectpicker" id="issueTitleMulti" name="issueTitleMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issueTitle}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-2">
										<label class="labelFontSize">진행 상태</label>
									  <select class="form-control selectpicker" id="issueProceStatusMulti" name="issueProceStatusMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<option value="progress" selected>진행 중</option>
											<option value="request">처리 완료 요청</option>
											<option value="complete">처리 완료</option>
									  </select>
								  </div>
									<div class="col-lg-2">
	              						<label class="labelFontSize">TOSMS</label>
										<select class="form-control selectpicker" id="issueTosmsMulti" name="issueTosmsMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issueTosms}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-2">
	              						<label class="labelFontSize">TOSRF</label>
										<select class="form-control selectpicker" id="issueTosrfMulti" name="issueTosrfMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issueTosrf}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-2">
	              						<label class="labelFontSize">PORTAL</label>
										<select class="form-control selectpicker" id="issuePortalMulti" name="issuePortalMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issuePortal}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-2">
	              						<label class="labelFontSize">JAVA</label>
										<select class="form-control selectpicker" id="issueJavaMulti" name="issueJavaMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issueJava}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-2">
	              						<label class="labelFontSize">WAS</label>
										<select class="form-control selectpicker" id="issueWasMulti" name="issueWasMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
											<c:forEach var="item" items="${issueWas}">
												<option value="${item}"><c:out value="${item}"/></option>
											</c:forEach>
										</select>
									</div>
		              				<input type="hidden" id="issueCustomer" name="issueCustomer" class="form-control">
									<input type="hidden" id="issueTarget" name="issueTarget" class="form-control" value="${issueTarget}">
									<input type="hidden" id="issueSubTarget" name="issueSubTarget" class="form-control" value="${issueSubTarget}">
		              				<input type="hidden" id="issueTitle" name="issueTitle" class="form-control">
									  <input type="hidden" id="issueProceStatus" name="issueProceStatus" class="form-control">
		              				<input type="hidden" id="issueTosms" name="issueTosms" class="form-control">
		              				<input type="hidden" id="issueTosrf" name="issueTosrf" class="form-control">
		              				<input type="hidden" id="issuePortal" name="issuePortal" class="form-control">
		              				<input type="hidden" id="issueJava" name="issueJava" class="form-control">
		              				<input type="hidden" id="issueWas" name="issueWas" class="form-control">
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
														<button class="btn btn-outline-info-add myBtn" id="BtnCompleteRequest">처리완료 요청</button>
														<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'issueKeyNum');">컬럼 선택</button>
														<button class="btn btn-outline-info-del myBtn" id="BtnImprovements">향후 개선 목록</button>
													</td>
												</tr>
												<tr>
													<td><span style="color: red;">처리 완료되었지만 리스트에 남아 있는 경우, 처리 완료 요청 바랍니다.</span></td>
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
	</body>

	<script>
		$('.selectpicker').selectpicker();

		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var issueDateStart = $("#issueDateStart").val();
			var issueDateEnd = $("#issueDateEnd").val();
			if(issueDateStart > issueDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일이 종료일자 보다 큽니다.',    
				});
			} else if(issueDateStart == "" && issueDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(issueDateEnd == "" && issueDateStart != "") {
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
			$('#issueCustomer').val($('#issueCustomerMulti').val().join());
			$('#issueTitle').val($('#issueTitleMulti').val().join());
			$('#issueProceStatus').val($('#issueProceStatusMulti').val().join());
			$('#issueTosms').val($('#issueTosmsMulti').val().join());
			$('#issueTosrf').val($('#issueTosrfMulti').val().join());
			$('#issuePortal').val($('#issuePortalMulti').val().join());
			$('#issueJava').val($('#issueJavaMulti').val().join());
			$('#issueWas').val($('#issueWasMulti').val().join());
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="urlOpen('+"'"+rowdata.issueRelayUrl+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function urlOpen(url) {
			window.open(url, '_blank');
		}

		function stateFormatter(cellValue, options, rowdata, action) {
			if(cellValue == 'progress') {
				return '진행 중';
			} else if(cellValue == 'request') {
				return '처리 완료 요청';
			}
			return '처리 완료';
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
			$('#issueProceStatusMulti').val('progress');
			$('#issueProceStatusMulti').selectpicker('refresh');
			
			tableRefresh();
		});

		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="issueDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});

		/* =========== 전달일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#issueDateStart").val("");
	        	$("#issueDateEnd").val("");
	        } else {
	        	$("#issueDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#issueDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }

		$('#BtnCompleteRequest').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '처리 요청!',
					  text: "선택한 이슈를 처리 요청 하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/issue/completeRequest'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '처리완료 요청 하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '처리완료 요청에 실패하였습니다.',
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

		$('#BtnImprovements').click(function() {
			window.open("<c:url value='/issueRelay/improvementsList'/>?target=${target}", '_blank');
		})		
	</script>

</html>