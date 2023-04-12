<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name',"customPackage");
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/customPackage'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','사업명','패키지 종류','Version','OS종류','파일명','릴리즈 노트'],
					colModel:[
						{name:'customPackageKeyNum', index:'customPackageKeyNum', align:'center', width: 100, hidden:true },
						{name:'customerName', index:'customerName', align:'center', width: 200, formatter: linkFormatter},
						{name:'businessName', index:'businessName', align:'center', width: 180},
						{name:'managementServer', index:'managementServer', align:'center' ,width: 250},
						{name:'agentVer', index:'agentVer', align:'center' ,width: 300},
						{name:'osType', index:'osType', align:'center' ,width: 200},
						{name:'releaseNotes', index:'releaseNotes', align:'center', width: 200},
						{name:'releaseNotes', index:'releaseNotes', align:'center', width: 150, formatter: releaseNotesFormatter, sortable:false},
					],
					jsonReader : {
			        	id: 'customPackageKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'managementServer', 	// 기본 정렬 
			        sortorder: 'asc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
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
												<h5 class="m-b-10">커스텀 패키지</h5>
												<p class="m-b-0">Custom Package</p>
											</div>
										</div>
										<div class="col-md-4">
										    <ul class="breadcrumb-title">
										        <li class="breadcrumb-item">
										            <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
										        </li>
										        <li class="breadcrumb-item"><a href="#!">커스텀 패키지</a>
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
		                      							<label class="labelFontSize">패키지 종류</label>
														<select class="form-control selectpicker" id="managementServerMulti" name="managementServerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${managementServer}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">Agent ver</label>
														<select class="form-control selectpicker" id="agentVerMulti" name="agentVerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${agentVer}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">OS종류</label>
														<select class="form-control selectpicker" id="osTypeMulti" name="osTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${osType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
		                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
		                      						<input type="hidden" id="businessName" name="businessName" class="form-control">
		                      						<input type="hidden" id="managementServer" name="managementServer" class="form-control">
		                      						<input type="hidden" id="agentVer" name="agentVer" class="form-control">
		                      						<input type="hidden" id="osType" name="osType" class="form-control">
		                      						
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
																	<td style="font-weight:bold;">커스텀 패키지 관리 :
																		<sec:authorize access="hasRole('ADMIN')">
																			<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																			<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		</sec:authorize>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnBatchDownload">일괄 다운로드</button>
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
		/* =========== 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/customPackage/insertView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'sl'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#customerName').val($('#customerNameMulti').val().join());
			$('#businessName').val($('#businessNameMulti').val().join());
			$('#managementServer').val($('#managementServerMulti').val().join());
			$('#agentVer').val($('#agentVerMulti').val().join());
			$('#osType').val($('#osTypeMulti').val().join());
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: $("#form").serializeObject() });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.customPackageKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== 삭제 ========= */
		$('#BtnDelect').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '삭제!',
					  text: "선택한 카테고리를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/customPackage/delete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							console.log(data);
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
		
		/* =========== 수정 Modal ========= */
		function updateView(data) {
			<sec:authorize access="hasRole('ADMIN')">
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/customPackage/updateView'/>",
		            data: {"customPackageKeyNum" : data},
		            async: false,
		            success: function (data) {
		            	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
		                $.modal(data, 'sl'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			</sec:authorize>
		}
		
		/* =========== 릴리즈 노트 포멧털 ========= */
		function releaseNotesFormatter(value, options, row) {
			var releaseNotes = row.releaseNotes.toUpperCase();
			return '<button class="btn btn-outline-info-nomal myBtn" onClick="fileDownload(' + "'" + releaseNotes + "'"  + ')">다운로드</button>';
		}
		
		/* =========== 릴리즈 노트 다운로드 ========= */
		function fileDownload(releaseNotes) {
			$.ajax({
	            type: 'GET',
	            url: "<c:url value='/customPackage/fileDownload'/>",
	            data: {"fileName" : releaseNotes},
	            async: false,
	            success: function (data) {
	            	window.location ="<c:url value='/customPackage/fileDownload?fileName="+releaseNotes+"'/>";
	            	Swal.fire(
					  '처리완료!',
					  '처리 완료하였습니다.',
					  'success'
					)
	            },
	            error: function(e) {
	            	Swal.fire(
					  '에러!',
					  '에러가 발생하였습니다.',
					  'error'
					)
	            }
	        });
		}
		
		/* =========== 릴리즈 노트 일괄 다운로드 ========= */
		$('#BtnBatchDownload').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var params = "";
			for (var value of chkList) {
				params = params + value + ",";
			}
			params = params.slice(0, -1);
			if(chkList == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length <= 1){
				Swal.fire({               
					icon: 'info',          
					title: '확인!',           
					text: '일괄다운로드의 경우 2개 이상의 행을 선택 후 사용바랍니다.',    
				});
			} else {
				 $.ajax({
					type: "GET",
					url: "<c:url value='/customPackage/batchDownload'/>",
					data: {chkList: params},
					async: false,
					success: function(data) {
						window.location ="<c:url value='/customPackage/batchDownload?chkList="+params+"'/>";
						Swal.fire(
						  '성공!',
						  '처리 완료하였습니다.',
						  'success'
						)
						tableRefresh();
					},
					error: function(error) {
						console.log(error);
						Swal.fire(
						  '실패!',
						  '처리 실패하였습니다.',
						  'error'
						)
					}
				});
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
	</script>
</html>