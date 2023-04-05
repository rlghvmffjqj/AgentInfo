<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 650px;">
	<form id="modalForm" name="form" method ="post">
		<div class="leftDiv">
			<c:choose>
				<c:when test="${viewType eq 'issued'}">
					<div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
					  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="customerNameViewSelf">
						  	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${customerName}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
						<span class="colorRed fontSize10 licenseShow" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
					  		<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="businessNameViewSelf">
						  	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
						  		<option value=""></option>
							</select>
						</div>
						<span class="colorRed fontSize10 licenseShow" id="NotBusinessName" style="display: none; line-height: initial;">사업명을 입력해주세요.</span>
					 </div>
	         	</c:when>
	         	<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
	         		<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
					  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="customerNameViewSelf">
				         	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.customerName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.customerName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${customerName}">
									<option value="${item}" <c:if test="${item eq packages.customerName}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
						<span class="colorRed fontSize10 licenseShow" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
			         </div>
			         <div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">사업명</label>
					  		<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="businessNameViewSelf">
				         	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.businessName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.businessName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${businessName}">
									<option value="${item}" <c:if test="${item eq packages.businessName}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
	         	</c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">추가정보</label>
	         	<input type="text" id="additionalInformationView" name="additionalInformationView" class="form-control viewForm" value="${license.additionalInformation}" max="9999-12-31">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'issued'}">
			         <div class="pading5Width450">
			         	<label class="labelFontSize">제품유형</label><label class="colorRed">*</label>
			         	<select class="form-control selectpicker selectForm" id="productTypeView" name="productTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="mGRIFFIN">mGRIFFIN</option>
							<option value="iGRIFFIN" selected>iGRIFFIN</option>
							<option value="TOS">TOS</option>
							<option value="TOSSuite">TOSSuite</option>
						</select>
			         </div>
		         </c:when>
		         <c:when test="${viewType eq 'copy'}">
		         	<div class="pading5Width450">
			         	<label class="labelFontSize">제품유형</label><label class="colorRed">*</label>
			         	<select class="form-control selectpicker selectForm" id="productTypeView" name="productTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="mGRIFFIN" <c:if test="${'mGRIFFIN' eq license.productType}">selected</c:if>>mGRIFFIN</option>
							<option value="iGRIFFIN" <c:if test="${'iGRIFFIN' eq license.productType}">selected</c:if>>iGRIFFIN</option>
							<option value="TOS" <c:if test="${'TOS' eq license.productType}">selected</c:if>>TOS</option>
							<option value="TOSSuite" <c:if test="${'TOSSuite' eq license.productType}">selected</c:if>>TOSSuite</option>
						</select>
			         </div>
		         </c:when>
	         </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">MAC주소</label><label class="colorRed">*</label>
	         	<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right;">MAC주소를 입력해주세요.</span>
	         	<input type="text" id="macAddressView" name="macAddressView" class="form-control viewForm" value="${license.macAddress}">
	         </div>
	          <div class="pading5Width450">
	         	<label class="labelFontSize">시작일</label><label class="colorRed">*</label>
	         	<input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm" value="${license.issueDate}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">만료일</label><label class="colorRed">*</label>
	         	<div class="floatRight">
	         		<input class="cssCheck" type="checkbox" id="chkExpirationDays" name="chkExpirationDays" value="전체">
    				<label for="chkExpirationDays"></label><span class="margin17">전체</span>
    			</div>
    			<a href="#" class="selfInput" style="margin-right: 2%;" id="expirationDaysChange" onclick="selfInput('expirationDaysChange');">달력</a>
	         	<div id="expirationDaysViewSelf" style="display:none; width: 100%">
	         		<input type="date" id="expirationDaysView" name="expirationDaysView" class="form-control viewForm expirationDays" value="${license.expirationDays}">
	         	</div>
	         	<div id="expirationDaysViewSelect">
		         	<input type="number" id="expirationDaysView" name="expirationDaysView" class="form-control viewForm expirationDays" value="90">
				</div>
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'issued'}">
			         <div class="pading5Width450">
			         	<label class="labelFontSize">iGRIFFIN Agent 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkIGRIFFINAgentCount" name="chkIGRIFFINAgentCount" value="전체">
		    				<label for="chkIGRIFFINAgentCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="iGRIFFINAgentCountView" name="iGRIFFINAgentCountView" class="form-control viewForm" value="1">
			         </div>
			         <div class="pading5Width450">
			         	<label class="labelFontSize">TOS 5.0 Agent 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos5AgentCount" name="chkTos5AgentCount" value="전체">
		    				<label for="chkTos5AgentCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="tos5AgentCountView" name="tos5AgentCountView" class="form-control viewForm" value="1">
					 </div>
				</c:when>
		        <c:when test="${viewType eq 'copy'}">
		         	<div class="pading5Width450">
			         	<label class="labelFontSize">iGRIFFIN Agent 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkIGRIFFINAgentCount" name="chkIGRIFFINAgentCount" value="전체">
		    				<label for="chkIGRIFFINAgentCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="iGRIFFINAgentCountView" name="iGRIFFINAgentCountView" class="form-control viewForm" value="${license.iGRIFFINAgentCount}">
			         </div>
			         <div class="pading5Width450">
			         	<label class="labelFontSize">TOS 5.0 Agent 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos5AgentCount" name="chkTos5AgentCount" value="전체">
		    				<label for="chkTos5AgentCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="tos5AgentCountView" name="tos5AgentCountView" class="form-control viewForm" value="${license.tos5AgentCount}">
					 </div>
				</c:when>
	         </c:choose>
	    </div>
        <div class="rightDiv">
        	<c:choose>
				<c:when test="${viewType eq 'issued'}">
		        	<div class="pading5Width450">
			         	<label class="labelFontSize">TOS 2.0 Agent 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos2AgentCount" name="chkTos2AgentCount" value="전체">
		    				<label for="chkTos2AgentCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="tos2AgentCountView" name="tos2AgentCountView" class="form-control viewForm" value="1">
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">DBMS 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkDbmsCount" name="chkDbmsCount" value="전체">
		    				<label for="chkDbmsCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="dbmsCountView" name="dbmsCountView" class="form-control viewForm" value="1">
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">Network 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkNetworkCount" name="chkNetworkCount" value="전체">
		    				<label for="chkNetworkCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="networkCountView" name="networkCountView" class="form-control viewForm" value="1">
					</div>
				    <div class="pading5Width450">
						<label class="labelFontSize">관리서버 OS</label><label class="colorRed">*</label>
						<span class="colorRed licenseShow" id="NotOsType" style="display: none; line-height: initial; float: right;">관리서버 OS를 선택해주세요.</span>
						<select class="form-control selectpicker" id="managerOsTypeView" name="managerOsTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="Linux" selected>Linux</option>
							<option value="Windows">Windows</option>
							<option value="AIX">AIX</option>
							<option value="HP-UX">HP-UX</option>
							<option value="Solaris">Solaris</option>
						</select>
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">관리서버 DBMS</label><label class="colorRed">*</label>
			         	<select class="form-control selectpicker" id="managerDbmsTypeView" name="managerDbmsTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="Oracle">Oracle</option>
							<option value="Tibero" selected>Tibero</option>
							<option value="MSSQL">MSSQL</option>
							<option value="MySQL">MySQL</option>
							<option value="MariaDB">MariaDB</option>
						</select>
			        </div>
			        <div class="pading5Width450">
			        	<label class="labelFontSize">국가</label><label class="colorRed">*</label>
			        	<select class="form-control selectpicker" id="countryView" name="countryView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="KR" selected>KR</option>
							<option value="JP">JP</option>
							<option value="US">US</option>
							<option value="CN">CN</option>
						</select>
					</div>
					<div class="pading5Width450">
						<label class="labelFontSize">제품버전</label><label class="colorRed">*</label>
						<span class="colorRed licenseShow" id="NotProductVersion" style="display: none; line-height: initial; float: right;">제품 버전을 입력해주세요.</span>
						<input type="text" id="productVersionView" name="productVersionView" class="form-control viewForm" value="5.0.20">
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">라이센스 파일명</label><label class="colorRed">*</label>
			         	<span class="colorRed licenseShow" id="NotLicenseFilePath" style="display: none; line-height: initial; float: right;">라이센스 파일명을 입력해주세요.</span>
			         	<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="licens-고객사명-사업명-날짜.xml">
			        </div>
	       		</c:when>
		        <c:when test="${viewType eq 'copy'}">
		        	<div class="pading5Width450">
			         	<label class="labelFontSize">TOS 2.0 Agent 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos2AgentCount" name="chkTos2AgentCount" value="전체">
		    				<label for="chkTos2AgentCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="tos2AgentCountView" name="tos2AgentCountView" class="form-control viewForm" value="${license.tos2AgentCount}">
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">DBMS 개수</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkDbmsCount" name="chkDbmsCount" value="전체">
		    				<label for="chkDbmsCount"></label><span class="margin17">전체</span>
		    			</div>
			         	<input type="number" id="dbmsCountView" name="dbmsCountView" class="form-control viewForm" value="${license.dbmsCount}">
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">Network 개수</label><label class="colorRed">*</label>
			         	<input type="number" id="networkCountView" name="networkCountView" class="form-control viewForm" value="${license.networkCount}">
					</div>
					<div class="pading5Width450">
						<label class="labelFontSize">관리서버 OS</label><label class="colorRed">*</label>
						<span class="colorRed licenseShow" id="NotOsType" style="display: none; line-height: initial; float: right;">관리서버 OS를 선택해주세요.</span>
						<select class="form-control selectpicker" id="managerOsTypeView" name="managerOsTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="Linux" <c:if test="${'Linux' eq license.managerOsType}">selected</c:if>>Linux</option>
							<option value="Windows" <c:if test="${'Windows' eq license.managerOsType}">selected</c:if>>Windows</option>
							<option value="AIX" <c:if test="${'AIX' eq license.managerOsType}">selected</c:if>>AIX</option>
							<option value="HP-UX" <c:if test="${'HP-UX' eq license.managerOsType}">selected</c:if>>HP-UX</option>
							<option value="Solaris" <c:if test="${'Solaris' eq license.managerOsType}">selected</c:if>>Solaris</option>
						</select>
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">관리서버 DBMS</label><label class="colorRed">*</label>
			         	<select class="form-control selectpicker" id="managerDbmsTypeView" name="managerDbmsTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="Oracle" <c:if test="${'Oracle' eq license.managerDbmsType}">selected</c:if>>Oracle</option>
							<option value="Tibero" <c:if test="${'Tibero' eq license.managerDbmsType}">selected</c:if>>Tibero</option>
							<option value="MSSQL" <c:if test="${'MSSQL' eq license.managerDbmsType}">selected</c:if>>MSSQL</option>
							<option value="MySQL" <c:if test="${'MySQL' eq license.managerDbmsType}">selected</c:if>>MySQL</option>
							<option value="MariaDB" <c:if test="${'MariaDB' eq license.managerDbmsType}">selected</c:if>>MariaDB</option>
						</select>
			        </div>
			        <div class="pading5Width450">
			        	<label class="labelFontSize">국가</label><label class="colorRed">*</label>
			        	<select class="form-control selectpicker" id="countryView" name="countryView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="KR" <c:if test="${'KR' eq license.country}">selected</c:if>>KR</option>
							<option value="JP" <c:if test="${'JP' eq license.country}">selected</c:if>>JP</option>
							<option value="US" <c:if test="${'US' eq license.country}">selected</c:if>>US</option>
							<option value="CN" <c:if test="${'CN' eq license.country}">selected</c:if>>CN</option>
						</select>
					</div>
					<div class="pading5Width450">
						<label class="labelFontSize">제품버전</label><label class="colorRed">*</label>
						<span class="colorRed licenseShow" id="NotProductVersion" style="display: none; line-height: initial; float: right;">제품 버전을 입력해주세요.</span>
						<input type="text" id="productVersionView" name="productVersionView" class="form-control viewForm" value="${license.productVersion}">
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">라이센스 파일명</label><label class="colorRed">*</label>
			         	<span class="colorRed licenseShow" id="NotLicenseFilePath" style="display: none; line-height: initial; float: right;">라이센스 파일명을 입력해주세요.</span>
			         	<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="${license.licenseFilePath}">
			        </div>
		        </c:when>
	        </c:choose>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}">
	        </div>
        </div>
        <input type="hidden" id="licenseKeyNum" name="licenseKeyNum" value="${license.licenseKeyNum}">
        <input type="hidden" id="btnType" name="btnType">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'issued'}">
			<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert('issued')">발급</button>
			<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
		</c:when>
		<c:when test="${viewType eq 'copy'}">
			<button class="btn btn-default btn-outline-info-add" onClick="BtnInsert('copy')">발급</button>
			<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
		</c:when>
    </c:choose>
