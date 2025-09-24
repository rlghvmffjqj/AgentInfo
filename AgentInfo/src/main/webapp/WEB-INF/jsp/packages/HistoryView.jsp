<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(function(){
		var productVersionData = $('#imProductVersionListForm').serializeObject();
		var issueData = $('#imIssueListForm').serializeObject();		
		
		$("#imProductVersionList").jqGrid({
			url: "<c:url value='/imProductVersionList/productVersion'/>",
			mtype: 'POST',
			postData: productVersionData,
			datatype: 'json',
			colNames:['Key','menuKey','패키지명','전달위치','날짜'],
			colModel:[
				{name:'productVersionKeyNum', index:'productVersionKeyNum', align:'center', width: 30, hidden:true },
				{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 30, hidden:true },
				{name:'packageName', index:'packageName', align:'center', width: 315, formatter: productVersionFormatter},
				{name:'location', index:'location', align:'center', width: 360},
				{name:'packageDate', index:'packageDate', align:'center', width: 70},
			],
			jsonReader : {
	        	id: 'productVersionKeyNum',
	        	repeatitems: false
	        },
	        // pager: '#imProductVersionPager',			// 페이징
	        rowNum: 10,					// 보여중 행의 수
	        sortname: 'productVersionKeyNum',	// 기본 정렬 
	        sortorder: 'desc',			// 정렬 방식
		
	        multiselect: true,			// 체크박스를 이용한 다중선택
	        viewrecords: false,			// 시작과 끝 레코드 번호 표시
	        gridview: true,				// 그리드뷰 방식 랜더링
	        sortable: true,				// 컬럼을 마우스 순서 변경
	        height : '360',
	        autowidth:true,				// 가로 넒이 자동조절
	        shrinkToFit: false,			// 컬럼 폭 고정값 유지
	        altRows: false,				// 라인 강조
			onSelectRow: function (rowId) {
				selectIssue();
 			}
		}); 

		$("#imIssueList").jqGrid({
			url: "<c:url value='/imIssueList/issue'/>",
			mtype: 'POST',
			postData: issueData,
			datatype: 'json',
			colNames:['Key','고객사명','타이틀','작성자','전달일자'],
			colModel:[
				{name:'issueKeyNum', index:'issueKeyNum', align:'center', width: 30, hidden:true },
				{name:'issueCustomer', index:'issueCustomer', align:'center', width: 270, formatter: issueFormatter},
				{name:'issueTitle', index:'issueTitle', align:'center', width: 330},
				{name:'issueFirstWriter', index:'issueFirstWriter', align:'center', width: 100},
				{name:'issueDate', index:'issueDate', align:'center', width: 70},
			],
			jsonReader : {
	        	id: 'issueKeyNum',
	        	repeatitems: false
	        },
	        // pager: '#imIssuePager',			// 페이징
	        rowNum: 10,					// 보여중 행의 수
	        sortname: 'issueKeyNum',	// 기본 정렬 
	        sortorder: 'desc',			// 정렬 방식
		
	        // multiselect: true,			// 체크박스를 이용한 다중선택
	        viewrecords: false,			// 시작과 끝 레코드 번호 표시
	        gridview: true,				// 그리드뷰 방식 랜더링
	        sortable: true,				// 컬럼을 마우스 순서 변경
	        height : '161',
	        autowidth:true,				// 가로 넒이 자동조절
	        shrinkToFit: false,			// 컬럼 폭 고정값 유지
	        altRows: false,				// 라인 강조
		}); 

		selectReport("${packagesKeyNum}")
		selecProductVersion();
		selectIssue();
	});
	
	$(window).on('resize.list', function () {
    	$("#imProductVersionList").jqGrid('setGridWidth', $(".page-wrapper").width());
    	$("#imIssueList").jqGrid('setGridWidth', $(".page-wrapper").width());
	});

	
