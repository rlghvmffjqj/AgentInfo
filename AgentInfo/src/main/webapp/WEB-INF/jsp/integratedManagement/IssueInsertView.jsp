<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(document).ready(function(){
		var formData = $('#form').serializeObject();
		$("#issueList").jqGrid({
			url: "<c:url value='/issue'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['Key','URL','고객사','Title','Target','SubTarget','작성자','테스터','등록일자','전달일자','진행상태','관리서버 사용유무','전체','해결','미해결','보류','TOSMS','TOSRF','PORTAL','JAVA','WAS'],
			colModel:[
				{name:'issueKeyNum', index:'issueKeyNum', align:'center', width: 35, hidden:true },
				{name:'issueRelayUrl', index:'issueRelayUrl', align:'center', width: 80, formatter: urlFormatter},
				{name:'issueCustomer', index:'issueCustomer', align:'center', width: 200, formatter: linkFormatter},
				{name:'issueTitle', index:'issueTitle', align:'center', width: 200},
				{name:'issueTarget', index:'issueTarget', align:'center', width: 80},
				{name:'issueSubTarget', index:'issueSubTarget', align:'center', width: 150, formatter: subTargetFormatter},
				{name:'issueFirstWriter', index:'issueFirstWriter', align:'center', width: 80},
				{name:'issueTester', index:'issueTester', align:'center', width: 120},
				{name:'issueFirstDate', index:'issueFirstDate', align:'center', width: 80},
				{name:'issueDate', index:'issueDate', align:'center', width: 80},
				{name:'issueProceStatus', index:'issueProceStatus', align:'center', width: 80, formatter: stateFormatter},
				{name:'issueManagerServerStatus', index:'issueManagerServerStatus', align:'center', width: 100, formatter: managerStateFormatter},
				{name:'total', index:'total', align:'center', width: 50},
				{name:'solution', index:'solution', align:'center', width: 50},
				{name:'unresolved', index:'unresolved', align:'center', width: 50},
				{name:'hold', index:'hold', align:'center', width: 50},
				{name:'issueTosms', index:'issueTosms', align:'center', width: 200},
				{name:'issueTosrf', index:'issueTosrf',align:'center', width: 200},
				{name:'issuePortal', index:'issuePortal',align:'center', width: 200},
				{name:'issueJava', index:'issueJava', align:'center', width: 200},
				{name:'issueWas', index:'issueWas', align:'center', width: 200},
			],
			jsonReader : {
		    	id: 'issueKeyNum',
		    	repeatitems: false
		    },
		    pager: '#issuePager',			// 페이징
		    rowNum: 15,					// 보여중 행의 수
		    sortname: 'issueKeyNum',	// 기본 정렬 
		    sortorder: 'desc',			// 정렬 방식
		    
		    // multiselect: true,			// 체크박스를 이용한 다중선택
		    viewrecords: false,			// 시작과 끝 레코드 번호 표시
		    gridview: true,				// 그리드뷰 방식 랜더링
		    sortable: true,				// 컬럼을 마우스 순서 변경
		    height : '440',
		    autowidth:true,				// 가로 넒이 자동조절
		    shrinkToFit: false,			// 컬럼 폭 고정값 유지
		    altRows: false,				// 라인 강조
		}); 
	});
	
	$(window).on('resize.list', function () {
	    jQuery("#issueList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
	});
</script>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 32vw;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 70px;">
			<div class="col-lg-2">
				<label class="labelFontSize">고객사</label>
				<input type="text" id="issueCustomer" name="issueCustomer" class="form-control noneBorder">
			</div>
	    	<div class="col-lg-2">
	    		<label class="labelFontSize">Title</label>
				<input type="text" id="issueTitle" name="issueTitle" class="form-control noneBorder">
			</div>
			<div class="col-lg-2">
				<label class="labelFontSize">작성자</label>
				<input type="text" id="issueFirstWriter" name="issueFirstWriter" class="form-control noneBorder">
			</div>
			<div class="col-lg-2">
	    		<label class="labelFontSize">진행상태</label>
	    		<input type="text" id="issueProceStatus" name="issueProceStatus" class="form-control noneBorder">
	    	</div>
		</div>
		<!------- Grid ------->
		<div class="jqGrid_wrapper" style="width: 1265px;">
			<table id="issueList"></table>
			<div id="issuePager"></div>
		</div>
		<!------- Grid ------->
        <input type="hidden" id="packagesKeyNum" name="packagesKeyNum" value="${integratedManagement.packagesKeyNum}">
		<input type="hidden" id="productVersionKeyNum" name="productVersionKeyNum" value="${integratedManagement.productVersionKeyNum}">
		<input type="hidden" id="menuKeyNum" name="menuKeyNum" value="${integratedManagement.menuKeyNum}">
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
		var issuePrimaryKeyNum = $("#issueList").getGridParam('selrow');
		alert(issuePrimaryKeyNum);
		postData.issuePrimaryKeyNum = issuePrimaryKeyNum;
		
		if(packagesKeyNum == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '이슈 목록을 선택 바랍니다.',    
			});  
		} else {
			$.ajax({
				url: "<c:url value='/integratedManagement/issueSelect'/>",
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
	    	        		imIssueListRefresh();
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

	$(document).on('input', '#issueCustomer', function() {
	    let keyword = $(this).val();
	    issueListRefresh();
	});

	$(document).on('input', '#issueTitle', function() {
	    let keyword = $(this).val();
	    issueListRefresh();
	});

	$(document).on('input', '#issueFirstWriter', function() {
	    let keyword = $(this).val();
	    issueListRefresh();
	});

	$(document).on('input', '#issueProceStatus', function() {
	    let keyword = $(this).val();
	    issueListRefresh();
	});

	/* =========== 테이블 새로고침 ========= */
	function issueListRefresh() {		
		var _postDate = $("#modalForm").serializeObject();
		
		var jqGrid = $("#issueList");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: _postDate });
		jqGrid.trigger('reloadGrid');
	}

	function linkFormatter(cellValue, options, rowdata, action) {
		return '<a onclick="updateView('+"'"+rowdata.issueKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}

	function urlFormatter(cellValue, options, rowdata, action) {
		if(cellValue == '' || cellValue == null) {
			return '';
		}
		return '<button class="btn btn-outline-info-nomal myBtn" onclick="urlOpen('+"'"+cellValue+"'"+');">Open</button>';
	}

	function stateFormatter(cellValue, options, rowdata, action) {
		if(cellValue == 'progress') {
			return '진행 중';
		} else if(cellValue == 'request') {
			return '처리 완료 요청';
		}
		return '처리 완료';
	}

	function subTargetFormatter(cellValue, options, rowdata, action) {
		if(cellValue == 'linux') {
			return 'UNIX/LINUX';
		} else if(cellValue == 'windows') {
			return 'WINDOWS';
		} else if(cellValue == 'linuxWindows') {
			return 'UNIX/LINUX/WINDOWS';
		} else {
			return '';
		}
	}

	function managerStateFormatter(value, options, row) {
		var state = row.issueManagerServerStatus;
		if(state == "use") {
			return '<div><img src="/AgentInfo/images/use.png" style="width:55px;"></div';
		} else {
			return '<div><img src="/AgentInfo/images/unuse.png" style="width:55px;"></div';
		} 
	}
	
	$("input").on("keydown", function(e) {
	    if (e.key === "Enter" || e.keyCode === 13) {
	        e.preventDefault();
	    }
	});

</script>
<style>
	.noneBorder {
		border: 1px solid #dab17d;
	}
</style>