<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="<c:url value='/js/dynatree/src/jquery.dynatree.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/dynatree/src/skin-vista/ui.dynatree.css'/>">

<div class="modal-body" style="width: 100%; height:400px;">
	<form id="modalForm" name="form" method ="post">
		<div class="margin10">
			<!----------------------- dynatree ----------------------->
			<div id="tree" style="width: 100px;"></div>
			<!----------------------- dynatree ----------------------->
		</div>
		<input type="hidden" id="menuDept" name="menuDept">
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="selectBtn">선택</button>
    <button class="btn btn-default btn-outline-info-nomal" id="closeBtn">닫기</button>
</div>

<script>
	/* =========== Tree 시작 ========= */
	$(document).ready(function() {
		createTree();
	});

	/* =========== 트리 컨트롤러 생성 ========= */
	function createTree()
	{
		$("#tree").empty();

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
	function reqMember(path) {
		$("#menuDept").val(path);
	}

	var menuSetting = {
		menuType: '${menuSetting.menuType}',
		menuParentKeyNum: '${menuSetting.menuParentKeyNum}',
		menuSort: '${menuSetting.menuSort}',
		menuTitle: '${menuSetting.menuTitle}',
		viewType: '${menuSetting.viewType}',
		menuDept: '${menuSetting.menuDept}',
		menuKeyNum: '${menuSetting.menuKeyNum}'
	}

	$('#selectBtn').click(function() {
		menuSetting.menuDept = $('#menuDept').val();
		var postData = menuSetting;

		$('#modal').modal("hide"); // 모달 닫기
		$('#modal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
		    $.ajax({
		        type: 'POST',
		        url: "<c:url value='/menuSetting/menuDeptSelect'/>",
		        data: postData,
		        async: false,
		        success: function (data) {
		            $.modal(data, 'menuSetting'); //modal창 호출
		        },
		        error: function(e) {
		            alert(e);
		        }
		    });
		});
	});

	$('#closeBtn').click(function() {
		var postData = menuSetting;

		$('#modal').modal("hide"); // 모달 닫기
		$('#modal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
		    $.ajax({
		        type: 'POST',
		        url: "<c:url value='/menuSetting/menuDeptSelect'/>",
		        data: postData,
		        async: false,
		        success: function (data) {
		            $.modal(data, 'menuSetting'); //modal창 호출
		        },
		        error: function(e) {
		            alert(e);
		        }
		    });
		});
	});
</script>
<style>
	#tree ul > li {
		margin: 5px !important;
	}
</style>