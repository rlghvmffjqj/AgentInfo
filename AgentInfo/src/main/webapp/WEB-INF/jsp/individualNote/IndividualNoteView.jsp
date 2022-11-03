<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 800px;">
	<form id="modalForm" name="form" method ="post">
		<div style="margin:10px">
			<div style="text-align: right;">
				<button class="buttonA" type="button" id="close">─</button>
				<button class="buttonA" type="button" style="font-size: 15px;" id="save">X</button>
			</div>
			<div>
		 		<label class="labelFontSize">Note Title</label>
		 	</div>
		 	<div>
		 		<input class="form-control" type="text" id="individualNoteTitleView" name="individualNoteTitleView" placeholder='노트 제목' value="${individualNote.individualNoteTitle}">
		 	</div>
		 	<div>
		 		<label class="labelFontSize">Note Contents</label>
		 	</div>
		 	<div>
		 		<textarea class="summerNoteSize" rows="5" id="individualNoteContentsView" name="individualNoteContentsView" onkeydown="resize(this)" onkeyup="resize(this)">${individualNote.individualNoteContents}</textarea>
		 	</div>
		</div>
		<input type="hidden" id="individualNoteKeyNum" name="individualNoteKeyNum"  value="${individualNote.individualNoteKeyNum}">
	</form>
</div>

<script>
	$(function() {
		$('.summerNoteSize').summernote({
			minHeight:600,
			maxHeight:600,
			placeholder:"노트 내용"
		});
		$('.note-insert').hide();
		$('.note-view').hide();
	});
	
	$('#close').click(function() {
		$('#modal').modal("hide"); // 모달 닫기
	})
	
	$('#save').click(function() {
		if("${viewType}"=="insert") {
			Swal.fire({
				title: '입력 사항을 저장하시겠습니까?',
				showDenyButton: true,
				showCancelButton: true,
				confirmButtonText: '저장',
				denyButtonText: '저장 안 함',
				confirmButtonColor: '#7066e0',
				denyButtonColor: '#FF99AB',
				icon: 'question',
			}).then((result) => {
				if (result.isConfirmed) {
					var postData = $('#modalForm').serializeObject();
					$.ajax({
						url: "<c:url value='/individualNote/insert'/>",
				        type: 'post',
				        data: postData,
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
				        			$('#btnReset').trigger("click");
				        		});
							} else if(result.result == "NotTitle") {
								Swal.fire({
									icon: 'error',
									title: '제목 입력 바랍',
									text: '제목 필수 입력 사항입니다.',
								});
							} else if(result.result == "NotContent") {
								Swal.fire({
									icon: 'error',
									title: '내용 입력 바랍',
									text: '내용 필수 입력 사항입니다.',
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
				} else if (result.isDenied) {
					$('#modal').modal("hide"); // 모달 닫기
				}
			});
		} else {
			Swal.fire({
				title: '변경 사항을 저장하시겠습니까?',
				showDenyButton: true,
				showCancelButton: true,
				confirmButtonText: '저장',
				denyButtonText: '저장 안 함',
				confirmButtonColor: '#7066e0',
				denyButtonColor: '#FF99AB',
				icon: 'question',
			}).then((result) => {
				if (result.isConfirmed) {
					var postData = $('#modalForm').serializeObject();
					$.ajax({
						url: "<c:url value='/individualNote/update'/>",
				        type: 'post',
				        data: postData,
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
				        			$('#btnReset').trigger("click");
				        		});
							} else if(result.result == "NotTitle") {
								Swal.fire({
									icon: 'error',
									title: '제목 입력 바랍',
									text: '제목 필수 입력 사항입니다.',
								});
							} else if(result.result == "NotContent") {
								Swal.fire({
									icon: 'error',
									title: '내용 입력 바랍',
									text: '내용 필수 입력 사항입니다.',
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
				} else if (result.isDenied) {
					$('#modal').modal("hide"); // 모달 닫기
				}
			});
		}
	})
</script>