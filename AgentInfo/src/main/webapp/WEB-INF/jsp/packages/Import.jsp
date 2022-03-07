<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	/* =========== ajax _csrf 전송 ========= */
	/* $(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	}); */
</script>

<div class="modal-body" style="width: 100%; height: 180px;">
	<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="/AgentInfo/packages/excelImport">
		<h4><strong>첨부 파일</strong></h4>
		<input id="excelFile" type="file" name="excelFile" />
		<div style="height: 20px"></div>
		<label class="colorRed">*첨부파일은 한개만 등록 가능합니다.</label>

	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>


<script>
	/* =========== 패키지 추가 ========= */
	function checkFileType(filePath) {
		var fileFormat = filePath.split(".");

		if (fileFormat.indexOf("xls") > -1 || fileFormat.indexOf("xlsx") > -1) {
			return true;
		} else {
			return false;
		}
	}

	$('#insertBtn').click(function() {
		var file = $("#excelFile").val();

		if (file == "" || file == null) {
			alert("파일을 선택해주세요.");

			return false;
		} else if (!checkFileType(file)) {
			alert("엑셀 파일만 업로드 가능합니다.");

			return false;
		}

		if (confirm("업로드 하시겠습니까?")) {
			var options = {
				success : function(data) {
					console.log(data);
					alert("모든 데이터가 업로드 되었습니다.");
				},
				type : "POST"
			};
			$("#excelUploadForm").ajaxSubmit(options);
		}
	});
</script>




