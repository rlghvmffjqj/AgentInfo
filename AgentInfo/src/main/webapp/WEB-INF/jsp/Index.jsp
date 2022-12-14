<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths"><head>
<head>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <script>
	    $(function() {
	    	$.cookie('name','home');
	    });
    </script>
    <script>
		$(document).ready(function(){
			$("#list").jqGrid({
				url: "<c:url value='/packages'/>",
				mtype: 'POST',
				datatype: 'json',
				caption: '최근 배포 패키지',
				colNames:['Key','고객사 명','사업명','전달일자','패키지 종류','일반/커스텀','Agent ver','패키지명','담당자','OS종류'],
				colModel:[
					{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 25, hidden:true },
					{name:'customerName', index:'customerName', align:'center', width: 190},
					{name:'businessName', index:'businessName', align:'center', width: 180},
					{name:'deliveryData', index:'deliveryData',align:'center', width: 70},
					{name:'managementServer', index:'managementServer', align:'center', width: 80},
					{name:'generalCustom', index:'generalCustom', align:'center', width: 60},
					{name:'agentVer', index:'agentVer', align:'center', width: 170},
					{name:'packageName', index:'packageName', align:'center', width: 630},
					{name:'manager', index:'manager', align:'center', width: 80},
					{name:'osType', index:'osType', align:'center', width: 80},
				],
				jsonReader : {
		        	id: 'packagesKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 15,					// 보여중 행의 수
		        sortname: 'packagesKeyNum',	// 기본 정렬 
		        sortorder: 'desc',			// 정렬 방식
		        
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: false,			// 컬럼을 마우스 순서 변경
		        loadonce: false,
		        height : '410',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: false,			// 컬럼 폭 고정값 유지
		        altRows: false,				// 라인 강조
			}); 
			
		});
		$(window).on('resize.list', function () {
		    jQuery("#list").jqGrid( 'setGridWidth', $(".indexTable").width() );
		});
	</script>
    
</head>
<body themebg-pattern="theme1">
  <div id="pcoded" class="pcoded iscollapsed">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
      	  <%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
          <%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
          <div class="pcoded-main-container" style="margin-top: 56px;">
              <div class="pcoded-wrapper">
                  <%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
                  <div class="pcoded-content" id="page-wrapper">
                      <div class="page-header">
                          <div class="page-block">
                              <div class="row align-items-center">
                                  <div class="col-md-8">
                                      <div class="page-header-title">
                                          <h5 class="m-b-10">대시보드</h5>
                                          <p class="m-b-0">Welcome chart & table dashboard</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="#!"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">Dashboard</a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                          </div>
                      </div>
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <div class="row">
                                            <div class="firstCahrt">
                                            	<div class="margin-1" style="position: relative; height:34vh; width:19vw;">
													<!--차트가 그려질 부분-->
													<select class="form-control selectForm chartYear" id="managementServerYear" name="managementServerYear" size="1"></select>
													<canvas id="managementServer"></canvas>
												</div>
											</div>
											<div class="firstCahrt">
                                            	<div class="margin-1" style="position: relative; height:34vh; width:19vw;">
													<!--차트가 그려질 부분-->
													<select class="form-control selectForm chartYear" id="osTypeYear" name="osTypeYear" size="1"></select>
													<canvas id="osType"></canvas>
												</div>
											</div>
											<div class="firstCahrt">
                                            	<div class="margin-1" style="position: relative; height:34vh; width:19vw;">
													<!--차트가 그려질 부분-->
													<select class="form-control selectForm chartYear" id="requestProductCategoryYear" name="requestProductCategoryYear" size="1"></select>
													<canvas id="requestProductCategory"></canvas>
												</div>
											</div>
											<div class="firstCahrt">
                                            	<div class="margin-1" style="position: relative; height:34vh; width:19vw;">
													<!--차트가 그려질 부분-->
													<canvas id="agentVer"></canvas>
												</div>
											</div>
											<div class="secondCahrt">
                                            	<div class="margin-1" style="position: relative; height:25.5vh; width:51vw;">
													<!--차트가 그려질 부분-->
													<select class="form-control selectForm chartYear" id="deliveryDataYear" name="deliveryDataYear" size="1"></select>
													<canvas class="deliveryData"></canvas>
												</div>
											</div>
											
											<div class="middleCahrt">
                                            	<div class="margin-1" style="position: relative; height:27vh; width:28vw;">
												<!--차트가 그려질 부분-->
												<select class="form-control selectForm chartYear" id="customerNameYear" name="customerNameYear" size="1"></select>
												<canvas id=customerName></canvas>
												</div>
											</div>

                                            <div class="indexTable">
	                                            <!------- Grid ------->
												<div class="jqGrid_wrapper">
													<table id="list"></table>
													<div id="pager"></div>
												</div>
												<!------- Grid ------->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>
<script>
	$(function() {
		var date = new Date();
		$('#managementServerYear').append("<option value='전체' selected>전체</option>");
		$('#osTypeYear').append("<option value='전체' selected>전체</option>");
		$('#requestProductCategoryYear').append("<option value='전체' selected>전체</option>");
		$('#customerNameYear').append("<option value='전체' selected>전체</option>");
		for(var y = date.getFullYear(); y >= 2014; y--) {
			$('#deliveryDataYear').append("<option value='"+y+"'>"+y+"년"+"</option>");
			$('#managementServerYear').append("<option value='"+y+"'>"+y+"년"+"</option>");
			$('#osTypeYear').append("<option value='"+y+"'>"+y+"년"+"</option>");
			$('#requestProductCategoryYear').append("<option value='"+y+"'>"+y+"년"+"</option>");
			$('#customerNameYear').append("<option value='"+y+"'>"+y+"년"+"</option>");
		}
		$('#deliveryDataYear option:eq(0)').prop("selected", true);
	});
	
	/* =========== 패키지 배포 현황(~현재) ========= */
	var managementServer;
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/packages/chart/managementServer'/>",
	    async: false,
	    success: function (data) {
	    	managementServer = data;
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});	
	
	var ctx = document.getElementById('managementServer').getContext('2d');
	var managementServerChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: ['관리서버', 'Agent', 'Portal', 'TOSRF', '기타'],
	        datasets: [{
	            label: 'Bar',
	            data: managementServer,
	            backgroundColor: [
	                'rgba(255, 127, 14, 0.6)',
	                'rgba(230, 64, 50, 0.6)',
	                'rgba(255, 206, 86, 0.6)',
	                'rgba(75, 192, 192, 0.6)',
	                'rgba(153, 102, 255, 0.6)',
	                'rgba(255, 159, 64, 0.6)'
	            ],
	            borderColor: [
	                'rgba(255, 127, 14, 1)',
	                'rgba(230, 64, 50, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: false,
	    	plugins: {
	            title: {
	              display: true,
	              text: '패키지 배포 현황(~현재)'
	            },
	            legend: {
		            display: false
		        },
	        },
	        
	    	indexAxis: 'y',
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
	
	$("#managementServerYear").change(function() {
		var managementServerYear = $('#managementServerYear').val();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/chart/managementServer'/>",
		    async: false,
		    data:{"managementServerYear" : managementServerYear},
		    success: function (data) {
		    	managementServer = data;
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
		var dataset = managementServerChart.data.datasets;
		for(var i=0; i<dataset.length; i++){
			//데이터 갯수 만큼 반복
			var data = dataset[i].data;
			for(var j=0 ; j < data.length ; j++){
				data[j] = managementServer[j];
			}
		}
		if(managementServerYear == "전체") {
			managementServerChart.options.plugins.title.text = '패키지 배포 현황(~현재)';
		} else {
			managementServerChart.options.plugins.title.text = '패키지 배포 현황('+managementServerYear+'년)';
		}
		managementServerChart.update();
	});
</script>
<script>
	var osType;
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/packages/chart/osType'/>",
	    async: false,
	    success: function (data) {
	    	osType = data;
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});	

	/* =========== OS종류 별 Agent 배포현황(~현재) ========= */
	var ctx = document.getElementById('osType').getContext('2d');
	var osTypeChart = new Chart(ctx, {
		plugins: [ChartDataLabels],
	    type: 'doughnut',
	    data: {
	        labels: ['Linux', 'Windows', 'HP-UX', 'AIX', 'Solaris'],
	        datasets: [{
	            label: 'OS종류 별 Agent 배포현황(~현재)',
	            data: osType,
	            backgroundColor: [
	                'rgba(255, 127, 14, 0.6)',
	                'rgba(230, 64, 50, 0.6)',
	                'rgba(255, 206, 86, 0.6)',
	                'rgba(75, 192, 192, 0.6)',
	                'rgba(153, 102, 255, 0.6)',
	                'rgba(255, 159, 64, 0.6)'
	            ],
	            borderColor: [
	                'rgba(255, 127, 14, 1)',
	                'rgba(230, 64, 50, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: false,
	        plugins: {
	        	datalabels:{
	        		formatter: function(value, context) {
	        			var percentage;
	        			let datasets = context.chart.data.datasets[0].data;
		                if (value!=0 ) {
		                    var sum = 0;
		                    dataArr = context.chart.data.datasets[0].data;
		                    dataArr.map(data => {
		                        sum += parseInt(data);
		                    });
		                    percentage = Math.round((value*100 / sum));
		                }
		                if(percentage >= 0) {
	        	        	return context.chart.data.labels[context.dataIndex] + "\n" + percentage + "%";
		                } else {
		                	return "";
		                }
	        	    
	              },
	              anchor :'center',
	              align:'center',
	              textAlign: "center",
		        },
	            title: {
	              display: true,
	              text: 'OS종류 별 Agent 배포현황(~현재)'
	            }
	        }
	    }
	});
	
	$("#osTypeYear").change(function() {
		var osTypeYear = $('#osTypeYear').val();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/chart/osType'/>",
		    async: false,
		    data:{"osTypeYear" : osTypeYear},
		    success: function (data) {
		    	osType = data;
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
		var dataset = osTypeChart.data.datasets;
		for(var i=0; i<dataset.length; i++){
			//데이터 갯수 만큼 반복
			var data = dataset[i].data;
			for(var j=0 ; j < data.length ; j++){
				data[j] = osType[j];
			}
		}
		if(osTypeYear == "전체") {
			osTypeChart.options.plugins.title.text = 'OS종류 별 Agent 배포현황(~현재)';
		} else {
			osTypeChart.options.plugins.title.text = 'OS종류 별 Agent 배포현황('+osTypeYear+'년)';
		}
		osTypeChart.update();
	});
</script>
<script>
	var osType;
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/packages/chart/requestProductCategory'/>",
	    async: false,
	    success: function (data) {
	    	requestProductCategory = data;
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});	
	
	/* =========== Agent 종류별 배포현황(~현재) ========= */
	var ctx = document.getElementById('requestProductCategory').getContext('2d');
	var requestProductCategoryChart = new Chart(ctx, {
		plugins: [ChartDataLabels],
	    type: 'doughnut',
	    data: {
	        labels: ['TOS 5.0', 'TOS 3.0', 'TOS 2.0.60.X', 'TOS 2.0.70.X', 'iGRIFFIN 5.0'],
	        datasets: [{
	            label: 'Agent 종류별 배포현황(~현재)',
	            data: requestProductCategory,
	            backgroundColor: [
	                'rgba(255, 127, 14, 0.6)',
	                'rgba(230, 64, 50, 0.6)',
	                'rgba(255, 206, 86, 0.6)',
	                'rgba(75, 192, 192, 0.6)',
	                'rgba(153, 102, 255, 0.6)',
	                'rgba(255, 159, 64, 0.6)'
	            ],
	            borderColor: [
	                'rgba(255, 127, 14, 1)',
	                'rgba(230, 64, 50, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1,
	        }]
	    },
	    
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: false,
	        plugins: {
	        	datalabels:{
	        		formatter: function(value, context) {
	        			var percentage;
	        			let datasets = context.chart.data.datasets[0].data;
		                if (value!=0 ) {
		                    var sum = 0;
		                    dataArr = context.chart.data.datasets[0].data;
		                    dataArr.map(data => {
		                        sum += parseInt(data);
		                    });
		                    percentage = Math.round((value*100 / sum));
		                }
		                if(percentage >= 0) {
	        	        	return context.chart.data.labels[context.dataIndex] + "\n" + percentage + "%";
		                } else {
		                	return "";
		                }
	        	    
	              },
	              anchor :'center',
	              align:'center',
	              textAlign: "center",
		        },
			    title: {
		            display: true,
		            text: 'Agent 종류별 배포현황(~현재)'
		         }
	   	 	}
	    }
	});
	
	$("#requestProductCategoryYear").change(function() {
		var requestProductCategoryYear = $('#requestProductCategoryYear').val();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/chart/requestProductCategory'/>",
		    async: false,
		    data:{"requestProductCategoryYear" : requestProductCategoryYear},
		    success: function (data) {
		    	requestProductCategory = data;
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
		var dataset = requestProductCategoryChart.data.datasets;
		for(var i=0; i<dataset.length; i++){
			//데이터 갯수 만큼 반복
			var data = dataset[i].data;
			for(var j=0 ; j < data.length ; j++){
				data[j] = requestProductCategory[j];
			}
		}
		if(requestProductCategoryYear == "전체") {
			requestProductCategoryChart.options.plugins.title.text = 'Agent 종류별 배포현황(~현재)';
		} else {
			requestProductCategoryChart.options.plugins.title.text = 'Agent 종류별 배포현황('+requestProductCategoryYear+'년)';
		}
		requestProductCategoryChart.update();
	});
</script>
<script>
	var agentName;
	var agentCount;
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/packages/chart/agentVer'/>",
	    async: false,
	    success: function (data) {
	    	agentName = data.name;
	    	agentCount = data.count;
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});	

	/* =========== OS종류 별 최다 배포 Agent 버전 (최근 3개월) ========= */
	var ctx = document.getElementById('agentVer').getContext('2d');
	var agentVer = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: agentName,
	        datasets: [{
	            label: 'Bar',
	            data: agentCount,
	            backgroundColor: [
	                'rgba(255, 127, 14, 0.6)',
	                'rgba(230, 64, 50, 0.6)',
	                'rgba(255, 206, 86, 0.6)',
	                'rgba(75, 192, 192, 0.6)',
	                'rgba(153, 102, 255, 0.6)',
	                'rgba(255, 159, 64, 0.6)'
	            ],
	            borderColor: [
	                'rgba(255, 127, 14, 1)',
	                'rgba(230, 64, 50, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: false,
	    	plugins: {
	            title: {
	              display: true,
	              text: 'OS종류별 최다 배포 Agent 버전 (최근 3개월)'
	            },
	            legend: {
		            display: false
		        },
	        },
	    	indexAxis: 'y',
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
</script>
<script>
	var deliveryData;
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/packages/chart/deliveryData'/>",
	    async: false,
	    success: function (data) {
	    	deliveryData = data;
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});	
	/* =========== 월별 배포 현황 (금년) ========= */
	const mydata = deliveryData;
	const mydataHalf = deliveryData;
	var ctx = document.getElementsByClassName("deliveryData");
	var date = new Date();
	
	var mixedChart = {
	  type: 'bar',
	  labels: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월',],
	  datasets : [
	    {
	      label: 'Bar',
	      data : mydata,
	      backgroundColor: 'rgba(256, 0, 0, 0.1)'
	    },
	    {
	      label: 'Line',
	      data: mydataHalf,
	      backgroundColor: 'transparent',
	      borderColor: 'skyblue',
	      type: 'line'
	    }
	  ]
	  };
	  var deliveryDataChart = new Chart(ctx, {
	    type: 'bar',
	    data: mixedChart,
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: false,
	    	plugins: {
	            title: {
	              display: true,
	              text: '월별 배포 현황 ('+date.getFullYear()+'년)'
	            },
	            legend: {
		            display: false
		        },
	          },
	    }
	 });
	 
	  /* =========== 월별 배포 현황 (금년) - 년도 변경 ========= */
	 $("#deliveryDataYear").change(function() {
		var deliveryDataYear = $('#deliveryDataYear').val();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/chart/deliveryData'/>",
		    async: false,
		    data:{"deliveryDataYear" : deliveryDataYear},
		    success: function (data) {
		    	deliveryData = data;
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
		var dataset = mixedChart.datasets;
		for(var i=0; i<dataset.length; i++){
			//데이터 갯수 만큼 반복
			var data = dataset[i].data;
			for(var j=0 ; j < data.length ; j++){
				data[j] = deliveryData[j];
			}
		}
		deliveryDataChart.options.plugins.title.text = '월별 배포 현황 ('+deliveryDataYear+'년)';
		deliveryDataChart.update();
	});
</script>
<script>
	var customerName;
	var customerCount;
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/packages/chart/customerName'/>",
	    async: false,
	    success: function (data) {
	    	customerName = data.name;
	    	customerCount = data.count;
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});	
	/* =========== 고객사별 패키지 배포 수량 TOP 7 (~현재) ========= */
	var ctx = document.getElementById('customerName').getContext('2d');
	var customerNameChart = new Chart(ctx, {
		plugins: [ChartDataLabels],
	    type: 'bar',
	    data: {
	        labels: customerName,
	        datasets: [{
	            label: 'Bar',
	            data: customerCount,
	            backgroundColor: [
	                'rgba(255, 127, 14, 0.6)',
	                'rgba(230, 64, 50, 0.6)',
	                'rgba(255, 206, 86, 0.6)',
	                'rgba(75, 192, 192, 0.6)',
	                'rgba(153, 102, 255, 0.6)',
	                'rgba(255, 159, 64, 0.6)'
	            ],
	            borderColor: [
	                'rgba(255, 127, 14, 1)',
	                'rgba(230, 64, 50, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: false,
	    	plugins: {
	    		datalabels:{
	        		formatter: function(value, context) {
	        	       return "  " + value + " 건";
	              },
	              align:'right',
	              anchor :'end',
		        },
	            title: {
	              display: true,
	              text: '고객사별 패키지 배포 수량 TOP 7 (~현재)'
	            },
	            legend: {
		            display: false
		        },
	        },
	    	indexAxis: 'y',
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
	
	$("#customerNameYear").change(function() {
		var customerNameYear = $('#customerNameYear').val();
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/chart/customerName'/>",
		    async: false,
		    data:{"customerNameYear" : customerNameYear},
		    success: function (data) {
		    	customerName = data.name;
		    	customerCount = data.count;
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
		var dataset = customerNameChart.data.datasets;
		for(var i=0; i<dataset.length; i++){
			//데이터 갯수 만큼 반복
			var data = dataset[i].data;
			for(var j=0 ; j < data.length ; j++){
				data[j] = customerCount[j];
			}
		}
		if(customerNameYear == "전체") {
			customerNameChart.options.plugins.title.text = '고객사별 패키지 배포 수량 TOP 7 (~현재)';
		} else {
			customerNameChart.options.plugins.title.text = '고객사별 패키지 배포 수량 TOP 7 ('+customerNameYear+'년)';
		}
		customerNameChart.data.labels = customerName;
		customerNameChart.update();
	});
	
	/* =========== 공지사항 Modal ========= */
	$(function() {
		<sec:authorize access="hasRole('ADMIN')">
			if(!$.cookie('notice')) {
				$.ajax({
			        type: 'POST',
			        url: "<c:url value='/requests/notice'/>",
			        async: false,
			        success: function (data) {
			        	if(data.indexOf("<!DOCTYPE html>") != -1) 
							location.reload();
			            $.modal(data, 'notice'); //modal창 호출
			        },
			        error: function(e) {
			            // TODO 에러 화면
			        }
			    });
			}
		</sec:authorize>
	});
</script>

</html>