</div>

<script>
	$(function() {
		if($('#viewType').val() == 'issued') {
			var customerName = $('#customerNameView').val();
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
		}
		
		$("#customerNameView").change(function() {
			var customerName = $('#customerNameView').val();
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
		});
		
		$("#businessNameView").change(function() {
			var customerName = $('#customerNameView').val();
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
		});
		
		$("#issueDateView").change(function() {
			var customerName = $('#customerNameView').val();
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			issueDate = issueDate.replace(/\-/g, '');
			$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
		});
		
		$('#chkExpirationDays').change(function() {
			if($("#chkExpirationDays").is(":checked")){
				$(".expirationDays").attr("disabled",true);
			} else {
				$(".expirationDays").attr("disabled",false);
			}
		});
		
		$('#chkIGRIFFINAgentCount').change(function() {
			if($("#chkIGRIFFINAgentCount").is(":checked")){
				$("#iGRIFFINAgentCountView").attr("disabled",true);
			} else {
				$("#iGRIFFINAgentCountView").attr("disabled",false);
			}
		});
		
		$('#chkTos5AgentCount').change(function() {
			if($("#chkTos5AgentCount").is(":checked")){
				$("#tos5AgentCountView").attr("disabled",true);
			} else {
				$("#tos5AgentCountView").attr("disabled",false);
			}
		});
		
		$('#chkTos2AgentCount').change(function() {
			if($("#chkTos2AgentCount").is(":checked")){
				$("#tos2AgentCountView").attr("disabled",true);
			} else {
				$("#tos2AgentCountView").attr("disabled",false);
			}
		});
		
		$('#chkDbmsCount').change(function() {
			if($("#chkDbmsCount").is(":checked")){
				$("#dbmsCountView").attr("disabled",true);
			} else {
				$("#dbmsCountView").attr("disabled",false);
			}
		});
		
		$('#chkNetworkCount').change(function() {
			if($("#chkNetworkCount").is(":checked")){
				$("#networkCountView").attr("disabled",true);
			} else {
				$("#networkCountView").attr("disabled",false);
			}
		});
		
		chkNetworkCount
		
	});
	
	if($('#viewType').val() == "issued") {
		document.getElementById('issueDateView').valueAsDate = new Date();
	}

	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 라이센스 발급 ========= */
	function BtnInsert(btnType) {
		$('#btnType').val(btnType);
		var customerName = $('#customerNameView').val();
		var businessName = $('#businessNameView').val();
		var macAddress = $('#macAddressView').val();
		var expirationDays = $('#expirationDaysView').val();
		var productVersion = $('#productVersionView').val();
		var licenseFilePath = $('#licenseFilePathView').val();
		
		$('.licenseShow').hide();
		if(customerName == "") {
			$('#NotCustomerName').show();
		} else if(businessName == "") {
			$('#NotBusinessName').show();
		} else if(macAddress == "") {
			$('#NotMacAddress').show();			
		} else if(productVersion == "") {
			$('#NotProductVersion').show();
		} else if(licenseFilePath == "") {
			$('#NotLicenseFilePath').show();
		} else { 
			if($("#expirationDaysChange").text() == "선택입력" && $('#expirationDaysYearSelf').val() <= 0 && $('#expirationDaysMonthSelf').val() <= 0 && $('#expirationDaysDaySelf').val() <= 0) {
				Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '직접 입력의 경우 1일 이상의 값을 입력 바랍니다.',    
				});
			} else {
				var postData = $('#modalForm').serializeObject();
				$.ajax({
					url: "<c:url value='/license5/linuxIssued50'/>",
				    type: 'post',
				    data: postData,
				    async: false,
				    success: function(result) {
						if(result.result == "FALSE") {
							Swal.fire({
								icon: 'error',
								title: '실패!',
								text: '라이센스 발급에 실패하였습니다.',
							});
						} else if(result.result == "NotRoute") {
							Swal.fire({
								icon: 'error',
								title: '경로 설정!',
								text: '경로 설정 후 라이센스 발급 바랍니다.',
							});
						} else if(result.result == "NOTCONNECT") {
				        		Swal.fire({
									icon: 'error',
									title: '연결 실패!',
									text: '서버 연결에 실패하였습니다.',
								});
						} else {
							Swal.fire({
								icon: 'success',
								title: '라이센스 발급!',
								text: result.result,
							});
							$('#modal').modal("hide"); // 모달 닫기
				    		$('#modal').on('hidden.bs.modal', function () {
				    			tableRefresh();
				    		});
						}
					},
					error: function(error) {
						console.log(error);
					}
				});
			}
		}
	};
	
	/* =========== 직접입력 <--> 선택입력 변경 ========= */
	function selfInput(data) {
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
		} else if (data == "customerNameChange") {
			if($('#customerNameChange').text() == "직접입력") {
				$('#customerNameViewSelf').hide();
				$('#customerNameSelf').attr('type','text');
				$('#customerNameView').val('');	
				$("#customerNameChange").text("선택입력");
			} else if($('#customerNameChange').text() == "선택입력") {
				$('#customerNameViewSelf').show();
				$('#customerNameSelf').attr('type','hidden');
				$('#customerNameSelf').val('');	
				$("#customerNameChange").text("직접입력");
			}
		} else if (data == "businessNameChange") {
			if($('#businessNameChange').text() == "직접입력") {
				$('#businessNameViewSelf').hide();
				$('#businessNameSelf').attr('type','text');
				$('#businessNameView').val('');	
				$("#businessNameChange").text("선택입력");
			} else if($('#businessNameChange').text() == "선택입력") {
				$('#businessNameViewSelf').show();
				$('#businessNameSelf').attr('type','hidden');
				$('#businessNameSelf').val('');	
				$("#businessNameChange").text("직접입력");
			}
		}
	}
	
	/* =========== 고객사명 Select Box 선택 ========= */
	$("#customerNameView").change(function() {
		$("#businessNameView").empty();
		$("#businessNameView").selectpicker("refresh");
		var customerName = $('#customerNameView').val();
		$.ajax({
			url: "<c:url value='/category/customerBusinessName'/>",
	        type: 'post',
	        data: {'customerName':customerName},
	        async: false,
	        success: function(items) {
	        	$("#businessNameView").append('<option value=""></option>');
	        	$.each(items, function (i, item) {
	        		$("#businessNameView").append('<option value="'+item+'">'+item+'</option>');
	        		$("#businessNameView").selectpicker("refresh");
	        	});
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});
</script>