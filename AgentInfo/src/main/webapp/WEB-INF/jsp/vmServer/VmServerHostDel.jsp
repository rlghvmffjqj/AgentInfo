<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- SummerNote -->
<div class="modelHead">
	<div class="modelHeadFont">호스트 서버 삭제</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 120px;">
	<form id="modalForm" name="form" method ="post">
		<table style="margin: 4%; width: 90%;">
			<tbody>
				<tr>
					<td>
						<label class="labelFontSize">호스트 서버</label>
						<span class="colorRed" id="NotVmServerHostName" style="display: none; line-height: initial; font-size: 12px;">한 개 이상의 호스트 서버를 선택해주세요.</span>
					</td>
				</tr>
				<tr>
					<td>
						<select class="form-control selectpicker" id="vmServerHostNameList" name="vmServerHostNameList" data-live-search="true" data-size="5" data-actions-box="true" multiple>
							<c:forEach var="item" items="${vmServerHostName}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="insertBtn" onClick="deleteBtn()">삭제</button>	
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	function deleteBtn() {
		var postData = $('#modalForm').serializeObject();
		var vmServerHostName = $('#vmServerHostNameList').val();
		
		if(vmServerHostName == "") {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '한 개 이상의 호스트 서버를 선택 바랍니다.',    
			}); 
			$('#NotVmServerHostName').show();
		} else {
			Swal.fire({
				title: '삭제!',
				text: "선택한 호스트 서버를 삭제하시겠습니까?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#7066e0',
				cancelButtonColor: '#FF99AB',
				confirmButtonText: 'OK'
			}).then((result) => {
				$.ajax({
					url: "<c:url value='/vmServer/delete'/>",
				    type: 'post',
				    data: postData,
				    async: false,
				    success: function(result) {
						if(result == "OK") {
							Swal.fire({
								icon: 'success',
								title: '삭제 완료!',
								text: '호스트 삭제 완료했습니다.',
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
		}	
	}
</script>