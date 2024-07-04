<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	/* $.cookie('name','issueWrite'); */
		    	$.cookie('name','issueList');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/issueHistory'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','고객사','Title','전달일자','TOSMS','TOSRF','PORTAL','JAVA','WAS','갯수','PDF'],
					colModel:[
						{name:'issueHistoryKeyNum', index:'issueHistoryKeyNum', align:'center', width: 35, hidden:true },
						{name:'issueHistoryCustomer', index:'issueHistoryCustomer', align:'center', width: 200},
						{name:'issueHistoryTitle', index:'issueHistoryTitle', align:'center', width: 240},
						{name:'issueHistoryDate', index:'issueHistoryDate', align:'center', width: 80},
						{name:'issueHistoryTosms', index:'issueHistoryTosms', align:'center', width: 150},
						{name:'issueHistoryTosrf', index:'issueHistoryTosrf',align:'center', width: 150},
						{name:'issueHistoryPortal', index:'issueHistoryPortal',align:'center', width: 150},
						{name:'issueHistoryJava', index:'issueHistoryJava', align:'center', width: 150},
						{name:'issueHistoryWas', index:'issueHistoryWas', align:'center', width: 150},
						{name:'issueHistoryTotal', index:'issueHistoryTotal', align:'center', width: 170},
						{name:'issueHistoryPdf', index:'issueHistoryPdf', align:'center', width: 70, formatter: issueHistoryFormatter, sortable:false}
					],
					jsonReader : {
			        	id: 'issueHistoryKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'issueHistoryKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        //multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : 'auto',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
			});
			
			$(window).on('resize.list', function () {
			    jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
			});
		</script>
		<style>
			table {
			  width: 100%;
			  border-top: 1px solid #444444;
			  border-collapse: collapse;
			}
			th, td {
			  border-bottom: 1px solid #444444;
			  border-left: 1px solid #444444;
			  padding: 3px;
			}
			th:first-child, td:first-child {
			  border-left: none;
			}
			
			.ui-jqgrid-htable > thead > tr > th {
				border-bottom: 1px solid burlywood;
    			border-left: none !important;
     			border-right: none !important;
			}
			#list > tbody > tr > td {
				border-bottom: 1px solid burlywood;
    			border-left: none;
    			border-right: none;
			}
			
		</style>
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
									            <h5 class="m-b-10">이슈 조회</h5>
									            <p class="m-b-0">Issue Write</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">이슈 조회</a>
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
	                                		<form id="form" name="form" method ="post">
		                                		<div class="searchbos" style="margin-bottom:20px">
		                                			<div class="col-lg-5">
		                                				<label class="labelFontSize marginBottom2">고객사</label><label class="colorRed">*</label><span class="colorRed" id="NotIssueCustomer" style="display: none; line-height: initial;">고객사 필수 입력 바랍니다.</span>
		                                				<input class="form-control" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사명' value="${issueTitle.issueCustomer}">
		                                			</div>
		                                			<div class="col-lg-5">
		                                				<label class="labelFontSize marginBottom2">Title</label>
		                                				<input class="form-control" type="text" id="issueTitle" name="issueTitle" placeholder='Title' value="${issueTitle.issueTitle}">
		                                			</div>
													<div class="col-lg-5">
		                                				<label class="labelFontSize marginBottom2">Target</label>
														<select class="form-control selectpicker" id="issueTarget" name="issueTarget" data-live-search="true" data-size="5" data-actions-box="true">
															<option value="TOSMS" <c:if test="${'TOSMS' eq issueTitle.issueTarget}">selected</c:if>>TOSMS</option>
															<option value="Agent" <c:if test="${'Agent' eq issueTitle.issueTarget}">selected</c:if>>Agent</option>
														</select>
		                                			</div>
		                                			<div class="col-lg-5">
		                                				<label class="labelFontSize marginBottom2">전달일자</label>
		                                				<input class="form-control" type="date" id="issueDate" name="issueDate" value="${issueTitle.issueDate}" max="9999-12-31">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize marginBottom2">TOSMS</label>
		                                				<input class="form-control" type="text" id="issueTosms" name="issueTosms" placeholder='TOSMS' value="${issueTitle.issueTosms}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize marginBottom2">TOSRF</label>
		                                				<input class="form-control" type="text" id="issueTosrf" name="issueTosrf" placeholder='TOSRF' value="${issueTitle.issueTosrf}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize marginBottom2">PORTAL</label>
		                                				<input class="form-control" type="text" id="issuePortal" name="issuePortal" placeholder='PORTAL' value="${issueTitle.issuePortal}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize marginBottom2">JAVA</label>
		                                				<input class="form-control" type="text" id="issueJava" name="issueJava" placeholder='JAVA' value="${issueTitle.issueJava}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize marginBottom2">WAS</label>
		                                				<input class="form-control" type="text" id="issueWas" name="issueWas" placeholder='WAS' value="${issueTitle.issueWas}">
		                                			</div>
		                                		</div>
		                                		<!------- Grid ------->
												<div class="jqGrid_wrapper" style="margin-bottom: 30px;">
													<table id="list"></table>
												</div>
												<!------- Grid ------->
		                                		<div style='text-align:left; float:left; margin-bottom:5px;'>
		                                			<span style="font-weight:bold;">보기 :</span> 
		                                			
		                                			<input class="cssCheck" type="checkbox" id="ChkTotal">
    												<label for="ChkTotal"></label><span class="margin17">전체</span>
		                                			<input class="cssCheck" type="checkbox" id="ChkSolution" name="chkSelectBox" value="해결">
    												<label for="ChkSolution"></label><span class="margin17">해결</span>
    												<input class="cssCheck" type="checkbox" id="ChkUnresolved" name="chkSelectBox" value="미해결">
    												<label for="ChkUnresolved"></label><span class="margin17">미해결</span>
    												<input class="cssCheck" type="checkbox" id="ChkHold" name="chkSelectBox" value="보류">
    												<label for="ChkHold"></label><span class="margin17">보류</span>
    												
		                                			<div id="downloadBtn" style="margin-top: 10px;">
			                                			<span style="font-weight:bold;">다운 :</span> 
			                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnPdf" style="font-size:11px">PDF Download</button>
														<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnURL" style="font-size:11px">URL Export</button>
			                                			<button type="button" class="btn btn-outline-info-del myBtn" id="BtnHistoryInsert" style="font-size:11px">히스토리 추가</button>
														<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnAuthority" style="font-size:11px">권한 가져오기</button>
			                                		</div>
		                                		</div> 
		                                		<div style='text-align:right;'>
					                              	Total:<label class="labelFontSize15" id="total">${issueTitle.total}</label>해결:<label class="labelFontSize15" id="solution">${issueTitle.solution}</label>미해결:<label class="labelFontSize15" id="unresolved">${issueTitle.unresolved}</label>보류<label class="labelFontSize15" id="hold">${issueTitle.hold}</label>
					                            </div>
		                                		<div class="searchbos issueStyle">
			                                		<div class="plus">
			                                			<div><div><div id="blank"></div></div></div>
			                                			<c:forEach var="list" items="${issue}">
					                                		<div class="issue" data-keynum="${list.issuePrimaryKeyNum}">
					                                			<div>
					                                				<div style='text-align:left; float:left; margin-bottom: 5px;'><input class="form-control" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" placeholder='구분' value="${list.issueDivision}"></div>
					                                			</div>
						                                		<table style="width:100%">
						                                			<tbody>
						                                				<tr>
						                                					<td class="alignCenter" style="width: 9%;">OS</td>
						                                					<c:choose>
							                                					<c:when test="${viewType eq 'insert'}">
								                                					<td><select class="form-control selectpicker selectForm" id="issueOsList" name="issueOsList" data-live-search="true" data-size="5">
																	                	<option value="Linux">Linux</option>
																						<option value="Windows">Windows</option>
																						<option value="AIX">AIX</option>
																						<option value="HP-UX">HP-UX</option>
																						<option value="Solaris">Solaris</option>
																					</select></td>
																					<td class="alignCenter">작성자</td>
								                                					<td>
								                                						<input  class="form-control" type="text" id="issueWriterList" name="issueWriterList" value="${issueWriter}" readonly>
																	                </td>
																				</c:when>
																				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
																					<td><select class="form-control selectpicker selectForm" id="issueOsList" name="issueOsList" data-live-search="true" data-size="5">
																						<option value="Linux" <c:if test="${list.issueOs eq 'Linux'}">selected</c:if>>Linux</option>
																				    	<option value="Windows" <c:if test="${list.issueOs eq 'Windows'}">selected</c:if>>Windows</option>
																				    	<option value="AIX" <c:if test="${list.issueOs eq 'AIX'}">selected</c:if>>AIX</option>
																				    	<option value="HP-UX" <c:if test="${list.issueOs eq 'HP-UX'}">selected</c:if>>HP-UX</option>
																				    	<option value="Solaris" <c:if test="${list.issueOs eq 'Solaris'}">selected</c:if>>Solaris</option>
																				    </select></td>
																				    <td class="alignCenter">작성자</td>
								                                					<td>
								                                						<input  class="form-control" type="text" id="issueWriterList" name="issueWriterList" value="${list.issueWriter}" readonly>
																	                </td>
																				</c:when>
																			</c:choose>
						                                				</tr>
						                                				<tr>
						                                					<td class="alignCenter">대항목</td>
						                                					<td><input class="form-control" type="text" id="issueAwardList" name="issueAwardList" placeholder='대항목' value="${list.issueAward}"></td>
						                                					<td class="alignCenter">중학목</td>
						                                					<td><input class="form-control" type="text" id="issueMiddleList" name="issueMiddleList" placeholder='중항목' value="${list.issueMiddle}"></td>
						                                				</tr>
						                                				<tr>
						                                					<td class="alignCenter">소항목1</td>
						                                					<td><input class="form-control" type="text" id="issueUnder1List" name="issueUnder1List" placeholder='소항목1' value="${list.issueUnder1}"></td>
						                                					<td class="alignCenter">소항목2</td>
						                                					<td><input class="form-control" type="text" id="issueUnder2List" name="issueUnder2List" placeholder='소항목2' value="${list.issueUnder2}"></td>
						                                				</tr>
						                                				<tr>
						                                					<td class="alignCenter">소항목3</td>
						                                					<td><input class="form-control" type="text" id="issueUnder3List" name="issueUnder3List" placeholder='소항목3' value="${list.issueUnder3}"></td>
						                                					<td class="alignCenter">소항목4</td>
						                                					<td><input class="form-control" type="text" id="issueUnder4List" name="issueUnder4List" placeholder='소항목4' value="${list.issueUnder4}"></td>
						                                				</tr>
						                                				<tr>
						                                					<td class="alignCenter">결함번호</td>
						                                					<td><input class="form-control" type="text" id="issueFlawNumList" name="issueFlawNumList" placeholder='결합번호' value="${list.issueFlawNum}"></td>
						                                					<td class="alignCenter">영향도</td>
						                                					<c:choose>
							                                					<c:when test="${viewType eq 'insert'}">
								                                					<td><select class="form-control selectpicker selectForm" id="issueEffectList" name="issueEffectList" data-live-search="true" data-size="5">
																	                	<option value="상">상</option>
																						<option value="중">중</option>
																						<option value="하">하</option>
																					</select></td>
																				</c:when>
																				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
																					<td><select class="form-control selectpicker selectForm" id="issueEffectList" name="issueEffectList" data-live-search="true" data-size="5">
																						<option value="상" <c:if test="${list.issueEffect eq '상'}">selected</c:if>>상</option>
																				    	<option value="중" <c:if test="${list.issueEffect eq '중'}">selected</c:if>>중</option>
																				    	<option value="하" <c:if test="${list.issueEffect eq '하'}">selected</c:if>>하</option>
																				    </select></td>
																				</c:when>
																			</c:choose>
						                                				</tr>
						                                				<tr>
						                                					<td class="alignCenter">테스트 결과</td>
						                                					<c:choose>
							                                					<c:when test="${viewType eq 'insert'}">
								                                					<td><select class="form-control selectpicker selectForm" id="issueTextResultList" name="issueTextResultList" data-live-search="true" data-size="5">
																	                	<option value="오류">오류</option>
																						<option value="개선사항">개선사항</option>
																					</select></td>
																				</c:when>
																				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
																					<td><select class="form-control selectpicker selectForm" id="issueTextResultList" name="issueTextResultList" data-live-search="true" data-size="5">
																						<option value="오류" <c:if test="${list.issueTextResult eq '오류'}">selected</c:if>>오류</option>
																				    	<option value="개선사항" <c:if test="${list.issueTextResult eq '개선사항'}">selected</c:if>>개선사항</option>
																				    </select></td>
																				</c:when>
																			</c:choose>
						                                					<td class="alignCenter">적용여부</td>
						                                					<c:choose>
							                                					<c:when test="${viewType eq 'insert'}">
								                                					<td><select class="form-control selectpicker selectForm" id="issueApplyYnList" name="issueApplyYnList" data-live-search="true" data-size="5">
																	                	<option value="미해결">미해결</option>
																						<option value="해결">해결</option>
																						<option value="보류">보류</option>
																					</select></td>
																				</c:when>
																				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
																					<td><select class="form-control selectpicker selectForm" id="issueApplyYnList" name="issueApplyYnList" data-live-search="true" data-size="5">
																						<option value="미해결" <c:if test="${list.issueApplyYn eq '미해결'}">selected</c:if>>미해결</option>
																				    	<option value="해결" <c:if test="${list.issueApplyYn eq '해결'}">selected</c:if>>해결</option>
																				    	<option value="보류" <c:if test="${list.issueApplyYn eq '보류'}">selected</c:if>>보류</option>
																				    </select></td>
																				</c:when>
																			</c:choose>
						                                				</tr>
						                                				<tr>
																			<td class="alignCenter">확인내용</td>
						                                					<td colspan='3'><input class="form-control" type="text" id="issueConfirmList" name="issueConfirmList" placeholder='확인 내용' value="${list.issueConfirm}"></td>
						                                				</tr>
																		<tr>
																			<td class="alignCenter">장애내용</td>
						                                					<td colspan='3' style="max-width: 890px;"><textarea class="summerNoteSize" rows="5" id="issueObstacleList" name="issueObstacleList" onkeydown="resize(this)" onkeyup="resize(this)">${list.issueObstacle}</textarea></td>
						                                				</tr>
						                                				<tr>
																			<td class="alignCenter">비고</td>
						                                					<td colspan='3'><textarea class="form-control" id="issueNoteList" name="issueNoteList" cols="30" onkeydown="resize(this)" onkeyup="resize(this)" placeholder='비고'>${list.issueNote}</textarea></td>
						                                				</tr>
						                                			</tbody>
						                                		</table>
																<input class="form-control" type="hidden" id="issuePrimaryKeyNumList" name="issuePrimaryKeyNumList" value="${list.issuePrimaryKeyNum}">
																<table style="border-top: none;">
																	<c:forEach var="issueRelay" items="${issueRelayList}">
																		<c:if test="${issueRelay.issuePrimaryKeyNum eq list.issuePrimaryKeyNum}">
																			<tr style="height: 50px;">
																				<td class="alignCenter" style="width: 9%;">${issueRelay.issueRelayType}</td>
																				<c:if test="${issueRelay.issueRelayType eq '개발'}">
																					<td class="statusTd">${issueRelay.issueRelayStatus}</td>
																				</c:if>
																				<c:if test="${issueRelay.issueRelayType ne '개발'}">
																					<td style="width:70px"></td>
																				</c:if>
																				<td style="background-color: white;" id="detail_${issueRelay.issueRelayKeyNum}">
																					${issueRelay.issueRelayDetail}
																				</td>
																				<td style="width: 100px; background: white; border-left: none; text-align: right;">
																					<span>${issueRelay.issueRelayDate}</span>
																					<c:if test="${issueRelay.issueRelayType eq 'QA'}">
																						<button type="button" class="btn btn-outline-info-nomal myBtn" onClick="btnUpdateQA('${issueRelay.issueRelayKeyNum}','${issueRelay.issuePrimaryKeyNum}')">수정</button>
																						<button type="button" class="btn btn-outline-info-del myBtn" onClick="btnDeleteQA('${issueRelay.issueRelayKeyNum}','${issueRelay.issuePrimaryKeyNum}')">삭제</button>
																					</c:if>
																				</td>
																			</tr>
																		</c:if>
																	</c:forEach>
																</table>
																<div style="width: 100%; text-align: right;	padding: 1%;">
																	<button type="button" class="btn btn-outline-info-add myBtn" onclick="btnRelayQA('${list.issuePrimaryKeyNum}','${list.issueKeyNum}')">답변달기</button>
																</div>
					                                		</div>
				                                		</c:forEach>
				                                	</div>
			                                		
		                                		</div>
												<input class="form-control" type="hidden" id="issueKeyNum" name="issueKeyNum" value="${issueTitle.issueKeyNum}">
		                                		<input class="form-control" type="hidden" id="issueObstacleList" name="issueObstacleList" value=""><!-- 단일 이미지 첨부일 경우 배열이 여러개로 분리되어 복합으로 전달하기 위해 추가  -->
		                                		<input class="form-control" type="hidden" id="issueBtnType" name="issueBtnType" value="${viewType}">
	                                		</form>

		    	                 		</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
		<div class="fixed-div" id="fixedDiv">
			<div style="text-align: right;">
				<a onclick="fixedClose();">x</a>
			</div>
			<% int num = 1; %>
			<c:forEach var="list" items="${issue}">
				<c:if test="${list.issueApplyYn eq '미해결' || list.issueApplyYn eq '보류'}">
					<a onClick="moveScroll('${list.issuePrimaryKeyNum}');">
						<c:if test="${fn:contains(issuePrimaryKeyNumList, list.issuePrimaryKeyNum)}">
							<img class="reply" src="/AgentInfo/images/reply.png">
						</c:if>
						<c:if test="${!fn:contains(issuePrimaryKeyNumList, list.issuePrimaryKeyNum)}">
							<div style="width: 16%;	height: 15px; float: left;"></div>
						</c:if>
						<c:if test="${fn:contains(alarmIndex, list.issuePrimaryKeyNum)}">
							<p class="text" style="color: green;">
								<%= num++ %>. ${list.issueDivision} <c:if test="${list.issueDivision eq '' || list.issueDivision eq null}">미입력</c:if>
							</p>
						</c:if>
						<c:if test="${!fn:contains(alarmIndex, list.issuePrimaryKeyNum)}">
							<p class="text">
								<%= num++ %>. ${list.issueDivision} <c:if test="${list.issueDivision eq '' || list.issueDivision eq null}">미입력</c:if>
							</p>
						</c:if>
					</a>
				</c:if>
			</c:forEach>
		</div>
		<button id="showFixedDiv">■</button>
	</body>

	<script>
		$(function() {
			Swal.fire({
				icon: 'info',
				title: '읽기 모드',
				text: '[${connecter}]님이 해당 이슈를 수정 중이므로 읽기 권한으로 접속하였습니다.',
			});
		});

		/* =========== 전달일자 오늘 날짜 입력 ========= */
		// document.getElementById('issueDate').value = new Date().toISOString().substring(0, 10);
		
		/* =========== 최초 1회 실행 ========= */
		$(function() {
			summernote();
			issueCount();
		});
		
		/* =========== SummerNote 설정 ========= */
		function summernote() {
			$('.summerNoteSize').summernote({
				minHeight:250,
				placeholder:"장애내용",
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
		}

		function btnRelayQA(issuePrimaryKeyNum, issueKeyNum) {
	  		$.ajax({
			    type: 'POST',
			    url: "<c:url value='/issueRelay/relayModal'/>",
				data: {
					"issuePrimaryKeyNum": issuePrimaryKeyNum,
					"issueKeyNum": issueKeyNum,
					"issueRelayType": "QA"
				},
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'issueRelayModal'); //modal창 호출
			    },
			    error: function(e) {
			        console.log(e);
			    }
			});	
	  	}	
		
		
		/* =========== Select 박스 변경시 ========= */
		$("select").change(function() {
			issueCount();
		});
		
		
		/* ===========Count 변경 ========= */
		function issueCount() {
			$('#total').text($('.issue').length);
			var list = new Array();
			$('select[name=issueApplyYnList]').each(function(index, item) {
				list.push($(item).val());
			});
			
			const result = list.reduce((accu, curr) => { 
					accu[curr] = (accu[curr] || 0)+1; // 객체에서 curr key값을 찾아 value값이 있으면 그 value에서 1을 더하고, 없다면 0을 할당하고 거기에 1을 더해준다. 
					return accu;
				}, {});
			$('#solution').text(0);
			$('#unresolved').text(0);
			$('#hold').text(0);
			
			$('#solution').text(result.해결);
			$('#unresolved').text(result.미해결);
			$('#hold').text(result.보류);
		}
		
		/* =========== 체크박스 체크된 상태로 시작 ========= */
		$(function() {
			$("input:checkbox[id='ChkTotal']").prop("checked",  true);
			$("input:checkbox[id='ChkSolution']").prop("checked",  true);
			$("input:checkbox[id='ChkUnresolved']").prop("checked", true);
			$("input:checkbox[id='ChkHold']").prop("checked", true);
			setTimeout(function() {
				$("#ChkSolution").click();
			}, 500);
		});

		/* =========== Total 체크박스 ========= */
		$("#ChkTotal").change(function(){
			if($("#ChkTotal").is(":checked")){
				$("input:checkbox[id='ChkSolution']").prop("checked", true);
				$("input:checkbox[id='ChkUnresolved']").prop("checked", true);
				$("input:checkbox[id='ChkHold']").prop("checked", true);
				$('select[name=issueApplyYnList]').each(function(index, item) {
					$(item).parent().parent().parent().parent().parent().parent().show();
				});
			}else{
				$("input:checkbox[id='ChkSolution']").prop("checked", false);
				$("input:checkbox[id='ChkUnresolved']").prop("checked", false);
				$("input:checkbox[id='ChkHold']").prop("checked", false);
				$('select[name=issueApplyYnList]').each(function(index, item) {
					$(item).parent().parent().parent().parent().parent().parent().hide();
				});
			}
		});
		 
		/* =========== 해결 보기 ========= */
		$("#ChkSolution").change(function(){
			selectChkView("ChkSolution","해결");
		});
		
		/* =========== 미해결 보기 ========= */
		$("#ChkUnresolved").change(function(){
			selectChkView("ChkUnresolved","미해결");
		});
		
		/* =========== 보류 보기 ========= */
		$("#ChkHold").change(function(){
			selectChkView("ChkHold","보류");
		});
		
		/* =========== 해결, 미해결, 보류 보기/숨기기 기능 ========= */
		function selectChkView(id, data) {
			if($("#"+id).is(":checked")){
				$('select[name=issueApplyYnList]').each(function(index, item) {
					var value = $(item).val();
					if(value == data) {
						$(item).parent().parent().parent().parent().parent().parent().show();
					}
				});
				if(document.getElementById("ChkHold").checked && document.getElementById("ChkUnresolved").checked && document.getElementById("ChkSolution").checked) {
					$("input:checkbox[id='ChkTotal']").prop("checked", true);
				}
			}else{
				$("input:checkbox[id='ChkTotal']").prop("checked", false);
				$('select[name=issueApplyYnList]').each(function(index, item) {
					var value = $(item).val();
					if(value == data) {
						$(item).parent().parent().parent().parent().parent().parent().hide();
					}
				});
			}
		}
		
		
		/* =========== TextArea 범위 초과시 크기 증가 ========= */
		function resize(obj) {
			obj.style.height = "1px";
			obj.style.height = (17+obj.scrollHeight)+"px";
		}
		
		
		/* =========== PDF 서버 PC 다운로드  ========= */
		$('#BtnPdf').click(function() {
			var frmData = document.form;
			var url = "<c:url value='/issue/pdfView'/>";
			window.open("", "form", "height=1000,width=1000,scrollbars=yes,status=yes,toolbar=no,location=yes,directories=yes,resizable=no,menubar=no");
			frmData.action = url; 
			frmData.method="post";
			frmData.target="form";
			frmData.submit();
		});

		/* =========== URL 생성  ========= */
		$('#BtnURL').click(function() {
			var issueKeyNum = $('#issueKeyNum').val();
			var issueCustomer = $('#issueCustomer').val();
			var issueTitle = $('#issueTitle').val();

			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/issueRelay/urlExport'/>",
		        data: {
					"issueKeyNum" : issueKeyNum,
					"issueCustomer" : issueCustomer,
					"issueTitle" : issueTitle
				},
		        async: false,
		        success: function (data) {
		        	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
		            $.modal(data, 'issueRelayUrl'); //modal창 호출
		        },
		        error: function(e) {
		            // TODO 에러 화면
		        }
		    });
		});

		$('#BtnAuthority').click(function() {
			Swal.fire({
    		title: '수정 권한 가져오기!',
    		html: "<span style='font-size: 17px;'>${connecter}님이 저장하지 않은 데이터가 <span style='color:red'>유실</span>될 수 있습니다.</span> <br>권한을 가져오시겠습니까?",
    		icon: 'warning',
    		showCancelButton: true,
    		confirmButtonColor: '#7066e0',
    		cancelButtonColor: '#FF99AB',
    		confirmButtonText: 'OK'
			}).then((result) => {
				if(result.isConfirmed) {
		    		var issueKeyNum = $('#issueKeyNum').val();
		    		$.ajax({
		    		    url: "<c:url value='/issue/leaveAndRedirectToList'/>",
		    		    data: {"issueKeyNum": issueKeyNum},
		    		    type: 'GET',
		    		    success: function() {
		    		        location.reload();
		    		    },
		    		    error: function(xhr, status, error) {
		    		        // 요청이 실패한 경우 수행할 작업
		    		    }
		    		});
				}
			})
		});


		

		
		/* =========== PDF History 로컬 PC 삭제 ========= */
		function fileDeleteHistory(fileName) {
			$.ajax({
				url: "<c:url value='/issueHistory/fileDelete'/>",
				type: "POST",
				data: {
						"fileName": fileName,
					},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '히스토리가 정상적으로 삭제되었습니다.'
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: 'PDF파일 또는 데이터가 존재하지 않습니다.',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			  });
		}
		
		/* =========== 이슈 히스토리 포멧털 ========= */
		function issueHistoryFormatter(value, options, row) {
			var issueHistoryPdf = row.issueHistoryPdf.toUpperCase();
			return '<button type="button" class="btn btn-outline-info-nomal myBtn" onClick="fileDownload(' + "'" + issueHistoryPdf + "'"  + ')">Download</button>';
		}

		
		/* =========== 이슈 히스토리 추가 ========= */
		$('#BtnHistoryInsert').click(function() {
			var frmData = document.form;
			var url = "<c:url value='/issue/pdfViewHistory'/>";
			window.open("", "form", "height=1000,width=1000,scrollbars=yes,status=yes,toolbar=no,location=yes,directories=yes,resizable=no,menubar=no");
			frmData.action = url; 
			frmData.method="post";
			frmData.target="form";
			frmData.submit();
		});

		/* =========== PDF 로컬 PC 다운로드(자식창에서 호출) ========= */
		function pdfDown(fileName) {
			window.location ="<c:url value='/issue/fileDownload?fileName="+fileName+"'/>";
			setTimeout(function() {
				fileDelete(fileName);
			},300);
		}
		
		/* =========== PDF 로컬 PC 다운로드 히스토리(자식창에서 호출) ========= */
		function pdfDownHistory(issueHistoryDate) {
			var postData = $('#form').serializeArray();
			postData.push({name : "issueHistoryDate", value : issueHistoryDate});
			postData.push({name : "total", value : $('#total').text()});
			postData.push({name : "solution", value : $('#solution').text()});
			postData.push({name : "unresolved", value : $('#unresolved').text()});
			postData.push({name : "hold", value : $('#hold').text()});
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/issueHistory/issueHistoryInsert'/>",
	            data: postData,
	            async: false,
	            success: function (data) {
	            	if(data.result == "OK") {
		            	Swal.fire(
						  '처리완료!',
						  '처리 완료하였습니다.',
						  'success'
						)
	            	} else {
	            		Swal.fire(
	  					  '실패!',
	  					  '처리 실패하였습니다.',
	  					  'error'
	  					)
	            	}
	            	tableRefresh();
	            },
	            error: function(e) {
	            	Swal.fire(
					  '에러!',
					  '에러가 발생하였습니다.',
					  'error'
					)
	            }
	        });
		}
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		function fileDownload(issueHistoryPdf) {
			window.location ="<c:url value='/issueHistory/fileDownload?fileName="+issueHistoryPdf+"'/>";
		}
		

		function btnUpdateQA(issueRelayKeyNum, issuePrimaryKeyNum) {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/issueRelay/relayUpdateModal'/>",
				data: {
					"issueRelayKeyNum": issueRelayKeyNum,
					"issuePrimaryKeyNum": issuePrimaryKeyNum
				},
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'issueRelayModal'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});
		}

		function btnDeleteQA(issueRelayKeyNum, issuePrimaryKeyNum) {
			Swal.fire({
				  title: '삭제!',
				  text: "답글을 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
					url: "<c:url value='/issueRelay/delete'/>",
					type: "POST",
					data: {
						"issueRelayKeyNum": issueRelayKeyNum,
						"issuePrimaryKeyNum": issuePrimaryKeyNum
					},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						if(data == "OK") {
							Swal.fire(
							  '성공!',
							  '삭제 완료하였습니다.',
							  'success'
							).then((result) => {
								if (result.isConfirmed) {
	            					location.reload();
								}
							})
						} else {
							Swal.fire(
							  '실패!',
							  '삭제 실패하였습니다.',
							  'error'
							).then((result) => {
								if (result.isConfirmed) {
	            					location.reload();
								}
							})
						}
						
					},
					error: function(error) {
						console.log(error);
					}
				  });
			  	}
			})
			
		}

		$(document).ready(function() {
            $(window).on('beforeunload', function(){
                $.ajax({
    			    url: "<c:url value='/issue/leaveView'/>",
    			    type: 'GET',
    			    success: function(response) {

    			    },
    			    error: function(xhr, status, error) {
    			        // 요청이 실패한 경우 수행할 작업
    			    }
    			});
            });

			var lastActivityTime = Date.now(); // 사용자의 마지막 활동 시간 초기화

			// 사용자의 활동 감지 이벤트 설정
			$(document).on('mousemove keydown', function() {
			    lastActivityTime = Date.now(); // 사용자의 활동이 감지되면 마지막 활동 시간 갱신
			});
			setInterval(function() {
			    var currentTime = Date.now();
    			var inactiveTime = currentTime - lastActivityTime; // 현재 시간과 마지막 활동 시간의 차이 계산

    			// 만약 사용자가 일정 시간 동안 활동이 없으면 AJAX 요청을 보냄
    			if (inactiveTime >= 600000) { // 여기서 60000은 10분을 밀리초로 나타낸 값입니다.
    			    $.ajax({
    			        url: "<c:url value='/issue/checkUserStatus'/>",
    			        type: 'GET',
    			        success: function(response) {
						
    			        },
    			        error: function(xhr, status, error) {
    			            // 요청이 실패한 경우 수행할 작업
    			        }
    			    });
    			}
			}, 600000); // 10분마다 사용자의 상태를 확인
        });

		$(document).ready(function() {
	    	$('.text').each(function() {
    		    var maxLength = 11;
					
    		    var text = $(this).text().trim();
				var textLength = 8;

        		for (var i = 0; i < text.length; i++) {
        		    var charCode = text.charCodeAt(i);
				
        		    if ((charCode >= 0xAC00 && charCode <= 0xD7AF) || (charCode >= 0x3131 && charCode <= 0x318E)) {

        		    } else {
						if(textLength < 11)
							textLength += 1;
        		    }
        		}

        		if (text.length > textLength) {
        		    var truncatedText = text.slice(0, textLength) + '...';
        		    $(this).text(truncatedText);
        

					$(this).mouseenter(function() {
            		    $(this).text(text);
            		});
				

            		$(this).mouseleave(function() {
            		    $(this).text(truncatedText);
            		});
    		    }
    		});
		});

		function moveScroll(keyNum) {
		    var target = document.querySelector('.issue[data-keynum="' + keyNum + '"]');
			if(target.style.display != "none") {
		    	if (target) {
		    	    var targetPosition = target.getBoundingClientRect().top;
        			var newPosition = targetPosition - 100; // 조금 더 위쪽으로 이동하려면 음수 값을 사용합니다.

        			window.scrollBy({
        			    top: newPosition,
        			    behavior: 'smooth'
        			});
		    	}
			}
		}

		$(document).ready(function() {
			var isDragging = false;
            var valueX, valueY;
			var startX, startY;
			var offsetX1, offsetX2;
			var offsetY1, offsetY2;

            $('#showFixedDiv').on('mousedown', function(event) {
                isDragging = true;
                startX = event.clientX - parseInt($('#showFixedDiv').css('left'));
                startY = event.clientY - parseInt($('#showFixedDiv').css('top'));
				offsetX1 = parseInt($('#showFixedDiv').css('left'));
                offsetY1 = parseInt($('#showFixedDiv').css('top'));
            });

            $(document).on('mousemove', function(event) {
                if (isDragging) {
                    var newX = event.clientX - startX;
                    var newY = event.clientY - startY;
					
					$('#showFixedDiv').css({ top: newY, left: newX });
                    $('#fixedDiv').css({ top: newY, left: newX-120 });
                }
            });

			$("#showFixedDiv").on('mouseup', function(event) {
				offsetX2 = parseInt($('#showFixedDiv').css('left'));
                offsetY2 = parseInt($('#showFixedDiv').css('top'));
				valueX = offsetX1-offsetX2;
				valueY = offsetY1-offsetY2;


				if (valueX == 0 && valueY == 0) {
                    	isDragging = false;
                	}
        	 
				if (!isDragging) {
					$('#showFixedDiv').fadeOut('fast', function() {
    				    $('#fixedDiv').fadeIn('fast');
    				});
				}
        	    isDragging = false;
        	});
		})


		$(document).ready(function() {
			var isDragging = false;
			var startX, startY;

			$('#fixedDiv').on('mousedown', function(event) {
				isDragging = true;
                startX = event.clientX - parseInt($('#fixedDiv').css('left'));
                startY = event.clientY - parseInt($('#fixedDiv').css('top'));
            });

            $(document).on('mousemove', function(event) {
				if (isDragging) {
                	var newX = event.clientX - startX;
                	var newY = event.clientY - startY;
					$('#fixedDiv').css({ top: newY, left: newX });
					$('#showFixedDiv').css({ top: newY, left: newX+120 });
				}
            });

			$("#fixedDiv").on('mouseup', function(event) {
				isDragging = false;
        	});
        });

		function fixedClose() {
			$('#fixedDiv').fadeOut('fast', function() {
    		    $('#showFixedDiv').fadeIn('fast');
    		});
		}

		$(document).on('issueRelayCompleteUpdate', function(event, data) {
			$('#detail_'+data.issueRelayKeyNum).html(data.issueRelayDetail);
		});
	</script>
	<style>
		.issueStyle {
			background: #f5e6d3bd;
    		font-weight: bold;
    		font-family: math;
		}

		.text {
			font-weight: bold;
		}
		.fixed-div {
		    position: fixed;
		    top: 50%;
		    right: 20px; /* 원하는 위치로 조정 가능 */
		    transform: translateY(-50%);
		    background-color: #f1f1f1;
		    padding: 10px 20px;
		    border-radius: 5px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
			max-width: 180px;
			background-color: lightpink;
    		color: #4d0505;
			box-shadow: 2px 3px 9px;
			width: 180px;
			max-height: 700px;
			overflow-y: scroll;
    		scrollbar-width: none;
			cursor: move;
			min-height: 100px;
		}

		#showFixedDiv {
			position: fixed; 
            bottom: 50%; 
            right: 20px; 
            width: 50px; 
            height: 50px; 
            border-radius: 50%; 
            background-color: lightpink; 
            color: white;
            border: none;
            cursor: move; /* 드래그 가능한 커서로 설정 */
            box-shadow: 2px 3px 9px black;
			display: none;
		}

		.text:hover {
			color: #cf0000;
			width:100%
		}

		.reply {
			width: 12%;
    		float: left;
    		margin-right: 5px;
		}

		.statusTd {
			width: 70px;
    		text-align: center;
    		background: #c19595;
    		color: white;
			font-weight: bold;
		}
	</style>
</html>