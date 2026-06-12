<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','license5');
		    });
	    </script>
	    <script>
			$(document).ready(function(){
				const initialWidth = Math.min($(".page-wrapper").width(), 1650);

				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/license5'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['ID','구분','고객사명','사업명','추가정보','발급일','시작일','만료일','일련번호','MAC주소','제품유형','iGRIFFIN Agent 수량','TOS 5.0 Agent 수량','TOS 2.0 Agent 수량','DBMS 수량','Network 수량','AIX(OS) 수량','HPUX(OS) 수량','Solaris(OS) 수량','Linux(OS) 수량','Windows(OS) 수량','관리서버 OS','관리서버 DBMS','국가','제품버전','라이선스 파일명','요청자','담당 영업','메일 발송'],
					colModel:[
						{name:'licenseKeyNum', index:'licenseKeyNum', align:'center', width: 35, hidden:true },
						{name:'licenseType', index:'licenseType', align:'center', width: 60},
						{name:'customerName', index:'customerName', align:'center', width: 200},
						{name:'businessName', index:'businessName', align:'center', width: 250},
						{name:'additionalInformation', index:'additionalInformation', align:'center', width: 200},
						{name:'writeDate', index:'writeDate', align:'center', width: 80},
						{name:'issueDate', index:'issueDate', align:'center', width: 80},
						{name:'expirationDays', index:'expirationDays', align:'center', width: 80},
						{name:'serialNumber', index:'serialNumber',align:'center', width: 250},
						{name:'macAddress', index:'macAddress',align:'center', width: 300},
						{name:'productType', index:'productType', align:'center', width: 80},						
						{name:'igriffinAgentCount', index:'igriffinAgentCount', align:'center', width: 120},
						{name:'tos5AgentCount', index:'tos5AgentCount', align:'center', width: 120},
						{name:'tos2AgentCount', index:'tos2AgentCount', align:'center', width: 120},
						{name:'dbmsCount', index:'dbmsCount', align:'center', width: 120},
						{name:'networkCount', index:'networkCount', align:'center', width: 120},
						{name:'aixCount', index:'aixCount', align:'center', width: 100},
						{name:'hpuxCount', index:'hpuxCount', align:'center', width: 100},
						{name:'solarisCount', index:'solarisCount', align:'center', width: 100},
						{name:'linuxCount', index:'linuxCount', align:'center', width: 100},
						{name:'windowsCount', index:'windowsCount', align:'center', width: 100},
						{name:'managerOsType', index:'managerOsType', align:'center', width: 80},
						{name:'managerDbmsType', index:'managerDbmsType', align:'center', width: 80},
						{name:'country', index:'country', align:'center', width: 50},
						{name:'productVersion', index:'productVersion', align:'center', width: 100},
						{name:'licenseFilePath', index:'licenseFilePath', align:'center', width: 250},
						{name:'requester', index:'requester', align:'center', width: 80},
						{name:'salesManager', index:'salesManager', align:'center', width: 80},
						{name:'licenseKeyNum', index:'licenseKeyNum', align:'center', width: 80, formatter: individualMailSendFormatter},
					],
					jsonReader : {
			        	id: 'licenseKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        rowList:[25,50,100],
			        sortname: 'issueDate',		// 기본 정렬 
			        sortorder: 'desc',			// 정렬 방식
			        
			        multiselect: true,			// 체크박스를 이용한 다중선택
			        viewrecords: false,			// 시작과 끝 레코드 번호 표시
			        gridview: true,				// 그리드뷰 방식 랜더링
			        sortable: true,				// 컬럼을 마우스 순서 변경
			        height : '675',
			        autowidth:false,				// 가로 넒이 자동조절
					width: initialWidth,
			        shrinkToFit: false,			// 컬럼 폭 고정값 유지
			        altRows: false,				// 라인 강조
				}); 
				loadColumns('#list','licenseList');
			});
			
			$(window).on('resize.list', function () {
				const parentWidth = $(".page-wrapper").width();
				$("#list").jqGrid('setGridWidth', Math.min(parentWidth, 1650));
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
									            <h5 class="m-b-10">라이선스 5.0</h5>
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
													<div style="padding-left:15px; width:28.3%; float: left;">
														<label class="labelFontSize">시작일</label>
														<div>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="issueDateStart" name="issueDateStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 45.5%; float: left;" type="date" id="issueDateEnd" name="issueDateEnd" max="9999-12-31">
													  	</div>
													</div>
													<div style="padding-left:15px; width:60%; float: left;">
														<label class="labelFontSize">만료일</label>
														<div>
														  <input class="form-control" style="width: 21%; float: left;" type="date" id="expirationDaysStart" name="expirationDaysStart" max="9999-12-31">
														  <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px;"> ~ </span>
														  <input class="form-control" style="width: 21%; float: left;" type="date" id="expirationDaysEnd" name="expirationDaysEnd" max="9999-12-31">
													  	</div>
													</div>
													<div class="col-lg-2">
														<label class="labelFontSize">구분</label>
														<select class="form-control selectpicker" id="licenseTypeMulti" name="licenseTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														  <option value="(구)">(구)버전</option>
														  <option value="(신)">(신)버전</option>
													  </select>
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">고객사명</label>
														<select class="form-control selectpicker" id="customerNameMulti" name="customerNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${customerName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">사업명</label>
														<select class="form-control selectpicker" id="businessNameMulti" name="businessNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${businessName}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													
													<div class="col-lg-2">
		                      							<label class="labelFontSize">추가정보</label>
														<select class="form-control selectpicker" id="additionalInformationMulti" name="additionalInformationMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${additionalInformation}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>		                      							
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">제품유형</label>
														<select class="form-control selectpicker" id="productTypeMulti" name="productTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${productType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select> 
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">일련번호</label>
														<select class="form-control selectpicker" id="serialNumberMulti" name="serialNumberMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${serialNumber}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select> 
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">MAC 주소</label>
														<select class="form-control selectpicker" id="macAddressMulti" name="macAddressMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${macAddress}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
		                      							<label class="labelFontSize">iGRIFFIN Agent 수량</label>
		                      							<input type="number" id="igriffinAgentCount" name="igriffinAgentCount" class="form-control">
													</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">TOS 5.0 Agent 수량</label>
		                      							<input type="number" id="tos5AgentCount" name="tos5AgentCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">TOS 2.0 Agent 수량</label>
		                      							<input type="number" id="tos2AgentCount" name="tos2AgentCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">DBMS 수량</label>
		                      							<input type="number" id="dbmsCount" name="dbmsCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Network 수량</label>
		                      							<input type="number" id="networkCount" name="networkCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">AIX(OS) 수량</label>
		                      							<input type="number" id="aixCount" name="aixCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">HPUX(OS) 수량</label>
		                      							<input type="number" id="hpuxCount" name="hpuxCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Solaris(OS) 수량</label>
		                      							<input type="number" id="solarisCount" name="solarisCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Linux(OS) 수량</label>
		                      							<input type="number" id="linuxCount" name="linuxCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">Windows(OS) 수량</label>
		                      							<input type="number" id="windowsCount" name="windowsCount" class="form-control">
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">관리서버 OS</label>
		                      							<select class="form-control selectpicker" id="managerOsTypeMulti" name="managerOsTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${managerOsType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">관리서버 DBMS</label>
														<select class="form-control selectpicker" id="managerDbmsTypeMulti" name="managerDbmsTypeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${managerDbmsType}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
													</div>
													<div class="col-lg-2">
			                      						<label class="labelFontSize">국가</label>
			                      						<select class="form-control selectpicker" id="countryMulti" name="countryMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<option value="KR">KR</option>
															<option value="JP">JP</option>
															<option value="US">US</option>
															<option value="CN">CN</option>
														</select>
			                      					</div>
			                      					<div class="col-lg-2">
		                      							<label class="labelFontSize">제품 버전</label>
		                      							<select class="form-control selectpicker" id="productVersionMulti" name="productVersionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${productVersion}">
																<option value="${item}"><c:out value="${item}"/></option>
															</c:forEach>
														</select>
		                      						</div>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">라이선스 파일명</label>
		                      							<select class="form-control selectpicker" id="licenseFilePathMulti" name="licenseFilePathMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
															<c:forEach var="item" items="${licenseFilePath}">
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
													 	<input type="hidden" id="licenseType" name="licenseType" class="form-control">
			                      						<input type="hidden" id="customerName" name="customerName" class="form-control">
			                      						<input type="hidden" id="businessName" name="businessName" class="form-control">
			                      						<input type="hidden" id="additionalInformation" name="additionalInformation" class="form-control">
			                      						<input type="hidden" id="productType" name="productType" class="form-control">
			                      						<input type="hidden" id="serialNumber" name="serialNumber" class="form-control">
			                      						<input type="hidden" id="macAddress" name="macAddress" class="form-control">
			                      						<input type="hidden" id="managerOsType" name="managerOsType" class="form-control">
			                      						<input type="hidden" id="managerDbmsType" name="managerDbmsType" class="form-control">
			                      						<input type="hidden" id="country" name="country" class="form-control">
			                      						<input type="hidden" id="productVersion" name="productVersion" class="form-control">
			                      						<input type="hidden" id="licenseFilePath" name="licenseFilePath" class="form-control">
			                      						<input type="hidden" id="requester" name="requester" class="form-control">
			                      						<div class="col-lg-12 text-right">
														<p class="search-btn">
															<button class="btn2 btn-primary btnm" type="button" id="btnSearch">
																<i class="fa fa-search"></i>&nbsp;<span>검색</span>
															</button>
															<button class="btn2 btn-default btnm" type="button" id="btnReset">
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
															    <td>
																
															        <div class="work-toolbar">
																	
															            <div class="toolbar-title">🔑 라이선스 관리</div>
																	
															            <!-- 라이선스 -->
															            <div class="toolbar-group">
															                <div class="group-label">라이선스</div>
																		
															                <button class="btn2 btn-primary myBtn" id="BtnInsert">➕ 발급</button>
															                <button class="btn2 btn-warning myBtn" id="BtnUpdate">✏ 수정</button>
																		
															                <button class="btn2 btn-danger myBtn" id="BtnDelect">🗑 제거</button>
															                <button class="btn2 btn-reissue myBtn" id="BtnReIssue">🔄 재발급</button>
															            </div>
																	
															            <!-- 파일 -->
															            <div class="toolbar-group">
															                <div class="group-label">파일</div>
																		
															                <button class="btn2 btn-download myBtn" id="BtnDownload" title="선택한 테이블 행의 XML 파일을 다운로드합니다.">⬇ 라이선스 다운로드</button>
															                <button class="btn2 btn-upload myBtn" id="BtnImport" title="XML 파일을 첨부하여 데이터를 추가합니다.">⬆ XML Import</button>
															                <button class="btn2 btn-light2 myBtn" id="BtnExcelExport" onclick="doExportExec()">📤 Excel 내보내기</button>
															            </div>
																	
															            <!-- 설정 -->
															            <div class="toolbar-group">
															                <div class="group-label">설정</div>
																		
															                <button class="btn2 btn-setting myBtn" id="BtnRoute">⚙ 경로설정</button>
															                <button class="btn2 btn-setting myBtn" id="BtnMailSetting">📧 메일발송설정</button>
															            </div>
																	
															            <!-- 관리 -->
															            <div class="toolbar-group">
															                <div class="group-label">관리</div>
																		
															                <button class="btn2 btn-history myBtn" id="BtnIssueNote">📋 발급 이력</button>
															                <button class="btn2 btn-manager myBtn" id="BtnManagerChange">👤 담당자 변경</button>
															                <button class="btn2 btn-light2 myBtn" onclick="selectColumns('#list', 'licenseList');">⚙ 컬럼 선택</button>
															            </div>
																	
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
			    url: "<c:url value='/license5/issuedView'/>",
			    data: {
		    		"viewType" : "issued"
		    	},
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'license5'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});		
		});
		
		$('#BtnImport').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/license5/licenseXmlImportView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'xmlImport'); //modal창 호출
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
					  text: "선택한 라이선스를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
						url: "<c:url value='/license5/delete'/>",
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
		
		/* =========== 라이선스 발급 Key 확인 버튼 ========= */
		function licenseNumFormatter(value, options, row) {
			var licenseKeyNum = row.licenseKeyNum;
			return '<button class="btn2 btn-outline-info-nomal myBtn" onClick="licenseNumber(' + "'" + licenseKeyNum + "'"  + ')">라이선스 발급</button>';
		}
		
		/* =========== 라이선스 Key 확인 ========= */
		function licenseNumber(licenseKeyNum) {
			$.ajax({
	            type: 'POST',
	            url: "<c:url value='/license5/issueKey'/>",
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
			$('#licenseType').val($('#licenseTypeMulti').val().join());
			$('#customerName').val($('#customerNameMulti').val().join());
			$('#businessName').val($('#businessNameMulti').val().join());
			$('#additionalInformation').val($('#additionalInformationMulti').val().join());
			$('#productType').val($('#productTypeMulti').val().join());
			$('#serialNumber').val($('#serialNumberMulti').val().join());
			$('#macAddress').val($('#macAddressMulti').val().join());
			$('#managerOsType').val($('#managerOsTypeMulti').val().join());
			$('#managerDbmsType').val($('#managerDbmsTypeMulti').val().join());
			$('#country').val($('#countryMulti').val().join());
			$('#productVersion').val($('#productVersionMulti').val().join());
			$('#licenseFilePath').val($('#licenseFilePathMulti').val().join());
			$('#requester').val($('#requesterMulti').val().join());
			
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
			var expirationDaysStart = $("#expirationDaysStart").val();
			var expirationDaysEnd = $("#expirationDaysEnd").val();
			
			if(issueDateStart == "" && issueDateEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의 시작날짜를 입력해주세요.',    
					});
			} else if(issueDateEnd == "" && issueDateStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '시작일의  종료 날짜를 입력해주세요.',    
					});
			} else if(issueDateStart > issueDateEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '시작일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else if(expirationDaysStart == "" && expirationDaysEnd != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '만료일의 시작 날짜를 입력해주세요.',    
					});
			} else if(expirationDaysEnd == "" && expirationDaysStart != "") {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '만료일의 종료 날짜를 입력해주세요.',    
					});
			} else if(expirationDaysStart > expirationDaysEnd) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '만료일의 시작 날짜가 종료 날짜 보다 큽니다.',    
				}); 
			} else {
				tableRefresh();	
			}
		});
		
		
		/* =========== 경로 설정 ========= */
		$('#BtnRoute').click(function() {
			$.ajax({
				url: "<c:url value='/license/setting'/>",
				data: {"licenseVersion" : "5"},
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					$.modal(data, 'ssl'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
		});

		$('#BtnMailSetting').click(function() {
			$.ajax({
				url: "<c:url value='/license5/mailSetting'/>",
				data: "",
				type: "POST",
				traditional: true,
				async: false,
				success: function(data) {
					$.modal(data, 'mailSetting'); //modal창 호출
				},
				error: function(error) {
					console.log(error);
				}
			});
		});
		

		$('#BtnDownload').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList.length === 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});  
			} else {
				$.ajax({
					url: "<c:url value='/license5/license5DownLoadCheck'/>",
					type: "POST",
					data: {chkList: chkList},
					traditional: true,
					async: false,
					success: function(result) {
	            		if(result==="Empty") {
							Swal.fire(
							  '에러!',
							  'XML 파일이 존재하지 않거나, <br>존재하지 않는 리스트가 포함되어 있습니다.',
							  'error'
							)
						} else if(chkList.length === 1) {
							location.href="<c:url value='/license5/license5SingleDownLoad'/>?licenseKeyNum="+chkList;
						} else {
							location.href="<c:url value='/license5/license5MultiDownLoad'/>?licenseKeyNum="+chkList;
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
			
		});
		
		/* =========== 데이터 수정 Modal ========= */
		$('#BtnUpdate').click(function() {
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
		            url: "<c:url value='/license5/updateView'/>",
		            data: {"licenseKeyNum" : licenseKeyNum},
		            async: false,
		            success: function (data) {
		                $.modal(data, 'license5'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '수정를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});

		$('#BtnReIssue').click(function() {
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
		            url: "<c:url value='/license5/reIssueView'/>",
		            data: {"licenseKeyNum" : licenseKeyNum},
		            async: false,
		            success: function (data) {
		                $.modal(data, 'license5'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '수정를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		})

		$('#BtnIssueNote').click(function() {
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
		            url: "<c:url value='/license5/issueNoteView'/>",
		            data: {"licenseKeyNum" : licenseKeyNum},
		            async: false,
		            success: function (data) {
		                $.modal(data, 'issueNote'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
		        });
			} else {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '수정를 원하는 데이터 한 행만 체크 해주세요.',    
				}); 
			}
		});

		$('#BtnManagerChange').click(function() {
			var chkList = $("#list").getGridParam('selarrrow');
			if(chkList == 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '선택한 행이 존재하지 않습니다.',    
				});    
			} else {
				$.ajax({
		            type: 'POST',
		            url: "<c:url value='/license5/managerChangeView'/>",
					data: {chkList: chkList},
		            async: false,
					traditional: true, 
		            success: function (data) {
		                $.modal(data, 'sr'); //modal창 호출
		            },
		            error: function(e) {
		                // TODO 에러 화면
		            }
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

		function individualMailSendFormatter(cellValue, options, rowdata, action) {
			if(cellValue == '' || cellValue == null) {
				return '';
			}
			console.log(rowdata);
			if(rowdata.expirationDays != "무제한" && rowdata.maillYn == "Y") {
				return '<button type="button" class="btn2 btn-outline-info-nomal myBtn" onclick="individualMailSend('+"'"+cellValue+"'"+');">발송</button>';
			} else {
				return "";
			}
		}

		function individualMailSend(keyNum) {
			$.ajax({
		        type: 'POST',
		        url: "<c:url value='/license5/individualMailSend'/>",
		        data: {"licenseKeyNum" : keyNum},
		        async: false,
		        success: function (data) {
		            if(data == "OK")
						Swal.fire(
						  '발송!',
						  'Mail 발송하였습니다.',
						  'success'
						)
					else
						Swal.fire(
						  '실패!',
						  'Mail 발송 실패하였습니다.',
						  'error'
						)
		        },
		        error: function(e) {
		            Swal.fire(
					  '실패!',
					  '에러가 발생하였습니다.',
					  'error'
					)
		        }
		    });
		}
	</script>
	<style>
		.work-toolbar{
		    display:flex;
		    align-items:center;
		    gap:5px;
		    flex-wrap:wrap;
		
		    padding:5px;
		    background:#fafafa;
		    border:1px solid #e5e7eb;
		    border-radius:12px;
		}

		.toolbar-title{
		    font-size:18px;
		    font-weight:700;
		    color:#111827;
		    margin-right:10px;
		}

		.toolbar-group{
		    display:flex;
		    align-items:center;
		    gap:3px;
		
		    padding:10px 15px;
		
		    background:#fff;
		    border:1px solid #e5e7eb;
		    border-radius:10px;
		
		    box-shadow:0 1px 3px rgba(0,0,0,0.05);
		}

		.group-label{
		    font-size:12px;
		    color:#6b7280;
		    font-weight:600;
		    margin-right:5px;
		    white-space:nowrap;
		}

		.work-toolbar .btn2{
		    border-radius:8px !important;
		    font-size:12px !important;
		    font-weight:600 !important;
		    padding:6px 12px;
		    border:none;
		    transition:all 0.2s ease;
		}

		.work-toolbar .btn2:hover{
		    transform:translateY(-1px);
		}

		/* 추가 */
		.btn-primary{
		    background:#2563eb !important;
		    color:#fff !important;
		}

		/* 삭제 */
		.btn-danger{
		    background:#dc2626 !important;
		    color:#fff !important;
		}

		/* 처리완료 */
		.btn-success{
		    background:#22c55e !important;
		    color:#fff !important;
		}

		/* 상태변경 */
		.btn-warning{
		    background:#f59e0b !important;
		    color:#fff !important;
		}

		/* 국내/국외 이동 */
		.btn-info{
		    background:#0891b2 !important;
		    color:#fff !important;
		}

		/* 일반 버튼 */
		.btn-light2{
		    background:#ffffff !important;
		    color:#374151 !important;
		    border:1px solid #d1d5db !important;
		}

		/* 복사 */
		.btn-copy{
		    background:#8b5cf6 !important;
		    color:#fff !important;
		}

		/* 자동화 */
		.btn-automation{
		    background:#6366f1 !important;
		    color:#fff !important;
		}

		/* 보고서 조회 */
		.btn-report{
		    background:#10b981 !important;
		    color:#fff !important;
		}

		/* 템플릿 */
		.btn-template{
		    background:#f59e0b !important;
		    color:#fff !important;
		}

		/* 삭제 보고서 */
		.btn-delete-report{
		    background:#ef4444 !important;
		    color:#fff !important;
		}

		/* 국내/국외 이동 */
		.btn-move{
		    background:#0ea5e9 !important;
		    color:#fff !important;
		}

		.btn-primary:hover{
		    background:#1d4ed8 !important;
		}

		.btn-danger:hover{
		    background:#b91c1c !important;
		}

		.btn-success:hover{
		    background:#16a34a !important;
		}

		.btn-warning:hover{
		    background:#d97706 !important;
		}

		.btn-copy:hover{
		    background:#7c3aed !important;
		}

		.btn-automation:hover{
		    background:#4f46e5 !important;
		}

		.btn-report:hover{
		    background:#059669 !important;
		}

		.btn-template:hover{
		    background:#d97706 !important;
		}

		.btn-delete-report:hover{
		    background:#dc2626 !important;
		}

		.btn-move:hover{
		    background:#0284c7 !important;
		}
	</style>
</html>