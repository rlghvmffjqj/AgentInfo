<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 450px;">
	<form id="modalForm" name="form" method ="post">
		<div style="width: 100%; height: 25px; border-bottom: dashed 1px silver; float:left">
			<div style="width: 65%; float:left">
				<input class="cssCheck" type="checkbox" id="chkLicenseIssuance" name="chkLicenseIssuance" checked>
		    	<label for="chkLicenseIssuance"></label><span class="margin17">라이선스 발급(해제할 경우 Database에 입력한 정보만 저장되고 라이선스 발급하지 않습니다.)</span>
		    </div>
		    <div style="width: 35%; float:right">
			<input id="serialNumberView" name="serialNumberView" placeholder="시리얼 번호" style="border: 1px solid silver; width: 90%; display: none" value="${license.serialNumber}">
		</div>
		</div>
		
		<div class="leftDiv">
			<div class="pading5Width450">
				<div>
			 		<label class="labelFontSize">발급대상(고객사)</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력 바랍니다..</span>
			 	</div>
			 	<input type="text" id="customerNameView" name="customerNameView" class="form-control viewForm" value="${license.customerName}">
			</div>
			<div class="pading5Width450">
				<div>
			 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
				<span class="colorRed fontSize10 licenseShow" id="NotBusinessName" style="display: none; line-height: initial;">사업명을 입력 바랍니다..</span>
			 	</div>
			 	<input type="text" id="businessNameView" name="businessNameView" class="form-control viewForm" value="${license.businessName}">
			</div>
	        <div class="pading5Width450">
				<label class="labelFontSize">MAC</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">MAC주소가 형식에 어긋납니다.</span>
				<input type="text" id="macAddressView" name="macAddressView" class="form-control viewForm" value="${license.macAddress}" placeholder="00:1A:2B:3C:4D:5E">
		    </div>
			<div class="pading5Width450">
				<label class="labelFontSize">제품명</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">제품명을 입력 바랍니다.</span>
				<input type="text" id="productNameView" name="productNameView" class="form-control viewForm" value="${license.productName}">
		    </div>
			<div class="pading5Width450">
				<label class="labelFontSize">제품 버전</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">제품 버전 입력 바랍니다.</span>
				<input type="text" id="productVersionView" name="productVersionView" class="form-control viewForm" value="${license.productVersion}">
		    </div>
	    </div>
        <div class="rightDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">에이전트</label><label class="colorRed">*</label>
				<div class="floatRight">
					<input class="cssCheck" type="checkbox" id="chkAgentCount" name="chkAgentCount" value="무제한">
				   <label for="chkAgentCount"></label><span class="margin17">무제한</span>
			   </div>
				<input type="number" id="agentCountView" name="agentCountView" class="form-control viewForm" value="0">
		   </div>
		   <div class="pading5Width450">
				<label class="labelFontSize">에이전트리스</label><label class="colorRed">*</label>
				<div class="floatRight">
					<input class="cssCheck" type="checkbox" id="chkAgentLisCountCount" name="chkAgentLisCountCount" value="무제한">
				   <label for="chkAgentLisCountCount"></label><span class="margin17">무제한</span>
			   </div>
				<input type="number" id="agentLisCountCountView" name="agentLisCountCountView" class="form-control viewForm" value="0">
		   </div>
		   <div class="pading5Width450">
			   <label class="labelFontSize">발급일</label><label class="colorRed">*</label>
			   <span class="colorRed licenseShow" id="NotIssueDate" style="display: none; line-height: initial; float: right; font-size: 11px;">발급일을 입력해주세요.</span>
			   <input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm" value="${license.issueDate}">
		   </div>
		   <div class="pading5Width450">
			   <label class="labelFontSize">만료일</label><label class="colorRed">*</label>
			   <div class="floatRight">
				   <input class="cssCheck" type="checkbox" id="chkExpirationDays" name="chkExpirationDays" value="무제한">
				  <label for="chkExpirationDays"></label><span class="margin17">무제한</span>
				  </div>
				  <a href="#" class="selfInput" style="margin-right: 2%;" id="expirationDaysChange" onclick="selfInputCalendar('expirationDaysChange');">달력</a>
			   <div id="expirationDaysViewSelf" style="display:none; width: 100%">
				   <input type="date" id="expirationDaysCalender" name="expirationDaysCalender" class="form-control viewForm">
			   </div>
			   <div id="expirationDaysViewSelect">
				   <input type="number" id="expirationDaysDay" name="expirationDaysDay" class="form-control viewForm" value="90">
				  </div>
		   </div>
		   <div class="pading5Width450">
				<label class="labelFontSize">추가정보</label>
				<input type="text" id="additionalInformationView" name="additionalInformationView" class="form-control viewForm" value="${license.additionalInformation}">
	   		</div>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}">
	        </div>
        </div>
        <input type="hidden" id="logGriffinKeyNum" name="logGriffinKeyNum" value="${license.logGriffinKeyNum}">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
        <input type="hidden" id="expirationDaysView" name="expirationDaysView" value="${license.expirationDays}">
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" onClick="existenceCheck()">발급</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$(function() {
		var clientTime = new Date();
		var options = {
     	   year: 'numeric',
     	   month: '2-digit',
     	   day: '2-digit'
   		};
		var formattedTime = clientTime.toLocaleDateString('en-US', options);

		if(formattedTime != "${ServerTime}") {
			Swal.fire({               
				icon: 'info',          
				title: '시작일 확인!',           
				text: '라이선스 발급서버 시간과 사용자PC 시간이 일치하지않습니다. 시작일이 올바르게 입력되었는지 확인 후 발급 진행 바랍니다.',    
			});
		}

		if($('#viewType').val() == 'issued') {
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-loggriffin-'+businessName+'-'+issueDate+".yml");
		}
		
		if($('#viewType').val() == 'update' || $('#viewType').val() == 'issuedback') {
			if($('#expirationDaysView').val() == "무제한") {
				$('#chkExpirationDays').prop("checked",true);
				$("#expirationDaysDay").val(90);
				$("#expirationDaysCalender").attr("disabled",true);
				$("#expirationDaysDay").attr("disabled",true);
				$("#expirationDaysView").attr("disabled",true);
			} else if($('#expirationDaysView').val().length > 4) {
				$("#expirationDaysChange").text("Day");
				$('#expirationDaysViewSelf').show();
				$('#expirationDaysViewSelect').hide();
				$('#expirationDaysCalender').val($('#expirationDaysView').val());
			} else {
				$("#expirationDaysChange").text("달력");
				$('#expirationDaysViewSelf').hide();
				$('#expirationDaysViewSelect').show();
				$('#expirationDaysDay').val($('#expirationDaysView').val());
			}
		}
		
		$('#chkExpirationDays').change(function() {
			if($("#chkExpirationDays").is(":checked")){
				$("#expirationDaysCalender").attr("disabled",true);
				$("#expirationDaysDay").attr("disabled",true);
				$("#expirationDaysView").attr("disabled",true);
			} else {
				$("#expirationDaysCalender").attr("disabled",false);
				$("#expirationDaysDay").attr("disabled",false);
				$("#expirationDaysView").attr("disabled",false);
			}
		});	

		$('#chkAgentCount').change(function() {
			if($("#chkAgentCount").is(":checked")){
				$("#agentCountView").attr("disabled",true);
			} else {
				$("#agentCountView").attr("disabled",false);
			}
		});

		$('#chkAgentLisCountCount').change(function() {
			if($("#chkAgentLisCountCount").is(":checked")){
				$("#agentLisCountCountView").attr("disabled",true);
			} else {
				$("#agentLisCountCountView").attr("disabled",false);
			}
		});
	});
	
	if($('#viewType').val() == "issued") {
		document.getElementById('issueDateView').valueAsDate = new Date();
		document.getElementById('expirationDaysCalender').valueAsDate = new Date();
	}

	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	function existenceCheck() {
		var customerName = $('#customerNameView').val();
		var businessName = $('#businessNameView').val();
		var macAddress = $('#macAddressView').val();
		var issueDate = $('#issueDateView').val();
		var expirationDays = $('#expirationDaysView').val();
		var productVersion = $('#productVersionView').val();
		var licenseFilePath = $('#licenseFilePathView').val();
		var viewType = $('#viewType').val();
		var additionalInformation = $('#additionalInformationView').val();

		if(customerName.includes("\"") || customerNameSelf.includes("\"") || businessName.includes("\"") || businessNameSelf.includes("\"") || additionalInformation.includes("\"") || licenseFilePath.includes("\"") || customerName.includes("/") || customerNameSelf.includes("/") || businessName.includes("/") || businessNameSelf.includes("/") || additionalInformation.includes("/") || licenseFilePath.includes("/") || customerName.includes("\\") || customerNameSelf.includes("\\") || businessName.includes("\\") || businessNameSelf.includes("\\") || additionalInformation.includes("\\") || licenseFilePath.includes("\\")) {
			Swal.fire(
			  '특수 문자 사용 불가!',
			  '특수문자 : \", \/, \\',
			  'error'
			)
			return false;
		}

		if(customerName.charAt(0) === "\-" || customerNameSelf.charAt(0) === "\-" || businessName.charAt(0) === "\-" || businessNameSelf.charAt(0) === "\-" || additionalInformation.charAt(0) === "\-" || licenseFilePath.charAt(0) === "\-") {
			Swal.fire(
			  '사용 불가!',
			  '첫글자 \- 입력이 불가능합니다.',
			  'error'
			)
			return false;
		}
		
		const macAddressRegex = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$|^[0-9A-Fa-f]{12}$/;
        if(!macAddressRegex.test(macAddress)) {
			$('#NotMacAddress').show();	
			return flase;
		}
		
		$('.licenseShow').hide();
		if(customerName == "" && customerNameSelf == "") {
			$('#NotCustomerName').show();
		} else if(businessName == "" && businessNameSelf == "") {
			$('#NotBusinessName').show();
		} else if(macAddress == "") {
			$('#NotMacAddress').show();			
		} else if(productVersion == "") {
			$('#NotProductVersion').show();
		} else if(licenseFilePath == "") {
			$('#NotLicenseFilePath').show();
		} else if(issueDate == "") {
			$('#NotIssueDate').show();
		} else { 
			var postData = $('#modalForm').serializeObject();
			var swalText = "<span style='font-weight: 600;'>라이선스 관리 목록에 유사 데이터가 존재합니다.</span> <br><br>";
			if("${viewType}" == "issued" || "${viewType}" == "issuedback") {
				var urlRoute = "<c:url value='/loggriffin/existenceCheckInsert'/>";
			}
			if("${viewType}" == "update" || "${viewType}" == "updateback") {
				var urlRoute = "<c:url value='/loggriffin/existenceCheckUpdate'/>";
			}
			$.ajax({
				url : urlRoute,				
		        type: 'post',
		        data: postData,
		        async: false,
		        success: function(items) {
					if(items[0] == "NotMacAddress") {
		        		Swal.fire({
							icon: 'error',
							title: 'MAC 주소 확인!',
							text: 'MAC주소가 형식에 어긋납니다.',
						});
					} else if(items.length != 0) {
			        	$.each(items, function (i, item) {
			        		swalText += "일련번호 : "+item+"<br>";
			        	});
			        	Swal.fire({
			  			  title: ' 발급을 계속 진행하시겠습니까?',
			  			  html: swalText,
			  			  icon: 'warning',
			  			  showCancelButton: true,
			  			  confirmButtonColor: '#7066e0',
			  			  cancelButtonColor: '#FF99AB',
			  			  confirmButtonText: 'OK'
				  		}).then((result) => {
				  			if (result.isConfirmed) {
				  				if(viewType == "issued" || viewType == "issuedback") 
				  					BtnInsert();
				  				else if(viewType == "update" || viewType == "updateback")
				  					BtnUpdate();	
				  			}
				  		});
		        	} else {
		        		if(viewType == "issued" || viewType == "issuedback") 
		  					BtnInsert();
		  				else if(viewType == "update" || viewType == "updateback")
		  					BtnUpdate();	
		        	}
				},
				error: function(error) {
					console.log(error);
				}
		    });
		}
	}
	
	/* =========== 라이선스 발급 ========= */
	function BtnInsert() {
		if($("#expirationDaysChange").text() == "Day") {
			var calender = $("#expirationDaysCalender").val();
			$("#expirationDaysView").val(calender);
		} else if($("#expirationDaysChange").text() == "달력") {
			var day = $("#expirationDaysDay").val();
			$("#expirationDaysView").val(day);
		}
		
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/loggriffin/licenseIssuanceConfirm'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'licenseConfirm'); //modal창 호출
		    	},300)
		    },
			error: function(error) {
				console.log(error);
			}
		});
	};
	
	/* =========== 직접입력 <> 선택입력 변경 ========= */
	function selfInputCalendar(data) {
		if(data == "expirationDaysChange") {
			if($("#expirationDaysChange").text() == "달력") {
				$('#expirationDaysViewSelf').show();
				$('#expirationDaysViewSelect').hide();
				$('#expirationDaysView').val('');
				$("#expirationDaysChange").text("Day");
			} else if($("#expirationDaysChange").text() == "Day") {
				$('#expirationDaysViewSelf').hide();
				$('#expirationDaysViewSelect').show();
				$("#expirationDaysChange").text("달력");
			}
		}
	}
	
	function BtnUpdate() {
		if($("#expirationDaysChange").text() == "Day") {
			var calender = $("#expirationDaysCalender").val();
			$("#expirationDaysView").val(calender);
		} else if($("#expirationDaysChange").text() == "달력") {
			var day = $("#expirationDaysDay").val();
			$("#expirationDaysView").val(day);
		}
		
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/loggriffin/licenseUpdateConfirm'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'licenseConfirm'); //modal창 호출
		    	},300)
		    },
			error: function(error) {
				console.log(error);
			}
		});
	}

	$("#customerNameView").change(function() {
		var issueDate = $('#issueDateView').val();
		var businessName = $('#businessNameView').val();
		issueDate = issueDate.replace(/\-/g, '');
		$('#licenseFilePathView').val('license-loggriffin-'+businessName+'-'+'-'+issueDate+".yml");
	});

</script>