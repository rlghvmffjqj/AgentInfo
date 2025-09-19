<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(document).ready(function(){
		var formData = $('#modalForm').serializeObject();
		$("#compatibilityList").jqGrid({
			url: "<c:url value='/compatibilityAll'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['Key','MenuKey','제품 구분','OS구분','패키지명',"전달위치",'날짜'],
			colModel:[
				{name:'productVersionKeyNum', index:'productVersionKeyNum', align:'center', width: 35, hidden:true},
				{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 35, hidden:true},
				{name:'mainMenuTitle', index:'mainMenuTitle', align:'center', width: 150},
				{name:'subMenuTitle', index:'subMenuTitle', align:'center', width: 100},
				{name:'packageName', index:'packageName', align:'center', width: 300, classes: 'ellipsis-cell', formatter: function(cellvalue) {return `<span title="`+cellvalue+`">`+cellvalue+`</span>`; }},
				{name:'location', index:'location', align:'center', width: 490, classes: 'ellipsis-cell', formatter: function(cellvalue) {return `<span title="`+cellvalue+`">`+cellvalue+`</span>`; }},
				{name:'packageDate', index:'packageDate', align:'center', width: 85},
			],
			jsonReader : {
	        	id: 'productVersionKeyNum',
	        	repeatitems: false
	        },
	        pager: '#compatibilitypager',			// 페이징
	        rowNum: 15,					// 보여중 행의 수
	        sortname: 'version',	// 기본 정렬 
	        sortorder: 'desc',			// 정렬 방식
	        
	        multiselect: true,			// 체크박스를 이용한 다중선택
	        viewrecords: false,			// 시작과 끝 레코드 번호 표시
	        gridview: true,				// 그리드뷰 방식 랜더링
	        sortable: true,				// 컬럼을 마우스 순서 변경
	        height : '440',
	        autowidth:true,				// 가로 넒이 자동조절
	        shrinkToFit: false,			// 컬럼 폭 고정값 유지
	        altRows: false,				// 라인 강조
			ondblClickRow: function(rowid, iRow, iCol, e) {
			    // a 태그 클릭 시에는 무시
			    if ($(e.target).is('a')) return;

			    var rowData = $(this).getRowData(rowid);
			    detailView(rowData.productVersionKeyNum);
			}

		}); 
	});
	
	$(window).on('resize.list', function () {
	    jQuery("#compatibilityList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
	});
</script>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 32vw;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 70px;">
			<div class="col-lg-2">
				<label class="labelFontSize">제품 구분</label>
				<input type="text" id="mainTitleView" name="mainTitleView" class="form-control noneBorder">
			</div>
	    	<div class="col-lg-2">
	    		<label class="labelFontSize">OS구분</label>
				<input type="text" id="subTitleView" name="subTitleView" class="form-control noneBorder">
			</div>
			<div class="col-lg-2">
				<label class="labelFontSize">패키지명</label>
				<input type="text" id="packageNameView" name="packageNameView" class="form-control noneBorder">
			</div>
			<div class="col-lg-2">
	    		<label class="labelFontSize">전달위치</label>
	    		<input type="text" id="locationView" name="locationView" class="form-control noneBorder">
	    	</div>
		</div>
		<!------- Grid ------->
		<div class="jqGrid_wrapper" style="width: 1265px;">
			<table id="compatibilityList"></table>
			<div id="compatibilitypager"></div>
		</div>
		<!------- Grid ------->
        <input type="hidden" id="packagesKeyNum" name="packagesKeyNum" value="${integratedManagement.packagesKeyNum}">
        <input type="hidden" id="integratedManagementType" name="integratedManagementType" value="${integratedManagement.integratedManagementType}">
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" onClick="BtnSelect()">선택</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>	
	function BtnSelect() {
		var postData = $('#modalForm').serializeObject();
		var ids = $("#compatibilityList").jqGrid("getGridParam", "selarrrow");
		postData.productVersionKeyNumArr = [];
		postData.menuKeyNumArr = [];
			
		ids.forEach(function(id) {
		    var row = $("#compatibilityList").jqGrid("getRowData", id);
		    postData.productVersionKeyNumArr.push(row.productVersionKeyNum);
		    postData.menuKeyNumArr.push(row.menuKeyNum);
		});

		if(packagesKeyNum == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '패키지 릴리즈를 선택 바랍니다.',    
			});  
		} else {
			$.ajax({
				url: "<c:url value='/integratedManagement/productVersionSelect'/>",
			    type: 'post',
			    data: postData,
			    async: false,
			    success: function (result) {
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$('#modal').modal("hide"); // 모달 닫기
	    	        	$('#modal').on('hidden.bs.modal', function () {
	    	        		imProductVersionListRefresh();
	    	        	});
					} else {
						Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: '작업을 실패했습니다.',    
						});  
					}
			    },
				error: function(error) {
					console.log(error);
				}
			});
		}
	};

	$(document).on('input', '#mainTitleView', function() {
	    let keyword = $(this).val();
	    compatibilityListRefresh();
	});

	$(document).on('input', '#subTitleView', function() {
	    let keyword = $(this).val();
	    compatibilityListRefresh();
	});

	$(document).on('input', '#packageNameView', function() {
	    let keyword = $(this).val();
	    compatibilityListRefresh();
	});

	$(document).on('input', '#locationView', function() {
	    let keyword = $(this).val();
	    compatibilityListRefresh();
	});

	/* =========== 테이블 새로고침 ========= */
	function compatibilityListRefresh() {		
		var _postDate = $("#modalForm").serializeObject();
		
		var jqGrid = $("#compatibilityList");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: _postDate });
		jqGrid.trigger('reloadGrid');
	}
	
</script>
<style>
	.noneBorder {
		border: 1px solid #dab17d;
	}
</style>