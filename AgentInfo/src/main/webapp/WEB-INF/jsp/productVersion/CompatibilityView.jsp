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
			colNames:['Key','제품 구분','OS구분','패키지명',"전달위치",'날짜'],
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
				<!-- <div class="col-lg-25">
				  	<label class="labelFontSize">제품 구분</label> -->
				  	<input type="hidden" id="mainTitleView" name="mainTitleView" class="form-control">
				<!-- </div> -->
				<div class="col-lg-25">
				  	<label class="labelFontSize">OS 구분</label>
				  	<!-- <input type="text" id="subTitleView" name="subTitleView" class="form-control"> -->
					<select class="form-control selectpicker" id="subTitleView" name="subTitleView" data-live-search="true" data-size="5" data-actions-box="true">
						<option value="">전체</option>
						<option value="Windows">Windows</option>
						<option value="Linux">Linux</option>
						<option value="AIX">AIX</option>
						<option value="HP-UX">HP-UX</option>
						<option value="SunOS">SunOS</option>
					</select>
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
	<div class="tab">
		<c:forEach var="item" items="${menutitleList}">	
			<button class="tablinks" onclick="mainTitleTab('${item}', this);">${item}</button>
		</c:forEach>
	</div>

	<div class="tabcontent">		
		<!------- Grid ------->
		<div class="jqGrid_wrapper" style="width: 1265px;">
			<table id="compatibilitylist"></table>
			<div id="compatibilitypager"></div>
		</div>
		<!------- Grid ------->
	</div>
	
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
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	$('#sendPackageStartDateView').datetimepicker();
	$('#sendPackageEndDateView').datetimepicker();

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
		$("#mainTitleView").val("");
		$('.tab button').removeClass('active');
		// $("input[type='date']").val("");
	    
	    $('.selectpicker').val('');
	    $('.filter-option-inner-inner').text('전체');
		
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

	function mainTitleTab(title, btn) {
	    $('#mainTitleView').val(title);
	    $('.tab button').removeClass('active');
	    $(btn).addClass('active');
	    tableRefreshCompatibility();
	} 

	/* =========== Select Box 선택 ========= */
	$("select").change(function() {
		tableRefreshCompatibility();
	});
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

	.tab {
	  overflow: hidden;
	}

	.tab button {
	  background-color: #f7deca; /* 기본 색 */
	  float: left;
	  border: none;
	  outline: none;
	  padding: 12px 15px;
	  cursor: pointer;
	  font-size: 12px;
	  border-top-left-radius: 12px;
	  border-top-right-radius: 12px;
	  margin-right: 5px;
	  transition: all 0.3s ease;
	  color: #333;
	  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
	}

	.tab button:hover {
	  background-color: #fec7c7;
	}

	.tab button.active {
	  background-color: #f1af63; /* 활성 탭 색 */
	  color: #fff;
	  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
	}

	/* 탭 컨텐츠 스타일 */
	.tabcontent {
	  display: block;
	  padding: 0px;
	  border: 1px solid #ccc;
	  border-top: none;
	  background-color: #fff; /* 컨텐츠 배경 */
	  border-radius: 0 0 12px 12px; /* 아래만 직선이 아닌 약간 둥글게 */
	  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
	  animation: fadeEffect 0.4s;
	}

	/* 페이드 인 효과 */
	@keyframes fadeEffect {
	  from {opacity: 0;}
	  to {opacity: 1;}
	}

</style>
