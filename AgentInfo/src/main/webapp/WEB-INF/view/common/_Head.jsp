<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<title>AgentInfo</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Mega Able Bootstrap admin template made using Bootstrap 4 and it has huge amount of ready made feature, UI components, pages which completely fulfills any dashboard needs.">
<meta name="keywords" content="bootstrap, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive">
<meta name="author" content="codedthemes">

<meta name="_csrf" th:content="${_csrf.token}"/>
<meta name="_csrf_header" th:content="${_csrf.headerName}"/>

<link rel="icon" href="<c:url value='/images/favicon.png'/>" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/pages/waves/css/waves.min.css" type="text/css'/>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/icon/themify-icons/themify-icons.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/icon/icofont/css/icofont.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/icon/font-awesome/css/font-awesome.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/google/font.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery.mCustomScrollbar.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/amcharts/export.css'/>" media="all">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/myStyle.css'/>">
<!-- jqGrid -->
<link href="<c:url value='/jquery-ui-1.13.1.custom/jquery-ui.min.css'/>" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<c:url value='/jqGrid/css/ui.jqgrid.css'/>">


<script type="text/javascript" src="<c:url value='/js/jquery/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.cookie.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.bpopup.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/myJS.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/sweetalert.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui/jquery-ui.min.js'/>"></script>   
<script type="text/javascript" src="<c:url value='/js/jquery/jquery.serializeObject.js'/>"></script>    

<!-- jqGrid -->
<script type="text/javascript" src="<c:url value='/jqGrid/js/i18n/grid.locale-kr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/jqGrid/js/jquery.jqGrid.min.js'/>"></script>     
  
<script type="text/javascript" src="<c:url value='/js/popper.js/popper.min.js'/>"></script>     
<script type="text/javascript" src="<c:url value='/js/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/widget/excanvas.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/waves/js/waves.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/modernizr/modernizr.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-slimscroll/jquery.slimscroll.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/chart.js/Chart.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/SmoothScroll.js'/>"></script>     
<script type="text/javascript" src="<c:url value='/js/amcharts/amcharts.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/widget/amchart/gauge.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/widget/amchart/serial.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/widget/amchart/light.js'/>"></script>
<script type="text/javascript" src="<c:url value='/pages/widget/amchart/pie.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/amcharts/export.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common-pages.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/pcoded.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/vertical-layout.min.js'/>"></script>




<script type="text/javascript" src="<c:url value='/js/amcharts/fabric.min.js'/>" async=""></script>
<script type="text/javascript" src="<c:url value='/js/amcharts/FileSaver.min.js'/>" async=""></script>
<script type="text/javascript" src="<c:url value='/js/amcharts/jszip.min.js'/>" async=""></script>
<script type="text/javascript" src="<c:url value='/js/amcharts/pdfmake.min.js'/>" async=""></script>
<script type="text/javascript" src="<c:url value='/js/amcharts/xlsx.min.js'/>" async=""></script>
<script type="text/javascript" src="<c:url value='/js/amcharts/vfs_fonts.js'/>" async=""></script>