</script>
<div class="modelHead">
	<div class="modelHeadFont">작업내역</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 740px; padding-left: 25px;">
	<div style="height: 710px;">
		<input type="hidden" id="resultsReportKeyNum" name="resultsReportKeyNum" class="form-control">
		<div style="height: 100%; width: 50%; float: left; border-right: 1px solid #e99b9b;">
			<div class="tableWidth" style="height: 65%; border-bottom: 1px solid #e99b9b;">
				<div class="integratedManagementDiv" style="height: 100%; ">
					<span style="font-weight:bold;">패키지 릴리즈 : </span>
					<form id="imProductVersionListForm" name="imProductVersionListForm" method ="post" style="float: left;" onsubmit="return false;">
						<input type="hidden" id="packageName" name="packageName" value="${packageName}">
						<input type="hidden" id="packagesKeyNum" name="packagesKeyNum" value="${packagesKeyNum}">
					</form>
					<!------- Grid ------->
					<div class="jqGrid_wrapper" style="padding-top: 20px; width: 795px;">
						<table id="imProductVersionList"></table>
						<!-- <div id="imProductVersionPager"></div> -->
					</div>
					<!------- Grid ------->
				</div>
			</div>
			<div class="tableWidth" style="height: 35%;">
				<div class="integratedManagementDiv" style="height: 100%;">
					<span style="font-weight:bold;">이슈목록 : </span>
					<form id="imIssueListForm" name="imIssueListForm" method ="post" style="float: left;" onsubmit="return false;">
						<input type="hidden" id="packageName" name="packageName" value="${packageName}">
						<input type="hidden" id="packagesKeyNum" name="packagesKeyNum" value="${packagesKeyNum}">
					</form>
					<!------- Grid ------->
					<div class="jqGrid_wrapper" style="padding-top: 20px; width: 795px;">
						<table id="imIssueList"></table>
						<!-- <div id="imIssuePager"></div> -->
					</div>
				</div>
			</div>
		</div>
		<div style="height: 100%; width: 50%; float: right;">
			<div class="integratedManagementDiv" style="height: 95%;">
				<span style="font-weight:bold;">결과보고서 : </span>
				<div id="resultsReportDiv"></div>
			</div>	
		</div>
	</div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	
	/* =========== 테이블 새로고침 ========= */
	function imProductVersionListRefresh() {		
		var _postDate = $("#imProductVersionListForm").serializeObject();
		var packagesKeyNum = "${packagesKeyNum}"; 
		var packageName = "${packageName}";
		_postDate.packagesKeyNum = packagesKeyNum;
		_postDate.packageName = packageName;
		
		$("#imProductVersionList").jqGrid('setGridParam', {
		    datatype: 'json',
		    postData: _postDate
		}).trigger('reloadGrid');
	}
	/* =========== 테이블 새로고침 ========= */
	function imIssueListRefresh() {		
		var _postDate = $("#imIssueListForm").serializeObject();
		var packagesKeyNum = "${packagesKeyNum}"; 
		var productVersionKeyNum = $("#imProductVersionList").jqGrid('getGridParam', 'selrow'); 
		var menuKeyNum = $("#imProductVersionList").jqGrid('getCell', productVersionKeyNum, 'menuKeyNum');
		var packageName = "${packageName}";
		_postDate.packagesKeyNum = packagesKeyNum;
		_postDate.productVersionKeyNum = productVersionKeyNum;
		_postDate.menuKeyNum = menuKeyNum;
		_postDate.packageName = packageName;
		var jqGrid = $("#imIssueList");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: _postDate });
		jqGrid.trigger('reloadGrid');
	}

	/* =========== jpgrid의 formatter 함수 ========= */
	function productVersionFormatter(cellValue, options, rowdata, action) {
		return '<a onclick="productVersionView('+"'"+rowdata.productVersionKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}
	function issueFormatter(cellValue, options, rowdata, action) {
		return '<a onclick="issueView('+"'"+rowdata.issueKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}
	function issueView(data) {
		window.open("<c:url value='/issue/updateView'/>?issueKeyNum=" + data, "_blank");
	}
	function productVersionView(data) {
	    var menuKeyNum = $("#imProductVersionList").jqGrid('getCell', data, 'menuKeyNum');

	    // 팝업용 form 생성
	    var form = $('<form>', {
	        method: 'POST',
	        action: '<c:url value="/productVersion/updateView"/>',
	        target: 'productVersionPopup'
	    });

	    // 데이터 input 추가
	    form.append($('<input>', { type: 'hidden', name: 'productVersionKeyNum', value: data }));
	    form.append($('<input>', { type: 'hidden', name: 'menuKeyNum', value: menuKeyNum }));
	    form.append($('<input>', { type: 'hidden', name: 'viewType', value: 'im' }));
		form.append($('<input>', { type: 'hidden', name: 'popup', value: 'y' }));

	    // DOM에 추가 후 submit
	    $('body').append(form);
	    window.open('', 'productVersionPopup', 'width=1000,height=700,scrollbars=yes,resizable=yes');
	    form.submit();

	    // 전송 후 폼 제거
	    form.remove();
	}


	function selectReport(packagesKeyNum) {
		var packageName = "${packageName}";
		$.ajax({
			url: "<c:url value='/integratedManagement/resultsReport'/>",
			type: "POST",
			data: {
				"packagesKeyNum": packagesKeyNum,
				"packageName": packageName
			},
			dataType: "html",
			traditional: true,
			async: false,
			success: function(data) {
				if(data == "") {
					$('#resultsReportDiv').empty();
				} else {
					$('#resultsReportDiv').empty().append(data);
					$('#resultsReportDiv input').prop('disabled', true);
				}
			},
			error: function(error) {
				console.log(error);
			}
		});
	}
	
	function selecProductVersion() {
		imProductVersionListRefresh();
	}

	function selectIssue() {
		imIssueListRefresh();
	}

	$('#resultsReportDiv').dblclick(function() {
		var packagesKeyNum = "${packagesKeyNum}"; 
		var packageName = "${packageName}";
		if(packagesKeyNum == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '패키지 배포 관리를 선택하고 확인 바랍니다.',    
			});    
		} else {
	    	var resultsReportDiv = $('#resultsReportDiv').text();
			if(resultsReportDiv == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '매핑된 결과 보고서가 존재하지 않습니다.',    
				});   
			} else {
				var resultsReportKeyNum = "";
				$.ajax({
					url: "<c:url value='/integratedManagement/resultsReportOne'/>",
					type: "POST",
					data: {
						"packagesKeyNum": packagesKeyNum,
						"packageName": packageName,
						"integratedManagementType": "resultsReport"
					},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						resultsReportKeyNum = data;
					},
					error: function(error) {
						console.log(error);
					}
				});
       			var baseUrl = "<c:url value='/resultsReport/updateView'/>";
       			var url = baseUrl + "?resultsReportNumber=" + encodeURIComponent(resultsReportKeyNum);
       			window.open(url, '_blank');
			}
		}
	});
