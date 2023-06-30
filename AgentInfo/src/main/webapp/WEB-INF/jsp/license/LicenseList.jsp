<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','license2');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/license'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','업체 명','사업명 / 설치 사유','발급일자','요청자','협력사명','OS','OS버전','커널버전','커널비트','TOS 버전','기간','MAC / UML / HostId','릴리즈타입','전달방법','라이선스 발급 Key',/* '라이선스 발급 번호' */],
					colModel:[
						{name:'licenseKeyNum', index:'licenseKeyNum', align:'center', width: 35, hidden:true },
						{name:'customerName', index:'customerName', align:'center', width: 200},
						{name:'businessName', index:'businessName', align:'center', width: 250},
						{name:'issueDate', index:'issueDate', align:'center', width: 80},
						{name:'requester', index:'requester', align:'center', width: 80},
						{name:'partners', index:'partners',align:'center', width: 150},
						{name:'osType', index:'osType',align:'center', width: 80},
						{name:'osVersion', index:'osVersion', align:'center', width: 150},
						{name:'kernelVersion', index:'kernelVersion', align:'center', width: 70},
						{name:'kernelBit', index:'kernelBit', align:'center', width: 70},
						{name:'tosVersion', index:'tosVersion', align:'center', width: 150},
						{name:'period', index:'period', align:'center', width: 70},
						{name:'macUmlHostId', index:'macUmlHostId', align:'center', width: 200},
						{name:'releaseType', index:'releaseType', align:'center', width: 100},
						{name:'deliveryMethod', index:'deliveryMethod', align:'center', width: 100},
						{name:'licenseIssueKey', index:'licenseIssueKey', align:'center', width: 200},
						//{name:'licenseNum', index:'licenseNum', align:'center', width: 150, formatter: licenseNumFormatter, sortable:false},
					],
					jsonReader : {
			        	id: 'licenseKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'licenseKeyNumOrigin',	// 기본 정렬 
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
				loadColumns('#list','licenseList');
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
									            <h5 class="m-b-10">라이선스 2.0</h5>
									            <p class="m-b-0">License Issuance</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">라이선스 발급</a>
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
		                      							<label class="labelFontSize">발급일자</label>
		                      							<div>
															<input class="form-control" style="width: 18.3%; float: left;" type="date" id="issueDateStart" name="issueDateStart" max="9999-12-31">
															<span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
															<input class="form-control" style="width: 18.3%; float: left;" type="date" id="issueDateEnd" name="issueDateEnd" max="9999-12-31">
														</div>
														<div style="padding-left: 50px; float: left;">
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="toDay" value="0">
															  <label class="form-check-label" for="toDay">
															    당일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="oneWeek" value="7">
															  <label class="form-check-label" for="oneWeek">
															    1주일
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="oneMonth" value="30">
															  <label class="form-check-label" for="oneMonth">
															    1개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="threeMonth" value="90">
															  <label class="form-check-label" for="threeMonth">
															    3개월
															  </label>
															</div>
															<div class="form-check radioDate">
															  <input class="form-check-input" type="radio" name="issueDate" id="dateFull" value="full" checked>
															  <label class="form-check-label" for="threeMonth">
															    전체
															  </label>
															</div>
														</div>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">업체명</label>
														<select class="form-control selectpicker" id="customerNameMulti" name="customerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${customerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사업명 / 설치 사유</label>
														<select class="form-control selectpicker" id="businessNameMulti" name="businessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${businessName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													
													<div class="col-lg-2">
		                      							<label class="labelFontSize">요청자</label>
														<select class="form-control selectpicker" id="requesterMulti" name="requesterMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${requester}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>		                      							
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">협력사명</label>
														<select class="form-control selectpicker" id="partnersMulti" name="partnersMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${partners}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select> 
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">OS</label>
														<select class="form-control selectpicker" id="osTypeMulti" name="osTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="Linux">Linux</option>
															<option value="Windows">Windows</option>
															<option value="AIX">AIX</option>
															<option value="HP-UX">HP-UX</option>
															<option value="MAC">MAC</option>
															<option value="Solaris">Solaris</option>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">OS버전</label>
														<select class="form-control selectpicker" id="osVersionMulti" name="osVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${osVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													
													<div class="col-lg-2">
		                      							<label class="labelFontSize">커널버전</label>
														<select class="form-control selectpicker" id="kernelVersionMulti" name="kernelVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${kernelVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">커널비트</label>
														<select class="form-control selectpicker" id="kernelBit" name="kernelBit" data-live-search="true" data-size="5" data-actions-box="true">
															<option value=""></option>
															<option value="64">64</option>
															<option value="32">32</option>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">TOS 버전</label>
														<select class="form-control selectpicker" id="tosVersionMulti" name="tosVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${tosVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">기간</label>
		                      							<input type="text" id="period" name="period" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC / UML / HostId</label>
		                      							<select class="form-control selectpicker" id="macUmlHostIdMulti" name="macUmlHostIdMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${macUmlHostId}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">릴리즈 타입</label>
														<select class="form-control selectpicker" id="releaseTypeMulti" name="releaseTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="Normal">Normal</option>
															<option value="Test">Test</option>
															<option value="Disable">Disable</option>
														</select>
													</div>
													<div class="col-lg-2">
			                      						<label class="labelFontSize">전달 방법</label>
			                      						<select class="form-control selectpicker" id="deliveryMethodMulti" name="deliveryMethodMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="메일">메일</option>
															<option value="대용량 메일">대용량 메일</option>
															<option value="CD">CD</option>
															<option value="점프호스트">점프호스트</option>
														</select>
			                      					</div>
			                      					<div class="col-lg-2">
		                      							<label class="labelFontSize">라이선스 발급 Key</label>
		                      							<input type="text" id="licenseIssueKey" name="licenseIssueKey" class="form-control">
		                      						</div>
			                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
			                      						<input type="hidden" id="businessName" name="businessName" class="form-control">
			                      						<input type="hidden" id="requester" name="requester" class="form-control">
			                      						<input type="hidden" id="partners" name="partners" class="form-control">
			                      						<input type="hidden" id="osType" name="osType" class="form-control">
			                      						<input type="hidden" id="osVersion" name="osVersion" class="form-control">
			                      						<input type="hidden" id="kernelVersion" name="kernelVersion" class="form-control">
			                      						<input type="hidden" id="tosVersion" name="tosVersion" class="form-control">
			                      						<input type="hidden" id="macUmlHostId" name="macUmlHostId" class="form-control">
			                      						<input type="hidden" id="releaseType" name="releaseType" class="form-control">
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
														<tbody>
															<tr>
																<td style="font-weight:bold;">라이선스 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert">발급</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnDelect">제거</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnCopy">복사</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnTxt">TXT저장</button>
																	<button class="btn btn-outline-info-nomal myBtn" id="BtnRoute">경로설정</button>
																	<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'licenseList');">컬럼 선택</button>
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
		/* =========== 라이선스 발급 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/license/issuedView'/>",
			    data: {
		    		"viewType" : "issued"
		    	},
			    async: false,
			    success: function (data) {
			    	//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
			    	$.modal(data, 'll'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});		
		});
		
		/* =========== 라이선스 발급 정보 제거 ========= */
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
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/license/delete'/>",
						type: "POST",
						data: {chkList: chkList},
						dataType: "text",
						traditional: true,
						async: false,
						success: function(data) {
							if(data == "OK")
								Swal.fire(
								  '성공!',
								  '제거 완료하였습니다.',
								  'success'
								)
							else
								Swal.fire(
								  '실패!',
								  '제거 실패하였습니다.',
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
		
		/* =========== 전달일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="issueDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
		
		/* =========== 라이선스 발급 Key 확인 버튼 ========= */
		function licenseNumFormatter(value, options, row) {
			var licenseKeyNum = row.licenseKeyNum;
			return '<button class="btn btn-outline-info-nomal myBtn" onClick="licenseNumber(' + "'" + licenseKeyNum + "'"  + ')">라이선스 발급</button>';
		}
		
		/* =========== 라이선스 Key 확인 ========= */
		function licenseNumber(licenseKeyNum) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/license/issueKey'/>",
	            data: {"licenseKeyNum" : licenseKeyNum},
	            async: false,
	            success: function (data) {
	            	if(data == "FALSE") {
	            		Swal.fire(
	      					  '실패!',
	      					  '라이선스 발급 Key가 존재하지 않습니다.',
	      					  'error'
	      					)
	            	} else {
		            	Swal.fire(
						  '라이선스 발급 Key!',
						  data,
						  'success'
						)
	            	}
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
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			$('#customerName').val($('#customerNameMulti').val().join());
			$('#businessName').val($('#businessNameMulti').val().join());
			$('#requester').val($('#requesterMulti').val().join());
			$('#partners').val($('#partnersMulti').val().join());
			$('#osType').val($('#osTypeMulti').val().join());
			$('#osVersion').val($('#osVersionMulti').val().join());
			$('#kernelVersion').val($('#kernelVersionMulti').val().join());
			$('#tosVersion').val($('#tosVersionMulti').val().join());
			$('#macUmlHostId').val($('#macUmlHostIdMulti').val().join());
			$('#releaseType').val($('#releaseTypeMulti').val().join());
			$('#deliveryMethod').val($('#deliveryMethodMulti').val().join());
			
			var _postDate = $("#form").serializeObject();
			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: _postDate });
			jqGrid.trigger('reloadGrid');
		}
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				tableRefresh();
			}
		});
		
		/* =========== 검색 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$("input[type='date']").val("");
			$("#dateFull").prop("checked",true);
	        
	        $('.selectpicker').val('');
	        $('.filter-option-inner-inner').text('');
			
			tableRefresh();
		});
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			tableRefresh();
		});
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			var issueDateStart = $("#issueDateStart").val();
			var issueDateEnd = $("#issueDateEnd").val();
			if(issueDateStart > issueDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '전달일자 시작일이 종료일자 보다 큽니다.',    
				});
			} else if(issueDateStart == "" && issueDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 시작일을 입력해주세요.',    
					});
			} else if(issueDateEnd == "" && issueDateStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '전달일자 종료일을 입력해주세요.',    
					});
			} else {
				tableRefresh();	
			}
			
		});
		
		/* =========== 발급일자 업데이트 ========= */
		function changeDate(term) {
			const dateTo = new Date();
 	        const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);
 	        
	        if(term == "full") {
	        	$("#issueDateStart").val("");
	        	$("#issueDateEnd").val("");
	        } else {
	        	$("#issueDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
	        	$("#issueDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
	        }
	    }
		
		/* =========== 발급일자 라이오 버튼 클릭 ========= */
		$(function() {
			$('input[name="issueDate"]').click(function() {
	            const value = $(this).val();
	            if (value !== undefined) {
	            	changeDate(value);
	            }
	        });
		});
		
		/* =========== TXT 저장 ========= */
		$('#BtnTxt').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
				url: "<c:url value='/license/txtTitle'/>",
				type: "POST",
				data: {chkList: chkList},
				traditional: true,
				async: false,
				success: function(data) {
					//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
				});
			}
		});
		
		/* =========== 경로 설정 ========= */
		$('#BtnRoute').click(function() {
			$.ajax({
				url: "<c:url value='/license/setting'/>",
				data: {"licenseVersion" : "2"},
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					//if(data.indexOf("<!DOCTYPE html>") != -1) 
					//	location.reload();
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
		});
		
		/* =========== 데이터 복사 Modal ========= */
		$('#BtnCopy').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			var licenseKeyNum = chkList[0];
			if(chkList.length == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else if(chkList.length == 1) {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/license/copyView'/>",
		            data: {"licenseKeyNum" : licenseKeyNum},
		            async: false,
		            success: function (data) {
		            	//if(data.indexOf("<!DOCTYPE html>") != -1) 
						//	location.reload();
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
	</script>
	<script>
		/* jqgrid 테이블 드래그 체크박스 선택 (부족하고 불편한 점이 있어 계속 수정할것) */
		$("#list").on('click','tr', function () {
			var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
			$("#list").jqGrid('setSelection', checkbox, true);
		});
		
		$("#list").on('mousedown','tr', function () {
			var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
			$("#list").jqGrid('setSelection', checkbox, true);
			var move = true;
			
			$("#list").on('mouseover','tr', function () {
				if(move) {
					var checkbox = $(this).find('td:first-child :checkbox')[0].id.substring(9);
					$("#list").jqGrid('setSelection', checkbox, true);
				}
			});
			$("#list").on('mouseup', 'tr', function () {
				move = false;				
			});
			$("body").on('mouseup', function () {
				move = false;				
			});
		});
		
	</script>
</html>