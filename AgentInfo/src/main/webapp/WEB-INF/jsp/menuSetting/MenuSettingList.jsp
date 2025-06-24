<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
		<script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
	    	$(function() {
	    		$.cookie('name','menuSetting');
	    	});
    	</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#mainList").jqGrid({
					url: "<c:url value='/menuSetting/main'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','순서','타이틀'],
					colModel:[
						{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 40, hidden:true },
						{name:'menuSort', index:'menuSort', align:'center', width: 150, formatter: mainLinkFormatter},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 300},
					],
					jsonReader : {
			        	id: 'menuSort',
			        	repeatitems: false
			        },
			        pager: '#mainPager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'menuSort', 		// 기본 정렬 
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
	 		});
			
			$(window).on('resize.list', function () {
			    jQuery("#subList").jqGrid( 'setGridWidth', $(".menuSettingDiv").width() );
				jQuery("#itemList").jqGrid( 'setGridWidth', $(".menuSettingDiv").width() );
				jQuery("#mainList").jqGrid( 'setGridWidth', $(".menuSettingDiv").width() );
			});
			
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#subList").jqGrid({
					url: "<c:url value='/menuSetting/sub'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','순서','타이틀'],
					colModel:[
						{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 40, hidden:true },
						{name:'menuSort', index:'menuSort', align:'center', width: 150, formatter: subLinkFormatter},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 300},
					],
					jsonReader : {
			        	id: 'menuSort',
			        	repeatitems: false
			        },
			        pager: '#subPager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'menuSort', 		// 기본 정렬 
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
	 		});

			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#itemList").jqGrid({
					url: "<c:url value='/itemSetting'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','순서','컬럼명','타입'],
					colModel:[
						{name:'menuKeyNum', index:'menuKeyNum', align:'center', width: 40, hidden:true },
						{name:'menuSort', index:'menuSort', align:'center', width: 100, formatter: itemLinkFormatter},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 160},
						{name:'menuTitle', index:'menuTitle', align:'center', width: 170},
					],
					jsonReader : {
			        	id: 'menuSort',
			        	repeatitems: false
			        },
			        pager: '#itemPager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'menuSort', 		// 기본 정렬 
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
								                <h5 class="m-b-10">메뉴 설정</h5>
								                <p class="m-b-0">Menu Setting</span>
								            </div>
								        </div>
								        <div class="col-md-4">
								            <ul class="breadcrumb-title">
								                <li class="breadcrumb-item">
								                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
								                </li>
								                <li class="breadcrumb-item"><a href="#!">메뉴 설정</a>
								                </li>
								            </ul>
								        </div>
								    </div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
			                           	<table style="width:100vw;">
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<div style="float: left;">
															<span class="menuSettingTitle">대메뉴</span>
															<div class="menuSettingDiv">
																<table style="width: 25vw;">
																	<tbody>
																		<tr>
																			<td style="font-weight:bold;">
																				<button class="btn btn-outline-info-add myBtn" id="BtnMainInsert">추가</button>
																				<button class="btn btn-outline-info-nomal myBtn" id="BtnMainUpdate">수정</button>
																				<button class="btn btn-outline-info-del myBtn" id="BtnMainDelect">삭제</button>
																			</td>
																		</tr>
																		<tr>
																			<td class="border1" colspan="2">
																				<!------- Grid ------->
																				<div class="jqGrid_wrapper">
																					<table id="mainList"></table>
																					<div id="mainPager"></div>
																				</div>
																				<!------- Grid ------->
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div style="float: left; padding-left: 1.5vw;">
															<span class="menuSettingTitle">중메뉴</span>
															<div class="menuSettingDiv">
																<table style="width:25vw;">
																	<tbody>
																		<tr>
																			<td style="font-weight:bold;">
																				<button class="btn btn-outline-info-add myBtn" id="BtnSubInsert">추가</button>
																				<button class="btn btn-outline-info-nomal myBtn" id="BtnSubUpdate">수정</button>
																				<button class="btn btn-outline-info-del myBtn" id="BtnSubDelect">삭제</button>
																			</td>
																		</tr>
																		<tr>
																			<td class="border1" colspan="2">
																				<!------- Grid ------->
																				<div class="jqGrid_wrapper">
																					<table id="subList"></table>
																					<div id="subPager"></div>
																				</div>
																				<!------- Grid ------->
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
														<div style="float: left; padding-left: 1.5vw;">
															<span class="menuSettingTitle">아이템</span>
															<div class="menuSettingDiv">
																<table style="width:25vw;">
																	<tbody>
																		<tr>
																			<td style="font-weight:bold;">
																				<button class="btn btn-outline-info-add myBtn" id="BtnItemInsert">추가</button>
																				<button class="btn btn-outline-info-nomal myBtn" id="BtnItemUpdate">수정</button>
																				<button class="btn btn-outline-info-del myBtn" id="BtnItemDelect">삭제</button>
																			</td>
																		</tr>
																		<tr>
																			<td class="border1" colspan="2">
																				<!------- Grid ------->
																				<div class="jqGrid_wrapper">
																					<table id="itemList"></table>
																					<div id="itemPager"></div>
																				</div>
																				<!------- Grid ------->
																			</td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</td>
												</tr>
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
	<script>
		function mainLinkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function subLinkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}

		function itemLinkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
	</script>
	<style>
		.menuSettingDiv {
			width:27vw; 
			float: left; 
			background: white; 
			padding: 1vw;
			border-top: 1px solid #cccccc;
		}

		.menuSettingTitle {
			display: block;
    		font-size: 14px;
    		margin-bottom: 5px;
    		color: black;
    		font-family: none;
    		font-weight: 400;
		}
	</style>
</html>