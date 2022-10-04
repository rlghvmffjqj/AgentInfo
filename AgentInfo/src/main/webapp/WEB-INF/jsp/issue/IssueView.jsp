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
		                                				<label class="labelFontSize">고객사</label><label class="colorRed">*</label><span class="colorRed" id="NotIssueCustomer" style="display: none; line-height: initial;">고객사 필수 입력 바랍니다.</span>
		                                				<input class="form-control" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사명' value="${issueTitle.issueCustomer}">
		                                			</div>
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize">Title</label>
		                                				<input class="form-control" type="text" id="issueTitle" name="issueTitle" placeholder='Title' value="${issueTitle.issueTitle}">
		                                			</div>
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize">전달일자</label>
		                                				<input class="form-control" type="date" id="issueDate" name="issueDate" value="${issueTitle.issueDate}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">TOSMS</label>
		                                				<input class="form-control" type="text" id="issueTosms" name="issueTosms" placeholder='TOSMS' value="${issueTitle.issueTosms}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">TOSRF</label>
		                                				<input class="form-control" type="text" id="issueTosrf" name="issueTosrf" placeholder='TOSRF' value="${issueTitle.issueTosrf}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">PORTAL</label>
		                                				<input class="form-control" type="text" id="issuePortal" name="issuePortal" placeholder='PORTAL' value="${issueTitle.issuePortal}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">JAVA</label>
		                                				<input class="form-control" type="text" id="issueJava" name="issueJava" placeholder='JAVA' value="${issueTitle.issueJava}">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">WAS</label>
		                                				<input class="form-control" type="text" id="issueWas" name="issueWas" placeholder='WAS' value="${issueTitle.issueWas}">
		                                			</div>
		                                		</div>
		                                		<div style='text-align:left; float:left; margin-bottom:5px;'>
		                                			<span style="font-weight:bold;">보기 :</span> 
		                                			<button type="button" class="btn btn-outline-info-add myBtn" id="BtnTotal">전체</button>
		                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnSolution">해결</button>
		                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnUnresolved">미해결</button>
		                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnHold">보류</button>
		                                			<div id="downloadBtn" style="margin-top: 5px;">
			                                			<span style="font-weight:bold;">다운 :</span> 
			                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnPdf">PDF Download</button>
			                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnPpt">PPT Download</button>
			                                			<button type="button" class="btn btn-outline-info-nomal myBtn" id="BtnWord">Word Download</button>
			                                		</div>
		                                		</div> 
		                                		<div style='text-align:right;'>
					                              	Total:<label class="labelFontSize15" id="total">${issueTitle.total}</label>해결:<label class="labelFontSize15" id="solution">${issueTitle.solution}</label>미해결:<label class="labelFontSize15" id="unresolved">${issueTitle.unresolved}</label>보류<label class="labelFontSize15" id="hold">${issueTitle.hold}</label>
					                            </div>
		                                		<div class="searchbos">
			                                		<div class="plus">
			                                			<div><div id="blank"></div></div>
			                                			<c:forEach var="list" items="${issue}">
					                                		<div class="issue">
					                                			
					                                			<div style="margin-bottom: 5px;">
					                                				<div style='text-align:left; float:left'><input class="form-control" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" placeholder='구분' value="${list.issueDivision}"></div>
					                                				<div style='text-align:right;'><a onclick='btnMinus(this)' id='btnMinus'><img  src='/AgentInfo/images/minus.png' style='width:30px'></a></div>
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
																				</c:when>
																				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
																					<td><select class="form-control selectpicker selectForm" id="issueOsList" name="issueOsList" data-live-search="true" data-size="5">
																						<option value="Linux" <c:if test="${list.issueOs eq 'Linux'}">selected</c:if>>Linux</option>
																				    	<option value="Windows" <c:if test="${list.issueOs eq 'Windows'}">selected</c:if>>Windows</option>
																				    	<option value="AIX" <c:if test="${list.issueOs eq 'AIX'}">selected</c:if>>AIX</option>
																				    	<option value="HP-UX" <c:if test="${list.issueOs eq 'HP-UX'}">selected</c:if>>HP-UX</option>
																				    	<option value="Solaris" <c:if test="${list.issueOs eq 'Solaris'}">selected</c:if>>Solaris</option>
																				    </select></td>
																				</c:when>
																			</c:choose>
						                                					<td class="alignCenter"></td>
						                                					<td></td>
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
					                                			<div class="plusBtn"><a onclick='btnPlus(this)' id="btnPlus"><img  src="/AgentInfo/images/pluse.png" style="width:40px"></a></div>
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
		
		/* =========== 마이너스 버튼 ========= */
		function btnMinus(obj) {
			var table = $(obj).parent().parent().parent();
			table.remove();
			issueCount();
			$('#total').text($('.issue').length);
			
			if($('.issue').length == 0) {
				btnPlus($(this).attr('blank'));
			}
		}
		
		
		/* =========== 플러스 버튼 ========= */
		function btnPlus(obj) {
			var table = $(obj).parent().parent();
			
			var rowItem = "<div class='issue'>";
			rowItem += "<div style='margin-bottom: 5px;'>";
			rowItem += "<div style='text-align:left; float:left'><input class='form-control' type='text' style='width:400px' id='issueDivisionList' name='issueDivisionList' placeholder='구분'></div>";
			rowItem += "<div style='text-align:right;'><a onclick='btnMinus(this)' id='btnMinus'><img  src='/AgentInfo/images/minus.png' style='width:30px'></a></div>";
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
			rowItem += "<td class='alignCenter'></td>";
			rowItem += "<td></td>";
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
			rowItem += "<div class='plusBtn'><a onclick='btnPlus(this)' id='btnPlus'><img  src='/AgentInfo/images/pluse.png' style='width:40px'></a></div>";
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
		
		/* =========== 전체보기 ========= */
		$('#BtnTotal').click(function() {
			var list = new Array();
			$('select[name=issueApplyYnList]').each(function(index, item) {
				var value = $(item).val();
				if(value == "해결" || value == "미해결" || value == "보류") {
					$(item).parent().parent().parent().parent().parent().parent().show();
				}
			});
		});
		
		/* =========== 해결보기 ========= */
		$('#BtnSolution').click(function() {
			var list = new Array();
			$('select[name=issueApplyYnList]').each(function(index, item) {
				var value = $(item).val();
				if(value == "해결") {
					$(item).parent().parent().parent().parent().parent().parent().show();
				}
				if(value == "미해결" || value == "보류") {
					$(item).parent().parent().parent().parent().parent().parent().hide();
				}
			});
		});
		
		/* =========== 미해결보기 ========= */
		$('#BtnUnresolved').click(function() {
			var list = new Array();
			$('select[name=issueApplyYnList]').each(function(index, item) {
				var value = $(item).val();
				if(value == "미해결") {
					$(item).parent().parent().parent().parent().parent().parent().show();
				}
				if(value == "해결" || value == "보류") {
					$(item).parent().parent().parent().parent().parent().parent().hide();
				}
			});
		});
		
		/* =========== 보류보기 ========= */
		$('#BtnHold').click(function() {
			var list = new Array();
			$('select[name=issueApplyYnList]').each(function(index, item) {
				var value = $(item).val();
				if(value == "보류") {
					$(item).parent().parent().parent().parent().parent().parent().show();
				}
				if(value == "해결" || value == "미해결") {
					$(item).parent().parent().parent().parent().parent().parent().hide();
				}
			});
		});
		
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
		
		/* =========== PDF 로컬 PC 다운로드 ========= */
		window.call = function (fileName) {
			window.location ="<c:url value='/issue/fileDownload?fileName="+fileName+"'/>";
			setTimeout(function() {
				fileDelete(fileName);
			},300);
		};
		
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
		
	</script>
</html>