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
		    	$.cookie('name','employee');
		    });
		</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/employee'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['사용자ID','부서명','사원명','이메일','직급','타입','전화번호','상태','역할'],
					colModel:[
						{name:'employeeId', index:'employeeId', align:'center', width: 170, formatter: linkFormatter},
						{name:'departmentName', index:'departmentName', align:'center', width: 170},
						{name:'employeeName', index:'employeeName',align:'center', width: 100},
						{name:'employeeEmail', index:'employeeEmail', width: 200, align:'center'},
						{name:'employeeRank', index:'employeeRank', align:'center', width: 100},
						{name:'employeeType', index:'employeeType', align:'center', width: 100},
						{name:'employeePhone', index:'employeePhone', align:'center', width: 150},
						{name:'employeeStatus', index:'employeeStatus', align:'center', width: 80},
						{name:'usersRole', index:'usersRole', align:'center', width: 100},
					],
					jsonReader : {
			        	id: 'employeeId',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'employeeId', 	// 기본 정렬 
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
				loadColumns('#list','employeeList');
			});
			
			$(window).on('resize.list', function () {
			    jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() - $(".departmentTable").width() - 10);
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
									            <h5 class="m-b-10">사용자 정보</h5>
									            <p class="m-b-0">User Information</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">사원</a>
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
		                      						<input type="hidden" id="departmentName" name="departmentName" class="form-control">
		                      						<input type="hidden" id="departmentFullPath" name="departmentFullPath" class="form-control">
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사용자ID</label>
														<input type="text" id="employeeId" name="employeeId" class="form-control"> 
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">사원명</label>
		                      							<input type="text" id="employeeName" name="employeeName" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">전화번호</label>
		                      							<input type="text" id="employeePhone" name="employeePhone" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">타입</label>
		                      							<select class="form-control selectpicker" id="employeeType" name="employeeType" data-live-search="true" data-size="5">
															<option value=""></option>
															<option value="정사원">정사원</option>
															<option value="외주">외주</option>
															<option value="인턴">인턴</option>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">직급</label>
		                      							<select class="form-control selectpicker" id="employeeRank" name="employeeRank" data-live-search="true" data-size="5">
		                      								<option value=""></option>
															<option value="연구원">연구원</option>
															<option value="전임">전임</option>
															<option value="선임">선임</option>
															<option value="차장">차장</option>
															<option value="책임">책임</option>
															<option value="실장">실장</option>
															<option value="소장">소장</option>
															<option value="본부장">본부장</option>
															<option value="대표">대표</option>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">상태</label>
		                      							<select class="form-control selectpicker" id="employeeStatus" name="employeeStatus" data-live-search="true" data-size="5">
															<option value=""></option>
															<option value="재직">재직</option>
															<option value="퇴사">퇴사</option>
															<option value="휴직">휴직</option>
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
			                           	 <table class="fullTable" style="width:100%; float:left">
											<tbody><tr>
												<td style="padding:0px 0px 0px 0px;" class="box">
													<table class="departmentTable" style="width:19%;float:left">
														<tbody>
															<tr>
																<td style="font-weight:bold;">
																	부서관리 :
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
													<table class="employeeTable" style="width:80%; float:right;">
														<tbody>
															<tr>
																<td style="font-weight:bold;">사원 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnEmployeeInsert">추가</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnEmployeeDelete">삭제</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'employeeList');">컬럼 선택</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="departmentMove()">부서 이동</button>
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
		/* =========== 사원 추가 Modal ========= */
		$('#BtnEmployeeInsert').click(function() {
			var departmentName = $("#departmentName").val();
			var departmentFullPath = $("#departmentFullPath").val();
			if(departmentName == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '부서를 선택해주세요.',    
				}); 
			} else {
				$.ajax({
				    type: 'POST',
				    url: "<c:url value='/employee/insertView'/>",
				    data: {
				    		"departmentName" : departmentName,
				    		"departmentFullPath" : departmentFullPath
				    	},
				    async: false,
				    success: function (data) {
				    	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
				        $.modal(data, 'l'); //modal창 호출
				    },
				    error: function(e) {
				        // TODO 에러 화면
				    }
				});
			}
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();
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
			return '<a onclick="updateView('+"'"+rowdata.employeeId+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
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
		
		/* =========== 사원 삭제 ========= */
		$('#BtnEmployeeDelete').click(function() {
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
					  text: "선택한 사원을 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/employee/delete'/>",
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
		
		/* =========== 사원 수정 Modal ========= */
		function updateView(data) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/employee/updateView'/>",
	            data: {"employeeId" : data},
	            async: false,
	            success: function (data) {
	            	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
	                $.modal(data, 'l'); //modal창 호출
	            },
	            error: function(e) {
	                // TODO 에러 화면
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
				url: "<c:url value='/department/list'/>",
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
								title : data[i].departmentName,
								tooltip : data[i].departmentName,
								key : data[i].departmentFullPath,
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
			var path = node.data.key; // 선택 부서 풀 경로
			var title = node.data.title; // 선택 부서
			$("#departmentName").val(title); //부서경로
			$("#departmentFullPath").val(path); // 부서 풀 경로
	
			var postData = $("#form").serializeObject();
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ datatype: 'json', postData: postData });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== 부서 추가 ========= */
		function btnDepartmentInsert() {
			var path = getCurrentPath();
	
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/department/insertView'/>",
			    data: {"departmentFullPath" : path},
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
		
		/* =========== 부서 삭제 ========= */
		function btnDepartmentDelect() {
			var node = $("#tree").dynatree("getActiveNode");
			var departmentFullPath = node.data.key;
			
			if(departmentFullPath == "/") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '루트 경로는 삭제가 불가능합니다.',
				});
				return false;
			}

			Swal.fire({
				  title: '삭제!',
				  text: "선택한 부서를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/department/delete'/>",
						type: "POST",
						data: {"departmentFullPath" : departmentFullPath},
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
							} else if(data.result == "SubDepartment") {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '하위부서가 존재합니다.',
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
		
		/* =========== 부모 부서 위치 ========= */
		function getParentPath() {
			var path = getCurrentPath();
	
			var pos = path.lastIndexOf('/');
			if ( pos > 0 ) {
				return path.substring(0, pos);
			} else {
				return '/';
			}
		}
		
		
		/* =========== 부서 수정 ========= */
		function btnDepartmentUpdate() {
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
			    url: "<c:url value='/department/updateView'/>",
			    data: {"departmentFullPath" : path},
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
		
		/* =========== 부서 이동 ========= */
		function departmentMove() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				    url: "<c:url value='/department/departmentMoveView'/>",
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