<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<script>
	$(document).ready(function(){
		var formData = $('#modalFormSearch').serializeObject();
		$("#listSearch").jqGrid({
			url: "<c:url value='/engineerList'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['사원명','아이디'],
			colModel:[
				{name:'employeeName', index:'employeeName', align:'center', width: 200},
				{name:'employeeId', index:'employeeId', align:'center', width: 200},
			],
			jsonReader : {
				id: 'employeeName',
				repeatitems: false
			},
			pager: '#pagerSearch',			// 페이징
			rowNum: 10,					// 보여중 행의 수
			sortname: 'employeeName',	// 기본 정렬 
			sortorder: 'desc',			// 정렬 방식
			
			multiselect: false,			// 체크박스를 이용한 다중선택
			viewrecords: false,			// 시작과 끝 레코드 번호 표시
			gridview: true,				// 그리드뷰 방식 랜더링
			sortable: true,				// 컬럼을 마우스 순서 변경
			height : '300',
			autowidth:true,				// 가로 넒이 자동조절
			shrinkToFit: false,			// 컬럼 폭 고정값 유지
			altRows: false,				// 라인 강조
		}); 
	});

</script>


<div class="modal-body" style="width: 100%; height: 500px;">	
	<input type="hidden" id="customerConsolidationKeyNum" name="customerConsolidationKeyNum" class="form-control viewForm" value="${customerConsolidation.customerConsolidationKeyNum}">
	<form id="modalFormSearch" name="form" method ="post">
		<input class="form-control" type="text" style="width: 90%; float: left;" id="employeeName" name="employeeName"> 
		<button style="width: 10%; float: right; height: 33px; background: #ffd493; border: 1px solid #c3c3c3; font-family: emoji;">검색</button>

		<table style="width:100%;">
			<tbody>
				<tr>
					<td style="padding:0px 0px 0px 0px;" class="box">
						<table style="width:100%">
						<tbody>
							<tr>
								<td class="border1">
									<!------- Grid ------->
									<div class="jqGrid_wrapper">
										<table id="listSearch"></table>
										<div id="pagerSearch"></div>
									</div>
									<!------- Grid ------->
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tbody>
		</table>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="engineerSelect" onClick="engineerSelect();">선택</button>		
    <button class="btn btn-default btn-outline-info-nomal" id="engineerSelectClose" onclick="engineerSelectClose();">닫기</button>
</div>


<script>
	function engineerSelectClose() {
		$('#modal').modal("hide"); // 모달 닫기
	}
</script>