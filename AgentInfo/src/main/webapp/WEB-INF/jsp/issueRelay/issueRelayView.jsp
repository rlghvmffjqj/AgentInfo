<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 100%;">
	<head>
		<title>Secuve Test Report</title>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<meta charset="UTF-8">
		

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
				max-width: 25%;
				height: 55px;
				position: relative;
			    width: 100%;
			    min-height: 1px;
			    padding-right: 15px;
			    padding-left: 15px;
			}
			
			.col-lg-3 {
				float: left;
				max-width: 25%;
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
				background: #00ff2005;
				border: 1px solid #ddd;
				border-top: 1px solid #0A8FFF;
				padding: 10px;
				display: inline-block;
				width: 100%;
				box-shadow: 5px 5px 5px darkgrey;
				border-radius: 15px;
			}
			.summerNoteSize {
				height: 200px;
			    width: 300px;
			}
			.alignCenter {
				text-align: center;
				font-size: 12px;
				width: 71px;
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

			input:not([disabled]) {
				background: transparent !important;
			}
			
			.titleInput {
				width: 95%;
				border: solid 0.1px #00893d94;
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
				padding-top: 15px;
    			padding-bottom: 15px;
    			text-align: center;
    			color: white;
				background: #95C1B6 !important;
				border-radius: 10px;
			}

			.pageBreak {
				page-break-before: always;
			}

			body {
				background-color: #95c1b617 !important;
				margin-left: 10%;
    			margin-right: 10%;
				background-image: none;
			}

			.noneForm {
				font-size: 13px !important;
			}

			p {
				font-size: 14px !important;
			}

			.form-control {
				border-radius: 25px;
			}
		</style>
	</head>
	<body>
		<div class="pcoded-content" id="page-wrapper"></div>
		<div class="title">
			<span id="relayTitle">${issueTitle.issueCustomer}_${issueTitle.issueTitle}_${issueTitle.issueDate}</span>
		</div>
		<div style="padding-top: 20px;">
		    <div>
		    	<div style='text-align:right;'>
			    	Total:<label class="labelFontSize15" id="total">${issueTitle.total}</label>해결:<label class="labelFontSize15" id="solution">${issueTitle.solution}</label>미해결:<label class="labelFontSize15" id="unresolved">${issueTitle.unresolved}</label>보류<label class="labelFontSize15" id="hold">${issueTitle.hold}</label>
			    </div>
			    <div class="searchbos" style="margin-bottom:20px">
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">고객사</label>
			    		<input class="form-control titleInput" type="text" id="issueCustomer" name="issueCustomer" style="background: white !important;" value="${issueTitle.issueCustomer}" readonly>
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">Title</label>
			    		<input class="form-control titleInput" type="text" id="issueTitle" name="issueTitle" style="background: white !important;" value="${issueTitle.issueTitle}" readonly>
			    	</div>
					<div class="col-lg-3">
			    		<label class="labelFontSize">테스터</label>
			    		<input class="form-control titleInput" type="text" id="issueTester" name="issueTester" style="background: white !important;" value="${issueTitle.issueTester}" readonly>
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">전달일자</label>
			    		<input class="form-control titleInput" type="text" id="issueDate" name="issueDate" style="background: white !important;" value="${issueTitle.issueDate}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">TOSMS</label>
			    		<input class="form-control titleInput" type="text" id="issueTosms" name="issueTosms" style="background: white !important;" value="${issueTitle.issueTosms}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">TOSRF</label>
			    		<input class="form-control titleInput" type="text" id="issueTosrf" name="issueTosrf" style="background: white !important;" value="${issueTitle.issueTosrf}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">PORTAL</label>
			    		<input class="form-control titleInput" type="text" id="issuePortal" name="issuePortal" style="background: white !important;" value="${issueTitle.issuePortal}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">JAVA</label>
			    		<input class="form-control titleInput" type="text" id="issueJava" name="issueJava" style="background: white !important;" value="${issueTitle.issueJava}" readonly>
			    	</div>
			    	<div class="col-lg-4">
			    		<label class="labelFontSize">WAS</label>
			    		<input class="form-control titleInput" type="text" id="issueWas" name="issueWas" style="background: white !important;" value="${issueTitle.issueWas}" readonly>
			    	</div>
			    </div>
			    
			    <div style="height:25px; margin-left: 1%;">
					<!-- <span style="color: red;">답변 상태가 일치하지 않을경우 페이지 새로고침 후 확인 바랍니다.(수정 중)</span> -->
				</div>
				
			    <div style="width: 100%; height: auto;">
				    <ol>
				    	<c:forEach var="list" items="${issue}">
				    		<li class="listLi">
								<a onClick="moveScroll('${list.issuePrimaryKeyNum}');" style="font-size: 18px;">
									<span style="float: left; width: auto; min-width: 820px;">
										${list.issueDivision}
				    					<c:forEach var="i" begin="${list.issueDivision.length()}" end="52" step="1">
				    						-
										</c:forEach>
									</span>
									<c:if test="${list.issueAnswerStatus eq 'atmosphere'}">
										<span class="txt anim-text-flow index${list.issuePrimaryKeyNum}" style="width: 100px; float: left; margin-left: 1%;">답변 대기</span>
									</c:if>
									<c:if test="${list.issueAnswerStatus eq 'reRequest'}">
										<span class="txt anim-text-flow index${list.issuePrimaryKeyNum}" style="width: 100px; float: left; margin-left: 1%;">답변 재요청</span>
									</c:if>
								</a>
							</li>
				    	</c:forEach>
				    </ol>
			    </div>
				<br><br><br>
				<div class='pageBreak'></div>
			   
			    <% int num = 1; %>
			    <c:forEach var="list" items="${issue}">
					<div class="searchbos" data-keynum="${list.issuePrimaryKeyNum}">
				    	<div class="issue">
							<div style="margin-bottom: 5px;">
								<span style="float:left; margin-right:3px;"><%= num %>.</span><div style='text-align:left; float:left'><input class="form-control noneForm" type="text" style='width:400px' id="issueDivisionList" name="issueDivisionList" value="${list.issueDivision}" readonly></div>
							</div>
					   		<table style="width:100%">
					   			<tbody>
					   				<tr>
					   					<td class="alignCenter">OS</td>
					   					<td><input class="form-control noneForm" type="text" id="issueOsList" name="issueOsList" value="${list.issueOs}" readonly></td>
					   					<td class="alignCenter"></td>
					   					<td></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">대항목</td>
					   					<td><input class="form-control noneForm" type="text" id="issueAwardList" name="issueAwardList" value="${list.issueAward}" readonly></td>
					   					<td class="alignCenter">중학목</td>
					   					<td><input class="form-control noneForm" type="text" id="issueMiddleList" name="issueMiddleList" value="${list.issueMiddle}" readonly></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">소항목1</td>
					   					<td><input class="form-control noneForm" type="text" id="issueUnder1List" name="issueUnder1List" value="${list.issueUnder1}" readonly></td>
					   					<td class="alignCenter">소항목2</td>
					   					<td><input class="form-control noneForm" type="text" id="issueUnder2List" name="issueUnder2List" value="${list.issueUnder2}" readonly></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">소항목3</td>
					   					<td><input class="form-control noneForm" type="text" id="issueUnder3List" name="issueUnder3List" value="${list.issueUnder3}" readonly></td>
					   					<td class="alignCenter">소항목4</td>
										<td><input class="form-control noneForm" type="text" id="issueUnder4List" name="issueUnder4List" value="${list.issueUnder4}" readonly></td>
					   				</tr>
					   				<tr>
					   					<td class="alignCenter">결함번호</td>
					   					<td><input class="form-control noneForm" type="text" id="issueFlawNumList" name="issueFlawNumList" value="${list.issueFlawNum}" readonly></td>
					   					<td class="alignCenter">영향도</td>
					   					<td><input class="form-control noneForm" type="text" id="issueEffectList" name="issueEffectList" value="${list.issueEffect}" readonly></td>
									</tr>
									<tr>
										<td class="alignCenter">테스트 결과</td>
										<td><input class="form-control noneForm" type="text" id="issueTextResultList" name="issueTextResultList" value="${list.issueTextResult}" readonly></td>
					   					<td class="alignCenter">적용여부</td>
					   					<td><input class="form-control noneForm" type="text" id="issueApplyYnList" name="issueApplyYnList" value="${list.issueApplyYn}" readonly></td>
					 				</tr>
					 				<tr>
										<td class="alignCenter">확인내용</td>
					 					<td colspan='3'><input class="form-control noneForm" type="text" id="issueConfirmList" name="issueConfirmList" value="${list.issueConfirm}" readonly></td>
					 				</tr>
									<tr>
										<td class="alignCenter">장애내용</td>
					 					<td colspan='3'>
					 						<div class="obstacleText" style="min-height: 150px; line-height: 30px; padding: 10px;">${list.issueObstacle}</div>
					 					</td>
					 				</tr>
					 				<tr>
										<td class="alignCenter">비고</td>
					 					<td colspan='3'>
					 						<textarea class="form-control" id="issueNoteList" name="issueNoteList" style="min-height: 70px; height: auto; overflow: hidden; width: 100vm !important; background: white; border-radius: 0;" readonly>${list.issueNote}</textarea>
					 					</td>
					 				</tr>
					 			</tbody>
					 		</table>
							<table style="border-top: none;">
								<c:forEach var="issueRelay" items="${issueRelayList}">
									<c:if test="${issueRelay.issuePrimaryKeyNum eq list.issuePrimaryKeyNum}">
										<tr style="height: 50px;">
											<td class="alignCenter">${issueRelay.issueRelayType}</td>
											<td style="background-color: white;" id="detail_${issueRelay.issueRelayKeyNum}">
												${issueRelay.issueRelayDetail}
											</td>
											<td style="width: 100px; background: white; border-left: none; text-align: right;">
												<span>${issueRelay.issueRelayDate}</span>
												<c:if test="${issueRelay.issueRelayType eq '개발'}">
													<button class="btn btn-outline-info-nomal myBtn" onClick="btnUpdate('${issueRelay.issueRelayKeyNum}','${list.issuePrimaryKeyNum}')">수정</button>
													<button class="btn btn-outline-info-del myBtn" onClick="btnDelete('${issueRelay.issueRelayKeyNum}','${list.issuePrimaryKeyNum}',this)">삭제</button>
												</c:if>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
							<div style="width: 100%; text-align: right;	padding: 1%;">
								<button type="button" class="btn btn-outline-info-add myBtn" onclick="btnRelay('${list.issuePrimaryKeyNum}','${list.issueKeyNum}',this)">답변달기</button>
							</div>
				    	</div>
				    </div>
				    <div style="width: 100%; height:50px;"></div>
				    <% num++; %>
					<div class="pageBreak"></div>
			 	</c:forEach>
			</div>
		</div>
		<button class="scrollToTop" onclick="scrollToTop();">맨 위로</button>
		<c:if test="${issue.get(0).issueTarget eq 'TOSMS'}">
			<a href="https://qa.secuve.com/AgentInfo/issueRelay/issueRelayList?target=TOSMS">
				<img class="img-fluid" src="/AgentInfo/images/list.png" alt="list" style="border: none !important; width: 40px; position: fixed; top: 5px; left: 25px;">
			</a>
		</c:if>
		<c:if test="${issue.get(0).issueTarget eq 'Agent'}">
			<c:if test="${issue.get(0).issueSubTarget eq 'linux'}">
				<a href="https://qa.secuve.com/AgentInfo/issueRelay/issueRelayList?target=Agent">
					<img class="img-fluid" src="/AgentInfo/images/list.png" alt="list" style="border: none !important; width: 40px; position: fixed; top: 5px; left: 25px;">
				</a>
			</c:if>
			<c:if test="${issue.get(0).issueSubTarget eq 'windows'}">
				<a href="https://qa.secuve.com/AgentInfo/issueRelay/issueRelayList?target=AgentWin">
					<img class="img-fluid" src="/AgentInfo/images/list.png" alt="list" style="border: none !important; width: 40px; position: fixed; top: 5px; left: 25px;">
				</a>
			</c:if>
		</c:if>
			
	</body>
	<script>
		function moveScroll(keyNum) {
		    var target = document.querySelector('.searchbos[data-keynum="' + keyNum + '"]');
		    if (target) {
		        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
		    }
		}

		document.addEventListener("DOMContentLoaded", function() {
       		autoResize();
    	});

    	function autoResize() {
    	    const textarea = document.getElementById("issueNoteList");
    	    textarea.style.height = "auto"; // 높이를 자동으로 조정하도록 설정
    	    textarea.style.height = textarea.scrollHeight + "px"; // 스크롤 높이로 설정
    	}

		var exObj = "";
		var exIssuePrimaryKeyNum = '';
		var exIssueKeyNum = '';
		function btnRelay(issuePrimaryKeyNum, issueKeyNum, obj) {
			exObj = obj;
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

		$(document).on('issueRelayComplete', function(event, data) {
			var table = $(exObj).parent();

			var rowItem = "<div class='issue'>";
			rowItem += "<table style='border-top: none;'>";
			rowItem += "<tr style='height: 50px;'>";
			rowItem += "<td class='alignCenter'>개발</td>";
			rowItem += "<td style='background-color: white;' id='detail_"+data.issueRelayKeyNum+"'>";
			rowItem += data.issueRelayDetail;
			rowItem += "</td>";
			rowItem += "<td style='width: 100px; background: white; border-left: none; text-align: right;'>";
			rowItem += "<span>"+getCurrentTime()+" </span>";
			rowItem += "<button class='btn btn-outline-info-nomal myBtn' onClick='btnUpdate("+data.issueRelayKeyNum+","+data.issuePrimaryKeyNum+")'>수정</button>";
			rowItem += "<button class='btn btn-outline-info-del myBtn' onClick='btnDelete("+data.issueRelayKeyNum+","+data.issuePrimaryKeyNum+",this)'>삭제</button>";
			rowItem += "</td>";
			rowItem += "</tr>";
			rowItem += "</table>";
			table.before(rowItem);
			$(".index"+data.issuePrimaryKeyNum).hide();
		});

		$(document).on('issueRelayCompleteUpdate', function(event, data) {
			$('#detail_'+data.issueRelayKeyNum).html(data.issueRelayDetail);
		});

		function getCurrentTime() {
			var now = new Date();
  			var year = now.getFullYear();
  			var month = now.getMonth() + 1;
  			var day = now.getDate();
  			var hours = now.getHours();
  			var minutes = now.getMinutes();
  			var seconds = now.getSeconds();

  			// 시간을 2자리 숫자로 표시하기 위해 앞에 0 추가
  			month = (month < 10 ? "0" : "") + month;
  			day = (day < 10 ? "0" : "") + day;
  			hours = (hours < 10 ? "0" : "") + hours;
  			minutes = (minutes < 10 ? "0" : "") + minutes;
  			seconds = (seconds < 10 ? "0" : "") + seconds;

  			// 현재 시간을 문자열로 조합
  			var currentTimeString = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;

			return currentTimeString;
		}

		function btnUpdate(issueRelayKeyNum, issuePrimaryKeyNum) {
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

		function btnDelete(issueRelayKeyNum, issuePrimaryKeyNum, obj) {
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
	            					//location.reload();
									obj.closest('tr').remove();
									$(".index"+issuePrimaryKeyNum).show();
								}
							})
						} else {
							Swal.fire(
							  '실패!',
							  '삭제 실패하였습니다.',
							  'error'
							).then((result) => {
								if (result.isConfirmed) {
	            					//location.reload();
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

		$('.txt').html(function(i, html) {
		  var chars = $.trim(html).split("");

		  return '<span>' + chars.join('</span><span>') + '</span>';
		});
		
		function scrollToTop() {
    	    window.scrollTo(0, 0);
    	}
	</script>
	<style>
		.scrollToTop {
    	    position: fixed;
    	    bottom: 1%;
    	    right: 1%;
    	    padding: 10px;
    	    background-color: #83c597;
    	    color: #fff;
    	    border: none;
    	    cursor: pointer;
			border-radius: 100px;
    	}

		p {
			font-size: 16px;
			padding: 0.2%;
			overflow-wrap: break-word;
			max-width: 100vw !important;
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

		.noneForm {
			background: none !important;
			border: none !important;
		}

		@media (min-width: 1024px) and (max-width: 2000px) {
			img {
				max-width: 80% !important;
			}

			#relayTitle {
				font-size: 30px;
			}
		}
		@media (min-width: 0px) and (max-width: 1024px) {
			img {
				max-width: 95% !important;
			}
			
			#relayTitle {
				font-size: 30px;
			}

			.listLi {
				height: 55px;
			}
		}

		@import url(https://fonts.googleapis.com/css?family=Ubuntu:300);

		.anim-text-flow span,
		.anim-text-flow-hover:hover span {
		  -webkit-animation-name: anim-text-flow-keys;
		          animation-name: anim-text-flow-keys;
		  -webkit-animation-duration: 40s;
		          animation-duration: 40s;
		  -webkit-animation-iteration-count: infinite;
		          animation-iteration-count: infinite;
		  -webkit-animation-direction: alternate;
		          animation-direction: alternate;
		  -webkit-animation-fill-mode: forwards;
		          animation-fill-mode: forwards;
		}
		@-webkit-keyframes anim-text-flow-keys {
		  0% {
		    color: #d6765c;
		  }
		  5% {
		    color: #5cd65e;
		  }
		  10% {
		    color: #b45cd6;
		  }
		  15% {
		    color: #5cd66c;
		  }
		  20% {
		    color: #d6625c;
		  }
		  25% {
		    color: #89d65c;
		  }
		  30% {
		    color: #5cd699;
		  }
		  35% {
		    color: #d68f5c;
		  }
		  40% {
		    color: #93d65c;
		  }
		  45% {
		    color: #74d65c;
		  }
		  50% {
		    color: #5cd6b1;
		  }
		  55% {
		    color: #d6835c;
		  }
		  60% {
		    color: #5cd6ba;
		  }
		  65% {
		    color: #d6835c;
		  }
		  70% {
		    color: #7c5cd6;
		  }
		  75% {
		    color: #995cd6;
		  }
		  80% {
		    color: #5cd666;
		  }
		  85% {
		    color: #d2d65c;
		  }
		  90% {
		    color: #d6685c;
		  }
		  95% {
		    color: #5cd6af;
		  }
		  100% {
		    color: #5c93d6;
		  }
		}
		@keyframes anim-text-flow-keys {
		  0% {
		    color: #d6765c;
		  }
		  5% {
		    color: #5cd65e;
		  }
		  10% {
		    color: #b45cd6;
		  }
		  15% {
		    color: #5cd66c;
		  }
		  20% {
		    color: #d6625c;
		  }
		  25% {
		    color: #89d65c;
		  }
		  30% {
		    color: #5cd699;
		  }
		  35% {
		    color: #d68f5c;
		  }
		  40% {
		    color: #93d65c;
		  }
		  45% {
		    color: #74d65c;
		  }
		  50% {
		    color: #5cd6b1;
		  }
		  55% {
		    color: #d6835c;
		  }
		  60% {
		    color: #5cd6ba;
		  }
		  65% {
		    color: #d6835c;
		  }
		  70% {
		    color: #7c5cd6;
		  }
		  75% {
		    color: #995cd6;
		  }
		  80% {
		    color: #5cd666;
		  }
		  85% {
		    color: #d2d65c;
		  }
		  90% {
		    color: #d6685c;
		  }
		  95% {
		    color: #5cd6af;
		  }
		  100% {
		    color: #5c93d6;
		  }
		}
		.anim-text-flow span:nth-of-type(1),
		.anim-text-flow-hover:hover span:nth-of-type(1) {
		  -webkit-animation-delay: -19.8s;
		          animation-delay: -19.8s;
		}
		.anim-text-flow span:nth-of-type(2),
		.anim-text-flow-hover:hover span:nth-of-type(2) {
		  -webkit-animation-delay: -19.6s;
		          animation-delay: -19.6s;
		}
		.anim-text-flow span:nth-of-type(3),
		.anim-text-flow-hover:hover span:nth-of-type(3) {
		  -webkit-animation-delay: -19.4s;
		          animation-delay: -19.4s;
		}
		.anim-text-flow span:nth-of-type(4),
		.anim-text-flow-hover:hover span:nth-of-type(4) {
		  -webkit-animation-delay: -19.2s;
		          animation-delay: -19.2s;
		}
		.anim-text-flow span:nth-of-type(5),
		.anim-text-flow-hover:hover span:nth-of-type(5) {
		  -webkit-animation-delay: -19s;
		          animation-delay: -19s;
		}
		.anim-text-flow span:nth-of-type(6),
		.anim-text-flow-hover:hover span:nth-of-type(6) {
		  -webkit-animation-delay: -18.8s;
		          animation-delay: -18.8s;
		}
		.anim-text-flow span:nth-of-type(7),
		.anim-text-flow-hover:hover span:nth-of-type(7) {
		  -webkit-animation-delay: -18.6s;
		          animation-delay: -18.6s;
		}
		.anim-text-flow span:nth-of-type(8),
		.anim-text-flow-hover:hover span:nth-of-type(8) {
		  -webkit-animation-delay: -18.4s;
		          animation-delay: -18.4s;
		}
		.anim-text-flow span:nth-of-type(9),
		.anim-text-flow-hover:hover span:nth-of-type(9) {
		  -webkit-animation-delay: -18.2s;
		          animation-delay: -18.2s;
		}
		.anim-text-flow span:nth-of-type(10),
		.anim-text-flow-hover:hover span:nth-of-type(10) {
		  -webkit-animation-delay: -18s;
		          animation-delay: -18s;
		}
		.anim-text-flow span:nth-of-type(11),
		.anim-text-flow-hover:hover span:nth-of-type(11) {
		  -webkit-animation-delay: -17.8s;
		          animation-delay: -17.8s;
		}
		.anim-text-flow span:nth-of-type(12),
		.anim-text-flow-hover:hover span:nth-of-type(12) {
		  -webkit-animation-delay: -17.6s;
		          animation-delay: -17.6s;
		}
		.anim-text-flow span:nth-of-type(13),
		.anim-text-flow-hover:hover span:nth-of-type(13) {
		  -webkit-animation-delay: -17.4s;
		          animation-delay: -17.4s;
		}
		.anim-text-flow span:nth-of-type(14),
		.anim-text-flow-hover:hover span:nth-of-type(14) {
		  -webkit-animation-delay: -17.2s;
		          animation-delay: -17.2s;
		}
		.anim-text-flow span:nth-of-type(15),
		.anim-text-flow-hover:hover span:nth-of-type(15) {
		  -webkit-animation-delay: -17s;
		          animation-delay: -17s;
		}
		.anim-text-flow span:nth-of-type(16),
		.anim-text-flow-hover:hover span:nth-of-type(16) {
		  -webkit-animation-delay: -16.8s;
		          animation-delay: -16.8s;
		}
		.anim-text-flow span:nth-of-type(17),
		.anim-text-flow-hover:hover span:nth-of-type(17) {
		  -webkit-animation-delay: -16.6s;
		          animation-delay: -16.6s;
		}
		.anim-text-flow span:nth-of-type(18),
		.anim-text-flow-hover:hover span:nth-of-type(18) {
		  -webkit-animation-delay: -16.4s;
		          animation-delay: -16.4s;
		}
		.anim-text-flow span:nth-of-type(19),
		.anim-text-flow-hover:hover span:nth-of-type(19) {
		  -webkit-animation-delay: -16.2s;
		          animation-delay: -16.2s;
		}
		.anim-text-flow span:nth-of-type(20),
		.anim-text-flow-hover:hover span:nth-of-type(20) {
		  -webkit-animation-delay: -16s;
		          animation-delay: -16s;
		}
		.anim-text-flow span:nth-of-type(21),
		.anim-text-flow-hover:hover span:nth-of-type(21) {
		  -webkit-animation-delay: -15.8s;
		          animation-delay: -15.8s;
		}
		.anim-text-flow span:nth-of-type(22),
		.anim-text-flow-hover:hover span:nth-of-type(22) {
		  -webkit-animation-delay: -15.6s;
		          animation-delay: -15.6s;
		}
		.anim-text-flow span:nth-of-type(23),
		.anim-text-flow-hover:hover span:nth-of-type(23) {
		  -webkit-animation-delay: -15.4s;
		          animation-delay: -15.4s;
		}
		.anim-text-flow span:nth-of-type(24),
		.anim-text-flow-hover:hover span:nth-of-type(24) {
		  -webkit-animation-delay: -15.2s;
		          animation-delay: -15.2s;
		}
		.anim-text-flow span:nth-of-type(25),
		.anim-text-flow-hover:hover span:nth-of-type(25) {
		  -webkit-animation-delay: -15s;
		          animation-delay: -15s;
		}
		.anim-text-flow span:nth-of-type(26),
		.anim-text-flow-hover:hover span:nth-of-type(26) {
		  -webkit-animation-delay: -14.8s;
		          animation-delay: -14.8s;
		}
		.anim-text-flow span:nth-of-type(27),
		.anim-text-flow-hover:hover span:nth-of-type(27) {
		  -webkit-animation-delay: -14.6s;
		          animation-delay: -14.6s;
		}
		.anim-text-flow span:nth-of-type(28),
		.anim-text-flow-hover:hover span:nth-of-type(28) {
		  -webkit-animation-delay: -14.4s;
		          animation-delay: -14.4s;
		}
		.anim-text-flow span:nth-of-type(29),
		.anim-text-flow-hover:hover span:nth-of-type(29) {
		  -webkit-animation-delay: -14.2s;
		          animation-delay: -14.2s;
		}
		.anim-text-flow span:nth-of-type(30),
		.anim-text-flow-hover:hover span:nth-of-type(30) {
		  -webkit-animation-delay: -14s;
		          animation-delay: -14s;
		}
		.anim-text-flow span:nth-of-type(31),
		.anim-text-flow-hover:hover span:nth-of-type(31) {
		  -webkit-animation-delay: -13.8s;
		          animation-delay: -13.8s;
		}
		.anim-text-flow span:nth-of-type(32),
		.anim-text-flow-hover:hover span:nth-of-type(32) {
		  -webkit-animation-delay: -13.6s;
		          animation-delay: -13.6s;
		}
		.anim-text-flow span:nth-of-type(33),
		.anim-text-flow-hover:hover span:nth-of-type(33) {
		  -webkit-animation-delay: -13.4s;
		          animation-delay: -13.4s;
		}
		.anim-text-flow span:nth-of-type(34),
		.anim-text-flow-hover:hover span:nth-of-type(34) {
		  -webkit-animation-delay: -13.2s;
		          animation-delay: -13.2s;
		}
		.anim-text-flow span:nth-of-type(35),
		.anim-text-flow-hover:hover span:nth-of-type(35) {
		  -webkit-animation-delay: -13s;
		          animation-delay: -13s;
		}
		.anim-text-flow span:nth-of-type(36),
		.anim-text-flow-hover:hover span:nth-of-type(36) {
		  -webkit-animation-delay: -12.8s;
		          animation-delay: -12.8s;
		}
		.anim-text-flow span:nth-of-type(37),
		.anim-text-flow-hover:hover span:nth-of-type(37) {
		  -webkit-animation-delay: -12.6s;
		          animation-delay: -12.6s;
		}
		.anim-text-flow span:nth-of-type(38),
		.anim-text-flow-hover:hover span:nth-of-type(38) {
		  -webkit-animation-delay: -12.4s;
		          animation-delay: -12.4s;
		}
		.anim-text-flow span:nth-of-type(39),
		.anim-text-flow-hover:hover span:nth-of-type(39) {
		  -webkit-animation-delay: -12.2s;
		          animation-delay: -12.2s;
		}
		.anim-text-flow span:nth-of-type(40),
		.anim-text-flow-hover:hover span:nth-of-type(40) {
		  -webkit-animation-delay: -12s;
		          animation-delay: -12s;
		}
		.anim-text-flow span:nth-of-type(41),
		.anim-text-flow-hover:hover span:nth-of-type(41) {
		  -webkit-animation-delay: -11.8s;
		          animation-delay: -11.8s;
		}
		.anim-text-flow span:nth-of-type(42),
		.anim-text-flow-hover:hover span:nth-of-type(42) {
		  -webkit-animation-delay: -11.6s;
		          animation-delay: -11.6s;
		}
		.anim-text-flow span:nth-of-type(43),
		.anim-text-flow-hover:hover span:nth-of-type(43) {
		  -webkit-animation-delay: -11.4s;
		          animation-delay: -11.4s;
		}
		.anim-text-flow span:nth-of-type(44),
		.anim-text-flow-hover:hover span:nth-of-type(44) {
		  -webkit-animation-delay: -11.2s;
		          animation-delay: -11.2s;
		}
		.anim-text-flow span:nth-of-type(45),
		.anim-text-flow-hover:hover span:nth-of-type(45) {
		  -webkit-animation-delay: -11s;
		          animation-delay: -11s;
		}
		.anim-text-flow span:nth-of-type(46),
		.anim-text-flow-hover:hover span:nth-of-type(46) {
		  -webkit-animation-delay: -10.8s;
		          animation-delay: -10.8s;
		}
		.anim-text-flow span:nth-of-type(47),
		.anim-text-flow-hover:hover span:nth-of-type(47) {
		  -webkit-animation-delay: -10.6s;
		          animation-delay: -10.6s;
		}
		.anim-text-flow span:nth-of-type(48),
		.anim-text-flow-hover:hover span:nth-of-type(48) {
		  -webkit-animation-delay: -10.4s;
		          animation-delay: -10.4s;
		}
		.anim-text-flow span:nth-of-type(49),
		.anim-text-flow-hover:hover span:nth-of-type(49) {
		  -webkit-animation-delay: -10.2s;
		          animation-delay: -10.2s;
		}
		.anim-text-flow span:nth-of-type(50),
		.anim-text-flow-hover:hover span:nth-of-type(50) {
		  -webkit-animation-delay: -10s;
		          animation-delay: -10s;
		}
		.anim-text-flow span:nth-of-type(51),
		.anim-text-flow-hover:hover span:nth-of-type(51) {
		  -webkit-animation-delay: -9.8s;
		          animation-delay: -9.8s;
		}
		.anim-text-flow span:nth-of-type(52),
		.anim-text-flow-hover:hover span:nth-of-type(52) {
		  -webkit-animation-delay: -9.6s;
		          animation-delay: -9.6s;
		}
		.anim-text-flow span:nth-of-type(53),
		.anim-text-flow-hover:hover span:nth-of-type(53) {
		  -webkit-animation-delay: -9.4s;
		          animation-delay: -9.4s;
		}
		.anim-text-flow span:nth-of-type(54),
		.anim-text-flow-hover:hover span:nth-of-type(54) {
		  -webkit-animation-delay: -9.2s;
		          animation-delay: -9.2s;
		}
		.anim-text-flow span:nth-of-type(55),
		.anim-text-flow-hover:hover span:nth-of-type(55) {
		  -webkit-animation-delay: -9s;
		          animation-delay: -9s;
		}
		.anim-text-flow span:nth-of-type(56),
		.anim-text-flow-hover:hover span:nth-of-type(56) {
		  -webkit-animation-delay: -8.8s;
		          animation-delay: -8.8s;
		}
		.anim-text-flow span:nth-of-type(57),
		.anim-text-flow-hover:hover span:nth-of-type(57) {
		  -webkit-animation-delay: -8.6s;
		          animation-delay: -8.6s;
		}
		.anim-text-flow span:nth-of-type(58),
		.anim-text-flow-hover:hover span:nth-of-type(58) {
		  -webkit-animation-delay: -8.4s;
		          animation-delay: -8.4s;
		}
		.anim-text-flow span:nth-of-type(59),
		.anim-text-flow-hover:hover span:nth-of-type(59) {
		  -webkit-animation-delay: -8.2s;
		          animation-delay: -8.2s;
		}
		.anim-text-flow span:nth-of-type(60),
		.anim-text-flow-hover:hover span:nth-of-type(60) {
		  -webkit-animation-delay: -8s;
		          animation-delay: -8s;
		}
		.anim-text-flow span:nth-of-type(61),
		.anim-text-flow-hover:hover span:nth-of-type(61) {
		  -webkit-animation-delay: -7.8s;
		          animation-delay: -7.8s;
		}
		.anim-text-flow span:nth-of-type(62),
		.anim-text-flow-hover:hover span:nth-of-type(62) {
		  -webkit-animation-delay: -7.6s;
		          animation-delay: -7.6s;
		}
		.anim-text-flow span:nth-of-type(63),
		.anim-text-flow-hover:hover span:nth-of-type(63) {
		  -webkit-animation-delay: -7.4s;
		          animation-delay: -7.4s;
		}
		.anim-text-flow span:nth-of-type(64),
		.anim-text-flow-hover:hover span:nth-of-type(64) {
		  -webkit-animation-delay: -7.2s;
		          animation-delay: -7.2s;
		}
		.anim-text-flow span:nth-of-type(65),
		.anim-text-flow-hover:hover span:nth-of-type(65) {
		  -webkit-animation-delay: -7s;
		          animation-delay: -7s;
		}
		.anim-text-flow span:nth-of-type(66),
		.anim-text-flow-hover:hover span:nth-of-type(66) {
		  -webkit-animation-delay: -6.8s;
		          animation-delay: -6.8s;
		}
		.anim-text-flow span:nth-of-type(67),
		.anim-text-flow-hover:hover span:nth-of-type(67) {
		  -webkit-animation-delay: -6.6s;
		          animation-delay: -6.6s;
		}
		.anim-text-flow span:nth-of-type(68),
		.anim-text-flow-hover:hover span:nth-of-type(68) {
		  -webkit-animation-delay: -6.4s;
		          animation-delay: -6.4s;
		}
		.anim-text-flow span:nth-of-type(69),
		.anim-text-flow-hover:hover span:nth-of-type(69) {
		  -webkit-animation-delay: -6.2s;
		          animation-delay: -6.2s;
		}
		.anim-text-flow span:nth-of-type(70),
		.anim-text-flow-hover:hover span:nth-of-type(70) {
		  -webkit-animation-delay: -6s;
		          animation-delay: -6s;
		}
		.anim-text-flow span:nth-of-type(71),
		.anim-text-flow-hover:hover span:nth-of-type(71) {
		  -webkit-animation-delay: -5.8s;
		          animation-delay: -5.8s;
		}
		.anim-text-flow span:nth-of-type(72),
		.anim-text-flow-hover:hover span:nth-of-type(72) {
		  -webkit-animation-delay: -5.6s;
		          animation-delay: -5.6s;
		}
		.anim-text-flow span:nth-of-type(73),
		.anim-text-flow-hover:hover span:nth-of-type(73) {
		  -webkit-animation-delay: -5.4s;
		          animation-delay: -5.4s;
		}
		.anim-text-flow span:nth-of-type(74),
		.anim-text-flow-hover:hover span:nth-of-type(74) {
		  -webkit-animation-delay: -5.2s;
		          animation-delay: -5.2s;
		}
		.anim-text-flow span:nth-of-type(75),
		.anim-text-flow-hover:hover span:nth-of-type(75) {
		  -webkit-animation-delay: -5s;
		          animation-delay: -5s;
		}
		.anim-text-flow span:nth-of-type(76),
		.anim-text-flow-hover:hover span:nth-of-type(76) {
		  -webkit-animation-delay: -4.8s;
		          animation-delay: -4.8s;
		}
		.anim-text-flow span:nth-of-type(77),
		.anim-text-flow-hover:hover span:nth-of-type(77) {
		  -webkit-animation-delay: -4.6s;
		          animation-delay: -4.6s;
		}
		.anim-text-flow span:nth-of-type(78),
		.anim-text-flow-hover:hover span:nth-of-type(78) {
		  -webkit-animation-delay: -4.4s;
		          animation-delay: -4.4s;
		}
		.anim-text-flow span:nth-of-type(79),
		.anim-text-flow-hover:hover span:nth-of-type(79) {
		  -webkit-animation-delay: -4.2s;
		          animation-delay: -4.2s;
		}
		.anim-text-flow span:nth-of-type(80),
		.anim-text-flow-hover:hover span:nth-of-type(80) {
		  -webkit-animation-delay: -4s;
		          animation-delay: -4s;
		}
		.anim-text-flow span:nth-of-type(81),
		.anim-text-flow-hover:hover span:nth-of-type(81) {
		  -webkit-animation-delay: -3.8s;
		          animation-delay: -3.8s;
		}
		.anim-text-flow span:nth-of-type(82),
		.anim-text-flow-hover:hover span:nth-of-type(82) {
		  -webkit-animation-delay: -3.6s;
		          animation-delay: -3.6s;
		}
		.anim-text-flow span:nth-of-type(83),
		.anim-text-flow-hover:hover span:nth-of-type(83) {
		  -webkit-animation-delay: -3.4s;
		          animation-delay: -3.4s;
		}
		.anim-text-flow span:nth-of-type(84),
		.anim-text-flow-hover:hover span:nth-of-type(84) {
		  -webkit-animation-delay: -3.2s;
		          animation-delay: -3.2s;
		}
		.anim-text-flow span:nth-of-type(85),
		.anim-text-flow-hover:hover span:nth-of-type(85) {
		  -webkit-animation-delay: -3s;
		          animation-delay: -3s;
		}
		.anim-text-flow span:nth-of-type(86),
		.anim-text-flow-hover:hover span:nth-of-type(86) {
		  -webkit-animation-delay: -2.8s;
		          animation-delay: -2.8s;
		}
		.anim-text-flow span:nth-of-type(87),
		.anim-text-flow-hover:hover span:nth-of-type(87) {
		  -webkit-animation-delay: -2.6s;
		          animation-delay: -2.6s;
		}
		.anim-text-flow span:nth-of-type(88),
		.anim-text-flow-hover:hover span:nth-of-type(88) {
		  -webkit-animation-delay: -2.4s;
		          animation-delay: -2.4s;
		}
		.anim-text-flow span:nth-of-type(89),
		.anim-text-flow-hover:hover span:nth-of-type(89) {
		  -webkit-animation-delay: -2.2s;
		          animation-delay: -2.2s;
		}
		.anim-text-flow span:nth-of-type(90),
		.anim-text-flow-hover:hover span:nth-of-type(90) {
		  -webkit-animation-delay: -2s;
		          animation-delay: -2s;
		}
		.anim-text-flow span:nth-of-type(91),
		.anim-text-flow-hover:hover span:nth-of-type(91) {
		  -webkit-animation-delay: -1.8s;
		          animation-delay: -1.8s;
		}
		.anim-text-flow span:nth-of-type(92),
		.anim-text-flow-hover:hover span:nth-of-type(92) {
		  -webkit-animation-delay: -1.6s;
		          animation-delay: -1.6s;
		}
		.anim-text-flow span:nth-of-type(93),
		.anim-text-flow-hover:hover span:nth-of-type(93) {
		  -webkit-animation-delay: -1.4s;
		          animation-delay: -1.4s;
		}
		.anim-text-flow span:nth-of-type(94),
		.anim-text-flow-hover:hover span:nth-of-type(94) {
		  -webkit-animation-delay: -1.2s;
		          animation-delay: -1.2s;
		}
		.anim-text-flow span:nth-of-type(95),
		.anim-text-flow-hover:hover span:nth-of-type(95) {
		  -webkit-animation-delay: -1s;
		          animation-delay: -1s;
		}
		.anim-text-flow span:nth-of-type(96),
		.anim-text-flow-hover:hover span:nth-of-type(96) {
		  -webkit-animation-delay: -0.8s;
		          animation-delay: -0.8s;
		}
		.anim-text-flow span:nth-of-type(97),
		.anim-text-flow-hover:hover span:nth-of-type(97) {
		  -webkit-animation-delay: -0.6s;
		          animation-delay: -0.6s;
		}
		.anim-text-flow span:nth-of-type(98),
		.anim-text-flow-hover:hover span:nth-of-type(98) {
		  -webkit-animation-delay: -0.4s;
		          animation-delay: -0.4s;
		}
		.anim-text-flow span:nth-of-type(99),
		.anim-text-flow-hover:hover span:nth-of-type(99) {
		  -webkit-animation-delay: -0.2s;
		          animation-delay: -0.2s;
		}
		.anim-text-flow span:nth-of-type(100),
		.anim-text-flow-hover:hover span:nth-of-type(100) {
		  -webkit-animation-delay: 0s;
		          animation-delay: 0s;
		}

		.container5 {
		  position: absolute;
		  top: 50%;
		  left: 50%;
		  width: 100%;
		  transform: translate(-50%, -50%);
		}

		.txt {
		  display: block;
		}
		
		p {
        	padding: 0px;
        }
	</style>
</html>