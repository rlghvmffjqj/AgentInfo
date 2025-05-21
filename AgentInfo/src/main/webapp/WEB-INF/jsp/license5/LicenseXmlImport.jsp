<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">License XML File Import</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 130px;">
	<form id="modalImportForm" name="form" method ="post" enctype="multipart/form-data">
		<input class="form-control viewForm" type="file" name="licenseXml" id="licenseXml" style="margin-top: 10%;" multiple />
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnDepartmentViewInsert" onClick="btnLicenseXmlImport()">등록</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	function btnLicenseXmlImport() {
		const postData = new FormData($('#modalImportForm')[0]);
		/* progressbar 정보 */
        var bar = $('.bar');
        var percent = $('.percent');
        var status = $('#status');
        
		$.ajax({
			xhr: function() {
                var xhr = new window.XMLHttpRequest();
                xhr.upload.addEventListener("progress", function(evt) {
                    if (evt.lengthComputable) {
                        var percentComplete = Math.floor((evt.loaded / evt.total) * 100);

                        var percentVal = percentComplete + '%';
                        bar.width(percentVal);
                        percent.html(percentVal);

                    }
                }, false);
                return xhr;
            },
			url: "<c:url value='/license5/licenseXmlImport'/>",
			enctype: 'multipart/form-data',
			type: 'post',
		    data: postData,
		    processData: false,
		    contentType: false,
		    beforeSend:function(){
                // progress Modal 열기
                $("#pleaseWaitDialog").modal('show');

                status.empty();
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal);

            },
            complete:function(){
                // progress Modal 닫기
                $("#pleaseWaitDialog").modal('hide');
            },
		    success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: result.success+'개의 작업을 처리하였습니다.',
					});
					$('.modal-backdrop').hide();
					$('#modal').modal("hide"); // 모달 닫기
		       		$('#modal').on('hidden.bs.modal', function () {
		       			tableRefresh();
		       		});
				} else if(result.result == "Duplication") {
					Swal.fire({
						icon: 'error',
						title: '일련번호 중복!',
						text: '일련번호가 동일한 데이터가 존재합니다.',
					});
				} else {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			}	
		});
	}
</script>