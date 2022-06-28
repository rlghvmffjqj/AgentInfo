<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<link rel="stylesheet" href="<c:url value='/css/toast/tui-grid.css'/>">
		<script src="<c:url value='/js/toast/tui-grid.js'/>"></script>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','customerInfo');
		    });
	    </script>
	    <script>
			var grid;
			$(function(){
				/* =========== Grid Start ========= */
				 grid = new tui.Grid({
				   el: document.getElementById('grid'),
				   scrollX: false,
				   scrollY: true,
				   rowHeaders: ['checkbox'],
				   selectionUnit: 'row',
				   bodyHeight: 700,
				   columns: [
				  	{                      
				    	header: '고객사명',     
				      	name: 'customerName', 
				      	formatter: function(rowData) {
				      		var customerName = rowData.row.customerName;
				      		var businessName = rowData.row.businessName;
							return '<a style="color:#0000FE" onclick="updateView('+"'"+customerName+"','"+businessName+"'"+');">' + rowData.value + '</a>';
			            },
				    },    
				    {                      
				    	header: '사업명',     
				      	name: 'businessName', 
				    },  
				   ],
				   columnOptions: {
				   	resizable: true
				   },
				 });
				tableRefresh();
			});
		</script>
	</head>
	<body>
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
									        <div class="page-header-title" >
									            <h5 class="m-b-10">고객사 정보</h5>
									            <p class="m-b-0">Customer Information</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">고객사 정보</a>
									            </li>
									        </ul>
									    </div>
									</div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
	                                	<div class="ibox">
	                                		<div class="searchbox">
		                                		<form class="form-material margin20">
				                                    <div class="form-group form-primary">
				                                        <select class="form-control selectpicker search" id="customerName" name="customerName" data-live-search="true" data-size="5" data-actions-box="true">
				                                        	<option value=""></option>
															<c:forEach var="item" items="${customerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
				                                        <span class="form-bar"></span>
				                                        <label class="float-label fontsize25"><i class="fa fa-search m-r-10"></i>고객사 이름</label>
				                                    </div>
				                                </form>
			                                </div>
	                     				 </div>
	                     				 <!-- table Start -->
										<div class="card">
                                            <div class="card-header">
                                                <h5>사업명 확인하여 선택 바랍니다.</h5>
                                                <sec:authorize access="hasAnyRole('ENGINEER','ADMIN')">
                                                	<button class="btn btn-outline-info-add myBtn" id="BtnInsert" style="float:right">신규 등록</button>
                                                </sec:authorize>
                                                <span class="colorRed">리스트 삭제 및 고객사명, 사업명 수정은 데이터 무결성 문제로 현재 지원하지 않습니다. 안정화 후 추가 예정입니다. 필요 시 관리자 요청 바랍니다.</span>
                                                <span class="colorRed">엔지니어 분들께서는 사업명이 없는 고객사의 경우 신규 등록하여 사업명을 추가 바랍니다.</span>
                                            </div>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
													<!------- TUI-Grid ------->
													<div id="grid"></div>
													<!------- TUI-Grid ------->
                                                </div>
                                            </div>
                                        </div>
										<!-- table END -->
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
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			var customerName = $('#customerName').val();
			$.ajax({
				url : "<c:url value='/customerInfo'/>",
				method : 'POST',
				dataType:'json',
				data: {"customerName": customerName},
				success: function(result){
					grid.resetData(result.list);
					
				},
				error : function(result){
					console.log('ajax error');
				}
			});
			
			let rowList = document.querySelectorAll('td.tui-grid-cell');
			for(let i = 0 ; i < rowList.length ; ++i) {
				rowList[i].classList.remove('selected');	
			}
		};
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 고객사 정보 Modal ========= */
		function updateView(customerName, businessName) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/customerInfo/updateView'/>",
	            data: {
	            	"customerName" : customerName,
	            	"businessName" : businessName,
	            	},
	            success: function (data) {
	                $.modal(data, 'se'); //modal창 호출
	            },
	            error: function(e) {
	                console.log(e);
	            }
	        });
		}
		
		/* =========== 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/customerInfo/insertView'/>",
			    async: false,
			    success: function (data) {
			        $.modal(data, 'se'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
	</script>
</html>