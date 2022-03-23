<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<script>
	// Left 메뉴바 선택 표시를 위해 쿠키 사용
	$(function() {
		if($.cookie('name') == 'main') {
			$('.main').addClass('active');
		} else if($.cookie('name') == 'employee') {
			$('.employee').addClass('active');
		} else if($.cookie('name') == 'packages') {
			$('.packages').addClass('active');
		} else if($.cookie('name') == 'existingNew') {
			$('.existingNew').addClass('active');
		} else if($.cookie('name') == 'managementServer') {
			$('.managementServer').addClass('active');
		} else if($.cookie('name') == 'generalCustom') {
			$('.generalCustom').addClass('active');
		} else if($.cookie('name') == 'osType') {
			$('.osType').addClass('active');
		} else if($.cookie('name') == 'requestProductCategory') {
			$('.requestProductCategory').addClass('active');
		} else if($.cookie('name') == 'deliveryMethod') {
			$('.deliveryMethod').addClass('active');
		} else if($.cookie('name') == 'log') {
			$('.log').addClass('active');
		}
	});
</script>
<nav class="pcoded-navbar">
     <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
     <div class="pcoded-inner-navbar main-menu mCustomScrollbar _mCS_1 mCS_no_scrollbar" style="height: calc(100% - 56px);"><div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical_horizontal mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_1_container_wrapper" class="mCSB_container_wrapper mCS_y_hidden mCS_no_scrollbar_y mCS_x_hidden mCS_no_scrollbar_x"><div id="mCSB_1_container" class="mCSB_container" style="position: relative; top: 0px; left: 0px; width: 100%;" dir="ltr">
         <div class="">
             <div class="main-menu-header">
                 <img class="img-80 img-radius mCS_img_loaded" src="/AgentInfo/images/profile.png" alt="User-Profile-Image">
                 <div class="user-details">
                     <span id="more-details"><sec:authentication property="name"/></span>
                 </div>
             </div>

         </div>
         <div class="p-15 p-b-0"></div>
         <div class="pcoded-navigation-label" data-i18n="nav.category.navigation">home</div>
         <ul class="pcoded-item pcoded-left-item">
             <li class="main">
                 <a href="<c:url value='/index'/>" class="waves-effect waves-dark">
                     <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                     <span class="pcoded-mtext" data-i18n="nav.dash.main">Main</span>
                     <span class="pcoded-mcaret"></span>
                 </a>
             </li>
         </ul>
         
         <div class="pcoded-navigation-label" data-i18n="nav.category.forms">main</div>
         <ul class="pcoded-item pcoded-left-item">
             <li class="packages">
                 <a href="<c:url value='/packages/list'/>" class="waves-effect waves-dark">
                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">패키지 배포 내용</span>
                     <span class="pcoded-mcaret"></span>
                 </a>
             </li>
         </ul>

		 <sec:authorize access="hasRole('ADMIN')">
		 	<div class="pcoded-navigation-label" data-i18n="nav.category.forms">Log</div>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="log">
	                 <a href="<c:url value='/uidLog/list'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">로그 정보</span>
	                     <span class="pcoded-mcaret"></span>
	                 </a>
	             </li>
	         </ul>
	         <div class="pcoded-navigation-label" data-i18n="nav.category.forms">user</div>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="employee">
	                 <a href="<c:url value='/employee/list'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">사용자 정보</span>
	                     <span class="pcoded-mcaret"></span>
	                 </a>
	             </li>
	         </ul>
	         <div class="pcoded-navigation-label" data-i18n="nav.category.forms">category</div>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="existingNew">
	                 <a href="<c:url value='/category/existingNew'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">기존/신규</span>
	                 </a>
	             </li>
	         </ul>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="managementServer">
	                 <a href="<c:url value='/category/managementServer'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">관리서버/Agent</span>
	                 </a>
	             </li>
	         </ul>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="generalCustom">
	                 <a href="<c:url value='/category/generalCustom'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">일반/커스텀</span>
	                 </a>
	             </li>
	         </ul>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="osType">
	                 <a href="<c:url value='/category/osType'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">OS 종류</span>
	                 </a>
	             </li>
	         </ul>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="osType">
	                 <a href="<c:url value='/category/requestProductCategory'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">요청 제품 구분</span>
	                 </a>
	             </li>
	         </ul>
	         <ul class="pcoded-item pcoded-left-item">
	             <li class="osType">
	                 <a href="<c:url value='/category/deliveryMethod'/>" class="waves-effect waves-dark">
	                     <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
	                     <span class="pcoded-mtext" data-i18n="nav.form-components.main">전달 방법</span>
	                 </a>
	             </li>
	         </ul>
         </sec:authorize>

     </div></div><div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; height: 0px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div><div id="mCSB_1_scrollbar_horizontal" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_horizontal" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_horizontal" class="mCSB_dragger" style="position: absolute; min-width: 30px; width: 0px; left: 0px;"><div class="mCSB_dragger_bar"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
 </nav>