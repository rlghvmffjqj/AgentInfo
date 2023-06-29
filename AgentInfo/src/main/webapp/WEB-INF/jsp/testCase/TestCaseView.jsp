<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- dynatree -->
		<script type="text/javascript" src="<c:url value='/js/dynatree/jquery.dynatree.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/dynatree/skin-vista/ui.dynatree.css'/>">

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
													<input type="text" id="testCaseRouteCustomer" name="testCaseRouteCustomer" class="form-control viewForm" value="${testCaseRouteCustomer}" <c:if test="${viewType eq 'update'}">readonly</c:if>>
												</div>
												<div class="col-lg-2">
													<label class="labelFontSize">비고</label>
													<span class="colorRed" id="NotNote" style="display: none; line-height: initial;">비고 입력 바랍니다.</span>
													<input type="text" id="testCaseRouteNote" name="testCaseRouteNote" class="form-control viewForm" value="${testCaseRouteNote}" <c:if test="${viewType eq 'update'}">readonly</c:if>>
												</div>
												<c:if test="${viewType eq 'insert'}">
													<button class="btn btn-outline-info-add myBtn" id="btnTestCaseConfirmed" style="float: right; height: 50px; width: 50px;">확정</button>
												</c:if>
			                     			</div>
											<input type="hidden" id="testCaseRouteName" name="testCaseRouteName" class="form-control">
											<input type="hidden" id="testCaseRouteFullPath" name="testCaseRouteFullPath" class="form-control">
											<input type="hidden" id="testCaseFormName" name="testCaseFormName" class="form-control" value="${testCaseFormName}">
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
																	<button class="btn btn-outline-info-add myBtn" id="BtnContentsInsert">추가</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnContentsDelete">삭제</button>
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
		
		
		/* =========== 테스트 케이스 수정 Modal ========= */
		function updateView(data) {
			location.href="<c:url value='/testCase/updateView'/>?testCaseKeyNum="+data;
		}

	</script>

	<script>
		/* =========== Tree 시작 ========= */
		$(document).ready(function() {
			createTree();
		});

		/* =========== 트리 컨트롤러 생성 ========= */
		function createTree()
		{
			$("#tree").dynatree({
				onActivate: function(node) {
					var path = node.data.key;
					reqChildNode(node, path);
				},
				onQueryExpand: function(flag, node) {
					if(flag) {
						$('#tree').dynatree('getTree').activateKey(node.data.key);
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
			var testCaseFormName = $('#testCaseFormName').val();

			$.ajax({
				url: "<c:url value='/testCase/routeList'/>",
				type: "POST",
				data: {
					"testCaseRouteParentPath" : path,
					"testCaseRouteCustomer" : testCaseRouteCustomer,
					"testCaseRouteNote" : testCaseRouteNote,
					"testCaseFormName" : testCaseFormName,
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
			$("#testCaseRouteName").val(title); //분류
			$("#testCaseRouteFullPath").val(path); // 분류 풀 분류

			console.log($("#tree"));
			console.log(node);

			// $.ajax({
			// 	type: 'POST',
			// 	url: "<c:url value='/testCase/testCaseContents'/>",
			// 	data: {"testCaseRouteFullPath" : path},
			// 	async: false,
			// 	success: function (data) {
			// 		if(data.indexOf("<!DOCTYPE html>") != -1) 
			// 			location.reload();
			// 		$.modal(data, 's'); //modal창 호출
			// 	},
			// 	error: function(e) {
			// 		console.log(e);
			// 	}
			// });

		}

		/* =========== 분류 추가 ========= */
		function btnRouteInsert() {
			var isReadonly = $('#testCaseRouteCustomer').prop('readonly');

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
						data: {"testCaseRouteFullPath" : testCaseRouteFullPath},
						dataType: "json",
						async: false,
						success: function(data) {
							console.log("확인"+data.result);
							if(data.result == "OK"){
								Swal.fire({
									icon: 'success',
									title: '성공!',
									text: '작업을 완료했습니다.',
								});
								reloadParent();
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
			var testCaseFormName = $('#testCaseFormName').val();

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

			
			$.ajax({
				type: 'POST',
				url: "<c:url value='/testCase/testCaseConfirmed'/>",
				data: {
					"testCaseRouteCustomer" : testCaseRouteCustomer,
					"testCaseRouteNote" : testCaseRouteNote,
					"testCaseFormName" : testCaseFormName,
				},
				async: false,
				success: function (result) {
					console.log(result);
					if(result == "FALSE") {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '중복된 고객사 및 비고가 존재합니다.',
						});
					} else {
						$('#testCaseRouteCustomer').prop('readonly', true);
						$('#testCaseRouteNote').prop('readonly', true);
					}
				},
				error: function(e) {
					console.log(e);
				}
			});

			
		});
	</script>



	<style>

	</style>
</html>