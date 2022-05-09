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
	    	$.cookie('name',"generalPackage");
	    });
    </script>
	<script>
		$(document).ready(function(){
			var formData = $('#form').serializeObject();
			$("#list").jqGrid({
				url: "<c:url value='/generalPackage'/>",
				mtype: 'POST',
				postData: formData,
				datatype: 'json',
				colNames:['Key','패키지 종류','Version','릴리즈 노트'],
				colModel:[
					{name:'generalPackageKeyNum', index:'generalPackageKeyNum', align:'center', width: 100, hidden:true },
					{name:'managementServer', index:'managementServer', align:'center' ,width: 300, formatter: linkFormatter},
					{name:'agentVer', index:'agentVer', align:'center' ,width: 300},
					{name:'releaseNotes', index:'releaseNotes', align:'center', width: 300, formatter: releaseNotesFormatter, sortable:false},
				],
				jsonReader : {
		        	id: 'generalPackageKeyNum',
		        	repeatitems: false
		        },
		        pager: '#pager',			// 페이징
		        rowNum: 25,					// 보여중 행의 수
		        sortname: 'managementServer', 	// 기본 정렬 
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
                                          <h5 class="m-b-10">일반 패키지</h5>
                                          <p class="m-b-0">General Package</p>
                                      </div>
                                  </div>
                                  <div class="col-md-4">
                                      <ul class="breadcrumb-title">
                                          <li class="breadcrumb-item">
                                              <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
                                          </li>
                                          <li class="breadcrumb-item"><a href="#!">일반 패키지</a>
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
		                           	 	<table style="width:99%;">
											<tbody><tr>
												<td style="padding:0px 0px 0px 0px;" class="box">
													<table style="width:100%">
													<tbody><tr>
														<td style="font-weight:bold;">일반 패키지 관리 :
															<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
															<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
															<button class="btn btn-outline-info-nomal myBtn" id="BtnBatchDownload">일괄 다운로드</button>
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
    </div>
</body>

<script>
	/* =========== 추가 Modal ========= */
	$('#BtnInsert').click(function() {
		$.ajax({
		    type: 'POST',
		    url: "<c:url value='/generalPackage/insertView'/>",
		    async: false,
		    success: function (data) {
		        $.modal(data, 'sl'); //modal창 호출
		    },
		    error: function(e) {
		        // TODO 에러 화면
		    }
		});			
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
		return '<a onclick="updateView('+"'"+rowdata.generalPackageKeyNum+"'"+')" style="color:#366cb3;">' + cellValue + '</a>';
	}
	
	/* =========== 삭제 ========= */
	$('#BtnDelect').click(function() {
		var chkList = $("#list").getGridParam('selarrrow');
		console.log(chkList);
		if(chkList == "") {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '선택한 행이 존재하지 않습니다.',    
			});    
		} else {
			Swal.fire({
				  title: '삭제!',
				  text: "선택한 카테고리를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
					url: "<c:url value='/generalPackage/delete'/>",
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
	
	/* =========== 수정 Modal ========= */
	function updateView(data) {
		$.ajax({
            type: 'POST',
            url: "<c:url value='/generalPackage/updateView'/>",
            data: {"generalPackageKeyNum" : data},
            async: false,
            success: function (data) {
                $.modal(data, 's'); //modal창 호출
            },
            error: function(e) {
                // TODO 에러 화면
            }
        });
	}
	
	/* =========== 릴리즈 노트 포멧털 ========= */
	function releaseNotesFormatter(value, options, row) {
		var releaseNotes = row.releaseNotes.toUpperCase();
		return '<button class="btn btn-outline-info-nomal myBtn" onClick="fileDownload(' + "'" + releaseNotes + "'"  + ')">다운로드</button>';
	}
	
	/* =========== 릴리즈 노트 다운로드 ========= */
	function fileDownload(releaseNotes) {
		$.ajax({
            type: 'GET',
            url: "<c:url value='/generalPackage/fileDownload'/>",
            data: {"fileName" : releaseNotes},
            async: false,
            success: function (data) {
            	window.location ="<c:url value='/generalPackage/fileDownload?fileName="+releaseNotes+"'/>";
            	Swal.fire(
				  '처리완료!',
				  '처리 완료하였습니다.',
				  'success'
				)
            },
            error: function(e) {
            	Swal.fire(
				  '에러!',
				  '에러가 발생하였습니다.',
				  'error'
				)
            }
        });
	}
	

</script>
</html>