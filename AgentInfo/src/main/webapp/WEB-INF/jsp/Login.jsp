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
									 <div class="caps-lock-memo">&lt;Caps Lock&gt; 이 켜져 있습니다.</div>
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
				} else if(data == "CountLock") {
					Swal.fire({
						icon: 'error',
						title: '계정 잠금!',
						text: '계정이 잠금 되었습니다. 관리자 문의 바랍니다.',
					});
				} else if(data == "LOCK") {
					Swal.fire({
						icon: 'error',
						title: '계정 잠금!',
						text: '아이디 패스워드 5회 이상 실패하여 계정이 잠금되었습니다. 관리자 문의 바랍니다.',
					});
                } else if(data == "NO"){
                	$("form").submit();
                }
            },
            error: function(e) {
                // TODO 에러 화면
            }
        });
		
		/* =========== CheckBox true 일경우 쿠키 저장 (기간 1일) ========= */
		if($('#checkbox').is(':checked') == true) {
			$.cookie('usersId',$('#usersId').val(),{ expires: 1 });
		}
		
		/* =========== CheckBox false일 경우 쿠키 삭제 ========= */
		if($('#checkbox').is(':checked') == false) {
			$.removeCookie('usersId');
		}
	}

	/* =========== 패스워드 변경 ========= */
	function pwdChange() {
		$.ajax({
            type: 'POST',
            url: "<c:url value='/users/pwdChangeView'/>",
            async: false,
            success: function (data) {
            	if(data.indexOf("<!DOCTYPE html>") != -1) 
					location.reload();
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

	// Caps Lock 상태를 확인하는 함수
	function isCapsLockOn(e) {
	    // Event 객체로부터 Caps Lock 키의 상태를 확인합니다.
	    var capsLockOn = (e.getModifierState && e.getModifierState('CapsLock')) || (e.key && e.key === 'CapsLock');
	    return capsLockOn;
	}

	// 이벤트 리스너를 등록하여 키보드 이벤트를 감지합니다.
	document.addEventListener('keydown', function(e) {
		if ($(e.target).attr('id') === 'usersPw') {
	    	// Caps Lock 키가 눌려 있는지 확인합니다.
	    	if (isCapsLockOn(e)) {
	    	    $('.caps-lock-memo').show();
	    	} else {
	    	    $('.caps-lock-memo').hide();
	    	}
		}
	});
</script>
<style>
    .caps-lock-memo {
        font-family: Arial, sans-serif;
        font-size: 14px;
        color: red;
        display: none;
        position: absolute;
        background-color: #fff;
        border: 1px solid #ccc;
        padding: 5px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
		left: 50%;
		bottom: 36%;
    }
</style>

</html>