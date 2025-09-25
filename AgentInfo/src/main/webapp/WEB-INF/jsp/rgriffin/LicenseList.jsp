<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','rgriffin');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/rgriffin'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사명','카테고리','발급일','만료일','수량','RGMSID','비밀번호','라이선스 파일명','요청자'],
					colModel:[
						{name:'rgriffinKeyNum', index:'rgriffinKeyNum', align:'center', width: 35, hidden:true },
						{name:'rgriffinCompany', index:'rgriffinCompany', align:'center', width: 220},
						{name:'rgriffinCategory', index:'rgriffinCategory', align:'center', width: 160},
						{name:'rgriffinIssueDate', index:'rgriffinIssueDate', align:'center', width: 100},
						{name:'rgriffinExpire', index:'rgriffinExpire', align:'center', width: 150},
						{name:'rgriffinQuantity', index:'rgriffinQuantity', align:'center', width: 80},
						{name:'rgriffinRgmsid', index:'rgriffinRgmsid', align:'center', width: 400},
						{name:'rgriffinPassword', index:'rgriffinPassword', align:'center', width: 100},
						{name:'rgriffinFilePath', index:'rgriffinFilePath',align:'center', width: 200},
						{name:'rgriffinRequester', index:'rgriffinRequester',align:'center', width: 150}
					],
					jsonReader : {
			        	id: 'rgriffinKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'rgriffinKeyNum',	// 기본 정렬 
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
				loadColumns('#list','rgriffinList');
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
									            <h5 class="m-b-10">rGRIFFIN 라이선스 발급</h5>
									            <p class="m-b-0">rGRIFFIN License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">rGRIFFIN 라이선스 발급</a>
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
													<div style="padding-left:15px; width:28.5%; display: table;">
														<label class="labelFontSize">만료일</label>
														<div>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="rgriffinExpireStart" name="rgriffinExpireStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="rgriffinExpireEnd" name="rgriffinExpireEnd" max="9999-12-31">
													  	</div>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">고객사명</label>
														<input type="text" id="rgriffinCompany" name="rgriffinCompany" class="form-control">
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">카테고리</label>
														<input type="text" id="rgriffinCategory" name="rgriffinCategory" class="form-control">
													</div>
													<div class="col-lg-2">
														<label class="labelFontSize">수량</label>
														<input type="text" id="rgriffinQuantity" name="rgriffinQuantity" class="form-control">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">RGMSID</label>
														<input type="text" id="rgriffinRgmsid" name="rgriffinRgmsid" class="form-control">		                      							
		                      						</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">라이선스 파일명</label>
														<input type="text" id="rgriffinFilePath" name="rgriffinFilePath" class="form-control">
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">요청자</label>
														<input type="text" id="rgriffinRequester" name="rgriffinRequester" class="form-control">
													</div>
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
																<td style="font-weight:bold;">라이선스 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">발급</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnDelect">제거</button>
																	<!-- <button class="btn btn-outline-info-nomal myBtn" id="BtnUpdate">수정</button> -->
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnDownload">라이선스 다운로드</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnExcelExport" onClick="doExportExec()" title="현제 테이블 조회된 데이터를 Excel로 Export합니다.">Excel 내보내기</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'rgriffinList');">컬럼 선택</button>
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
		/* =========== 라이선스 발급 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/rgriffin/issuedView'/>",
			    data: {
		    		"viewType" : "issued"
		    	},
			    async: false,
			    success: function (data) {
			    	//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
			    	$.modal(data, 'rgriffin'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});		
		});
		
		/* =========== 라이선스 발급 정보 제거 ========= */
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
					  text: "선택한 라이선스를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/rgriffin/delete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '제거 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '제거 실패하였습니다.',
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
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {		
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
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var rgriffinExpireStart = $("#rgriffinExpireStart").val();
			var rgriffinExpireEnd = $("#rgriffinExpireEnd").val();
			
			if(rgriffinExpireStart == "" && rgriffinExpireEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의 시작날짜를 입력해주세요.',    
					});
			} else if(rgriffinExpireEnd == "" && rgriffinExpireStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의  종료 날짜를 입력해주세요.',    
					});
			} else if(rgriffinExpireStart > rgriffinExpireEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '시작일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else {
				tableRefresh();	
			}
		});
		
		
		/* =========== TXT 저장 ========= */
		$('#BtnTxt').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				url: "<c:url value='/license/txtTitle'/>",
				type: "POST",
				data: {chkList: chkList},
				traditional: true,
				async: false,
				success: function(data) {
					//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
				});
			}
		});
		
		/* =========== 경로 설정 ========= */
		$('#BtnRoute').click(function() {
			$.ajax({
				url: "<c:url value='/license/setting'/>",
				data: {"licenseVersion" : "rgriffin"},
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
		});
		
		/* =========== 데이터 복사 Modal ========= */
		$('#BtnCopy').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var rgriffinKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/license/copyView'/>",
		            data: {"rgriffinKeyNum" : rgriffinKeyNum},
		            async: false,
		            success: function (data) {
		            	//if(data.indexOf("<!DOCTYPE html>") != -1) 
						//	location.reload();
		                $.modal(data, 'll'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '복사를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});

		/* =========== 데이터 수정 Modal ========= */
		$('#BtnUpdate').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var rgriffinKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/rgriffin/updateView'/>",
		            data: {"rgriffinKeyNum" : rgriffinKeyNum},
		            async: false,
		            success: function (data) {
		                $.modal(data, 'll'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '수정를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});

		$('#BtnDownload').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList.length === 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});  
			} else if (chkList.length == 1) {
				$.ajax({
					url: "<c:url value='/rgriffin/rgriffinDownLoadCheck'/>",
					type: "POST",
					data: {chkList: chkList},
					traditional: true,
					async: false,
					success: function(result) {
	            		if(result==="FALSE") {
							Swal.fire(
							  '에러!',
							  'JSON 파일이 존재하지 않습니다.',
							  'error'
							)
						} else {
							location.href="<c:url value='/rgriffin/rgriffinMultiDownLoad'/>?rgriffinKeyNum="+chkList;
						}
	            	},
	            	error: function(e) {
	            		Swal.fire(
						  '에러!',
						  '에러가 발생하였습니다.',
						  'error'
						)
	            	}
	       		});
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '라이선스 재다운로드 받을 데이터 한 행만 선택 해주세요.',    
				}); 
			}
			
		});

		$('#BtnImport').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/rgriffin/licenseYmlImportView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'xmlImport'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});
		});
	</script>
	<script>
		/* jqgrid 테이블 드래그 체크박스 선택 (부족하고 불편한 점이 있어 계속 수정할것) */
		$("#list").on('click','tr', function () {
			var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
			$("#list").jqGrid('setSelection', checkbox, true);
		});
		
		$("#list").on('mousedown','tr', function () {
			var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
			$("#list").jqGrid('setSelection', checkbox, true);
			var move = true;
			
			$("#list").on('mouseover','tr', function () {
				if(move) {
					var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
					$("#list").jqGrid('setSelection', checkbox, true);
				}
			});
			$("#list").on('mouseup', 'tr', function () {
				move = false;				
			});
			$("body").on('mouseup', function () {
				move = false;				
			});
		});
		
	</script>
</html>