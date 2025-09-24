<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- datetimepicker -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/datetimepicker/jquery.datetimepicker.min.css'/>">
		<script type="text/javascript" src="<c:url value='/datetimepicker/jquery.datetimepicker.full.min.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/myStyle.css'/>">
		
	</head>

	<div class="modal-body scroll box1" style="width: 100%; height: auto; background-color: white;">
		<form id="modalForm" name="form" method ="post">
			<c:forEach var="item" items="${menuSettingItemList}">
			    <div class="pading5Width1270">
			        <div>
			            <label class="labelFontSize">${item.menuTitleKor}</label>
						<c:if test="${item.menuRequired eq 'on'}"><label style="color: red; margin-top: 5px">*</label></c:if>
			        </div>
					<c:choose>
						<c:when test="${item.menuItemType eq 'INT'}">
							<input type="number" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" placeholder="0" spellcheck="false" <c:if test="${viewType == 'update' || viewType == 'im'}">value="${item[item.menuTitle]}"</c:if> <c:if test="${item.menuRequired eq 'on'}">required</c:if>>
						</c:when>
						<c:when test="${item.menuItemType eq 'VARCHAR(500)' or item.menuItemType eq 'VARCHAR(1000)'}">
							<textarea id="${item.menuTitle}" name="${item.menuTitle}" class="form-control itemArea auto-height pvFont" placeholder="${item.menuTitleKor}" spellcheck="false" oninput="autoResize(this)" <c:if test="${item.menuRequired eq 'on'}">required</c:if>><c:if test="${viewType == 'update' || viewType == 'im'}">${item[item.menuTitle]}</c:if></textarea>
						</c:when>
						<c:when test="${item.menuItemType eq 'TEXT'}">
							<textarea id="${item.menuTitle}" name="${item.menuTitle}" class="form-control itemArea auto-height pvFont" placeholder="${item.menuTitleKor}" spellcheck="false" oninput="autoResize(this)" <c:if test="${item.menuRequired eq 'on'}">required</c:if>><c:if test="${viewType == 'update' || viewType == 'im'}">${item[item.menuTitle]}</c:if></textarea>
						</c:when>
						<c:when test="${item.menuItemType eq 'DATE'}">
							<input type="date" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" placeholder="0" spellcheck="false" <c:if test="${viewType == 'update' || viewType == 'im'}">value="${item[item.menuTitle]}"</c:if> <c:if test="${item.menuRequired eq 'on'}">required</c:if>>
						</c:when>
						<c:otherwise>
							<input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" placeholder="${item.menuTitleKor}" <c:if test="${viewType == 'update' || viewType == 'im'}">value="${item[item.menuTitle]}"</c:if> <c:if test="${item.menuRequired eq 'on'}">required</c:if>>
						</c:otherwise>
					</c:choose>
			    </div>
			</c:forEach>
		</form>
	</div>
	<div class="modal-footer">
	    <button class="btn btn-default btn-outline-info-nomal" id="closePopupBtn">닫기</button>
	</div>
</html>

<script>
    function autoResize(textarea) {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';
    }

    // 페이지 로드 완료 후 모든 textarea 높이 조절
    window.addEventListener('load', function() {
        document.querySelectorAll('textarea.auto-height').forEach(function(ta) {
            autoResize(ta);

            // 입력 시 자동 높이
            ta.addEventListener('input', function() {
                autoResize(this);
            });
        });
    });

	 $('#closePopupBtn').on('click', function() {
        window.close(); // 현재 팝업창 닫기
    });
</script>


<style>
	.scroll{
	  display: inline-block;
	  height: 633px !important;  
	  overflow-x: hidden;
	  box-sizing: border-box;
	  max-height: 770px;
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
		min-height: 100px;
		border: 1px solid #dab17d !important;
		resize: none;
  		line-height: 1.5;
		font-size: 12px !important;
    	margin-bottom: -3px;
	}

	.itemArea:hover {
		border: 1px solid #ffa700 !important;
	}


	textarea {
        width: 100%;
        box-sizing: border-box;
        overflow: hidden; /* 스크롤바 숨김 */
        resize: none; /* 사용자가 수동으로 크기 조절하지 못하게 함 */
    }

	.pvFont {
		font-size: 13px !important;
		color: black !important;
		line-height: 2 !important;
	}
	
	.pading5Width1270 {
		width: 970px !important;
	}

</style>