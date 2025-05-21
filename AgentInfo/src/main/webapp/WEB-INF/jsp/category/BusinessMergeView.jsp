<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">카테고리 병합</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 150px;">
	<table>
		<tbody>
			<tr class="hight60">
				<td style="width: 100%;">기준 카테고리 선택 : </td>
			</tr>
			<tr>
				<td style="width: 100%;">
					<select class="form-control selectpicker" id="categoryBusinessNameView" name="categoryBusinessNameView" data-size="5" data-actions-box="true">
						<c:forEach var="item" items="${categoryBusinessMergeList}">
							<option value="${item}"><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</td>
				<td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="btnConfirmed" onClick="btnConfirmed()">확정</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수

	/* =========== 병합 ========= */
	function btnConfirmed() {
		var chkList = $("#list").getGridParam('selarrrow');
		var categoryBusinessNameView = $('#categoryBusinessNameView').val();		
		console.log(categoryBusinessNameView);
		$.ajax({
			url: "<c:url value='/categoryBusiness/merge'/>",
			type: "POST",
			data: {
				chkList: chkList,
				"categoryBusinessNameView": categoryBusinessNameView
			},
			dataType: "text",
			async: false,
			traditional: true,
			success: function(result) {
				console.log(result);
				if(result == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '병합 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						tableRefresh();
					});
				} else{
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(e) {
		    	console.log(e);
		    }
		});
	}
</script>