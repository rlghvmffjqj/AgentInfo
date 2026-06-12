<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- SummerNote -->
<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
<div class="status-modal">
    <div class="status-card">

        <div class="card-title">🔄 진행 정보</div>

        <div class="progress-info">

            <div class="progress-label">진행률</div>

            <div class="progress-value">
                <span id="progressText">${workManage.workManageProgress}</span>%
            </div>

        </div>

        <input type="range" id="progressSlider" min="0" max="100" value="${workManage.workManageProgress}">
        <input type="hidden" id="workManageProgressView" value="${workManage.workManageProgress}">
    </div>

    <div class="status-card">
        <div class="card-title">📝 비고</div>
        <textarea id="summernote"name="summernote">${workManage.workManageComment}</textarea>

    </div>

    <div class="status-footer">
        <button class="btn-close-custom" data-dismiss="modal">닫기</button>
        <button class="btn-save" id="BtnProgressChange" onclick="btnProgressChange()">변경</button>
    </div>

</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 섬머노트 ========= */
	$(function() {
		$('#summernote').summernote({
			height:200,
			placeholder:"테스트 중 발생한 특이사항 및 진행 상황을 입력합니다."
		});

		$('#progressSlider').on('input change', function() {
		
	        let value = $(this).val();
		
	        // 화면 표시 숫자 변경
	        $('#progressText').text(value);
		
	        // 저장용 값 변경
	        $('#workManageProgressView').val(value);
		
	    });
	});
	
	/* =========== 상태 변경 ========= */
	function btnProgressChange() {
		var chkList = $("#list").getGridParam('selarrrow');
		var workManageCommentView = $('#summernote').val();
		var workManageProgressView = $("#workManageProgressView").val();
		
		$.ajax({
			url: "<c:url value='/workManage/progressChange'/>",
			type: "POST",
			data: {
					chkList: chkList,
					"workManageCommentView" : workManageCommentView,
					"workManageProgressView" : workManageProgressView
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
<style>
	.percent-wrap{
	    position:relative;
	    width:200px;
	}

	.percent-wrap input{
	    padding-right:30px;
	}

	.percent-wrap span{
	    position:absolute;
	    right:10px;
	    top:50%;
	    transform:translateY(-50%);
	}

	.status-modal{
	    padding:20px;
	    background:#fff;
	}

	.status-header{
	    display:flex;
	    align-items:center;
	    gap:20px;
	    margin-bottom:25px;
	}

	.icon-circle{
	    width:70px;
	    height:70px;
	    border-radius:50%;
	    background:#eef4ff;
	    display:flex;
	    align-items:center;
	    justify-content:center;
	    font-size:32px;
	}

	.status-title{
	    font-size:30px;
	    font-weight:700;
	    color:#111827;
	}

	.status-desc{
	    color:#6b7280;
	    margin-top:5px;
	}

	.status-card{
	    border:1px solid #e5e7eb;
	    border-radius:15px;
	    padding:25px;
	    margin-bottom:20px;
	}

	.card-title{
	    font-size:22px;
	    font-weight:700;
	    margin-bottom:25px;
	}

	.progress-info{
	    display:flex;
	    justify-content:space-between;
	    align-items:center;
	    margin-bottom:15px;
	}

	.progress-label{
	    font-size:20px;
	    font-weight:600;
	}

	.progress-value{
	    font-size:42px;
	    font-weight:700;
	    color:#2563eb;
	}

	#progressSlider{
	    width:100%;
	    height:8px;
	}

	.status-footer{
	    display:flex;
	    justify-content:flex-end;
	    gap:15px;
	    margin-top:30px;
	}

	.btn-close-custom{
	    min-width:120px;
	    height:50px;
	    border:1px solid #d1d5db;
	    background:#fff;
	    border-radius:10px;
	    font-weight:600;
	}

	.btn-save{
	    min-width:120px;
	    height:50px;
	    border:none;
	    background:#2563eb;
	    color:#fff;
	    border-radius:10px;
	    font-weight:600;
	}
</style>