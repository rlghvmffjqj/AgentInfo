<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(function(){
		var viewType = "${viewType}"; // 서버에서 넘어온 값 사용
    	var jqueryUrl = "/";

    	if (viewType === "insert") {
    	    jqueryUrl = "<c:url value='/compatibility'/>";
    	} else if (viewType === "search") {
    	    jqueryUrl = "<c:url value='/compatibilitySearch'/>";
    	}
		var formData = $('#compatibilityform').serializeObject();
		$("#compatibilitylist").jqGrid({
			url: jqueryUrl,
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['Key','메인 메뉴','서브 메뉴','패키지명',"전달위치",'날짜'],
			colModel:[
				{name:'productVersionKeyNum', index:'productVersionKeyNum', align:'center', width: 35, hidden:true},
				{name:'mainMenuTitle', index:'mainMenuTitle', align:'center', width: 150},
				{name:'subMenuTitle', index:'subMenuTitle', align:'center', width: 100},
				{name:'packageName', index:'packageName', align:'center', width: 300, classes: 'ellipsis-cell', formatter: function(cellvalue) {return `<span title="`+cellvalue+`">`+cellvalue+`</span>`; }, formatter: detailFormatter},
				{name:'location', index:'location', align:'center', width: 490, classes: 'ellipsis-cell', formatter: function(cellvalue) {return `<span title="`+cellvalue+`">`+cellvalue+`</span>`; }},
				{name:'packageDate', index:'packageDate', align:'center', width: 85},
			],
			jsonReader : {
	        	id: 'productVersionKeyNum',
	        	repeatitems: false
	        },
	        pager: '#compatibilitypager',			// 페이징
	        rowNum: 25,					// 보여중 행의 수
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
	    jQuery("#compatibilitylist").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
	});
</script>
<div class="modal-body scroll box1" style="width: 100%; height: auto;">
	<div class="ibox">
		<div class="searchbos">
			<form id="compatibilityform" name="compatibilityform" method ="post" onSubmit="return false;">
				<div class="col-lg-25">
				  	<label class="labelFontSize">제품 구분</label>
				  	<input type="text" id="mainTitleView" name="mainTitleView" class="form-control">
				</div>
				<div class="col-lg-25">
				  	<label class="labelFontSize">OS 구분</label>
				  	<input type="text" id="subTitleView" name="subTitleView" class="form-control">
				</div>
				<div class="col-lg-25">
				  	<label class="labelFontSize">패키지명</label>
				  	<input type="text" id="packageNameView" name="packageNameView" class="form-control">
				</div>
				<div class="col-lg-25">
				  	<label class="labelFontSize">전달위치</label>
				  	<input type="text" id="locationView" name="locationView" class="form-control">
				</div>
				<input type="hidden" id="menuKeyNum" name="menuKeyNum" class="form-control" value="${menuKeyNum}">
				<input type="hidden" id="productVersionKeyNum" name="productVersionKeyNum" class="form-control" value="${productVersionKeyNum}">
				<input type="hidden" id="parentChkList" name="parentChkList" class="form-control" value="${parentChkList}">
				<div class="col-lg-12 text-right" style="margin-top: 30px;">
					<p class="search-btn">
						<button class="btn btn-primary btnm" type="button" id="btnSearchCompatibility">
							<i class="fa fa-search"></i>&nbsp;<span>검색</span>
						</button>
						<button class="btn btn-default btnm" type="button" id="btnResetCompatibility">
							<span>초기화</span>
						</button>
					</p>
				</div>
			</form>
		</div>
	</div>
	<table style="width:100%; border:none;">
		<tbody>
			<tr>
				<td style="padding:0px 0px 0px 0px;" class="box">
					<table style="width:100%">
						<tbody>
							<tr>
								<td class="border1" colspan="2" style="border: none;">
									<!------- Grid ------->
									<div class="jqGrid_wrapper" style="width: 1265px;">
										<table id="compatibilitylist"></table>
										<div id="compatibilitypager"></div>
									</div>
									<!------- Grid ------->
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button type="button" class="btn btn-default btn-outline-info-add" id="insertBtn">등록</button>
		</c:when>
		<c:when test="${viewType eq 'search'}">
			<button class="btn btn-default btn-outline-info-add"  onClick="doExportExec('#compatibilityform')">Excel 추출</button>	
			<button class="btn btn-default btn-outline-info-del" id="deleteBtn">제거</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$(function() {
		var productVersionKeyNum = "${productVersionKeyNum}";
	})

	$('#insertBtn').click(function() {
		var menuKeyNum = "${menuKeyNum}";
		var parentChkList = "${parentChkList}";

		var childChkList = $("#compatibilitylist").getGridParam('selarrrow');
			
		if(childChkList == 0) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '선택한 행이 존재하지 않습니다.',    
			});    
		} else {
			Swal.fire({
				title: '호환 등록!',
				text: "선택한 제품을 호환가능 목록에 등록 하시겠습니까?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#FF99AB',
				confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/productVersion/insertCompatibility'/>",
						type: "POST",
						data: {
							childChkList: childChkList,
							"parentChkList": parentChkList,
							"menuKeyNum": menuKeyNum
						},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '호환 성공!',
								  '작업 완료하였습니다.',
								  'success'
								)
							else 
								Swal.fire(
								  '실패!',
								  '삭제 실패하였습니다.',
								  'error'
								)
							$('#modal').modal("hide");
						},
						error: function(error) {
							console.log(error);
						}
					});
			  	}
			})
		}
	});

	
	$('#deleteBtn').click(function() {
		var menuKeyNum = "${menuKeyNum}";
		var parentChkList = "${parentChkList}";
		var childChkList = $("#compatibilitylist").getGridParam('selarrrow');
			
		if(childChkList == 0) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '선택한 행이 존재하지 않습니다.',    
			});    
		} else {
			Swal.fire({
				title: '호환 삭제!',
				text: "선택한 제품을 호환가능 목록에서 삭제 하시겠습니까?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#FF99AB',
				confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/productVersion/deleteCompatibility'/>",
						type: "POST",
						data: {
							childChkList: childChkList,
							"parentChkList": parentChkList,
							"menuKeyNum": menuKeyNum
						},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '호환 삭제!',
								  '작업 완료하였습니다.',
								  'success'
								)
							else 
								Swal.fire(
								  '실패!',
								  '삭제 실패하였습니다.',
								  'error'
								)
							// $('#modal').modal("hide");
							tableRefreshCompatibility();
						},
						error: function(error) {
							console.log(error);
						}
					});
			  	}
			})
		}
	});

	/* =========== 검색 ========= */
	$('#btnSearchCompatibility').click(function() {
		tableRefreshCompatibility();	
	});

	/* =========== 검색 초기화 ========= */
	$('#btnResetCompatibility').click(function() {
		$("input[type='text']").val("");
		// $("input[type='date']").val("");
	    
	    // $('.selectpicker').val('');
	    // $('.filter-option-inner-inner').text('');
		
		tableRefreshCompatibility();
	});

	/* =========== 테이블 새로고침 ========= */
	function tableRefreshCompatibility() {
		setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
		var jqGrid = $("#compatibilitylist");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: $("#compatibilityform").serializeObject() });
		jqGrid.trigger('reloadGrid');
	}

	$("input[type=text]").keypress(function(event) {
		if (window.event.keyCode == 13) {
			tableRefreshCompatibility();
		}
	});

	function detailFormatter(cellValue, options, rowdata, action) {
		return '<a onclick="detailView('+"'"+rowdata.productVersionKeyNum+"'"+')" style="color:#366cb3; font-size:12px;">' + cellValue + '</a>';
	}

	function detailView(productVersionKeyNum) {
		const url = "<c:url value='/productVersion/detailView'/>?productVersionKeyNum=" + encodeURIComponent(productVersionKeyNum);
  		const specs = 'width=1100,height=750,scrollbars=yes,resizable=yes';

		window.open(url, name, specs);
	}
</script>

<style>
	.ellipsis-cell div,
	.ellipsis-cell span {
		display: inline-block;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		width: 100%;
	}
	
	#compatibilitylist {
		table-layout: fixed !important;
	}

</style>
