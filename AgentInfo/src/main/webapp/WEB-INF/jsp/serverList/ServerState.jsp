<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<div class="modelHeadFont">상태 변경</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 80px;">
	<table>
		<tbody>
			<tr class="hight60">
				<td style="width: 50px;">상태 : </td>
				<td style="width: 85%;">
					<select class="form-control selectpicker" id="stateView" name="stateView" data-size="5" data-actions-box="true">
						<option value='정상작동' class="backGreen">정상작동</option>
						<option value='접속불가' class="backRed">접속불가</option>
						<option value='업데이트' class="backYellow">업데이트</option>
						<option value='외부반출' class="backbrown">외부반출</option>
					</select>
				</td>
				<td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnStateChange" onClick="btnStateChange()">변경</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 상태 변경 ========= */
	function btnStateChange() {
		var chkList = $("#list").getGridParam('selarrrow');
		var stateView = $("#stateView").val();
		
		$.ajax({
			url: "<c:url value='/serverList/stateChange'/>",
			type: "POST",
			data: {
					chkList: chkList,
					"stateView" : stateView
				},
			dataType: "json",
			async: false,
			traditional: true,
			success: function(data) {
				if(data.result == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
					$('#modal').on('hidden.bs.modal', function () {
						reloadView();
					});
					tableRefresh();
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