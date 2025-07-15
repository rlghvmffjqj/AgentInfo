<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(function(){
		var formData = $('#compatibilityform').serializeObject();
		$("#compatibilitylist").jqGrid({
			url: "<c:url value='/compatibility'/>",
			mtype: 'POST',
			postData: formData,
			datatype: 'json',
			colNames:['Key','메인 메뉴','서브 메뉴','패키지명',"전달위치"],
			colModel:[
				{name:'productVersionKeyNum', index:'productVersionKeyNum', align:'center', width: 35, hidden:true },
				{name:'mainMenuTitle', index:'mainMenuTitle', align:'center', width: 100},
				{name:'subMenuTitle', index:'subMenuTitle', align:'center', width: 100},
				{name:'packageName', index:'packageName', align:'center', width: 300},
				{name:'location', index:'location', align:'center', width: 410},
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
				  	<label class="labelFontSize">메인 메뉴</label>
				  	<input type="text" id="mainTitleView" name="mainTitleView" class="form-control">
				</div>
				<div class="col-lg-25">
				  	<label class="labelFontSize">서브 메뉴</label>
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
									<div class="jqGrid_wrapper" style="width: 965px;">
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
		<c:when test="${viewType eq 'update'}">
			<button type="button" class="btn btn-default btn-outline-info-del" id="updateBtn">삭제</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();

		let isValid = true;
		$('[required]').each(function() {
		  if (!this.value || this.value.trim() === '') {
		    const labelText = $(this).siblings('div').find('label.labelFontSize').text() || $(this).attr('name');
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: labelText+ '를(을) 필수 입력바랍니다.',
			});
		    $(this).focus();
			isValid = false;
		    return false;
		  }
		});

		if (!isValid) return;

		$.ajax({
			url: "<c:url value='/productVersion/productVersionInsert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
		        	});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});

	$('#updateBtn').click(function() {		
		var postData = $('#modalForm').serializeObject();

		let isValid = true;
		$('[required]').each(function() {
		  if (!this.value || this.value.trim() === '') {
		    const labelText = $(this).siblings('div').find('label.labelFontSize').text() || $(this).attr('name');
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: labelText+ '를(을) 필수 입력바랍니다.',
			});
		    $(this).focus();
			isValid = false;
		    return false;
		  }
		});

		if (!isValid) return;
		
		$.ajax({
			url: "<c:url value='/productVersion/productVersionUpdate'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
		        	});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
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

</script>
<style>
	

</style>