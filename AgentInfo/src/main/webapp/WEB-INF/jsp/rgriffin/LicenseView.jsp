<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="<c:url value='/timepicker/jquery-ui-timepicker-addon.min.css'/>">
<script type="text/javascript" src="<c:url value='/timepicker/jquery-ui-timepicker-addon.min.js'/>"></script>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 380px;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 25px; border-bottom: dashed 1px silver; float:left"></div>
		<div class="leftDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotCompany" style="display: none; line-height: initial; float: right;">고객사명을 입력해주세요.</span>
			 	<input type="text" id="rgriffinCompanyView" name="rgriffinCompanyView" class="form-control viewForm" value="${license.rgriffinCompany}" placeholder="SECUVE">
			</div>
			<div class="pading5Width450">
				<label class="labelFontSize">카테고리</label>
			 	<input type="text" id="rgriffinCategoryView" name="rgriffinCategoryView" class="form-control viewForm" value="${license.rgriffinCategory}" placeholder="TEST">
			</div>
			<div class="pading5Width450">
				<label class="labelFontSize">발급일</label>
				<input type="text" id="rgriffinIssueDateView" name="rgriffinIssueDateView" class="form-control viewForm" value="${license.rgriffinIssueDate}" readonly>
		    </div>
	        <!-- <div class="pading5Width450">
				<label class="labelFontSize">만료일</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotExpire" style="display: none; line-height: initial; float: right;">만료일을 입력해주세요.</span>
				<input type="text" id="rgriffinExpireView" name="rgriffinExpireView" class="form-control viewForm" value="${license.rgriffinExpire}" placeholder="YYYY-MM-DD hh:mm:ss" autocomplete="off">
		    </div> -->
			<div class="pading5Width450">
				<label class="labelFontSize">만료일</label><label class="colorRed">*</label>
				<div class="floatRight normalLicense">
					<input class="cssCheck" type="checkbox" id="chkExpirationDays" name="chkExpirationDays" value="무제한">
				   <label for="chkExpirationDays"></label><span class="margin17">무제한</span>
				 </div>
				 <div style="width: 100%">
					<input type="text" id="rgriffinExpireView" name="rgriffinExpireView" class="form-control viewForm" value="${license.rgriffinExpire}" placeholder="YYYY-MM-DD hh:mm:ss" autocomplete="off">
				 </div>
			 </div>
			 <div class="pading5Width450">
				<label class="labelFontSize">수량</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotQuantity" style="display: none; line-height: initial; float: right;">수량을 입력해주세요.</span>
				 <div style="width: 100%">
					<input type="number" id="rgriffinQuantityView" name="rgriffinQuantityView" class="form-control viewForm" value="${license.rgriffinQuantity}" placeholder="0">
				 </div>
			 </div>
	    </div>
        <div class="rightDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">RGMSID</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotRgmsid" style="display: none; line-height: initial; float: right;">RGMSID를 입력해주세요.</span>
				<input type="text" id="rgriffinRgmsidView" name="rgriffinRgmsidView" class="form-control viewForm" value="${license.rgriffinRgmsid}" placeholder="{hostname}.{wmic path win32_computersystemproduct get UUID}">
		   </div>
		   <div class="pading5Width450">
				<label class="labelFontSize">비밀번호</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotPassword" style="display: none; line-height: initial; float: right;">비밀번호를 입력해주세요.</span>
				<input type="text" id="rgriffinPasswordView" name="rgriffinPasswordView" class="form-control viewForm" value="zaq1@WSX3">
		   </div>
			<div class="pading5Width450">
				<label class="labelFontSize">라이선스 파일명</label>
				<input type="text" id="rgriffinFilePathView" name="rgriffinFilePathView" class="form-control viewForm" placeholder="고객사명.json" value="${license.rgriffinFilePath}">
		   </div>
	       <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
				<input type="text" id="rgriffinRequesterView" name="rgriffinRequesterView" class="form-control viewForm" value="${license.rgriffinRequester}" style="width: 90%;">
	         	<input type="hidden" id="requesterId" name="requesterId" class="form-control viewForm" value="${license.requesterId}" readonly>
				<div class="custom-btn" style="float: right; width: 45px;">
					<button class="btn custom-btn" type="button" onclick="requesterSearch()" style="margin-right: 7px; background: #ffc4c4; margin-top: -48px; height: 35px;">검색</button>
				</div>
	        </div>
			<div class="pading5Width450 scribePeriod scribeMetering">
	         	<label class="labelFontSize">담당 영업</label>
				<input type="text" id="salesManagerNameView" name="salesManagerNameView" class="form-control viewForm" value="${license.salesManagerName}" style="width: 90%;" readonly>
	         	<input type="hidden" id="salesManagerId" name="salesManagerId" class="form-control viewForm" value="${license.salesManagerId}" readonly>
				<div class="custom-btn" style="float: right; width: 45px;">
					<button class="btn custom-btn" type="button" onclick="salesManagerSearch()" style="margin-right: 7px; background: #ffc4c4; margin-top: -48px; height: 35px;">검색</button>
				</div>
	        </div>
        </div>
        <input type="hidden" id="rgriffinKeyNum" name="rgriffinKeyNum" value="${license.rgriffinKeyNum}">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
		<input type="hidden" id="licenseTypeView" name="licenseTypeView" value="${license.licenseType}">
	</form>
