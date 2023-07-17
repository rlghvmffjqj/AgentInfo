<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- dynatree -->
		<script type="text/javascript" src="<c:url value='/js/dynatree/src/jquery.dynatree.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/dynatree/src/skin-vista/ui.dynatree.css'/>">

		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
		<script>
		/* =========== 페이지 쿠키 값 저장 ========= */
	    $(function() {
	    	$.cookie('name','testCase');
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
												<div class="col-lg-2">
													<label class="labelFontSize">고객사</label>
													<span class="colorRed" id="NotCustomer" style="display: none; line-height: initial;">고객사 입력 바랍니다.</span>
													<input type="text" id="testCaseRouteCustomer" name="testCaseRouteCustomer" class="form-control viewForm" value="${testCase.testCaseRouteCustomerView}" <c:if test="${viewType eq 'update'}">readonly</c:if>>
												</div>
												<div class="col-lg-2">
													<label class="labelFontSize">비고</label>
													<span class="colorRed" id="NotNote" style="display: none; line-height: initial;">비고 입력 바랍니다.</span>
													<input type="text" id="testCaseRouteNote" name="testCaseRouteNote" class="form-control viewForm" value="${testCase.testCaseRouteNoteView}" <c:if test="${viewType eq 'update'}">readonly</c:if>>
												</div>
												<c:if test="${viewType eq 'insert'}">
													<button class="btn btn-outline-info-add myBtn" id="btnTestCaseConfirmed" style="float: right; height: 50px; width: 50px;">확정</button>
												</c:if>
			                     			</div>
											<input type="hidden" id="testCaseFormKeyNum" name="testCaseFormKeyNum" class="form-control" value="${testCase.testCaseFormKeyNum}">
											<input type="hidden" id="testCaseRouteGroupNum" name="testCaseRouteGroupNum" class="form-control" value="${testCase.testCaseRouteGroupNum}">
											<input type="hidden" id="testCaseRouteKeyNum" name="testCaseRouteKeyNum" class="form-control">
											<input type="hidden" id="testCaseRouteName" name="testCaseRouteName" class="form-control">
											<input type="hidden" id="testCaseRouteFullPath" name="testCaseRouteFullPath" class="form-control">
											<input type="hidden" id="testCaseFormName" name="testCaseFormName" class="form-control" value="${testCase.testCaseFormName}">
		                     			</div>

										 <table class="fullTable" style="width:100%; float:left">
											<tbody><tr>
												<td style="padding:0px 0px 0px 0px;" class="box">
													<table class="RouteTable" style="width:19%;float:left">
														<tbody>
															<tr>
																<td style="font-weight:bold;">
																	테스트 케이스 분류 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnRouteInsert" onClick="btnRouteInsert()">추가</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnRouteUpdate" onClick="btnRouteUpdate()">수정</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnRouteDelect" onClick="btnRouteDelect()">삭제</button>
																</td>
															</tr>
															<tr>
																<td valign="top">
																	<div class="border1" style="overflow:scroll; height:728px;">
																		<div class="margin10">
																			<!----------------------- dynatree ----------------------->
																			<div id="tree" style="width: 100px;"></div>
																			<!----------------------- dynatree ----------------------->
																		</div>
																	</div>
					 											</td>
															</tr>
														</tbody>
													</table>
													<table class="ContentsTable" style="width:80%; float:right;">
														<tbody>
															<tr>
																<td style="font-weight:bold;">테스트 케이스 내용 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnContentsInsert" onclick="BtnContentsInsert()">추가</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnContentsDelete" onclick="BtnContentsDelete()">삭제</button>
																</td>
															</tr>
															<tr>
																<td class="border1" colspan="2" style="overflow: scroll;">
																	<div class="testCaseContents" id="testCaseContents">
																		
																	</div>
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
		/* =========== 테스트 케이스 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			location.href="<c:url value='/testCase/view'/>";		
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

	</script>

	<script>
		/* =========== Tree 시작 ========= */
		$(document).ready(function() {
			createTree();
			remakeIcon();
		});

		$('#tree').click(function() {
			setTimeout(function() {
				remakeIcon();
			}, 0);
		});

		function remakeIcon() {
			$('.dynatree-icon').addClass('dynatree-icon-remake');
			$('.dynatree-icon').removeClass('dynatree-icon');
			$('.dynatree-icon-remake').text('●');
		}

		/* =========== 트리 컨트롤러 생성 ========= */
		function createTree()
		{
			var startTestCaseRouteSortNum;
			var startTestCaseRouteFullPath;
			var startTestCaseRouteParentPath;
			var testCaseRouteName;
			$("#tree").dynatree({
				onActivate: function(node) {
					var path = node.data.key;
					reqChildNode(node, path);
				},
				onQueryExpand: function(flag, node) {
					if(flag) {
						$('#tree').dynatree('getTree').activateKey(node.data.key);
					}
				},
				dnd: {
					autoExpandMS: 1000,
    				preventVoidMoves: true, 
      				onDragStart: function(node) {
						console.log(node);		
						startTestCaseRouteSortNum = node.data.sortNum;
						startTestCaseRouteFullPath = node.data.key;
						startTestCaseRouteParentPath = node.data.parentPath;
						testCaseRouteName = node.data.title;
      					return true;
      				},
					autoExpandMS: 1000,
      				preventVoidMoves: true,
      				onDragEnter: function(node, sourceNode) {
      					// if(node.parent !== sourceNode.parent){
      					// 	return false;
      					// }
      					// return ["before", "after"];
						return true;
      				},
      				onDrop: function(node, sourceNode, hitMode, ui, draggable) {
						$.ajax({
							type: 'POST',
							url: "<c:url value='/testCase/testCaseRouteMove'/>",
							data: {
								"startTestCaseRouteSortNum" : startTestCaseRouteSortNum,
								"endTestCaseRouteSortNum" : node.data.sortNum,
								"hitMode" : hitMode,
								"testCaseRouteFullPath" : node.data.key,
								"testCaseRouteName" : testCaseRouteName,
								"testCaseRouteParentPath" : node.data.parentPath,
								"startTestCaseRouteFullPath" : startTestCaseRouteFullPath,
								"startTestCaseRouteParentPath" : startTestCaseRouteParentPath,
							},
							async: false,
							success: function (result) {
								if(result === "RouteFALSE") {
									Swal.fire({
										icon: 'error',
										title: '실패!',
										text: '/ 경로 위치로 이동이 불가능합니다.',
									});
								} else {
									sourceNode.move(node, hitMode);
								}
							},
							error: function(e) {
								console.log(e);
							}
						});
						remakeIcon();
      				}
    			}
			});
		
			var root = $("#tree").dynatree("getRoot");
			var rootNode = root.addChild({
				title : '/',
				tooltip : '/',
				key : '/',
				children: {title: 'Loading...', icon: 'loading.gif', noLink: true},
				isFolder : true
			});
		
			reqRootNode();
		}

		/* =========== 트리 루트노드 데이터 요청 ========= */
		function reqRootNode()
		{
			var rootNode = $("#tree").dynatree("getTree").selectKey('/');
			reqChildNode(rootNode, '/');
		}

		/* =========== 트리 하위노드 데이터 요청 ========= */
		function reqChildNode(node, path) {
			var testCaseRouteCustomer = $('#testCaseRouteCustomer').val();
			var testCaseRouteNote = $('#testCaseRouteNote').val();
			var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();

			$.ajax({
				url: "<c:url value='/testCase/routeList'/>",
				type: "POST",
				data: {
					"testCaseRouteParentPath" : path,
					"testCaseRouteCustomer" : testCaseRouteCustomer,
					"testCaseRouteNote" : testCaseRouteNote,
					"testCaseFormKeyNum" : testCaseFormKeyNum,
				},
				dataType: "json",
				async: false,
				success: function(data)
				{	
					var tree = $("#tree").dynatree("getTree");
					node.removeChildren();

					if(data != null && data.length > 0)
					{
						/* ===================== */
						tree.enableUpdate(false);
						/* ===================== */

						for(var i = 0; i < data.length; i++)
						{
							var childNode = node.addChild({
								title : data[i].testCaseRouteName,
								tooltip : data[i].testCaseRouteName,
								key : data[i].testCaseRouteFullPath,
								KeyNum : data[i].testCaseRouteKeyNum,
								sortNum : data[i].testCaseRouteSortNum,
								parentPath : data[i].testCaseRouteParentPath,
								children: {title: 'Loading...', icon: 'loading.gif', noLink: true},
								isFolder : true
							});
						}

						/* ===================== */
						tree.enableUpdate(true);
						/* ===================== */

						node.expand(true);
					}
					else
					{
						node.expand(false); // for IE7
					}

					if (path != '/') reqMember(path);
				},
				error: function(e) {
					console.log(e);
				}
			});
		}

		/* =========== 디렉토리에 해당하는 데이터 목록 요청 ========= */
		function reqMember(path)
		{
			var node = $("#tree").dynatree("getActiveNode");
			var path = node.data.key; // 선택 분류 풀 분류
			var title = node.data.title; // 선택 분류
			var keyNum = node.data.KeyNum;
			$("#testCaseRouteKeyNum").val(keyNum);
			$("#testCaseRouteName").val(title); //분류
			$("#testCaseRouteFullPath").val(path); // 분류 풀 분류

			$.ajax({
				type: 'POST',
				url: "<c:url value='/testCase/testCaseContents'/>",
				data: {"testCaseRouteKeyNum" : keyNum},
				async: false,
				success: function (testCase) {
					$('#testCaseContentsView').remove();
					if(testCase != "") {
						contentView(testCase);
					}
				},
				error: function(e) {
					console.log(e);
				}
			});
		}

		/* =========== 분류 추가 ========= */
		function btnRouteInsert() {
			var isReadonly = $('#testCaseRouteCustomer').prop('readonly');
			var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();

			if (!isReadonly) {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사, 비고 입력 및 확정 후 사용 바랍니다.',
				});
				return false;
			} 

			var path = getCurrentPath();

			$.ajax({
				type: 'POST',
				url: "<c:url value='/testCase/insertRouteView'/>",
				data: {
					"testCaseRouteFullPath" : path,
					"testCaseFormKeyNum" : testCaseFormKeyNum,
				},
				async: false,
				success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
					$.modal(data, 's'); //modal창 호출
				},
				error: function(e) {
					console.log(e);
				}
			});
		}

		/* =========== RouteFullPath 분류 가져오기 ========= */
		function getCurrentPath() {
			var node = $("#tree").dynatree("getActiveNode");
			if (node != null )
				return node.data.key;
			else
				return '/';
		}

		/* =========== 현재 디렉토리 다시 불러오기 ========= */
		function reloadView()
		{
			var node = $("#tree").dynatree("getActiveNode");
			if ( node != null ) {
				$('#tree').dynatree('getTree').reactivate(true);
			} else {
				reqRootNode();
			}
		}

		/* =========== 분류 삭제 ========= */
		function btnRouteDelect() {
			var node = $("#tree").dynatree("getActiveNode");
			var testCaseRouteFullPath = node.data.key;
			var testCaseRouteKeyNum = $('#testCaseRouteKeyNum').val();
			Swal.fire({
				  title: '삭제!',
				  text: "선택한 분류를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  	if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/testCase/deleteRoute'/>",
						type: "POST",
						data: {
							"testCaseRouteFullPath" : testCaseRouteFullPath,
							"testCaseRouteKeyNum" : testCaseRouteKeyNum,
						},
						dataType: "json",
						async: false,
						success: function(data) {
							if(data.result == "OK"){
								Swal.fire({
									icon: 'success',
									title: '성공!',
									text: '작업을 완료했습니다.',
								});
								reloadParent();
								remakeIcon();
							} else if(data.result == "SubRoute") {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '하위분류가 존재합니다.',
								});
							}
						},
						error: function(e) {
							console.log(e);
						}
					});
			  	}
			});
		}

		/* =========== 상위 디렉토리 다시 불러오기 (현재 디렉토리 삭제, 이름변경, 추가 등) ========= */
		function reloadParent()
		{
			var path = getParentPath();
			if ( path != '/' ) {
				$("#tree").dynatree("getTree").activateKey(path);
			} else {
				reqRootNode();
			}
		}

		/* =========== 부모 분류 위치 ========= */
		function getParentPath() {
			var path = getCurrentPath();

			var pos = path.lastIndexOf('/');
			if ( pos > 0 ) {
				return path.substring(0, pos);
			} else {
				return '/';
			}
		}


		/* =========== 분류 수정 ========= */
		function btnRouteUpdate() {
			var path = getCurrentPath();

			$.ajax({
				type: 'POST',
				url: "<c:url value='/testCase/updateRouteView'/>",
				data: {"testCaseRouteFullPath" : path},
				async: false,
				success: function (data) {
					if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
					$.modal(data, 's'); //modal창 호출
				},
				error: function(e) {
					console.log(e);
				}
			});
		}

	</script>

	<script>
		$('#btnTestCaseConfirmed').click(function() {
			var testCaseRouteCustomer = $('#testCaseRouteCustomer').val();
			var testCaseRouteNote = $('#testCaseRouteNote').val();
			var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();

			if(testCaseRouteCustomer == "") {
				$('#NotCustomer').show();
				return false;
			} else {
				$('#NotCustomer').hide();
			}

			if(testCaseRouteNote == "") {
				$('#NotNote').show();
				return false;
			} else {
				$('#NotNote').hide();
			}

			Swal.fire({
				  title: '확정!',
				  text: "확정 이후 변동이 불가능합니다. 계속 진행하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  	if (result.isConfirmed) {
					$.ajax({
						type: 'POST',
						url: "<c:url value='/testCase/testCaseConfirmed'/>",
						data: {
							"testCaseRouteCustomer" : testCaseRouteCustomer,
							"testCaseRouteNote" : testCaseRouteNote,
							"testCaseFormKeyNum" : testCaseFormKeyNum,
						},
						async: false,
						success: function (result) {
							if(result == "FALSE") {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '중복된 고객사 및 비고가 존재합니다.',
								});
							} else {
								$('#testCaseRouteCustomer').prop('readonly', true);
								$('#testCaseRouteNote').prop('readonly', true);
								Swal.fire({
									icon: 'success',
									title: '확정!',
									text: '확정 되었습니다.',
								});
							}
						},
						error: function(e) {
							console.log(e);
						}
					});
				}
			});
		});
	</script>
	
	<script>
		$(function() {
			summernote();
		});

		function summernote() {
			$('.testCaseSummerNote').summernote({
				minHeight:250,
				placeholder:"",
				callbacks: {
					onKeyup: function(e) {
						var pCount = e.currentTarget.childElementCount;
						if(pCount > 41) {
						    if (e.which != 8 && e.which != 46 && e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {  
								Swal.fire({
									icon: 'error',
									title: '범위 초과!',
									text: '입력 범위를 초과하였습니다.',
								});
						    }
						}
				    }
				}
			});
		}

		function BtnContentsInsert() {
			var testCaseRouteKeyNum = $('#testCaseRouteKeyNum').val();
			var testCaseRouteName = $("#testCaseRouteName").val();
			var testCaseFormKeyNum = $('#testCaseFormKeyNum').val();
			if(testCaseRouteName == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '항목을 선택해주세요.',    
				}); 
				return false;
			}

			$.ajax({
				type: 'POST',
				url: "<c:url value='/testCase/testCaseContentsInsert'/>",
				data: {
					"testCaseRouteKeyNum" : testCaseRouteKeyNum,
					"testCaseFormKeyNum" : testCaseFormKeyNum,
				},
				async: false,
				success: function (result) {
					if(result.result == "FALSE") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '내용은 하나의 항목에 한개의 내용만 추가 가능합니다.',
						});
					} else {
						contentView(result.testCase);
					}
				},
				error: function(e) {
					console.log(e);
				}
			});
		}

		function btnContentSave() {
			var postData = $('#contentsForm').serializeArray();
			postData.push({name : "testCaseRouteKeyNum", value : $('#testCaseRouteKeyNum').val()});
			$.ajax({
				url: "<c:url value='/testCase/testCaseContentsUpdate'/>",
	        	type: 'post',
	        	data: postData,
	        	async: false,
	        	success: function(result) {     	
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '저장 완료했습니다.',
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '작업을 실패하였습니다.',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
	    	});
		}

		/* =========== Ctrl + S 사용시 저장 ========= */
		document.onkeydown = function(e) {
		    if (e.which == 17)  isCtrl = true;
		    if (e.which == 83 && isCtrl == true) {  // Ctrl + s
		    	btnContentSave();
		    	isCtrl = false;
		    	return false;
		    }
		}
		document.onkeyup = function(e) {
			if (e.which == 17)  isCtrl = false;
		}

		function BtnContentsDelete() {
			var testCaseRouteKeyNum = $('#testCaseRouteKeyNum').val();
			Swal.fire({
				  title: '삭제!',
				  text: "테스트 케이스 내용을 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  	if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/testCase/testCaseContentsDelete'/>",
	        			type: 'post',
	        			data: {
							"testCaseRouteKeyNum" : testCaseRouteKeyNum,
						},
	        			async: false,
	        			success: function(result) {     	
							if(result == "OK") {
								Swal.fire({
									icon: 'success',
									title: '성공!',
									text: '삭제 완료했습니다.',
								});
								$('#testCaseContentsView').remove();
							} else {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '작업을 실패하였습니다.',
								});
							}
						},
						error: function(error) {
							console.log(error);
						}
	    			});
				}
			});
		}

		function contentView(testCase) {
			var table = $("#testCaseContents");
			var rowItem = "<div id='testCaseContentsView'>";
			rowItem += "<form id='contentsForm' name='form' method ='post'>";
			rowItem += "<table class='testCaseTable'>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>대메뉴</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsMainMenu' name='testCaseContentsMainMenu' value='"+testCase.testCaseContentsMainMenu+"'></td>";
			rowItem += "<td class='testCaseMenu'>중메뉴</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsMediumMenu' name='testCaseContentsMediumMenu' value='"+testCase.testCaseContentsMediumMenu+"'></td>";
			rowItem += "<td class='testCaseMenu'>소메뉴</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsSmallMenu' name='testCaseContentsSmallMenu' value='"+testCase.testCaseContentsSmallMenu+"'></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>TC코드</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsTcCode' name='testCaseContentsTcCode' value='"+testCase.testCaseContentsTcCode+"'></td>";
			rowItem += "<td class='testCaseMenu'>적용 분류코드</td>";
			rowItem += "<td colspan='3' class='testCaseTd'><textarea class='testCaseTextarea' id='testCaseContentsClassificationCode' name='testCaseContentsClassificationCode'>"+testCase.testCaseContentsClassificationCode+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>테스트 목적</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseTextarea' id='testCaseContentsPurpose' name='testCaseContentsPurpose'>"+testCase.testCaseContentsPurpose+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>사전 테스트 준비</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseTextarea' id='testCaseContentsPreparation' name='testCaseContentsPreparation'>"+testCase.testCaseContentsPreparation+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>하위 테스트 항목</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseTextarea' id='testCaseContentsItem' name='testCaseContentsItem'>"+testCase.testCaseContentsItem+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>테스트 절차</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseSummerNote' rows='5' id='testCaseContentsProcedure' name='testCaseContentsProcedure'>"+testCase.testCaseContentsProcedure+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>예상테스트 결과</td>";
			rowItem += "<td colspan='5'class='testCaseTd'><textarea class='testCaseSummerNote' rows='5' id='testCaseContentsExpectedResult' name='testCaseContentsExpectedResult'>"+testCase.testCaseContentsExpectedResult+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>테스트 결과</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseSummerNote' rows='5' id='testCaseContentsTestResult' name='testCaseContentsTestResult'>"+testCase.testCaseContentsTestResult+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>결과 코드</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsResultCode' name='testCaseContentsResultCode' value='"+testCase.testCaseContentsResultCode+"'></td>";
			rowItem += "<td class='testCaseMenu'>영향도</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsInfluence' name='testCaseContentsInfluence' value='"+testCase.testCaseContentsInfluence+"'></td>";
			rowItem += "<td class='testCaseMenu'>테스트 담당자</td>";
			rowItem += "<td class='testCaseTd'><input class='testCaseInput' id='testCaseContentsManager' name='testCaseContentsManager' value='"+testCase.testCaseContentsManager+"'></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>오류 증상</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseTextarea' id='testCaseContentsError' name='testCaseContentsError'>"+testCase.testCaseContentsError+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr class='testCaseTr'>";
			rowItem += "<td class='testCaseMenu'>비고</td>";
			rowItem += "<td colspan='5' class='testCaseTd'><textarea class='testCaseTextarea' id='testCaseContentsNote' name='testCaseContentsNote'>"+testCase.testCaseContentsNote+"</textarea></td>";
			rowItem += "</tr>";
			rowItem += "</table>";
			rowItem += "</form>";
			rowItem += "<div class='testCaseSaveDiv'>";
			rowItem += "<button type='button' class='btn btn-default btn-outline-info-add' id='btnContentSave' onclick='btnContentSave();'>SAVE</button>";
			rowItem += "</div>";
			rowItem += "</div>";
			table.append(rowItem);
			summernote();
		}
	</script>



	<style>
		.testCaseContents {
			height: 655px;
			margin: 2%;;
		}

		.testCaseMenu {
			background-color: #ad6868;
			width: 130px;
    		text-align: center;
    		color: white;
			font-weight: bold;
			border: 1px solid #a97a7a;
		}

		.testCaseTr {
			height: 70px;
		}

		.testCaseTd {
			border: 1px solid #a97a7a;
		}

		.testCaseTable {
			width: 100%;
    		height: 100%;
    		border: 1px solid #a97a7a;
		}

		.testCaseInput {
			text-align: center;
    		width: 100%;
			height: 100%;
			border: 0;
		}

		.testCaseTextarea {
			padding: 1%;
    		width: 100%;
			height: 100%;
			border: 0;
		}

		.testCaseSaveDiv {
			padding-top: 10px;
    		padding-bottom: 10px;
    		text-align: right;
		}

		ul.dynatree-container li {
			padding: 5% !important;
			font-size: 16px !important;
		}
	</style>
</html>