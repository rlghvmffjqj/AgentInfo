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
			
			.col-lg-4 {
				float: left;
				max-width: 29%;
				height: 55px;
				position: relative;
			    width: 100%;
			    min-height: 1px;
			    padding-right: 15px;
			    padding-left: 15px;
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
			.labelFontSize15 {
				font-size: 12px;
				font-weight: bold;
				margin-right: 10px;
			}
			.searchbos {
				background: #f5f5f5;
				border: 1px solid #ddd;
				border-top: 1px solid #0A8FFF;
				padding: 10px;
				display: inline-block;
				width: 100%;
				box-shadow: 5px 5px 5px darkgrey;
			}
			.summerNoteSize {
				height: 200px;
			    width: 300px;
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
				max-width: 100vw;
				overflow-wrap: break-word;
			}
			.obstacleText {
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
				page-break-before: always;
			}
		</style>
	</head>
	<body>
		<div class="title">
			<h1>${issueTitle.issueCustomer}_${issueTitle.issueTitle}_${issueTitle.issueDate}</h1>
		</div>
		<div style="background: #FFFFFF;">
		    <div>
		    	<div style='text-align:right;'>
			    	Total:<label class="labelFontSize15" id="total">${issueTitle.total}</label>해결:<label class="labelFontSize15" id="solution">${issueTitle.solution}</label>미해결:<label class="labelFontSize15" id="unresolved">${issueTitle.unresolved}</label>보류<label class="labelFontSize15" id="hold">${issueTitle.hold}</label>
			    </div>
			    <div class="searchbos" style="margin-bottom:20px">
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">고객사</label>
			    		<input class="form-control titleInput" type="text" id="issueCustomer" name="issueCustomer" value="${issueTitle.issueCustomer}">
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">Title</label>
			    		<input class="form-control titleInput" type="text" id="issueTitle" name="issueTitle" value="${issueTitle.issueTitle}">
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">전달일자</label>
			    		<input class="form-control titleInput" type="text" id="issueDate" name="issueDate" value="${issueTitle.issueDate}">
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">TOSMS</label>
			    		<input class="form-control titleInput" type="text" id="issueTosms" name="issueTosms" value="${issueTitle.issueTosms}">
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">TOSRF</label>
			    		<input class="form-control titleInput" type="text" id="issueTosrf" name="issueTosrf" value="${issueTitle.issueTosrf}">
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">PORTAL</label>
			    		<input class="form-control titleInput" type="text" id="issuePortal" name="issuePortal" value="${issueTitle.issuePortal}">
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">JAVA</label>
			    		<input class="form-control titleInput" type="text" id="issueJava" name="issueJava" value="${issueTitle.issueJava}">
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">WAS</label>
			    		<input class="form-control titleInput" type="text" id="issueWas" name="issueWas" value="${issueTitle.issueWas}">
			    	</div>
			    </div>
			    
			    <div style="height:25px; background: white;"></div>
			    <div style="background: white; width: 100%; height: auto;">
				    <ol>
				    	<c:forEach var="list" items="${issue}">
				    		<li>${list.issueDivision}
				    			<c:forEach var="i" begin="${list.issueDivision.length()}" end="52" step="1">
				    				-
								</c:forEach>
							</li>
				    	</c:forEach>
				    </ol>
			    </div>
				<div class='pageBreak'></div>
			   
			    <% int num = 1; %>
			    <c:forEach var="list" items="${issue}">
					<div class="searchbos">
				    	<div class="issue">
							<div style="margin-bottom: 5px;">
								<span style="float:left; margin-right:3px;"><%= num %>.</span><div style='text-align:left; float:left'><input class="form-control" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" value="${list.issueDivision}"></div>
							</div>
					   		<table style="width:100%">
					   			<tbody>
					   				<tr>
					   					<td class="alignCenter">OS</td>
					   					<td><input class="form-control" type="text" id="issueOsList" name="issueOsList" value="${list.issueOs}"></td>
					   					<td class="alignCenter"></td>
					   					<td></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">대항목</td>
					   					<td><input class="form-control" type="text" id="issueAwardList" name="issueAwardList" value="${list.issueAward}"></td>
					   					<td class="alignCenter">중학목</td>
					   					<td><input class="form-control" type="text" id="issueMiddleList" name="issueMiddleList" value="${list.issueMiddle}"></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">소항목1</td>
					   					<td><input class="form-control" type="text" id="issueUnder1List" name="issueUnder1List" value="${list.issueUnder1}"></td>
					   					<td class="alignCenter">소항목2</td>
					   					<td><input class="form-control" type="text" id="issueUnder2List" name="issueUnder2List" value="${list.issueUnder2}"></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">소항목3</td>
					   					<td><input class="form-control" type="text" id="issueUnder3List" name="issueUnder3List" value="${list.issueUnder3}"></td>
					   					<td class="alignCenter">소항목4</td>
										<td><input class="form-control" type="text" id="issueUnder4List" name="issueUnder4List" value="${list.issueUnder4}"></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">결함번호</td>
					   					<td><input class="form-control" type="text" id="issueFlawNumList" name="issueFlawNumList" value="${list.issueFlawNum}"></td>
					   					<td class="alignCenter">영향도</td>
					   					<td><input class="form-control" type="text" id="issueEffectList" name="issueEffectList" value="${list.issueEffect}"></td>
									</tr>
									<tr>
										<td class="alignCenter">테스트 결과</td>
										<td><input class="form-control" type="text" id="issueTextResultList" name="issueTextResultList" value="${list.issueTextResult}"></td>
					   					<td class="alignCenter">적용여부</td>
					   					<td><input class="form-control" type="text" id="issueApplyYnList" name="issueApplyYnList" value="${list.issueApplyYn}"></td>
					 				</tr>
					 				<tr>
										<td class="alignCenter">확인내용</td>
					 					<td colspan='3'><input class="form-control" type="text" id="issueConfirmList" name="issueConfirmList" value="${list.issueConfirm}"></td>
					 				</tr>
									<tr>
										<td class="alignCenter">장애내용</td>
					 					<td colspan='3'>
					 						<div class="obstacleText" style="max-width: 880px;">${list.issueObstacle}</div>
					 					</td>
					 				</tr>
					 				<tr>
										<td class="alignCenter">비고</td>
					 					<td colspan='3'>
					 						<textarea class="form-control" id="issueNoteList" name="issueNoteList">${list.issueNote}</textarea>
					 					</td>
					 				</tr>
					 			</tbody>
					 		</table>
							 <table style="border-top: none;">
								<c:forEach var="issueRelay" items="${issueRelayList}">
									<c:if test="${issueRelay.issuePrimaryKeyNum eq list.issuePrimaryKeyNum}">
										<tr style="height: 50px;">
											<td class="alignCenter">${issueRelay.issueRelayType}</td>
											<td style="background-color: white;">
												${issueRelay.issueRelayDetail}
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
				    	</div>
				    </div>
				    <div style="width: 100%; height:30px;"></div>
				    <% num++; %>
					<div class="pageBreak"></div>
			 	</c:forEach>
			</div>
		</div>
	</body>
	<script>
		$(document).ready(function() {
		    $("p").each(function() {
    		    // 이미지가 아닌 경우에만 작업 수행
    		    if (!$(this).find("img").length) {
    		        var text = $(this).text();
    		        var newText = '';
    		        for (var i = 0; i < text.length; i++) {
    		            newText += text[i];
    		            if ((i + 1) % 110 === 0 && i !== 0 && i !== text.length - 1) {
    		                newText += "<br>";
    		            }
    		        }
    		        $(this).html(newText);
    		    }
    		});
		});
		$(function() {
			// // obstacleText 요소 선택
 			// var $obstacleText = $('.obstacleText');

			// // 원하는 높이 (예: 300px) 설정
			// var desiredHeight = 800;

			// // obstacleText 요소의 높이 가져오기
			// var obstacleTextHeight = $obstacleText.height();

			// // 300px 위치에 pageBreak 요소를 삽입
			// if (obstacleTextHeight >= desiredHeight) {
			//   // <p> 태그 아래에 pageBreak 요소를 삽입
			//   var $paragraphs = $obstacleText.find('p');
			//   $paragraphs.first().before("<div class='pageBreak'></div>");
			// }

			var $images = $('.obstacleText img');

    		// 이미지의 높이 확인 및 pageBreak 요소 추가
    		$images.each(function() {
    		    var $image = $(this);
    		    var imageHeight = $image.height();
    		    if (imageHeight >= 200) {
    		        $image.after("<div class='pageBreak'></div>");
    		    }
    		});

			var obj = $('textarea');
			for(var i=0; i<obj.length; i++) {
				obj[i].style.height = '1px';
				obj[i].style.height = (17+obj[i].scrollHeight)+"px";
			}
			var today = new Date();
			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
			var hours = ('0' + today.getHours()).slice(-2); 
			var minutes = ('0' + today.getMinutes()).slice(-2);
			var seconds = ('0' + today.getSeconds()).slice(-2); 
			var now = year + '-' + month  + '-' + day + " " + hours + '：' + minutes  + '：' + seconds;
			
			var jsp = document.documentElement.innerHTML;
			var issueCustomer = $('#issueCustomer').val();
			var issueTitle = $('#issueTitle').val();
			if("${viewType}" == "download") {
				var issueDate = $('#issueDate').val();
				$.ajax({
					url: "<c:url value='/issue/pdf'/>",
					type: "POST",
					data: {
							"jsp": jsp,
							"issueCustomer":issueCustomer,
							"issueTitle":issueTitle,
							"issueDate":issueDate,
						},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						if(data == "OK") {
							var fileName = issueCustomer + "_" + issueTitle + "_" + issueDate + ".pdf";
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
			} else if("${viewType}" == "history") {
				var issueDate = now;
				$.ajax({
					url: "<c:url value='/issue/pdfHistory'/>",
					type: "POST",
					data: {
							"jsp": jsp,
							"issueCustomer":issueCustomer,
							"issueTitle":issueTitle,
							"issueDate":issueDate,
						},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						if(data == "OK") {
							var fileName = issueCustomer + "_" + issueTitle + "_" + issueDate + ".pdf";
							opener.pdfDownHistory(now);
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
			}
		});
	</script>
</html>