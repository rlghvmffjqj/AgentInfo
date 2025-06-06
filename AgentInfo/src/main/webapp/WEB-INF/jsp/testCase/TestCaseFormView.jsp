<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
    <c:choose>
		<c:when test="${viewType eq 'insert'}">
	        <div class="modelHeadFont">테스트 케이스 타입 추가</div>
        </c:when>
		<c:when test="${viewType eq 'update'}">
            <div class="modelHeadFont">테스트 케이스 타입 변경</div>
        </c:when>
    </c:choose>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 100px;">
    <table style="margin:20px">
        <tbody>
            <input type="text" id="testCaseFormNameView" name="testCaseFormNameView" style="width: 310px; margin-top: 8%;" value="${testCase.testCaseFormName}" placeholder="제품 이름" autofocus>
            <input type="hidden" id="testCaseFormNameOriginal" name="testCaseFormNameOriginal" value="${testCase.testCaseFormName}">
			<input type="hidden" id="testCaseFormKeyNumView" name="testCaseFormKeyNumView" value="${testCase.testCaseFormKeyNum}">
        </tbody>
    </table>
</div>
<div class="modal-footer">
    <c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="insertFormBtn">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateFormBtn">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== autofocus 미작동시 추가 ========= */
	$(document).on('shown.bs.modal', function (e) {
	    $(this).find('[autofocus]').focus();
	});
	
	/* =========== Enter Key ========= */
	$("#fileName").keypress(function(event) {
		if (window.event.keyCode == 13) {
			BtnChange();
		}
	});

    $('#insertFormBtn').click(function() {
        var testCaseFormName = $('#testCaseFormNameView').val();
		$.ajax({
			url: "<c:url value='/testCase/insertForm'/>",
	        type: 'post',
	        data: {
				"testCaseFormName" : testCaseFormName,
			},
	        async: false,
	        success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		        	$('#modal').on('hidden.bs.modal', function () {
		        		var table = $("#testCaseFormDiv");
			            var rowItem = "<button type='button' class='btn btn-primary formBtn' id='"+testCaseFormName+"' style='box-shadow: 0px 3px 3px grey;' onClick='btnTestCaseForm(this,"+result.testCaseFormKeyNum+")'>"+testCaseFormName+"</button>";
			            table.append(rowItem);
                        $('#testCaseFormName').val(testCaseFormName);
		        	});	
                } else if(result == "Duplication") {
                    Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '동일한 이름의 제품이 존재합니다.',
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
	
    $('#updateFormBtn').click(function() {
        var testCaseFormName = $('#testCaseFormNameView').val();
        var testCaseFormNameOriginal = $('#testCaseFormNameOriginal').val();
		var testCaseFormKeyNum = $('#testCaseFormKeyNumView').val();
        $.ajax({
			url: "<c:url value='/testCase/updateForm'/>",
	        type: 'post',
	        data: {
				"testCaseFormName" : testCaseFormName,
				"testCaseFormKeyNum" : testCaseFormKeyNum,
			},
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
                        $('#testCaseFormName').val(testCaseFormName);
                        $('#'+testCaseFormNameOriginal).text(testCaseFormName);
                        $("#"+testCaseFormNameOriginal).attr("id", testCaseFormName);
		        	});	
                } else if(result == "Duplication") {
                    Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '동일한 이름의 제품이 존재합니다.',
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
</script>