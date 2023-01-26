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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.slim.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/popper/popper.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bootstrap/js/bootstrap.min.js'/>"></script>
<body>
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
	<!-- progress Modal -->
	<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
	    <div class="modal-dialog" style="margin-top: 15%;">
	        <div class="modal-content">
	            <div class="modal-header" style="background: #B51F1F;">
	                <h3 style="font-weight: bold; font-family: none; color: white;">패키지 다운로드 ...</h3>
	            </div>
	            <div class="modal-body">
	                <!-- progress , bar, percent를 표시할 div 생성한다. -->
	                <div class="progress">
	                    <div class="bar"></div>
	                    <div class="percent">0%</div>
	                </div>
	                <div id="status"></div>
	            </div>
	        </div>
	    </div>
	</div>
</body>
<script>
	function btnDownload(fileName, url) {
		/* progressbar 정보 */
        var bar = $('.bar');
        var percent = $('.percent');
        var status = $('#status');
        
		$.ajax({
	        type: 'GET',
	        url: "<c:url value='/PKG/fileDownload'/>",
	        data: {
	        	"fileName" : fileName,
	        	"url" : url
	        },
            xhrFields: {
	            responseType: "blob",
	        },
	        beforeSend:function(){
                // progress Modal 열기
                $("#pleaseWaitDialog").modal('show');

                status.empty();
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal);

            },
            xhr: function() {
            	var xhr = $.ajaxSettings.xhr();
            	xhr.onprogress = function(evt) {
                    if (evt.lengthComputable) {
                        var percentComplete = Math.floor((evt.loaded / evt.total) * 100);

                        /* Do something with upload progress here */
                        var percentVal = percentComplete + '%';
                        bar.width(percentVal);
                        percent.html(percentVal);
                    }
                };
                return xhr;
            },
			complete:function(){
                // progress Modal 닫기
                $("#pleaseWaitDialog").modal('hide');
                location.reload();
            }
	    }).done(function (blob, status, xhr) {
	        // check for a filename
	        var fileName = "";
	        var disposition = xhr.getResponseHeader("Content-Disposition");

	        if (disposition && disposition.indexOf("attachment") !== -1) {
	            var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
	            var matches = filenameRegex.exec(disposition);

	            if (matches != null && matches[1]) {
	                fileName = decodeURI(matches[1].replace(/['"]/g, ""));
	            }
	        }

	        // for IE
	        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
	            window.navigator.msSaveOrOpenBlob(blob, fileName);
	        } else {
	            var URL = window.URL || window.webkitURL;
	            var downloadUrl = URL.createObjectURL(blob);

	            if (fileName) {
	                var a = document.createElement("a");

	                // for safari
	                if (a.download === undefined) {
	                    window.location.href = downloadUrl;
	                } else {
	                    a.href = downloadUrl;
	                    a.download = fileName;
	                    document.body.appendChild(a);
	                    a.click();
	                }
	            } else {
	                window.location.href = downloadUrl;
	            }
	        }
	    });
			
		
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
	
	th {
		text-align: center;
	}
	
	.progress { position:relative; width:100%; border: 1px solid #ddd; padding: 1px; border-radius: 3px; color: black; }
	.bar { background-color: #337ab7; width:0%; height:30px; border-radius: 3px; }
	.percent { position:absolute; display:inline-block; top:1px; left:48%; }
</style>
</html>