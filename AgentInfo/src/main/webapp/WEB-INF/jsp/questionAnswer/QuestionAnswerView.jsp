<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>

		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','questionAnswer');
		    });
	    </script>
	</head>
	<body>
		<div id="pcoded" class="pcoded iscollapsed">
			<div class="pcoded-overlay-box"></div>
			<div class="pcoded-container navbar-wrapper">
				<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
				<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
				<div class="pcoded-main-container" style="margin-top: 56px;">
					<div class="pcoded-wrapper">
						<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
						<div class="pcoded-content" id="page-wrapper">
							<div class="page-header">
								<div class="page-block">
									<div class="row align-items-center">
									    <div class="col-md-8">
									        <div class="page-header-title" >
									            <h5 class="m-b-10">Q & A</h5>
									            <p class="m-b-0">Question & Answer</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">Q & A</a>
									            </li>
									        </ul>
									    </div>
									</div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
										<form id="formView" name="formView" method ="post">
											<table style="width:100%; background: white; border-top: 3px solid #999999; text-align: center;">
												<tbody>
													<tr>
														<td colspan="6" style="background: #ffe08738; height: 70px;">
															<c:choose>
																<c:when test="${viewType eq 'insert'}">
																	<input class="questionTitle" id="questionTitle" name="questionTitle" placeholder="제목 입력">
																</c:when>
																<c:when test="${viewType eq 'view'}">
																	<span class="questionTitle">${question.questionTitle}</span>
																</c:when>
															</c:choose>
														</td>
													</tr>
													<tr>
														<td class="qnatdq">
															작성자
														</td>
														<td class="qnatda">
															${question.employeeName}
														</td>
														<td class="qnatdq">
															등록일
														</td>
														<td class="qnatda">
															${question.questionDate}
														</td>
														<td class="qnatdq">
															조회수
														</td>
														<td class="qnatda" style="border-right: none;">
															<c:choose>
																<c:when test="${viewType eq 'insert'}">
																	0
																</c:when>
																<c:when test="${viewType eq 'view'}">
																	${question.questionCount}
																</c:when>
															</c:choose>
														</td>
													</tr>
													<tr>
														<td colspan="6" style="text-align: left;">
															<c:choose>
																<c:when test="${viewType eq 'insert'}">
																	<div id="questionDiv">
																		<textarea class="questionDetail summerNoteQuestion" id="questionDetail" name="questionDetail" placeholder="내용 입력"></textarea>
																	</div>
																</c:when>
																<c:when test="${viewType eq 'view'}">
																	<label class="questionDetailView">${question.questionDetail}</label>
																</c:when>
															</c:choose>
														</td>
													</tr>
												</tbody>
											</table>
										</form>
										<sec:authorize access="hasRole('ADMIN')">
											<c:if test="${viewType eq 'view'}">
												<div id="answerDiv" style="margin-top: 10px;">
													<textarea class="answer summerNoteAnswer" id="answer" rows="5" placeholder="답변 작성 바랍니다.">${answer.answerDetail}</textarea>
												</div>
											</c:if>
										</sec:authorize>
										<label class="answer" id="answerView" style="display: none;">${answer.answerDetail}</label>
										<label>답변 : ${answer.employeeName}, </label>
										<label>시간 : ${answer.answerDate}</label>
										<button class="btn btn-outline-info-nomal myBtn questionWrite" id="listBtn" onclick="listBtn();">목록</button>
										<c:choose>
											<c:when test="${viewType eq 'insert'}">
												<button class="btn btn-outline-info-add myBtn questionWrite" id="insertBtn" onclick="insertBtn()">질문 하기</button>
											</c:when>
											<c:when test="${viewType eq 'view'}">
												<sec:authorize access="hasRole('ADMIN')">
													<button class="btn btn-outline-info-add myBtn questionWrite" id="answerBtn" onclick="answerBtn()">답변 하기</button>
													<button class="btn btn-outline-info-add myBtn questionWrite" id="answerUpdateBtn" onclick="answerUpdateBtn()" style="display: none;">답변 수정 하기</button>
												</sec:authorize>
											</c:when>
										</c:choose>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>
	
	<script>
		$(document).ready(function() {
			/* =========== 섬머노트 ========= */
			$('.summerNoteAnswer').summernote({
				minHeight:150,
				placeholder:"여기에 내용을 입력 주세요."
			});

			$('.summerNoteQuestion').summernote({
				minHeight:300,
				placeholder:"여기에 내용을 입력 주세요."
			});

			

			if($('#answerView').text() != "") {
				$('#answerDiv').hide();
				$('#answerView').show();
				$('#answerBtn').hide();
				$('#answerUpdateBtn').show();
			}
		});

		function listBtn() {
			location.href="<c:url value='/questionAnswer/list'/>";
		}

		function insertBtn() {
			var postData = $('#formView').serializeObject();
			$.ajax({
				url: "<c:url value='/question/insert'/>",
			    type: 'post',
			    data: postData,
			    async: false,
			    success: function(result) {
			    	if(result == "NotTitle") { // 제목 입력 알림.
			    		Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '제목을 입력해주세요.',
						});
						return;
					} 
					
			    	if(result == "NotDetail") { // 내용 입력 알림
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '내용을 입력해주세요.',
						});
						return;
					}
				
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						}).then((result) => {
							location.href="<c:url value='/questionAnswer/list'/>";
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

		function answerBtn() {
			var questionKeyNum = "${question.questionKeyNum}";
			var answerDetail = $('#answer').val();
			$.ajax({
		        type: 'post',
		        url: "<c:url value='/answer/insert'/>",
		        async: false,
		        data: {
					"questionKeyNum": questionKeyNum,
					"answerDetail": answerDetail
				},
		        success: function (result) {
					if(result.result == "OK") {
		        		$('#answerDiv').hide();
						$('#answerView').text(result.detail);
						$('#answerView').show();
						$('#answerBtn').hide();
						$('#answerUpdateBtn').show();
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '답변 작성 완료하였습니다.',
						})
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '작업을 실패하였습니다.',
						});
					}
		        },
		    });
		}

		function answerUpdateBtn() {
			$('#answerDiv').show();
			$('#answerView').hide();
			$('#answerBtn').show();
			$('#answerUpdateBtn').hide();
			Swal.fire({
				icon: 'success',
				title: '답변 수정!',
				text: '답변 수정 후 답변 하기 버튼 입력 바랍니다.',
			})
		}
			
	</script>

	<style>
		.ui-jqgrid tr.ui-row-ltr td {
			border-right-style: none !important;
			height: 35px;
		}
		
		.ui-state-default, .ui-widget-content .ui-state-default {
			border-right: none;
		}

		.questionInsert {
			float: right;
			width: 100px;
			height: 40px;
			margin-top: 5px;
		}

		tr {
			border-bottom: 1px solid #9f510029;
		}

		.questionTitle {
			width: 100%;
    		text-align: center;
    		height: 70px;
    		font-size: 20px;
			border: none;
			color: black;
			font-weight: bold;
		}

		.questionDetail {
			width: 100%;
    		height: 400px;
    		border: none;
			color: black;
			padding: 10px;
		}

		.qnatdq {
			border-right: 1px solid #9f510029;
			height: 50px;
			width: 14%;
			font-weight: bold;
			background: #ffe08738;
			color: black;
		}

		.qnatda {
			border-right: 1px solid #9f510029;
			height: 50px;
			width: 20%;
			color: black;
		}

		.questionWrite{
			float: right;
    		margin-top: 5px;
    		width: 100px;
    		height: 40px;
		}

		.questionDetailView {
			text-align: left;
    		padding: 15px;
    		min-height: 200px;
    		color: black;
    		width: 100%;
			height: auto;
		}

		.answer {
			margin-top: 10px;
    		width: 100%;
    		min-height: 100px;
			padding: 10px;
    		border: 1px solid #bbbbbb;
			background: white;
		}

		.note-editor {
			border: none !important;
		}

	</style>
</html>