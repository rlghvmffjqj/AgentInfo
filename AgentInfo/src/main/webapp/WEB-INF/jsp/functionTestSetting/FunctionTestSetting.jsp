<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','functionTestSetting');
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
							                <h5 class="m-b-10">기능 테스트 설정</h5>
							                <p class="m-b-0">Set up a function test</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">기능 테스트 설정</a>
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
			                <div class='main-body' id='main-TOSMS'>
			                    <div class='page-wrapper'>
			                    	<div class='ibox'>
		                    			<div class='formDiv'>
		                    				<c:if test="${functionTestSettingFormTOSMS eq '[]'}">
			                    				<div class='functionTestForm'>
			                    					<div id='functionTestPlusOne'>
					                    				<div style='padding-left: 100%; padding-top: 130%;'>
					                    					<button class='formPlus' onClick='formPlus(this,0)'><span class='functionTestFont'>추가</span></button>
					                    				</div>
				                    				</div>
				                    			</div>
				                    		</c:if>
				                    		<c:if test="${functionTestSettingFormTOSMS ne '[]'}">
				                    			<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormTOSMS}">
				                    				<c:if test="${functionTestSettingFormList.functionTestSettingDivision eq 'TOSMS'}">
					                    				<div class='functionTestForm' id='form_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
						                    				<div class='functionTestCommand'>
						                    					<button class='btn btn-primary formBtn' onClick="functionTestSettingForm(${functionTestSettingFormList.functionTestSettingFormKeyNum})">${functionTestSettingFormList.functionTestSettingFormName}</button>
						                    					<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum})'><span class='functionTestFont'>제거</span></button></div>
						                    					<div style='width: 80%; display: inline-block;'>
							                						<div class='input-group'>
																		<input type='text' class='form-control' id='inputChange' placeholder='이름'>
																		<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='formChange(this,${functionTestSettingFormList.functionTestSettingFormKeyNum})'>변경</button>
																	</div>
																</div>
						                    				</div>
						                    				<div class='functionTestPlus'>
						                    					<button class='formPlus' onClick='formPlus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum})'><span class='functionTestFont'>추가</span></button>
						                    				</div>
						                    			</div>
						                    		</c:if>
					                    		</c:forEach>
				                    		</c:if>
		                    			</div>
			                    		<c:if test="${functionTestSettingFormTOSMS ne '[]'}">
			                    			<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormTOSMS}">
				                    			<div class='categoryDiv' id='categoryDiv_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
				                    				<c:forEach var='functionTestSettingCategoryList' items="${functionTestSettingCategory}">
				                    					<c:if test="${functionTestSettingFormList.functionTestSettingFormKeyNum eq functionTestSettingCategoryList.functionTestSettingFormKeyNum}"> 
						                    				<div class='categorySmallDiv'>
						                    					<div style='height: 30px;'>
								                    				<input class='form-control' placeholder='Category' style='width: 40%; float: left;' value="${functionTestSettingCategoryList.functionTestSettingCategoryName}">
								                    				<button class='categorySave' onClick='categorySave(this,${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum})'><span class='functionTestFont'>저장</span></button>
								                    				<button class='categoryPlus' onClick='categoryPlus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum},${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum})'><span class='functionTestFont'>추가</span></button>
								                    				<button class='categoryMinus' onClick='categoryMinus(this,${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum})'><span class='functionTestFont'>제거</span></button>
								                    			</div>
								                    			<div style="margin-bottom: -15px; margin-top: 10px;">
								                    				<span class="checkTortalSpan">전수</span><span class="checkBasicSpan">기본</span><span class="checkFoundationSpan">기초</span>
								                    			</div>
								                    			<c:forEach var='functionTestSettingSubCategoryList' items='${functionTestSettingSubCategory}'>
								                    				<c:if test='${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum eq functionTestSettingSubCategoryList.functionTestSettingCategoryKeyNum}'>
									                    				<div class='subCategoryDiv'>
									                    					<div class="checkbox-group">
									                    						<label>
										                    						<input type="checkbox" name="functionTestSettingSubCategoryTortal" class="custom-checkbox ${functionTestSettingSubCategoryList.functionTestSettingSubCategoryTortal}" onClick='functionTestSettingSubCategoryCheck(this,"tortal",${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})' value='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryTortal}'>
										                    						<span class="checkmark"></span>
									                    						</label>
									                    					</div>
									                    					<div class="checkbox-group">
									                    						<label>
										                    						<input type="checkbox" name="functionTestSettingSubCategoryBasic" class="custom-checkbox ${functionTestSettingSubCategoryList.functionTestSettingSubCategoryBasic}" onClick='functionTestSettingSubCategoryCheck(this,"basic",${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})' value='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryBasic}'>
										                    						<span class="checkmark"></span>
									                    						</label>
									                    					</div>
									                    					<div class="checkbox-group">
									                    						<label>
										                    						<input type="checkbox" name="functionTestSettingSubCategoryFoundation" class="custom-checkbox ${functionTestSettingSubCategoryList.functionTestSettingSubCategoryFoundation}" onClick='functionTestSettingSubCategoryCheck(this,"foundation",${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})' value='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryFoundation}'>
										                    						<span class="checkmark"></span>
									                    						</label>
									                    					</div>
									                    					<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;' value="${functionTestSettingSubCategoryList.functionTestSettingSubCategoryName}">
									                    					<button class='subCategorySave' onClick='subCategorySave(this,${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='functionTestFont'>저장</span></button>
									                    					<button class='subCategoryPlus' onClick='subCategoryPlus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum},${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum},${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='functionTestFont'>추가</span></button>
									                    					<button class='subCategoryMinus' onClick='subCategoryMinus(this,${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='functionTestFont'>제거</span></button>
									                    					<button class='subCategoryDetail' onClick='subCategoryDetail(${functionTestSettingCategoryList.functionTestSettingFormKeyNum},${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum},${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
									                    				</div>
									                    			</c:if>
								                    			</c:forEach>
							                    			</div>
							                    		</c:if>
						                    		</c:forEach>
				                    			</div>
				                    		</c:forEach>
			                    		</c:if>
		                    		</div>
	                        	</div>
		                    </div>
		                    <!-- ================================================================================================================= -->
		                    <div class='main-body' id='main-Agent' style="display: none;">
			                    <div class='page-wrapper'>
			                    	<div class='ibox'>
		                    			<div class='formDiv'>
		                    				<c:if test="${functionTestSettingFormAgent eq '[]'}">
			                    				<div class='functionTestForm'>
			                    					<div id='functionTestPlusOne'>
					                    				<div style='padding-left: 100%; padding-top: 130%;'>
					                    					<button class='formPlus' onClick='formPlus(this,0)'><span class='functionTestFont'>추가</span></button>
					                    				</div>
				                    				</div>
				                    			</div>
				                    		</c:if>
				                    		<c:if test="${functionTestSettingFormAgent ne '[]'}">
				                    			<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormAgent}">
				                    				<c:if test="${functionTestSettingFormList.functionTestSettingDivision eq 'Agent'}">
					                    				<div class='functionTestForm' id='form_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
						                    				<div class='functionTestCommand'>
						                    					<button class='btn btn-primary formBtn' onClick="functionTestSettingForm(${functionTestSettingFormList.functionTestSettingFormKeyNum})">${functionTestSettingFormList.functionTestSettingFormName}</button>
						                    					<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum})'><span class='functionTestFont'>제거</span></button></div>
						                    					<div style='width: 80%; display: inline-block;'>
							                						<div class='input-group'>
																		<input type='text' class='form-control' id='inputChange' placeholder='이름'>
																		<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='formChange(this,${functionTestSettingFormList.functionTestSettingFormKeyNum})'>변경</button>
																	</div>
																</div>
						                    				</div>
						                    				<div class='functionTestPlus'>
						                    					<button class='formPlus' onClick='formPlus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum})'><span class='functionTestFont'>추가</span></button>
						                    				</div>
						                    			</div>
						                    		</c:if>
					                    		</c:forEach>
				                    		</c:if>
		                    			</div>
			                    		<c:if test="${functionTestSettingFormAgent ne '[]'}">
			                    			<c:forEach var="functionTestSettingFormList" items="${functionTestSettingFormAgent}">
				                    			<div class='categoryDiv' id='categoryDiv_${functionTestSettingFormList.functionTestSettingFormKeyNum}'>
				                    				<c:forEach var='functionTestSettingCategoryList' items="${functionTestSettingCategory}">
				                    					<c:if test="${functionTestSettingFormList.functionTestSettingFormKeyNum eq functionTestSettingCategoryList.functionTestSettingFormKeyNum}"> 
						                    				<div class='categorySmallDiv'>
						                    					<div style='height: 30px;'>
								                    				<input class='form-control' placeholder='Category' style='width: 40%; float: left;' value="${functionTestSettingCategoryList.functionTestSettingCategoryName}">
								                    				<button class='categorySave' onClick='categorySave(this,${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum})'><span class='functionTestFont'>저장</span></button>
								                    				<button class='categoryPlus' onClick='categoryPlus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum},${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum})'><span class='functionTestFont'>추가</span></button>
								                    				<button class='categoryMinus' onClick='categoryMinus(this,${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum})'><span class='functionTestFont'>제거</span></button>
								                    			</div>
								                    			<div style="margin-bottom: -15px; margin-top: 10px;">
								                    				<span class="checkTortalSpan">전수</span><span class="checkBasicSpan">기본</span><span class="checkFoundationSpan">기초</span>
								                    			</div>
								                    			<c:forEach var='functionTestSettingSubCategoryList' items='${functionTestSettingSubCategory}'>
								                    				<c:if test='${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum eq functionTestSettingSubCategoryList.functionTestSettingCategoryKeyNum}'>
									                    				<div class='subCategoryDiv'>
									                    					<div class="checkbox-group">
									                    						<label>
										                    						<input type="checkbox" name="functionTestSettingSubCategoryTortal" class="custom-checkbox ${functionTestSettingSubCategoryList.functionTestSettingSubCategoryTortal}" onClick='functionTestSettingSubCategoryCheck(this,"tortal",${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})' value='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryTortal}'>
										                    						<span class="checkmark"></span>
									                    						</label>
									                    					</div>
									                    					<div class="checkbox-group">
									                    						<label>
										                    						<input type="checkbox" name="functionTestSettingSubCategoryBasic" class="custom-checkbox ${functionTestSettingSubCategoryList.functionTestSettingSubCategoryBasic}" onClick='functionTestSettingSubCategoryCheck(this,"basic",${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})' value='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryBasic}'>
										                    						<span class="checkmark"></span>
									                    						</label>
									                    					</div>
									                    					<div class="checkbox-group">
									                    						<label>
										                    						<input type="checkbox" name="functionTestSettingSubCategoryFoundation" class="custom-checkbox ${functionTestSettingSubCategoryList.functionTestSettingSubCategoryFoundation}" onClick='functionTestSettingSubCategoryCheck(this,"foundation",${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})' value='${functionTestSettingSubCategoryList.functionTestSettingSubCategoryFoundation}'>
										                    						<span class="checkmark"></span>
									                    						</label>
									                    					</div>
									                    					<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;' value="${functionTestSettingSubCategoryList.functionTestSettingSubCategoryName}">
									                    					<button class='subCategorySave' onClick='subCategorySave(this,${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='functionTestFont'>저장</span></button>
									                    					<button class='subCategoryPlus' onClick='subCategoryPlus(this,${functionTestSettingFormList.functionTestSettingFormKeyNum},${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum},${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='functionTestFont'>추가</span></button>
									                    					<button class='subCategoryMinus' onClick='subCategoryMinus(this,${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='functionTestFont'>제거</span></button>
									                    					<button class='subCategoryDetail' onClick='subCategoryDetail(${functionTestSettingCategoryList.functionTestSettingFormKeyNum},${functionTestSettingCategoryList.functionTestSettingCategoryKeyNum},${functionTestSettingSubCategoryList.functionTestSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
									                    				</div>
									                    			</c:if>
								                    			</c:forEach>
							                    			</div>
							                    		</c:if>
						                    		</c:forEach>
				                    			</div>
				                    		</c:forEach>
			                    		</c:if>
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
		
		function formChange(obj, number) {
			var btnName = $(obj).siblings('input').val();
			
			$.ajax({
				url: "<c:url value='/functionTestSetting/formChange'/>",
				type: "POST",
				data: {
					"functionTestSettingFormKeyNum": number,
					"functionTestSettingFormName": btnName,
				},
				async: false,
				success: function(data) {
					if(data == "OK") {
						$(obj).parent().parent().siblings('button').first().text(btnName);
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '폼 이름 변경에 실패 했습니다.',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
		}
		
		
		function formPlus(obj, number) {
			var number2;
			var number3;
			var functionTestSettingDivision = $('#functionTestSettingDivision').val();
			
			$.ajax({
				url: "<c:url value='/functionTestSetting/formPlus'/>",
				type: "POST",
				data: {
					"functionTestSettingDivision": functionTestSettingDivision,
					"functionTestSettingFormKeyNum": number,
				},
				async: false,
				success: function(data) {
					number = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			
			var table = $(obj).parent().parent();
			var rowItem = "<div class='functionTestForm' id='form_"+number+"'>";
			rowItem += "<div class='functionTestCommand'>";
			rowItem += "<button class='btn btn-primary formBtn' onClick='functionTestSettingForm("+number+")'>미지정</button>";
			rowItem += "<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this,"+number+")'><span class='functionTestFont'>제거</span></button></div>";
			rowItem += "<div style='width: 80%; display: inline-block;'>";
			rowItem += "<div class='input-group'>";
			rowItem += "<input type='text' class='form-control' id='inputChange' placeholder='이름'>";
			rowItem += "<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='formChange(this,"+number+")'>변경</button>";
			rowItem += "</div>";
			rowItem += "</div>";
			rowItem += "</div>";
			rowItem += "<div class='functionTestPlus'>";
			rowItem += "<button class='formPlus' onClick='formPlus(this,"+number+")'><span class='functionTestFont'>추가</span></button>";
			rowItem += "</div>";
			rowItem += "</div>";
			table.after(rowItem);
			
			$.ajax({
				url: "<c:url value='/functionTestSetting/categoryPlus'/>",
				type: "POST",
				data: {"functionTestSettingFormKeyNum":number},
				async: false,
				success: function(data) {
					number2 = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			$.ajax({
				url: "<c:url value='/functionTestSetting/subCategoryPlus'/>",
				type: "POST",
				data: {
					"functionTestSettingCategoryKeyNum":number2,
					"functionTestSettingFormKeyNum": number,
				},
				async: false,
				success: function(data) {
					number3 = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			
			var table2 = $(obj).parent().parent().parent().parent();
			var rowItem2 = "<div class='categoryDiv' id='categoryDiv_"+number+"' style='display: none;'>";
			rowItem2 += "<div class='categorySmallDiv'>";
			rowItem2 += "<div style='height: 30px;'>";
			rowItem2 += "<input class='form-control' placeholder='Category' style='width: 40%; float: left;'>";
			rowItem2 += "<button class='categorySave' onClick='categorySave(this,"+number2+")'><span class='functionTestFont'>저장</span></button>";
			rowItem2 += "<button class='categoryPlus' onClick='categoryPlus(this,"+number+","+number2+")'><span class='functionTestFont'>추가</span></button>";
			rowItem2 += "<button class='categoryMinus' onClick='categoryMinus(this,"+number2+")'><span class='functionTestFont'>제거</span></button>";
			rowItem2 += "</div>";
			rowItem2 += "<div style='margin-bottom: -15px; margin-top: 10px;'>";
			rowItem2 += "<span class='checkTortalSpan'>전수</span><span class='checkBasicSpan'>기본</span><span class='checkFoundationSpan'>기초</span>";
			rowItem2 += "</div>";
			rowItem2 += "<div class='subCategoryDiv'>";
			rowItem2 += "<div class='checkbox-group'>";
			rowItem2 += "<label>";
			rowItem2 += "<input type='checkbox' name='functionTestSettingSubCategoryTortal' class='custom-checkbox success' onClick='functionTestSettingSubCategoryCheck(this,"+'"tortal"'+","+number3+")' value='success'>";
			rowItem2 += "<span class='checkmark'></span>";
			rowItem2 += "</label>";
			rowItem2 += "</div>";
			rowItem2 += "<div class='checkbox-group'>";
			rowItem2 += "<label>";
			rowItem2 += "<input type='checkbox' name='functionTestSettingSubCategoryBasic' class='custom-checkbox empty' onClick='functionTestSettingSubCategoryCheck(this,"+'"basic"'+","+number3+")' value='empty'>";
			rowItem2 += "<span class='checkmark'></span>";
			rowItem2 += "</label>";
			rowItem2 += "</div>";
			rowItem2 += "<div class='checkbox-group'>";
			rowItem2 += "<label>";
			rowItem2 += "<input type='checkbox' name='functionTestSettingSubCategoryFoundation' class='custom-checkbox empty' onClick='functionTestSettingSubCategoryCheck(this,"+'"foundation"'+","+number3+")' value='empty'>";
			rowItem2 += "<span class='checkmark'></span>";
			rowItem2 += "</label>";
			rowItem2 += "</div>";
			rowItem2 += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem2 += "<button class='subCategorySave' onClick='subCategorySave(this,"+number3+")'><span class='functionTestFont'>저장</span></button>";
			rowItem2 += "<button class='subCategoryPlus' onClick='subCategoryPlus(this,"+number+","+number2+","+number3+")'><span class='functionTestFont'>추가</span></button>";
			rowItem2 += "<button class='subCategoryMinus' onClick='subCategoryMinus(this,"+number3+")'><span class='functionTestFont'>제거</span></button>";
			rowItem2 += "<button class='subCategoryDetail' onClick='subCategoryDetail("+number+","+number2+","+number3+")'><span class='subCategoryDetailFont'>!</span></button>";
			rowItem2 += "</div>";
			rowItem2 += "</div>";
			rowItem2 += "</div>";
			table2.after(rowItem2);
			
			$('#functionTestPlusOne').hide();
		}
		
		function formMinus(obj, number) {
			Swal.fire({
				  title: '삭제!',
				  text: "폼을 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url: "<c:url value='/functionTestSetting/formMinus'/>",
						type: "POST",
						data: {
							"functionTestSettingFormKeyNum": number,
						},
						async: false,
						success: function(data) {
							if(data == "OK") {
								$('#form_'+number).remove();
								$('#categoryDiv_'+number).remove();
							} else {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '폼 삭제 실패 했습니다.',
								});
							}
						},
						error: function(error) {
							console.log(error);
						}
					});
			  	}
			})
		}
		
		function categorySave(obj, number) {
			var functionTestSettingCategoryName = $(obj).siblings('input').val();
			
			$.ajax({
				url: "<c:url value='/functionTestSetting/categorySave'/>",
				type: "POST",
				data: {
					"functionTestSettingCategoryKeyNum": number,
					"functionTestSettingCategoryName": functionTestSettingCategoryName,
				},
				async: false,
				success: function(data) {
					if(data == "OK") {
						Swal.fire({
							icon: 'success',
							title: '저장!',
							text: '카테고리 저장 완료!',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
		}
		
		function categoryPlus(obj, number, number2) {
			var number3;
			$.ajax({
				url: "<c:url value='/functionTestSetting/categoryPlus'/>",
				type: "POST",
				data: {
					"functionTestSettingFormKeyNum":number,
					"functionTestSettingCategoryKeyNum":number2,
				},
				async: false,
				success: function(data) {
					number2 = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			$.ajax({
				url: "<c:url value='/functionTestSetting/subCategoryPlus'/>",
				type: "POST",
				data: {
					"functionTestSettingCategoryKeyNum":number2,
					"functionTestSettingFormKeyNum": number,
				},
				async: false,
				success: function(data) {
					number3 = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			
			var table = $(obj).parent().parent();
			var rowItem = "<div class='categorySmallDiv'>";
			rowItem += "<div style='height: 30px;'>";
			rowItem += "<input class='form-control' placeholder='Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='categorySave' onClick='categorySave(this,"+number2+")'><span class='functionTestFont'>저장</span></button>";
			rowItem += "<button class='categoryPlus' onClick='categoryPlus(this,"+number+","+number2+")'><span class='functionTestFont'>추가</span></button>";
			rowItem += "<button class='categoryMinus' onClick='categoryMinus(this,"+number2+")'><span class='functionTestFont'>제거</span></button>";
			rowItem += "</div>";
			rowItem += "<div style='margin-bottom: -15px; margin-top: 10px;'>";
			rowItem += "<span class='checkTortalSpan'>전수</span><span class='checkBasicSpan'>기본</span><span class='checkFoundationSpan'>기초</span>";
			rowItem += "</div>";
			rowItem += "<div class='subCategoryDiv'>";
			rowItem += "<div class='checkbox-group'>";
			rowItem += "<label>";
			rowItem += "<input type='checkbox' name='functionTestSettingSubCategoryTortal' class='custom-checkbox success' onClick='functionTestSettingSubCategoryCheck(this,"+'"tortal"'+","+number3+")' value='success'>";
			rowItem += "<span class='checkmark'></span>";
			rowItem += "</label>";
			rowItem += "</div>";
			rowItem += "<div class='checkbox-group'>";
			rowItem += "<label>";
			rowItem += "<input type='checkbox' name='functionTestSettingSubCategoryBasic' class='custom-checkbox empty' onClick='functionTestSettingSubCategoryCheck(this,"+'"basic"'+","+number3+")' value='empty'>";
			rowItem += "<span class='checkmark'></span>";
			rowItem += "</label>";
			rowItem += "</div>";
			rowItem += "<div class='checkbox-group'>";
			rowItem += "<label>";
			rowItem += "<input type='checkbox' name='functionTestSettingSubCategoryFoundation' class='custom-checkbox empty' onClick='functionTestSettingSubCategoryCheck(this,"+'"foundation"'+","+number3+")' value='empty'>";
			rowItem += "<span class='checkmark'></span>";
			rowItem += "</label>";
			rowItem += "</div>";
			rowItem += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='subCategorySave' onClick='subCategorySave(this,"+number3+")'><span class='functionTestFont'>저장</span></button>";
			rowItem += "<button class='subCategoryPlus' onClick='subCategoryPlus(this,"+number+","+number2+","+number3+")'><span class='functionTestFont'>추가</span></button>";
			rowItem += "<button class='subCategoryMinus' onClick='subCategoryMinus(this,"+number3+")'><span class='functionTestFont'>제거</span></button>";
			rowItem += "<button class='subCategoryDetail' onClick='subCategoryDetail("+number+","+number2+","+number3+")'><span class='subCategoryDetailFont'>!</span></button>";
			rowItem += "</div>";
			rowItem += "</div>";
			console.log(table);
			table.after(rowItem);
			
			$('#categoryPlusOne').hide();
		}
		
		function categoryMinus(obj, number) {
			Swal.fire({
				  title: '삭제!',
				  text: "카테고리를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url: "<c:url value='/functionTestSetting/categoryMinus'/>",
						type: "POST",
						data: {
							"functionTestSettingCategoryKeyNum":number,
						},
						async: false,
						success: function(data) {
							if(data == "OK") {
								Swal.fire({
									icon: 'success',
									title: '삭제!',
									text: '카테고리 삭제 완료!',
								});
								
								$(obj).parent().parent().remove();
							} else {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '카테고리 삭제 실패 했습니다.',
								});
							}
						},
						error: function(error) {
							console.log(error);
						}
					});
			  	}
			})
		}
		
		function subCategorySave(obj, number) {
			var functionTestSettingSubCategoryName = $(obj).siblings('input').val();
			
			$.ajax({
				url: "<c:url value='/functionTestSetting/subCategorySave'/>",
				type: "POST",
				data: {
					"functionTestSettingSubCategoryKeyNum": number,
					"functionTestSettingSubCategoryName": functionTestSettingSubCategoryName,
				},
				async: false,
				success: function(data) {
					if(data == "OK") {
						Swal.fire({
							icon: 'success',
							title: '저장!',
							text: '서브 카테고리 저장 완료!',
						});
					} 
				},
				error: function(error) {
					console.log(error);
				}
			});
		}
		
		function subCategoryPlus(obj, number, number2, number3) {
			$.ajax({
				url: "<c:url value='/functionTestSetting/subCategoryPlus'/>",
				type: "POST",
				data: {
					"functionTestSettingFormKeyNum": number,
					"functionTestSettingCategoryKeyNum": number2,
					"functionTestSettingSubCategoryKeyNum": number3,
				},
				async: false,
				success: function(data) {
					number3 = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			
			var table = $(obj).parent();
			var rowItem = "<div class='subCategoryDiv'>";
			rowItem += "<div class='checkbox-group'>";
			rowItem += "<label>";
			rowItem += "<input type='checkbox' name='functionTestSettingSubCategoryTortal' class='custom-checkbox success' onClick='functionTestSettingSubCategoryCheck(this,"+'"tortal"'+","+number3+")' value='success'>";
			rowItem += "<span class='checkmark'></span>";
			rowItem += "</label>";
			rowItem += "</div>";
			rowItem += "<div class='checkbox-group'>";
			rowItem += "<label>";
			rowItem += "<input type='checkbox' name='functionTestSettingSubCategoryBasic' class='custom-checkbox empty' onClick='functionTestSettingSubCategoryCheck(this,"+'"basic"'+","+number3+")' value='empty'>";
			rowItem += "<span class='checkmark'></span>";
			rowItem += "</label>";
			rowItem += "</div>";
			rowItem += "<div class='checkbox-group'>";
			rowItem += "<label>";
			rowItem += "<input type='checkbox' name='functionTestSettingSubCategoryFoundation' class='custom-checkbox empty' onClick='functionTestSettingSubCategoryCheck(this,"+'"foundation"'+","+number3+")' value='empty'>";
			rowItem += "<span class='checkmark'></span>";
			rowItem += "</label>";
			rowItem += "</div>";
			rowItem += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='subCategorySave' onClick='subCategorySave(this,"+number3+")'><span class='functionTestFont'>저장</span></button>";
			rowItem += "<button class='subCategoryPlus' onClick='subCategoryPlus(this,"+number+","+number2+","+number3+")'><span class='functionTestFont'>추가</span></button>";
			rowItem += "<button class='subCategoryMinus' onClick='subCategoryMinus(this,"+number3+")'><span class='functionTestFont'>제거</span></button>";
			rowItem += "<button class='subCategoryDetail' onClick='subCategoryDetail("+number+","+number2+","+number3+")'><span class='subCategoryDetailFont'>!</span></button>";
			rowItem += "</div>";
			table.after(rowItem);
		}
		
		function subCategoryMinus(obj, number) {
			Swal.fire({
				  title: '삭제!',
				  text: "서브 카테고리를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
						url: "<c:url value='/functionTestSetting/subCategoryMinus'/>",
						type: "POST",
						data: {
							"functionTestSettingSubCategoryKeyNum": number,
						},
						async: false,
						success: function(data) {
							if(data == "OK") {
								Swal.fire({
									icon: 'success',
									title: '삭제!',
									text: '서브 카테고리 삭제 완료!',
								});
								
								$(obj).parent().remove();
							} else {
								Swal.fire({
									icon: 'error',
									title: '실패!',
									text: '서브 카테고리 삭제 실패 했습니다.',
								});
							}
						},
						error: function(error) {
							console.log(error);
						}
					});
			  	}
			})
		}
		
		$('#form_1').click(function() {
			$('.categoryDiv').hide();
			$('#categoryDiv_1').show();
		});
		
		function functionTestSettingForm(number) {
			$('.categorySmallDiv').show();
			$('.categoryDiv').hide();
			$('#categoryDiv_'+number).show();
		}
		
		function subCategoryDetail(number, number2, number3) {
			var url = "<c:url value='/functionTestSetting/detailView?functionTestSettingFormKeyNum="+number+"&functionTestSettingCategoryKeyNum="+number2+"&functionTestSettingSubCategoryKeyNum="+number3+"'/>";
			var windowFeatures = 'width=1000,height=800';
			window.open(url, '_blank', windowFeatures);
		}
	</script>
	<script>
		/* $(function () {
			const checkboxes = document.querySelectorAll('.custom-checkbox');
		
			checkboxes.forEach(function(checkbox) {
				checkbox.addEventListener('click', function() {
					if (this.value == 'empty') {
						this.classList.remove('empty');
						this.classList.add('success');
						$(this).val('success');
					} else if (this.value == 'success') {
						this.classList.remove('success');
						this.classList.add('empty');
						$(this).val('empty');
					}
				});
			});
		}) */
		
		function functionTestSettingSubCategoryCheck(obj,type,number) {
			if (obj.value == 'empty') {
				obj.classList.remove('empty');
				obj.classList.add('success');
				$(obj).val('success');
			} else if (obj.value == 'success') {
				obj.classList.remove('success');
				obj.classList.add('empty');
				$(obj).val('empty');
			}
			
			$.ajax({
				url: "<c:url value='/functionTestSetting/check'/>",
				type: "POST",
				data: {
					"functionTestSettingSubCategoryKeyNum": number,
					"functionTestSettingSubCategoryType":type,
					"functionTestSettingSubCategoryCheck": obj.value,
				},
				async: false,
				success: function() {
				},
				error: function(error) {
					console.log(error);
				}
			});
		}
	</script>
	
	<style>
		.divisionActive {
			background: black !important;
			font-weight: bold !important;
			color: white !important;
		}
		
		.functionTestPlus {
		    text-align: center;
		    height: 100%;
		    padding-top: 25%;
		    float: left;
		}
		
		.functionTestCommand {
		    text-align: center;
		    height: 100%;
		    padding-top: 10px;
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
		    padding-top: 1%;
		    padding-left: 2%;
		}
		
		.functionTestFont {
			font-size: 12px;
    		font-family: monospace;
		}
		
		.categoryPlus {
			height: 33px;
		    background: #cfcff7;
		    border: 1px solid #b7bbf1;
		    margin-right: 5px;
		    float: left;
		}
		
		.categoryMinus {
			height: 33px;
		    background: #f7cfcf;
		    border: 1px solid #efa8a8;
		    margin-right: 5px;
		    float: left;
		}
		
		.categorySave {
			height: 33px;
			background: #f3e8c1;
    		border: 1px solid #ffcd5c;
		    margin-right: 5px;
		    float: left;
		}
		
		.subCategoryPlus {
			height: 33px;
		    background: #cfcff7;
		    border: 1px solid #b7bbf1;
		    margin-right: 5px;
		    float: left;
		}
		
		.subCategoryMinus {
			height: 33px;
		    background: #f7cfcf;
		    border: 1px solid #efa8a8;
		    margin-right: 5px;
		    float: left;
		}
		
		.subCategorySave {
			height: 33px;
		    background: #f3e8c1;
    		border: 1px solid #ffcd5c;
		    margin-right: 5px;
		    float: left;
		}
		
		.subCategoryDetail {
			height: 33px;
		    background: #e4cff7;
    		border: 1px solid #c7a8ef;
		}
		
		.subCategoryDetailFont {
			font-size: 14px;
    		font-family: monospace;
		}
		
		.formPlus {
			background: #cfcff7;
		    border: 1px solid #b7bbf1;
		    height: 30px;
		}
		
		.formMinus {
			background: #f7cfcf;
		    border: 1px solid #efa8a8;
		    width: 40px;
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
	</style>
	<style>
		.checkbox-group {
			display: flex;
			flex-direction: column;
			padding-top: 9px;
			float: left;
    		margin-right: 1%;
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
		
		.custom-checkbox.empty + .checkmark::after {
			display: none;
		}

		
		.checkTortalSpan {
			font-size: 12px;
			margin-left: 1.8%;
		}
		
		.checkBasicSpan {
			font-size: 12px;
			margin-left: 0.4%;
		}
		
		.checkFoundationSpan {
			font-size: 12px;
			margin-left: 0.6%;
		}
		
		.formBtn {
			min-width:70%;
			width: auto; 
			height: 50px;
		}
	</style>
</html>