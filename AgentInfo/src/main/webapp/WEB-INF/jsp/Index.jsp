<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths"><head>
<head>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <title>Mega Able bootstrap admin template by codedthemes </title>
    <script>
	    $(function() {
	    	$.cookie('name','main');
	    });
    </script>
</head>
<body themebg-pattern="theme1">
  <div id="pcoded" class="pcoded iscollapsed">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
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
                                          <h5 class="m-b-10">Dashboard</h5>
                                          <p class="m-b-0">Welcome to Mega Able</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="index.html"> <i class="fa fa-home"></i> </a>
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
                                            <div class="col-xl-3 col-md-6">
                                                <div class="card">
                                                    <div class="card-block">
                                                        <div class="row align-items-center">
                                                            <div class="col-8">
                                                                <h4 class="text-c-purple">$30200</h4>
                                                                <h6 class="text-muted m-b-0">All Earnings</h6>
                                                            </div>
                                                            <div class="col-4 text-right">
                                                                <i class="fa fa-bar-chart f-28"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer bg-c-purple">
                                                        <div class="row align-items-center">
                                                            <div class="col-9">
                                                                <p class="text-white m-b-0">% change</p>
                                                            </div>
                                                            <div class="col-3 text-right">
                                                                <i class="fa fa-line-chart text-white f-16"></i>
                                                            </div>
                                                        </div>
            
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-md-6">
                                                <div class="card">
                                                    <div class="card-block">
                                                        <div class="row align-items-center">
                                                            <div class="col-8">
                                                                <h4 class="text-c-green">290+</h4>
                                                                <h6 class="text-muted m-b-0">Page Views</h6>
                                                            </div>
                                                            <div class="col-4 text-right">
                                                                <i class="fa fa-file-text-o f-28"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer bg-c-green">
                                                        <div class="row align-items-center">
                                                            <div class="col-9">
                                                                <p class="text-white m-b-0">% change</p>
                                                            </div>
                                                            <div class="col-3 text-right">
                                                                <i class="fa fa-line-chart text-white f-16"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-md-6">
                                                <div class="card">
                                                    <div class="card-block">
                                                        <div class="row align-items-center">
                                                            <div class="col-8">
                                                                <h4 class="text-c-red">145</h4>
                                                                <h6 class="text-muted m-b-0">Task Completed</h6>
                                                            </div>
                                                            <div class="col-4 text-right">
                                                                <i class="fa fa-calendar-check-o f-28"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer bg-c-red">
                                                        <div class="row align-items-center">
                                                            <div class="col-9">
                                                                <p class="text-white m-b-0">% change</p>
                                                            </div>
                                                            <div class="col-3 text-right">
                                                                <i class="fa fa-line-chart text-white f-16"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-md-6">
                                                <div class="card">
                                                    <div class="card-block">
                                                        <div class="row align-items-center">
                                                            <div class="col-8">
                                                                <h4 class="text-c-blue">500</h4>
                                                                <h6 class="text-muted m-b-0">Downloads</h6>
                                                            </div>
                                                            <div class="col-4 text-right">
                                                                <i class="fa fa-hand-o-down f-28"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer bg-c-blue">
                                                        <div class="row align-items-center">
                                                            <div class="col-9">
                                                                <p class="text-white m-b-0">% change</p>
                                                            </div>
                                                            <div class="col-3 text-right">
                                                                <i class="fa fa-line-chart text-white f-16"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-8 col-md-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Sales Analytics</h5>
                                                        <span class="text-muted">Get 15% Off on <a href="https://www.amcharts.com/" target="_blank">amCharts</a> licences. Use code "codedthemes" and get the discount.</span>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
                                                                <li><i class="fa fa-minus minimize-card"></i></li>
                                                                <li><i class="fa fa-refresh reload-card"></i></li>
                                                                <li><i class="fa fa-trash close-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div id="sales-analytics" style="height: 400px; overflow: visible; text-align: left;"><div class="amcharts-main-div" style="position: relative;"><div class="amcharts-chart-div" style="overflow: hidden; position: relative; text-align: left; width: 1010px; height: 400px; padding: 0px; cursor: default; touch-action: auto;"><svg version="1.1" style="position: absolute; width: 1010px; height: 400px; top: -0.125px; left: -0.203125px;"><desc>JavaScript chart by amCharts 3.21.15</desc><g><path cs="100,100" d="M0.5,0.5 L1009.5,0.5 L1009.5,399.5 L0.5,399.5 Z" fill="#FFFFFF" stroke="#000000" fill-opacity="0" stroke-width="1" stroke-opacity="0" class="amcharts-bg"></path><path cs="100,100" d="M0.5,0.5 L929.5,0.5 L929.5,249.5 L0.5,249.5 L0.5,0.5 Z" fill="#FFFFFF" stroke="#000000" fill-opacity="0" stroke-width="1" stroke-opacity="0" class="amcharts-plot-area" transform="translate(40,110)"></path></g><g><g class="amcharts-value-axis value-axis-v1" transform="translate(40,0)" visibility="hidden"></g><g class="amcharts-category-axis" transform="translate(40,110)"><g><path cs="100,100" d="M25.5,0.5 L25.5,5.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(0,249)" class="amcharts-axis-tick"></path><path cs="100,100" d="M25.5,249.5 L25.5,249.5 L25.5,0.5" fill="none" stroke-width="1" stroke-dasharray="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M178.5,0.5 L178.5,5.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(0,249)" class="amcharts-axis-tick"></path><path cs="100,100" d="M178.5,249.5 L178.5,249.5 L178.5,0.5" fill="none" stroke-width="1" stroke-dasharray="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M326.5,0.5 L326.5,5.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(0,249)" class="amcharts-axis-tick"></path><path cs="100,100" d="M326.5,249.5 L326.5,249.5 L326.5,0.5" fill="none" stroke-width="1" stroke-dasharray="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M479.5,0.5 L479.5,5.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(0,249)" class="amcharts-axis-tick"></path><path cs="100,100" d="M479.5,249.5 L479.5,249.5 L479.5,0.5" fill="none" stroke-width="1" stroke-dasharray="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M628.5,0.5 L628.5,5.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(0,249)" class="amcharts-axis-tick"></path><path cs="100,100" d="M628.5,249.5 L628.5,249.5 L628.5,0.5" fill="none" stroke-width="1" stroke-dasharray="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M781.5,0.5 L781.5,5.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(0,249)" class="amcharts-axis-tick"></path><path cs="100,100" d="M781.5,249.5 L781.5,249.5 L781.5,0.5" fill="none" stroke-width="1" stroke-dasharray="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g></g><g class="amcharts-value-axis value-axis-v1" transform="translate(40,110)" visibility="visible"><g><path cs="100,100" d="M0.5,249.5 L0.5,249.5 L929.5,249.5" fill="none" stroke-width="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M0.5,199.5 L0.5,199.5 L929.5,199.5" fill="none" stroke-width="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M0.5,149.5 L0.5,149.5 L929.5,149.5" fill="none" stroke-width="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M0.5,100.5 L0.5,100.5 L929.5,100.5" fill="none" stroke-width="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M0.5,50.5 L0.5,50.5 L929.5,50.5" fill="none" stroke-width="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g><g><path cs="100,100" d="M0.5,0.5 L0.5,0.5 L929.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.1" stroke="#000000" class="amcharts-axis-grid"></path></g></g></g><g transform="translate(40,110)" clip-path="url(#AmChartsEl-3)"><g visibility="hidden"></g></g><g></g><g></g><g></g><g><g transform="translate(40,110)" class="amcharts-graph-line amcharts-graph-g1"><g></g><g clip-path="url(#AmChartsEl-5)"><path cs="100,100" d="M2.5,217.13 L7.5,222.11 L12.5,212.15 L17.5,209.66 L22.5,204.68 L27.5,217.13 L32.5,194.72 L37.5,192.23 L42.5,199.7 L47.5,207.17 L52.5,209.66 L57.5,204.68 L62.5,197.21 L67.5,184.76 L72.5,189.74 L77.5,177.29 L82.5,169.82 L86.5,204.68 L91.5,189.74 L96.5,194.72 L101.5,204.68 L106.5,202.19 L111.5,214.64 L116.5,212.15 L121.5,219.62 L126.5,229.58 L131.5,227.09 L136.5,229.58 L141.5,232.07 L146.5,237.05 L151.5,222.11 L156.5,217.13 L161.5,204.68 L166.5,199.7 L170.5,177.29 L175.5,167.33 L180.5,144.92 L185.5,162.35 L190.5,172.31 L195.5,132.47 L200.5,120.02 L205.5,134.96 L210.5,147.41 L215.5,142.43 L220.5,149.9 L225.5,152.39 L230.5,164.84 L235.5,177.29 L240.5,164.84 L245.5,157.37 L250.5,144.92 L254.5,127.49 L259.5,134.96 L264.5,132.47 L269.5,112.55 L274.5,102.59 L279.5,105.08 L284.5,107.57 L289.5,97.61 L294.5,102.59 L299.5,82.67 L304.5,87.65 L309.5,97.61 L314.5,85.16 L319.5,77.69 L324.5,72.71 L329.5,82.67 L334.5,92.63 L338.5,134.96 L343.5,169.82 L348.5,197.21 L353.5,204.68 L358.5,197.21 L363.5,179.78 L368.5,182.27 L373.5,159.86 L378.5,167.33 L383.5,172.31 L388.5,174.8 L393.5,164.84 L398.5,154.88 L403.5,157.37 L408.5,139.94 L413.5,127.49 L418.5,117.53 L422.5,107.57 L427.5,100.1 L432.5,97.61 L437.5,77.69 L442.5,82.67 L447.5,70.22 L452.5,57.77 L457.5,62.75 L462.5,75.2 L467.5,70.22 L472.5,75.2 L477.5,70.22 L482.5,67.73 L487.5,82.67 L492.5,80.18 L497.5,87.65 L502.5,72.71 L507.5,62.75 L511.5,65.24 L516.5,72.71 L521.5,60.26 L526.5,57.77 L531.5,47.81 L536.5,42.83 L541.5,50.3 L546.5,47.81 L551.5,32.87 L556.5,45.32 L561.5,35.36 L566.5,50.3 L571.5,32.87 L576.5,42.83 L581.5,37.85 L586.5,40.34 L591.5,45.32 L595.5,67.73 L600.5,72.71 L605.5,62.75 L610.5,52.79 L615.5,75.2 L620.5,67.73 L625.5,97.61 L630.5,95.12 L635.5,85.16 L640.5,87.65 L645.5,67.73 L650.5,52.79 L655.5,55.28 L660.5,55.28 L665.5,55.28 L670.5,65.24 L675.5,67.73 L679.5,62.75 L684.5,75.2 L689.5,57.77 L694.5,82.67 L699.5,95.12 L704.5,90.14 L709.5,97.61 L714.5,102.59 L719.5,117.53 L724.5,115.04 L729.5,110.06 L734.5,102.59 L739.5,105.08 L744.5,112.55 L749.5,120.02 L754.5,115.04 L759.5,125 L763.5,125 L768.5,122.51 L773.5,120.02 L778.5,105.08 L783.5,100.1 L788.5,82.67 L793.5,90.14 L798.5,85.16 L803.5,100.1 L808.5,92.63 L813.5,97.61 L818.5,100.1 L823.5,87.65 L828.5,62.75 L833.5,57.77 L838.5,55.28 L843.5,75.2 L847.5,75.2 L852.5,67.73 L857.5,72.71 L862.5,65.24 L867.5,55.28 L872.5,37.85 L877.5,45.32 L882.5,42.83 L887.5,30.38 L892.5,37.85 L897.5,37.85 L902.5,50.3 L907.5,32.87 L912.5,40.34 L917.5,42.83 L922.5,40.34 L927.5,47.81 L927.5,249.5 L2.5,249.5 L2.5,217.13 Z" fill="#11c15b" stroke="#000" fill-opacity="0.5" stroke-width="1" stroke-opacity="0" class="amcharts-graph-fill"></path><path cs="100,100" d="M2.5,217.13 L7.5,222.11 L12.5,212.15 L17.5,209.66 L22.5,204.68 L27.5,217.13 L32.5,194.72 L37.5,192.23 L42.5,199.7 L47.5,207.17 L52.5,209.66 L57.5,204.68 L62.5,197.21 L67.5,184.76 L72.5,189.74 L77.5,177.29 L82.5,169.82 L86.5,204.68 L91.5,189.74 L96.5,194.72 L101.5,204.68 L106.5,202.19 L111.5,214.64 L116.5,212.15 L121.5,219.62 L126.5,229.58 L131.5,227.09 L136.5,229.58 L141.5,232.07 L146.5,237.05 L151.5,222.11 L156.5,217.13 L161.5,204.68 L166.5,199.7 L170.5,177.29 L175.5,167.33 L180.5,144.92 L185.5,162.35 L190.5,172.31 L195.5,132.47 L200.5,120.02 L205.5,134.96 L210.5,147.41 L215.5,142.43 L220.5,149.9 L225.5,152.39 L230.5,164.84 L235.5,177.29 L240.5,164.84 L245.5,157.37 L250.5,144.92 L254.5,127.49 L259.5,134.96 L264.5,132.47 L269.5,112.55 L274.5,102.59 L279.5,105.08 L284.5,107.57 L289.5,97.61 L294.5,102.59 L299.5,82.67 L304.5,87.65 L309.5,97.61 L314.5,85.16 L319.5,77.69 L324.5,72.71 L329.5,82.67 L334.5,92.63 L338.5,134.96 L343.5,169.82 L348.5,197.21 L353.5,204.68 L358.5,197.21 L363.5,179.78 L368.5,182.27 L373.5,159.86 L378.5,167.33 L383.5,172.31 L388.5,174.8 L393.5,164.84 L398.5,154.88 L403.5,157.37 L408.5,139.94 L413.5,127.49 L418.5,117.53 L422.5,107.57 L427.5,100.1 L432.5,97.61 L437.5,77.69 L442.5,82.67 L447.5,70.22 L452.5,57.77 L457.5,62.75 L462.5,75.2 L467.5,70.22 L472.5,75.2 L477.5,70.22 L482.5,67.73 L487.5,82.67 L492.5,80.18 L497.5,87.65 L502.5,72.71 L507.5,62.75 L511.5,65.24 L516.5,72.71 L521.5,60.26 L526.5,57.77 L531.5,47.81 L536.5,42.83 L541.5,50.3 L546.5,47.81 L551.5,32.87 L556.5,45.32 L561.5,35.36 L566.5,50.3 L571.5,32.87 L576.5,42.83 L581.5,37.85 L586.5,40.34 L591.5,45.32 L595.5,67.73 L600.5,72.71 L605.5,62.75 L610.5,52.79 L615.5,75.2 L620.5,67.73 L625.5,97.61 L630.5,95.12 L635.5,85.16 L640.5,87.65 L645.5,67.73 L650.5,52.79 L655.5,55.28 L660.5,55.28 L665.5,55.28 L670.5,65.24 L675.5,67.73 L679.5,62.75 L684.5,75.2 L689.5,57.77 L694.5,82.67 L699.5,95.12 L704.5,90.14 L709.5,97.61 L714.5,102.59 L719.5,117.53 L724.5,115.04 L729.5,110.06 L734.5,102.59 L739.5,105.08 L744.5,112.55 L749.5,120.02 L754.5,115.04 L759.5,125 L763.5,125 L768.5,122.51 L773.5,120.02 L778.5,105.08 L783.5,100.1 L788.5,82.67 L793.5,90.14 L798.5,85.16 L803.5,100.1 L808.5,92.63 L813.5,97.61 L818.5,100.1 L823.5,87.65 L828.5,62.75 L833.5,57.77 L838.5,55.28 L843.5,75.2 L847.5,75.2 L852.5,67.73 L857.5,72.71 L862.5,65.24 L867.5,55.28 L872.5,37.85 L877.5,45.32 L882.5,42.83 L887.5,30.38 L892.5,37.85 L897.5,37.85 L902.5,50.3 L907.5,32.87 L912.5,40.34 L917.5,42.83 L922.5,40.34 L927.5,47.81" fill="none" stroke-width="3" stroke-opacity="0.9" stroke="#11c15b" stroke-linejoin="round" class="amcharts-graph-stroke"></path></g><clipPath id="AmChartsEl-5"><rect x="0" y="0" width="929" height="249" rx="0" ry="0" stroke-width="0"></rect></clipPath><g></g></g></g><g></g><g><path cs="100,100" d="M0.5,249.5 L929.5,249.5 L929.5,249.5" fill="none" stroke-width="1" stroke-opacity="0.2" stroke="#000000" transform="translate(40,110)" class="amcharts-axis-zero-grid-v1 amcharts-axis-zero-grid"></path><path cs="100,100" d="M0.5,90.5 L930.5,90.5 L930.5,90.5" fill="none" stroke-width="1" stroke-opacity="0" stroke="#000000" transform="translate(40,0)" class="amcharts-axis-zero-grid-v1 amcharts-axis-zero-grid"></path><g><path cs="100,100" d="M0.5,0.5 L929.5,0.5" fill="none" stroke-width="1" stroke-opacity="0" stroke="#000000" transform="translate(0,90)" class="amcharts-axis-line"></path></g><g class="amcharts-value-axis value-axis-v1"><path cs="100,100" d="M0.5,0.5 L0.5,90.5" fill="none" stroke-width="1" stroke-opacity="0" stroke="#000000" transform="translate(40,0)" class="amcharts-axis-line" visibility="hidden"></path></g><g class="amcharts-category-axis"><path cs="100,100" d="M0.5,0.5 L929.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.3" stroke="#000000" transform="translate(40,359)" class="amcharts-axis-line"></path></g><g class="amcharts-value-axis value-axis-v1"><path cs="100,100" d="M0.5,0.5 L0.5,249.5" fill="none" stroke-width="1" stroke-opacity="0" stroke="#000000" transform="translate(40,110)" class="amcharts-axis-line" visibility="visible"></path></g></g><g><g transform="translate(40,110)" clip-path="url(#AmChartsEl-4)" style="pointer-events: none;"><path cs="100,100" d="M0.5,0.5 L0.5,0.5 L0.5,249.5" fill="none" stroke-width="1" stroke-opacity="0" stroke="#000000" class="amcharts-cursor-line amcharts-cursor-line-vertical" visibility="hidden" transform="translate(121,0)"></path><path cs="100,100" d="M0.5,0.5 L929.5,0.5 L929.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.5" stroke="#000000" class="amcharts-cursor-line amcharts-cursor-line-horizontal" visibility="hidden" transform="translate(0,33)"></path></g><clipPath id="AmChartsEl-4"><rect x="0" y="0" width="929" height="249" rx="0" ry="0" stroke-width="0"></rect></clipPath></g><g><g class="amcharts-scrollbar-horizontal" visibility="visible" transform="translate(40,20)" style="touch-action: none;"><rect x="0.5" y="0.5" width="930" height="90" rx="0" ry="0" stroke-width="1" fill="#000000" stroke="#000000" fill-opacity="0.12" stroke-opacity="0.12" class="amcharts-scrollbar-bg"></rect><rect x="0.5" y="0.5" width="929" height="91" rx="0" ry="0" stroke-width="0" fill="#FFFFFF" stroke="#FFFFFF" fill-opacity="0.4" stroke-opacity="0.4" class="amcharts-scrollbar-bg-selected" transform="translate(0,0)"></rect><g transform="translate(0,0)" class="amcharts-graph-line amcharts-graph-g1"><g></g><g><path cs="100,100" d="M2.5,78.8 L7.5,80.6 L12.5,77 L17.5,76.1 L22.5,74.3 L27.5,78.8 L32.5,70.7 L37.5,69.8 L42.5,72.5 L47.5,75.2 L52.5,76.1 L57.5,74.3 L62.5,71.6 L67.5,67.1 L72.5,68.9 L77.5,64.4 L82.5,61.7 L86.5,74.3 L91.5,68.9 L96.5,70.7 L101.5,74.3 L106.5,73.4 L111.5,77.9 L116.5,77 L121.5,79.7 L126.5,83.3 L131.5,82.4 L136.5,83.3 L141.5,84.2 L146.5,86 L151.5,80.6 L156.5,78.8 L161.5,74.3 L166.5,72.5 L170.5,64.4 L175.5,60.8 L180.5,52.7 L185.5,59 L190.5,62.6 L195.5,48.2 L200.5,43.7 L205.5,49.1 L210.5,53.6 L215.5,51.8 L220.5,54.5 L225.5,55.4 L230.5,59.9 L235.5,64.4 L240.5,59.9 L245.5,57.2 L250.5,52.7 L254.5,46.4 L259.5,49.1 L264.5,48.2 L269.5,41 L274.5,37.4 L279.5,38.3 L284.5,39.2 L289.5,35.6 L294.5,37.4 L299.5,30.2 L304.5,32 L309.5,35.6 L314.5,31.1 L319.5,28.4 L324.5,26.6 L329.5,30.2 L334.5,33.8 L338.5,49.1 L343.5,61.7 L348.5,71.6 L353.5,74.3 L358.5,71.6 L363.5,65.3 L368.5,66.2 L373.5,58.1 L378.5,60.8 L383.5,62.6 L388.5,63.5 L393.5,59.9 L398.5,56.3 L403.5,57.2 L408.5,50.9 L413.5,46.4 L418.5,42.8 L422.5,39.2 L427.5,36.5 L432.5,35.6 L437.5,28.4 L442.5,30.2 L447.5,25.7 L452.5,21.2 L457.5,23 L462.5,27.5 L467.5,25.7 L472.5,27.5 L477.5,25.7 L482.5,24.8 L487.5,30.2 L492.5,29.3 L497.5,32 L502.5,26.6 L507.5,23 L511.5,23.9 L516.5,26.6 L521.5,22.1 L526.5,21.2 L531.5,17.6 L536.5,15.8 L541.5,18.5 L546.5,17.6 L551.5,12.2 L556.5,16.7 L561.5,13.1 L566.5,18.5 L571.5,12.2 L576.5,15.8 L581.5,14 L586.5,14.9 L591.5,16.7 L595.5,24.8 L600.5,26.6 L605.5,23 L610.5,19.4 L615.5,27.5 L620.5,24.8 L625.5,35.6 L630.5,34.7 L635.5,31.1 L640.5,32 L645.5,24.8 L650.5,19.4 L655.5,20.3 L660.5,20.3 L665.5,20.3 L670.5,23.9 L675.5,24.8 L679.5,23 L684.5,27.5 L689.5,21.2 L694.5,30.2 L699.5,34.7 L704.5,32.9 L709.5,35.6 L714.5,37.4 L719.5,42.8 L724.5,41.9 L729.5,40.1 L734.5,37.4 L739.5,38.3 L744.5,41 L749.5,43.7 L754.5,41.9 L759.5,45.5 L763.5,45.5 L768.5,44.6 L773.5,43.7 L778.5,38.3 L783.5,36.5 L788.5,30.2 L793.5,32.9 L798.5,31.1 L803.5,36.5 L808.5,33.8 L813.5,35.6 L818.5,36.5 L823.5,32 L828.5,23 L833.5,21.2 L838.5,20.3 L843.5,27.5 L847.5,27.5 L852.5,24.8 L857.5,26.6 L862.5,23.9 L867.5,20.3 L872.5,14 L877.5,16.7 L882.5,15.8 L887.5,11.3 L892.5,14 L897.5,14 L902.5,18.5 L907.5,12.2 L912.5,14.9 L917.5,15.8 L922.5,14.9 L927.5,17.6 L927.5,90.5 L2.5,90.5 L2.5,78.8 Z" fill="#BBBBBB" stroke="#000" fill-opacity="0.5" stroke-width="1" stroke-opacity="0" class="amcharts-scrollbar-graph-fill"></path><path cs="100,100" d="M2.5,78.8 L7.5,80.6 L12.5,77 L17.5,76.1 L22.5,74.3 L27.5,78.8 L32.5,70.7 L37.5,69.8 L42.5,72.5 L47.5,75.2 L52.5,76.1 L57.5,74.3 L62.5,71.6 L67.5,67.1 L72.5,68.9 L77.5,64.4 L82.5,61.7 L86.5,74.3 L91.5,68.9 L96.5,70.7 L101.5,74.3 L106.5,73.4 L111.5,77.9 L116.5,77 L121.5,79.7 L126.5,83.3 L131.5,82.4 L136.5,83.3 L141.5,84.2 L146.5,86 L151.5,80.6 L156.5,78.8 L161.5,74.3 L166.5,72.5 L170.5,64.4 L175.5,60.8 L180.5,52.7 L185.5,59 L190.5,62.6 L195.5,48.2 L200.5,43.7 L205.5,49.1 L210.5,53.6 L215.5,51.8 L220.5,54.5 L225.5,55.4 L230.5,59.9 L235.5,64.4 L240.5,59.9 L245.5,57.2 L250.5,52.7 L254.5,46.4 L259.5,49.1 L264.5,48.2 L269.5,41 L274.5,37.4 L279.5,38.3 L284.5,39.2 L289.5,35.6 L294.5,37.4 L299.5,30.2 L304.5,32 L309.5,35.6 L314.5,31.1 L319.5,28.4 L324.5,26.6 L329.5,30.2 L334.5,33.8 L338.5,49.1 L343.5,61.7 L348.5,71.6 L353.5,74.3 L358.5,71.6 L363.5,65.3 L368.5,66.2 L373.5,58.1 L378.5,60.8 L383.5,62.6 L388.5,63.5 L393.5,59.9 L398.5,56.3 L403.5,57.2 L408.5,50.9 L413.5,46.4 L418.5,42.8 L422.5,39.2 L427.5,36.5 L432.5,35.6 L437.5,28.4 L442.5,30.2 L447.5,25.7 L452.5,21.2 L457.5,23 L462.5,27.5 L467.5,25.7 L472.5,27.5 L477.5,25.7 L482.5,24.8 L487.5,30.2 L492.5,29.3 L497.5,32 L502.5,26.6 L507.5,23 L511.5,23.9 L516.5,26.6 L521.5,22.1 L526.5,21.2 L531.5,17.6 L536.5,15.8 L541.5,18.5 L546.5,17.6 L551.5,12.2 L556.5,16.7 L561.5,13.1 L566.5,18.5 L571.5,12.2 L576.5,15.8 L581.5,14 L586.5,14.9 L591.5,16.7 L595.5,24.8 L600.5,26.6 L605.5,23 L610.5,19.4 L615.5,27.5 L620.5,24.8 L625.5,35.6 L630.5,34.7 L635.5,31.1 L640.5,32 L645.5,24.8 L650.5,19.4 L655.5,20.3 L660.5,20.3 L665.5,20.3 L670.5,23.9 L675.5,24.8 L679.5,23 L684.5,27.5 L689.5,21.2 L694.5,30.2 L699.5,34.7 L704.5,32.9 L709.5,35.6 L714.5,37.4 L719.5,42.8 L724.5,41.9 L729.5,40.1 L734.5,37.4 L739.5,38.3 L744.5,41 L749.5,43.7 L754.5,41.9 L759.5,45.5 L763.5,45.5 L768.5,44.6 L773.5,43.7 L778.5,38.3 L783.5,36.5 L788.5,30.2 L793.5,32.9 L798.5,31.1 L803.5,36.5 L808.5,33.8 L813.5,35.6 L818.5,36.5 L823.5,32 L828.5,23 L833.5,21.2 L838.5,20.3 L843.5,27.5 L847.5,27.5 L852.5,24.8 L857.5,26.6 L862.5,23.9 L867.5,20.3 L872.5,14 L877.5,16.7 L882.5,15.8 L887.5,11.3 L892.5,14 L897.5,14 L902.5,18.5 L907.5,12.2 L912.5,14.9 L917.5,15.8 L922.5,14.9 L927.5,17.6" fill="none" stroke-width="1" stroke-opacity="0" stroke="#BBBBBB" stroke-linejoin="round" class="amcharts-scrollbar-graph-stroke"></path></g><g></g></g><g transform="translate(0,0)" class="amcharts-graph-line amcharts-graph-g1" clip-path="url(#AmChartsEl-6)"><g></g><g><path cs="100,100" d="M2.5,78.8 L7.5,80.6 L12.5,77 L17.5,76.1 L22.5,74.3 L27.5,78.8 L32.5,70.7 L37.5,69.8 L42.5,72.5 L47.5,75.2 L52.5,76.1 L57.5,74.3 L62.5,71.6 L67.5,67.1 L72.5,68.9 L77.5,64.4 L82.5,61.7 L86.5,74.3 L91.5,68.9 L96.5,70.7 L101.5,74.3 L106.5,73.4 L111.5,77.9 L116.5,77 L121.5,79.7 L126.5,83.3 L131.5,82.4 L136.5,83.3 L141.5,84.2 L146.5,86 L151.5,80.6 L156.5,78.8 L161.5,74.3 L166.5,72.5 L170.5,64.4 L175.5,60.8 L180.5,52.7 L185.5,59 L190.5,62.6 L195.5,48.2 L200.5,43.7 L205.5,49.1 L210.5,53.6 L215.5,51.8 L220.5,54.5 L225.5,55.4 L230.5,59.9 L235.5,64.4 L240.5,59.9 L245.5,57.2 L250.5,52.7 L254.5,46.4 L259.5,49.1 L264.5,48.2 L269.5,41 L274.5,37.4 L279.5,38.3 L284.5,39.2 L289.5,35.6 L294.5,37.4 L299.5,30.2 L304.5,32 L309.5,35.6 L314.5,31.1 L319.5,28.4 L324.5,26.6 L329.5,30.2 L334.5,33.8 L338.5,49.1 L343.5,61.7 L348.5,71.6 L353.5,74.3 L358.5,71.6 L363.5,65.3 L368.5,66.2 L373.5,58.1 L378.5,60.8 L383.5,62.6 L388.5,63.5 L393.5,59.9 L398.5,56.3 L403.5,57.2 L408.5,50.9 L413.5,46.4 L418.5,42.8 L422.5,39.2 L427.5,36.5 L432.5,35.6 L437.5,28.4 L442.5,30.2 L447.5,25.7 L452.5,21.2 L457.5,23 L462.5,27.5 L467.5,25.7 L472.5,27.5 L477.5,25.7 L482.5,24.8 L487.5,30.2 L492.5,29.3 L497.5,32 L502.5,26.6 L507.5,23 L511.5,23.9 L516.5,26.6 L521.5,22.1 L526.5,21.2 L531.5,17.6 L536.5,15.8 L541.5,18.5 L546.5,17.6 L551.5,12.2 L556.5,16.7 L561.5,13.1 L566.5,18.5 L571.5,12.2 L576.5,15.8 L581.5,14 L586.5,14.9 L591.5,16.7 L595.5,24.8 L600.5,26.6 L605.5,23 L610.5,19.4 L615.5,27.5 L620.5,24.8 L625.5,35.6 L630.5,34.7 L635.5,31.1 L640.5,32 L645.5,24.8 L650.5,19.4 L655.5,20.3 L660.5,20.3 L665.5,20.3 L670.5,23.9 L675.5,24.8 L679.5,23 L684.5,27.5 L689.5,21.2 L694.5,30.2 L699.5,34.7 L704.5,32.9 L709.5,35.6 L714.5,37.4 L719.5,42.8 L724.5,41.9 L729.5,40.1 L734.5,37.4 L739.5,38.3 L744.5,41 L749.5,43.7 L754.5,41.9 L759.5,45.5 L763.5,45.5 L768.5,44.6 L773.5,43.7 L778.5,38.3 L783.5,36.5 L788.5,30.2 L793.5,32.9 L798.5,31.1 L803.5,36.5 L808.5,33.8 L813.5,35.6 L818.5,36.5 L823.5,32 L828.5,23 L833.5,21.2 L838.5,20.3 L843.5,27.5 L847.5,27.5 L852.5,24.8 L857.5,26.6 L862.5,23.9 L867.5,20.3 L872.5,14 L877.5,16.7 L882.5,15.8 L887.5,11.3 L892.5,14 L897.5,14 L902.5,18.5 L907.5,12.2 L912.5,14.9 L917.5,15.8 L922.5,14.9 L927.5,17.6 L927.5,90.5 L2.5,90.5 L2.5,78.8 Z" fill="#888888" stroke="#000" fill-opacity="1" stroke-width="1" stroke-opacity="0" class="amcharts-scrollbar-graph-selected-fill"></path><path cs="100,100" d="M2.5,78.8 L7.5,80.6 L12.5,77 L17.5,76.1 L22.5,74.3 L27.5,78.8 L32.5,70.7 L37.5,69.8 L42.5,72.5 L47.5,75.2 L52.5,76.1 L57.5,74.3 L62.5,71.6 L67.5,67.1 L72.5,68.9 L77.5,64.4 L82.5,61.7 L86.5,74.3 L91.5,68.9 L96.5,70.7 L101.5,74.3 L106.5,73.4 L111.5,77.9 L116.5,77 L121.5,79.7 L126.5,83.3 L131.5,82.4 L136.5,83.3 L141.5,84.2 L146.5,86 L151.5,80.6 L156.5,78.8 L161.5,74.3 L166.5,72.5 L170.5,64.4 L175.5,60.8 L180.5,52.7 L185.5,59 L190.5,62.6 L195.5,48.2 L200.5,43.7 L205.5,49.1 L210.5,53.6 L215.5,51.8 L220.5,54.5 L225.5,55.4 L230.5,59.9 L235.5,64.4 L240.5,59.9 L245.5,57.2 L250.5,52.7 L254.5,46.4 L259.5,49.1 L264.5,48.2 L269.5,41 L274.5,37.4 L279.5,38.3 L284.5,39.2 L289.5,35.6 L294.5,37.4 L299.5,30.2 L304.5,32 L309.5,35.6 L314.5,31.1 L319.5,28.4 L324.5,26.6 L329.5,30.2 L334.5,33.8 L338.5,49.1 L343.5,61.7 L348.5,71.6 L353.5,74.3 L358.5,71.6 L363.5,65.3 L368.5,66.2 L373.5,58.1 L378.5,60.8 L383.5,62.6 L388.5,63.5 L393.5,59.9 L398.5,56.3 L403.5,57.2 L408.5,50.9 L413.5,46.4 L418.5,42.8 L422.5,39.2 L427.5,36.5 L432.5,35.6 L437.5,28.4 L442.5,30.2 L447.5,25.7 L452.5,21.2 L457.5,23 L462.5,27.5 L467.5,25.7 L472.5,27.5 L477.5,25.7 L482.5,24.8 L487.5,30.2 L492.5,29.3 L497.5,32 L502.5,26.6 L507.5,23 L511.5,23.9 L516.5,26.6 L521.5,22.1 L526.5,21.2 L531.5,17.6 L536.5,15.8 L541.5,18.5 L546.5,17.6 L551.5,12.2 L556.5,16.7 L561.5,13.1 L566.5,18.5 L571.5,12.2 L576.5,15.8 L581.5,14 L586.5,14.9 L591.5,16.7 L595.5,24.8 L600.5,26.6 L605.5,23 L610.5,19.4 L615.5,27.5 L620.5,24.8 L625.5,35.6 L630.5,34.7 L635.5,31.1 L640.5,32 L645.5,24.8 L650.5,19.4 L655.5,20.3 L660.5,20.3 L665.5,20.3 L670.5,23.9 L675.5,24.8 L679.5,23 L684.5,27.5 L689.5,21.2 L694.5,30.2 L699.5,34.7 L704.5,32.9 L709.5,35.6 L714.5,37.4 L719.5,42.8 L724.5,41.9 L729.5,40.1 L734.5,37.4 L739.5,38.3 L744.5,41 L749.5,43.7 L754.5,41.9 L759.5,45.5 L763.5,45.5 L768.5,44.6 L773.5,43.7 L778.5,38.3 L783.5,36.5 L788.5,30.2 L793.5,32.9 L798.5,31.1 L803.5,36.5 L808.5,33.8 L813.5,35.6 L818.5,36.5 L823.5,32 L828.5,23 L833.5,21.2 L838.5,20.3 L843.5,27.5 L847.5,27.5 L852.5,24.8 L857.5,26.6 L862.5,23.9 L867.5,20.3 L872.5,14 L877.5,16.7 L882.5,15.8 L887.5,11.3 L892.5,14 L897.5,14 L902.5,18.5 L907.5,12.2 L912.5,14.9 L917.5,15.8 L922.5,14.9 L927.5,17.6" fill="none" stroke-width="1" stroke-opacity="0" stroke="#888888" stroke-linejoin="round" class="amcharts-scrollbar-graph-selected-stroke"></path></g><g></g></g><g transform="translate(0,0)"><g><path cs="100,100" d="M25.5,90.5 L25.5,90.5 L25.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.15" stroke="#FFFFFF" class="amcharts-scrollbar-grid"></path></g><g><path cs="100,100" d="M178.5,90.5 L178.5,90.5 L178.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.15" stroke="#FFFFFF" class="amcharts-scrollbar-grid"></path></g><g><path cs="100,100" d="M326.5,90.5 L326.5,90.5 L326.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.15" stroke="#FFFFFF" class="amcharts-scrollbar-grid"></path></g><g><path cs="100,100" d="M479.5,90.5 L479.5,90.5 L479.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.15" stroke="#FFFFFF" class="amcharts-scrollbar-grid"></path></g><g><path cs="100,100" d="M628.5,90.5 L628.5,90.5 L628.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.15" stroke="#FFFFFF" class="amcharts-scrollbar-grid"></path></g><g><path cs="100,100" d="M781.5,90.5 L781.5,90.5 L781.5,0.5" fill="none" stroke-width="1" stroke-opacity="0.15" stroke="#FFFFFF" class="amcharts-scrollbar-grid"></path></g></g><g transform="translate(0,0)" visibility="visible"><text y="6" fill="#FFFFFF" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(101.59308511109838,78.5)" class="amcharts-scrollbar-label"><tspan y="6" x="0">Aug</tspan></text><text y="6" fill="#FFFFFF" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(254.5930851110984,78.5)" class="amcharts-scrollbar-label"><tspan y="6" x="0">Sep</tspan></text><text y="6" fill="#FFFFFF" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(402.5930851110984,78.5)" class="amcharts-scrollbar-label"><tspan y="6" x="0">Oct</tspan></text><text y="6" fill="#FFFFFF" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(555.5930851110984,78.5)" class="amcharts-scrollbar-label"><tspan y="6" x="0">Nov</tspan></text><text y="6" fill="#FFFFFF" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(704.5930851110984,78.5)" class="amcharts-scrollbar-label"><tspan y="6" x="0">Dec</tspan></text><text y="6" fill="#FFFFFF" font-family="Verdana" font-size="11px" opacity="1" font-weight="bold" text-anchor="middle" transform="translate(857.5930851110984,78.5)" class="amcharts-scrollbar-label"><tspan y="6" x="0">2013</tspan></text></g><rect x="0.5" y="0.5" width="930" height="90" rx="0" ry="0" stroke-width="0" fill="#000" stroke="#000" fill-opacity="0.005" stroke-opacity="0.005"></rect><rect x="0" y="0.5" width="929" height="90" rx="0" ry="0" stroke-width="0" fill="#000" stroke="#000" fill-opacity="0.005" stroke-opacity="0.005" aria-label="Zoom chart using cursor arrows" role="menuitem" style="cursor: -webkit-grab;"></rect><g aria-label="Zoom chart using cursor arrows" role="menuitem" transform="translate(-17,28)" visibility="visible"><image x="0" y="0" width="35" height="35" xlink:href="https://www.amcharts.com/lib/3/images/dragIconRoundBig.svg" class="amcharts-scrollbar-grip-left"></image><rect x="0.5" y="0.5" width="25" height="90" rx="0" ry="0" stroke-width="0" fill="#000" stroke="#000" fill-opacity="0.005" stroke-opacity="0.005" transform="translate(5,-27)"></rect></g><g aria-label="Zoom chart using cursor arrows" role="menuitem" transform="translate(912,28)" visibility="visible"><image x="0" y="0" width="35" height="35" xlink:href="https://www.amcharts.com/lib/3/images/dragIconRoundBig.svg" class="amcharts-scrollbar-grip-right"></image><rect x="0.5" y="0.5" width="25" height="90" rx="0" ry="0" stroke-width="0" fill="#000" stroke="#000" fill-opacity="0.005" stroke-opacity="0.005" transform="translate(5,-27)"></rect></g><clipPath id="AmChartsEl-6"><rect x="0" y="0" width="929" height="91" rx="0" ry="0" stroke-width="0"></rect></clipPath></g></g><g><g transform="translate(0,0)" class="amcharts-graph-line amcharts-graph-g1"></g><g transform="translate(0,0)" class="amcharts-graph-line amcharts-graph-g1"></g><g transform="translate(40,110)" class="amcharts-graph-line amcharts-graph-g1"></g></g><g><g></g></g><g><g class="amcharts-value-axis value-axis-v1" transform="translate(40,0)" visibility="hidden"></g><g class="amcharts-category-axis" transform="translate(40,110)" visibility="visible"><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(101.59308511109838,261.5)" class="amcharts-axis-label"><tspan y="6" x="0">Aug</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(254.5930851110984,261.5)" class="amcharts-axis-label"><tspan y="6" x="0">Sep</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(402.5930851110984,261.5)" class="amcharts-axis-label"><tspan y="6" x="0">Oct</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(555.5930851110984,261.5)" class="amcharts-axis-label"><tspan y="6" x="0">Nov</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="middle" transform="translate(704.5930851110984,261.5)" class="amcharts-axis-label"><tspan y="6" x="0">Dec</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" font-weight="bold" text-anchor="middle" transform="translate(857.5930851110984,261.5)" class="amcharts-axis-label"><tspan y="6" x="0">2013</tspan></text></g><g class="amcharts-value-axis value-axis-v1" transform="translate(40,110)" visibility="visible"><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="end" transform="translate(-12,248)" class="amcharts-axis-label"><tspan y="6" x="0">0</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="end" transform="translate(-12,198)" class="amcharts-axis-label"><tspan y="6" x="0">20</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="end" transform="translate(-12,148)" class="amcharts-axis-label"><tspan y="6" x="0">40</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="end" transform="translate(-12,99)" class="amcharts-axis-label"><tspan y="6" x="0">60</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="end" transform="translate(-12,49)" class="amcharts-axis-label"><tspan y="6" x="0">80</tspan></text><text y="6" fill="#000000" font-family="Verdana" font-size="11px" opacity="1" text-anchor="end" transform="translate(-12,-1)" class="amcharts-axis-label"><tspan y="6" x="0">100</tspan></text></g></g><g></g><g transform="translate(40,110)"></g><g></g><g></g><clipPath id="AmChartsEl-3"><rect x="-1" y="-1" width="931" height="251" rx="0" ry="0" stroke-width="0"></rect></clipPath></svg><a href="http://www.amcharts.com" title="JavaScript charts" style="position: absolute; text-decoration: none; color: rgb(0, 0, 0); font-family: Verdana; font-size: 11px; opacity: 0.7; display: block; left: 45px; top: 115px;">JS chart by amCharts</a></div><div class="amcharts-export-menu amcharts-export-menu-top-right amExportButton"><ul><li class="export-main"><a href="#"><span>menu.label.undefined</span></a><ul><li><a href="#"><span>Download as ...</span></a><ul><li><a href="#"><span>PNG</span></a></li><li><a href="#"><span>JPG</span></a></li><li><a href="#"><span>SVG</span></a></li><li><a href="#"><span>PDF</span></a></li></ul></li><li><a href="#"><span>Save as ...</span></a><ul><li><a href="#"><span>CSV</span></a></li><li><a href="#"><span>XLSX</span></a></li><li><a href="#"><span>JSON</span></a></li></ul></li><li><a href="#"><span>Annotate ...</span></a></li><li><a href="#"><span>Print</span></a></li></ul></li></ul></div></div></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-4 col-md-12">
                                                <div class="card">
                                                    <div class="card-block">
                                                        <div class="row">
                                                            <div class="col">
                                                                <h4>$256.23</h4>
                                                                <p class="text-muted">This Month</p>
                                                            </div>
                                                            <div class="col-auto">
                                                                <label class="label label-success">+20%</label>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-8">
                                                                <canvas id="this-month" style="height: 150px;"></canvas>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card quater-card">
                                                    <div class="card-block">
                                                        <h6 class="text-muted m-b-15">This Quarter</h6>
                                                        <h4>$3,9452.50</h4>
                                                        <p class="text-muted">$3,9452.50</p>
                                                        <h5>87</h5>
                                                        <p class="text-muted">Online Revenue<span class="f-right">80%</span></p>
                                                        <div class="progress"><div class="progress-bar bg-c-blue" style="width: 80%"></div></div>
                                                        <h5 class="m-t-15">68</h5>
                                                        <p class="text-muted">Offline Revenue<span class="f-right">50%</span></p>
                                                        <div class="progress"><div class="progress-bar bg-c-green" style="width: 50%"></div></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-8 col-md-12">
                                                <div class="card table-card">
                                                    <div class="card-header">
                                                        <h5>Projects</h5>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
                                                                <li><i class="fa fa-minus minimize-card"></i></li>
                                                                <li><i class="fa fa-refresh reload-card"></i></li>
                                                                <li><i class="fa fa-trash close-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                <tr>
                                                                    <th>
                                                                        <div class="chk-option">
                                                                            <div class="checkbox-fade fade-in-primary">
                                                                                <label class="check-task">
                                                                                    <input type="checkbox" value="">
                                                                                    <span class="cr">
                                                                                            <i class="cr-icon fa fa-check txt-default"></i>
                                                                                        </span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        Assigned</th>
                                                                    <th>Name</th>
                                                                    <th>Due Date</th>
                                                                    <th class="text-right">Priority</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <div class="chk-option">
                                                                            <div class="checkbox-fade fade-in-primary">
                                                                                <label class="check-task">
                                                                                    <input type="checkbox" value="">
                                                                                    <span class="cr">
                                                                                                <i class="cr-icon fa fa-check txt-default"></i>
                                                                                            </span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="d-inline-block align-middle">
                                                                            <img src="images/avatar-4.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                                            <div class="d-inline-block">
                                                                                <h6>John Deo</h6>
                                                                                <p class="text-muted m-b-0">Graphics Designer</p>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>Able Pro</td>
                                                                    <td>Jun, 26</td>
                                                                    <td class="text-right"><label class="label label-danger">Low</label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="chk-option">
                                                                            <div class="checkbox-fade fade-in-primary">
                                                                                <label class="check-task">
                                                                                    <input type="checkbox" value="">
                                                                                    <span class="cr">
                                                                                                <i class="cr-icon fa fa-check txt-default"></i>
                                                                                            </span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="d-inline-block align-middle">
                                                                            <img src="images/avatar-5.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                                            <div class="d-inline-block">
                                                                                <h6>Jenifer Vintage</h6>
                                                                                <p class="text-muted m-b-0">Web Designer</p>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>Mashable</td>
                                                                    <td>March, 31</td>
                                                                    <td class="text-right"><label class="label label-primary">high</label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="chk-option">
                                                                            <div class="checkbox-fade fade-in-primary">
                                                                                <label class="check-task">
                                                                                    <input type="checkbox" value="">
                                                                                    <span class="cr">
                                                                                                <i class="cr-icon fa fa-check txt-default"></i>
                                                                                            </span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="d-inline-block align-middle">
                                                                            <img src="images/avatar-3.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                                            <div class="d-inline-block">
                                                                                <h6>William Jem</h6>
                                                                                <p class="text-muted m-b-0">Developer</p>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>Flatable</td>
                                                                    <td>Aug, 02</td>
                                                                    <td class="text-right"><label class="label label-success">medium</label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div class="chk-option">
                                                                            <div class="checkbox-fade fade-in-primary">
                                                                                <label class="check-task">
                                                                                    <input type="checkbox" value="">
                                                                                    <span class="cr">
                                                                                                <i class="cr-icon fa fa-check txt-default"></i>
                                                                                            </span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="d-inline-block align-middle">
                                                                            <img src="images/avatar-2.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                                            <div class="d-inline-block">
                                                                                <h6>David Jones</h6>
                                                                                <p class="text-muted m-b-0">Developer</p>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>Guruable</td>
                                                                    <td>Sep, 22</td>
                                                                    <td class="text-right"><label class="label label-primary">high</label></td>
                                                                </tr>
                                                                </tbody>
                                                            </table>
                                                            <div class="text-right m-r-20">
                                                                <a href="#!" class=" b-b-primary text-primary">View all Projects</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-4 col-md-12">
                                                <div class="card ">
                                                    <div class="card-header">
                                                        <h5>Team Members</h5>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="fa fa fa-wrench open-card-option"></i></li>
                                                                <li><i class="fa fa-window-maximize full-card"></i></li>
                                                                <li><i class="fa fa-minus minimize-card"></i></li>
                                                                <li><i class="fa fa-refresh reload-card"></i></li>
                                                                <li><i class="fa fa-trash close-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div class="align-middle m-b-30">
                                                            <img src="images/avatar-2.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                            <div class="d-inline-block">
                                                                <h6>David Jones</h6>
                                                                <p class="text-muted m-b-0">Developer</p>
                                                            </div>
                                                        </div>
                                                        <div class="align-middle m-b-30">
                                                            <img src="images/avatar-1.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                            <div class="d-inline-block">
                                                                <h6>David Jones</h6>
                                                                <p class="text-muted m-b-0">Developer</p>
                                                            </div>
                                                        </div>
                                                        <div class="align-middle m-b-30">
                                                            <img src="images/avatar-3.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                            <div class="d-inline-block">
                                                                <h6>David Jones</h6>
                                                                <p class="text-muted m-b-0">Developer</p>
                                                            </div>
                                                        </div>
                                                        <div class="align-middle m-b-30">
                                                            <img src="images/avatar-4.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                            <div class="d-inline-block">
                                                                <h6>David Jones</h6>
                                                                <p class="text-muted m-b-0">Developer</p>
                                                            </div>
                                                        </div>
                                                        <div class="align-middle m-b-10">
                                                            <img src="images/avatar-5.jpg" alt="user image" class="img-radius img-40 align-top m-r-15">
                                                            <div class="d-inline-block">
                                                                <h6>David Jones</h6>
                                                                <p class="text-muted m-b-0">Developer</p>
                                                            </div>
                                                        </div>
                                                        <div class="text-center">
                                                            <a href="#!" class="b-b-primary text-primary">View all Projects</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body></html>