</script>

<style>
	.integratedManagementDiv {
		width: 100%;
   		/* float: left; */
		padding: 10px;
	}
	#resultsReportDiv {
		background: white; 
		width: 100%; 
		height: 100%; 
		margin-top: 25px; 
		border: 1px solid #dfa465;
		overflow-y: scroll;
		padding: 10px;
	}
	#resultsReportDiv input:disabled {
	    background-color: white; /* 배경 흰색 */
	}
	.ui-jqgrid .ui-jqgrid-htable .ui-th-div {
		font-size: 12px;
	}
	.ui-jqgrid tr.jqgrow td, .ui-jqgrid tr.jqgroup td {
		font-size: 12px;
	}
	.ui-jqgrid .ui-jqgrid-pager .ui-paging-pager, .ui-jqgrid .ui-jqgrid-toppager .ui-paging-pager {
		font-size: 11px;
	}
	.integratedInput {
		height: 26px;
	}
</style>
<style>
	.pageBreak {
		border-bottom: 1px dotted gray;
		margin-top: 40px;
		margin-bottom: 40px;
	}
	.borderDotted {
		/* border: 1px dotted #bababa !important; */
		width: 100%;
	}
	.myBtn {
		padding: 5px 5px;
	}
	table td.selected {
		background: #afdcff70 !important;
	}
	/* input:not([disabled]) {
		background: none !important;
	} */
