<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','checkListSetting');
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
							                <h5 class="m-b-10">테스트 체크리스트 설정</h5>
							                <p class="m-b-0">Set up a test checklist</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">체크리스트 설정</a>
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
			                <div class='main-body' id='main-TOSMS'>
			                    <div class='page-wrapper'>
			                    	<div class='ibox'>
		                    			<div class='formDiv'>
		                    				<c:if test="${checkListSettingFormTOSMS eq '[]'}">
			                    				<div class='chckListForm'>
			                    					<div id='chckListPlusOne'>
					                    				<div style='padding-left: 100%; padding-top: 130%;'>
					                    					<button class='formPlus' onClick='formPlus(this,0)'><span class='chekListFont'>추가</span></button>
					                    				</div>
				                    				</div>
				                    			</div>
				                    		</c:if>
				                    		<c:if test="${checkListSettingFormTOSMS ne '[]'}">
				                    			<c:forEach var="checkListSettingFormList" items="${checkListSettingFormTOSMS}">
				                    				<c:if test="${checkListSettingFormList.checkListSettingDivision eq 'TOSMS'}">
					                    				<div class='chckListForm' id='form_${checkListSettingFormList.checkListSettingFormKeyNum}'>
						                    				<div class='chckListCommand'>
						                    					<button class='btn btn-primary' onClick="checkListSettingForm(${checkListSettingFormList.checkListSettingFormKeyNum})" style='width: 70%; height: 50px;'>${checkListSettingFormList.checkListSettingFormName}</button>
						                    					<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this,${checkListSettingFormList.checkListSettingFormKeyNum})'><span class='chekListFont'>제거</span></button></div>
						                    					<div style='width: 80%; display: inline-block;'>
							                						<div class='input-group'>
																		<input type='text' class='form-control' id='inputChange' placeholder='이름'>
																		<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='formChange(this,${checkListSettingFormList.checkListSettingFormKeyNum})'>변경</button>
																	</div>
																</div>
						                    				</div>
						                    				<div class='chckListPlus'>
						                    					<button class='formPlus' onClick='formPlus(this,${checkListSettingFormList.checkListSettingFormKeyNum})'><span class='chekListFont'>추가</span></button>
						                    				</div>
						                    			</div>
						                    		</c:if>
					                    		</c:forEach>
				                    		</c:if>
		                    			</div>
			                    		<c:if test="${checkListSettingFormTOSMS ne '[]'}">
			                    			<c:forEach var="checkListSettingFormList" items="${checkListSettingFormTOSMS}">
				                    			<div class='categoryDiv' id='categoryDiv_${checkListSettingFormList.checkListSettingFormKeyNum}'>
				                    				<c:forEach var='checkListSettingCategoryList' items="${checkListSettingCategory}">
				                    					<c:if test="${checkListSettingFormList.checkListSettingFormKeyNum eq checkListSettingCategoryList.checkListSettingFormKeyNum}"> 
						                    				<div class='categorySmallDiv'>
						                    					<div style='height: 30px;'>
								                    				<input class='form-control' placeholder='Category' style='width: 40%; float: left;' value="${checkListSettingCategoryList.checkListSettingCategoryName}">
								                    				<button class='categorySave' onClick='categorySave(this,${checkListSettingCategoryList.checkListSettingCategoryKeyNum})'><span class='chekListFont'>저장</span></button>
								                    				<button class='categoryPlus' onClick='categoryPlus(this,${checkListSettingFormList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum})'><span class='chekListFont'>추가</span></button>
								                    				<button class='categoryMinus' onClick='categoryMinus(this,${checkListSettingCategoryList.checkListSettingCategoryKeyNum})'><span class='chekListFont'>제거</span></button>
								                    			</div>
								                    			<c:forEach var='checkListSettingSubCategoryList' items='${checkListSettingSubCategory}'>
								                    				<c:if test='${checkListSettingCategoryList.checkListSettingCategoryKeyNum eq checkListSettingSubCategoryList.checkListSettingCategoryKeyNum}'>
									                    				<div class='subCategoryDiv'>
									                    					<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;' value="${checkListSettingSubCategoryList.checkListSettingSubCategoryName}">
									                    					<button class='subCategorySave' onClick='subCategorySave(this,${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='chekListFont'>저장</span></button>
									                    					<button class='subCategoryPlus' onClick='subCategoryPlus(this,${checkListSettingFormList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum},${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='chekListFont'>추가</span></button>
									                    					<button class='subCategoryMinus' onClick='subCategoryMinus(this,${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='chekListFont'>제거</span></button>
									                    					<button class='subCategoryDetail' onClick='subCategoryDetail(${checkListSettingCategoryList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum},${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
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
		                    				<c:if test="${checkListSettingFormAgent eq '[]'}">
			                    				<div class='chckListForm'>
			                    					<div id='chckListPlusOne'>
					                    				<div style='padding-left: 100%; padding-top: 130%;'>
					                    					<button class='formPlus' onClick='formPlus(this,0)'><span class='chekListFont'>추가</span></button>
					                    				</div>
				                    				</div>
				                    			</div>
				                    		</c:if>
				                    		<c:if test="${checkListSettingFormAgent ne '[]'}">
				                    			<c:forEach var="checkListSettingFormList" items="${checkListSettingFormAgent}">
				                    				<c:if test="${checkListSettingFormList.checkListSettingDivision eq 'Agent'}">
					                    				<div class='chckListForm' id='form_${checkListSettingFormList.checkListSettingFormKeyNum}'>
						                    				<div class='chckListCommand'>
						                    					<button class='btn btn-primary' onClick="checkListSettingForm(${checkListSettingFormList.checkListSettingFormKeyNum})" style='width: 70%; height: 50px;'>${checkListSettingFormList.checkListSettingFormName}</button>
						                    					<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this,${checkListSettingFormList.checkListSettingFormKeyNum})'><span class='chekListFont'>제거</span></button></div>
						                    					<div style='width: 80%; display: inline-block;'>
							                						<div class='input-group'>
																		<input type='text' class='form-control' id='inputChange' placeholder='이름'>
																		<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='formChange(this,${checkListSettingFormList.checkListSettingFormKeyNum})'>변경</button>
																	</div>
																</div>
						                    				</div>
						                    				<div class='chckListPlus'>
						                    					<button class='formPlus' onClick='formPlus(this,${checkListSettingFormList.checkListSettingFormKeyNum})'><span class='chekListFont'>추가</span></button>
						                    				</div>
						                    			</div>
						                    		</c:if>
					                    		</c:forEach>
				                    		</c:if>
		                    			</div>
			                    		<c:if test="${checkListSettingFormAgent ne '[]'}">
			                    			<c:forEach var="checkListSettingFormList" items="${checkListSettingFormAgent}">
				                    			<div class='categoryDiv' id='categoryDiv_${checkListSettingFormList.checkListSettingFormKeyNum}'>
				                    				<c:forEach var='checkListSettingCategoryList' items="${checkListSettingCategory}">
				                    					<c:if test="${checkListSettingFormList.checkListSettingFormKeyNum eq checkListSettingCategoryList.checkListSettingFormKeyNum}"> 
						                    				<div class='categorySmallDiv'>
						                    					<div style='height: 30px;'>
								                    				<input class='form-control' placeholder='Category' style='width: 40%; float: left;' value="${checkListSettingCategoryList.checkListSettingCategoryName}">
								                    				<button class='categorySave' onClick='categorySave(this,${checkListSettingCategoryList.checkListSettingCategoryKeyNum})'><span class='chekListFont'>저장</span></button>
								                    				<button class='categoryPlus' onClick='categoryPlus(this,${checkListSettingFormList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum})'><span class='chekListFont'>추가</span></button>
								                    				<button class='categoryMinus' onClick='categoryMinus(this,${checkListSettingCategoryList.checkListSettingCategoryKeyNum})'><span class='chekListFont'>제거</span></button>
								                    			</div>
								                    			<c:forEach var='checkListSettingSubCategoryList' items='${checkListSettingSubCategory}'>
								                    				<c:if test='${checkListSettingCategoryList.checkListSettingCategoryKeyNum eq checkListSettingSubCategoryList.checkListSettingCategoryKeyNum}'>
									                    				<div class='subCategoryDiv'>
									                    					<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;' value="${checkListSettingSubCategoryList.checkListSettingSubCategoryName}">
									                    					<button class='subCategorySave' onClick='subCategorySave(this,${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='chekListFont'>저장</span></button>
									                    					<button class='subCategoryPlus' onClick='subCategoryPlus(this,${checkListSettingFormList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum},${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='chekListFont'>추가</span></button>
									                    					<button class='subCategoryMinus' onClick='subCategoryMinus(this,${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='chekListFont'>제거</span></button>
									                    					<button class='subCategoryDetail' onClick='subCategoryDetail(${checkListSettingCategoryList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum},${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
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
		
		function formChange(obj, number) {
			var btnName = $(obj).siblings('input').val();
			
			$.ajax({
				url: "<c:url value='/checkListSetting/formChange'/>",
				type: "POST",
				data: {
					"checkListSettingFormKeyNum": number,
					"checkListSettingFormName": btnName,
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
		
		
		function formPlus(obj,number) {
			var number2;
			var number3;
			var checkListSettingDivision = $('#checkListSettingDivision').val();
			
			$.ajax({
				url: "<c:url value='/checkListSetting/formPlus'/>",
				type: "POST",
				data: {
					"checkListSettingDivision": checkListSettingDivision,
					"checkListSettingFormKeyNum": number,
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
			var rowItem = "<div class='chckListForm' id='form_"+number+"'>";
			rowItem += "<div class='chckListCommand'>";
			rowItem += "<button class='btn btn-primary' onClick='checkListSettingForm("+number+")' style='width: 70%; height: 50px;'>미지정</button>";
			rowItem += "<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this,"+number+")'><span class='chekListFont'>제거</span></button></div>";
			rowItem += "<div style='width: 80%; display: inline-block;'>";
			rowItem += "<div class='input-group'>";
			rowItem += "<input type='text' class='form-control' id='inputChange' placeholder='이름'>";
			rowItem += "<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='formChange(this,"+number+")'>변경</button>";
			rowItem += "</div>";
			rowItem += "</div>";
			rowItem += "</div>";
			rowItem += "<div class='chckListPlus'>";
			rowItem += "<button class='formPlus' onClick='formPlus(this,"+number+")'><span class='chekListFont'>추가</span></button>";
			rowItem += "</div>";
			rowItem += "</div>";
			table.after(rowItem);
			
			$.ajax({
				url: "<c:url value='/checkListSetting/categoryPlus'/>",
				type: "POST",
				data: {"checkListSettingFormKeyNum":number},
				async: false,
				success: function(data) {
					number2 = data;
				},
				error: function(error) {
					console.log(error);
				}
			});
			$.ajax({
				url: "<c:url value='/checkListSetting/subCategoryPlus'/>",
				type: "POST",
				data: {
					"checkListSettingCategoryKeyNum":number2,
					"checkListSettingFormKeyNum": number,
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
			rowItem2 += "<button class='categorySave' onClick='categorySave(this,"+number2+")'><span class='chekListFont'>저장</span></button>";
			rowItem2 += "<button class='categoryPlus' onClick='categoryPlus(this,"+number+","+number2+")'><span class='chekListFont'>추가</span></button>";
			rowItem2 += "<button class='categoryMinus' onClick='categoryMinus(this,"+number2+")'><span class='chekListFont'>제거</span></button>";
			rowItem2 += "</div>";
			rowItem2 += "<div class='subCategoryDiv'>";
			rowItem2 += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem2 += "<button class='subCategorySave' onClick='subCategorySave(this,"+number3+")'><span class='chekListFont'>저장</span></button>";
			rowItem2 += "<button class='subCategoryPlus' onClick='subCategoryPlus(this,"+number+","+number2+","+number3+")'><span class='chekListFont'>추가</span></button>";
			rowItem2 += "<button class='subCategoryMinus' onClick='subCategoryMinus(this,"+number3+")'><span class='chekListFont'>제거</span></button>";
			rowItem2 += "<button class='subCategoryDetail' onClick='subCategoryDetail("+number+","+number2+","+number3+")'><span class='subCategoryDetailFont'>!</span></button>";
			rowItem2 += "</div>";
			rowItem2 += "</div>";
			rowItem2 += "</div>";
			table2.after(rowItem2);
			
			$('#chckListPlusOne').hide();
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
						url: "<c:url value='/checkListSetting/formMinus'/>",
						type: "POST",
						data: {
							"checkListSettingFormKeyNum": number,
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
			var checkListSettingCategoryName = $(obj).siblings('input').val();
			
			$.ajax({
				url: "<c:url value='/checkListSetting/categorySave'/>",
				type: "POST",
				data: {
					"checkListSettingCategoryKeyNum": number,
					"checkListSettingCategoryName": checkListSettingCategoryName,
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
				url: "<c:url value='/checkListSetting/categoryPlus'/>",
				type: "POST",
				data: {
					"checkListSettingFormKeyNum":number,
					"checkListSettingCategoryKeyNum":number2,
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
				url: "<c:url value='/checkListSetting/subCategoryPlus'/>",
				type: "POST",
				data: {
					"checkListSettingCategoryKeyNum":number2,
					"checkListSettingFormKeyNum": number,
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
			rowItem += "<button class='categorySave' onClick='categorySave(this,"+number2+")'><span class='chekListFont'>저장</span></button>";
			rowItem += "<button class='categoryPlus' onClick='categoryPlus(this,"+number+","+number2+")'><span class='chekListFont'>추가</span></button>";
			rowItem += "<button class='categoryMinus' onClick='categoryMinus(this,"+number2+")'><span class='chekListFont'>제거</span></button>";
			rowItem += "</div>";
			rowItem += "<div class='subCategoryDiv'>";
			rowItem += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='subCategorySave' onClick='subCategorySave(this,"+number3+")'><span class='chekListFont'>저장</span></button>";
			rowItem += "<button class='subCategoryPlus' onClick='subCategoryPlus(this,"+number+","+number2+","+number3+")'><span class='chekListFont'>추가</span></button>";
			rowItem += "<button class='subCategoryMinus' onClick='subCategoryMinus(this,"+number3+")'><span class='chekListFont'>제거</span></button>";
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
						url: "<c:url value='/checkListSetting/categoryMinus'/>",
						type: "POST",
						data: {
							"checkListSettingCategoryKeyNum":number,
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
			var checkListSettingSubCategoryName = $(obj).siblings('input').val();
			
			$.ajax({
				url: "<c:url value='/checkListSetting/subCategorySave'/>",
				type: "POST",
				data: {
					"checkListSettingSubCategoryKeyNum": number,
					"checkListSettingSubCategoryName": checkListSettingSubCategoryName,
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
				url: "<c:url value='/checkListSetting/subCategoryPlus'/>",
				type: "POST",
				data: {
					"checkListSettingFormKeyNum": number,
					"checkListSettingCategoryKeyNum": number2,
					"checkListSettingSubCategoryKeyNum": number3,
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
			rowItem += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='subCategorySave' onClick='subCategorySave(this,"+number3+")'><span class='chekListFont'>저장</span></button>";
			rowItem += "<button class='subCategoryPlus' onClick='subCategoryPlus(this,"+number+","+number2+","+number3+")'><span class='chekListFont'>추가</span></button>";
			rowItem += "<button class='subCategoryMinus' onClick='subCategoryMinus(this,"+number3+")'><span class='chekListFont'>제거</span></button>";
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
						url: "<c:url value='/checkListSetting/subCategoryMinus'/>",
						type: "POST",
						data: {
							"checkListSettingSubCategoryKeyNum": number,
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
		
		function checkListSettingForm(number) {
			$('.categorySmallDiv').show();
			$('.categoryDiv').hide();
			$('#categoryDiv_'+number).show();
		}
		
		function subCategoryDetail(number, number2, number3) {
			var url = "<c:url value='/checkListSetting/detailView?checkListSettingFormKeyNum="+number+"&checkListSettingCategoryKeyNum="+number2+"&checkListSettingSubCategoryKeyNum="+number3+"'/>";
			var windowFeatures = 'width=1000,height=800';
			window.open(url, '_blank', windowFeatures);
		}
		
	</script>
	
	<style>
		.divisionActive {
			background: black !important;
			font-weight: bold !important;
			color: white !important;
		}
		
		.chckListPlus {
		    text-align: center;
		    height: 100%;
		    padding-top: 25%;
		    float: left;
		}
		
		.chckListCommand {
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
		
		.chekListFont {
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
	</style>
</html>