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
	    	$.cookie('name','trash');
	    });
    </script>
	<script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/trash'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','고객사 명','사업명','요청일자','전달일자','패키지 종류','일반/커스텀','Agent ver','패키지명','담당자','OS종류','패키지 상세버전','Agent OS','기존/신규','요청 제품구분','전달 방법','비고','사용자','시간'],
				colModel:[
					{name:'trashKeyNum', index:'trashKeyNum', align:'center', width: 25, hidden:true },
					{name:'trashCustomerName', index:'trashCustomerName', align:'center', width: 200},
					{name:'trashBusinessName', index:'trashBusinessName', align:'center', width: 180},
					{name:'trashRequestDate', index:'trashRequestDate', align:'center', width: 70},
					{name:'trashDeliveryData', index:'trashDeliveryData',align:'center', width: 70},
					{name:'trashManagementServer', index:'trashManagementServer', align:'center', width: 80},
					{name:'trashGeneralCustom', index:'trashGeneralCustom', align:'center', width: 60},
					{name:'trashAgentVer', index:'trashAgentVer', align:'center', width: 170},
					{name:'trashPackageName', index:'trashPackageName', align:'center', width: 630},
					{name:'trashManager', index:'trashManager', align:'center', width: 80},
					{name:'trashOsType', index:'trashOsType', align:'center', width: 80},
					{name:'trashOsDetailVersion', index:'trashOsDetailVersion', align:'center', width: 350},
					{name:'trashAgentOS', index:'trashAgentOS', align:'center', width: 120},
					{name:'trashExistingNew', index:'trashExistingNew', align:'center', width: 70},
					{name:'trashRequestProductCategory', index:'trashRequestProductCategory', align:'center', width: 90},
					{name:'trashDeliveryMethod', index:'trashDeliveryMethod', align:'center', width: 60},
					{name:'trashNote', index:'trashNote', align:'center', width: 600},
					{name:'trashUser', index:'trashUser', align:'center', width: 80},
					{name:'trashTime', index:'trashTime', align:'center', width: 80},
				],
				jsonReader : {
		        	id: 'trashKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'trashKeyNum', 		// 기본 정렬 
		        sortorder: 'desc',			// 정렬 방식
		        
		        multiselect: true,			// 체크박스를 이용한 다중선택
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: true,				// 컬럼을 마우스 순서 변경
		        height : '670',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: false,			// 컬럼 폭 고정값 유지
		        altRows: false,				// 라인 강조
			}); 
			loadColumns('#list','trashList');
 		});
		
		$(window).on('resize.list', function () {
		    jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
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
                                          <h5 class="m-b-10">휴지통</h5>
                                          <p class="m-b-0">Trash Storage</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">휴지통</a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                          </div>
                      </div>
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
		                           	<table style="width:99%;">
										<tbody><tr>
											<td style="padding:0px 0px 0px 0px;" class="box">
												<table style="width:100%">
												<tbody><tr>
													<td style="font-weight:bold;">휴지통 관리 :
														<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'trashList');">컬럼 선택</button>
													</td>
												</tr>
												<tr>
													<td class="border1" colspan="2">
														<!------- Grid ------->
														<div class="jqGrid_wrapper">
															<table id="list"></table>
															<div id="pager"></div>
														</div>
														<!------- Grid ------->
													</td>
												</tr>
												</tbody>
											</table>
										</td>
									</tbody>
								</table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>

</html>