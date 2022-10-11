<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','issueWrite');
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
					colNames:['Key','고객사','Title','전달일자','TOSMS','TOSRF','PORTAL','JAVA','WAS','갯수','PDF','제거'],
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
						{name:'issueHistoryPdf', index:'issueHistoryPdf', align:'center', width: 70, formatter: issueHistoryFormatter, sortable:false},
						{name:'issueHistoryDelete', index:'issueHistoryDelete', align:'center', width: 50, formatter: minusFormatter, sortable:false},
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
									            <h5 class="m-b-10">이슈 작성</h5>
									            <p class="m-b-0">Issue Write</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">이슈 작성</a>
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
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize marginBottom2">고객사</label><label class="colorRed">*</label><span class="colorRed" id="NotIssueCustomer" style="display: none; line-height: initial;">고객사 필수 입력 바랍니다.</span>
		                                				<input class="form-control" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사명' value="${issueTitle.issueCustomer}">
		                                			</div>
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize marginBottom2">Title</label>
		                                				<input class="form-control" type="text" id="issueTitle" name="issueTitle" placeholder='Title' value="${issueTitle.issueTitle}">
		                                			</div>
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize marginBottom2">전달일자</label>
		                                				<input class="form-control" type="date" id="issueDate" name="issueDate" value="${issueTitle.issueDate}">
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
		                                			<input class="cssCheck" type="checkbox" id="ChkSolution">
    												<label for="ChkSolution"></label><span class="margin17">해결</span>
    												<input class="cssCheck" type="checkbox" id="ChkUnresolved">
    												<label for="ChkUnresolved"></label><span class="margin17">미해결</span>
    												<input class="cssCheck" type="checkbox" id="ChkHold">
    												<label for="ChkHold"></label><span class="margin17">보류</span>
    												
		                                			<div id="downloadBtn" style="margin-top: 10px;">
			                                			<span style="font-weight:bold;">다운 :</span> 
			                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnPdf" style="font-size:11px">PDF Download</button>
			                                			<!-- <button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnPpt">PPT Download</button> -->
			                                			<!-- <button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnWord">Word Download</button> -->
			                                			<button type="button" class="btn btn-outline-info-del myBtn" id="BtnHistoryInsert" style="font-size:11px">히스토리 추가</button>
			                                		</div>
		                                		</div> 
		                                		<div style='text-align:right;'>
					                              	Total:<label class="labelFontSize15" id="total">${issueTitle.total}</label>해결:<label class="labelFontSize15" id="solution">${issueTitle.solution}</label>미해결:<label class="labelFontSize15" id="unresolved">${issueTitle.unresolved}</label>보류<label class="labelFontSize15" id="hold">${issueTitle.hold}</label>
					                            </div>
		                                		<div class="searchbos">
			                                		<div class="plus">
			                                			<div><div><div id="blank"></div></div></div>
			                                			<c:forEach var="list" items="${issue}">
					                                		<div class="issue">
					                                			<div>
					                                				<div style='text-align:left; float:left; margin-bottom: 5px;'><input class="form-control" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" placeholder='구분' value="${list.issueDivision}"></div>
					                                				<div style='text-align:right; float:right;'> <a onclick='btnPlus(this)' id="btnPlus"><img  src="/AgentInfo/images/pluse.png" style="width:30px"></a></div>
					                                				<div style='text-align:right; float:right;'><a onclick='btnMinus(this)' id='btnMinus'><img  src='/AgentInfo/images/minus.png' style='width:30px'></a></div>
					                                			</div>
						                                		<table style="width:100%">
						                                			<tbody>
						                                				<tr>
						                                					<td class="alignCenter">OS</td>
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
								                                						<input  class="form-control" type="text" id="issueWriterList" name="issueWriterList" value=
																		                    <c:if test="${issueWriter eq 'admin'}">관리자</c:if>
																		                    <c:if test="${issueWriter eq 'khkim'}">김기호</c:if>
																		                    <c:if test="${issueWriter eq 'bspark'}">박범수</c:if>
																		                    <c:if test="${issueWriter eq 'DWSun'}">선두원</c:if>
																		            	readonly>
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
						                                					<td colspan='3'><textarea class="summerNoteSize" rows="5" id="issueObstacleList" name="issueObstacleList" onkeydown="resize(this)" onkeyup="resize(this)">${list.issueObstacle}</textarea></td>
						                                				</tr>
						                                				<tr>
																			<td class="alignCenter">비고</td>
						                                					<td colspan='3'><textarea class="form-control" id="issueNoteList" name="issueNoteList" onkeydown="resize(this)" onkeyup="resize(this)" placeholder='비고'>${list.issueNote}</textarea></td>
						                                				</tr>
						                                			</tbody>
						                                		</table>
						                                		<div class="positioningBtn"><button type="button" class="arrowBtn" style="background: peachpuff;" onclick="btnUp(this)">ᐱ</button> <button type="button" class="arrowBtn" style="background: burlywood;" onclick="btnDown(this)">ᐯ</button></div>
					                                		</div>
				                                		</c:forEach>
				                                	</div>
			                                		<div style="text-align:right">
			                                			<c:choose>
															<c:when test="${viewType eq 'update'}">
			                                					<button type="button" class="btn btn-default btn-outline-info-add" id="btnUpdate">SAVE</button>
			                                				</c:when>
			                                				<c:when test="${viewType eq 'copy'}">
			                                					<div id="copy">
			                                						<button type="button" class="btn btn-default btn-outline-info-add" id="btnCopy">SAVE</button>
			                                					</div>
			                                				</c:when>
			                                				<c:when test="${viewType eq 'insert'}">
			                                					<div id="save">
			                                						<button type="button" class="btn btn-default btn-outline-info-add" id="btnSave">SAVE</button>
			                                					</div>
			                                				</c:when>
			                                			</c:choose>
			                                			<div id="update" style="display: none;">
			                                				<button type="button" class="btn btn-default btn-outline-info-add" id="btnUpdate">SAVE</button>
			                                			</div>
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
	</body>

	<script>
		/* =========== 전달일자 오늘 날짜 입력 ========= */
		document.getElementById('issueDate').value = new Date().toISOString().substring(0, 10);;
		
		/* =========== 최초 1회 실행 ========= */
		$(function() {
			summernote();
			issueCount();
			if("${viewType}" == "insert") {
				$('#downloadBtn').hide();
			}
		});
		
		/* =========== SummerNote 설정 ========= */
		function summernote() {
			$('.summerNoteSize').summernote({
				minHeight:250,
				placeholder:"장애내용"
			});
		}
		
		/* =========== 위로 이동 ========= */
		function btnUp(obj) {
			var table = $(obj).parent().parent();
			table.prev().before(table);
		}
		
		/* =========== 아래로 이동 ========= */
		function btnDown(obj) {
			var table = $(obj).parent().parent();
			table.next().after(table);
		}
		
		/* =========== 마이너스 버튼 ========= */
		function btnMinus(obj) {
			var table = $(obj).parent().parent().parent();
			console.log(table);
			table.remove();
			issueCount();
			$('#total').text($('.issue').length);
			
			if($('.issue').length == 0) {
				btnPlus($(this).attr('blank'));
			}
		}
		
		/* =========== 플러스 버튼 ========= */
		function btnPlus(obj) {
			var table = $(obj).parent().parent().parent();
			
			var rowItem = "<div class='issue'>";
			rowItem += "<div>";
			rowItem += "<div style='text-align:left; float:left; margin-bottom: 5px;'><input class='form-control' type='text' style='width:400px' id='issueDivisionList' name='issueDivisionList' placeholder='구분'></div>";
			rowItem += "<div style='text-align:right; float:right;'><a onclick='btnPlus(this)' id='btnPlus'><img  src='/AgentInfo/images/pluse.png' style='width:30px'></a></div>";
			rowItem += "<div style='text-align:right; float:right;'><a onclick='btnMinus(this)' id='btnMinus'><img  src='/AgentInfo/images/minus.png' style='width:30px'></a></div>";
			rowItem += "</div>";
			rowItem += "<table style='width:100%'>";
			rowItem += "<tbody>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>OS</td>";
			rowItem += "<td><select class='form-control selectpicker selectForm' id='issueOsList' name='issueOsList' data-live-search='true' data-size='5'>";
			rowItem += "<option value='Linux'>Linux</option>";
			rowItem += "<option value='Windows'>Windows</option>";
			rowItem += "<option value='AIX'>AIX</option>";
			rowItem += "<option value='HP-UX'>HP-UX</option>";
			rowItem += "<option value='Solaris'>Solaris</option>";
			rowItem += "</select></td>";
			rowItem += "<td class='alignCenter'>작성자</td>";
			rowItem += "<td>";
			rowItem += "<input  class='form-control' type='text' id='issueWriterList' name='issueWriterList' value=";
			if('${issueWriter}' == 'admin') rowItem += "관리자";
			if('${issueWriter}' == 'khkim') rowItem += "김기호";
			if('${issueWriter}' == 'bspark') rowItem += "박범수";
			if('${issueWriter}' == 'DWSun') rowItem += "선두원";
			rowItem += " readonly>"
			rowItem += "</td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>대항목</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueAwardList' name='issueAwardList' placeholder='대항목'></td>";
			rowItem += "<td class='alignCenter'>중학목</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueMiddleList' name='issueMiddleList' placeholder='중항목'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>소항목1</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueUnder1List' name='issueUnder1List' placeholder='소항목1'></td>";
			rowItem += "<td class='alignCenter'>소항목2</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueUnder2List' name='issueUnder2List' placeholder='소항목2'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>소항목3</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueUnder3List' name='issueUnder3List' placeholder='소항목3'></td>";
			rowItem += "<td class='alignCenter'>소항목4</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueUnder4List' name='issueUnder4List' placeholder='소항목4'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>결함번호</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueFlawNumList' name='issueFlawNumList' placeholder='결함번호'></td>";
			rowItem += "<td class='alignCenter'>영향도</td>";
			rowItem += "<td><select class='form-control selectpicker selectForm' id='issueEffectList' name='issueEffectList' data-live-search='true' data-size='5'>";
			rowItem += "<option value='상'>상</option>";
			rowItem += "<option value='중'>중</option>";
			rowItem += "<option value='하'>하</option>";
			rowItem += "</select></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>테스트 결과</td>";
			rowItem += "<td><select class='form-control selectpicker selectForm' id='issueTextResultList' name='issueTextResultList' data-live-search='true' data-size='5'>";
			rowItem += "<option value='오류'>오류</option>";
			rowItem += "<option value='개선사항'>개선사항</option>";
			rowItem += "</select></td>";
			rowItem += "<td class='alignCenter'>적용여부</td>";
			rowItem += "<td><select class='form-control selectpicker selectForm' id='issueApplyYnList' name='issueApplyYnList' data-live-search='true' data-size='5'>";
			rowItem += "<option value='미해결'>미해결</option>";
			rowItem += "<option value='해결'>해결</option>";
			rowItem += "<option value='보류'>보류</option>";
			rowItem += "</select></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>확인내용</td>";
			rowItem += "<td colspan='3'><input class='form-control' type='text' id='issueConfirmList' name='issueConfirmList' placeholder='확인 내용'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>장애내용</td>";
			rowItem += "<td colspan='3'><textarea class='summerNoteSize' id='issueObstacleList' name='issueObstacleList' onkeydown='resize(this)' onkeyup='resize(this)'></textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>비고</td>";
			rowItem += "<td colspan='3'><textarea class='form-control' id='issueNoteList' name='issueNoteList' onkeydown='resize(this)' onkeyup='resize(this)' placeholder='비고'>${list.issueNote}</textarea></td>";
			rowItem += "</tr>";
			rowItem += "</tbody>";
			rowItem += "</table>";
			rowItem += "<div class='positioningBtn'><button type='button' class='arrowBtn' style='background: peachpuff;' onclick='btnUp(this)'>ᐱ</button> <button type='button' class='arrowBtn' style='background: burlywood;' onclick='btnDown(this)'>ᐯ</button></div>";
			rowItem += "</div>";
			
			table.after(rowItem); // 동적으로 row를 추가한다.
			$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
			
			$('#total').text($('.issue').length);
			
			// 플러스 클릭시 카운트 추가
			var unresolved = parseInt($('#unresolved').text());
			$('#unresolved').text(++unresolved);
			
			summernote(); // summerNote 적용
			$("select[name=issueApplyYnList]").change(function() {
				issueCount();
			});
		};
		
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
			$("input:checkbox[id='ChkTotal']").prop("checked", true);
			$("input:checkbox[id='ChkSolution']").prop("checked", true);
			$("input:checkbox[id='ChkUnresolved']").prop("checked", true);
			$("input:checkbox[id='ChkHold']").prop("checked", true);
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
		
		
		/* =========== 저장 버튼 ========= */
		$('#btnSave').click(function() {
			var postData = $('#form').serializeArray();
			var issueCustomer = $('#issueCustomer').val();
			postData.push({name : "total", value : $('#total').text()});
			postData.push({name : "solution", value : $('#solution').text()});
			postData.push({name : "unresolved", value : $('#unresolved').text()});
			postData.push({name : "hold", value : $('#hold').text()});
			if(issueCustomer == "") {
				$('#NotIssueCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotIssueCustomer').hide();
				$.ajax({
					url: "<c:url value='/issue/issueSave'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	$('#issueKeyNum').val(result.issueKeyNum);
			        	var issueKeyNum = $('#issueKeyNum').val();
			        	if(result.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "이슈 목록으로 이동하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '이동',
								  cancelButtonText: '저장',
							}).then((result) => {
								if (result.isConfirmed) {
									location.href="<c:url value='/issue/issueList'/>";
								} else {
									$('#save').hide();
									$('#update').show();
									$('#downloadBtn').show();
									$('#issueBtnType').val("update");
								}
							})
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
						}
					},
					error: function(error) {
						console.log(error);
					}
			    });
			}
		});
		
		/* =========== 업데이트 버튼 ========= */
		$('#btnUpdate').click(function() {
			var postData = $('#form').serializeArray();
			postData.push({name : "total", value : $('#total').text()});
			postData.push({name : "solution", value : $('#solution').text()});
			postData.push({name : "unresolved", value : $('#unresolved').text()});
			postData.push({name : "hold", value : $('#hold').text()});
			var issueCustomer = $('#issueCustomer').val();
			if(issueCustomer == "") {
				$('#NotIssueCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotIssueCustomer').hide();
				$.ajax({
					url: "<c:url value='/issue/update'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	if(result.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "이슈 목록으로 이동하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '이동',
								  cancelButtonText: '저장',
							}).then((result2) => {
								if (result2.isConfirmed) {
									location.href="<c:url value='/issue/issueList'/>";
								} else {
									$('#issueKeyNum').val(result.issueKeyNum);
									$('#downloadBtn').show();
								}
							})
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
						}
					},
					error: function(error) {
						console.log(error);
					}
			    });
			}
		});
		
		/* =========== 복사 버튼 ========= */
		$('#btnCopy').click(function() {
			var postData = $('#form').serializeArray();
			postData.push({name : "total", value : $('#total').text()});
			postData.push({name : "solution", value : $('#solution').text()});
			postData.push({name : "unresolved", value : $('#unresolved').text()});
			postData.push({name : "hold", value : $('#hold').text()});
			var issueCustomer = $('#issueCustomer').val();
			if(issueCustomer == "") {
				$('#NotIssueCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotIssueCustomer').hide();
				$.ajax({
					url: "<c:url value='/issue/copy'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	if(result.result == "OK") {
			        		if(result.result == "OK") {
			        			$('#issueKeyNum').val(result.issueKeyNum);
				        		Swal.fire({
									  title: '저장 완료!',
									  text: "이슈 목록으로 이동하시겠습니까?",
									  icon: 'success',
									  showCancelButton: true,
									  confirmButtonColor: '#7066e0',
									  cancelButtonColor: '#FF99AB',
									  confirmButtonText: '이동',
									  cancelButtonText: '저장',
								}).then((result) => {
									if (result.isConfirmed) {
										location.href="<c:url value='/issue/issueList'/>";
									} else {
										$('#copy').hide();
										$('#update').show();
										$('#issueBtnType').val("update");
									}
								})
							} else {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '작업을 실패하였습니다.',
								});
							}
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
						}
					},
					error: function(error) {
						console.log(error);
					}
			    });
			}
		});
		
		/* =========== TextArea 범위 초과시 크기 증가 ========= */
		function resize(obj) {
			obj.style.height = "1px";
			obj.style.height = (17+obj.scrollHeight)+"px";
		}
		
		/* =========== Ctrl + S 사용시 저장 ========= */
		document.onkeydown = function(e) {
		    if (e.which == 17)  isCtrl = true;
		    if (e.which == 83 && isCtrl == true) {  // Ctrl + s
		    	var btnType = $('#issueBtnType').val();
		    	if(btnType == "copy") {
		    		$('#btnCopy').click();
		    	} else {
		    		$('#btnUpdate').click();
		    	}
		    	isCtrl = false;
		    	return false;
		    }
		}
		document.onkeyup = function(e) {
			if (e.which == 17)  isCtrl = false;
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
		
		/* =========== PPT 다운로드 ========= */
		$('#BtnPpt').click(function() {
			Swal.fire({
				icon: 'info',
				title: '준비!',
				text: 'PPT 다운로드 준비중 입니다.'
			});
		});
		
		/* =========== Word 다운로드 ========= */
		$('#BtnWord').click(function() {
			Swal.fire({
				icon: 'info',
				title: '준비!',
				text: 'Word 다운로드 준비중 입니다.'
			});
		});
		
		/* =========== PDF 로컬 PC 다운로드(자식창에서 호출) ========= */
		function pdfDown(fileName) {
			window.location ="<c:url value='/issue/fileDownload?fileName="+fileName+"'/>";
			setTimeout(function() {
				fileDelete(fileName);
			},300);
		}
		
		/* =========== PDF 로컬 PC 삭제 ========= */
		function fileDelete(fileName) {
			$.ajax({
				url: "<c:url value='/issue/fileDelete'/>",
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
							text: 'PDF다운로드 완료되었습니다.'
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: 'PDF파일이 존재하지 않습니다.',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			  });
		}
		
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
		
		/* =========== 이슈 히스토리 제거 포멧털 ========= */
		function minusFormatter(value, options, row) {
			var issueHistoryPdf = row.issueHistoryPdf.toUpperCase();
			return '<a onclick="issueHistoryMinus(' + "'" + issueHistoryPdf + "'"  + ')"><img  src="/AgentInfo/images/minus2.png" style="width:20px"></a>';
		}
		
		/* =========== 이슈 히스토리 제거 ========= */
		function issueHistoryMinus(issueHistoryPdf) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/issueHistory/issueHistoryDelete'/>",
	            data: {"issueHistoryPdf" : issueHistoryPdf},
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
			fileDeleteHistory(issueHistoryPdf);
		}
		
		/* =========== 이슈 히스토리 추가 ========= */
		$('#BtnHistoryInsert').click(function() {
			var btnType = $('#issueBtnType').val();
			var resault;
	    	if(btnType == "copy") {
	    		resault = automaticCopy();
	    	} else {
	    		resault = automaticUpdate();
	    	}
	    	if(resault == "OK") {
				var frmData = document.form;
				var url = "<c:url value='/issue/pdfViewHistory'/>";
				window.open("", "form", "height=1000,width=1000,scrollbars=yes,status=yes,toolbar=no,location=yes,directories=yes,resizable=no,menubar=no");
				frmData.action = url; 
				frmData.method="post";
				frmData.target="form";
				frmData.submit();
	    	}
		});
		
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
		
		/* =========== 자동 복사 버튼 ========= */
		function automaticCopy() {
			var postData = $('#form').serializeArray();
			postData.push({name : "total", value : $('#total').text()});
			postData.push({name : "solution", value : $('#solution').text()});
			postData.push({name : "unresolved", value : $('#unresolved').text()});
			postData.push({name : "hold", value : $('#hold').text()});
			var issueCustomer = $('#issueCustomer').val();
			if(issueCustomer == "") {
				$('#NotIssueCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
				return "FALSE";
			} else {
				$('#NotIssueCustomer').hide();
				var resault;
				$.ajax({
					url: "<c:url value='/issue/copy'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	if(result.result == "OK") {
			        		$('#issueKeyNum').val(result.issueKeyNum);
							$('#copy').hide();
							$('#update').show();
							$('#issueBtnType').val("update");
							resault = "OK";
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
							resault = "FALSE";
						}
					},
					error: function(error) {
						console.log(error);
						resault = "FALSE";
					}
			    });
				return resault;
			}
		}
		
		/* =========== 자동 업데이트 버튼 ========= */
		function automaticUpdate() {
			var postData = $('#form').serializeArray();
			postData.push({name : "total", value : $('#total').text()});
			postData.push({name : "solution", value : $('#solution').text()});
			postData.push({name : "unresolved", value : $('#unresolved').text()});
			postData.push({name : "hold", value : $('#hold').text()});
			var issueCustomer = $('#issueCustomer').val();
			var resault;
			if(issueCustomer == "") {
				$('#NotIssueCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
				return "FALSE";
			} else {
				$('#NotIssueCustomer').hide();
				$.ajax({
					url: "<c:url value='/issue/update'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	if(result.result == "OK") {
							$('#issueKeyNum').val(result.issueKeyNum);
							$('#downloadBtn').show();
							resault = "OK";
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
							resault = "FALSE";
						}
					},
					error: function(error) {
						console.log(error);
						resault = "FALSE";
					}
			    });
				return resault;
			}
		}
	</script>
</html>