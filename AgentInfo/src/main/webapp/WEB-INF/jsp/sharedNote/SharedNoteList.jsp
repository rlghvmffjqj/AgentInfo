<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- dynatree -->
		<script type="text/javascript" src="<c:url value='/js/dynatree/src/jquery.dynatree.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/dynatree/src/skin-vista/ui.dynatree.css'/>">
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','sharedNote');
		    });
		</script>
		
		<link rel="stylesheet" type="text/css" href="<c:url value='/gridstack/gridstack.min.css'/>">
		<script type="text/javascript" src="<c:url value='/gridstack/gridstack-h5.js'/>"></script>
		
		<style type="text/css">
		  .grid-stack { background: white; min-height: 724px; }
		  .grid-stack-item-content { background-color: #FFFF88; box-shadow: 1px 1px 1px grey;}
		  .grid-stack-item-content {
		    overflow: auto;
		  }
		  .grid-stack-item-content::-webkit-scrollbar {
		    width: 10px;
		  }
		  .grid-stack-item-content::-webkit-scrollbar-thumb {
		    background-color: #2f3542;
		  }
		  .grid-stack-item-content::-webkit-scrollbar-track {
		    background-color: lightgrey;
		  }
		</style>
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
							    <div class="row align-dataList-center">
							        <div class="col-md-8">
							            <div class="page-header-title" >
							                <h5 class="m-b-10">부서 노트</h5>
							                <p class="m-b-0">Department Note</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">부서 노트</a>
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
												<input type="hidden" id="sharedNoteTreeName" name="sharedNoteTreeName" class="form-control">
		                      					<input type="hidden" id="sharedNoteTreeFullPath" name="sharedNoteTreeFullPath" class="form-control">
												<div class="col-lg-2">
	                      							<label class="labelFontSize">제목</label>
	                      							<input hidden="hidden" />
													<input type="hidden" id="sharedNoteTitle" name="sharedNoteTitle" class="form-control">
													<select class="form-control selectpicker" id="sharedNoteTitleMulti" name="sharedNoteTitleMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${sharedNoteTitle}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">해시 태그</label>
	                      							<input hidden="hidden" />
													<input type="hidden" id="sharedNoteHashTag" name="sharedNoteHashTag" class="form-control">
													<select class="form-control selectpicker" id="sharedNoteHashTagMulti" name="sharedNoteHashTagMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${sharedNoteHashTag}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
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
		                     			<table style="width:100vw;">
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table class="sharedNoteTreeTable" style="width:15%;float:left">
														<tbody>
															<tr>
																<td style="font-weight:bold;">
																	폴더관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnDepartmentInsert" onClick="btnDepartmentInsert()">추가</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnDepartmentUpdate" onClick="btnDepartmentUpdate()">수정</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnDepartmentDelect" onClick="btnDepartmentDelect()">삭제</button>
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
													<table style="width:68%; float:left; margin-left: 1%;" >
														<tbody>
															<tr>
																<td style="font-weight:bold;">노트 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert" onclick="addWidget()">추가</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnSave" onclick="BtnSave()">저장</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnExplanation" onclick="BtnExplanation()">사용 설명서</button>
																</td>
															</tr>
															<tr>
																<td class="border1" colspan="2">
																	<div class="grid-stack"></div>
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

	<script type="text/javascript">
		/* =========== 로딩시 실행 ========= */
		var grid = GridStack.init({
		  float: false,
		  disableOneColumnMode: true, 
		  autoPosition: true,
		  acceptWidgets: true,
		  cellHeight: 100
		});
		
		/* 
		var items = [
			<c:forEach items="${list}" var="item">
				{keynum: "${item.sharedNoteKeyNum}", title: "${item.sharedNoteTitle}", contents: '${item.sharedNoteContents}', hashTag: '${item.sharedNoteHashTag}'},
			</c:forEach>
		];
		
		items.forEach(n => {
			n.content = "<div style='background-color:"+ n.backgroundColor + "; padding-bottom: 1px; height:100%; padding-left: 5px;'><a href='#' onClick='sharedNoteDelete(this.parentNode.childNodes[3].value)' style='float: right; margin: 5px; font-size: 8px; padding-right: 5px;'>X</a><br><br><input type='hidden' value=" + n.keynum + "><laber style='font-weight: bold;color: mediumvioletred;'>" + n.title +"</laber>" + n.contents + "</div>";
			grid.addWidget(n); 
		}); 
		*/
		
		/* =========== 노트 추가 View ========= */
		function addWidget() {
			var sharedNoteTreeName = $("#sharedNoteTreeName").val();
			var sharedNoteTreeFullPath = $("#sharedNoteTreeFullPath").val();
			if(sharedNoteTreeName == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '폴더를 선택해주세요.',    
				}); 
			} else if(sharedNoteTreeFullPath == "/") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '루트 경로에 추가 불가능 합니다.',    
				}); 
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/sharedNote/insertView'/>",
				    data: {
			    		"sharedNoteTreeName" : sharedNoteTreeName,
			    		"sharedNoteTreeFullPath" : sharedNoteTreeFullPath
			    	},
				    async: false,
				    success: function (data) {
				    	$.modal(data, 'full'); //modal창 호출
				    },
				    error: function(e) {
				        alert(e);
				    }
				});
			}
		};
		
		/* =========== 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$('.selectpicker').val('');
			$('.filter-option-inner-inner').text('');
			stackRefresh();
		});
		
		/* =========== 새로고침 ========= */
		function stackRefresh(sharedNoteTitle) {
			$('#sharedNoteTitle').val($('#sharedNoteTitleMulti').val().join());
			$('#sharedNoteHashTag').val($('#sharedNoteHashTagMulti').val().join());
			var postDate = $("#form").serializeObject();
			grid.removeAll();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/sharedNote/search'/>",
			    data: postDate,
			    async: false,
			    success: function (data) {
			    	var items = [];
			    	for(var i=0; i<data.length; i++) {
			    		items.push({'keynum': data[i].sharedNoteKeyNum, 'title': data[i].sharedNoteTitle, 'contents': data[i].sharedNoteContents, 'hashTag': data[i].sharedNoteHashTag, 'backgroundColor': data[i].sharedNoteColor});
			    	};
			    	items.forEach(n => {
			    		n.content = "<div id='addNote"+ n.keynum + "' style='padding-bottom: 1px; height:100%; padding-left: 5px;'><a href='#' onClick='sharedNoteDelete(this.parentNode.childNodes[3].value)' style='float: right; margin: 5px; font-size: 8px; padding-right: 5px;'>X</a><br><br><input type='hidden' value=" + n.keynum + "><laber style='font-weight: bold;color: mediumvioletred;'>" + n.title +"</laber>" + n.contents + "</div>";
						grid.addWidget(n);
						document.getElementById('addNote'+n.keynum).parentNode.style.background =  n.backgroundColor;
					});
			    },
			    error: function(e) {
			        alert(e);
			    }
			});
			$(".grid-stack-item-content").on('dblclick', (e) => {
				var sharedNoteKeyNum = e.currentTarget.childNodes[0].childNodes[3].defaultValue;
				$.ajax({
				    type: 'POST',
				    data: {'sharedNoteKeyNum': sharedNoteKeyNum},
				    url: "<c:url value='/sharedNote/updateView'/>",
				    async: false,
				    success: function (data) {
				    	$.modal(data, 'full'); //modal창 호출
				    },
				    error: function(e) {
				        alert(e);
				    }
				});	
			});
		}
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var sharedNoteTitle = $('#sharedNoteTitle').val();
			stackRefresh(sharedNoteTitle);
		});
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				$('#btnSearch').trigger("click");
			}
		});
		
		/* =========== 노트 수정 View ========= */
		$(".grid-stack-item-content").on('dblclick', (e) => {
			var sharedNoteKeyNum = e.currentTarget.childNodes[0].childNodes[3].defaultValue;
			$.ajax({
			    type: 'POST',
			    data: {'sharedNoteKeyNum': sharedNoteKeyNum},
			    url: "<c:url value='/sharedNote/updateView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'full'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		});
		
		/* =========== 노트 삭제 ========= */
		function sharedNoteDelete(sharedNoteKeyNum) {
			Swal.fire({
				  title: '삭제!',
				  text: "선택한 노트를 제거하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
					url: "<c:url value='/sharedNote/delete'/>",
					data: {'sharedNoteKeyNum': sharedNoteKeyNum},
					type: "POST",
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
						$('#btnSearch').trigger("click");
					},
					error: function(error) {
						console.log(error);
					}
				  });
			  	}
			})
		}
		
		/* =========== 노트 정렬 저장 ========= */
		function BtnSave(content = true, full = true) {
			var sharedNoteTreeName = $("#sharedNoteTreeName").val();
			var sharedNoteTreeFullPath = $("#sharedNoteTreeFullPath").val();
			if(sharedNoteTreeName == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '폴더를 선택해주세요.',    
				}); 
			} else if(sharedNoteTreeFullPath == "/") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '루트 경로에 저장 불가능합니다.',    
				}); 
			} else {
				options = grid.save(content, full);
				var sharedNoteKeyNum = [];
				for(var num = 0; num<options.children.length; num++) {
					sharedNoteKeyNum.push(options.children[num].keynum);
				}
				if(sharedNoteKeyNum.length < 2) {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '노트 갯수가 두 개 이상일 경우 저장이 가능합니다.',
					});
				} else {
					$.ajax({
						url: "<c:url value='/sharedNote/save'/>",
				        type: 'post',
				        data: {
				        	'sharedNoteKeyNum': sharedNoteKeyNum
				        },
				        async: false,
				        success: function(result) {
							if(result == "OK") {
								Swal.fire({
									icon: 'success',
									title: '성공!',
									text: '작업을 완료했습니다.',
								});
				        		$('#btnReset').trigger("click");
								//stackRefresh();
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
			}
		}
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			stackRefresh();
		});

		/* =========== 사용 설명서 ========= */
		function BtnExplanation() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/individualNote/explanationView'/>",
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'explanation'); //modal창 호출
			    },
			    error: function(e) {
			    	console.log(e);
			    }
			});
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
				url: "<c:url value='/sharedNoteTree/list'/>",
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
								title : data[i].sharedNoteTreeName,
								tooltip : data[i].sharedNoteTreeName,
								key : data[i].sharedNoteTreeFullPath,
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
	
					//if (path != '/') reqMember(path);
					reqMember(path);
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
			var path = node.data.key; // 선택 폴더 풀 경로
			var title = node.data.title; // 선택 폴더
			$("#sharedNoteTreeName").val(title); //폴더경로
			$("#sharedNoteTreeFullPath").val(path); // 폴더 풀 경로
	
			$('#btnSearch').trigger("click");
		}
		
		/* =========== 폴더 추가 ========= */
		function btnDepartmentInsert() {
			var path = getCurrentPath();
	
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/sharedNoteTree/insertView'/>",
			    data: {"sharedNoteTreeFullPath" : path},
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
		
		/* =========== DepartmentFullPath 경로 가져오기 ========= */
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
		
		/* =========== 폴더 삭제 ========= */
		function btnDepartmentDelect() {
			var node = $("#tree").dynatree("getActiveNode");
			var sharedNoteTreeFullPath = node.data.key;
			var sharedNoteTreeFullPath = $("#sharedNoteTreeFullPath").val();
			
			if(sharedNoteTreeFullPath == "/") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '루트 경로는 삭제 불가능합니다.',
				});
			} else {
				Swal.fire({
					  title: '삭제!',
					  text: "선택한 폴더를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
						$.ajax({
							url: "<c:url value='/sharedNoteTree/delete'/>",
							type: "POST",
							data: {"sharedNoteTreeFullPath" : sharedNoteTreeFullPath},
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
								} else if(data.result == "SubDepartment") {
									Swal.fire({
										icon: 'error',
										title: '실패!',
										text: '하위폴더가 존재합니다.',
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
		
		/* =========== 부모 폴더 위치 ========= */
		function getParentPath() {
			var path = getCurrentPath();
	
			var pos = path.lastIndexOf('/');
			if ( pos > 0 ) {
				return path.substring(0, pos);
			} else {
				return '/';
			}
		}
		
		
		/* =========== 폴더 수정 ========= */
		function btnDepartmentUpdate() {
			var path = getCurrentPath();
			var sharedNoteTreeFullPath = $("#sharedNoteTreeFullPath").val();
			
			if(sharedNoteTreeFullPath == "/") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '루트 경로는 수정 불가능합니다.',
				});
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/sharedNoteTree/updateView'/>",
				    data: {"sharedNoteTreeFullPath" : path},
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
		}
		
		/* =========== 폴더 이동 ========= */
		function sharedNoteTreeMove() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    url: "<c:url value='/sharedNoteTree/sharedNoteTreeMoveView'/>",	
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

	<style>
		.ui-droppable {
			height: 725px !important;
			overflow: scroll;
		}
	</style>
</html>