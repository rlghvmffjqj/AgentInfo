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
			  white-space: normal;
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
				float: left;
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
				background: #F4F0EC;
				border: 1px solid #ddd;
				border-top: 1px solid #0A8FFF;
				padding: 10px;
				display: inline-block;
				width: 100%;
				box-shadow: 5px 5px 5px darkgrey;
				border-radius: 15px;
				margin-left: -1%;
    			margin-bottom: 3%;
    			margin-top: 1%;
				min-width: 800px;
			}
			.searchbox {
				background: #f5f5f5;
				border: 1px solid #ddd;
				border-top: 1px solid #0A8FFF;
				padding: 10px;
				display: inline-block;
				width: 100%;
				box-shadow: 5px 5px 5px darkgrey;
				border-radius: 15px;
				margin-left: 0%;
    			margin-bottom: 3%;
    			margin-top: 1%;
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
				border: solid 0.1px #89310094;
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
				background: #cfa875cc !important;
				border-radius: 10px;
				min-width: 850px;
			}

			.pageBreak {
				page-break-before: always;
			}

			body {
				background-color: #95c1b617 !important;
				margin-left: 10%;
    			margin-right: 10%;
				background-image: none;
				overflow: scroll;
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

			.titleDiv {
				float: left;
    			min-width: 18vw;
    			margin-left: 5px;
			}

			.titleMenu {
				float: left;
    			width: 10%;
    			border: 1px solid;
    			border-radius: 25px;
    			height: 30px;
    			text-align: center;
    			padding-top: 4px;
			}
		</style>
	</head>
	<body>
		<div class="pcoded-content" id="page-wrapper"></div>
		<div class="title">
			<span id="relayTitle">향후 개선 사항</span>
		</div>
		<div style="padding-top: 20px;">
		    <div>

			    <div class="searchbox" style="margin-bottom:20px; height: 200px; min-width: 850px;">
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">고객사</label>
			    		<input class="form-control titleInput" type="text" id="issueCustomer" name="issueCustomer" style="background: white !important;" value="">
			    	</div>
			    	<div class="col-lg-3">
			    		<label class="labelFontSize">Title</label>
			    		<input class="form-control titleInput" type="text" id="issueTitle" name="issueTitle" style="background: white !important;" value="">
			    	</div>
					<p class="search-btn" style="padding-top: 125px; text-align: right;">
						<button class="btn btn-primary btnm" type="button" id="btnSearch">
							<i class="fa fa-search"></i>&nbsp;<span>검색</span>
						</button>
						<button class="btn btn-default btnm" type="button" id="btnReset">
							<span>초기화</span>
						</button>
					</p>
			    </div>
			    
			    <div style="height:25px; margin-left: 1%;">
					<!-- <span style="color: red;">답변 상태가 일치하지 않을경우 페이지 새로고침 후 확인 바랍니다.(수정 중)</span> -->
				</div>
				<div style="width: 100%; height: 30px; font-size: 18px; font-weight: bold; color: #6165cd; padding-top: 4px; margin-bottom: 20px;">
					<div class="titleMenu" style="margin-left: 8%;">고객사</div>
					<div class="titleMenu" style="margin-left: 15%;">타이틀</div>
					<div class="titleMenu" style="margin-left: 12%;">제목</div>
				</div>
			    <div style="width: 100%; height: auto;">
				    <ol>
				    	<c:forEach var="list" items="${issue}">
				    		<li class="listLi" id="item${list.issuePrimaryKeyNum}" style="height:34px !important; width: 70vw;">
								<a onClick="moveScroll(this, '${list.issuePrimaryKeyNum}');" style="font-size: 18px;">
									<div style="width: 80%; height:18px; overflow: hidden; float: left; min-width: 600px;">
										<span style="float: left;">
											<div class="titleDiv customerSerach">${list.issueCustomer}</div><div class="titleDiv titleSearch"> | ${list.issueTitle} </div><div class="titleDiv"> | ${list.issueDivision}</div>
										</span>
									
				    					<c:forEach var="i" begin="${list.issueDivision.length()}" end="100" step="1">
				    						-
										</c:forEach>
									</div>
								</a>
								<a onClick="deleteImprovements('${list.issuePrimaryKeyNum}')">
									<span class="txt solveSpan" style="width: 100px; float: left; margin-left: 1%;">삭제</span>	
								</a>
							</li>
				    	</c:forEach>
				    </ol>
			    </div>
			</div>
		</div>

		<button class="scrollToTop" onclick="scrollToTop();">맨 위로</button>
		<button class="scrollToTop" onclick="closeAll();" style="right: 5% !important;">전체 닫기</button>
		
	</body>
	<script>
		var isAnimating = false;
		function moveScroll(element, keyNum) {
			if (isAnimating) {
    		    return false; // 애니메이션 중이면 동작하지 않음
    		}
			isAnimating = true;
			var parent = $(element).parent();
            var nextSibling = parent.next('.searchbos');
            if (nextSibling.length) {
                nextSibling.slideUp(300, function() {
                    nextSibling.remove();
					isAnimating = false;
                });
				return false;
			}

			var itemLi = $("#item" + keyNum);
		    $.ajax({
				url: "<c:url value='/issueRelay/improvementsitem'/>",
				type: "POST",
				data: {
					"issuePrimaryKeyNum": keyNum

				},
				success: function(data) {
					var itemDiv = "<div class='searchbos' id='div"+data.issue.issuePrimaryKeyNum+"'>";
					itemDiv += "<div class='issue'>";
					itemDiv += "<div style='margin-bottom: 5px;'>";
					itemDiv += "<div style='text-align:left; float:left'><input class='form-control noneForm' type='text' style='width:400px' id='issueDivisionList' name='issueDivisionList' value='"+data.issue.issueDivision+"' readonly></div>";
					itemDiv += "</div>";
					itemDiv += "<table style='width:100%'>";
					itemDiv += "<tbody>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>OS</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueOsList' name='issueOsList' value='"+data.issue.issueOs+"' readonly></td>";
					itemDiv += "<td class='alignCenter'>작성자</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueWriterList' name='issueWriterList' value='"+data.issue.issueWriter+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>대항목</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueAwardList' name='issueAwardList' value='"+data.issue.issueAward+"' readonly></td>";
					itemDiv += "<td class='alignCenter'>중학목</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueMiddleList' name='issueMiddleList' value='"+data.issue.issueMiddle+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>소항목1</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueUnder1List' name='issueUnder1List' value='"+data.issue.issueUnder1+"' readonly></td>";
					itemDiv += "<td class='alignCenter'>소항목2</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueUnder2List' name='issueUnder2List' value='"+data.issue.issueUnder2+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>소항목3</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueUnder3List' name='issueUnder3List' value='"+data.issue.issueUnder3+"' readonly></td>";
					itemDiv += "<td class='alignCenter'>소항목4</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueUnder4List' name='issueUnder4List' value='"+data.issue.issueUnder4+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>결함번호</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueFlawNumList' name='issueFlawNumList' value='"+data.issue.issueFlawNum+"' readonly></td>";
					itemDiv += "<td class='alignCenter'>영향도</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueEffectList' name='issueEffectList' value='"+data.issue.issueEffect+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>테스트 결과</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueTextResultList' name='issueTextResultList' value='"+data.issue.issueTextResult+"' readonly></td>";
					itemDiv += "<td class='alignCenter'>적용여부</td>";
					itemDiv += "<td><input class='form-control noneForm' type='text' id='issueApplyYnList' name='issueApplyYnList' value='"+data.issue.issueApplyYn+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>확인내용</td>";
					itemDiv += "<td colspan='3'><input class='form-control noneForm' type='text' id='issueConfirmList' name='issueConfirmList' value='"+data.issue.issueConfirm+"' readonly></td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>장애내용</td>";
					itemDiv += "<td colspan='3'>";
					itemDiv += "<div class='obstacleText' style='min-height: 150px; line-height: 30px; padding: 10px;'>"+data.issue.issueObstacle+"</div>";
					itemDiv += "</td>";
					itemDiv += "</tr>";
					itemDiv += "<tr>";
					itemDiv += "<td class='alignCenter'>비고</td>";
					itemDiv += "<td colspan='3'>";
					itemDiv += "<textarea class='form-control' id='issueNoteList' name='issueNoteList' style='min-height: 70px; height: auto; overflow: hidden; width: 100vm !important; background: white; border-radius: 0;' readonly>"+data.issue.issueNote+"</textarea>";
					itemDiv += "</td>";
					itemDiv += "</tr>";
					itemDiv += "</tbody>";
					itemDiv += "</table>";

					itemDiv += "<table style='border-top: none;'>";

					data.issueRelayList.forEach(function(issueRelay) {
						if(issueRelay.issuePrimaryKeyNum == data.issue.issuePrimaryKeyNum) {
							
							itemDiv += "<tr style='height: 50px;'>";
							itemDiv += "<td class='alignCenter'>"+issueRelay.issueRelayType+"</td>";
							if(issueRelay.issueRelayType == '개발') {
								itemDiv += "<td class='statusTd' id='status_"+issueRelay.issueRelayKeyNum+"'>"+issueRelay.issueRelayStatus+"</td>";
							} else {
								itemDiv += "<td style='width: 70px;'></td>";
							}
							itemDiv += "<td style='background-color: white; color: black; line-height: 20px;' id='detail_"+issueRelay.issueRelayKeyNum+"'>";
							itemDiv += issueRelay.issueRelayDetail;
							itemDiv += "</td>";
							itemDiv += "<td style='width: 100px; background: white; border-left: none; text-align: right; white-space: nowrap;'>";
							itemDiv += "<span>"+issueRelay.issueRelayDate+"</span>";
							if(issueRelay.issueRelayType == "개발") {
								itemDiv += "<button class='btn btn-outline-info-nomal myBtn' onClick='btnUpdate("+issueRelay.issueRelayKeyNum+","+issueRelay.issuePrimaryKeyNum+")'>수정</button>";
								itemDiv += "<button class='btn btn-outline-info-del myBtn' onClick='btnDelete("+issueRelay.issueRelayKeyNum+","+issueRelay.issuePrimaryKeyNum+",this)'>삭제</button>";
							}
							itemDiv += "</td>";
							itemDiv += "</tr>";
						}
					});
					itemDiv += "</table>";
					
					itemDiv += "<div style='width: 100%; text-align: right;	padding: 1%;'>";
					itemDiv += "<button type='button' class='btn btn-outline-info-del myBtn' onclick='btnModify("+data.issue.issuePrimaryKeyNum+","+data.issue.issueKeyNum+",this)'>수정완료</button>";
					itemDiv += "<button type='button' class='btn btn-outline-info-add myBtn' onclick='btnRelay("+data.issue.issuePrimaryKeyNum+","+data.issue.issueKeyNum+",this)'>상세답변</button>";
					itemDiv += "</div>";
					itemDiv += "</div>";
					itemDiv += "</dv>";

					itemLi.after(itemDiv);
					$('#div'+data.issue.issuePrimaryKeyNum).hide();
					$('#div'+data.issue.issuePrimaryKeyNum).slideDown(500);
					isAnimating = false;
				},
				error: function(error) {
					console.log(error);
				}
			});
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
			    url: "<c:url value='/issueRelay/relayImprovementsModal'/>",
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

		
		function btnModify(issuePrimaryKeyNum, issueKeyNum, obj) {
			Swal.fire({
				  title: '수정완료!',
				  text: "수정 완료 시, 해당 이슈는 향후 개선 목록에서 사라집니다.",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			 	 if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/issueRelay/improvementsRelay'/>",
	    			    type: 'post',
	    			    data: {
							"issueRelayDetail": "해당 이슈를 수정완료 하였습니다.",
							"issuePrimaryKeyNum": issuePrimaryKeyNum,
							"issueKeyNum": issueKeyNum,
							"issueRelayType": "개발",
							"issueRelayStatus": "해결"
						},
	    			    async: false,
	    			    success: function(result) {
							if(result.result == "OK") {
								Swal.fire({
									icon: 'success',
									title: '답변 완료!',
									html: '개선 항목을 수정 처리하였습니다.',
								}).then((result2) => {
									$("#div"+issuePrimaryKeyNum).remove();
									$("#item"+issuePrimaryKeyNum).remove();
								})
							} else if(result.result == "UrlExport") {
								Swal.fire({               
									icon: 'error',          
									title: '실패!',           
									text: 'URL Export 생성 후 답글 입력 바랍니다.',    
								}); 
							} else {
								Swal.fire({               
									icon: 'error',          
									title: '실패!',           
									text: '작업을 실패했습니다.',    
								});  
							}
						},
						error: function(error) {
							console.log(error);
						}
	    			});
				}
			})
	  	}

		$(document).on('issueRelayComplete', function(event, data) {
			if(data.issueRelayStatus != '향후 개선' && data.issueRelayStatus != '대기') {
				$("#div"+data.issuePrimaryKeyNum).remove();
				$("#item"+data.issuePrimaryKeyNum).remove();
			} else {
				var table = $(exObj).parent();

				var rowItem = "<div class='issue'>";
				rowItem += "<table style='border-top: none;'>";
				rowItem += "<tr style='height: 50px;'>";
				rowItem += "<td class='alignCenter'>개발</td>";
				rowItem += "<td class='statusTd' id='status_"+data.issueRelayKeyNum+"'>"+data.issueRelayStatus+"</td>";
				rowItem += "<td style='background-color: white; color: black; line-height: 20px;' id='detail_"+data.issueRelayKeyNum+"'>";
				rowItem += data.issueRelayDetail;
				rowItem += "</td>";
				rowItem += "<td style='width: 100px; background: white; border-left: none; text-align: right; white-space: nowrap;'>";
				rowItem += "<span>"+getCurrentTime()+" </span>";
				rowItem += "<button class='btn btn-outline-info-nomal myBtn' onClick='btnUpdate("+data.issueRelayKeyNum+","+data.issuePrimaryKeyNum+")'>수정</button>";
				rowItem += "<button class='btn btn-outline-info-del myBtn' onClick='btnDelete("+data.issueRelayKeyNum+","+data.issuePrimaryKeyNum+",this)'>삭제</button>";
				rowItem += "</td>";
				rowItem += "</tr>";
				rowItem += "</table>";
				table.before(rowItem);
			}
		});

		$(document).on('issueRelayCompleteUpdate', function(event, data) {
			$('#status_'+data.issueRelayKeyNum).html(data.issueRelayStatus);
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

		function closeAll() {
			$(".searchbos").slideUp(300, function() {
				$(".searchbos").remove();
			});
		}

		function deleteImprovements(issuePrimaryKeyNum) {
			Swal.fire({
				  title: '수정완료!',
				  text: "해당 이슈는 향후 개선 목록에서 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			 	 if (result.isConfirmed) {
					$.ajax({
						url: "<c:url value='/issueRelay/deleteImprovements'/>",
	    			    type: 'post',
	    			    data: {
							"issueRelayDetail": "해당 이슈를 향후 개선 목록에서 제거 하였습니다.",
							"issuePrimaryKeyNum": issuePrimaryKeyNum,
							"issueRelayType": "개발"
						},
	    			    async: false,
	    			    success: function(result) {
							if(result.result == "OK") {
								Swal.fire({
									icon: 'success',
									title: '삭제 완료!',
									html: '개선 항목을 삭제 처리하였습니다.',
								}).then((result2) => {
									$("#div"+issuePrimaryKeyNum).remove();
									$("#item"+issuePrimaryKeyNum).remove();
								})
							} else if(result.result == "UrlExport") {
								Swal.fire({               
									icon: 'error',          
									title: '실패!',           
									text: 'URL Export 생성 후 답글 입력 바랍니다.',    
								}); 
							} else {
								Swal.fire({               
									icon: 'error',          
									title: '실패!',           
									text: '작업을 실패했습니다.',    
								});  
							}
						},
						error: function(error) {
							console.log(error);
						}
	    			});
				}
			})
		}

		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var issueCustomer = $('#issueCustomer').val();
			var issueTitle = $('#issueTitle').val();

			$('.listLi').hide();
			closeAll();

			$('.listLi').each(function() {
                var customerSerachText = $(this).find('.customerSerach').text();
				var titleSearchText = $(this).find('.titleSearch').text();
                
                if (customerSerachText.includes(issueCustomer)) {
					if(titleSearchText.includes(issueTitle)) {
                    	$(this).show();
					}
                }
            });
		});

		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$('#issueCustomer').val("");
			$('#issueTitle').val("");
			closeAll();
			$('.listLi').show();
			
		});

		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				$('#btnSearch').trigger('click');
			}
		});
	</script>
	<style>
		.scrollToTop {
    	    position: fixed;
    	    bottom: 1%;
    	    right: 1%;
    	    padding: 10px;
    	    background-color: #c58383;
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
			min-width: 750px;
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
				height: 50px !important;
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

		.statusTd {
			width: 70px;
    		text-align: center;
    		background: #c1ac95;
    		color: white;
			font-weight: bold;
		}

		.solveSpan {
			font-size: 18px !important;
    		color: #a50000;
		}
		
		p {
        	padding: 0px;
        }
	</style>
</html>