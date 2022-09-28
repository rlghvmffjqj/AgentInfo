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
				   scrollX: true,
				   scrollY: true,
				   rowHeaders: ['checkbox'],
				   selectionUnit: 'row',
				   bodyHeight: 700,
				   columns: [
				  	{                      
				    	header: '고객사명',     
				      	name: 'customerName',
				      	align: 'center',
				      	formatter: function(rowData) {
				      		var customerInfoKeyNum = rowData.row.customerInfoKeyNum;
							return '<a style="color:#0000FE" onclick="updateView('+"'"+customerInfoKeyNum+"'"+');">' + rowData.value + '</a>';
			            },
			            width: 170,
				    },    
				    {                      
				    	header: '사업명',     
				      	name: 'businessName', 
				      	align: 'center',
				      	width: 150,
				    },  
				    {                      
				    	header: '망 구분',     
				      	name: 'networkClassification', 
				      	align: 'center',
				      	width: 80,
				    },  
				    {                      
				    	header: 'OS타입',     
				      	name: 'osType', 
				      	align: 'center',
				      	width: 80,
				    }, 
				    {                      
				    	header: 'TOSMS',     
				      	name: 'tosmsVer', 
				      	align: 'center',
				      	width: 260,
				    }, 
				    {                      
				    	header: 'TOSRF',     
				      	name: 'tosrfVer', 
				      	align: 'center',
				      	width: 260,
				    },  
				    {                      
				    	header: 'PORTAL',     
				      	name: 'portalVer', 
				      	align: 'center',
				      	width: 260,
				    },  
				    {                      
				    	header: 'LogServer',     
				      	name: 'logServerVer', 
				      	align: 'center',
				      	width: 260,
				    },  
				    {                      
				    	header: 'ScvEA',     
				      	name: 'scvEaVer', 
				      	align: 'center',
				      	width: 260,
				    },  
				    {                      
				    	header: 'ScvCA',     
				      	name: 'scvCaVer', 
				      	align: 'center',
				      	width: 260,
				    },
				    {                      
				    	header: 'Auth/PKI',     
				      	name: 'authPkiVer', 
				      	align: 'center',
				      	width: 260,
				    },
				    {                      
				    	header: 'JAVA',     
				      	name: 'javaVer', 
				      	align: 'center',
				      	width: 150,
				    },  
				    {                      
				    	header: 'WebServer',     
				      	name: 'webServerVer', 
				      	align: 'center',
				      	width: 150,
				    },  
				    {                      
				    	header: 'Database',     
				      	name: 'databaseVer', 
				      	align: 'center',
				      	width: 150,
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
				                                        <select class="form-control selectpicker search" id="customerNameSearch" name="customerName" data-live-search="true" data-size="5" data-actions-box="true">
				                                        	<option value="">All</option>
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
                                                <h5>신규 등록 전 고객사가 존재하는지 확인 후 등록 바랍니다.</h5>
                                                <sec:authorize access="hasAnyRole('ENGINEER','ADMIN')">
                                                	<button class="btn btn-outline-info-nomal myBtn" id="BtnRefresh" style="float:right">새로고침</button>
                                                	<button class="btn btn-outline-info-del myBtn" id="BtnDelect" style="float:right">삭제</button>
                                                	<button class="btn btn-outline-info-add myBtn" id="BtnInsert" style="float:right">신규 등록</button>
                                                </sec:authorize>
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
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			var customerName = $('#customerNameSearch').val();
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
		function updateView(customerInfoKeyNum) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/customerInfo/updateView'/>",
	            data: {
	            	"customerInfoKeyNum" : customerInfoKeyNum,
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
		
		/* =========== 고객사정보 삭제 ========= */
		$('#BtnDelect').click(function() {
			var chkList = grid.getCheckedRows();
			if(chkList == "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				Swal.fire({
					  title: '삭제!',
					  text: "선택한 고객사 정보를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: '예'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/customerInfo/delete'/>",
						type: "POST",
						contentType: 'application/json',
						data: JSON.stringify(chkList),
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '삭제 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '삭제 실패하였습니다.',
								  'error'
								)
							tableRefresh();
						},
						error: function(error) {
							console.log(error);
						}
					  });
				  	}
				})
			}
		});
		
		/* =========== 테이블 새로고침 ========= */
		$('#BtnRefresh').click(function() {
			tableRefresh();
		});
	</script>
</html>