<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<div class="modelHeadFont">폴더 선택</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 350px;">
	<div class="backgroundWhite" style="overflow:scroll; height:100%;">
		<div class="margin10">
			<!----------------------- dynatree ----------------------->
			<div id="treeView"></div>
			<!----------------------- dynatree ----------------------->
		</div>
	</div>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="select" onClick="select()">선택</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== 트리 선택 ========= */
	function select() {
		var chkList = $("#list").getGridParam('selarrrow');
		var node = $("#treeView").dynatree("getActiveNode");
		var individualNoteTreeFullPath = node.data.key; // 선택 트리 풀 경로
		var individualNoteTreeName = node.data.title; // 선택 트리
		$.ajax({
		    url: "<c:url value='/employee/individualNoteTreeMove'/>",
		    type: "POST",
			data: {
					chkList : chkList,
					"individualNoteTreeFullPath" : individualNoteTreeFullPath,
					"individualNoteTreeName" : individualNoteTreeName
				},
			dataType: "text",
			traditional: true,
			async: false,
		    success: function (data) {
		    	if(data == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						//tableRefresh();
						reqMemberView();
					});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
		    },
		    error: function(e) {
		    	console.log(e);
		    }
		});
	}
	
	/* =========== Tree 시작 ========= */
	$(document).ready(function() {
		createTreeView();
		
	});

	/* =========== 트리 컨트롤러 생성 ========= */
	function createTreeView()
	{
		$("#treeView").dynatree({
			onActivate: function(node) {
				var path = node.data.key;
				reqChildNodeView(node, path);
			},
			onQueryExpand: function(flag, node) {
				if(flag) {
					$('#treeView').dynatree('getTree').activateKey(node.data.key);
				}
			}
		});
	
		var root = $("#treeView").dynatree("getRoot");
		var rootNode = root.addChild({
			title : '/',
			tooltip : '/',
			key : '/',
			children: {title: 'Loading...', icon: 'loading.gif', noLink: true},
			isFolder : true
		});
	
		reqRootNodeView();
	}
	
	/* =========== 트리 루트노드 데이터 요청 ========= */
	function reqRootNodeView()
	{
		var rootNode = $("#treeView").dynatree("getTree").selectKey('/');
		reqChildNodeView(rootNode, '/');
	}
	
	/* =========== 트리 하위노드 데이터 요청 ========= */
	function reqChildNodeView(node, path)
	{
		$.ajax({
			url: "<c:url value='/individualNoteTree/list'/>",
			type: "POST",
			data: {"parentPath" : path},
			dataType: "json",
			success: function(data)
			{
				var treeView = $("#treeView").dynatree("getTree");
				node.removeChildren();

				if(data != null && data.length > 0)
				{
					/* ===================== */
					treeView.enableUpdate(false);
					/* ===================== */

					for(var i = 0; i < data.length; i++)
					{
						var childNode = node.addChild({
							title : data[i].individualNoteTreeName,
							tooltip : data[i].individualNoteTreeName,
							key : data[i].individualNoteTreeFullPath,
							children: {title: 'Loading...', icon: 'loading.gif', noLink: true},
							isFolder : true
						});
					}
					
					/* ===================== */
					treeView.enableUpdate(true);
					/* ===================== */

					node.expand(true);
				}
				else
				{
					node.expand(false); // for IE7
				}

				/* if (path != '/') reqMemberView(path); */
			},
			error: function(e) {
	        	console.log(e);
	        }
		});
	}
	
	/* =========== 디렉토리에 해당하는 사용자 목록 요청 ========= */
	function reqMemberView()
	{
		var node = $("#tree").dynatree("getActiveNode");
		var path = node.data.key; // 선택 트리 풀 경로
		var title = node.data.title; // 선택 트리
		$("#individualNoteTreeName").val(title); //트리경로
		$("#individualNoteTreeFullPath").val(path); // 트리 풀 경로

		var postData = $("#form").serializeObject();
		var jqGrid = $("#list");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ datatype: 'json', postData: postData });
		jqGrid.trigger('reloadGrid');
	}
</script>