</style>
<style id="pdfStyle">
	div {
		font-size: 13px;
	}
	
	.middleTitle {
		margin-top: 30px;
	}
	.table1 {
		border: 1px solid black;
		width: 200px;
		padding: 5px;
		
	}
	.table2 {
		border: 1px solid black;
		width: 400px;
		padding: 5px;
	}
	.tableTd {
		border: 1px solid black;
		padding: 5px;
	}
	.tableCenter {
		text-align: center;
	}
	.pageBreak {
		page-break-before: always;
	}
	#BtnPDFexport {
		text-align: -webkit-right;
   		float: left;
   		border-radius: 0 !important;
   		font-size: 15px;
   		color: #ff1500;
   		border: 1px solid #ff0000;
		padding: 5px 7px;
	}
	#BtnPDFexport:hover {
		color: white;
		background: #4451ff;
		border: 1px solid blue;
	}
	.writeDiv {
		width: 100%;
	    height: 100%;
	    background: white;
	    min-height: 700px;
	    padding: 2%;
	}
	.title1 {
		color: red;
   		border: 10px double red;
   		padding: 10px;
   		width: 170px;
   		text-align: center;
   		float: right;
		font-size: 16px;
		font-weight: bolder;
		margin-top: 10px;
		margin-right: 10px;
	}
	.title2 {
		width: 100%;
   		text-align: center;
   		font-size: 50px;
   		font-weight: bolder;
   		color: #7F7F7F;
   		font-style: italic !important;
	}
	.title3 {
		width: 100%;
   		text-align: center;
   		font-size: 50px;
   		margin-top: 25px;
   		color: #7F7F7F;
	}
	
	.title4 {
		font-size: 25px;
		color: black;
		text-align: center;
	}
	.title5 {
		font-size: 25px;
   		color: black;
   		margin-top: 15px;
		text-align: center;
	}
	.title6 {
		font-size: 35px;
   		color: black;
	}
	.title7 {
		font-size: 20px;
   		font-weight: bold;
   		color: black;
		margin-bottom: 10px;
		text-align: center;
	}
	.title8 {
		font-size: 22px;
   		font-weight: bold;
   		margin-bottom: 20px;
	}
	.titleScope1 {
		text-align: -webkit-right;
   		width: 100%;
   		height: 130px;
	}
	.titleScope3 {
		margin-top: 200px;
		text-align: center;
	}
	.titleScope4 {
		margin-top: 250px;
		text-align: center;
	}
	.titleScope5 {
		text-align: -webkit-center;
	}
	input {
		border: none;
	}
	textarea {
		border: none;
		background-color: transparent;
	}
	.inputCenter {
		text-align: center;
	}
	.textareaDouble  {
		height: 50px;
		resize: none;
		border-radius: 50px;
	}
	input {
		width: 100%
	}
	.width10p {
		width: 10%;
	}
	.width20p {
		width: 20%;
	}
	.width15p {
		width: 15%;
	}
	.width65p {
		width: 65%;
	}
	.width35p {
		width: 35%;
	}
	.width25p {
		width: 25%;
	}
	.width70p {
		width: 70%;
	}
	.width60p {
		width: 60%;
	}
	#gbox_imIssueList .ui-jqgrid-bdiv {
		overflow-x: hidden;
	}
	#gbox_imProductVersionList .ui-jqgrid-bdiv {
		overflow-x: hidden;
	}
</style>