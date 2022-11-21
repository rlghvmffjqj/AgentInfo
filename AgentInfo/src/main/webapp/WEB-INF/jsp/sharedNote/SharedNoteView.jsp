<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<style>
	.modal-body {
		background-color: #FFFF88;
	}	
	#sharedNoteTitleView {
		background-color: #FFFF88;
		border: 0;
	}
	#sharedNoteHashTagView {
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
	.modal-body {
		padding: 5px;
	}
	
	a {
		color: cadetblue
	}
	.moveBtn {
	    position: absolute;
	    left: 1400px;
	    bottom: 772px;
	    font-weight: bold;
	    color: #555;
	    transition: all 0.1s 0.1s;
	    font-size: 15px;
	    opacity: 0;
	}
	
	#setting:hover .moveBtn {
	    left: 1360px;
	    opacity: 1;
	}
	
</style>

<div class="modal-body" style="width: 100%; height: 800px;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data">
		<input type="hidden" id="sharedNoteTreeFullPath" name="sharedNoteTreeFullPath" class="form-control" value="${sharedNote.sharedNoteTreeFullPath}">
		<input type="hidden" id="sharedNoteTreeName" name="sharedNoteTreeName" class="form-control" value="${sharedNote.sharedNoteTreeName}">
		<div style="margin:10px">
			<div style="text-align: right; margin-top: -10px;">
				<a href="#" id="setting">
					<div class="moveBtn">
						<input type="color" id="sharedNoteColor" name="sharedNoteColor" value="${sharedNote.sharedNoteColor}" style="border:0; background-color: black; width: 30px; height: 17px;">
						<span ><img src="/AgentInfo/images/return.png" id="return" style="width: 17px;" alt="Theme-Logo"></span>
						<span ><img src="/AgentInfo/images/minus2.png" id="close" style="width: 15px; height: 17px;" alt="Theme-Logo"></span>
						<span ><img src="/AgentInfo/images/close2.png" id="save" style="width: 15px;" alt="Theme-Logo"></span>
					</div>
					<span><img src="/AgentInfo/images/setting.png"  style="width: 25px;" alt="Theme-Logo"></span>
				</a>
			</div>
			<div>
		 		<label class="labelFontSize">Note Title</label>
		 	</div>
		 	<div>
		 		<input class="form-control" type="text" id="sharedNoteTitleView" name="sharedNoteTitleView" placeholder='노트 제목' value="${sharedNote.sharedNoteTitle}">
		 	</div>
		 	<div>
		 		<label class="labelFontSize">Note Contents</label>
		 	</div>
		 	<div>
		 		<div class="form-group" style="margin-bottom:0">
					<input id="fileInput" name="fileInput" filestyle="" type="file" data-class-button="btn btn-default" data-class-input="form-control" data-button-text="" data-icon-name="fa fa-upload" class="form-control" tabindex="-1" style="position: absolute; clip: rect(0px 0px 0px 0px);" multiple>
					<div class="bootstrap-filestyle input-group" style="margin-bottom:0">
						<input type="text" id="sharedNoteFileName" class="form-control" name="sharedNoteFileName" readonly="" style="height: 35px; background: #F4F6BB; border: 1px solid burlywood;" placeholder="첨부파일">
						<span class="group-span-filestyle input-group-btn" tabindex="0">
							<label for="fileInput" class="btn btn-default">
								<span class="glyphicon fa fa-upload"></span>
							</label>
						</span>
					</div>
				</div>
				<div class="fileDownloadLink" id="fileDownloadLink">
					<c:forEach var="file" items="${sharedNoteFileName}">
						<div class="attachmentsDiv">
							<a href="#" class="attachmentsA" onclick='fileDownload("${file}")'>
								<span><img class="attachmentsImg" src="/AgentInfo/images/mail.png" alt="Theme-Logo"></span>
								<div class="attachmentsTxt" title="${file}">${file}</div>
							</a>
							<button class="attachmentsBtn" type="button" onclick="linkDelete(this.parentNode,'${file}')">
								<span><img class="attachmentsClose" src="/AgentInfo/images/close.png"></span>
							</button>
						</div>
					</c:forEach>
				</div>
		 		<textarea class="summerNoteSize" rows="5" id="sharedNoteContentsView" name="sharedNoteContentsView" onkeydown="resize(this)" onkeyup="resize(this)">${sharedNote.sharedNoteContents}</textarea>
		 	</div>
		 	<div>
		 		<label class="labelFontSize">Hash Tag</label>
		 	</div>
		 	<div>
		 		<input class="form-control" type="text" style="width:85%; float: left;" id="sharedNoteHashTagView" name="sharedNoteHashTagView" placeholder='해시 태그' value="${sharedNote.sharedNoteHashTag}">
		 		<span style="float: right; font-size: 11px;" id="sharedNoteModifiedDate">마지막 수정일 : ${sharedNote.sharedNoteModifiedDate}</span>
		 	</div>
		</div>
		<input type="hidden" id="sharedNoteKeyNum" name="sharedNoteKeyNum" value="${sharedNote.sharedNoteKeyNum}">
		<input type="hidden" id="viewType" name="viewType" value="${viewType}">
	</form>
