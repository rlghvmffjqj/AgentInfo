<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(function(){
		var formData = $('#form').serializeObject();
		$("#releaseList").jqGrid({
			url: "<c:url value='/packagesHistory'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['Key',/* 'OriginKey', */'고객사ID','고객사 명','사업명','망 구분','요청일자','전달일자','상태','패키지 종류','일반/커스텀'],
			colModel:[
				{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 35, hidden:true },
				/* {name:'packagesKeyNumOrigin', index:'packagesKeyNumOrigin', align:'center', width: 50, hidden:true }, */
				{name:'categoryKeyNum', index:'categoryKeyNum', align:'center', width: 70, formatter: strFormatter },
				{name:'customerName', index:'customerName', align:'center', width: 200, formatter: linkFormatter},
				{name:'businessName', index:'businessName', align:'center', width: 180},
				{name:'networkClassification', index:'networkClassification', align:'center', width: 70},
				{name:'requestDate', index:'requestDate', align:'center', width: 70},
				{name:'deliveryData', index:'deliveryData',align:'center', width: 70},
				{name:'state', index:'state',align:'center', width: 50, formatter: stateFormatter, sortable:false},
				{name:'managementServer', index:'managementServer', align:'center', width: 80},
				{name:'generalCustom', index:'generalCustom', align:'center', width: 60},
			],
			jsonReader : {
	        	id: 'packagesKeyNum',
	        	repeatitems: false
	        },
	        pager: '#releaseLPager',			// 페이징
	        rowNum: 5,					// 보여중 행의 수
	        sortname: 'packagesKeyNumOrigin',	// 기본 정렬 
	        sortorder: 'desc',			// 정렬 방식
	        
	        multiselect: true,			// 체크박스를 이용한 다중선택
	        viewrecords: false,			// 시작과 끝 레코드 번호 표시
	        gridview: true,				// 그리드뷰 방식 랜더링
	        sortable: true,				// 컬럼을 마우스 순서 변경
	        height : '150',
	        autowidth:true,				// 가로 넒이 자동조절
	        shrinkToFit: false,			// 컬럼 폭 고정값 유지
	        altRows: false,				// 라인 강조
		}); 
		loadColumns('#releaseList','packagesHistory');
	});
	
	$(window).on('resize.list', function () {
	    jQuery("#releaseList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
	});
</script>
<div class="modelHead">
	<div class="modelHeadFont">히스토리</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 740px; padding-left: 25px;">
	<div class="historyDiv" style="height: 100%;">
		패키지 배포 관리
	</div>
	<div class="historyDiv" style="height: 33.33%;">
		패키지 릴리즈
		<!------- Grid ------->
		<div class="jqGrid_wrapper">
			<table id="releaseList"></table>
			<div id="releaseLPager"></div>
		</div>
		<!------- Grid ------->
	</div>
	<div class="historyDiv" style="height: 33.33%;">이슈목록</div>
	<div class="historyDiv" style="height: 33.33%;">결과보고서</div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 상태 변경 ========= */
	function btnStateChange() {
		var chkList = $("#list").getGridParam('selarrrow');
		var statusComment = $('#summernote').val();
		var stateView = $("#stateView").val();
		
		$.ajax({
			url: "<c:url value='/packages/stateChange'/>",
			type: "POST",
			data: {
					chkList: chkList,
					"statusComment" : statusComment,
					"stateView" : stateView
				},
			dataType: "json",
			async: false,
			traditional: true,
			success: function(data) {
				if(data.result == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						tableRefresh();
					});
				} else{
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
</script>
<style>
	.historyDiv {
		border: 1px solid black;
		width: 50%;
    	float: left;
	}
</style>