</div>
<div class="modal-footer">
	<c:if test="${viewType eq 'insert'}">
		<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert()">발급</button>
	</c:if>
	<c:if test="${viewType eq 'update'}">
		<button class="btn btn-default btn-outline-info-add" onClick="BtnUpdate()">수정</button>
	</c:if>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>	
	/* =========== 라이선스 발급 ========= */
	function BtnInsert() {
		var licenseTypeView = $('#licenseTypeView').val();
		var rgriffinCompanyView = $('#rgriffinCompanyView').val();
		var rgriffinExpireView = $('#rgriffinExpireView').val();
		var rgriffinQuantityView = $('#rgriffinQuantityView').val();
		var rgriffinRgmsidView = $('#rgriffinRgmsidView').val();
		var rgriffinPasswordView = $('#rgriffinPasswordView').val();
		var validation = true;

		if(rgriffinCompanyView == "") {
			$('#NotCompany').show();
			validation = false;
		}
		if(rgriffinExpireView == "") {
			$('#NotExpire').show();
			validation = false;
		}
		if(rgriffinQuantityView == "") {
			$('#NotQuantity').show();
			validation = false;
		}
		if(rgriffinRgmsidView == "") {
			$('#NotRgmsid').show();
			validation = false;
		}
		if(rgriffinPasswordView == "") {
			$('#NotPassword').show();
			validation = false;
		}

		if(!validation) {
			return false;
		}


		var postData = $('#modalForm').serializeObject();
		
		$.ajax({
			url: "<c:url value='/rgriffin/licenseIssuance'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (result) {
				if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
	            	$('#modal').on('hidden.bs.modal', function () {
						location.href="<c:url value='/rgriffin/licenseIssuanceDownLoad'/>?fileName="+rgriffinCompanyView;
	            		tableRefresh();
	            	});
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
		    },
			error: function(error) {
				console.log(error);
			}
		});
	};
	
	
	function BtnUpdate() {	
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/rgriffin/licenseUpdate'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (result) {
		    	if(result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
	            	$('#modal').on('hidden.bs.modal', function () {
	            		tableRefresh();
	            	});
				} else {
					Swal.fire({               
						icon: 'error',          
						title: '실패!',           
						text: '작업을 실패했습니다.',    
					});  
				}
		    },
			error: function(error) {
				console.log(error);
			}
		});
	}

	$("#rgriffinCompanyView").change(function() {
		var rgriffinCompany = $('#rgriffinCompanyView').val();
		$('#rgriffinFilePathView').val(rgriffinCompany+".json");
	});

	$(function() {
	    $("#rgriffinExpireView").datetimepicker({
	        dateFormat: "yy-mm-dd",
	        timeFormat: "HH:mm:ss",
	        showSecond: true,
	        controlType: 'select', // 시간 선택을 드롭다운으로
	        oneLine: true
	    });

		var $input = $("#rgriffinIssueDateView");

    	// 값이 비어있으면 오늘 날짜를 넣기
    	if (!$input.val()) {
    	    var today = new Date();
    	    var yyyy = today.getFullYear();
    	    var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월 2자리
    	    var dd = String(today.getDate()).padStart(2, '0');        // 일 2자리

    	    $input.val(yyyy + "-" + mm + "-" + dd);
    	}
	});
	
	if('${license.licenseType}' == '(일반)' || '${license.licenseTypeView}' == '(일반)') {
		btnLicense();
	} else if('${license.licenseType}' == '구독(기간)' || '${license.licenseTypeView}' == '구독(기간)') {
		btnScribePeriod();
	} else if('${license.licenseType}' == '구독(미터링)' || '${license.licenseTypeView}' == '구독(미터링)') {
		btnScribeMetering();
	}

	function btnLicense() {
		$('.scribeMetering').css("display","none");
		$('.scribePeriod').css("display","none");
		$('.normalLicense').css("display","block");

		$('#btnLicense').addClass('customerManagentActive');
		$('#btnScribeMetering').removeClass('customerManagentActive');
		$('#btnScribePeriod').removeClass('customerManagentActive');
		$('#licenseTypeView').val("(일반)");
	}

	function btnScribePeriod() {
		$('.scribeMetering').css("display","none");
		$('.normalLicense').css("display","none");
		$('.scribePeriod').css("display","block");

		$('#btnScribePeriod').addClass('customerManagentActive');
		$('#btnLicense').removeClass('customerManagentActive');
		$('#btnScribeMetering').removeClass('customerManagentActive');
		$('#licenseTypeView').val("구독(기간)");
	}

	function btnScribeMetering() {
		$('.scribePeriod').css("display","none");
		$('.normalLicense').css("display","none");
		$('.scribeMetering').css("display","block");

		$('#btnScribePeriod').removeClass('customerManagentActive');
		$('#btnLicense').removeClass('customerManagentActive');
		$('#btnScribeMetering').addClass('customerManagentActive');
		$('#licenseTypeView').val("구독(미터링)");
	}

	$('#chkExpirationDays').change(function() {
		if($("#chkExpirationDays").is(":checked")){
			$("#rgriffinExpireView").attr("disabled",true);
		} else {
			$("#rgriffinExpireView").attr("disabled",false);
		}
	});

	function salesManagerSearch() {
		window.open("<c:url value='/employee/salesManagerSearch'/>?selectType=salesManager", '', 'width=1000,height=690,scrollbars=yes,resizable=yes');
	}

	function requesterSearch() {
		window.open("<c:url value='/employee/salesManagerSearch'/>?selectType=requester", '', 'width=1000,height=690,scrollbars=yes,resizable=yes');
	}

	function setSalesManager(employeeId, employeeName) {
		$('#salesManagerNameView').val(employeeName);
		$('#salesManagerId').val(employeeId);
	}

	function setRequester(employeeId, employeeName) {
		$('#requesterView').val(employeeName);
		$('#requesterId').val(employeeId);
	}
</script>

<style>
	#salesManagerNameView {
		background-color: #efefef !important; /* disabled 비슷한 회색 */
		color: black !important;           /* 글자색도 연하게 */
	}
</style>