</div>

<script>
	$(function() {
		var ordFilename;
		$("#fileInput").on('change', function(){  // 값이 변경되면
			$("#sharedNoteFileName").val("");
			var fileInput = document.getElementById("fileInput");
			var files = fileInput.files;
			var file;
			for (var i = 0; i < files.length; i++) {
			    file = files[i];
			    ordFilename = $("#sharedNoteFileName").val();
			    if(ordFilename != '') {
			    	$("#sharedNoteFileName").val(ordFilename + ", " + file.name);
			    } else {
			    	$("#sharedNoteFileName").val(file.name);
			    }
			}
		});
		
		/* =========== 색상 변경식 적용 ========= */
		$("#sharedNoteColor").on('change', function(){  // 값이 변경되면
			var backgroundColor = $("#sharedNoteColor").val();
			$(".modal-body").css("background-color",backgroundColor);
			$(".note-editable").css("background-color",backgroundColor);
			$(".note-toolbar").css("background-color",backgroundColor);
			$(".note-btn").css("background-color",backgroundColor);
			$("#sharedNoteTitleView").css("background-color",backgroundColor);
			$("#sharedNoteHashTagView").css("background-color",backgroundColor);
			$("#close").css("background-color",backgroundColor);
			$("#save").css("background-color",backgroundColor);
		});
		
		/* =========== 섬머노트 ========= */
		$('.summerNoteSize').summernote({
			minHeight:495,
			maxHeight:495,
			placeholder:"노트 내용"
		});
		$('.note-insert').hide();
		$('.note-view').hide();
		
		/* =========== 설정한 배경 색상 적용하기 ========= */
		if("${viewType}" == 'update') {
			$(".modal-body").css("background-color","${sharedNote.sharedNoteColor}");
			$(".note-editable").css("background-color","${sharedNote.sharedNoteColor}");
			$(".note-toolbar").css("background-color","${sharedNote.sharedNoteColor}");
			$(".note-btn").css("background-color","${sharedNote.sharedNoteColor}");
			$("#sharedNoteTitleView").css("background-color","${sharedNote.sharedNoteColor}");
			$("#sharedNoteHashTagView").css("background-color","${sharedNote.sharedNoteColor}");
			$("#close").css("background-color","${sharedNote.sharedNoteColor}");
			$("#save").css("background-color","${sharedNote.sharedNoteColor}");
		} else if("${viewType}" == 'insert') {
			$("#sharedNoteColor").val("#FFFF88");
		}
	});
	
	
	/* =========== 닫기 ========= */
	$('#close').click(function() {
		$('#modal').modal("hide"); // 모달 닫기
		$('#modal').on('hidden.bs.modal', function () {
			stackRefresh();
		});
	})
	
	/* =========== 배경 되돌리기 ========= */
	$('#return').click(function() {
		$(".modal-body").css("background-color","#FFFF88");
		$(".note-editable").css("background-color","#FFFF88");
		$(".note-toolbar").css("background-color","#FFFF88");
		$(".note-btn").css("background-color","#FFFF88");
		$("#sharedNoteTitleView").css("background-color","#FFFF88");
		$("#sharedNoteHashTagView").css("background-color","#FFFF88");
		$("#close").css("background-color","#FFFF88");
		$("#save").css("background-color","#FFFF88");
		$("#sharedNoteColor").val("#FFFF88");
	})
	
	/* =========== 저장 ========= */
	$('#save').click(function() {
		var viewType = $("#viewType").val();
		if(viewType == "insert") {
			$("#viewType").val("update");
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
					var postData = new FormData($('#modalForm')[0]);
					$.ajax({
						url: "<c:url value='/sharedNote/insert'/>",
				        type: 'post',
				        data: postData,
				        async: false,
				        processData: false,
				        contentType: false,
				        success: function(result) {
							if(result.result == "OK") {
								$('#sharedNoteModifiedDate').text('마지막 수정일 : ' + result.sharedNoteModifiedDate);
								$('#sharedNoteKeyNum').val(result.sharedNoteKeyNum);
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
							} else if(result.result == "Existence") {
								Swal.fire({
									icon: 'error',
									title: '파일명 중복',
									text: '동일한 파일명이 존재합니다.',
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
					var postData = new FormData($('#modalForm')[0]);
					$.ajax({
						url: "<c:url value='/sharedNote/update'/>",
				        type: 'post',
				        data: postData,
				        async: false,
				        processData: false,
				        contentType: false,
				        success: function(result) {
							if(result.result == "OK") {
								$('#sharedNoteModifiedDate').text('마지막 수정일 : ' + result.sharedNoteModifiedDate);
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
							} else if(result.result == "Existence") {
								Swal.fire({
									icon: 'error',
									title: '파일명 중복',
									text: '동일한 파일명이 존재합니다.',
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
	    	var postData = new FormData($('#modalForm')[0]);
	    	var viewType = $("#viewType").val();
	    	if(viewType == "insert") {
	    		$("#viewType").val("update");
	    		$.ajax({
					url: "<c:url value='/sharedNote/insert'/>",
			        type: 'post',
			        data: postData,
			        processData: false,
			        contentType: false,
			        async: false,
			        success: function(result) {
						if(result.result == "OK") {
							$('#sharedNoteModifiedDate').text('마지막 수정일 : ' + result.sharedNoteModifiedDate);
							$('#sharedNoteKeyNum').val(result.sharedNoteKeyNum);
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '작업을 완료했습니다.',
							});
							result.fileName.forEach(function(fileName) {
								var rowItem = "<div class='attachmentsDiv'>";
								rowItem += "<a href='#' class='attachmentsA' onclick='fileDownload("+'"'+fileName+'"'+")'>";
								rowItem += "<span><img class='attachmentsImg' src='/AgentInfo/images/mail.png' alt='Theme-Logo'></span>";
								rowItem += "<div class='attachmentsTxt' title="+fileName+">"+fileName+"</div>";
								rowItem += "</a>";
								rowItem += "<button class='attachmentsBtn' type='button' onclick='linkDelete(this.parentNode,"+'"'+fileName+'"'+")'>";
								rowItem += "<span><img class='attachmentsClose' src='/AgentInfo/images/close.png'></span>";
								rowItem += "</button>";
								rowItem += "</div>";
							 	$('#fileDownloadLink').append(rowItem);
								$("#sharedNoteFileName").val("");
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
						} else if(result.result == "Existence") {
							Swal.fire({
								icon: 'error',
								title: '파일명 중복',
								text: '동일한 파일명이 존재합니다.',
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
					url: "<c:url value='/sharedNote/update'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        processData: false,
			        contentType: false,
			        success: function(result) {
						if(result.result == "OK") {
							$('#sharedNoteModifiedDate').text('마지막 수정일 : ' + result.sharedNoteModifiedDate);
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '작업을 완료했습니다.',
							});
							result.fileName.forEach(function(fileName) {
								var rowItem = "<div class='attachmentsDiv'>";
								rowItem += "<a href='#' class='attachmentsA' onclick='fileDownload("+'"'+fileName+'"'+")'>";
								rowItem += "<span><img class='attachmentsImg' src='/AgentInfo/images/mail.png' alt='Theme-Logo'></span>";
								rowItem += "<div class='attachmentsTxt' title="+fileName+">"+fileName+"</div>";
								rowItem += "</a>";
								rowItem += "<button class='attachmentsBtn' type='button' onclick='linkDelete(this.parentNode,"+'"'+fileName+'"'+")'>";
								rowItem += "<span><img class='attachmentsClose' src='/AgentInfo/images/close.png'></span>";
								rowItem += "</button>";
								rowItem += "</div>";
								$('#fileDownloadLink').append(rowItem);
								$("#sharedNoteFileName").val("");
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
						} else if(result.result == "Existence") {
							Swal.fire({
								icon: 'error',
								title: '파일명 중복',
								text: '동일한 파일명이 존재합니다.',
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
	
	function linkDelete(parentNode,sharedNoteFileName) {
		var sharedNoteKeyNum = $('#sharedNoteKeyNum').val();
		Swal.fire({
			  title: '삭제!',
			  text: "선택한 첨부파일을 삭제하시겠습니까?",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#7066e0',
			  cancelButtonColor: '#FF99AB',
			  confirmButtonText: '예'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: "<c:url value='/sharedNote/fileDelete'/>",
					type: "POST",
					data: {
							"sharedNoteFileName": sharedNoteFileName,
							"sharedNoteKeyNum": sharedNoteKeyNum
						},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						if(data == "OK") {
							parentNode.remove();
							Swal.fire({
								icon: 'success',
								title: '성공!',
								text: '정상적으로 삭제 되었습니다.'
							});
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '첨부파일이 존재 하지 않습니다.',
							});
						}
					},
					error: function(error) {
						console.log(error);
					}
				});
			}
		});
	}
	
	function fileDownload(fileName) {
		var sharedNoteKeyNum = $('#sharedNoteKeyNum').val();
		window.location ="<c:url value='/sharedNote/fileDownload?fileName="+fileName+"&sharedNoteKeyNum="+sharedNoteKeyNum+"'/>";
	}
	
</script>