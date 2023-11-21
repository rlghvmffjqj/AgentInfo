<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<script>
	/** Left 메뉴바 선택 표시를 위해 쿠키 사용 **/
	$(function() {
		if($.cookie('name') == 'home') {
			$('.home').addClass('active');
		} else if($.cookie('name') == 'employee') {
			$('.employee').addClass('active');
		} else if($.cookie('name') == 'packages') {
			$('.packages').addClass('active');
		} else if($.cookie('name') == 'existingNew') {
			$('.existingNew').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'managementServer') {
			$('.managementServer').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'generalCustom') {
			$('.generalCustom').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'osType') {
			$('.osType').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'requestProductCategory') {
			$('.requestProductCategory').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'deliveryMethod') {
			$('.deliveryMethod').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'agentVer') {
			$('.agentVer').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'agentOS') {
			$('.agentOS').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'log') {
			$('.log').addClass('active');
		} else if($.cookie('name') == 'customerName') {
			$('.customerName').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'businessName') {
			$('.businessName').addClass('active');
			$('.categroy').addClass('active');
			$('.categroy').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'trash') {
			$('.trash').addClass('active');
		} else if($.cookie('name') == 'generalPackage') {
			$('.generalPackage').addClass('active');
			$('.releaseNotes').addClass('active');
			$('.releaseNotes').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'customPackage') {
			$('.customPackage').addClass('active');
			$('.releaseNotes').addClass('active');
			$('.releaseNotes').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'customer') {
			$('.customer').addClass('active');
		} else if($.cookie('name') == 'product') {
			$('.product').addClass('active');
		} else if($.cookie('name') == 'requests') {
			$('.requests').addClass('active');
		} else if($.cookie('name') == 'requestsWrite') {
			$('.requestsWrite').addClass('active');
		} else if($.cookie('name') == 'customerInfo') {
			$('.customerInfo').addClass('active');
		} else if($.cookie('name') == 'packageLog') {
			$('.packageLog').addClass('active');
			$('.log').addClass('active');
			$('.log').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'licenseLog') {
			$('.licenseLog').addClass('active');
			$('.log').addClass('active');
			$('.log').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'license5Log') {
			$('.license5Log').addClass('active');
			$('.log').addClass('active');
			$('.log').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'customerLog') {
			$('.customerLog').addClass('active');
			$('.log').addClass('active');
			$('.log').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'employeeLog') {
			$('.employeeLog').addClass('active');
			$('.log').addClass('active');
			$('.log').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'serverListLog') {
			$('.serverListLog').addClass('active');
			$('.log').addClass('active');
			$('.log').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'loginSession') {
			$('.loginSession').addClass('active');
		} else if($.cookie('name') == 'schedule') {
			$('.schedule').addClass('active');
		} else if($.cookie('name') == 'license5') {
			$('.license').addClass('active');
			$('.license').addClass('pcoded-trigger');
			$('.license5').addClass('active');
		} else if($.cookie('name') == 'license2') {
			$('.license').addClass('active');
			$('.license').addClass('pcoded-trigger');
			$('.license2').addClass('active');
		} else if($.cookie('name') == 'licenseRequest') {
			$('.license').addClass('active');
			$('.license').addClass('pcoded-trigger');
			$('.licenseRequest').addClass('active');
		} else if($.cookie('name') == 'externalEquipment') {
			$('.externalEquipment').addClass('active');
			$('.serverList').addClass('active');
			$('.serverList').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'internalEquipment') {
			$('.internalEquipment').addClass('active');
			$('.serverList').addClass('active');
			$('.serverList').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'hyperV') {
			$('.hyperV').addClass('active');
			$('.serverList').addClass('active');
			$('.serverList').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'issueWrite') {
			$('.issueWrite').addClass('active');
		} else if($.cookie('name') == 'issueList') {
			$('.issueList').addClass('active');
		} else if($.cookie('name') == 'individualNote') {
			$('.individualNote').addClass('active');
			$('.note').addClass('active');
			$('.note').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'sharedNote') {
			$('.sharedNote').addClass('active');
			$('.note').addClass('active');
			$('.note').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'calendar') {
			$('.calendar').addClass('active');
		} else if($.cookie('name') == 'individualCalendar') {
			$('.individualCalendar').addClass('active');
			$('.calendar').addClass('active');
			$('.calendar').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'sharedCalendar') {
			$('.sharedCalendar').addClass('active');
			$('.calendar').addClass('active');
			$('.calendar').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'serverCalendar') {
			$('.serverCalendar').addClass('active');
			$('.calendar').addClass('active');
			$('.calendar').addClass('pcoded-trigger');
		} else if($.cookie('name') == 'calendar') {
			$('.calendar').addClass('active');
		} else if($.cookie('name') == 'sendPackage') {
			$('.sendPackage').addClass('active');
		} else if($.cookie('name') == 'customerLicenseManagement') {
			$('.customerLicense').addClass('active');
			$('.customerLicense').addClass('pcoded-trigger');
			$('.customerLicenseManagement').addClass('active');
		} else if($.cookie('name') == 'engineerUnassigned') {
			$('.customerLicense').addClass('active');
			$('.customerLicense').addClass('pcoded-trigger');
			$('.engineerUnassigned').addClass('active');
		} else if($.cookie('name') == 'unissuedLicense') {
			$('.customerLicense').addClass('active');
			$('.customerLicense').addClass('pcoded-trigger');
			$('.unissuedLicense').addClass('active');
		} else if($.cookie('name') == 'checkListSetting') {
			$('.checkListSetting').addClass('active');
			$('.setting').addClass('pcoded-trigger');
			$('.setting').addClass('active');
		} else if($.cookie('name') == 'checkList') {
			$('.checkList').addClass('active');
		} else if($.cookie('name') == 'functionTestSetting') {
			$('.functionTestSetting').addClass('active');
			$('.setting').addClass('pcoded-trigger');
			$('.setting').addClass('active');
		} else if($.cookie('name') == 'functionTestTortal') {
			$('.functionTestTortal').addClass('active');
			$('.functionTest').addClass('pcoded-trigger');
			$('.functionTest').addClass('active');
		} else if($.cookie('name') == 'functionTestBasic') {
			$('.functionTestBasic').addClass('active');
			$('.functionTest').addClass('pcoded-trigger');
			$('.functionTest').addClass('active');
		} else if($.cookie('name') == 'functionTestFoundation') {
			$('.functionTestFoundation').addClass('active');
			$('.functionTest').addClass('pcoded-trigger');
			$('.functionTest').addClass('active');
		} else if($.cookie('name') == 'testCase') {
			$('.testCase').addClass('active');
		}  else if($.cookie('name') == 'customerConsolidation') {
			$('.customerConsolidation').addClass('active');
		} else if($.cookie('name') == 'questionAnswer') {
			$('.questionAnswer').addClass('active');
		} else if($.cookie('name') == 'packageAnalysisSimple') {
			$('.packageAnalysisSimple').addClass('active');
			$('.packageAnalysis').addClass('pcoded-trigger');
			$('.packageAnalysis').addClass('active');
		} else if($.cookie('name') == 'packageAnalysisDetail') {
			$('.packageAnalysisDetail').addClass('active');
			$('.packageAnalysis').addClass('pcoded-trigger');
			$('.packageAnalysis').addClass('active');
		}
	});
