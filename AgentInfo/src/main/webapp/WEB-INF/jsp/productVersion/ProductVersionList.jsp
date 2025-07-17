<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name',"${menuType}${menuTitle}");
		    });
	    </script>
		<script>
			$(document).ready(function(){
				const menuTitleKorList = JSON.parse('${menuTitleKorListJson}');

				const menuTitleList = [
  				  <c:forEach var="title" items="${menuTitleList}" varStatus="loop">
  				    '${title}'<c:if test="${!loop.last}">,</c:if>
  				  </c:forEach>
  				];
			  
  				const colModel = menuTitleList.map((title, idx) => ({
  				  	name: title,  // 실제 데이터 키에 맞게 조정 필요
  				  	index: title,
  				  	align: 'center',
  				  	width: 250,/*  */
				  	classes: 'ellipsis-cell',
    				formatter: function(cellvalue) {
    				  return `<span title="`+cellvalue+`">`+cellvalue+`</span>`;
    				}
  				}));


				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/productVersion/${productData}'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:menuTitleKorList,
					colModel:colModel,
					jsonReader : {
			        	id: 'productVersionKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'productVersionKeyNum', 	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false ,			// 컬럼 폭 고정값 유지
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
									            <h5 class="m-b-10">제품 버전 관리 [${menuTitle}]</h5>
									            <p class="m-b-0">Product Version</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">제품 버전 관리 [${menuTitle}]</a>
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
		                                		<form id="form" name="form" method ="post" onSubmit="return false;">
													<c:forEach var="item" items="${menuSettingItemList}">
													  	<div class="col-lg-2">
													  	  	<label class="labelFontSize">${item.menuTitleKor}</label>
													  	  	<input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control">
													  	</div>
													</c:forEach>
													<input type="hidden" id="menuKeyNum" name="menuKeyNum" value="${menuKeyNum}">
													<input type="hidden" id="menuTitle" name="menuTitle" value="${menuTitle}">
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
																	<td style="font-weight:bold;">제품 버전 관리 :
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnUpdate">수정</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		<button class="btn btn-outline-info-add myBtn" id="BtnCompatibilityAdd">호환 항목 등록</button>
																		<button class="btn btn-outline-info-nomal myBtn" id="BtnCompatibilitySerach">호환 항목 조회</button>
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
			var formData = $('#form').serializeObject();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/productVersion/insertView'/>",
			    data: formData,
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'productVersion'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: $("#form").serializeObject() });
			jqGrid.trigger('reloadGrid');
		}
	
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.menuKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		
		/* =========== 삭제 ========= */
		$('#BtnDelect').click(function() {
			var menuKeyNum = $('#menuKeyNum').val();
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
					  text: "선택한 제품 정보를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/productVersion/delete'/>",
						type: "POST",
						data: {
							chkList: chkList,
							"menuKeyNum": menuKeyNum
						},
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
		
		/* =========== 수정 Modal ========= */
		$('#BtnUpdate').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
				return;
			} else if(chkList.length > 1) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '수정할 하나의 행만 선택해 주세요.',    
				});    
				return;
			}

			var formData = $('#form').serializeObject();
			formData["productVersionKeyNum"] = chkList;
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/productVersion/updateView'/>",
			    data: formData,
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'productVersion'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$("input[type='date']").val("");
	        
	        $('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
			
			tableRefresh();
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();	
		});
		
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


		/* =========== 호환 추가 Modal ========= */
		$('#BtnCompatibilityAdd').click(function() {
			var menuKeyNum = $('#menuKeyNum').val();
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
				    url: "<c:url value='/productVersion/compatibilityView'/>",
				    data: {
						chkList: chkList,
						"menuKeyNum": menuKeyNum
					},
				    async: false,
					traditional: true,
					dataType: "text",
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'compatibility'); //modal창 호출
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});			
			}
		});

		$('#BtnCompatibilitySerach').click(function() {
			var menuKeyNum = $('#menuKeyNum').val();
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			}else if(chkList.length > 1) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '하나의 행만 석택 바랍니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/productVersion/compatibilitySearchView'/>",
				    data: {
						chkList: chkList,
						"menuKeyNum": menuKeyNum
					},
				    async: false,
					traditional: true,
					dataType: "text",
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'compatibility'); //modal창 호출
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});		
			}
		});
		
	</script>
	<style>
		.ellipsis-cell div,
		.ellipsis-cell span {
			display: inline-block;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			width: 100%;
		}

		#list {
			table-layout: fixed !important;
		}

	</style>
</html>