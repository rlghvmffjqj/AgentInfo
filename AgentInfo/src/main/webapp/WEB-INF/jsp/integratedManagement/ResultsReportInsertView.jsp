<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(document).ready(function(){
		var formData = $('#form').serializeObject();
		$("#resultsReportList").jqGrid({
			url: "<c:url value='/resultsReport'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['문서 번호','고객사명','의뢰자','검증자','검토자','문서 작성일','테스트 일정','템플릿 적용 여부','노트'],
			colModel:[
				{name:'resultsReportNumber', index:'resultsReportNumber', align:'center', width: 200},
				{name:'resultsReportCustomerName', index:'resultsReportCustomerName', align:'center', width: 200},
				{name:'resultsReportClient', index:'resultsReportClient', align:'center', width: 200},
				{name:'resultsReportVerifier', index:'resultsReportVerifier', align:'center', width: 120},
				{name:'resultsReportReviewer', index:'resultsReportReviewer', align:'center', width: 120},
				{name:'resultsReportDate', index:'resultsReportDate', align:'center', width: 200},
				{name:'resultsReportTestDate', index:'resultsReportTestDate', align:'center', width: 200},
				{name:'resultsReportTemplate', index:'resultsReportTemplate', align:'center', width: 100, hidden:true},
				{name:'resultsreportDelNote', index:'resultsreportDelNote', align:'center', width: 250},
			],
			jsonReader : {
	        	id: 'resultsReportKeyNum',
	        	repeatitems: false
	        },
	        pager: '#resultsReportPager',			// 페이징
	        rowNum: 22,					// 보여중 행의 수
	        sortname: 'resultsReportKeyNum',	// 기본 정렬 
	        sortorder: 'desc',			// 정렬 방식
	        viewrecords: false,			// 시작과 끝 레코드 번호 표시
	        gridview: true,				// 그리드뷰 방식 랜더링
	        sortable: true,				// 컬럼을 마우스 순서 변경
	        height : '600',
	        autowidth:true,				// 가로 넒이 자동조절
	        shrinkToFit: false,			// 컬럼 폭 고정값 유지
	        altRows: false,				// 라인 강조
		}); 
	});
	
	$('#modal').on('shown.bs.modal', function () {
	    $("#resultsReportList").jqGrid('setGridWidth', $(".modal-body").width());
	});
</script>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 40vw;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 70px;">
			<div class="col-lg-2">
				<label class="labelFontSize">문서 번호</label>
				<input type="text" id="resultsReportNumber" name="resultsReportNumber" class="form-control noneBorder">
			</div>
	    	<div class="col-lg-2">
	    		<label class="labelFontSize">고객사명</label>
				<input type="text" id="resultsReportCustomerName" name="resultsReportCustomerName" class="form-control noneBorder">
			</div>
			<div class="col-lg-2">
				<label class="labelFontSize">의뢰자</label>
				<input type="text" id="resultsReportClient" name="resultsReportClient" class="form-control noneBorder">
			</div>
			<div class="col-lg-2">
	    		<label class="labelFontSize">검증자</label>
	    		<input type="text" id="resultsReportVerifier" name="resultsReportVerifier" class="form-control noneBorder">
	    	</div>
		</div>
		<!------- Grid ------->
		<div class="jqGrid_wrapper" style="display: table;">
			<table id="resultsReportList"></table>
			<div id="resultsReportPager"></div>
		</div>
		<!------- Grid ------->
        <input type="hidden" id="packagesKeyNum" name="packagesKeyNum" value="${integratedManagement.packagesKeyNum}">
        <input type="hidden" id="integratedManagementType" name="integratedManagementType" value="${integratedManagement.integratedManagementType}">
		<input type="hidden" id="resultsReportTemplate" name="resultsReportTemplate" class="form-control">
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" onClick="BtnSelect()">선택</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>	
	function BtnSelect() {
		var postData = $('#modalForm').serializeObject();
		var resultsReportKeyNum = $("#resultsReportList").jqGrid('getGridParam', 'selrow'); 
		postData.resultsReportKeyNum = resultsReportKeyNum;

		if(packagesKeyNum == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '결과보고서를 선택 바랍니다.',    
			});  
		} else {
			$.ajax({
				url: "<c:url value='/integratedManagement/resultsReportSelect'/>",
			    type: 'post',
			    data: postData,
			    async: false,
			    success: function (result) {
					if(result != "") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$('#modal').modal("hide"); // 모달 닫기
	    	        	$('#modal').on('hidden.bs.modal', function () {
	    	        		$('#resultsReportDiv').empty().append(result);
							$('#resultsReportDiv input').prop('disabled', true);
							$('#resultsReportKeyNum').val(resultsReportKeyNum);
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

	$(document).on('input', '#resultsReportNumber', function() {
	    let keyword = $(this).val();
	    resultsReportListRefresh();
	});

	$(document).on('input', '#resultsReportCustomerName', function() {
	    let keyword = $(this).val();
	    resultsReportListRefresh();
	});

	$(document).on('input', '#resultsReportClient', function() {
	    let keyword = $(this).val();
	    resultsReportListRefresh();
	});

	$(document).on('input', '#resultsReportVerifier', function() {
	    let keyword = $(this).val();
	    resultsReportListRefresh();
	});

	/* =========== 테이블 새로고침 ========= */
	function resultsReportListRefresh() {		
		var _postDate = $("#modalForm").serializeObject();
		
		var jqGrid = $("#resultsReportList");
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