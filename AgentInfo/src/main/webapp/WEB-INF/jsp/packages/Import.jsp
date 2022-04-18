<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	/* =========== ajax _csrf 전송 ========= */
	/* $(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	}); */
</script>

<div class="modal-body" style="width: 100%; height: 200px;">
	<form id="excelUploadForm" name="excelUploadForm" method="post" enctype="multipart/form-data" action="AgentInfo/packages/import">
		<h4><strong>첨부 파일</strong></h4>
		<label class="labelFontSize">연도 선택 : </label>
	    <select class="form-control marginBttom20 width-200" id="excelImportYear" name="excelImportYear">
			<option value=""></option>
			<option value="CSV">CSV</option>
			<option value="2019년">2019년</option>
			<option value="2021년">2021년</option>
			<option value="2022년">2022년</option>
		</select>
		<input id="file" type="file" name="file" />
		<div style="height: 20px"></div>
		<label class="colorRed">* 첨부파일은 한개 씩 등록 가능합니다.</label>

	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>


<script>

	$('#insertBtn').click(function() {
		var file = $("#file").val();
		var year = $("#excelImportYear").val();

		// 연도 미입력 에러 발생
		if(year == "" || year == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '첨부파일 연도를 입력해주세요.',    
			});
			return false;
		}
		// 파일 미 선택 에러 발생
		if (file == "" || file == null) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '파일을 선택해주세요.',    
			});
			return false;
		} 
		
		if (confirm("업로드 하시겠습니까?")) {
			var form = $('#excelUploadForm')[0];
			var data = new FormData(form);
			
			$.ajax({
				url: "<c:url value='/packages/import'/>",
				type : "POST",
				enctype: 'multipart/form-data',
		        data: data,
		        async: false,
		        processData: false,
		        contentType: false,
		        success: function(result) {
		        	if(result == "FALSE") {
		        		Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: '작업 실패 하였습니다.',    
						});
		        	}
		        	if(result == "OK") {
		        		Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
		        	}
		        	
		        	$('#modal').modal("hide"); // 모달 닫기
            		$('#modal').on('hidden.bs.modal', function () {
            			tableRefresh();
            		});
				},
				error: function(error) {
					console.log(error);
				}
		    });
		}
	});
</script>




