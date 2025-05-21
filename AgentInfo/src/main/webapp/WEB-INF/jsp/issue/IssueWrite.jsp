<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
		                                				<input class="form-control" type="text" id="issueCustomer" name="issueCustomer" placeholder='고객사명'>
		                                			</div>
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize">Title</label>
		                                				<input class="form-control" type="text" id="issueTitle" name="issueTitle" placeholder='Title'>
		                                			</div>
		                                			<div class="col-lg-3">
		                                				<label class="labelFontSize">전달일자</label>
		                                				<input class="form-control" type="date" id="issueDate" name="issueDate" max="9999-12-31">
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">TOSMS</label>
		                                				<input class="form-control" type="text" id="issueTosms" name="issueTosms" placeholder='TOSMS'>
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">TOSRF</label>
		                                				<input class="form-control" type="text" id="issueTosrf" name="issueTosrf" placeholder='TOSRF'>
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">PORTAL</label>
		                                				<input class="form-control" type="text" id="issuePortal" name="issuePortal" placeholder='PORTAL'>
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">JAVA</label>
		                                				<input class="form-control" type="text" id="issueJava" name="issueJava" placeholder='JAVA'>
		                                			</div>
		                                			<div class="col-lg-4">
		                                				<label class="labelFontSize">WAS</label>
		                                				<input class="form-control" type="text" id="issueWas" name="issueWas" placeholder='WAS'>
		                                			</div>
		                                		</div>
		                                		<div class="searchbos issueStyle">
			                                		<div class="plus">
				                                		<div class="issue">
				                                			<div style="margin-bottom: 5px;">
				                                				<div style='text-align:left;'><input class="form-control" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" placeholder='구분'></div>
				                                			</div>
					                                		<table style="width:100%">
					                                			<tbody>
					                                				<tr>
					                                					<td class="alignCenter">OS</td>
					                                					<td><input class="form-control" type="text" id="issueOsList" name="issueOsList" placeholder='OS'></td>
					                                					<td class="alignCenter"></td>
					                                					<td></td>
					                                				</tr>
					                                				<tr>
					                                					<td class="alignCenter">대항목</td>
					                                					<td><input class="form-control" type="text" id="issueAwardList" name="issueAwardList" placeholder='대항목'></td>
					                                					<td class="alignCenter">중학목</td>
					                                					<td><input class="form-control" type="text" id="issueMiddleList" name="issueMiddleList" placeholder='중항목'></td>
					                                				</tr>
					                                				<tr>
					                                					<td class="alignCenter">소항목1</td>
					                                					<td><input class="form-control" type="text" id="issueUnder1List" name="issueUnder1List" placeholder='소항목1'></td>
					                                					<td class="alignCenter">소항목2</td>
					                                					<td><input class="form-control" type="text" id="issueUnder2List" name="issueUnder2List" placeholder='소항목2'></td>
					                                				</tr>
					                                				<tr>
					                                					<td class="alignCenter">결함번호</td>
					                                					<td><input class="form-control" type="text" id="issueFlawNumList" name="issueFlawNumList" placeholder='결합번호'></td>
					                                					<td class="alignCenter">영향도</td>
					                                					<td><input class="form-control" type="text" id="issueEffectList" name="issueEffectList"  placeholder='영향도'></td>
					                                				</tr>
					                                				<tr>
					                                					<td class="alignCenter">테스트 결과</td>
					                                					<td><input class="form-control" type="text" id="issueTextResultList" name="issueTextResultList" placeholder='테스트 결과'></td>
					                                					<td class="alignCenter">적용여부</td>
					                                					<td><input class="form-control" type="text" id="issueApplyYnList" name="issueApplyYnList"  placeholder='적용 여부'></td>
					                                				</tr>
					                                				<tr>
																		<td class="alignCenter">확인내용</td>
					                                					<td colspan='3'><input class="form-control" type="text" id="issueConfirmList" name="issueConfirmList" placeholder='확인 내용'></td>
					                                				</tr>
																	<tr>
																		<td class="alignCenter">장애내용</td>
					                                					<td colspan='3'><textarea class="summerNoteSize" id="issueObstacleList" name="issueObstacleList"></textarea></td>
					                                				</tr>
					                                				<tr>
																		<td class="alignCenter">비고</td>
					                                					<td colspan='3'><input class="form-control" type="text" id="issueNoteList" name="issueNoteList" placeholder='비고'></td>
					                                				</tr>
					                                			</tbody>
					                                		</table>
				                                			<div class="plusBtn"><a onclick='btnPlus(this)' id="btnPlus"><img  src="/AgentInfo/images/pluse.png" style="width:40px"></a></div>
				                                		</div>
				                                	</div>
			                                		<div style="text-align:right">
			                                			<div id="save">
			                                				<button type="button" class="btn btn-default btn-outline-info-add" id="btnSave">SAVE</button>
			                                			</div>
			                                			<div id="update" style="display: none;">
			                                				<button type="button" class="btn btn-default btn-outline-info-add" id="btnUpdate">SAVE</button>
			                                			</div>
			                                			<a href="<c:url value='/issue/pdfDownload'/>" class="waves-effect waves-dark">TEST</a>
			                                		</div>
		                                		</div>
		                                		<input class="form-control" type="hidden" id="issueKeyNum" name="issueKeyNum" value="0">
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
		document.getElementById('issueDate').value = new Date().toISOString().substring(0, 10);;
		
		$(function() {
			summernote();
		});
		
		function summernote() {
			$('.summerNoteSize').summernote({
				height:200,
				placeholder:"장애내용"
			});
		}
		
		function btnMinus(obj) {
			var table = $(obj).parent().parent().parent();
			table.remove();
		}
		
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
			rowItem += "<td><input class='form-control' type='text' id='issueOsList' name='issueOsList' placeholder='OS'></td>";
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
			rowItem += "<td class='alignCenter'>결함번호</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueFlawNumList' name='issueFlawNumList' placeholder='결함번호'></td>";
			rowItem += "<td class='alignCenter'>영향도</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueEffectList' name='issueEffectList' placeholder='영향도'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>테스트 결과</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueTextResultList' name='issueTextResultList' placeholder='테스트 결과'></td>";
			rowItem += "<td class='alignCenter'>적용여부</td>";
			rowItem += "<td><input class='form-control' type='text' id='issueApplyYnList' name='issueApplyYnList' placeholder='적용 여부'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>확인내용</td>";
			rowItem += "<td colspan='3'><input class='form-control' type='text' id='issueConfirmList' name='issueConfirmList' placeholder='확인 내용'></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>장애내용</td>";
			rowItem += "<td colspan='3'><textarea class='summerNoteSize' id='issueObstacleList' name='issueObstacleList'></textarea></td>";
			rowItem += "</tr>";
			rowItem += "<tr>";
			rowItem += "<td class='alignCenter'>비고</td>";
			rowItem += "<td colspan='3'><input class='form-control' type='text' id='issueNoteList' name='issueNoteList' placeholder='비고'></td>";
			rowItem += "</tr>";
			rowItem += "</tbody>";
			rowItem += "</table>";
			rowItem += "<div class='plusBtn'><a onclick='btnPlus(this)' id='btnPlus'><img  src='/AgentInfo/images/pluse.png' style='width:40px'></a></div>";
			rowItem += "</div>";
			
			table.after(rowItem); // 동적으로 row를 추가한다.
			
			summernote();
		};
		
		$('#btnSave').click(function() {
			var postData = $('#form').serializeArray();
			//var markup = document.documentElement.innerHTML;
			//var data =[{name: 'htmlCode', value: markup}];
			//var jsonData = postData.concat(data);
			
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
		
		$('#btnUpdate').click(function() {
			var postData = $('#form').serializeArray();
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
							}).then((result) => {
								if (result.isConfirmed) {
									location.href="<c:url value='/issue/issueList'/>";
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
	</script>
	<style>
		.issueStyle {
			background: #fdf4e2;
    		font-weight: bold;
    		font-family: math;
		}
	</style>
</html>