<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- datetimepicker -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/datetimepicker/jquery.datetimepicker.min.css'/>">
		<script type="text/javascript" src="<c:url value='/datetimepicker/jquery.datetimepicker.full.min.js'/>"></script>

		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','mailSend');
		    });
		</script>
		<script>
			
		</script>
	</head>
	<body>
	<div id="pcoded" class="pcoded iscollapsed">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
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
							                <h5 class="m-b-10">메일 발송</h5>
							                <p class="m-b-0">Mail Send</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">메일 전송</a>
							                </li>
							            </ul>
							        </div>
							    </div>
							</div>
						</div>
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                	<div class="ibox">
										<span style="color: red;">현제 페이지는 메일 발송 기능 테스트 페이지로 발송자는 로그인한 사용자로되어 지정되어 있습니다. 필요에 따라 기능 수정 하겠습니다.</span>
										<br>
										<form id="form" name="form" method ="post">
											<label class="labelFontSize">받는 사람(이메일 입력 ex : iamdev)</label>
											<input class="form-control" type="text" id="mailTo" name="mailTo" placeholder="iamdev"> 
											<br>
											<label class="labelFontSize">참조(두명 이상일 경우 "," 로 구분, 이메일 입력 ex : iamdev)</label>
											<input class="form-control" type="text" id="mailCc" name="mailCc" placeholder="iamdev1, iamdev2"> 
											<br>
	                                		<label class="labelFontSize">메일 제목</label>
											<input class="form-control" type="text" id="mailSubject" name="mailSubject" placeholder="메일 제목"> 
											<br>
											<label class="labelFontSize">메일 내용</label>
											<textarea class="summerNoteSize" rows="5" id="mailText" name="mailText" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
											<br><br>
											<label class="labelFontSize">첨부 파일</label>
											<input class="form-control" type="file" name="mailAttFile" id="mailAttFile" />
											<br><br><br>
											<button type="button" class="btn btn-default btn-outline-info-add" id="btnMailSend">전송</button>
										</form>
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
		$(function () {
			/* =========== SummerNote 설정 ========= */
			$('.summerNoteSize').summernote({
				minHeight:300,
				placeholder:"메일 내용!",
				callbacks: {
					onKeyup: function(e) {
						var pCount = e.currentTarget.childElementCount;
						if(pCount > 41) {
						    if (e.which != 8 && e.which != 46 && e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {  
								Swal.fire({
									icon: 'error',
									title: '범위 초과!',
									text: '입력 범위를 초과하였습니다.',
								});
						    }
						}
				    }
				}
			});
		})

		$('#btnMailSend').click(function() {
			var formData = new FormData();

			// 폼 데이터 추가
			formData.append('mailTo', $('#mailTo').val());
			formData.append('mailCc', $('#mailCc').val());
			formData.append('mailSubject', $('#mailSubject').val());
			formData.append('mailText', $('#mailText').val());
			formData.append('mailAttFile', $('#mailAttFile')[0].files[0]);

			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/mailSend/send'/>",
				data: formData,
		        async: false,
				processData: false,
			    contentType: false,
		        success: function (result) {
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '메일발송 완료했습니다.',
						});
					} else if(result == "Korean") {
						Swal.fire({
							icon: 'info',
							title: '메일 계정 확인!',
							text: '받는 사람 및 참조는 이름이 아닌 메일 계정을 입력 바랍니다.(ex : iamdev)',
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '작업에 실패하였습니다.',
						});
					}
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		})
		
	</script>
	<style>
		.ibox {
			background: white;
    		padding: 46px;
    		border-radius: 10px;
    		border: 1px solid #dbdbdb;
		}

		.form-control:hover {
			border: none;
    		border-bottom: 1px solid #cccccc;
		}

		.form-control:focus {
			border: none;
    		border-bottom: 1px solid #cccccc;
		}

		.form-control {
			border: none;
    		border-bottom: 1px solid #cccccc;
		}

		

	</style>
</html>