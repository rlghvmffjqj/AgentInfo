<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>PDF View</title>

		<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.slim.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery/jquery.min.js'/>"></script>
	</head>
	<body>
		<div class="title">
			<h1>
				<c:if test="${functionTestTitle.functionTestSettingDivision eq 'TOSMS'}">통합관리_</c:if>
				<c:if test="${functionTestTitle.functionTestSettingDivision eq 'Agent'}">정책관리_</c:if>
				${functionTestTitle.functionTestCustomer}_
				${functionTestTitle.functionTestTitle}_
				${functionTestTitle.functionTestDate}
			</h1>
		</div>
		<div style="background: #FFFFFF;">
		    <div>
			    <div class="searchbos" style="margin-bottom:20px; height: 55px;">
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">고객사</label>
			    		<input class="form-control titleInput" type="text" id="functionTestCustomer" name="functionTestCustomer" value="${functionTestTitle.functionTestCustomer}">
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">Title</label>
			    		<input class="form-control titleInput" type="text" id="functionTestTitle" name="functionTestTitle" value="${functionTestTitle.functionTestTitle}">
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">전달일자</label>
			    		<input class="form-control titleInput" type="text" id="functionTestDate" name="functionTestDate" value="${functionTestTitle.functionTestDate}">
			    	</div>
			    </div>
			    
			    <div style="height:25px; background: white;"></div>
			    <div style="background: white; width: 100%; height: auto;">
				    <ol>
				    	<c:forEach var="list" items="${functionTestSettingList}">
				    		<li>${list.functionTestSettingFormName} > ${list.functionTestSettingCategoryName} > ${list.functionTestSettingSubCategoryName}
				    			<c:forEach var="i" begin="${list.functionTestSettingFormName.length() + list.functionTestSettingCategoryName.length() + list.functionTestSettingSubCategoryName.length()}" end="52" step="1">
				    				-
								</c:forEach>
							</li>
				    	</c:forEach>
				    </ol>
			    </div>
			   
			    <% int num = 1; %>
			    <c:forEach var="list" items="${functionTestSettingList}">
					<div class="pageBreak"></div>
					<div class="searchbos">
						<div style="margin-bottom: 5px;">
							<span style="float:left; margin-right:3px;"><%= num %>.</span><div style='text-align:left; float:left'><input class="form-control" type="text" style='width:400px'  value="${list.functionTestSettingFormName} > ${list.functionTestSettingCategoryName} > ${list.functionTestSettingSubCategoryName}"></div>
						</div>
					   	<table style="width:100%">
					   		<tbody>
					   			<tr>
					   				<td class="alignCenter">대항목</td>
					   				<td><input class="form-control titleInput" type="text" id="functionTestSettingFormName" name="functionTestSettingFormName" value="${list.functionTestSettingFormName}"></td>
					   				<td class="alignCenter">중학목</td>
					   				<td><input class="form-control" type="text" id="functionTestSettingCategoryName" name="functionTestSettingCategoryName" value="${list.functionTestSettingCategoryName}"></td>
					   			</tr>
					   			<tr>
					   				<td class="alignCenter">소항목</td>
					   				<td><input class="form-control" type="text" id="functionTestSettingSubCategoryName" name="functionTestSettingSubCategoryName" value="${list.functionTestSettingSubCategoryName}"></td>
					   				<td class="alignCenter">테스트 결과</td>
					   				<td>
										<c:if test="${list.functionTestSubCategoryState eq 'success'}">
											<input class="form-control" type="text" id="functionTestSubCategoryState" name="functionTestSubCategoryState" value="정상">
										</c:if>
										<c:if test="${list.functionTestSubCategoryState eq 'failure'}">
											<input class="form-control" type="text" id="functionTestSubCategoryState" name="functionTestSubCategoryState" value="에러">
										</c:if>
									</td>
					   			</tr>
					 			<tr>
									<td class="alignCenter">사전 테스트 준비</td>
					 				<td colspan='3'><input class="form-control" type="text" id="functionTestSettingDetailProcedure" name="functionTestSettingDetailProcedure" value="${list.functionTestSettingDetailProcedure}"></td>
					 			</tr>
								 <tr>
									<td class="alignCenter">테스트 절차</td>
					 				<td colspan='3'>
					 					<div class="obstacleText1">${list.functionTestSettingDetailMethod}</div>
									</td>
					 			</tr>
								<tr>
									<td class="alignCenter">예상 테스트 결과</td>
					 				<td colspan='3'>
					 					<div class="obstacleText2">${list.functionTestSettingDetailExpectation}</div>
					 				</td>
					 			</tr>
								<tr>
									<td class="alignCenter">테스트 결과</td>
					 				<td colspan='3'>
					 					<div class="obstacleText3">${list.functionTestResult}</div>
					 				</td>
					 			</tr>
								<tr>
									<td class="alignCenter">비고</td>
					 				<td colspan='3'><input class="form-control" type="text" id="functionTestSubCategoryFailReason" name="functionTestSubCategoryFailReason" value="${list.functionTestSubCategoryFailReason}"></td>
					 			</tr>
					 		</tbody>
					 	</table>
				    </div>
				    <div style="width: 100%; height:30px;"></div>
				    <% num++; %>
			 	</c:forEach>
			</div>
		</div>
	</body>
	<script>
		$(document).ready(function() {
			// obstacleText 요소 선택
			var $obstacleText1 = $('.obstacleText1');

			// 원하는 높이 (예: 300px) 설정
			var desiredHeight = 800;

			// obstacleText 요소의 높이 가져오기
			var obstacleTextHeight1 = $obstacleText1.height();

			// 300px 위치에 pageBreak 요소를 삽입
			if (obstacleTextHeight1 >= desiredHeight) {
			  // <p> 태그 아래에 pageBreak 요소를 삽입
			  var $paragraphs1 = $obstacleText1.find('p');
			  $paragraphs1.first().before("<div class='pageBreak'></div>");
			}

			// ================

			// obstacleText 요소 선택
			var $obstacleText2 = $('.obstacleText2');

			// obstacleText 요소의 높이 가져오기
			var obstacleTextHeight2 = $obstacleText2.height();

			// 300px 위치에 pageBreak 요소를 삽입
			if (obstacleTextHeight2 >= desiredHeight) {
			  // <p> 태그 아래에 pageBreak 요소를 삽입
			  var $paragraphs2 = $obstacleText2.find('p');
			  $paragraphs2.first().before("<div class='pageBreak'></div>");
			}

			// ================

			// obstacleText 요소 선택
			var $obstacleText3 = $('.obstacleText3');

			// obstacleText 요소의 높이 가져오기
			var obstacleTextHeight3 = $obstacleText3.height();

			// 300px 위치에 pageBreak 요소를 삽입
			if (obstacleTextHeight3 >= desiredHeight) {
			  // <p> 태그 아래에 pageBreak 요소를 삽입
			  var $paragraphs3 = $obstacleText3.find('p');
			  $paragraphs3.first().before("<div class='pageBreak'></div>");
			}


		    var jsp = document.documentElement.innerHTML;
			var functionTestCustomer = $('#functionTestCustomer').val();
			var functionTestTitle = $('#functionTestTitle').val();
			var functionTestDate = $('#functionTestDate').val();
			$.ajax({
				url: "<c:url value='/functionTest/pdf'/>",
				type: "POST",
				data: {
						"jsp": jsp,
						"functionTestCustomer":functionTestCustomer,
						"functionTestTitle":functionTestTitle,
						"functionTestDate":functionTestDate,
					},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "OK") {
						var fileName = functionTestCustomer + "_" + functionTestTitle + "_" + functionTestDate + ".pdf";
						opener.pdfDown(fileName);
						window.close();
					} else {
						alert("PDF Download Error!\n관리자에게 문의 바랍니다.");
						window.close();
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
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
		
		.col-lg-3 {
			float: left;
			max-width: 29%;
			height: 55px;
			position: relative;
			width: 100%;
			min-height: 1px;
			padding-right: 15px;
			padding-left: 15px;
		}
		.labelFontSize {
			font-size: 12px;
			font-weight: bold;
		}
		.select, select.form-control {
			border: 1px solid #cccccc;
			padding: 0 30px 0 10px;
			font-size: 12px;
			background-size: 28px auto;
			letter-spacing: -0.8px;
		}
		.searchbos {
			background: #f5f5f5;
			border: 1px solid #ddd;
			border-top: 1px solid #0A8FFF;
			padding: 10px;
			/* display: inline-block; */
			width: 98%;
			box-shadow: 5px 5px 5px darkgrey;
		}
		.alignCenter {
			text-align: center;
			font-size: 12px;
			width: 70px;
		}
		.form-control {
			font-size: 12px;
			display: block;
			width: 100%;
			/* padding: 0.5rem 0.75rem; */
			line-height: 1.25;
			color: #495057;
			background-color: #fff;
			background-image: none;
			background-clip: padding-box;
			border: 1px solid rgba(0,0,0,.15);
			border-radius: 0.25rem;
			transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		}
		*, ::after, ::before {
			box-sizing: inherit;
		}
		button, input {
			overflow: visible;
		}
		
		.titleInput {
			width: 95%;
		}
		
		p {
			font-size: 10px;
			margin-block-start: 0px !important;
			margin-block-end: 0px !important;
			margin: 0px 0px 0px;
		}
		.obstacleText1, obstacleText2, obstacleText3 {
			font-size: 11px;
			background:white; 
			outline: 1px solid lightgray; 
			border-radius: 5px;
			min-height: 20px;
			width:100% !important;
			height:100%;
			overflow:hidden;
			margin:0 auto;
		}
		
		b {
			font-weight: bold;
			font-family: monospace;
			font-size: 12px;
		}
		
		img {
			max-width: 620px !important;
			max-height: 100% !important;
			object-fit:cover;
			border: solid 1px black !important;
		}
		.title {
			margin-top: 50px;
			margin-bottom: 50px;
			text-align: center;
		}

		.pageBreak {
			page-break-after: always;
		}

		tr {
			height: auto;
		}
	</style>
</html>