</script>
<nav class="pcoded-navbar">
	
	<div class="pcoded-inner-navbar main-menu mCustomScrollbar _mCS_1 mCS_no_scrollbar" style="height: calc(100% - 56px);"><div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical_horizontal mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_1_container_wrapper" class="mCSB_container_wrapper mCS_y_hidden mCS_no_scrollbar_y mCS_x_hidden mCS_no_scrollbar_x"><div id="mCSB_1_container" class="mCSB_container" style="background-color: lightgray; position: relative; top: 0px; left: 0px; width: 100%; height: 100%" dir="ltr">
		<div class="height-100">
			<div class="main-menu-header page-header height-100">
			    <img class="img-80 img-radius mCS_img_loaded" src="/AgentInfo/images/profile.png" alt="User-Profile-Image">
			    <div class="user-details">
			        <span id="more-details"><sec:authentication property="name"/></span>
			    </div>
			</div>
		</div>
		<div class="box" style="overflow-y: scroll; height: 85%; background-color: lightgray;">
		    <div class="p-15 p-b-0"></div>
		    <div class="pcoded-navigation-label" data-i18n="nav.category.navigation">home</div>
		    <ul class="pcoded-item pcoded-left-item">
		        <li class="home">
		            <a href="<c:url value='/index'/>" class="waves-effect waves-dark">
		                <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
		                <span class="pcoded-mtext" data-i18n="nav.dash.main">Home</span>
		                <span class="pcoded-mcaret"></span>
		            </a>
		        </li>
		    </ul>
		    <div class="pcoded-navigation-label" data-i18n="nav.category.forms">main</div>
			<sec:authorize access="hasAnyRole('ADMIN','MEMBER','ENGINEER','QA','ENGINEERLEADER','SALES')">
		    	<ul class="pcoded-item pcoded-left-item">
		    	    <li class="packages">
		    	        <a href="<c:url value='/packages/list'/>" class="waves-effect waves-dark">
		    	            <span class="pcoded-micon"><i class="ti-harddrives"></i><b>FC</b></span>
		    	            <span class="pcoded-mtext" data-i18n="nav.form-components.main">패키지 배포 내용</span>
		    	            <span class="pcoded-mcaret"></span>
		    	        </a>
		    	    </li>
		    	</ul>
			</sec:authorize>
		    <sec:authorize access="hasRole('ADMIN')">
		    	<ul class="pcoded-item pcoded-left-item">
				    <li class="sendPackage">
				        <a href="<c:url value='/sendPackage/list'/>" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-share"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">패키지 전송</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				    </li>
				</ul>
		    </sec:authorize>
		    <sec:authorize access="hasAnyRole('ADMIN','LICENSE')">
			    <ul class="pcoded-item pcoded-left-item">
					<li class="license pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-key"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">라이선스 관리</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				        <ul class="pcoded-submenu" style="display: block;">
				         	<li class="license5">
								<a href="<c:url value='/license5/issuance'/>" class="waves-effect waves-dark">
									<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
									<span class="pcoded-mtext">라이선스 5.0</span>
									<span class="pcoded-mcaret"></span>
								</a>
					     	</li>
						    <li class="license2">
						           <a href="<c:url value='/license/issuance'/>" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext">라이선스 2.0</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						    </li>
							<li class="licenseRequest">
								<a href="<c:url value='/license5/request'/>" class="waves-effect waves-dark">
								  <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
								  <span class="pcoded-mtext">라이선스 발급 요청</span>
								  <span class="pcoded-mcaret"></span>
								</a>
						 	</li>
					  	</ul>
				    </li>
			    </ul>
		    </sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','ENGINEER','ENGINEERLEADER','LICENSE','SALES')">
				<ul class="pcoded-item pcoded-left-item">
					<li class="customerConsolidation">
						<a href="<c:url value='/customerConsolidation/list'/>" class="waves-effect waves-dark">
							<span class="pcoded-micon"><i class="ti-clipboard"></i><b>FC</b></span>
							<span class="pcoded-mtext" data-i18n="nav.form-components.main">고객사 통합관리</span>
							<span class="pcoded-mcaret"></span>
						</a>
					</li>
				</ul>
			
				<!-- <ul class="pcoded-item pcoded-left-item">
					<li class="customerLicense pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-clipboard"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">고객사 & 라이선스<br>(개발 중)</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				        <ul class="pcoded-submenu" style="display: block;">
				         	<li class="customerLicenseManagement">
								<a href="<c:url value='/customerLicense/customerLicenseManagement/list'/>" class="waves-effect waves-dark">
									<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
									<span class="pcoded-mtext" style="font-size: 13px;">고객사 & 라이선스 관리</span>
									<span class="pcoded-mcaret"></span>
								</a>
					     	</li>
							 <sec:authorize access="hasAnyRole('ADMIN','ENGINEER')">
						    	<li class="engineerUnassigned">
						    	       <a href="<c:url value='/customerLicense/engineerUnassigned/list'/>" class="waves-effect waves-dark">
						    	         <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						    	         <span class="pcoded-mtext" style="font-size: 13px;">엔지니어 미배정 사업 목록</span>
						    	         <span class="pcoded-mcaret"></span>
						    	       </a>
						    	</li>
							</sec:authorize>
						    <li class="unissuedLicense">
						           <a href="<c:url value='/customerLicense/unissuedLicense/list'/>" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext" style="font-size: 13px;">미발급 라이선스 요청 목록</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						    </li>
					  	</ul>
				    </li>
				</ul> -->
			</sec:authorize>
		    <%-- <ul class="pcoded-item pcoded-left-item">
		        <li class="customer">
		            <a href="<c:url value='/customer/list'/>" class="waves-effect waves-dark">
		                <span class="pcoded-micon"><i class="ti-server"></i><b>FC</b></span>
		                <span class="pcoded-mtext" data-i18n="nav.form-components.main">고객사 정보</span>
		                <span class="pcoded-mcaret"></span>
		            </a>
		        </li>
		    </ul> --%>
		    <%-- <ul class="pcoded-item pcoded-left-item">
		        <li class="product">
		            <a href="<c:url value='/product/list'/>" class="waves-effect waves-dark">
		                <span class="pcoded-micon"><i class="ti-server"></i><b>FC</b></span>
		                <span class="pcoded-mtext" data-i18n="nav.form-components.main">제품 버전 정보</span>
		                <span class="pcoded-mcaret"></span>
		            </a>
		        </li>
		    </ul> --%>
		    <ul class="pcoded-item pcoded-left-item customerInfoSwitch" style="display: none;">
		        <li class="customerInfo">
		            <a href="<c:url value='/customerInfo/search'/>" class="waves-effect waves-dark">
		                <span class="pcoded-micon"><i class="ti-clipboard"></i><b>FC</b></span>
		                <span class="pcoded-mtext" data-i18n="nav.form-components.main">고객사 정보</span>
		                <span class="pcoded-mcaret"></span>
		            </a>
		        </li>
		    </ul>
		    <sec:authorize access="hasAnyRole('ADMIN','QA')">
			    <ul class="pcoded-item pcoded-left-item">
					<li class="serverList pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-server"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">서버 목록</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				        <ul class="pcoded-submenu" style="display: block;">
				         	<li class="externalEquipment">
								<a href="<c:url value='/serverList/list'/>?serverListType=externalEquipment" class="waves-effect waves-dark">
									<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
									<span class="pcoded-mtext">외부망 장비</span>
									<span class="pcoded-mcaret"></span>
								</a>
					     	</li>
						    <li class="internalEquipment">
						           <a href="<c:url value='/serverList/list'/>?serverListType=internalEquipment" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext">내부망 장비</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						    </li>
						    <li class="hyperV">
						           <a href="<c:url value='/serverList/list'/>?serverListType=hyperV" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext">Hyper-V</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						    </li>
					  	</ul>
				    </li>
			    </ul>
		    </sec:authorize>
			<div class="pcoded-navigation-label" data-i18n="nav.category.forms">sub Main</div>
			<sec:authorize access="hasAnyRole('ADMIN','QA')">
				<ul class="pcoded-item pcoded-left-item">
					<li class="packageAnalysis pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">패키지 분석</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				        <ul class="pcoded-submenu" style="display: block;">
				         	<li class="packageAnalysisSimple">
								<a href="<c:url value='/packageAnalysis/upload'/>" class="waves-effect waves-dark">
				        		    <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
				        		    <span class="pcoded-mtext" data-i18n="nav.form-components.main">간편 패키지 분석</span>
				        		    <span class="pcoded-mcaret"></span>
				        		</a>
					     	</li>
						    <li class="packageAnalysisDetail">
								<a href="<c:url value='/packageAnalysis/upload'/>" class="waves-effect waves-dark">
				        		    <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
				        		    <span class="pcoded-mtext" data-i18n="nav.form-components.main">정밀 패키지 분석</span>
				        		    <span class="pcoded-mcaret"></span>
				        		</a>
						    </li>
					  	</ul>
				    </li>
				</ul>
		    	<ul class="pcoded-item pcoded-left-item">
				    <li class="testCase">
				        <a href="<c:url value='/testCase/list'/>" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-layout-media-overlay"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">테스트 케이스</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				    </li>
				</ul>
				<!-- <ul class="pcoded-item pcoded-left-item">
				    <li class="checkList">
				        <a href="<c:url value='/checkList/list'/>" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-check-box"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">체크 리스트</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				    </li>
				</ul> -->
				<ul class="pcoded-item pcoded-left-item">
					<li class="functionTest pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-check-box"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">기능 체크 리스트</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				        <ul class="pcoded-submenu" style="display: block;">
				         	<li class="functionTestTortal">
								<a href="<c:url value='/functionTest/list'/>?functionTestType=tortal" class="waves-effect waves-dark">
									<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
									<span class="pcoded-mtext">전수 테스트</span>
									<span class="pcoded-mcaret"></span>
								</a>
					     	</li>
						    <li class="functionTestBasic">
						           <a href="<c:url value='/functionTest/list'/>?functionTestType=basic" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext">기본 테스트</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						    </li>
						    <li class="functionTestFoundation">
						           <a href="<c:url value='/functionTest/list'/>?functionTestType=foundation" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext">기초 테스트</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						    </li>
					  	</ul>
				    </li>
			    </ul>
			</sec:authorize>
		    <sec:authorize access="hasAnyRole('ADMIN','QA')">
			   	<ul class="pcoded-item pcoded-left-item">
				    <li class="issueList">
				        <a href="<c:url value='/issue/issueList'/>" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-receipt"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">이슈 목록</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				    </li>
				</ul>
			    <%-- <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Issue</div>
			    <ul class="pcoded-item pcoded-left-item">
				    <li class="issueWrite">
				        <a href="<c:url value='/issue/issueWrite'/>" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-pencil-alt"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">이슈 작성</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				    </li>
			    </ul> --%>
		    </sec:authorize>
			<ul class="pcoded-item pcoded-left-item">
				<li class="questionAnswer">
					<a href="<c:url value='/questionAnswer/list'/>" class="waves-effect waves-dark">
						<span class="pcoded-micon"><i class="ti-help"></i><b>FC</b></span>
						<span class="pcoded-mtext" data-i18n="nav.form-components.main">Q & A</span>
						<span class="pcoded-mcaret"></span>
					</a>
				</li>
			</ul>
		    <sec:authorize access="hasAnyRole('ADMIN','ENGINEER','ENGINEERLEADER','SALES')">
		        <div class="pcoded-navigation-label" data-i18n="nav.category.forms">release notes</div>
		        <ul class="pcoded-item pcoded-left-item">
					<li class="releaseNotes pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
		                    <span class="pcoded-micon"><i class="ti-download"></i><b>FC</b></span>
		                    <span class="pcoded-mtext" data-i18n="nav.form-components.main">릴리즈 노트</span>
		                    <span class="pcoded-mcaret"></span>
		                </a>
		                <ul class="pcoded-submenu" style="display: block;">
		                 	<li class="generalPackage">
								<a href="<c:url value='/generalPackage/List'/>" class="waves-effect waves-dark">
									<span class="pcoded-micon"><i class="ti-angle-right"></i></span>
									<span class="pcoded-mtext">일반패키지</span>
									<span class="pcoded-mcaret"></span>
								</a>
					     	</li>
						     <li class="customPackage">
						           <a href="<c:url value='/customPackage/List'/>" class="waves-effect waves-dark">
						             <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
						             <span class="pcoded-mtext">커스텀 패키지</span>
						             <span class="pcoded-mcaret"></span>
						           </a>
						     </li>
					  	</ul>
		            </li>
		        </ul>
		    </sec:authorize>
		    <div class="pcoded-navigation-label" data-i18n="nav.category.forms">private</div>
			<ul class="pcoded-item pcoded-left-item">
			    <li class="note pcoded-hasmenu">
					<a href="#!" class="waves-effect waves-dark">
			            <span class="pcoded-micon"><i class="ti-bookmark-alt"></i><b>FC</b></span>
			            <span class="pcoded-mtext" data-i18n="nav.form-components.main">노트</span>
			            <span class="pcoded-mcaret"></span>
			        </a>
			        <ul class="pcoded-submenu" style="display: block;">
				        <li class="individualNote">
				            <a href="<c:url value='/individualNote/list'/>" class="waves-effect waves-dark">
				                <span class="pcoded-micon"><i class="ti-bookmark-alt"></i><b>FC</b></span>
			            		<span class="pcoded-mtext" data-i18n="nav.form-components.main">개인 노트</span>
			            		<span class="pcoded-mcaret"></span>
				            </a>
				        </li>
				        <li class="sharedNote">
				            <a href="<c:url value='/sharedNote/list'/>" class="waves-effect waves-dark">
				                <span class="pcoded-micon"><i class="ti-bookmark-alt"></i><b>FC</b></span>
				                <span class="pcoded-mtext" data-i18n="nav.form-components.main">부서 노트</span>
				                <span class="pcoded-mcaret"></span>
				            </a>
				        </li>
					</ul>
				</li>
			</ul>
			<ul class="pcoded-item pcoded-left-item">
				<li class="calendar pcoded-hasmenu">
					<a href="#!" class="waves-effect waves-dark">
			            <span class="pcoded-micon"><i class="ti-calendar"></i><b>FC</b></span>
			            <span class="pcoded-mtext" data-i18n="nav.form-components.main">일정</span>
			            <span class="pcoded-mcaret"></span>
			        </a>
			        <ul class="pcoded-submenu" style="display: block;">
				        <li class="individualCalendar">
					        <a href="<c:url value='/calendar/list'/>" class="waves-effect waves-dark">
					            <span class="pcoded-micon"><i class="ti-calendar"></i><b>FC</b></span>
					            <span class="pcoded-mtext" data-i18n="nav.form-components.main">개인 일정</span>
					            <span class="pcoded-mcaret"></span>
					        </a>
					    </li>
				        <li class="sharedCalendar">
					        <a href="<c:url value='/sharedCalendar/list'/>" class="waves-effect waves-dark">
					            <span class="pcoded-micon"><i class="ti-calendar"></i><b>FC</b></span>
					            <span class="pcoded-mtext" data-i18n="nav.form-components.main">부서 일정</span>
					            <span class="pcoded-mcaret"></span>
					        </a>
					    </li>
					    <sec:authorize access="hasAnyRole('ADMIN','QA')">
						    <li class="serverCalendar">
						       <a href="<c:url value='/serverCalendar/list'/>" class="waves-effect waves-dark">
						           <span class="pcoded-micon"><i class="ti-calendar"></i><b>FC</b></span>
						           <span class="pcoded-mtext" data-i18n="nav.form-components.main">장비대여 일정</span>
						           <span class="pcoded-mcaret"></span>
						       </a>
						    </li>
						</sec:authorize>
					</ul>
				</li>
			</ul>
			<sec:authorize access="hasAnyRole('ADMIN','LICENSE')">
		 		<div class="pcoded-navigation-label" data-i18n="nav.category.forms">Log</div>
			    <ul class="pcoded-item pcoded-left-item">
			    	<li class="log pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
			                <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
			                <span class="pcoded-mtext" data-i18n="nav.form-components.main">로그 정보</span>
			                <span class="pcoded-mcaret"></span>
			            </a>
			            <ul class="pcoded-submenu" style="display: block;">
							<sec:authorize access="hasAnyRole('ADMIN')">
					        	<li class="packageLog">
					        	    <a href="<c:url value='/packageUidLog/list'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
					        	        <span class="pcoded-mtext" data-i18n="nav.form-components.main">패키지 배포 내용 로그</span>
					        	        <span class="pcoded-mcaret"></span>
					        	    </a>
					        	</li>
							</sec:authorize>
					        <li class="license5Log">
					            <a href="<c:url value='/license5UidLog/list'/>" class="waves-effect waves-dark">
					                <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
					                <span class="pcoded-mtext" data-i18n="nav.form-components.main">라이선스 5.0 관리 로그</span>
					                <span class="pcoded-mcaret"></span>
					            </a>
					        </li>
					        <li class="licenseLog">
					            <a href="<c:url value='/licenseUidLog/list'/>" class="waves-effect waves-dark">
					                <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
					                <span class="pcoded-mtext" data-i18n="nav.form-components.main">라이선스 2.0 관리 로그</span>
					                <span class="pcoded-mcaret"></span>
					            </a>
					        </li>
							<sec:authorize access="hasAnyRole('ADMIN')">
					        	<li class="customerLog" style="display: none;">
					        	    <a href="<c:url value='/customerUidLog/list'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
					        	        <span class="pcoded-mtext" data-i18n="nav.form-components.main">고객사 정보 로그</span>
					        	        <span class="pcoded-mcaret"></span>
					        	    </a>
					        	</li>
					        	<%-- <li class="serverListLog">
					        	    <a href="<c:url value='/severListUidLog/list'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
					        	        <span class="pcoded-mtext" data-i18n="nav.form-components.main">서버 목록 로그</span>
					        	        <span class="pcoded-mcaret"></span>
					        	    </a>
					        	</li> --%>
					        	<li class="employeeLog">
					        	    <a href="<c:url value='/employeeUidLog/list'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-files"></i><b>FC</b></span>
					        	        <span class="pcoded-mtext" data-i18n="nav.form-components.main">사용자 접속 정보 로그</span>
					        	        <span class="pcoded-mcaret"></span>
					        	    </a>
					        	</li>
							</sec:authorize>
						</ul>
					</li>
			    </ul>
				<sec:authorize access="hasAnyRole('ADMIN')">
		        	<div class="pcoded-navigation-label" data-i18n="nav.category.forms">user</div>
		        	<ul class="pcoded-item pcoded-left-item">
			    	    <li class="employee">
			    	        <a href="<c:url value='/employee/list'/>" class="waves-effect waves-dark">
			    	            <span class="pcoded-micon"><i class="ti-user"></i><b>FC</b></span>
			    	            <span class="pcoded-mtext" data-i18n="nav.form-components.main">사용자 정보</span>
			    	            <span class="pcoded-mcaret"></span>
			    	        </a>
			    	    </li>
		        	</ul>
			    	<div class="pcoded-navigation-label" data-i18n="nav.category.forms">trash</div>
			    	<ul class="pcoded-item pcoded-left-item">
			    	    <li class="trash">
			    	        <a href="<c:url value='/trash/list'/>" class="waves-effect waves-dark">
			    	            <span class="pcoded-micon"><i class="ti-trash"></i><b>FC</b></span>
			    	            <span class="pcoded-mtext" data-i18n="nav.form-components.main">삭제 이력</span>
			    	            <span class="pcoded-mcaret"></span>
			    	        </a>
			    	    </li>
			    	</ul>
			    	<div class="pcoded-navigation-label" data-i18n="nav.category.forms">category</div>
			    	<ul class="pcoded-item pcoded-left-item">
			    	    <li class="categroy pcoded-hasmenu">
			    	        <a href="#!" class="waves-effect waves-dark">
			    	            <span class="pcoded-micon"><i class="ti-view-grid"></i><b>FC</b></span>
			    	            <span class="pcoded-mtext" data-i18n="nav.form-components.main">카테고리</span>
			    	            <span class="pcoded-mcaret"></span>
			    	        </a>
			    	        <ul class="pcoded-submenu" style="display: block;">
			    	        	<li class="customerName">
			    	               <a href="<c:url value='/category/customerName'/>" class="waves-effect waves-dark">
					                <span class="pcoded-micon"><i class="ti-angle-right"></i><b>FC</b></span>
					                <span class="pcoded-mtext">고객사명</span>
					                <span class="pcoded-mcaret"></span>
					              </a>
					        	</li>
					        	<li class="businessName">
					        	      <a href="<c:url value='/category/businessName'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">사업명</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					        	</li>
					        	<li class="managementServer">
					        	      <a href="<c:url value='/category/managementServer'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">패키지 종류</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					        	 </li>
					        	 <li class="existingNew">
					        	      <a href="<c:url value='/category/existingNew'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">기존/신규</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
					    		<li class="generalCustom">
					        	      <a href="<c:url value='/category/generalCustom'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">일반/커스텀</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
					    		<li class="osType">
					        	      <a href="<c:url value='/category/osType'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">OS 종류</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
					    		<li class="requestProductCategory">
					        	      <a href="<c:url value='/category/requestProductCategory'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">요청 제품 구분</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
					    		<li class="deliveryMethod">
					        	      <a href="<c:url value='/category/deliveryMethod'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">전달 방법</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
					    		<li class="agentVer">
					        	      <a href="<c:url value='/category/agentVer'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">Agent ver</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
					    		<li class="agentOS">
					        	      <a href="<c:url value='/category/agentOS'/>" class="waves-effect waves-dark">
					        	        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
					        	        <span class="pcoded-mtext">Agent OS</span>
					        	        <span class="pcoded-mcaret"></span>
					        	      </a>
					    		</li>
			    	    	</ul>
			    	    </li>
			    	</ul>
				</sec:authorize>
		    </sec:authorize>
			<sec:authorize access="hasRole('ADMIN')">
		    	<div class="pcoded-navigation-label" data-i18n="nav.category.forms">request</div>
				<ul class="pcoded-item pcoded-left-item">
				    <li class="requests">
				        <a href="<c:url value='/requests/list'/>" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-view-list"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">요청 사항</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				    </li>
				</ul>
		    	<ul class="pcoded-item pcoded-left-item">
		    	    <li class="requestsWrite">
		    	        <a href="<c:url value='/requestsWrite/list'/>" class="waves-effect waves-dark">
		    	            <span class="pcoded-micon"><i class="ti-write"></i><b>FC</b></span>
		    	            <span class="pcoded-mtext" data-i18n="nav.form-components.main">요청 작성</span>
		    	            <span class="pcoded-mcaret"></span>
		    	        </a>
		    	    </li>
		    	</ul>
			</sec:authorize>
		    <sec:authorize access="hasRole('ADMIN')">
				<div class="pcoded-navigation-label" data-i18n="nav.category.forms">admin</div>
			    <ul class="pcoded-item pcoded-left-item">
			        <li class="loginSession">
			            <a href="<c:url value='/loginSession/list'/>" class="waves-effect waves-dark">
			                <span class="pcoded-micon"><i class="ti-target"></i><b>FC</b></span>
			                <span class="pcoded-mtext" data-i18n="nav.form-components.main">접속 세션 목록</span>
			                <span class="pcoded-mcaret"></span>
			            </a>
			        </li>
			    </ul>
			    <ul class="pcoded-item pcoded-left-item">
			        <li class="schedule">
			            <a href="<c:url value='/schedule/list'/>" class="waves-effect waves-dark">
			                <span class="pcoded-micon"><i class="ti-notepad"></i><b>FC</b></span>
			                <span class="pcoded-mtext" data-i18n="nav.form-components.main">스케쥴 목록</span>
			                <span class="pcoded-mcaret"></span>
			            </a>
			        </li>
			    </ul>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','QA')">
				<%-- <ul class="pcoded-item pcoded-left-item">
			        <li class="checkListSetting">
			            <a href="<c:url value='/checkListSetting/setting'/>" class="waves-effect waves-dark">
			                <span class="pcoded-micon"><i class="ti-settings"></i><b>FC</b></span>
			                <span class="pcoded-mtext" data-i18n="nav.form-components.main">체크 리스트 설정</span>
			                <span class="pcoded-mcaret"></span>
			            </a>
			        </li>
			    </ul>
			    <ul class="pcoded-item pcoded-left-item">
			        <li class="functionTestSetting">
			            <a href="<c:url value='/functionTestSetting/setting'/>" class="waves-effect waves-dark">
			                <span class="pcoded-micon"><i class="ti-settings"></i><b>FC</b></span>
			                <span class="pcoded-mtext" data-i18n="nav.form-components.main">기능 테스트 설정</span>
			                <span class="pcoded-mcaret"></span>
			            </a>
			        </li>
			    </ul> --%>
			    
			    <ul class="pcoded-item pcoded-left-item">
				    <li class="setting pcoded-hasmenu">
						<a href="#!" class="waves-effect waves-dark">
				            <span class="pcoded-micon"><i class="ti-settings"></i><b>FC</b></span>
				            <span class="pcoded-mtext" data-i18n="nav.form-components.main">설정</span>
				            <span class="pcoded-mcaret"></span>
				        </a>
				        <ul class="pcoded-submenu" style="display: block;">
					        <!-- <li class="checkListSetting">
					            <a href="<c:url value='/checkListSetting/setting'/>" class="waves-effect waves-dark">
					                <span class="pcoded-micon"><i class="ti-settings"></i><b>FC</b></span>
				            		<span class="pcoded-mtext" data-i18n="nav.form-components.main">체크 리스트 설정</span>
				            		<span class="pcoded-mcaret"></span>
					            </a>
					        </li> -->
					        <li class="functionTestSetting">
					            <a href="<c:url value='/functionTestSetting/setting'/>" class="waves-effect waves-dark">
					                <span class="pcoded-micon"><i class="ti-settings"></i><b>FC</b></span>
					                <span class="pcoded-mtext" data-i18n="nav.form-components.main">기능 테스트 설정</span>
					                <span class="pcoded-mcaret"></span>
					            </a>
					        </li>
						</ul>
					</li>
				</ul>
			</sec:authorize>
		</div>
     </div></div><div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; height: 0px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div><div id="mCSB_1_scrollbar_horizontal" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_horizontal" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_horizontal" class="mCSB_dragger" style="position: absolute; min-width: 30px; width: 0px; left: 0px;"><div class="mCSB_dragger_bar"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
 </nav>