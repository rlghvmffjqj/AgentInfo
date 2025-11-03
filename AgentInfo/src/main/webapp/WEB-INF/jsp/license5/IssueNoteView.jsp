<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script>
	$(document).ready(function(){
		var formData = $('#issueNoteform').serializeObject();
		$("#issueNoteList").jqGrid({
			url: "<c:url value='/license5/issueNote'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['ID','구분','고객사명','사업명','추가정보','발급일','시작일','만료일','일련번호','MAC주소','제품유형','iGRIFFIN Agent 수량','TOS 5.0 Agent 수량','TOS 2.0 Agent 수량','DBMS 수량','Network 수량','AIX(OS) 수량','HPUX(OS) 수량','Solaris(OS) 수량','Linux(OS) 수량','Windows(OS) 수량','관리서버 OS','관리서버 DBMS','국가','제품버전','라이선스 파일명','요청자','담당 영업'],
			colModel:[
				{name:'licenseKeyNum', index:'licenseKeyNum', align:'center', width: 35, hidden:true },
				{name:'licenseType', index:'licenseType', align:'center', width: 60},
				{name:'customerName', index:'customerName', align:'center', width: 200},
				{name:'businessName', index:'businessName', align:'center', width: 250},
				{name:'additionalInformation', index:'additionalInformation', align:'center', width: 200},
				{name:'writeDate', index:'writeDate', align:'center', width: 80},
				{name:'issueDate', index:'issueDate', align:'center', width: 80},
				{name:'expirationDays', index:'expirationDays', align:'center', width: 80},
				{name:'serialNumber', index:'serialNumber',align:'center', width: 250},
				{name:'macAddress', index:'macAddress',align:'center', width: 300},
				{name:'productType', index:'productType', align:'center', width: 80},						
				{name:'igriffinAgentCount', index:'igriffinAgentCount', align:'center', width: 120},
				{name:'tos5AgentCount', index:'tos5AgentCount', align:'center', width: 120},
				{name:'tos2AgentCount', index:'tos2AgentCount', align:'center', width: 120},
				{name:'dbmsCount', index:'dbmsCount', align:'center', width: 120},
				{name:'networkCount', index:'networkCount', align:'center', width: 120},
				{name:'aixCount', index:'aixCount', align:'center', width: 100},
				{name:'hpuxCount', index:'hpuxCount', align:'center', width: 100},
				{name:'solarisCount', index:'solarisCount', align:'center', width: 100},
				{name:'linuxCount', index:'linuxCount', align:'center', width: 100},
				{name:'windowsCount', index:'windowsCount', align:'center', width: 100},
				{name:'managerOsType', index:'managerOsType', align:'center', width: 80},
				{name:'managerDbmsType', index:'managerDbmsType', align:'center', width: 80},
				{name:'country', index:'country', align:'center', width: 50},
				{name:'productVersion', index:'productVersion', align:'center', width: 100},
				{name:'licenseFilePath', index:'licenseFilePath', align:'center', width: 250},
				{name:'requester', index:'requester', align:'center', width: 80},
				{name:'salesManagerName', index:'salesManagerName', align:'center', width: 80},
			],
			jsonReader : {
	        	id: 'licenseKeyNum',
	        	repeatitems: false
	        },
	        pager: '#issueNotePager',			// 페이징
	        rowNum: 25,					// 보여중 행의 수
	        rowList:[25,50,100],
	        sortname: 'issueDate',		// 기본 정렬 
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
	
	$(window).on('resize.list', function () {
	    jQuery("#issueNoteList").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
	});
</script>
<div class="modal-body scroll box1" style="width: 100%; height: auto;">
	
	<form id="issueNoteform" name="issueNoteform" method ="post" onSubmit="return false;">
		<input type="hidden" id="firstLicenseKeyNum" name="firstLicenseKeyNum" value="${firstLicenseKeyNum}">
	</form>
	
	<div class="tabcontent">		
		<!------- Grid ------->
		<div class="jqGrid_wrapper" style="width: 1265px;">
			<table id="issueNoteList"></table>
			<div id="issueNotePager"></div>
		</div>
		<!------- Grid ------->
	</div>
	
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>

</script>
	