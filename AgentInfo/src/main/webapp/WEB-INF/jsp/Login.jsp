<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <title>로그인</title>

	<script>
		$(function() {
			/* =========== 쿠키 값이 있을 경우 아이디 저장 CheckBox true ========= */
			if($.cookie('usersId') != null) {
				$('#checkbox').prop('checked',true);
			}
			
			/* =========== CheckBox true 일경우 ID Input 값 넣기 ========= */
			if($('#checkbox').is(':checked') == true) {
				$('#usersId').val($.cookie('usersId'));
			}
			
			/* =========== 로그인 버튼 클릭 ========= */
			$('#btn').on("click", function(e) {
				/* =========== CheckBox true 일경우 쿠키 저장 (기간 1일) ========= */
				if($('#checkbox').is(':checked') == true) {
					$.cookie('usersId',$('#usersId').val(),{ expires: 1 });
				}
				
				/* =========== CheckBox false일 경우 쿠키 삭제 ========= */
				if($('#checkbox').is(':checked') == false) {
					$.removeCookie('usersId');
				}
			});
		});
	</script>
 </head>
<body>
    <section class="login-block">
    <div class="pcoded-content" id="page-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                     <form class="md-float-material form-material" id="form" method="post">
                         <div class="text-center">
                             <img src="<c:url value='/images/logo.png' />" alt="logo.png">
                         </div>
                         <div class="auth-box card">
                             <div class="card-block">
                                 <div class="row m-b-20">
                                     <div class="col-md-12">
                                         <h3 class="text-center">로그인</h3>
                                     </div>
                                 </div>
                                 <div class="form-group form-primary">
                                     <input type="text" id="usersId" name="usersId" class="form-control" required="required">
                                     <span class="form-bar"></span>
                                     <label class="float-label">ID</label>
                                 </div>
                                 <div class="form-group form-primary">
                                     <input type="password" id="usersPw" name="usersPw" class="form-control" required="required">
                                     <span class="form-bar"></span>
                                     <label class="float-label">Password</label>
                                 </div>
                                 <div class="row m-t-25 text-left">
                                     <div class="col-12">
                                         <div class="checkbox-fade fade-in-primary d-">
                                             <label>
                                                 <input type="checkbox" id="checkbox" value="">
                                                 <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                 <span class="text-inverse">아이디 저장</span>
                                             </label>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="row m-t-30">
                                     <div class="col-md-12">
                                         <!-- <button type="submit" id="btn" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center">Login</button> -->
                                         <button type="button" id="btn" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center" onClick="pwdCheck();">Login</button>
                                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </form>
                </div>
            </div>
        </div>
        </div>
    </section>
</body>
<script>
	/* =========== 로그인(ID, PWD 일치 여부 확인 후) ========= */
	function pwdCheck() {
		var usersId = $('#usersId').val();
		var usersPw = $('#usersPw').val();
		
		if(usersId == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '아이디를 입력해주세요.',
			});
			return false;
		}
		if(usersPw == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '패스워드를 입력해주세요.',
			});
			return false;
		}
		
		$.ajax({
            type: 'POST',
            url: "<c:url value='/users/pwdCheck'/>",
            data: {
            	"usersId" : usersId,
            	"usersPw" : usersPw
            },
            async: false,
            success: function (data) {
                if(data == "YES") { 
                	pwdChange();
                } else if(data == "FALSE") {
                	Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '아이디 패스워드가 일치하지 않습니다.',
					});
                } else if(data == "NO"){
                	$("form").submit();
                }
            },
            error: function(e) {
                // TODO 에러 화면
            }
        });
	}

	/* =========== 패스워드 변경 ========= */
	function pwdChange() {
		$.ajax({
            type: 'POST',
            url: "<c:url value='/users/pwdChangeView'/>",
            async: false,
            success: function (data) {
                $.modal(data, 'sr'); //modal창 호출
            },
            error: function(e) {
                // TODO 에러 화면
            }
        });
	}
	
	/* =========== Enter 검색 ========= */
	$("input[type=password]").keypress(function(event) {
		if (window.event.keyCode == 13) {
			pwdCheck();
		}
	});
</script>

</html>