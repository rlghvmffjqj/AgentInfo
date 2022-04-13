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
	    	$.cookie('name','packages');
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
				url: "<c:url value='/packages'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','고객사 명','요청일자','전달일자','패키지 종류','일반/커스텀','Agent ver','패키지명','담당자','OS종류','패키지 상세버전','Agent OS','기존/신규','요청 제품구분','전달 방법','비고'],
				colModel:[
					{name:'packagesKeyNum', index:'packagesKeyNum', align:'center', width: 25, hidden:true },
					{name:'customerName', index:'customerName', align:'center', width: 280, formatter: linkFormatter},
					{name:'requestDate', index:'requestDate', align:'center', width: 70},
					{name:'deliveryData', index:'deliveryData',align:'center', width: 70},
					{name:'managementServer', index:'managementServer', align:'center', width: 80},
					{name:'generalCustom', index:'generalCustom', align:'center', width: 60},
					{name:'agentVer', index:'agentVer', align:'center', width: 170},
					{name:'packageName', index:'packageName', align:'center', width: 650},
					{name:'manager', index:'manager', align:'center', width: 80},
					{name:'osType', index:'osType', align:'center', width: 60},
					{name:'osDetailVersion', index:'osDetailVersion', align:'center', width: 350},
					{name:'agentOS', index:'agentOS', align:'center', width: 120},
					{name:'existingNew', index:'existingNew', align:'center', width: 70},
					{name:'requestProductCategory', index:'requestProductCategory', align:'center', width: 90},
					{name:'deliveryMethod', index:'deliveryMethod', align:'center', width: 60},
					{name:'note', index:'note', align:'center', width: 600},
				],
				jsonReader : {
		        	id: 'packagesKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'packagesKeyNum',	// 기본 정렬 
		        sortorder: 'desc',			// 정렬 방식
		        
		        multiselect: true,			// 체크박스를 이용한 다중선택
		        viewrecords: false,			// 시작과 끝 레코드 번호 표시
		        gridview: true,				// 그리드뷰 방식 랜더링
		        sortable: true,				// 컬럼을 마우스 순서 변경
		        height : '670',
		        autowidth:true,				// 가로 넒이 자동조절
		        shrinkToFit: false,			// 컬럼 폭 고정값 유지
		        altRows: false,				// 라인 강조
			}); 
			loadColumns('#list','packagesList');
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
                                          <h5 class="m-b-10">패키지 배포 내용</h5>
                                          <p class="m-b-0">Package distribution content</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="index.html"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">패키지 배포 내용</a>
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
	                      						<div style="padding-left:15px; width:100%; float: left;">
	                      							<label class="labelFontSize">전달일자</label>
	                      							<div>
														<input class="form-control" style="width: 18.3%; float: left;" type="date" id="deliveryDataStart" name="deliveryDataStart">
														<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														<input class="form-control" style="width: 18.3%; float: left;" type="date" id="deliveryDataEnd" name="deliveryDataEnd">
													</div>
	                      						</div>
	                      						
	                      						
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">고객사 명</label>
													<input class="form-control" type="text" id="customerName" name="customerName"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">요청일자</label>
													<input class="form-control" type="date" id="requestDate" name="requestDate"> 
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지 종류</label>
													<select class="form-control selectpicker" id="managementServerStr" name="managementServerStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${managementServer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">일반/커스텀</label>
													<select class="form-control selectpicker" id="generalCustomStr" name="generalCustomStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${generalCustom}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">Agent ver</label>
													<select class="form-control selectpicker" id="agentVerStr" name="agentVerStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${agentVer}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
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
	                      							<label class="labelFontSize">OS종류</label>
													<select class="form-control selectpicker" id="osTypeStr" name="osTypeStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${osType}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
												<div class="col-lg-2">
	                      							<label class="labelFontSize">패키지 상세버전</label>
	                      							<input type="text" id="osDetailVersion" name="osDetailVersion" class="form-control">
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">Agent OS</label>
													<select class="form-control selectpicker" id="agentOSStr" name="agentOSStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${agentOS}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">기존/신규</label>
													<select class="form-control selectpicker" id="existingNewStr" name="existingNewStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${existingNew}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
												</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">요청 제품구분</label>
	                      							<select class="form-control selectpicker" id="requestProductCategoryStr" name="requestProductCategoryStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${requestProductCategory}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
	                      						</div>
	                      						<div class="col-lg-2">
	                      							<label class="labelFontSize">전달 방법</label>
	                      							<select class="form-control selectpicker" id="deliveryMethodStr" name="deliveryMethodStr" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${deliveryMethod}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
	                      						</div>
	                      						<input type="hidden" id="managementServer" name="managementServer" class="form-control">
	                      						<input type="hidden" id="generalCustom" name="generalCustom" class="form-control">
	                      						<input type="hidden" id="agentVer" name="agentVer" class="form-control">
	                      						<input type="hidden" id="osType" name="osType" class="form-control">
	                      						<input type="hidden" id="agentOS" name="agentOS" class="form-control">
	                      						<input type="hidden" id="existingNew" name="existingNew" class="form-control">
	                      						<input type="hidden" id="requestProductCategory" name="requestProductCategory" class="form-control">
	                      						<input type="hidden" id="deliveryMethod" name="deliveryMethod" class="form-control">
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
		                           	 	<table style="width:99%;">
											<tbody><tr>
												<td style="padding:0px 0px 0px 0px;" class="box">
													<table style="width:100%">
													<tbody><tr>
														<td style="font-weight:bold;">패키지 관리 :
															<sec:authorize access="hasRole('ADMIN')">
																<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																<button class="btn btn-outline-info-nomal myBtn" id="BtnCopy">복사</button>
																<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'packagesList');">컬럼 선택</button>
																<button class="btn btn-outline-info-nomal myBtn" id="BtnImport">Excel 가져오기</button>
															</sec:authorize>
															<button class="btn btn-outline-info-nomal myBtn" onClick="doExportExec()">Excel 내보내기</button>
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
	/* =========== Excel Import Modal ========= */
  	$('#BtnImport').click(function() {
  		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/importView'/>",
		    async: false,
		    success: function (data) {
		        $.modal(data, 's'); //modal창 호출
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});	
  	})
  	
	/* =========== 패키지 추가 Modal ========= */
	$('#BtnInsert').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/packages/insertView'/>",
		    async: false,
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
		var deliveryDataStart = $("#deliveryDataStart").val();
		var deliveryDataEnd = $("#deliveryDataEnd").val();
		if(deliveryDataStart > deliveryDataEnd) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '전달일자 시작일이 종료일자 보다 큽니다.',    
			});
		} else if(deliveryDataStart == "" && deliveryDataEnd != "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일을 입력해주세요.',    
				});
		} else if(deliveryDataEnd == "" && deliveryDataStart != "") {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 종료일을 입력해주세요.',    
				});
		} else {
			tableRefresh();	
		}
		
	});
	
	/* =========== 테이블 새로고침 ========= */
	function tableRefresh() {
		$('#managementServer').val($('#managementServerStr').val().join());
		$('#generalCustom').val($('#generalCustomStr').val().join());
		$('#agentVer').val($('#agentVerStr').val().join());
		$('#osType').val($('#osTypeStr').val().join());
		$('#agentOS').val($('#agentOSStr').val().join());
		$('#existingNew').val($('#existingNewStr').val().join());
		$('#requestProductCategory').val($('#requestProductCategoryStr').val().join());
		$('#deliveryMethod').val($('#deliveryMethodStr').val().join());
		
		var _postDate = $("#form").serializeObject();
		
		var jqGrid = $("#list");
		console.log(jqGrid.getGridParam("postData"));
		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: _postDate });
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
	
	/* =========== 갤린더 검색 ========= */
	$("#requestDate").change(function() {
		tableRefresh();
	});
	
	/* =========== Select Box 선택 ========= */
	$("select").change(function() {
		tableRefresh();
	});
	
	/* =========== 검색 초기화 ========= */
	$('#btnReset').click(function() {
		$("input[type='text']").val("");
		$("input[type='date']").val("");
        
        $('.selectpicker').val('');
        $('.filter-option-inner-inner').text('');
		
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
				  text: "선택한 패키지를 삭제하시겠습니까?",
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
	
	/* =========== 데이터 복사 Modal ========= */
	$('#BtnCopy').click(function() {
		var chkList = $("#list").getGridParam('selarrrow');
		var packagesKeyNum = chkList[0];
		if(chkList.length == 0) {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '선택한 행이 존재하지 않습니다.',    
			});    
		} else if(chkList.length == 1) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/packages/copyView'/>",
	            data: {"packagesKeyNum" : packagesKeyNum},
	            async: false,
	            success: function (data) {
	                $.modal(data, 'll'); //modal창 호출
	            },
	            error: function(e) {
	                // TODO 에러 화면
	            }
	        });
		} else {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '복사를 원하는 데이터 한 행만 체크 해주세요.',    
			}); 
		}
	});
	
	/* =========== 패키지 수정 Modal ========= */
	function updateView(data) {
		<sec:authorize access="hasRole('ADMIN')">
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/packages/updateView'/>",
	            data: {"packagesKeyNum" : data},
	            async: false,
	            success: function (data) {
	                $.modal(data, 'll'); //modal창 호출
	            },
	            error: function(e) {
	                // TODO 에러 화면
	            }
	        });
		</sec:authorize>
	}
	
	


</script>
</html>