<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
</head>
<title>Secuve PKG Download</title>

<!-- Favicon -->
<link rel="icon" href="<c:url value='/images/favicon.png'/>" type="image/x-icon">
<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.slim.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.min.js'/>"></script>
<body>
	<div id="loadImage" class="loding">
		<img src="/AgentInfo/images/loding.gif" style="width:100px; height:100px;">
	</div>
	<div style="text-align: center; margin-top: 15%;">
		<table style="margin-left: auto; margin-right: auto; margin-bottom: 50px;">
			<tr>
				<td><img class="img-fluid" src="/AgentInfo/images/favicon.png" alt="Theme-Logo"></td>
				<td><span style="font-size: 20px; font-weight: bold; font-family: emoji;">Secuve Package Download</span></td>
			</tr>
		</table>
		<table style="margin-left: auto; margin-right: auto;">
			<tr>
				<th style="width:290px; font-family: emoji;">패키지명</th>
				<th style="width:250px; font-family: emoji;">다운로드 가능 기간</th>
				<th style="width:150px; font-family: emoji;">다운로드 횟수</th>
				<th style="width:150px; font-family: emoji;">다운로드</th>
			</tr>
			<c:forEach var="item" items="${list}">
				<tr>
					<td>${item.sendPackageName}</td>
					<td>${item.sendPackageStartDate} ~ ${item.sendPackageEndDate}</td>
					<td>${item.sendPackageCount}/${item.sendPackageLimitCount}</td>
					<td><button onClick="btnDownload('${item.sendPackageName}','${item.sendPackageRandomUrl}')"> 패키지 다운로드</button></td>
				<tr>
			</c:forEach>
		</table>
	</div>
</body>
<script>
	function btnDownload(fileName, url) {
		$('#loadImage').show();
		$(".overlay").show();
		setTimeout(() => {
			$.ajax({
	            type: 'GET',
	            url: "<c:url value='/PKG/fileDownload'/>",
	            data: {
	            	"fileName" : fileName,
	            	"url" : url
	            },
	            async: false,
	            success: function () {
	            	$('#loadImage').css('display','block');
	            	window.location ="<c:url value='/PKG/fileDownload?fileName="+fileName+"&&url="+url+"'/>";
	            },
	            error: function(e) {
	            	Swal.fire(
					  '에러!',
					  '에러가 발생하였습니다.',
					  'error'
					)
	            }
	        });
			
			$.ajax({
	            type: 'post',
	            url: "<c:url value='/PKG/downloadCount'/>",
	            data: {
	            	"sendPackageName" : fileName,
	            	"sendPackageRandomUrl" : url
	            },
	            async: false,
	            success: function () {
	            	location.reload();
	            },
	            error: function(e) {
	            	Swal.fire(
					  '에러!',
					  '에러가 발생하였습니다.',
					  'error'
					)
	            }
	        });
		}, "100");
		
	}
</script>
<style>
	.loding {
		position: absolute;
	    width: 99%;
	    height: 0px;
	    z-index: 9999;
	    text-align: center;
	    display: none;
	}
</style>
</html>