<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
  <head>
	<%@ include file="/WEB-INF/view/common/_Head.jsp"%>
    <!-- 쿠키 스크립트 -->
    <script>
    	/* =========== 페이지 쿠키 값 저장 ========= */
	    $(function() {
	    	$.cookie('name','packages');
	    });
    </script>
    <script>
		/* =========== ajax _csrf 전송 ========= */
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		});
	</script>
	<script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/packages'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','고객사명','요청일자','전달일자','기존/신규','관리서버/Agent','Agent OS','OS 상세버전','일반/커스텀','OS 종류','Agent ver','패키지명','담당자','요청 제품구분','전달 방법','기존 Agent 버전','기존 Manager(War) 버전','Manager OS','DB','PKI & AuthClient','비고'],
				colModel:[
					{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 100, hidden:true},
					{name:'customerName', index:'customerName', align:'center', width: 150, formatter: linkFormatter},
					{name:'requestDate', index:'requestDate', align:'center', width: 150},
					{name:'deliveryData', index:'deliveryData',align:'center', width: 150},
					{name:'existingNew', index:'existingNew', align:'center', width: 150},
					{name:'managementServer', index:'managementServer', align:'center', width: 150},
					{name:'agentOS', index:'agentOS', align:'center', width: 150},
					{name:'osDetailVersion', index:'osDetailVersion', align:'center', width: 450},
					{name:'generalCustom', index:'generalCustom', align:'center', width: 150},
					{name:'osType', index:'osType', align:'center', width: 150},
					{name:'agentVer', index:'agentVer', align:'center', width: 150},
					{name:'packageName', index:'packageName', align:'center', width: 700},
					{name:'manager', index:'manager', align:'center', width: 150},
					{name:'requestProductCategory', index:'requestProductCategory', align:'center', width: 150},
					{name:'deliveryMethod', index:'deliveryMethod', align:'center', width: 150},
					{name:'existingAgentVersion', index:'existingAgentVersion', align:'center', width: 150},
					{name:'legacyManagerVersion', index:'legacyManagerVersion', align:'center', width: 150},
					{name:'managerOS', index:'managerOS', align:'center', width: 150},
					{name:'db', index:'db', align:'center', width: 150},
					{name:'pkiAuthClient', index:'pkiAuthClient', align:'center', width: 150},
					{name:'note', index:'note', align:'center', width: 150},
				],
				jsonReader : {
		        	id: 'packagesKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 30,					// 보여중 행의 수
		        sortname: 'packagesKeyNum',	// 기본 정렬 
		        sortorder: 'asc',			// 정렬 방식
		        
		        multiselect: true,			// 체크박스를 이용한 다중선택
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: true,				// 컬럼을 마우스 순서 변경
		        height : '790',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: false,			// 컬럼 폭 고정값 유지
		        altRows: false,				// 라인 강조


			}); 
			/* loadColumns('#list','userAccountList'); */
			//$("#list").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false, search: true });
		});
		
			
	</script>
  </head>
  <body>
  
  <div id="pcoded" class="pcoded iscollapsed">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
          <%@ include file="/WEB-INF/view/common/_TopMenu.jsp"%>

          <div class="pcoded-main-container" style="margin-top: 56px;">
              <div class="pcoded-wrapper">
                  <%@ include file="/WEB-INF/view/common/_LeftMenu.jsp"%>
                  <div class="pcoded-content" id="page-wrapper">
                      <div class="page-header">
                          <div class="page-block">
                              <div class="row align-items-center">
                                  <div class="col-md-8">
                                      <div class="page-header-title" >
                                          <h5 class="m-b-10">패키지 배포 내용</h5>
                                          <p class="m-b-0">Package distribution content</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="index.html"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">패키지</a>
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
	                      							<label class="labelFontSize">고객사명</label>
													<input type="text" id="customerName" name="customerName" class="form-control"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">기존/신규</label>
	                      							<select class="form-control" id="existingNew" name="existingNew">
														<option value=""></option>
														<option value="기존">기존</option>
														<option value="신규">신규</option>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">관리서버/Agent</label>
	                      							<select class="form-control" id="managementServer" name="managementServer">
														<option value=""></option>
														<option value="관리서버">관리서버</option>
														<option value="Agent">Agent</option>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">Agent OS</label>
	                      							<input type="text" id="agentOS" name="agentOS" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">OS 상세버전</label>
	                      							<input type="text" id="osDetailVersion" name="osDetailVersion" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">OS종류</label>
	                      							<select class="form-control" id="osType" name="osType">
														<option value=""></option>
														<option value="Linux">Linux</option>
														<option value="Windows">Windows</option>
														<option value="Unix">Unix</option>
														<option value="UnixLinux">UnixLinux</option>
														<option value="AIX">AIX</option>
														<option value="HP-UX">HP-UX</option>
														<option value="SunOS">SunOS</option>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">Agent ver</label>
	                      							<input type="text" id="agentVer" name="agentVer" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지명</label>
	                      							<input type="text" id="packageName" name="packageName" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">담당자</label>
	                      							<input type="text" id="manager" name="manager" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">요청제품 구분</label>
	                      							<input type="text" id="requestProductCategory" name="requestProductCategory" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">전달 방법</label>
	                      							<input type="text" id="deliveryMethod" name="deliveryMethod" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">DB</label>
	                      							<select class="form-control" id="db" name="db">
														<option value=""></option>
														<option value="tibero">tibero</option>
														<option value="MySQL">MySQL</option>
														<option value="MSSQL">MSSQL</option>
														<option value="Oracle">Oracle</option>
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
														<td style="font-weight:bold;">패키지 관리 :
															<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
															<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
															<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'userAccountList');">컬럼 선택</button>
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
	/* =========== 패키지 추가 Modal ========= */
	$('#BtnInsert').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/insertView'/>",
		    success: function (data) {
		        $.modal(data, 'll'); //modal창 호출
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
		return '<a onclick="updateView('+"'"+rowdata.packagesKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
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
	
	/* =========== 패키지 삭제 ========= */
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
				  text: "선택한 패키지지 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
					url: "<c:url value='/packages/delete'/>",
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
	
	/* =========== 패키지 수정 Modal ========= */
	function updateView(data) {
		$.ajax({
            type: 'POST',
            url: "<c:url value='/packages/updateView'/>",
            data: {"packagesKeyNum" : data},
            success: function (data) {
                $.modal(data, 'll'); //modal창 호출
            },
            error: function(e) {
                // TODO 에러 화면
            }
        });
	}


</script>
</html>