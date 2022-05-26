<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
  <head>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <!-- 쿠키 스크립트 -->
    <script>
    	/* =========== 페이지 쿠키 값 저장 ========= */
	    $(function() {
	    	$.cookie('name','requestsWrite');
	    });
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
                                          <h5 class="m-b-10">요청 작성</h5>
                                          <p class="m-b-0">Requset Write</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">요청 작성</a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                          </div>
                      </div>
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                	<div>
	                                	<div class="card">
                                             <div class="card-header">
                                                 <h4>해당 페이지는 관리자에게 요청 사항을 전달합니다.</h4>
                                                 <h5 class="colorRed">시스템 설정 또는 오류, 수정 사항의 내용만 기재 바랍니다. (예: 사용자 정보 수정, 사용자 추가, 패스워드 변경 재요청, 시스템 오류, 시스템 설정 추가, 시스템 개선 사항)</h5>
                                             </div>
                                             <div class="card-block">
                                                 <form class="form-material" id="form">
                                                     <div class="form-group form-default">
                                                         <input type="text" class="form-control" id="requestsTitle" name="requestsTitle" maxlength="50" required="">
                                                         <span class="form-bar"></span>
                                                         <label class="float-label">제목 추가</label>
                                                     </div>
                                                     <div class="form-group form-default">
                                                         <textarea class="form-control" id="requestsDetail" name="requestsDetail" required=""></textarea>
                                                         <span class="form-bar"></span>
                                                         <label class="float-label">여기에 메시지를 입력 주세요.</label>
                                                     </div>
                                                 </form>
                                                 <div class="requestsBtn">
													<button class="btn btn-default btn-outline-info-add" id="sendBtn">보내기</button>
												</div>
                                             </div>
                                         </div>
									</div>                           
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
	$('#sendBtn').click(function() {
		var formData = $("#form").serializeObject();
		$.ajax({
		    type: 'post',
		    url: "<c:url value='/requests/write'/>",
		    data: formData,
		    async: false,
		    success: function (data) {
		    	if(data == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '관리자에게 요청 사항이 정상적으로 전달 되었습니다.',
					});
					$('#requestsTitle').val("");
					$('#requestsDetail').val("");
		    	} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
		    },
		    error: function(e) {
		        console.log(e);
		    }
		});
	});

</script>

</html>