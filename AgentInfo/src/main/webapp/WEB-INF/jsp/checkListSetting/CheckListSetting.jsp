<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- SummerNote -->
		<script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>">
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	if("${checkListSettingType}" == "totalTest") {
			    	$.cookie('name','totalTest');
		    	} else if("${checkListSettingType}" == "vasicTest") {
		    		$.cookie('name','vasicTest');
		    	} else if("${checkListSettingType}" == "foundationTest") {
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
			                	<input type='hidden' id='checkListSettingDivisionName' name='checkListSettingDivisionName' value='TOSMS'>
			                </div>
			                <div class='main-body' id='main-TOSMS'>
			                    <div class='page-wrapper'>
			                    	<div class='ibox'>
		                    			<div style='width: 100%; height: 140px; background: rgba(0, 0, 0, 0.05)'>
		                    				<c:if test="${checkListSettingForm eq '[]'}">
			                    				<div class='chckListForm'>
				                    				<div class='chckListCommand'>
				                    					<button class='btn btn-primary'  id='form_1' style='width: 70%; height: 50px;'>미지정</button>
				                    					<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this)'><span class='chekListFont'>제거</span></button></div>
				                    					<div style='width: 80%; display: inline-block;'>
					                						<div class='input-group'>
																<input type='text' class='form-control' id='inputChange' placeholder='이름'>
																<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='btnChange(this)'>변경</button>
															</div>
														</div>
				                    				</div>
				                    				<div class='chckListPlus'>
				                    					<button class='formPlus' onClick='formPlus(this)'><span class='chekListFont'>추가</span></button>
				                    				</div>
				                    			</div>
				                    		</c:if>
				                    		<c:if test="${checkListSettingForm ne '[]'}">
				                    			<c:forEach var="checkListSettingFormList" items="${checkListSettingForm}">
				                    				<div class='chckListForm'>
					                    				<div class='chckListCommand'>
					                    					<button class='btn btn-primary'  id='form_${checkListSettingFormList.checkListSettingFormKeyNum}' onClick="checkListSettingForm(${checkListSettingFormList.checkListSettingFormKeyNum})" style='width: 70%; height: 50px;'>${checkListSettingFormList.checkListSettingFormName}</button>
					                    					<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this)'><span class='chekListFont'>제거</span></button></div>
					                    					<div style='width: 80%; display: inline-block;'>
						                						<div class='input-group'>
																	<input type='text' class='form-control' id='inputChange' placeholder='이름'>
																	<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='btnChange(this)'>변경</button>
																</div>
															</div>
					                    				</div>
					                    				<div class='chckListPlus'>
					                    					<button class='formPlus' onClick='formPlus(this)'><span class='chekListFont'>추가</span></button>
					                    				</div>
					                    			</div>
					                    		</c:forEach>
				                    		</c:if>
		                    			</div>
		                    			<c:if test="${checkListSettingForm eq '[]'}">
			                    			<div class='categoryDiv' id='categoryDiv_1'>
			                    				<div>
			                    					<div style='height: 30px;'>
					                    				<input class='form-control' placeholder='Category' style='width: 40%; float: left;'>
					                    				<button class='categoryPlus' onClick='categoryPlus(this)'><span class='chekListFont'>추가</span></button>
					                    				<button class='categoryMinus' onClick='categoryMinus(this)'><span class='chekListFont'>제거</span></button>
					                    			</div>
				                    				<div class='subCategoryDiv'>
				                    					<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>
				                    					<button class='subCategoryPlus' onClick='subCategoryPlus(this)'><span class='chekListFont'>추가</span></button>
				                    					<button class='subCategoryMinus' onClick='subCategoryMinus(this)'><span class='chekListFont'>제거</span></button>
				                    					<button class='subCategoryDetail' onClick='subCategoryDetail()'><span class='subCategoryDetailFont'>!</span></button>
				                    				</div>
				                    			</div>
			                    			</div>
			                    		</c:if>
			                    		<c:if test="${checkListSettingForm ne '[]'}">
			                    			<c:forEach var="checkListSettingFormList" items="${checkListSettingForm}">
				                    			<div class='categoryDiv' id='categoryDiv_${checkListSettingFormList.checkListSettingFormKeyNum}'>
				                    				<div>
				                    					<div style='height: 30px;'>
						                    				<input class='form-control' placeholder='Category' style='width: 40%; float: left;'>
						                    				<button class='categoryPlus' onClick='categoryPlus(this)'><span class='chekListFont'>추가</span></button>
						                    				<button class='categoryMinus' onClick='categoryMinus(this)'><span class='chekListFont'>제거</span></button>
						                    			</div>
					                    				<div class='subCategoryDiv'>
					                    					<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>
					                    					<button class='subCategoryPlus' onClick='subCategoryPlus(this)'><span class='chekListFont'>추가</span></button>
					                    					<button class='subCategoryMinus' onClick='subCategoryMinus(this)'><span class='chekListFont'>제거</span></button>
					                    					<button class='subCategoryDetail' onClick='subCategoryDetail()'><span class='subCategoryDetailFont'>!</span></button>
					                    				</div>
					                    			</div>
				                    			</div>
				                    		</c:forEach>
			                    		</c:if>
		                    		</div>
	                        	</div>
		                    </div>
		                    <!-- ================================================================================================================= -->
		                    <div class='main-body' id='main-Agent' style="display: none;">
			                    <div class="page-wrapper">
			                    	<div class="ibox">
		                    			<div style="width: 100%; height: 130px; background: rgba(0, 0, 0, 0.05)">
		                    				<div class="chckListCommand">
		                    					<button class="btn btn-primary" style="width: 70%; height: 50px;">미지정</button>
		                    					<div style="height: 30px; padding-top: 5px;"><button><span class='chekListFont'>제거</span></button></div>
		                    					<div style="width: 80%; display: inline-block;">
			                						<div class="input-group">
														<input type="text" class="form-control" id="inputChange" placeholder="이름">
														<button class="btn btn-primary" style="background: dimgray; border-color: black;" id="btnChange" onClick="btnChange(this)">변경</button>
													</div>
												</div>
		                    				</div>
		                    				<div class="chckListPlus">
		                    					<button onClick="formPlus(this)"><span class='chekListFont'>추가</span></button>
		                    				</div>
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
		$('#TOSMS').click(function() {
			$('#TOSMS').addClass('divisionActive');
			$('#Agent').removeClass('divisionActive');
			$('#checkListSettingDivisionName').val('TOSMS');
			$('#main-TOSMS').show();
			$('#main-Agent').hide();
		});
		
		$('#Agent').click(function() {
			$('#Agent').addClass('divisionActive');
			$('#TOSMS').removeClass('divisionActive');
			$('#checkListSettingDivisionName').val('Agent');
			$('#main-TOSMS').hide();
			$('#main-Agent').show();
		});
		
		function btnChange(obj) {
			var btnName = $(obj).siblings('input').val();
			$(obj).parent().parent().siblings('button').first().text(btnName);
			console.log($(obj).parent().parent().siblings('button').text());
		}
		
		
		function formPlus(obj) {
			var table = $(obj).parent().parent();
			var rowItem = "<div>";
			rowItem += "<div class='chckListCommand'>";
			rowItem += "<button class='btn btn-primary' style='width: 70%; height: 50px;'>미지정</button>";
			rowItem += "<div style='height: 30px; padding-top: 5px;'><button class='formMinus' onClick='formMinus(this)'><span class='chekListFont'>제거</span></button></div>";
			rowItem += "<div style='width: 80%; display: inline-block;'>";
			rowItem += "<div class='input-group'>";
			rowItem += "<input type='text' class='form-control' id='inputChange' placeholder='이름'>";
			rowItem += "<button class='btn btn-primary' style='background: dimgray; border-color: black;' onClick='btnChange(this)'>변경</button>";
			rowItem += "</div>";
			rowItem += "</div>";
			rowItem += "</div>";
			rowItem += "<div class='chckListPlus'>";
			rowItem += "<button class='formPlus' onClick='formPlus(this)'><span class='chekListFont'>추가</span></button>";
			rowItem += "</div>";
			rowItem += "</div>";
			table.after(rowItem);
		}
		
		function formMinus(obj) {
			$(obj).parent().parent().parent().remove();
		}
		
		function categoryPlus(obj) {
			var table = $(obj).parent().parent();
			var rowItem = "<div style='padding-top: 5%;'>";
			rowItem += "<div style='height: 30px;'>";
			rowItem += "<input class='form-control' placeholder='Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='categoryPlus' onClick='categoryPlus(this)'><span class='chekListFont'>추가</span></button>";
			rowItem += "<button class='categoryMinus' onClick='categoryMinus(this)'><span class='chekListFont'>제거</span></button>";
			rowItem += "</div>";
			rowItem += "<div class='subCategoryDiv'>";
			rowItem += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='subCategoryPlus' onClick='subCategoryPlus(this)'><span class='chekListFont'>추가</span></button>";
			rowItem += "<button class='subCategoryMinus' onClick='subCategoryMinus(this)'><span class='chekListFont'>제거</span></button>";
			rowItem += "<button class='subCategoryDetail' onClick='subCategoryDetail()'><span class='subCategoryDetailFont'>!</span></button>";
			rowItem += "</div>";
			rowItem += "</div>";
			console.log(table);
			table.after(rowItem);
		}
		
		function categoryMinus(obj) {
			$(obj).parent().parent().remove();
		}
		
		function subCategoryPlus(obj) {
			var table = $(obj).parent();
			var rowItem = "<div class='subCategoryDiv'>";
			rowItem += "<input class='form-control' placeholder='Sub Category' style='width: 40%; float: left;'>";
			rowItem += "<button class='subCategoryPlus' onClick='subCategoryPlus(this)'><span class='chekListFont'>추가</span></button>";
			rowItem += "<button class='subCategoryMinus' onClick='subCategoryMinus(this)'><span class='chekListFont'>제거</span></button>";
			rowItem += "<button class='subCategoryDetail' onClick='subCategoryDetail()'><span class='subCategoryDetailFont'>!</span></button>";
			rowItem += "</div>";
			table.after(rowItem);
		}
		
		function subCategoryMinus(obj) {
			$(obj).parent().remove();
		}
		
		$('#form_1').click(function() {
			$('.categoryDiv').hide();
			$('#categoryDiv_1').show();
		});
		
		function checkListSettingForm(number) {
			console.log(number);
			$('.categoryDiv').hide();
			$('#categoryDiv_'+number).show();
		}
		
	</script>
	
	<style>
		.divisionActive {
			background: black !important;
			font-weight: bold !important;
			color: white !important;
		}
		
		.chckListPlus {
			width: 3%;
		    text-align: center;
		    height: 100%;
		    padding-top: 3.5%;
		    float: left;
		}
		
		.chckListCommand {
			width: 15%;
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
		
	</style>
</html>