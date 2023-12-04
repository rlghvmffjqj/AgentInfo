<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
		<script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
	    	$(function() {
	    		$.cookie('name','serviceControl');
	    	});
    	</script>
		<script>
			$(document).ready(function(){
				var formData = $('#form').serializeObject();
				$("#list").jqGrid({
					url: "<c:url value='/serviceControl'/>",
					mtype: 'POST',
					postData: formData,
					datatype: 'json',
					colNames:['Key','사용 목적','서버 IP','PC전원','Tomcat','LogServer','EA','CA',/*'Agent',*/'DB','Disk(%)','Memory(%)','방화벽','JAVA 버전','Tomcat 버전','릴리즈 정보',/*'커널 정보',*/'DB 구분','서비스 설치 경로','Tomcat 설치 경로'],
					colModel:[
						{name:'serviceControlKeyNum', index:'serviceControlKeyNum', align:'center', width: 40, hidden:true },
						{name:'serviceControlPurpose', index:'serviceControlPurpose', align:'center', width: 150, formatter: urlFormatter},
						{name:'serviceControlIp', index:'serviceControlIp', align:'center', width: 100, formatter: linkFormatter},
						{name:'serviceControlPcPower', index:'serviceControlPcPower', align:'center', width: 70, formatter: pcPowerFormatter},
						{name:'serviceControlTomcat', index:'serviceControlTomcat', align:'center', width: 70, formatter: tomcatFormatter},
						{name:'serviceControlLogServer', index:'serviceControlLogServer', align:'center', width: 70, formatter: logServerFormatter},
						{name:'serviceControlScvEA', index:'serviceControlScvEA', align:'center', width: 70, formatter: scvEAFormatter},
						{name:'serviceControlScvCA', index:'serviceControlScvCA', align:'center', width: 70, formatter: scvCAFormatter},
						/*{name:'serviceControlAgent', index:'serviceControlAgent', align:'center', width: 100, formatter: agentFormatter},*/
						{name:'serviceControlDB', index:'serviceControlDB', align:'center', width: 70, formatter: databaseFormatter},
						{name:'serviceControlDisk', index:'serviceControlDisk', align:'center', width: 80},
						{name:'serviceControlMemory', index:'serviceControlMemory', align:'center', width: 80},
						{name:'serviceControlFirewall', index:'serviceControlFirewall', align:'center', width: 70, formatter: firewallFormatter},
						{name:'serviceControlJavaVersion', index:'serviceControlJavaVersion',align:'center', width: 100},
						{name:'serviceControlTomcatVersion', index:'serviceControlTomcatVersion',align:'center', width: 100},
						{name:'serviceControlRelease', index:'serviceControlRelease',align:'center', width: 200},
						// {name:'serviceControlKernel', index:'serviceControlKernel',align:'center', width: 200},
						{name:'serviceControlDbType', index:'serviceControlDbType',align:'center', width: 80, formatter: dbTypeFormatter},
						{name:'serviceControlServicePath', index:'serviceControlServicePath',align:'center', width: 150},
						{name:'serviceControlTomcatPath', index:'serviceControlTomcatPath',align:'center', width: 150},
					],
					jsonReader : {
			        	id: 'serviceControlKeyNum',
			        	repeatitems: false
			        },
			        pager: '#pager',			// 페이징
			        rowNum: 25,					// 보여중 행의 수
			        sortname: 'serviceControlKeyNum', 		// 기본 정렬 
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
				loadColumns('#list','serviceControlList');
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
								                <h5 class="m-b-10">서비스 제어</h5>
								                <p class="m-b-0">Service Control</p>
								            </div>
								        </div>
								        <div class="col-md-4">
								            <ul class="breadcrumb-title">
								                <li class="breadcrumb-item">
								                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
								                </li>
								                <li class="breadcrumb-item"><a href="#!">서비스 제어</a>
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
		                      						<sec:authorize access="hasRole('ADMIN')">
			                      						<div class="col-lg-2">
			                      							<label class="labelFontSize">사용 목적</label>
															<select class="form-control selectpicker" id="serviceControlPurposeMulti" name="serviceControlPurposeMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
																<c:forEach var="item" items="${serviceControlPurpose}">
																	<option value="${item}"><c:out value="${item}"/></option>
																</c:forEach>
															</select>
														</div>
														<div class="col-lg-2">
			                      							<label class="labelFontSize">서버 IP</label>
															<select class="form-control selectpicker" id="serviceControlIpMulti" name="serviceControlIpMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
																<c:forEach var="item" items="${serviceControlIp}">
																	<option value="${item}"><c:out value="${item}"/></option>
																</c:forEach>
															</select>
														</div>
													</sec:authorize>
		                      						<div class="col-lg-2">
		                      							<label class="labelFontSize">서버 상태</label>
		                      							<input type="text" id="serviceControlTomcat" name="serviceControlTomcat" class="form-control">
		                      						</div>
		                      						<div class="col-lg-12 text-right">
		                      							<input type="hidden" id="serviceControlPurposeSearch" name="serviceControlPurposeSearch" class="form-control">
		                      							<input type="hidden" id="serviceControlIpSearch" name="serviceControlIpSearch" class="form-control">
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
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
															<tbody>
																<tr>
																	<td style="font-weight:bold;">서비스 제어 :
																		<button class="btn btn-outline-info-add myBtn" id="BtnInsert">추가</button>
																		<button class="btn btn-outline-info-del myBtn" id="BtnDelect">삭제</button>
																		<button class="btn btn-outline-info-nomal myBtn" onclick="bntSynchronization();">동기화</button>
																		<button class="btn btn-outline-info-nomal myBtn" onclick="selectColumns('#list', 'serviceControlList');">컬럼 선택</button>
																		<div style="float: right;">
																			<span style="color: red;">미설치&nbsp;&nbsp;&nbsp; : </span>파일이 존재 하지 않음.<br>
																			<span style="color: #ffb300;">실행대기 : </span>파일은 존재하지만 서비스가 동작하지 않음.<br>
																			<span style="color: #25CD04;">실행 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </span>서비스 정상 동작
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
		<div id="loadingDiv" style="display:none;">
			<div id="loadingImgDiv">
				<img id="loadingImage" src="/AgentInfo/images/secuve_loading.gif" alt="Loading..." />
			</div>
		</div>
	</body>
	<script>
		/* =========== 서비스 추가 Modal ========= */
		$('#BtnInsert').click(function() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/serviceControl/insertView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'serviceControl'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});			
		});

		/* =========== 서비스 삭제 ========= */
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
					  text: "선택한 서비스를 삭제하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: 'OK'
				}).then((result) => {
				  	if (result.isConfirmed) {
						showLoadingImage();
					  	$.ajax({
							url: "<c:url value='/serviceControl/delete'/>",
							type: "POST",
							data: {chkList: chkList},
							dataType: "text",
							traditional: true,
							success: function(data) {
								hideLoadingImage();
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
								hideLoadingImage();
								console.log(error);
							}
					  	});
				  	}
				})
			}
		});

		/* =========== 동기화 ========= */
		function bntSynchronization() {
			showLoadingImage();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/serviceControl/synchronization'/>",
			    success: function (data) {
					hideLoadingImage();
					if(data == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						}).then((result) => {
							if (result.isConfirmed) {
	        					//tableRefresh();
								location.reload(true);
							}
						})

					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: "작업 실패 하였습니다.",
						});
					}
			    },
			    error: function(e) {
					hideLoadingImage();
			        alert(e);
			    }
			});
		}

		/* =========== jpgrid의 formatter 함수 ========= */
		function urlFormatter(cellValue, options, rowdata, action) {
			if(rowdata.serviceControlPort == "") {
				return cellValue
			}
			return '<a onclick="sitePageLink('+"'"+rowdata.serviceControlIp+"',"+"'"+rowdata.serviceControlPort+"'"+')" style="color:#366cb3; font-size: 12px;">' + cellValue + '</a>';
		}

		function sitePageLink(serviceControlIp, serviceControlPort) {
			if(serviceControlPort == "8080") {
				window.open('http://'+serviceControlIp+':'+serviceControlPort+'/TOSMS/LoginText', '_blank');
			} else if(serviceControlPort == "8443") {
				window.open('https://'+serviceControlIp+':'+serviceControlPort+'/TOSMS/LoginText', '_blank');
			}
		}

		/* =========== jpgrid의 formatter 함수 ========= */
		function linkFormatter(cellValue, options, rowdata, action) {
			return '<a onclick="updateView('+"'"+rowdata.serviceControlKeyNum+"'"+')" style="color:#366cb3; font-size: 12px;">' + cellValue + '</a>';
		}
		
		/* =========== 서비스 수정 Modal ========= */
		function updateView(data) {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/serviceControl/updateView'/>",
			    data: {"serviceControlKeyNum" : data},
			    async: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'serviceControl'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
		    });
		}
		
		/* =========== 검색 ========= */
		$('#btnSearch').click(function() {
			tableRefresh();
		});
		
		/* =========== 테이블 새로고침 ========= */
		function tableRefresh() {
			setTimerSessionTimeoutCheck() // 세션 타임아웃 리셋
			$('#serviceControlPurposeSearch').val($('#serviceControlPurposeMulti').val().join());
			$('#serviceControlIpSearch').val($('#serviceControlIpMulti').val().join());

			
			var jqGrid = $("#list");
			jqGrid.clearGridData();
			jqGrid.setGridParam({ postData: $("#form").serializeObject() });
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
		
		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function pcPowerFormatter(value, options, row) {
			var serviceControlPcPower = row.serviceControlPcPower;
			if(serviceControlPcPower == "on") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlPcPower == "off") {
				return '<div><img src="/AgentInfo/images/end.png" style="width:50px;"></div';
			} 
			return '<div></div>';
		}
		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function tomcatFormatter(value, options, row) {
			var serviceControlTomcat = row.serviceControlTomcat;
			if(serviceControlTomcat == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlTomcat == "notRunning") {
				return '<div><img src="/AgentInfo/images/notRun.png" style="width:50px;"></div';
			} else if(serviceControlTomcat == "notInstalled") {
				return '<div><img src="/AgentInfo/images/notInstalled.png" style="width:50px;"></div';
			} 
			return '<div></div>';
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function logServerFormatter(value, options, row) {
			var serviceControlLogServer = row.serviceControlLogServer;
			if(serviceControlLogServer == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlLogServer == "notRunning") {
				return '<div><img src="/AgentInfo/images/notRun.png" style="width:50px;"></div';
			} else if(serviceControlLogServer == "notInstalled") {
				return '<div><img src="/AgentInfo/images/notInstalled.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function scvEAFormatter(value, options, row) {
			var serviceControlScvEA = row.serviceControlScvEA;
			if(serviceControlScvEA == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlScvEA == "notRunning") {
				return '<div><img src="/AgentInfo/images/notRun.png" style="width:50px;"></div';
			} else if(serviceControlScvEA == "notInstalled") {
				return '<div><img src="/AgentInfo/images/notInstalled.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function scvCAFormatter(value, options, row) {
			var serviceControlScvCA = row.serviceControlScvCA;
			if(serviceControlScvCA == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlScvCA == "notRunning") {
				return '<div><img src="/AgentInfo/images/notRun.png" style="width:50px;"></div';
			} else if(serviceControlScvCA == "notInstalled") {
				return '<div><img src="/AgentInfo/images/notInstalled.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function agentFormatter(value, options, row) {
			var serviceControlAgent = row.serviceControlAgent;
			if(serviceControlAgent == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlAgent == "notRunning") {
				return '<div><img src="/AgentInfo/images/notRun.png" style="width:50px;"></div';
			} else if(serviceControlAgent == "notInstalled") {
				return '<div><img src="/AgentInfo/images/notInstalled.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function databaseFormatter(value, options, row) {
			var serviceControlDB = row.serviceControlDB;
			if(serviceControlDB == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlDB == "notRunning") {
				return '<div><img src="/AgentInfo/images/notRun.png" style="width:50px;"></div';
			} else if(serviceControlDB == "notInstalled") {
				return '<div><img src="/AgentInfo/images/notInstalled.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}

		/* =========== 상태에 따른 이미지 부여 ========= */
		function firewallFormatter(value, options, row) {
			var serviceControlFirewall = row.serviceControlFirewall;
			if(serviceControlFirewall == "execution") {
				return '<div><img src="/AgentInfo/images/run.png" style="width:50px;"></div';
			} else if(serviceControlFirewall == "notRunning") {
				return '<div><img src="/AgentInfo/images/end.png" style="width:50px;"></div';
			} else if(serviceControlFirewall == "unableConfirm") {
				return '<div><img src="/AgentInfo/images/unableConfirm.png" style="width:50px;"></div';
			}
			return '<div></div>';
		}

		
		/* =========== 상태에 따른 이미지 부여 ========= */
		function dbTypeFormatter(value, options, row) {
			var serviceControlDbType = row.serviceControlDbType;
			if(serviceControlDbType == "none") {
				return '<div></div';
			} 
			return '<div>'+serviceControlDbType+'</div>';
		}

		// 로딩 이미지를 보여주는 함수
		function showLoadingImage() {
		    $('#loadingDiv').show();
		}
	
		// 로딩 이미지를 숨기는 함수
		function hideLoadingImage() {
		    $('#loadingDiv').hide();
		}
	</script>
	<style>
		#loadingDiv {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0, 0, 0, 0.5); /* 반투명한 검은 배경 */
			justify-content: center;
			align-items: center;
			z-index: 9999; /* 다른 요소 위에 표시되도록 함 */
		}
	
		#loadingImage {
			width: 50px; /* 로딩 이미지의 너비 */
			height: 50px; /* 로딩 이미지의 높이 */
			background: url('secuve_loading.gif') no-repeat center center; /* 로딩 이미지 설정 */
			background-size: cover;
		}

		#loadingImgDiv {
			width: 100%;
    		height: 100%;
    		top: 50%;
    		left: 50%;
    		position: absolute;
		}
	</style>
</html>