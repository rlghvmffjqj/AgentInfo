<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<nav class="navbar header-navbar pcoded-header iscollapsed">
    <div class="navbar-wrapper">
        <div class="navbar-logo">
            <a class="mobile-menu waves-effect waves-light" id="mobile-collapse" href="#!">
                <i class="ti-menu"></i>
            </a>
            <div class="mobile-search waves-effect waves-light">
                <div class="header-search">
                    <div class="main-search morphsearch-search">
                        <div class="input-group">
                            <span class="input-group-addon search-close"><i class="ti-close"></i></span>
                            <input type="text" class="form-control" placeholder="Enter Keyword">
                            <span class="input-group-addon search-btn"><i class="ti-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
            <a href="<c:url value='/index'/>">
                <img class="img-fluid" src="/AgentInfo/images/logo2.png" alt="Theme-Logo" style="margin-left: -10px;">
            </a>
            <a class="mobile-options waves-effect waves-light">
                <i class="ti-more"></i>
            </a>
        </div>
      
        <div class="navbar-container container-fluid">
            <ul class="nav-left">
                <li>
                    <div class="sidebar_toggle"><a href="javascript:void(0)"><i class="ti-menu"></i></a></div>
                </li>
                <li>
                    <a href="#!" onclick="javascript:toggleFullScreen()" class="waves-effect waves-light">
                        <i class="ti-fullscreen"></i>
                    </a>
                </li>
                <sec:authorize access="hasRole('ADMIN')">
	                <li style="height:55px">
	                	<label class="switch" style="margin-top: 12px;">
					        <input type="checkbox" id="customerSwitch" onclick="toggle(this)">
					        <span class="slider round"></span>
					    </label>
	                </li>
                </sec:authorize>
            </ul>
            <ul class="nav-right">
                <li class="user-profile header-notification">
                    <a href="#!" class="waves-effect waves-light">
                        <img src="/AgentInfo/images/profile.png" class="img-radius" alt="User-Profile-Image">
                        <span style="color:black;"><sec:authentication property="name"/></span>
                        <i class="ti-angle-down"></i>
                    </a>
                    <ul class="show-notification profile-notification">
                        <li class="waves-effect waves-light">
                            <a href="#" onclick="profileView()">
                                <i class="ti-user"></i> Profile
                            </a>
                        </li>
                        <li class="waves-effect waves-light">
                            <a href="<c:url value='/logout' />">
                                <i class="ti-layout-sidebar-left"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<script>
/* =========== 프로필 조회 ========= */
function profileView() {	
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/users/profileView'/>",
	    async: false,
	    success: function (data) {
	    	if(data.indexOf("<!DOCTYPE html>") != -1) 
				location.reload();
	        $.modal(data, 'l'); //modal창 호출
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});
 }
 
/* =========== 고객사 표시, 숨김(쿠키) ========= */
function toggle(element) {
    if(element.checked) {
    	$('.customerLog').show();
    	$('.customerInfoSwitch').show();
    	$.cookie('customerSwitch','on',{path:'/'});
    } else {
    	$('.customerLog').hide();
    	$('.customerInfoSwitch').hide();
    	$.cookie('customerSwitch','off',{path:'/'});
    }
    /* location.reload(); */
}

/* =========== 쿠키값 으로 고객사 표시, 숨김 ========= */
$(function() {
	<sec:authorize access="hasAnyRole('ENGINEER','MEMBER')">
		$.removeCookie('customerSwitch', { path: '/' });
	</sec:authorize>
	var cookieSwitch = $.cookie('customerSwitch');
	if(cookieSwitch == 'on') {
		$("#customerSwitch").prop("checked",true);
		customerSwitch(true);
	} else {
		$("#customerSwitch").prop("checked",false);
		customerSwitch(false);
	}
});

/* =========== 고객사 표시, 숨김 ========= */
function customerSwitch(result) {
	if(result) {
		$('.customerLog').show();
		$('.customerInfoSwitch').show();
	} else {
		$('.customerLog').hide();
		$('.customerInfoSwitch').hide();
	}
}
</script>