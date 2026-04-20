<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- dynatree -->
		<script type="text/javascript" src="<c:url value='/js/dynatree/src/jquery.dynatree.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/dynatree/src/skin-vista/ui.dynatree.css'/>">
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','selenium');
		    });
	    </script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/selenium'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','타이틀','URL 주소','상세 메모'],
					colModel:[
						{name:'seleniumKeyNum', index:'seleniumKeyNum', align:'center', width: 35, hidden:true },
						{name:'seleniumTitle', index:'seleniumTitle', align:'center', width: 300, formatter: linkFormatter},
						{name:'seleniumAddress', index:'seleniumAddress', align:'center', width: 250},
						{name:'seleniumDetailNote', index:'seleniumDetailNote', align:'center', width: 1000},
					],
					jsonReader : {
			        	id: 'seleniumKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'seleniumKeyNum',	// 기본 정렬 
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
				loadColumns('#list','seleniumList');
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
												<h5 class="m-b-10">자동화 테스트</h5>
												<p class="m-b-0">Automated Testing</p>
											</div>
										</div>
										<div class="col-md-4">
											<ul class="breadcrumb-title">
												<li class="breadcrumb-item">
													<a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
												</li>
												<li class="breadcrumb-item"><a href="#!">자동화 테스트</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="pcoded-inner-content">
								<div class="main-body">
									<div class="page-wrapper">
										<div>
											<div class="card">
												<div class="card-header" style="float: left;">
													<div style="float: left;">
														<h4>자동화 테스트 도구</h4>
														<h5 class="colorRed">그룹으로 구분하여 자동화 테스트를 제공합니다.</h5>
													</div>
												</div>

												
	                                			<div class="searchbos">
	                                				<form id="form" name="form" method ="post">
														<input type="hidden" id="seleniumGroupName" name="seleniumGroupName" class="form-control">
		                      							<input type="hidden" id="seleniumGroupFullPath" name="seleniumGroupFullPath" class="form-control">
	                      								<div class="col-lg-2">
	                      									<label class="labelFontSize">타이틀</label>
	                      									<input type="text" id="seleniumTitle" name="seleniumTitle" class="form-control">
	                      								</div><div class="col-lg-2">
	                      									<label class="labelFontSize">URL주소</label>
	                      									<input type="text" id="seleniumAddress" name="seleniumAddress" class="form-control">
	                      								</div>
														<div class="col-lg-2">
	                      									<label class="labelFontSize">상세 메모</label>
	                      									<input type="text" id="seleniumDetailNote" name="seleniumDetailNote" class="form-control">
	                      								</div>
		                      								<div class="col-lg-12 text-right">
																<p class="search-btn" style="margin-top: 10px;">
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
											<form id="form" name="form" method ="post">
											</form>
											<table style="width:99%;">
												<tbody>
													<tr>
														<td style="padding:0px 0px 0px 0px;" class="box">
															<table class="seleniumGroupTable" style="width:19%;float:left">
																<tbody>
																	<tr>
																		<td style="font-weight:bold;">
																			테스트 그룹관리 :
																			<button class="btn btn-outline-info-add myBtn" id="BtnSeleniumGroupInsert" onClick="btnSeleniumGroupInsert()">추가</button>
																			<button class="btn btn-outline-info-nomal myBtn" id="BtnSeleniumGroupUpdate" onClick="btnSeleniumGroupUpdate()">수정</button>
																			<button class="btn btn-outline-info-del myBtn" id="BtnSeleniumGroupDelect" onClick="btnSeleniumGroupDelect()">삭제</button>
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
															<table style="width:80%; float:right;">
															<tbody>
																<tr>
																	<td style="font-weight:bold;">테스트 항목관리 :
																		<button class="btn btn-outline-info-add myBtn" id="createButton">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="deleteButton">삭제</button>
																		<button class="btn btn-outline-info-nomal myBtn" onclick="seleniumCopy()">자동화 복사</button>
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
		</div>
	</body>
	<script>
		$('#createButton').click(function() {	
			var seleniumGroupName = $("#seleniumGroupName").val();
			var seleniumGroupFullPath = $("#seleniumGroupFullPath").val();
			if(seleniumGroupName == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '테스트 그룹을 선택해주세요.',    
				}); 
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/selenium/startView'/>",
					data: {
				    		"seleniumGroupName" : seleniumGroupName,
				    		"seleniumGroupFullPath" : seleniumGroupFullPath
				    	},
				    async: false,
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'selenium'); //modal창 호출
				    },
				    error: function(e) {
				        // TODO 에러 화면
						console.log(e);
				    }
				});	
			}
		});

		$('#deleteButton').click(function() {
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
					  text: "선택한 테스트 항목을 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/selenium/delete'/>",
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

		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.seleniumKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function updateView(seleniumKeyNum) {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/selenium/updateView'/>",
			    async: false,
				data: {"seleniumKeyNum": seleniumKeyNum},
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'selenium'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
					console.log(e);
			    }
			});	
		}

		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}

		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();
		});

		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$("input[type='hidden']").val("");
			$("select").each(function(index){
				$("option:eq(0)",this).prop("selected",true);
			});
			reqRootNode();
			tableRefresh();
		});

		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
			}
		});

		function seleniumCopy() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/seleniumGroup/seleniumGroupCopyView'/>",
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
			}
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
		function reqChildNode(node, path)
		{
			$.ajax({
				url: "<c:url value='/seleniumGroup/list'/>",
				type: "POST",
				data: {"parentPath" : path},
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
								title : data[i].seleniumGroupName,
								tooltip : data[i].seleniumGroupName,
								key : data[i].seleniumGroupFullPath,
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
		
		/* =========== 디렉토리에 해당하는 사용자 목록 요청 ========= */
		function reqMember(path)
		{
			var node = $("#tree").dynatree("getActiveNode");
			var path = node.data.key; // 선택 그룹 풀 경로
			var title = node.data.title; // 선택 그룹
			$("#seleniumGroupName").val(title); //그룹경로
			$("#seleniumGroupFullPath").val(path); // 그룹 풀 경로
	
			var postData = $("#form").serializeObject();
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ datatype: 'json', postData: postData });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== 그룹 추가 ========= */
		function btnSeleniumGroupInsert() {
			var path = getCurrentPath();
			
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/seleniumGroup/insertView'/>",
			    data: {"seleniumGroupFullPath" : path},
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
		
		/* =========== SeleniumGroupFullPath 경로 가져오기 ========= */
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
		
		/* =========== 그룹 삭제 ========= */
		function btnSeleniumGroupDelect() {
			var node = $("#tree").dynatree("getActiveNode");
			var seleniumGroupFullPath = node.data.key;
			
			if(seleniumGroupFullPath == "/") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '루트 경로는 삭제가 불가능합니다.',
				});
				return false;
			}

			Swal.fire({
				  title: '삭제!',
				  text: "선택한 그룹를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/seleniumGroup/delete'/>",
						type: "POST",
						data: {"seleniumGroupFullPath" : seleniumGroupFullPath},
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
							} else if(data.result == "SubSeleniumGroup") {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '하위그룹가 존재합니다.',
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
		
		/* =========== 부모 그룹 위치 ========= */
		function getParentPath() {
			var path = getCurrentPath();
	
			var pos = path.lastIndexOf('/');
			if ( pos > 0 ) {
				return path.substring(0, pos);
			} else {
				return '/';
			}
		}
		
		
		/* =========== 그룹 수정 ========= */
		function btnSeleniumGroupUpdate() {
			var path = getCurrentPath();

			if(path == "/") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '루트 경로는 수정이 불가능합니다.',
				});
				return false;
			}
	
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/seleniumGroup/updateView'/>",
			    data: {"seleniumGroupFullPath" : path},
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
		
		/* =========== 그룹 이동 ========= */
		function seleniumGroupMove() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    url: "<c:url value='/seleniumGroup/seleniumGroupMoveView'/>",
				    type: "POST",
					dataType: "text",
					traditional: true,
				    async: false,
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'sl'); //modal창 호출
				    },
				    error: function(e) {
				    	console.log(e);
				    }
				});
			}
		}
	</script>
</html>