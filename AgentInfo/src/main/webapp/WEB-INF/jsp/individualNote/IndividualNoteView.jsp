<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<style>
	.modal-body {
		background-color: #FFFF88;
	}	
	.buttonA {
		background-color: #FFFF88;
	}
	#individualNoteTitleView {
		background-color: #FFFF88;
		border: 0;
	}
	#individualNoteHashTagView {
		background-color: #FFFF88;
    	color: blue;
    	border: 0;
    	font-weight: bold;
	}
	.note-toolbar {
		background-color: #FFFF88;
	}
	.note-btn {
		background-color: #FFFF88;
		border: 0;
	}
	.note-editable {
		background-color: #FFFF88;
	}
	.note-resizebar {
		display: none;
	}
	.note-editor {
		border: 0 !important;
	}
	.note-statusbar {
		display: none;
	}
	.note-editable {
		background-color: #FFFF88;
	}
</style>

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
		 	<div>
		 		<label class="labelFontSize">Hash Tag</label>
		 	</div>
		 	<div>
		 		<input class="form-control" type="text" id="individualNoteHashTagView" name="individualNoteHashTagView" placeholder='해시 태그' value="${individualNote.individualNoteHashTag}">
		 	</div>
		</div>
		<input type="hidden" id="individualNoteKeyNum" name="individualNoteKeyNum"  value="${individualNote.individualNoteKeyNum}">
	</form>
</div>

<script>
	$(function() {
		/* =========== 섬머노트 ========= */
		$('.summerNoteSize').summernote({
			minHeight:560,
			maxHeight:560,
			placeholder:"노트 내용"
		});
		$('.note-insert').hide();
		$('.note-view').hide();
	});
	
	/* =========== 닫기 ========= */
	$('#close').click(function() {
		$('#modal').modal("hide"); // 모달 닫기
		$('#modal').on('hidden.bs.modal', function () {
			stackRefresh();
		});
	})
	
	/* =========== 저장 ========= */
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
					$('#modal').on('hidden.bs.modal', function () {
						stackRefresh();
	        		});
				}
			});
		}
	})
	
	/* =========== Ctrl + S 사용시 저장 ========= */
	document.onkeydown = function(e) {
	    if (e.which == 17)  isCtrl = true;
	    if (e.which == 83 && isCtrl == true) {  // Ctrl + s
	    	var postData = $('#modalForm').serializeObject();
	    	if("${viewType}"=="insert") {
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
	    	} else {
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
	    	}
	    	isCtrl = false;
	    	return false;
	    }
	}
	document.onkeyup = function(e) {
		if (e.which == 17)  isCtrl = false;
	}
</script>