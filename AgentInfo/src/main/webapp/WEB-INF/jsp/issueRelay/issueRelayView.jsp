<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 100%;">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<meta charset="UTF-8">
		<title>${issueTitle.issueCustomer}_${issueTitle.issueTitle}_${issueTitle.issueDate}</title>

		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
		
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
				background: #7bb2a417;
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
				margin-top: 60px;
    			margin-bottom: 90px;
    			text-align: center;
    			color: white;
			}

			.pageBreak {
				page-break-before: always;
			}
		</style>
	</head>
	<body>
		<div class="pcoded-content" id="page-wrapper"></div>
		<div class="title">
			<h1>${issueTitle.issueCustomer}_${issueTitle.issueTitle}_${issueTitle.issueDate}</h1>
		</div>
		<div style="background: #FFFFFF; padding-top: 20px;">
		    <div>
		    	<div style='text-align:right;'>
			    	Total:<label class="labelFontSize15" id="total">${issueTitle.total}</label>해결:<label class="labelFontSize15" id="solution">${issueTitle.solution}</label>미해결:<label class="labelFontSize15" id="unresolved">${issueTitle.unresolved}</label>보류<label class="labelFontSize15" id="hold">${issueTitle.hold}</label>
			    </div>
			    <div class="searchbos" style="margin-bottom:20px">
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">고객사</label>
			    		<input class="form-control titleInput" type="text" id="issueCustomer" name="issueCustomer" value="${issueTitle.issueCustomer}" readonly>
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">Title</label>
			    		<input class="form-control titleInput" type="text" id="issueTitle" name="issueTitle" value="${issueTitle.issueTitle}" readonly>
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">전달일자</label>
			    		<input class="form-control titleInput" type="text" id="issueDate" name="issueDate" value="${issueTitle.issueDate}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">TOSMS</label>
			    		<input class="form-control titleInput" type="text" id="issueTosms" name="issueTosms" value="${issueTitle.issueTosms}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">TOSRF</label>
			    		<input class="form-control titleInput" type="text" id="issueTosrf" name="issueTosrf" value="${issueTitle.issueTosrf}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">PORTAL</label>
			    		<input class="form-control titleInput" type="text" id="issuePortal" name="issuePortal" value="${issueTitle.issuePortal}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">JAVA</label>
			    		<input class="form-control titleInput" type="text" id="issueJava" name="issueJava" value="${issueTitle.issueJava}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">WAS</label>
			    		<input class="form-control titleInput" type="text" id="issueWas" name="issueWas" value="${issueTitle.issueWas}" readonly>
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
				<br><br><br>
				<div class='pageBreak'></div>
			   
			    <% int num = 1; %>
			    <c:forEach var="list" items="${issue}">
					<div class="searchbos">
				    	<div class="issue">
							<div style="margin-bottom: 5px;">
								<span style="float:left; margin-right:3px;"><%= num %>.</span><div style='text-align:left; float:left'><input class="form-control" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" value="${list.issueDivision}" readonly></div>
							</div>
					   		<table style="width:100%">
					   			<tbody>
					   				<tr>
					   					<td class="alignCenter">OS</td>
					   					<td><input class="form-control" type="text" id="issueOsList" name="issueOsList" value="${list.issueOs}" readonly></td>
					   					<td class="alignCenter"></td>
					   					<td></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">대항목</td>
					   					<td><input class="form-control" type="text" id="issueAwardList" name="issueAwardList" value="${list.issueAward}" readonly></td>
					   					<td class="alignCenter">중학목</td>
					   					<td><input class="form-control" type="text" id="issueMiddleList" name="issueMiddleList" value="${list.issueMiddle}" readonly></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">소항목1</td>
					   					<td><input class="form-control" type="text" id="issueUnder1List" name="issueUnder1List" value="${list.issueUnder1}" readonly></td>
					   					<td class="alignCenter">소항목2</td>
					   					<td><input class="form-control" type="text" id="issueUnder2List" name="issueUnder2List" value="${list.issueUnder2}" readonly></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">소항목3</td>
					   					<td><input class="form-control" type="text" id="issueUnder3List" name="issueUnder3List" value="${list.issueUnder3}" readonly></td>
					   					<td class="alignCenter">소항목4</td>
										<td><input class="form-control" type="text" id="issueUnder4List" name="issueUnder4List" value="${list.issueUnder4}" readonly></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">결함번호</td>
					   					<td><input class="form-control" type="text" id="issueFlawNumList" name="issueFlawNumList" value="${list.issueFlawNum}" readonly></td>
					   					<td class="alignCenter">영향도</td>
					   					<td><input class="form-control" type="text" id="issueEffectList" name="issueEffectList" value="${list.issueEffect}" readonly></td>
									</tr>
									<tr>
										<td class="alignCenter">테스트 결과</td>
										<td><input class="form-control" type="text" id="issueTextResultList" name="issueTextResultList" value="${list.issueTextResult}" readonly></td>
					   					<td class="alignCenter">적용여부</td>
					   					<td><input class="form-control" type="text" id="issueApplyYnList" name="issueApplyYnList" value="${list.issueApplyYn}" readonly></td>
					 				</tr>
					 				<tr>
										<td class="alignCenter">확인내용</td>
					 					<td colspan='3'><input class="form-control" type="text" id="issueConfirmList" name="issueConfirmList" value="${list.issueConfirm}" readonly></td>
					 				</tr>
									<tr>
										<td class="alignCenter">장애내용</td>
					 					<td colspan='3'>
					 						<div class="obstacleText" style="min-height: 150px;">${list.issueObstacle}</div>
					 					</td>
					 				</tr>
					 				<tr>
										<td class="alignCenter">비고</td>
					 					<td colspan='3'>
					 						<textarea class="form-control" id="issueNoteList" name="issueNoteList" style="min-height: 70px; height: auto; overflow: hidden;" readonly>${list.issueNote}</textarea>
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
											<td style="width: 100px; background: white; border-left: none; text-align: right;">
												<span>${issueRelay.issueRelayDate}</span>
												<c:if test="${issueRelay.issueRelayType eq '개발'}">
													<button class="btn btn-outline-info-nomal myBtn" onClick="btnUpdate('${issueRelay.issueRelayKeyNum}')">수정</button>
													<button class="btn btn-outline-info-del myBtn" onClick="btnDelete('${issueRelay.issueRelayKeyNum}')">삭제</button>
												</c:if>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
							<div style="width: 100%; text-align: right;	padding: 1%;">
								<button type="button" class="btn btn-outline-info-add myBtn" onclick="btnRelay('${list.issuePrimaryKeyNum}','${list.issueKeyNum}')">답변달기</button>
							</div>
				    	</div>
				    </div>
				    <div style="width: 100%; height:50px;"></div>
				    <% num++; %>
					<div class="pageBreak"></div>
			 	</c:forEach>
			</div>
		</div>
	</body>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
       		autoResize();
    	});

    	function autoResize() {
    	    const textarea = document.getElementById("issueNoteList");
    	    textarea.style.height = "auto"; // 높이를 자동으로 조정하도록 설정
    	    textarea.style.height = textarea.scrollHeight + "px"; // 스크롤 높이로 설정
    	}

		function btnRelay(issuePrimaryKeyNum, issueKeyNum) {
	  		$.ajax({
			    type: 'POST',
			    url: "<c:url value='/issueRelay/relayModal'/>",
				data: {
					"issuePrimaryKeyNum": issuePrimaryKeyNum,
					"issueKeyNum": issueKeyNum,
					"issueRelayType": "개발"
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

		function btnUpdate(issueRelayKeyNum) {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/issueRelay/relayUpdateModal'/>",
				data: {
					"issueRelayKeyNum": issueRelayKeyNum
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

		function btnDelete(issueRelayKeyNum) {
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
					data: {"issueRelayKeyNum": issueRelayKeyNum},
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
	</script>
	<style>
		body {
			background-color: #95C1B6 !important;
			background-image: none;
		}

		img {
			max-width: 800px !important;
		}

		p {
			font-size: 16px;
			padding: 0.2%;
		}

		input {
			font-size: 15px !important;
		}

		li {
			font-size: 20px;
    		font-weight: bold;
		}

		#btnRelay {
			width: 95px;
    		height: 40px;
    		font-size: 15px;
		}

		label {
			margin-bottom: 5px;
		}
	</style>
</html>