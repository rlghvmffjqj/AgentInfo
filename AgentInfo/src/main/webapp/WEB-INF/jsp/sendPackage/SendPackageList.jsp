<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- datetimepicker -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/datetimepicker/jquery.datetimepicker.min.css'/>">
		<script type="text/javascript" src="<c:url value='/datetimepicker/jquery.datetimepicker.full.min.js'/>"></script>
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','sendPackage');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/sendPackage'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['No.','URL','고객사명','사업명','망구분','담당자','요청일자','패키지종류','패키지명','다운로드 허용기간','다운로드 횟수','최대 다운로드 횟수'],
					colModel:[
						{name:'sendPackageKeyNum', index:'sendPackageKeyNum', align:'center', width: 70, hidden:true},
						{name:'sendPackageRandomUrl', index:'sendPackageRandomUrl', align:'center', width: 310, formatter: copyFormatter, sortable:false},
						{name:'customerName', index:'customerName', align:'center', width: 200, formatter: linkFormatter},
						{name:'businessName', index:'businessName', align:'center', width: 200},
						{name:'networkClassification', index:'networkClassification', align:'center', width: 70},
						{name:'manager', index:'manager', align:'center', width: 70},
						{name:'requestDate', index:'requestDate', align:'center', width: 70},
						{name:'managementServer', index:'managementServer', align:'center', width: 200},
						{name:'sendPackageName', index:'sendPackageName', align:'center', width: 500},
						{name:'sendPackageStartDate', index:'sendPackageStartDate', align:'center', width: 230, formatter: downloadPeriod},
						{name:'sendPackageCount', index:'sendPackageCount', align:'center', width: 100},
						{name:'sendPackageLimitCount', index:'sendPackageLimitCount', align:'center', width: 100},
						
					],
					jsonReader : {
			        	id: 'sendPackageKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'sendPackageKeyNum',	// 기본 정렬 
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
				loadColumns('#list','sendPackageList');
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
							                <h5 class="m-b-10">패키지 파일관리</h5>
							                <p class="m-b-0">Package File Management</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">패키지 파일 관리</a>
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
	                      							<label class="labelFontSize">고객사명</label>
													<select class="form-control selectpicker" id="customerNameMulti" name="customerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${customerName}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">사업명</label>
													<select class="form-control selectpicker" id="businessNameMulti" name="businessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${businessName}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">망 구분</label>
	                      							<input type="text" id="networkClassification" name="networkClassification" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">담당자</label>
	                      							<input type="text" id="manager" name="manager" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">요청일자</label>
													<input class="form-control" type="date" id="requestDate" name="requestDate" max="9999-12-31"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지 종류</label>
													<select class="form-control selectpicker" id="managementServerMulti" name="managementServerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${managementServer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지명</label>
	                      							<input type="text" id="sendPackageName" name="sendPackageName" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">다운로드 허용 시작일</label>
													<input class="form-control" type="date" id="sendPackageStartDate" name="sendPackageStartDate" max="9999-12-31"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">다운로드 허용 종료일</label>
													<input class="form-control" type="date" id="sendPackageEndDate" name="sendPackageEndDate" max="9999-12-31"> 
	                      						</div>
	                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
		                      					<input type="hidden" id="businessName" name="businessName" class="form-control">
	                      						<input type="hidden" id="managementServer" name="managementServer" class="form-control">
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
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="font-weight:bold;">패키지 파일 관리 :
																	<sec:authorize access="hasRole('ADMIN')">
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																	</sec:authorize>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'sendPackageList');">컬럼 선택</button>
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
		/* =========== 패키지 관리 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/sendPackage/insertView'/>",
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'sendPackage'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
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
			$('#managementServer').val($('#managementServerMulti').val().join());
			$('#customerName').val($('#customerNameMulti').val().join());
			$('#businessName').val($('#businessNameMulti').val().join());

			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.sendPackageKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
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
	        
			$('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
	        
			tableRefresh();
		});
		
		/* =========== 패키지 관리 삭제 ========= */
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
						url: "<c:url value='/sendPackage/delete'/>",
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
		
		/* =========== 패키지 수정 Modal ========= */
		function updateView(data) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/sendPackage/updateView'/>",
		        data: {"sendPackageKeyNum" : data},
		        async: false,
		        success: function (data) {
		        	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
		            $.modal(data, 'sendPackage'); //modal창 호출
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		}
		
		function copyFormatter(value, options, row) {
			var URL = row.sendPackageRandomUrl;
			return '<a href="#!" onClick="btnCopy('+"'"+URL+"'"+');" style="font-size:10px;">https://172.16.50.79:8443/AgentInfo/PKG/download/'+URL+'</a>';
		}
		
		function btnCopy(URL) {
			URL = "https://172.16.50.79:8443/AgentInfo/PKG/download/"+URL;
			const textarea = document.createElement('textarea');
			textarea.textContent = URL;
			document.body.append(textarea);
			textarea.select();
			document.execCommand('copy');
			textarea.remove();
			Swal.fire(
			  '복사!',
			  '클립보드 복사 하였습니다.',
			  'success'
			)
		}
		
		function downloadPeriod(value, options, row) {
			var startDate = row.sendPackageStartDate;
			var endDate = row.sendPackageEndDate;
			return startDate+' ~ '+endDate;
		}
		
	</script>
</html>