<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','empDump');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/empDumpEmpty'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:[''],
					colModel:[
						{name:'', index:'', align:'center', width: 400},
					],
					jsonReader : {
			        	id: 'serverListKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        height : '670',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        
				}); 
			});
			
			$(window).on('resize.list', function () {
			    jQuery("#list").jqGrid( 'setGridWidth', $(".page-wrapper").width() );
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
									            <h5 class="m-b-10">고객사 인사정보 파일</h5>
									            <p class="m-b-0">Customer Employee File</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">고객사 인사정보 파일</a>
									            </li>
									        </ul>
									    </div>
									</div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
	                                	
			                           	 	<table style="width:99%;">
												<tbody><tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="width: 110px; background: white; border-radius: 25px;">
																	<select class="form-control" id="empDumpCount" name="empDumpCount" data-size="5"  data-actions-box="true">
																		<option value="10">10개</option>
																		<option value="25">25개</option>
																		<option value="50">50개</option>
																		<option value="100">100개</option>
																		<option value="500">500개</option>
																		<option value="1000">1000개</option>
																	</select>
																</td>
																<td style="width: 170px; background: white; border-radius: 25px;">
																	<select class="form-control" id="empDumpCustomer" name="empDumpCustomer" data-size="5" data-actions-box="true">
																		<option value="">--- 고객사 선택 ---</option>
																		<option value="nhlife">NH농협생명</option>
																		<option value="kbank">KB카드</option>
																		<option value="nhqv">NH투자증권</option>
																	</select>
																</td>
																<td>
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert" style="height: 34px;">생성</button>
																</td>
															</tr>
															<tr>
																<td class="border1" colspan="3">
																	<!------- Grid ------->
																	<div class="jqGrid_wrapper">
																		<table id="list"></table>
																		<div id="pager"></div>
																	</div>
																	<!------- Grid ------->
																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tbody>
										</table>
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
		/* =========== 서버목록 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			var empDumpCount = $('#empDumpCount').val();
			var empDumpCustomer = $('#empDumpCustomer').val();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/empDump/create'/>",
			    data: {
					"empDumpCount": empDumpCount,
					"empDumpCustomer": empDumpCustomer
				},
			    async: false,
			    success: function (data) {
			    	
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});			
		});
		
		
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam();
			jqGrid.trigger('reloadGrid');
		}
		
		
		
	</script>
</html>