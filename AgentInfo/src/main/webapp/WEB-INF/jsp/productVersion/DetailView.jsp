<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>패키지 상세 조회</title>
<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
<div class="modal-body scroll box1" style="width: 100%; height: 685px !important; background: #9ba6c30f;">
	<form id="modalForm" name="form" method ="post">
		<c:forEach var="item" items="${menuSettingItemList}">
		    <div class="pading5Width1065">
		        <div>
		            <label class="labelFontSize">${item.menuTitleKor}</label>
		        </div>
				<c:choose>
					<c:when test="${item.menuItemType eq 'INT'}">
						<input type="number" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" spellcheck="false" value="${item[item.menuTitle]}" readonly>
					</c:when>
					<c:when test="${item.menuItemType eq 'VARCHAR(500)' or item.menuItemType eq 'VARCHAR(1000)'}">
						<textarea id="${item.menuTitle}" name="${item.menuTitle}" class="form-control itemArea auto-height pvFont" spellcheck="false" oninput="autoResize(this)" readonly>${item[item.menuTitle]}</textarea>
					</c:when>
					<c:when test="${item.menuItemType eq 'TEXT'}">
						<textarea id="${item.menuTitle}" name="${item.menuTitle}" class="form-control itemArea auto-height pvFont" spellcheck="false" oninput="autoResize(this)" readonly>${item[item.menuTitle]}</textarea>
					</c:when>
					<c:when test="${item.menuItemType eq 'DATE'}">
						<input type="date" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" spellcheck="false" value="${item[item.menuTitle]}" readonly>
					</c:when>
					<c:otherwise>
						<input type="text" id="${item.menuTitle}" name="${item.menuTitle}" class="form-control viewForm pvFont" value="${item[item.menuTitle]}" readonly>
					</c:otherwise>
				</c:choose>
		    </div>
		</c:forEach>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default btn-outline-info-del">PDF 출력</button>
    <button type="button" class="btn btn-default btn-outline-info-nomal" onclick="window.close();">닫기</button>
</div>

<script>
	function autoResize(textarea) {
	    $(textarea).css('height', 'auto');
	    $(textarea).css('height', textarea.scrollHeight + 'px');
	}
	
	$(function () {
  $('textarea.auto-height').each(function () {
    autoResize(this);
  });
});
	
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

	.form-control:disabled, .form-control[readonly] {
		background: white !important;
	}
</style>