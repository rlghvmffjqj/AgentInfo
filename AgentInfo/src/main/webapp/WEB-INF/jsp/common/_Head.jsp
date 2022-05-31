<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<title>AgentInfo</title>

<meta charset="utf-8">
<meta name="_csrf" th:content="${_csrf.token}"/>
<meta name="_csrf_header" th:content="${_csrf.headerName}"/>

<!-- Favicon -->
<link rel="icon" href="<c:url value='/images/favicon.png'/>" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/icon/themify-icons/themify-icons.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/icon/icofont/css/icofont.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/icon/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery.mCustomScrollbar.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/myStyle.css'/>">

<!-- jqGrid UI -->
<link href="<c:url value='/jquery-ui-1.13.1.custom/jquery-ui.min.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<c:url value='/jqGrid/css/ui.jqgrid.css'/>">

<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.slim.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.cookie.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.bpopup.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/myJS.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/postcode.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/sweetalert.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui/jquery-ui.min.js'/>"></script>   
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.serializeObject.js'/>"></script>    

<!-- jqGrid -->
<script type="text/javascript" src="<c:url value='/jqGrid/js/i18n/grid.locale-en.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jqGrid/js/jquery.jqGrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jqGrid/js/grid.setcolumns.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jqGrid/js/jqgrid.extends.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jqGrid/js/jquery.fileDownload.js'/>"></script>

<script type="text/javascript" src="<c:url value='/jqGrid/js/jquery.json-2.3.min.js'/>"></script>   
<script type="text/javascript" src="<c:url value='/js/popper/popper.min.js'/>"></script>     
<script type="text/javascript" src="<c:url value='/js/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/widget/excanvas.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/waves/js/waves.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-slimscroll/jquery.slimscroll.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/chart/chart.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/chart/chartjs-plugin-datalabels@2.0.0.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/SmoothScroll.js'/>"></script>     
<script type="text/javascript" src="<c:url value='/js/common-pages.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/pcoded.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vertical-layout.min.js'/>"></script>

<!-- Bootstrap Select Box -->
<script type="text/javascript" src="<c:url value='/js/select/bootstrap-select.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/select/bootstrap-select.css'/>">

<!-- dynatree -->
<script type="text/javascript" src="<c:url value='/js/dynatree/jquery.dynatree.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/dynatree/skin-vista/ui.dynatree.css'/>">

<!-- SummerNote -->
<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
