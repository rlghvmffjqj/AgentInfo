<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	if("${checkListType}" == "totalTest") {
			    	$.cookie('name','totalTest');
		    	} else if("${checkListType}" == "basicTest") {
		    		$.cookie('name','basicTest');
		    	} else if("${checkListType}" == "foundationTest") {
		    		$.cookie('name','foundationTest');
		    	}
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
							                <p class="m-b-0">Set up a test checklist</p>
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
			                <div class='main-body' id='main-TOSMS'>
			                    <div class='page-wrapper'>
			                    	<div class='ibox'>
		                    			<div class='formDiv'>
				                    		<c:forEach var="checkListSettingFormList" items="${checkListSettingFormTOSMS}">
				                    			<c:if test="${checkListSettingFormList.checkListSettingDivision eq 'TOSMS'}">
					                    			<div class='chckListForm' id='form_${checkListSettingFormList.checkListSettingFormKeyNum}'>
						                    			<div class='chckListCommand'>
						                    				<button class='btn btn-primary formBtn' onClick="checkListForm(${checkListSettingFormList.checkListSettingFormKeyNum})">${checkListSettingFormList.checkListSettingFormName}</button>
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
																				<input type="checkbox" name="checkbox1" class="custom-checkbox">
																				<span class="checkmark"></span>
																			</label>
																		</div>

									                					<span class="subCategorySpan">${checkListSettingSubCategoryList.checkListSettingSubCategoryName}</span>
									                					<input class='form-control' placeholder='Note' style='width: 53%; float: left;'>
									                					<button class='subCategoryDetail' onClick='subCategoryDetail(${checkListSettingCategoryList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum},${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
									                				</div>
									                			</c:if>
								                			</c:forEach>
							                			</div>
							                		</c:if>
						                		</c:forEach>
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
						                    				<button class='btn btn-primary formBtn' onClick="checkListForm(${checkListSettingFormList.checkListSettingFormKeyNum})">${checkListSettingFormList.checkListSettingFormName}</button>
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
								                				<span class='categorySpan'>${checkListSettingCategoryList.checkListSettingCategoryName}</span>
								                			</div>
								                			<c:forEach var='checkListSettingSubCategoryList' items='${checkListSettingSubCategory}'>
								                				<c:if test='${checkListSettingCategoryList.checkListSettingCategoryKeyNum eq checkListSettingSubCategoryList.checkListSettingCategoryKeyNum}'>
									                				<div class='subCategoryDiv'>
									                					<span class="subCategorySpan">${checkListSettingSubCategoryList.checkListSettingSubCategoryName}</span>
									                					<button class='subCategoryDetail' onClick='subCategoryDetail(${checkListSettingCategoryList.checkListSettingFormKeyNum},${checkListSettingCategoryList.checkListSettingCategoryKeyNum},${checkListSettingSubCategoryList.checkListSettingSubCategoryKeyNum})'><span class='subCategoryDetailFont'>!</span></button>
									                				</div>
									                			</c:if>
								                			</c:forEach>
							                			</div>
							                		</c:if>
						                		</c:forEach>
				                    		</div>
				                    	</c:forEach>
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
		
		function checkListForm(number) {
			$('.categorySmallDiv').show();
			$('.categoryDiv').hide();
			$('#categoryDiv_'+number).show();
		}
		
		function subCategoryDetail(number, number2, number3) {
			var url = "<c:url value='/checkList/detailView?checkListSettingFormKeyNum="+number+"&checkListSettingCategoryKeyNum="+number2+"&checkListSettingSubCategoryKeyNum="+number3+"'/>";
			var windowFeatures = 'width=1000,height=800';
			window.open(url, '_blank', windowFeatures);
		}
	</script>
	<script>
		const checkbox = document.querySelector('.custom-checkbox');
		let clickCount = 0;

		checkbox.addEventListener('click', function() {
		  clickCount++;
		  
		  if (clickCount === 1) {
		    this.classList.remove('failure', 'empty');
		    this.classList.add('success');
		  } else if (clickCount === 2) {
		    this.classList.remove('success', 'empty');
		    this.classList.add('failure');
		  } else if (clickCount === 3) {
		    this.classList.remove('success', 'failure');
		    this.classList.add('empty');
		    clickCount = 0;
		  }
		});

		
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
			width: 150px;
		    font-weight: bold;
		    font-size: 14px;
		    height: 55px;
		}
		
		.categorySpan {
			font-size: 25px;
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
		  display: block;
		  content: "X";
		  font-weight: bold;
		  font-size: 12px;
		  text-align: center;
		  line-height: 10px;
		  border-color: #ff0000;
		}
		
		.custom-checkbox.empty + .checkmark::after {
		  display: none;
		}
		
		
	</style>
</html>