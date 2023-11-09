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
		<table style="width: 100%;">
			<tr>
				<td class="blue-text">1</td>
				<td>2</td>
			</tr>
			<tr>
				<td>3</td>
				<td>4</td>
			</tr>
		</table>
	</body>
	<script>
		$(document).ready(function() {
		    var jsp = $('body').clone().find('script').remove().end().html();
			$.ajax({
				url: "<c:url value='/functionTest/word'/>",
				type: "POST",
				data: {
						"jsp": jsp,
					},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "OK") {
						var fileName = "document.docx";
						opener.pdfDown(fileName);
						//window.close();
					} else {
						alert("PDF Download Error!\n관리자에게 문의 바랍니다.");
						//window.close();
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
		});
	</script>
</html>