<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
		$(function() {
	    	if("${functionTestType}"=="tortal")
	    		$.cookie('name','functionTestTortal');
	    	if("${functionTestType}"=="basic")
	    		$.cookie('name','functionTestBasic');
	    	if("${functionTestType}"=="foundation")
	    		$.cookie('name','functionTestFoundation');
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
							                <h5 class="m-b-10">기능 테스트</h5>
							                <p class="m-b-0">Function Test</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">기능 테스트</a>
							                </li>
							            </ul>
							        </div>
							    </div>
							</div>
						</div>
			                <div>
			                	<button class='btn btn-secondary divisionActive' id='TOSMS' style='float: left;'>TOSMS</button>
			                	<button class='btn btn-secondary' id='Agent'>Agent</button>
			                	<input type='hidden' id='functionTestSettingDivision' name='functionTestSettingDivision' value='TOSMS'>
			                </div>
			                <form id="form" name="form" method ="post">
				                <div class='main-body'>
				                    <div class='page-wrapper'>
				                    	<div class='ibox'>
				                    		<div class="searchbos">
				                    			<div class="col-lg-2">
		                      						<label class="labelFontSize">고객사명</label><span class="colorRed" id="NotFunctionTestCustomer" style="display: none; line-height: initial;">고객사 필수 입력 바랍니다.</span>
		                      						<input type="text" id="functionTestCustomer" name="functionTestCustomer" class="form-control" value="${functionTestTitle.functionTestCustomer}">
		                      					</div>
		                      					<div class="col-lg-2">
		                      						<label class="labelFontSize">Title</label>
		                      						<input type="text" id="functionTestTitle" name="functionTestTitle" class="form-control" value="${functionTestTitle.functionTestTitle}">
		                      					</div>
		                      					<div class="col-lg-2">
		                      						<label class="labelFontSize">날짜</label>
		                      						<input type="date" id="functionTestDate" name="functionTestDate" class="form-control" value="${functionTestTitle.functionTestDate}">
		                      					</div>
				                    		</div>
				                    	</div>
				                    </div>
				                </div>
				                <div class='main-body' id='main-TOSMS'>
				                    <div class='page-wrapper'>
				                    	<div class='ibox'>
			                    			<div class='formDiv'>
					                    		<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormTOSMS}">
					                    			<c:if test="${functionTestSettingFormList.functionTestSettingDivision eq 'TOSMS'}">
						                    			<div class='functionTestForm' id='form_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
							                    			<div class='functionTestCommand'>
							                    				<button type="button" class='btn btn-primary formBtn' onClick="functionTestForm(${functionTestSettingFormList.functionTestSettingFormKeyNum})" style="box-shadow: 0px 3px 3px grey;">${functionTestSettingFormList.functionTestSettingFormName}</button>
							                    			</div>
							                    		</div>
							                    	</c:if>
						                    	</c:forEach>
			                    			</div>
				                    		<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormTOSMS}">
					                    		<div class='categoryDiv' id='categoryDiv_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
					                    			<c:forEach var='functionTestSettingCategoryList' items="${functionTestSettingCategory}">
					                    				<c:if test="${functionTestSettingFormList.functionTestSettingFormKeyNum eq functionTestSettingCategoryList.functionTestSettingFormKeyNum}"> 
							                				<div class='categorySmallDiv'>
							                					<div style='height: 45px;'>
									                				<span class="categorySpan">${functionTestSettingCategoryList.functionTestSettingCategoryName}</span>
									                			</div>
									                			<c:forEach var='functionTestSettingSubCategoryList' items='${functionTestSettingSubCategory}'>
									                				<c:if test='${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum eq functionTestSettingSubCategoryList.functionTestSettingCategoryKeyNum}'>
										                				<div class='subCategoryDiv'>
											                				<div class="checkbox-group">
																				<label>
																					<c:if test="${viewType eq 'insert'}">
																						<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox"  value='empty'>
																					</c:if>
																					<c:if test="${viewType eq 'update'}">
																						<c:forEach var='functionTestList' items='${functionTest}'>
																							<c:if test='${functionTestList.functionTestKeyNum eq functionTestTitle.functionTestKeyNum}'>
																								<c:if test='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum eq functionTestList.functionTestSettingSubCategoryKeyNum}'>
																									<c:if test="${functionTestList.functionTestSubCategoryState eq 'success'}">
																										<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox success"  value='success'>
																									</c:if>
																									<c:if test="${functionTestList.functionTestSubCategoryState eq 'failure'}">
																										<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox failure"  value='failure'>
																									</c:if>
																									<c:if test="${functionTestList.functionTestSubCategoryState eq 'empty'}">
																										<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox empty"  value='empty'>
																									</c:if>
																								</c:if>
																							</c:if>
																						</c:forEach>
																						<c:if test='${not functionTestFunctionTestSettingSubCategoryKeyNum.contains(functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum)}'>
																							<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox empty"  value='empty'>
																						</c:if>
																					</c:if>
																					<span class="checkmark"></span>
																				</label>
																			</div>
																			<input type="hidden" value="${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum}" name="functionTestSettingSubCategoryKeyNumList">
																			<span class="subCategorySpan">${functionTestSettingSubCategoryList.functionTestSettingSubCategoryName}</span>
																			<c:if test="${viewType eq 'insert'}">
																				<input class='form-control' name="functionTestSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
																			</c:if>
																			<c:if test="${viewType eq 'update'}">
																				<c:forEach var='functionTestList' items='${functionTest}'>
																					<c:if test='${functionTestList.functionTestKeyNum eq functionTestTitle.functionTestKeyNum}'>
																						<c:if test='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum eq functionTestList.functionTestSettingSubCategoryKeyNum}'>
																                			<input class='form-control' name="functionTestSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;' value="${functionTestList.functionTestSubCategoryFailReason}">
																                		</c:if>
																                	</c:if>
															                	</c:forEach>
															                	<c:if test='${not functionTestFunctionTestSettingSubCategoryKeyNum.contains(functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum)}'>
															                		<input class='form-control' name="functionTestSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
															                	</c:if>
															                </c:if>
														                	<button type="button" class='subCategoryDetail' onClick='subCategoryDetail(${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
										                				</div>
										                			</c:if>
									                			</c:forEach>
								                			</div>
								                		</c:if>
							                		</c:forEach>
							                		<div style="padding-top: 3%;">
							                			<c:choose>
															<c:when test="${viewType eq 'insert'}">
							                					<button type="button" class="btn btn-default btn-outline-info-add" onClick="btnSave()">SAVE</button>
							                				</c:when>
							                				<c:when test="${viewType eq 'update'}">
			                                					<button type="button" class="btn btn-default btn-outline-info-add" onClick="btnUpdate()">SAVE</button>
			                                				</c:when>
							                			</c:choose>
							                		</div>
					                    		</div>
					                    	</c:forEach>
			                    		</div>
		                        	</div>
			                    </div>
		                    	<!-- ================================================================================================================= -->
			                    <div class='main-body' id='main-Agent' style="display: none;">
				                    <div class='page-wrapper'>
				                    	<div class='ibox'>
			                    			<div class='formDiv'>
					                    		<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormAgent}">
					                    			<c:if test="${functionTestSettingFormList.functionTestSettingDivision eq 'Agent'}">
						                    			<div class='functionTestForm' id='form_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
							                    			<div class='functionTestCommand'>
							                    				<button type="button" class='btn btn-primary formBtn' onClick="functionTestForm(${functionTestSettingFormList.functionTestSettingFormKeyNum})" style="box-shadow: 0px 3px 3px grey;">${functionTestSettingFormList.functionTestSettingFormName}</button>
							                    			</div>
							                    		</div>
							                    	</c:if>
						                    	</c:forEach>
			                    			</div>
				                    		<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormAgent}">
					                    		<div class='categoryDiv' id='categoryDiv_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
					                    			<c:forEach var='functionTestSettingCategoryList' items="${functionTestSettingCategory}">
					                    				<c:if test="${functionTestSettingFormList.functionTestSettingFormKeyNum eq functionTestSettingCategoryList.functionTestSettingFormKeyNum}"> 
							                				<div class='categorySmallDiv'>
							                					<div style='height: 45px;'>
									                				<span class="categorySpan">${functionTestSettingCategoryList.functionTestSettingCategoryName}</span>
									                			</div>
									                			<c:forEach var='functionTestSettingSubCategoryList' items='${functionTestSettingSubCategory}'>
									                				<c:if test='${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum eq functionTestSettingSubCategoryList.functionTestSettingCategoryKeyNum}'>
										                				<div class='subCategoryDiv'>
											                				<div class="checkbox-group">
																				<label>
																					<c:if test="${viewType eq 'insert'}">
																						<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox"  value='empty'>
																					</c:if>
																					<c:if test="${viewType eq 'update'}">
																						<c:forEach var='functionTestList' items='${functionTest}'>
																							<c:if test='${functionTestList.functionTestKeyNum eq functionTestTitle.functionTestKeyNum}'>
																								<c:if test='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum eq functionTestList.functionTestSettingSubCategoryKeyNum}'>
																									<c:if test="${functionTestList.functionTestSubCategoryState eq 'success'}">
																										<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox success"  value='success'>
																									</c:if>
																									<c:if test="${functionTestList.functionTestSubCategoryState eq 'failure'}">
																										<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox failure"  value='failure'>
																									</c:if>
																									<c:if test="${functionTestList.functionTestSubCategoryState eq 'empty'}">
																										<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox empty"  value='empty'>
																									</c:if>
																								</c:if>
																							</c:if>
																						</c:forEach>
																						<c:if test='${not functionTestFunctionTestSettingSubCategoryKeyNum.contains(functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum)}'>
																							<input type="checkbox" name="functionTestSubCategoryState" class="custom-checkbox empty"  value='empty'>
																						</c:if>
																					</c:if>
																					<span class="checkmark"></span>
																				</label>
																			</div>
																			<input type="hidden" value="${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum}" name="functionTestSettingSubCategoryKeyNumList">
																			<span class="subCategorySpan">${functionTestSettingSubCategoryList.functionTestSettingSubCategoryName}</span>
																			<c:if test="${viewType eq 'insert'}">
																				<input class='form-control' name="functionTestSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
																			</c:if>
																			<c:if test="${viewType eq 'update'}">
																				<c:forEach var='functionTestList' items='${functionTest}'>
																					<c:if test='${functionTestList.functionTestKeyNum eq functionTestTitle.functionTestKeyNum}'>
																						<c:if test='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum eq functionTestList.functionTestSettingSubCategoryKeyNum}'>
																                			<input class='form-control' name="functionTestSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;' value="${functionTestList.functionTestSubCategoryFailReason}">
																                		</c:if>
																                	</c:if>
															                	</c:forEach>
															                	<c:if test='${not functionTestFunctionTestSettingSubCategoryKeyNum.contains(functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum)}'>
															                		<input class='form-control' name="functionTestSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
															                	</c:if>
															                </c:if>
														                	<button type="button" class='subCategoryDetail' onClick='subCategoryDetail(${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
										                				</div>
										                			</c:if>
									                			</c:forEach>
								                			</div>
								                		</c:if>
							                		</c:forEach>
							                		<div style="padding-top: 3%;">
							                			<c:choose>
															<c:when test="${viewType eq 'insert'}">
							                					<button type="button" class="btn btn-default btn-outline-info-add" onClick="btnSave()">SAVE</button>
							                				</c:when>
							                				<c:when test="${viewType eq 'update'}">
			                                					<button type="button" class="btn btn-default btn-outline-info-add" onClick="btnUpdate()">SAVE</button>
			                                				</c:when>
							                			</c:choose>
							                		</div>
					                    		</div>
					                    	</c:forEach>
			                    		</div>
		                        	</div>
			                    </div>
			                    <input class="form-control" type="hidden" id="functionTestType" name="functionTestType" value="${functionTestType}">
			                    <input class="form-control" type="hidden" id="functionTestBtnType" name="functionTestBtnType" value="${viewType}">
			                    <input class="form-control" type="hidden" id="functionTestKeyNum" name="functionTestKeyNum" value="${functionTestTitle.functionTestKeyNum}">
							</form> 
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>

	<script>
		/* =========== 전달일자 오늘 날짜 입력 ========= */
		document.getElementById('functionTestDate').value = new Date().toISOString().substring(0, 10);
	
		$('#TOSMS').click(function() {
			$('#TOSMS').addClass('divisionActive');
			$('#Agent').removeClass('divisionActive');
			$('#functionTestSettingDivision').val('TOSMS');
			$('#main-TOSMS').show();
			$('#main-Agent').hide();
		});
		
		$('#Agent').click(function() {
			$('#Agent').addClass('divisionActive');
			$('#TOSMS').removeClass('divisionActive');
			$('#functionTestSettingDivision').val('Agent');
			$('#main-TOSMS').hide();
			$('#main-Agent').show();
		});
		
		function functionTestForm(number) {
			$('.categorySmallDiv').show();
			$('.categoryDiv').hide();
			$('#categoryDiv_'+number).show();
		}
		
		function subCategoryDetail(number) {
			var url = "<c:url value='/functionTest/detailView?functionTestSettingSubCategoryKeyNum="+number+"'/>";
			var windowFeatures = 'width=1000,height=800';
			window.open(url, '_blank', windowFeatures);
		}
		
		function btnSave() {
			const values = $('.custom-checkbox').map(function() {
				if(this.value=='empty')
					return 'empty';
				if(this.value=='success')
					return 'success';
				if(this.value=='failure')
					return 'failure';
			}).get();
			
			var postData = $('#form').serializeArray();
			
			$.each(values, function(index, value) {
				postData.push({ name: "functionTestSubCategoryStateList", value: value });
			});
			
			var functionTestCustomer = $('#functionTestCustomer').val();
			if(functionTestCustomer == "") {
				$('#NotFunctionTestCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotFunctionTestCustomer').hide();
				$.ajax({
					url: "<c:url value='/functionTest/functionTestSave'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	$('#functionTestKeyNum').val(result.functionTestKeyNum);
			        	var functionTestKeyNum = $('#functionTestKeyNum').val();
			        	if(result.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "기능 테스트 목록으로 이동하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '이동',
								  cancelButtonText: '저장',
							}).then((result) => {
								if (result.isConfirmed) {
									location.href="<c:url value='/functionTest/list'/>?functionTestType=${functionTestType}";
								} else {
									$('#save').hide();
									$('#update').show();
									$('#functionTestBtnType').val("update");
								}
							})
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
						}
					},
					error: function(error) {
						console.log(error);
					}
			    });
			}
		}
		
		
		/* =========== 업데이트 버튼 ========= */
		function btnUpdate() {
			const values = $('.custom-checkbox').map(function() {
				if(this.value=='empty')
					return 'empty';
				if(this.value=='success')
					return 'success';
				if(this.value=='failure')
					return 'failure';
			}).get();
			
			var postData = $('#form').serializeArray();
			
			$.each(values, function(index, value) {
				postData.push({ name: "functionTestSubCategoryStateList", value: value });
			});
			
			var functionTestCustomer = $('#functionTestCustomer').val();
			if(functionTestCustomer == "") {
				$('#NotFunctionTestCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotFunctionTestCustomer').hide();
				$.ajax({
					url: "<c:url value='/functionTest/update'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	if(result.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "기능 테스트 목록으로 이동하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '이동',
								  cancelButtonText: '저장',
							}).then((result2) => {
								if (result2.isConfirmed) {
									location.href="<c:url value='/functionTest/list'/>?functionTestType=${functionTestType}";
								} else {
									$('#functionTestKeyNum').val(result.functionTestKeyNum);
									$('#downloadBtn').show();
								}
							})
						} else {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '작업을 실패하였습니다.',
							});
						}
					},
					error: function(error) {
						console.log(error);
					}
			    });
			}
		}
		
		
		/* =========== Ctrl + S 사용시 저장 ========= */
		document.onkeydown = function(e) {
		    if (e.which == 17)  isCtrl = true;
		    if (e.which == 83 && isCtrl == true) {  // Ctrl + s
		    	var btnType = $('#functionTestBtnType').val();
		    	if(btnType == "insert") {
		    		//$('#btnSave').click();
		    		btnSave();
		    	} else {
		    		//$('#btnUpdate').click();
		    		btnUpdate();
		    	}
		    	isCtrl = false;
		    	return false;
		    }
		}
		document.onkeyup = function(e) {
			if (e.which == 17)  isCtrl = false;
		}
	</script>
	<script>
		$(function () {
		const checkboxes = document.querySelectorAll('.custom-checkbox');
	
		checkboxes.forEach(function(checkbox) {
			checkbox.addEventListener('click', function() {
				if (this.value == 'empty') {
					this.classList.remove('failure', 'empty');
					this.classList.add('success');
					$(this).val('success');
				} else if (this.value == 'success') {
					this.classList.remove('success', 'empty');
					this.classList.add('failure');
					$(this).val('failure');
				}else if (this.value == 'failure') {
					this.classList.remove('success', 'failure');
					this.classList.add('empty');
					$(this).val('empty');
				}
			});
		});
		})
	</script>
	
	<style>
		.divisionActive {
			background: black !important;
			font-weight: bold !important;
			color: white !important;
		}
		
		.functionTestCommand {
		    text-align: center;
		    height: 100%;
		    padding-top: 20%;
		    padding-left: 25px;
		    float: left;
		}
		
		.categoryDiv {
			width: 100%;
		    height: auto;
		    min-height: 570px;
		    background: white;
		    margin-top: 1%;
		    padding-top: 2%;
    		padding-bottom: 2%;
		    padding-left: 2%;
		}
		
		.subCategoryDiv {
			padding: 10px;
			border-bottom: 1px solid black;
			width: 70%;
			display: inline-flex;
		}
		
		.subCategoryDetail {
			height: 33px;
			width: 33px;
			background: #e4cff7;
			border: 1px solid #c7a8ef;
			margin-left: 1%;
		}
		
		.subCategoryDetailFont {
			font-size: 14px;
    		font-family: monospace;
		}
		
		.functionTestForm {
			display: inline-block;
		}
		
		.formDiv {
			width: 100%;
		    height: 155px;
		    background: rgba(0, 0, 0, 0.05);
		    overflow-x: scroll;
		    overflow-y: hidden;
		    white-space: nowrap;
		}
		
		.categorySmallDiv {
			padding-bottom: 3%;
		}
		
		.formBtn {
			width: auto;
    		min-width: 140px;
		    font-weight: bold;
		    font-size: 14px;
		    height: 55px;
		}
		
		.categorySpan {
			font-size: 20px;
    		font-weight: bold;
		}
		
		.subCategorySpan {
			font-size: 15px;
			padding: 10px;
    		float: left;
    		min-width: 50%;
		}
	</style>
	
	<style>
		.checkbox-group {
			display: flex;
			flex-direction: column;
			padding-top: 9px;
		}
		
		.checkbox-group label {
			display: flex;
			align-items: center;
			position: relative;
			margin-bottom: 5px;
		}
		
		.custom-checkbox {
			display: none;
		}
		
		.checkmark {
			position: relative;
			display: inline-block;
			width: 16px;
			height: 16px;
			background-color: #fff;
			border: 1px solid #000;
			cursor: pointer;
			text-align: center;
		}
		
		.checkmark::after {
			content: "";
			position: absolute;
			display: none;
			top: 3px;
			left: 6px;
			width: 4px;
			height: 8px;
			border: solid #000;
			border-width: 0 2px 2px 0;
			transform: rotate(45deg);
		}
		
		.custom-checkbox.success + .checkmark::after {
			display: block;
		}
		
		.custom-checkbox.failure + .checkmark::after {
			display: contents;
		    content: "X";
		    font-weight: bold;
		    font-size: 14px;
		    color: red;
		}
		
		.custom-checkbox.empty + .checkmark::after {
			display: none;
		}
	</style>
</html>