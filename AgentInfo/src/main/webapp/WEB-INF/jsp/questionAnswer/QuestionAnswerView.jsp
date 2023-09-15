<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
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
														<td colspan="6" style="background: #ffe08738;">
															<input class="questionAnswerTitle" id="questionAnswerTitle" name="questionAnswerTitle" placeholder="제목 입력">
														</td>
													</tr>
													<tr>
														<td class="qnatdq">
															작성자
														</td>
														<td class="qnatda">
															${employeeName}
														</td>
														<td class="qnatdq">
															등록일
														</td>
														<td class="qnatda">
															${questionAnswerDate}
														</td>
														<td class="qnatdq">
															조회수
														</td>
														<td class="qnatda" style="border-right: none;">
															0
														</td>
													</tr>
													<tr>
														<td colspan="6">
															<textarea class="questionAnswerDetail" id="questionAnswerDetail" name="questionAnswerDetail" placeholder="내용 입력"></textarea>
														</td>
													</tr>
												</tbody>
											</table>
										</form>
										<button class="btn btn-outline-info-nomal myBtn questionAnswerWrite" id="listBtn" onclick="listBtn();">목록</button>
										<button class="btn btn-outline-info-add myBtn questionAnswerWrite" id="insertBtn" onclick="insertBtn()">답변 요청</button>
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
		function listBtn() {
			location.href="<c:url value='/questionAnswer/list'/>";
		}

		function insertBtn() {
			var postData = $('#formView').serializeObject();
			$.ajax({
				url: "<c:url value='/questionAnswer/insert'/>",
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
			
	</script>

	<style>
		.ui-jqgrid tr.ui-row-ltr td {
			border-right-style: none !important;
			height: 35px;
		}
		
		.ui-state-default, .ui-widget-content .ui-state-default {
			border-right: none;
		}

		.questionAnswerInsert {
			float: right;
			width: 100px;
			height: 40px;
			margin-top: 5px;
		}

		tr {
			border-bottom: 1px solid #9f510029;
		}

		.questionAnswerTitle {
			width: 100%;
    		text-align: center;
    		height: 70px;
    		font-size: 20px;
			border: none;
			color: black;
		}

		.questionAnswerDetail {
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

		.questionAnswerWrite{
			float: right;
    		margin-top: 5px;
    		width: 100px;
    		height: 40px;
		}
	</style>
</html>