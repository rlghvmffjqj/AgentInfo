<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
  <head>
	<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <!-- 쿠키 스크립트 -->
    <script>
    	/* =========== 페이지 쿠키 값 저장 ========= */
	    $(function() {
	    	$.cookie('name','employee');
	    });
    </script>
    <script>
		/* =========== ajax _csrf 전송 ========= */
		/* $(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		}); */
	</script>
	<script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/employee'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['사원번호','부서명','사원명','이메일','직급','타입','전화번호','상태','역할'],
				colModel:[
					{name:'employeeId', index:'employeeId', align:'center', width: 200, formatter: linkFormatter},
					{name:'departmentName', index:'departmentName', align:'center' ,width: 200},
					{name:'employeeName', index:'employeeName',align:'center'},
					{name:'employeeEmail', index:'employeeEmail', width: 180, align:'center'},
					{name:'employeeRank', index:'employeeRank', align:'center'},
					{name:'employeeType', index:'employeeType', align:'center'},
					{name:'employeePhone', index:'employeePhone', width: 180, align:'center'},
					{name:'employeeStatus', index:'employeeStatus', align:'center'},
					{name:'usersRole', index:'usersRole', align:'center'},
				],
				jsonReader : {
		        	id: 'employeeId',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'employeeId', 	// 기본 정렬 
		        sortorder: 'asc',			// 정렬 방식
		        
		        multiselect: true,			// 체크박스를 이용한 다중선택
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: true,				// 컬럼을 마우스 순서 변경
		        height : '670',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: false,			// 컬럼 폭 고정값 유지
		        altRows: false,				// 라인 강조
			}); 
			loadColumns('#list','employeeList');
			setAutoResize('#list',810);
		});
			
	</script>
  </head>
  <body>
  
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
                                      <div class="page-header-title" >
                                          <h5 class="m-b-10">사원 목록</h5>
                                          <p class="m-b-0">Employee List</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="index.html"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">사원</a>
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
	                                	<div class="searchbos">
	                      					<form id="form" name="form" method ="post"> 
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">사원번호</label>
													<input type="text" id="employeeId" name="employeeId" class="form-control"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">사원명</label>
	                      							<input type="text" id="employeeName" name="employeeName" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">부서명</label>
	                      							<input type="text" id="departmentName" name="departmentName" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">전화번호</label>
	                      							<input type="text" id="employeePhone" name="employeePhone" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">타입</label>
	                      							<select class="form-control" id="employeeType" name="employeeType">
														<option value=""></option>
														<option value="정사원">정사원</option>
														<option value="외주">외주</option>
														<option value="인턴">인턴</option>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">직급</label>
													<input type="text" id="employeeRank" name="employeeRank" class="form-control">
	                      						</div><br>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">상태</label>
	                      							<select class="form-control" id="employeeStatus" name="employeeStatus">
														<option value=""></option>
														<option value="재직">재직</option>
														<option value="퇴사">퇴사</option>
														<option value="휴직">휴직</option>
													</select>
	                      						</div>
	                      						<div class="col-lg-12 text-right">
												<p class="search-btn">
													<button class="btn btn-primary btnm" type="button" id="btnSearch">
														<i class="fa fa-search"></i>&nbsp;<span>검색</span>
													</button>
													<button class="btn btn-default btnm" type="button" id="btnReset">
														<span>초기화</span>
													</button>
												</p>
											</div>
	                      						
	                      					</form>
	                     				</div>
                     				 </div>
		                           	 	<table style="width:100%;">
											<tbody><tr>
												<td style="padding:0px 0px 0px 0px;" class="box">
													<table style="width:100%">
													<tbody><tr>
														<td style="font-weight:bold;">사원 관리 :
															<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
															<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
															<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'employeeList');">컬럼 선택</button>
															<!-- <button class="btn btn-outline-info-nomal myBtn" id="BtnLeave">퇴사</button> -->
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
	/* =========== 사원 추가 Modal ========= */
	$('#BtnInsert').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/employee/insertView'/>",
		    success: function (data) {
		        $.modal(data, 'l'); //modal창 호출
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});			
	});
	
	/* =========== 검색 ========= */
	$('#btnSearch').click(function() {
		tableRefresh();
	});
	
	/* =========== 테이블 새로고침 ========= */
	function tableRefresh() {
		var jqGrid = $("#list");
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: $("#form").serializeObject() });
		jqGrid.trigger('reloadGrid');
	}

	/* =========== jpgrid의 formatter 함수 ========= */
	function linkFormatter(cellValue, options, rowdata, action) {
		return '<a onclick="updateView('+"'"+rowdata.employeeId+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}
	
	/* =========== Enter 검색 ========= */
	$("input[type=text]").keypress(function(event) {
		if (window.event.keyCode == 13) {
			tableRefresh();
		}
	});
	
	/* =========== Select Box 선택 ========= */
	$("select").change(function() {
		tableRefresh();
	});
	
	/* =========== 검색 초기화 ========= */
	$('#btnReset').click(function() {
		$("input[type='text']").val("");
		$("select").each(function(index){
			$("option:eq(0)",this).prop("selected",true);
		});
		tableRefresh();
	});
	
	/* =========== 사원 삭제 ========= */
	$('#BtnDelect').click(function() {
		var chkList = $("#list").getGridParam('selarrrow');
		if(chkList == 0) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '선택한 행이 존재하지 않습니다.',    
			});    
		} else {
			Swal.fire({
				  title: '삭제!',
				  text: "선택한 사원을 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
					url: "<c:url value='/employee/delete'/>",
					type: "POST",
					data: {chkList: chkList},
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						console.log(data);
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
	
	/* =========== 사원 수정 Modal ========= */
	function updateView(data) {
		$.ajax({
            type: 'POST',
            url: "<c:url value='/employee/updateView'/>",
            data: {"employeeId" : data},
            success: function (data) {
                $.modal(data, 'l'); //modal창 호출
            },
            error: function(e) {
                // TODO 에러 화면
            }
        });
	}


</script>
</html>