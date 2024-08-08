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
				<label class="labelFontSize">추가정보</label>
				<input type="text" id="additionalInformationView" name="additionalInformationView" class="form-control viewForm" value="${license.additionalInformation}">
	   		</div>
	        <div class="pading5Width450">
				<label class="labelFontSize">MAC</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">MAC주소가 형식에 어긋납니다.</span>
				<input type="text" id="macAddressView" name="macAddressView" class="form-control viewForm" value="${license.macAddress}" placeholder="00:1A:2B:3C:4D:5E">
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
				 <div style="width: 100%">
					<input type="date" id="expirationDaysView" name="expirationDaysView" class="form-control viewForm" value="${license.expirationDays}">
				 </div>
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
					<input class="cssCheck" type="checkbox" id="chkAgentLisCount" name="chkAgentLisCount" value="무제한">
				   <label for="chkAgentLisCount"></label><span class="margin17">무제한</span>
			   </div>
				<input type="number" id="agentLisCountView" name="agentLisCountView" class="form-control viewForm" value="0">
		   </div>
			<div class="pading5Width450">
				<label class="labelFontSize">제품명</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotProductName" style="display: none; line-height: initial; float: right; font-size: 11px;">제품명을 입력 바랍니다.</span>
				<input type="text" id="productNameView" name="productNameView" class="form-control viewForm" value="${license.productName}">
		    </div>
			<div class="pading5Width450">
				<label class="labelFontSize">제품 버전</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotProductVersion" style="display: none; line-height: initial; float: right; font-size: 11px;">제품 버전 입력 바랍니다.</span>
				<input type="text" id="productVersionView" name="productVersionView" class="form-control viewForm" value="${license.productVersion}">
		    </div>
			<div class="pading5Width450">
				<label class="labelFontSize">라이선스 파일명</label><label class="colorRed">*</label>
				<span class="colorRed licenseShow" id="NotLicenseFilePath" style="display: none; line-height: initial; float: right;">라이선스 파일명을 입력해주세요.</span>
				<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="licens-고객사명-loggriffin-사업명-발급일.yml">
		   </div>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}">
	        </div>
        </div>
        <input type="hidden" id="logGriffinKeyNum" name="logGriffinKeyNum" value="${license.logGriffinKeyNum}">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
	</form>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" onClick="existenceCheck()">발급</button>
	<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	$(function() {
		var agentCount = "${license.agentCount}";
    
    	if (!agentCount || isNaN(agentCount)) {
    	  	$("#agentCountView").val(0);
    	} else {
    	  	$("#agentCountView").val(agentCount);
    	}

		var agentLisCount = "${license.agentLisCount}";
    
    	if (!agentLisCount || isNaN(agentLisCount)) {
    	  	$("#agentLisCountView").val(0);
    	} else {
    	  	$("#agentLisCountView").val(agentLisCount);
    	}

		var productName = "${license.productName}";
    
    	if (!productName) {
    	  	$("#productNameView").val('LogGRIFFIN');
    	} else {
    	  	$("#productNameView").val(productName);
    	}

		var productVersion = "${license.productVersion}";
    
    	if (!productVersion) {
    	  	$("#productVersionView").val('7.0');
    	} else {
    	  	$("#productVersionView").val(productVersion);
    	}

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

		if($('#viewType').val() != 'issued') {
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-loggriffin-'+businessName+'-'+issueDate+".yml");
		}

		if($('#viewType').val() == 'issued') {
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-loggriffin-'+businessName+'-'+issueDate+".yml");
		}

		$('#chkAgentCount').change(function() {
			if($("#chkAgentCount").is(":checked")){
				$("#agentCountView").attr("disabled",true);
			} else {
				$("#agentCountView").attr("disabled",false);
			}
		});

		$('#chkAgentLisCount').change(function() {
			if($("#chkAgentLisCount").is(":checked")){
				$("#agentLisCountView").attr("disabled",true);
			} else {
				$("#agentLisCountView").attr("disabled",false);
			}
		});

		if($('#viewType').val() == 'update' || $('#viewType').val() == 'issuedback' || $('#viewType').val() == 'updateback') {
			if('${license.expirationDays}' == "" || '${license.expirationDays}' == "무제한") {
				$('#chkExpirationDays').prop("checked",true);
				document.getElementById('expirationDaysView').valueAsDate = new Date();
				$("#expirationDaysView").attr("disabled",true);
			}

			if('${license.agentCount}' == "" || '${license.agentCount}' == "무제한") {
				$('#chkAgentCount').prop("checked",true);
				$("#agentCountView").val(0);
				$("#agentCountView").attr("disabled",true);
			}

			if('${license.agentLisCount}' == "" || '${license.agentLisCount}' == "무제한") {
				$('#chkAgentLisCount').prop("checked",true);
				$("#agentLisCountView").val(0);
				$("#agentLisCountView").attr("disabled",true);
			}
		}

		$('#chkLicenseIssuance').change(function() {
			if($("#chkLicenseIssuance").is(":checked")){
				$("#serialNumberView").css("display","none");
			} else {
				$("#serialNumberView").css("display","block");
			}
		});
	});
	
	if($('#viewType').val() == "issued") {
		document.getElementById('issueDateView').valueAsDate = new Date();
		document.getElementById('expirationDaysView').valueAsDate = new Date();
	}

	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	function existenceCheck() {
		var customerName = $('#customerNameView').val();
		var businessName = $('#businessNameView').val();
		var macAddress = $('#macAddressView').val();
		var issueDate = $('#issueDateView').val();
		var expirationDays = $('#expirationDaysView').val();
		var productName = $('#productNameView').val();
		var productVersion = $('#productVersionView').val();
		var licenseFilePath = $('#licenseFilePathView').val();
		var viewType = $('#viewType').val();
		var additionalInformation = $('#additionalInformationView').val();

		if(customerName.includes("\"") || businessName.includes("\"") || additionalInformation.includes("\"") || licenseFilePath.includes("\"") || customerName.includes("/") || businessName.includes("/") || additionalInformation.includes("/") || licenseFilePath.includes("/") || customerName.includes("\\") || businessName.includes("\\") || additionalInformation.includes("\\") || licenseFilePath.includes("\\")) {
			Swal.fire(
			  '특수 문자 사용 불가!',
			  '특수문자 : \", \/, \\',
			  'error'
			)
			return false;
		}

		if(customerName.charAt(0) === "\-" || businessName.charAt(0) === "\-" || additionalInformation.charAt(0) === "\-" || licenseFilePath.charAt(0) === "\-") {
			Swal.fire(
			  '사용 불가!',
			  '첫글자 \- 입력이 불가능합니다.',
			  'error'
			)
			return false;
		}
		
		const macAddressRegex = /^(00[:-]){5}00$/;
		function validateMacAddress(macAddress) {
		    if(!macAddressRegex.test(macAddress)) {
		        $('#NotMacAddress').show();    
		        return false;
		    }
		}
		
		$('.licenseShow').hide();
		if(customerName == "") {
			$('#NotCustomerName').show();
		} else if(businessName == "") {
			$('#NotBusinessName').show();
		} else if(macAddress == "") {
			$('#NotMacAddress').show();	
		} else if(productName == "") {
			$('#NotProductName').show();		
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
					} else if(items[0] == "NotMacAddress") {
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

	$('#chkExpirationDays').change(function() {
		if($("#chkExpirationDays").is(":checked")){
			$("#expirationDaysView").attr("disabled",true);
		} else {
			$("#expirationDaysView").attr("disabled",false);
		}
	});
	
	/* =========== 라이선스 발급 ========= */
	function BtnInsert() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/loggriffin/licenseIssuanceConfirm'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'logGriffinConfirm'); //modal창 호출
		    	},300)
		    },
			error: function(error) {
				console.log(error);
			}
		});
	};
	
	
	function BtnUpdate() {	
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/loggriffin/licenseUpdateConfirm'/>",
		    type: 'post',
		    data: postData,
		    async: false,
		    success: function (data) {
		    	$('#modal').modal("hide"); // 모달 닫기
		    	setTimeout(function() {
		    		$.modal(data, 'logGriffinConfirm'); //modal창 호출
		    	},300)
		    },
			error: function(error) {
				console.log(error);
			}
		});
	}

	$("#businessNameView").change(function() {
		var issueDate = $('#issueDateView').val();
		var businessName = $('#businessNameView').val();
		issueDate = issueDate.replace(/\-/g, '');
		$('#licenseFilePathView').val('license-loggriffin-'+businessName+'-'+issueDate+".yml");
	});

	$("#issueDateView").change(function() {
		var businessName = $('#businessNameView').val();
		var issueDate = $('#issueDateView').val();
		issueDate = issueDate.replace(/\-/g, '');
		$('#licenseFilePathView').val('license-loggriffin-'+businessName+'-'+issueDate+".yml");
	});

</script>