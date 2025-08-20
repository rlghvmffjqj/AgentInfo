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
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	</head>
	<body>
		<div class="modal-body scroll box1" style="width: 100%; height: 685px !important; background: #FCFBFE; display: block;">
			<c:forEach var="item" items="${menuSettingItemList}">
			    <div class="pading5Width1065">
			        <div>
			            <label class="labelFontSize">${item.menuTitleKor}</label>
			        </div>
					<c:choose>
						<c:when test="${item.menuItemType eq 'INT'}">
							<input type="number" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" spellcheck="false" value="${item[item.menuTitle]}" readonly />
						</c:when>
						<c:when test="${item.menuItemType eq 'VARCHAR(500)' or item.menuItemType eq 'VARCHAR(1000)'}">
							<div id="${item.menuTitle}" name="${item.menuTitle}" class="form-control divForm itemAreaDiv  itemArea auto-height pvFont">${item[item.menuTitle]}</div>
						</c:when>
						<c:when test="${item.menuItemType eq 'TEXT'}">
							<div id="${item.menuTitle}" name="${item.menuTitle}" class="form-control divForm itemAreaDiv  itemArea auto-height pvFont">${item[item.menuTitle]}</div>
						</c:when>
						<c:when test="${item.menuItemType eq 'DATE'}">
							<input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" spellcheck="false" value="${item[item.menuTitle]}" readonly />
						</c:when>
						<c:otherwise>
							<input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" value="${item[item.menuTitle]}" readonly />
						</c:otherwise>
					</c:choose>
			    </div>
				<div class="pading5Width1065 page-break"></div>

			</c:forEach>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default btn-outline-info-del" onclick="pdfDownload();">PDF 출력</button>
		    <button type="button" class="btn btn-default btn-outline-info-nomal" onclick="window.close();">닫기</button>
		</div>
	</body>

	<script>
		function pdfDownload() {
		    // 1. 복사본 생성 (원본 DOM 훼손 방지)
    		var bodyClone = document.body.cloneNode(true);
				
    		// 2. modal-footer 제거
    		var footer = bodyClone.querySelector(".modal-footer");
    		if (footer) {
    		    footer.remove();
    		}

			var hiddenDiv = document.createElement('div');
		    hiddenDiv.style.position = 'fixed';
		    hiddenDiv.style.visibility = 'hidden';
		    hiddenDiv.style.height = 'auto';
		    hiddenDiv.style.overflow = 'visible';
		    hiddenDiv.style.width = '690px'; // 실제 출력 너비에 맞게 조정
		    document.body.appendChild(hiddenDiv);

		    hiddenDiv.appendChild(bodyClone);

		    var textareas = bodyClone.querySelectorAll('textarea.auto-height');
		    textareas.forEach(function(textarea) {
		        if (textarea.value.trim().length > 0) {
		            var currentHeight = textarea.offsetHeight;
		            textarea.style.height = (currentHeight + 40) + 'px';
		        }
		    });
		
    		// 3. 필요한 값
    		var extraCSS = `
    		    <style>
    		        .pading5Width1065 {
					    padding: 12px !important;
					    width: 690px;
					    height: auto;
					    display: inline-block;
					}

					.form-control {
    					display: block;
    					width: 100%;
					}

					.form-control {
						padding: .5rem .75rem;
					}
					
					.viewForm {
						width: 665px;
					}

					.divForm {
						width: 665px;
					}

					.pageBreak {
  						page-break-before: always;
					}

    		    </style>
    		`;
			
    		var jsp = extraCSS + bodyClone.innerHTML;
			var packageName = $('#packageName').val();
			hiddenDiv.remove();
			$.ajax({
				url: "<c:url value='/productVersion/pdf'/>",
				type: "POST",
				data: {
						"jsp": jsp,
						"packageName":packageName,
					},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "OK") {
						var fileName = packageName + ".pdf";
						pdfDown(fileName);
					} else {
						alert("PDF Download Error!\n관리자에게 문의 바랍니다.");
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
		}

		function pdfDown(fileName) {
			window.location ="<c:url value='/productVersion/fileDownload?fileName="+fileName+"'/>";
			setTimeout(function() {
				fileDelete(fileName);
			},300);
		}

		function fileDelete(fileName) {
			$.ajax({
				url: "<c:url value='/productVersion/fileDelete'/>",
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
	<style>
		body {
			background-color: white !important;
			overflow: hidden;
		}

		.scroll{
		  display: inline-block;
		  height: 710px !important;  
		  overflow-x: hidden;
		  overflow-y: scroll !important;
		  box-sizing: border-box;
		  /* max-height: 770px; */
		}

		/* 스크롤바 막대 설정*/
		.box1::-webkit-scrollbar-thumb{
		  background-color: #8500005e;
		  /* 스크롤바 둥글게 설정    */
		  border-radius: 10px; 
		}

		.box1::-webkit-scrollbar {
		  width: 7px;  /* 세로 스크롤 두께 */
		  height: 12px; /* 가로 스크롤 두께 */
		}

		.itemArea {
			min-height: 50px;
			border: 1px solid #dab17d !important;
			resize: none;
	  		line-height: 1.5;
			font-size: 12px !important;
	    	margin-bottom: -3px;
		}

		.itemArea:hover {
			border: 1px solid #ffa700 !important;
		}


		div {
	        width: 100%;
	        /* overflow: hidden; 스크롤바 숨김 */
	    }

		.pvFont {
			font-size: 13px !important;
			color: black !important;
			line-height: 2 !important;
			border: 1px solid #dab17d !important;
		}

		.form-control {
			background: white !important;
		}

		.page-break {
		   page-break-before: always; /* 이 블록 앞에서 끊어라 */
		}
		
		.itemAreaDiv {
		    white-space: pre-wrap;   /* 줄바꿈 유지 */
		    word-wrap: break-word;   /* 긴 단어 줄바꿈 */
		    border: 1px solid #dab17d;
		    padding: 8px;
		    font-size: 12px;
		    line-height: 1.5;
		    min-height: 50px;
		    background-color: white;
		}

		.pading5Width1065 {
			padding: 5px;
		}

	</style>
</html>