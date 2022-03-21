<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <title>로그인</title>

 </head>
<body themebg-pattern="theme1">

    <section class="login-block">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    
                     <form class="md-float-material form-material" method="post" >
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
                                     <input type="text" name="usersId" class="form-control" required="required">
                                     <span class="form-bar"></span>
                                     <label class="float-label">ID</label>
                                 </div>
                                 <div class="form-group form-primary">
                                     <input type="password" name="usersPw" class="form-control" required="required">
                                     <span class="form-bar"></span>
                                     <label class="float-label">Password</label>
                                 </div>
                                 <div class="row m-t-25 text-left">
                                     <div class="col-12">
                                         <div class="checkbox-fade fade-in-primary d-">
                                             <label>
                                                 <input type="checkbox" value="">
                                                 <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                 <span class="text-inverse">아이디 저장</span>
                                             </label>
                                         </div>
                                         <div class="forgot-phone text-right f-right">
                                             <!-- <a href="#" class="text-right f-w-600"> 패스워드 찾기</a> -->
                                         </div>
                                     </div>
                                 </div>
                                 <div class="row m-t-30">
                                     <div class="col-md-12">
                                         <button type="submit" class="btn btn-primary btn-md btn-block waves-effect waves-light text-center">Login</button>

                                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </form>
                     
                </div>
            </div>
        </div>
    </section>
</body>

</html>