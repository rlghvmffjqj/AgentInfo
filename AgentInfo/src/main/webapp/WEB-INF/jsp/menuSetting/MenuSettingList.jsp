<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
		<script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
	    	$(function() {
	    		$.cookie('name','menuSetting');
	    	});
    	</script>
		<script>	
			$(document).ready(function(){
				$("#mainList").jqGrid({
					url: "<c:url value='/menuSetting/main'/>",
					mtype: 'POST',
					datatype: 'json',
					colNames:['Key','순서','타이틀'],
					colModel:[
						{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 40, hidden:true },
						{name:'menuSort', index:'menuSort', align:'center', width: 150, formatter: mainLinkFormatter},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 325},
					],
					jsonReader : {
			        	id: 'menuKeyNum',
			        	repeatitems: false
			        },
			        pager: '#mainPager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'menuSort', 		// 기본 정렬 
			        sortorder: 'asc',			// 정렬 방식
			        
			        // multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
					onSelectRow: function (rowId) {
  						// var rowData = $("#mainList").jqGrid('getRowData', rowId);
						selectSubMenu(rowId)
						selectItem(rowId)
  					}
				});

				$("#subList").jqGrid({
					url: "<c:url value='/menuSetting/sub'/>",
					mtype: 'POST',
					datatype: 'json',
					colNames:['Key','순서','타이틀'],
					colModel:[
						{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 40, hidden:true },
						{name:'menuSort', index:'menuSort', align:'center', width: 150, formatter: subLinkFormatter},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 325},
					],
					jsonReader : {
			        	id: 'menuKeyNum',
			        	repeatitems: false
			        },
			        pager: '#subPager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'menuSort', 		// 기본 정렬 
			        sortorder: 'asc',			// 정렬 방식
			        
			        // multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
					onSelectRow: function (rowId) {
						selectItem(rowId)
  					}
				}); 

				$("#itemList").jqGrid({
					url: "<c:url value='/menuSetting/item'/>",
					mtype: 'POST',
					datatype: 'json',
					colNames:['Key','순서','컬럼명(한글)','컬럼명(영문)','타입'],
					colModel:[
						{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 50, hidden:true },
						{name:'menuSort', index:'menuSort', align:'center', width: 70, formatter: itemLinkFormatter},
						{name:'menuTitleKor', index:'menuTitleKor', align:'center', width: 130},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 130},
						{name:'menuItemType', index:'menuItemType', align:'center', width: 135},
					],
					jsonReader : {
			        	id: 'menuKeyNum',
			        	repeatitems: false
			        },
			        pager: '#itemPager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'menuSort', 		// 기본 정렬 
			        sortorder: 'asc',			// 정렬 방식
			        
			        // multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 

				$(window).on('resize.list', function () {
			    	jQuery("#subList").jqGrid( 'setGridWidth', $(".menuSettingDiv").width() );
					jQuery("#itemList").jqGrid( 'setGridWidth', $(".menuSettingDiv").width() );
					jQuery("#mainList").jqGrid( 'setGridWidth', $(".menuSettingDiv").width() );
				});
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
								                <h5 class="m-b-10">메뉴 설정</h5>
								                <p class="m-b-0">Menu Setting</span>
								            </div>
								        </div>
								        <div class="col-md-4">
								            <ul class="breadcrumb-title">
								                <li class="breadcrumb-item">
								                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
								                </li>
								                <li class="breadcrumb-item"><a href="#!">메뉴 설정</a>
								                </li>
								            </ul>
								        </div>
								    </div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
			                           	<table style="width:100vw;">
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<div style="float: left;">
															<span class="menuSettingTitle">메인 메뉴</span>
															<div class="menuSettingDiv">
																<table class="menuSettingTable">
																	<tbody>
																		<tr>
																			<td style="font-weight:bold;">
																				<button class="btn btn-outline-info-add myBtn" id="BtnMainInsert">추가</button>
																				<button class="btn btn-outline-info-nomal myBtn" id="BtnMainUpdate">수정</button>
																				<button class="btn btn-outline-info-del myBtn" id="BtnMainDelete">삭제</button>
																			</td>
																		</tr>
																		<tr>
																			<td class="border1" colspan="2">
																				<!------- Grid ------->
																				<div class="jqGrid_wrapper">
																					<table id="mainList"></table>
																					<div id="mainPager"></div>
																				</div>
																				<!------- Grid ------->
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div style="float: left; padding-left: 1.5vw;">
															<span class="menuSettingTitle">서브 메뉴</span>
															<div class="menuSettingDiv">
																<table class="menuSettingTable">
																	<tbody>
																		<tr>
																			<td style="font-weight:bold;">
																				<button class="btn btn-outline-info-add myBtn" id="BtnSubInsert">추가</button>
																				<button class="btn btn-outline-info-nomal myBtn" id="BtnSubUpdate">수정</button>
																				<button class="btn btn-outline-info-del myBtn" id="BtnSubDelete">삭제</button>
																			</td>
																		</tr>
																		<tr>
																			<td class="border1" colspan="2">
																				<!------- Grid ------->
																				<div class="jqGrid_wrapper">
																					<table id="subList"></table>
																					<div id="subPager"></div>
																				</div>
																				<!------- Grid ------->
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div style="float: left; padding-left: 1.5vw;">
															<span class="menuSettingTitle">컬럼</span>
															<div class="menuSettingDiv">
																<table class="menuSettingTable">
																	<tbody>
																		<tr>
																			<td style="font-weight:bold;">
																				<button class="btn btn-outline-info-add myBtn" id="BtnItemInsert">추가</button>
																				<button class="btn btn-outline-info-nomal myBtn" id="BtnItemUpdate">수정</button>
																				<button class="btn btn-outline-info-del myBtn" id="BtnItemDelete">삭제</button>
																			</td>
																		</tr>
																		<tr>
																			<td class="border1" colspan="2">
																				<!------- Grid ------->
																				<div class="jqGrid_wrapper">
																					<table id="itemList"></table>
																					<div id="itemPager"></div>
																				</div>
																				<!------- Grid ------->
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
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
		function mainLinkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function subLinkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function itemLinkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		$('#BtnMainInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/menuSetting/insertView'/>",
				data: {
					"menuType": "main",
					"menuParentKeyNum": 0
				},
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'menuSetting'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		});

		$('#BtnMainUpdate').click(function() {
			var menuKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow'); 
			if(!menuKeyNum) {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '행 선택 바랍니다.',
				});
				return false;
			}
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/menuSetting/updateView'/>",
				data: {
					"menuKeyNum": menuKeyNum
				},
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'menuSetting'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		});

		$('#BtnMainDelete').click(function() {
			var menuKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow'); 
			
			if(!menuKeyNum) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					title: '삭제!',
					text: "선택한 메인 메뉴를 삭제하시겠습니까?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#7066e0',
					cancelButtonColor: '#FF99AB',
					confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/menuSetting/delete'/>",
						type: "POST",
						data: {"menuKeyNum": menuKeyNum},
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
							mainTableRefresh();
						},
						error: function(error) {
							console.log(error);
						}
					  });
				  	}
				})
			}
		});


		$('#BtnSubInsert').click(function() {
			var menuKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow');
			if(!menuKeyNum) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/menuSetting/insertView'/>",
					data: {
						"menuType": "sub",
						"menuParentKeyNum": menuKeyNum
					},
				    async: false,
				    success: function (data) {
						if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				    	$.modal(data, 'menuSetting'); //modal창 호출
				    },
				    error: function(e) {
				        alert(e);
				    }
				});	
			}
		});


		$('#BtnSubUpdate').click(function() {
			var menuKeyNum = $("#subList").jqGrid('getGridParam', 'selrow'); 
			if(!menuKeyNum) {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '행 선택 바랍니다.',
				});
				return false;
			}
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/menuSetting/updateView'/>",
				data: {
					"menuKeyNum": menuKeyNum
				},
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'menuSetting'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		});


		$('#BtnSubDelete').click(function() {
			var menuKeyNum = $("#subList").jqGrid('getGridParam', 'selrow'); 
			
			if(!menuKeyNum) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					title: '삭제!',
					text: "선택한 서브 메뉴를 삭제하시겠습니까?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#7066e0',
					cancelButtonColor: '#FF99AB',
					confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/menuSetting/delete'/>",
						type: "POST",
						data: {"menuKeyNum": menuKeyNum},
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
							subTableRefresh();
						},
						error: function(error) {
							console.log(error);
						}
					  });
				  	}
				})
			}
		});

		function mainTableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var jqGrid = $("#mainList");
			jqGrid.clearGridData();
			jqGrid.trigger('reloadGrid');
		}

		function subTableRefresh(menuKeyNum) {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var jqGrid = $("#subList");
			jqGrid.clearGridData();
			jqGrid.setGridParam({postData: { "menuParentKeyNum": menuKeyNum }});
			jqGrid.trigger('reloadGrid');
		}

		function itemTableRefresh(menuKeyNum) {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var jqGrid = $("#itemList");
			jqGrid.clearGridData();
			jqGrid.setGridParam({postData: { "menuParentKeyNum": menuKeyNum }});
			jqGrid.trigger('reloadGrid');
		}

		function selectSubMenu(menuKeyNum) {
			subTableRefresh(menuKeyNum);
		}

		function selectItem(menuKeyNum) {
			itemTableRefresh(menuKeyNum);
		}

		$('#BtnItemInsert').click(function() {
			var mainKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow');
			var subKeyNum = $("#subList").jqGrid('getGridParam', 'selrow');
			if(!mainKeyNum) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/menuSetting/insertItemCheck'/>",
					data: {
						"mainKeyNum": mainKeyNum,
						"subKeyNum": subKeyNum
					},
				    async: false,
				    success: function (data) {
						if(data == "ItemCheckFalse") {
							Swal.fire({               
								icon: 'error',          
								title: '실패!',           
								text: '서브메뉴가 존재할 경우 메인메뉴에서 컬럼 추가 불가능합니다.',    
							});  
							return;
						} else {
							itemInsert();	
						}
				    },
				    error: function(e) {
				        alert(e);
				    }
				});	
			}
		});

		function itemInsert() {
			var mainKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow');
			var subKeyNum = $("#subList").jqGrid('getGridParam', 'selrow');
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/menuSetting/insertItemView'/>",
				data: {
					"menuType": "item",
					"mainKeyNum": mainKeyNum,
					"subKeyNum": subKeyNum
				},
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'menuSettingItem'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		}

		$('#BtnItemUpdate').click(function() {
			var menuKeyNum = $("#itemList").jqGrid('getGridParam', 'selrow'); 
			var mainKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow');
			var subKeyNum = $("#subList").jqGrid('getGridParam', 'selrow');
			if(!menuKeyNum) {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '행 선택 바랍니다.',
				});
				return false;
			}
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/menuSetting/updateItemView'/>",
				data: {
					"menuKeyNum": menuKeyNum,
					"mainKeyNum": mainKeyNum,
					"subKeyNum": subKeyNum
				},
			    async: false,
			    success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			    	$.modal(data, 'menuSettingItem'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		});

		$('#BtnItemDelete').click(function() {
			var mainKeyNum = $("#mainList").jqGrid('getGridParam', 'selrow');
			var subKeyNum = $("#subList").jqGrid('getGridParam', 'selrow');
			var menuKeyNum = $("#itemList").jqGrid('getGridParam', 'selrow'); 
			
			if(!menuKeyNum) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					title: '삭제!',
					text: "선택한 컬럼을 삭제하시겠습니까?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#7066e0',
					cancelButtonColor: '#FF99AB',
					confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/menuSetting/deleteItem'/>",
						type: "POST",
						data: {
							"menuKeyNum": menuKeyNum,
							"mainKeyNum": mainKeyNum,
							"subKeyNum": subKeyNum
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
							itemTableRefresh();
						},
						error: function(error) {
							console.log(error);
						}
					  });
				  	}
				})
			}
		});
	</script>
	<style>
		.menuSettingDiv {
			width:27.5vw; 
			float: left; 
			background: white; 
			padding: 1vw;
			border-top: 1px solid #cccccc;
		}

		.menuSettingTitle {
			display: block;
    		font-size: 14px;
    		margin-bottom: 5px;
    		color: black;
    		font-family: none;
    		font-weight: 400;
		}

		.menuSettingTable {
			width: 25.5vw;
			z-index: 0;
    		position: relative;
		}
	</style>
</html>