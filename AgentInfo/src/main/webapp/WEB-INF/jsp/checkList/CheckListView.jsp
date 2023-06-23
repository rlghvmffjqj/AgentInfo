<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','checkList');
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
							                <h5 class="m-b-10">테스트 체크리스트</h5>
							                <p class="m-b-0">Test Check List</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">체크리스트</a>
							                </li>
							            </ul>
							        </div>
							    </div>
							</div>
						</div>
			                <div>
			                	<button class='btn btn-secondary divisionActive' id='TOSMS' style='float: left;'>TOSMS</button>
			                	<button class='btn btn-secondary' id='Agent'>Agent</button>
			                	<input type='hidden' id='checkListSettingDivision' name='checkListSettingDivision' value='TOSMS'>
			                </div>
			                <form id="form" name="form" method ="post">
				                <div class='main-body'>
				                    <div class='page-wrapper'>
				                    	<div class='ibox'>
				                    		<div class="searchbos">
				                    			<div class="col-lg-2">
		                      						<label class="labelFontSize">고객사명</label><span class="colorRed" id="NotCheckListCustomer" style="display: none; line-height: initial;">고객사 필수 입력 바랍니다.</span>
		                      						<input type="text" id="checkListCustomer" name="checkListCustomer" class="form-control" value="${checkListTitle.checkListCustomer}">
		                      					</div>
		                      					<div class="col-lg-2">
		                      						<label class="labelFontSize">Title</label>
		                      						<input type="text" id="checkListTitle" name="checkListTitle" class="form-control" value="${checkListTitle.checkListTitle}">
		                      					</div>
		                      					<div class="col-lg-2">
		                      						<label class="labelFontSize">날짜</label>
		                      						<input type="date" id="checkListDate" name="checkListDate" class="form-control" value="${checkListTitle.checkListDate}">
		                      					</div>
				                    		</div>
				                    	</div>
				                    </div>
				                </div>
				                <div class='main-body' id='main-TOSMS'>
				                    <div class='page-wrapper'>
				                    	<div class='ibox'>
			                    			<div class='formDiv'>
					                    		<c:forEach var="checkListSettingFormList" items="${checkListSettingFormTOSMS}">
					                    			<c:if test="${checkListSettingFormList.checkListSettingDivision eq 'TOSMS'}">
						                    			<div class='chckListForm' id='form_${checkListSettingFormList.checkListSettingFormKeyNum}'>
							                    			<div class='chckListCommand'>
							                    				<button type="button" class='btn btn-primary formBtn' onClick="checkListForm(${checkListSettingFormList.checkListSettingFormKeyNum})" style="box-shadow: 0px 3px 3px grey;">${checkListSettingFormList.checkListSettingFormName}</button>
							                    			</div>
							                    		</div>
							                    	</c:if>
						                    	</c:forEach>
			                    			</div>
				                    		<c:forEach var="checkListSettingFormList" items="${checkListSettingFormTOSMS}">
					                    		<div class='categoryDiv' id='categoryDiv_${checkListSettingFormList.checkListSettingFormKeyNum}'>
					                    			<c:forEach var='checkListSettingCategoryList' items="${checkListSettingCategory}">
					                    				<c:if test="${checkListSettingFormList.checkListSettingFormKeyNum eq checkListSettingCategoryList.checkListSettingFormKeyNum}"> 
							                				<div class='categorySmallDiv'>
							                					<div style='height: 45px;'>
									                				<span class="categorySpan">${checkListSettingCategoryList.checkListSettingCategoryName}</span>
									                			</div>
									                			<c:forEach var='checkListSettingSubCategoryList' items='${checkListSettingSubCategory}'>
									                				<c:if test='${checkListSettingCategoryList.checkListSettingCategoryKeyNum eq checkListSettingSubCategoryList.checkListSettingCategoryKeyNum}'>
										                				<div class='subCategoryDiv'>
											                				<div class="checkbox-group">
																				<label>
																					<c:if test="${viewType eq 'insert'}">
																						<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox"  value='empty'>
																					</c:if>
																					<c:if test="${viewType eq 'update'}">
																						<c:forEach var='checkListList' items='${checkList}'>
																							<c:if test='${checkListList.checkListKeyNum eq checkListTitle.checkListKeyNum}'>
																								<c:if test='${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum eq checkListList.checkListSettingSubCategoryKeyNum}'>
																									<c:if test="${checkListList.checkListSubCategoryState eq 'success'}">
																										<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox success"  value='success'>
																									</c:if>
																									<c:if test="${checkListList.checkListSubCategoryState eq 'failure'}">
																										<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox failure"  value='failure'>
																									</c:if>
																									<c:if test="${checkListList.checkListSubCategoryState eq 'empty'}">
																										<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox empty"  value='empty'>
																									</c:if>
																								</c:if>
																							</c:if>
																						</c:forEach>
																						<c:if test='${not checkListCheckListSettingSubCategoryKeyNum.contains(checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum)}'>
																							<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox empty"  value='empty'>
																						</c:if>
																					</c:if>
																					<span class="checkmark"></span>
																				</label>
																			</div>
																			<input type="hidden" value="${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum}" name="checkListSettingSubCategoryKeyNumList">
																			<span class="subCategorySpan">${checkListSettingSubCategoryList.checkListSettingSubCategoryName}</span>
																			<c:if test="${viewType eq 'insert'}">
																				<input class='form-control' name="checkListSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
																			</c:if>
																			<c:if test="${viewType eq 'update'}">
																				<c:forEach var='checkListList' items='${checkList}'>
																					<c:if test='${checkListList.checkListKeyNum eq checkListTitle.checkListKeyNum}'>
																						<c:if test='${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum eq checkListList.checkListSettingSubCategoryKeyNum}'>
																                			<input class='form-control' name="checkListSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;' value="${checkListList.checkListSubCategoryFailReason}">
																                		</c:if>
																                	</c:if>
															                	</c:forEach>
															                	<c:if test='${not checkListCheckListSettingSubCategoryKeyNum.contains(checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum)}'>
															                		<input class='form-control' name="checkListSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
															                	</c:if>
															                </c:if>
														                	<button type="button" class='subCategoryDetail' onClick='subCategoryDetail(${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
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
					                    		<c:forEach var="checkListSettingFormList" items="${checkListSettingFormAgent}">
					                    			<c:if test="${checkListSettingFormList.checkListSettingDivision eq 'Agent'}">
						                    			<div class='chckListForm' id='form_${checkListSettingFormList.checkListSettingFormKeyNum}'>
							                    			<div class='chckListCommand'>
							                    				<button type="button" class='btn btn-primary formBtn' onClick="checkListForm(${checkListSettingFormList.checkListSettingFormKeyNum})" style="box-shadow: 0px 3px 3px grey;">${checkListSettingFormList.checkListSettingFormName}</button>
							                    			</div>
							                    		</div>
							                    	</c:if>
						                    	</c:forEach>
			                    			</div>
				                    		<c:forEach var="checkListSettingFormList" items="${checkListSettingFormAgent}">
					                    		<div class='categoryDiv' id='categoryDiv_${checkListSettingFormList.checkListSettingFormKeyNum}'>
					                    			<c:forEach var='checkListSettingCategoryList' items="${checkListSettingCategory}">
					                    				<c:if test="${checkListSettingFormList.checkListSettingFormKeyNum eq checkListSettingCategoryList.checkListSettingFormKeyNum}"> 
							                				<div class='categorySmallDiv'>
							                					<div style='height: 45px;'>
									                				<span class="categorySpan">${checkListSettingCategoryList.checkListSettingCategoryName}</span>
									                			</div>
									                			<c:forEach var='checkListSettingSubCategoryList' items='${checkListSettingSubCategory}'>
									                				<c:if test='${checkListSettingCategoryList.checkListSettingCategoryKeyNum eq checkListSettingSubCategoryList.checkListSettingCategoryKeyNum}'>
										                				<div class='subCategoryDiv'>
											                				<div class="checkbox-group">
																				<label>
																					<c:if test="${viewType eq 'insert'}">
																						<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox"  value='empty'>
																					</c:if>
																					<c:if test="${viewType eq 'update'}">
																						<c:forEach var='checkListList' items='${checkList}'>
																							<c:if test='${checkListList.checkListKeyNum eq checkListTitle.checkListKeyNum}'>
																								<c:if test='${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum eq checkListList.checkListSettingSubCategoryKeyNum}'>
																									<c:if test="${checkListList.checkListSubCategoryState eq 'success'}">
																										<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox success"  value='success'>
																									</c:if>
																									<c:if test="${checkListList.checkListSubCategoryState eq 'failure'}">
																										<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox failure"  value='failure'>
																									</c:if>
																									<c:if test="${checkListList.checkListSubCategoryState eq 'empty'}">
																										<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox empty"  value='empty'>
																									</c:if>
																								</c:if>
																							</c:if>
																						</c:forEach>
																						<c:if test='${not checkListCheckListSettingSubCategoryKeyNum.contains(checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum)}'>
																							<input type="checkbox" name="checkListSubCategoryState" class="custom-checkbox empty"  value='empty'>
																						</c:if>
																					</c:if>
																					<span class="checkmark"></span>
																				</label>
																			</div>
																			<input type="hidden" value="${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum}" name="checkListSettingSubCategoryKeyNumList">
																			<span class="subCategorySpan">${checkListSettingSubCategoryList.checkListSettingSubCategoryName}</span>
																			<c:if test="${viewType eq 'insert'}">
																				<input class='form-control' name="checkListSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
																			</c:if>
																			<c:if test="${viewType eq 'update'}">
																				<c:forEach var='checkListList' items='${checkList}'>
																					<c:if test='${checkListList.checkListKeyNum eq checkListTitle.checkListKeyNum}'>
																						<c:if test='${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum eq checkListList.checkListSettingSubCategoryKeyNum}'>
																                			<input class='form-control' name="checkListSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;' value="${checkListList.checkListSubCategoryFailReason}">
																                		</c:if>
																                	</c:if>
															                	</c:forEach>
															                	<c:if test='${not checkListCheckListSettingSubCategoryKeyNum.contains(checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum)}'>
															                		<input class='form-control' name="checkListSubCategoryFailReasonList" placeholder='Note' style='width: 53%; float: left;'>
															                	</c:if>
															                </c:if>
														                	<button type="button" class='subCategoryDetail' onClick='subCategoryDetail(${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
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
			                    <input class="form-control" type="hidden" id="checkListBtnType" name="checkListBtnType" value="${viewType}">
			                    <input class="form-control" type="hidden" id="checkListKeyNum" name="checkListKeyNum" value="${checkListTitle.checkListKeyNum}">
							</form> 
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>

	<script>
		/* =========== 전달일자 오늘 날짜 입력 ========= */
		document.getElementById('checkListDate').value = new Date().toISOString().substring(0, 10);
	
		$('#TOSMS').click(function() {
			$('#TOSMS').addClass('divisionActive');
			$('#Agent').removeClass('divisionActive');
			$('#checkListSettingDivision').val('TOSMS');
			$('#main-TOSMS').show();
			$('#main-Agent').hide();
		});
		
		$('#Agent').click(function() {
			$('#Agent').addClass('divisionActive');
			$('#TOSMS').removeClass('divisionActive');
			$('#checkListSettingDivision').val('Agent');
			$('#main-TOSMS').hide();
			$('#main-Agent').show();
		});
		
		function checkListForm(number) {
			$('.categorySmallDiv').show();
			$('.categoryDiv').hide();
			$('#categoryDiv_'+number).show();
		}
		
		function subCategoryDetail(number) {
			var url = "<c:url value='/checkList/detailView?checkListSettingSubCategoryKeyNum="+number+"'/>";
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
				postData.push({ name: "checkListSubCategoryStateList", value: value });
			});
			
			var checkListCustomer = $('#checkListCustomer').val();
			if(checkListCustomer == "") {
				$('#NotCheckListCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotCheckListCustomer').hide();
				$.ajax({
					url: "<c:url value='/checkList/checkListSave'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	$('#checkListKeyNum').val(result.checkListKeyNum);
			        	var checkListKeyNum = $('#checkListKeyNum').val();
			        	if(result.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "체크리스트 목록으로 이동하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '이동',
								  cancelButtonText: '저장',
							}).then((result) => {
								if (result.isConfirmed) {
									location.href="<c:url value='/checkList/list'/>";
								} else {
									$('#save').hide();
									$('#update').show();
									$('#checkListBtnType').val("update");
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
				postData.push({ name: "checkListSubCategoryStateList", value: value });
			});
			
			var checkListCustomer = $('#checkListCustomer').val();
			if(checkListCustomer == "") {
				$('#NotCheckListCustomer').show();
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '고객사 필수 입력 바랍니다.',
				});
			} else {
				$('#NotCheckListCustomer').hide();
				$.ajax({
					url: "<c:url value='/checkList/update'/>",
			        type: 'post',
			        data: postData,
			        async: false,
			        success: function(result) {
			        	if(result.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "체크 리스트 목록으로 이동하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '이동',
								  cancelButtonText: '저장',
							}).then((result2) => {
								if (result2.isConfirmed) {
									location.href="<c:url value='/checkList/list'/>";
								} else {
									$('#checkListKeyNum').val(result.checkListKeyNum);
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
		    	var btnType = $('#checkListBtnType').val();
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
		
		.chckListCommand {
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
		
		.chckListForm {
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