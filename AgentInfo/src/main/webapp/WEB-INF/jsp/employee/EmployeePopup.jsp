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
						{name:'employeeId', index:'employeeId', align:'center', width: 170},
						{name:'departmentName', index:'departmentName', align:'center', width: 170},
						{name:'employeeName', index:'employeeName',align:'center', width: 100, formatter: linkFormatter},
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
			        height : '570',
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
				<div class="pcoded-main-container" style="margin-top: 7px;">
					<div class="main-body">
						<table class="fullTable" style="width:100%; float:left">
							<tbody><tr>
								<td style="padding:0px 0px 0px 0px;" class="box">
									<table class="departmentTable" style="width:19%;float:left">
										<tbody>
											<tr>
												<td valign="top">
													<div class="border1" style="overflow:scroll; height:640px; margin-top: 33px;">
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
									<table class="employeeTable" style="width:79.5%; float:right;">
										<tbody>
											<tr>
												<td><form id="form" name="form" method ="post" onsubmit="return false;">
													<input class="form-control integratedInput" type="text" id="employeeName" name="employeeName" placeholder='사원명' style="width: 30% !important;">
													<input type="hidden" id="departmentName" name="departmentName" class="form-control">
		                      						<input type="hidden" id="departmentFullPath" name="departmentFullPath" class="form-control">
												</form></td>
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
	</body>

	<script>
		
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
			return '<a onclick="selectBtn('+"'"+rowdata.employeeId+"',"+"'"+rowdata.employeeName+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
			}
		});
		
		$('#employeeName').on('input', function() {
		    let keyword = $(this).val();
		    tableRefresh();
		});

		function selectBtn(employeeId, employeeName) {
			if (window.opener && !window.opener.closed) {
				var selectType = "${selectType}";
				if(selectType === "salesManager") {
        			window.opener.setSalesManager(employeeId, employeeName);
				} else {
					window.opener.setRequester(employeeId, employeeName);
				}
			}
        	window.close();
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

	</script>
	<style>
		.integratedInput {
			float: right;
			width: 20%;
		}
	</style>
</html>