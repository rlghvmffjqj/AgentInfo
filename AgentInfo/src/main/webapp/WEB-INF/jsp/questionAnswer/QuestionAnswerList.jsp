<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','questionAnswer');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/question'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','제목','상태','이름','날짜','조회'],
					colModel:[
						{name:'questionKeyNum', index:'questionKeyNum', align:'center', width: 35, hidden:true },
						{name:'questionTitle', index:'questionTitle', align:'center', width: 600, align:'left', formatter: linkFormatter},
						{name:'questionState', index:'questionState', align:'center', width: 150},
						{name:'employeeName', index:'employeeName', align:'center', width: 150, formatter: nameFormatter},
						{name:'questionDate', index:'questionDate', align:'center', width: 150},
						{name:'questionCount', index:'questionCount', align:'center', width: 150},
					],
					jsonReader : {
			        	id: 'questionKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 15,					// 보여중 행의 수
			        sortname: 'questionKeyNum',	// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			    
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '570',
			        autowidth:true,				// 가로 넒이 자동조절
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
					rownumbers : true,
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
									            <h5 class="m-b-10">Q & A</h5>
									            <p class="m-b-0">Question & Answer</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">Q & A</a>
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
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
															<tbody>
																<tr>
																	<td>
																		<div>
																			<form id="form" name="form" method ="post">
																				<div style="width: 100px; float: left; padding-right: 5px; margin-top: -1px;">
																		  			<select class="form-control selectpicker" id="search" name="search" data-size="5" data-actions-box="true">
																					  	<option value="글제목">글제목</option>
																					  	<option value="글제목내용">글제목+내용</option>
																						<option value="이름">이름</option>
																		  			</select>
																				</div>
																		  		<input type="text" id="searchInput" name="searchInput" class="form-control" style="float: left; width: 250px;">
																		  		<button class="btn btn-primary btnm" type="button" id="btnSearch" style="float: left; min-width: 0px !important; height: 32px">
																					<i class="fa fa-search"></i>&nbsp;<span>검색</span>
																				</button>
																			</form>
																	  </div>
																	</td>
																</tr>
																<tr>
																	<td class="border1" colspan="2">
																		<!------- Grid ------->
																		<div class="jqGrid_wrapper">
																			<table id="list"></table>
																			<div id="pager"></div>
																		</div>
																		<!------- Grid ------->
																	</td>
																</tr>
																<tr>
																	<td>
																		<button class="btn btn-outline-info-add myBtn questionWrite" id="btnInsert" onclick="btnInsert()">글쓰기</button>
																	</td>
																</tr>
															</tbody>
														</table>
													</td>
												</tr>
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
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();	
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋

			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.questionKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
		}
				
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				event.preventDefault();
				tableRefresh();
			}
		});

		function btnInsert() {
			location.href="<c:url value='/question/write'/>";
		}

		function updateView(keyNum) {
			var form = document.createElement("form");
  			form.method = "POST";
  			form.action = "<c:url value='/question/view'/>"; // 이동할 페이지의 URL을 지정

  			// 폼에 값을 추가
  			var input1 = document.createElement("input");
  			input1.type = "hidden"; // 숨겨진 필드로 설정
  			input1.name = "questionKeyNum"; // 서버에서 사용할 파라미터 이름
  			input1.value = keyNum; // 전달할 값
  			form.appendChild(input1);

  			// 폼을 문서에 추가하고 자동으로 제출
  			document.body.appendChild(form);
  			form.submit();
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function nameFormatter(value, options, row) {
			var employeeId = row.employeeId;
			if("${role}" == "ADMIN") {
				return row.employeeName;
			}
			if("${writer}" != employeeId) {
				return "***";
			}
			return row.employeeName;
		}
			
	</script>

	<style>
		.ui-jqgrid tr.ui-row-ltr td {
			border-right-style: none !important;
			height: 35px;
		}
		
		.ui-state-default, .ui-widget-content .ui-state-default {
			border-right: none;
		}

		.questionWrite {
			float: right;
			width: 100px;
			height: 40px;
			margin-top: 5px;
		}
	</style>
</html>