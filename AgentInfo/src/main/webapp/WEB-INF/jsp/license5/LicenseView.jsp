<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal-body" id="licenseModal" style="width: 100%; height: 820px;">
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
			<div class="newLicense scribePeriod">
				<c:choose>
					<c:when test="${viewType eq 'issued'}">
						<div class="pading5Width450">
						 	<div>
						  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
								<span class="colorRed fontSize10 licenseShow" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 선택해주세요.</span>
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
						 </div>
						 <div class="pading5Width450">
						 	<div>
						  		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
								<span class="colorRed fontSize10 licenseShow" id="NotBusinessName" style="display: none; line-height: initial;">사업명을 선택해주세요.</span>
						  		<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
						  	</div>
						  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
						  	<div id="businessNameViewSelf">
							  	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
							  		<option value=""></option>
								</select>
							</div>
						 </div>
	        	 	</c:when>
	        	 	<c:when test="${viewType eq 'update' || viewType eq 'issuedback' || viewType eq 'updateback'}">
	        	 		<div class="pading5Width450">
							<div>
						  		<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
								<span class="colorRed fontSize10 licenseShow" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 선택해주세요.</span>
						  		<a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a>
						  	</div>
						  	<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
						  	<div id="customerNameViewSelf">
					         	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
					         		<c:if test="${license.customerName ne ''}"><option value=""></option></c:if>
					         		<c:if test="${license.customerName eq ''}"><option value=""></option></c:if>
					         		<c:forEach var="item" items="${customerName}">
										<option value="${item}" <c:if test="${item eq license.customerName}">selected</c:if>><c:out value="${item}"/></option>
									</c:forEach>
								</select>
							</div>
				         </div>
				         <div class="pading5Width450">
							<div>
						  		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
								<span class="colorRed fontSize10 licenseShow" id="NotBusinessName" style="display: none; line-height: initial;">사업명을 선택해주세요.</span>
						  		<a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a>
						  	</div>
						  	<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
						  	<div id="businessNameViewSelf">
					         	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
					         		<c:if test="${license.businessName ne ''}"><option value=""></option></c:if>
					         		<c:if test="${license.businessName eq ''}"><option value=""></option></c:if>
					         		<c:forEach var="item" items="${businessName}">
										<option value="${item}" <c:if test="${item eq license.businessName}">selected</c:if>><c:out value="${item}"/></option>
									</c:forEach>
								</select>
							</div>
				         </div>
	        	 	</c:when>
				</c:choose>
			</div>
			<div class="oldLicense">
				<div class="pading5Width450">
					<div>
						<label class="labelFontSize">고객사명</label><label class="colorRed" style="font-size: 12px;">* (구) 버전 라이선스는 영문만 입력 가능합니다.</label>
					    <span class="colorRed fontSize10 licenseShow" id="NotCustomerNameOld" style="display: none; line-height: initial; float: right;">고객사명을 입력해주세요.</span>
					</div>
					<input type="text" id="customerNameOldView" name="customerNameOldView" class="form-control viewForm" value="${license.customerName}">
				</div>
				<div class="pading5Width450">
					<div>
						<label class="labelFontSize">사업명</label>
					</div>
					<input type="text" id="businessNameOldView" name="businessNameOldView" class="form-control viewForm" value="${license.businessName}">
				</div>
			</div>
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
							<option value="iGRIFFIN">iGRIFFIN</option>
							<option value="TOS" selected>TOS</option>
							<option value="TOSSuite">TOSSuite</option>
						</select>
			         </div>
		         </c:when>
		         <c:when test="${viewType eq 'update' || viewType eq 'issuedback' || viewType eq 'updateback'}">
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
	         	<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">MAC주소를 입력해주세요</span>
	         	<input type="text" id="macAddressView" name="macAddressView" class="form-control viewForm" value="${license.macAddress}" placeholder="00:1A:2B:3C:4D:5E">
	        </div>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">시작일</label><label class="colorRed">*</label>
				 <span class="colorRed licenseShow" id="NotIssueDate" style="display: none; line-height: initial; float: right; font-size: 11px;">시작일을 입력해주세요.</span>
	         	<input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm" value="${license.issueDate}">
	        </div>
	        <c:choose>
				<c:when test="${viewType eq 'issued'}">
					<div class="pading5Width450">
			         	<label class="labelFontSize">만료일</label><label class="colorRed">*</label>
			         	<div class="floatRight oldLicense newLicense">
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
			         	<label class="labelFontSize">iGRIFFIN Agent 수량</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkIGRIFFINAgentCount" name="chkIGRIFFINAgentCount" value="무제한">
		    				<label for="chkIGRIFFINAgentCount"></label><span class="margin17">무제한</span>
		    			</div>
			         	<input type="number" id="igriffinAgentCountView" name="igriffinAgentCountView" class="form-control viewForm" value="0">
			         </div>
			         <div class="pading5Width450">
			         	<label class="labelFontSize">TOS 5.0 Agent 수량</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos5AgentCount" name="chkTos5AgentCount" value="무제한">
		    				<label for="chkTos5AgentCount"></label><span class="margin17">무제한</span>
		    			</div>
			         	<input type="number" id="tos5AgentCountView" name="tos5AgentCountView" class="form-control viewForm" value="0">
					 </div>
					 <div class="pading5Width450">
			         	<label class="labelFontSize">TOS 2.0 Agent 수량</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos2AgentCount" name="chkTos2AgentCount" value="무제한">
		    				<label for="chkTos2AgentCount"></label><span class="margin17">무제한</span>
		    			</div>
			         	<input type="number" id="tos2AgentCountView" name="tos2AgentCountView" class="form-control viewForm" value="0">
					</div>
					<div class="newLicense scribePeriod">
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Network 수량</label><label class="colorRed">*</label>
			        	 	<div class="floatRight">
			        	 		<input class="cssCheck" type="checkbox" id="chkNetworkCount" name="chkNetworkCount" value="무제한">
		    					<label for="chkNetworkCount"></label><span class="margin17">무제한</span>
		    				</div>
			        	 	<input type="number" id="networkCountView" name="networkCountView" class="form-control viewForm" value="0">
						</div>
					</div>
					<div class="pading5Width450">
						<label class="labelFontSize">DBMS 수량</label><label class="colorRed">*</label>
						<div class="floatRight">
							<input class="cssCheck" type="checkbox" id="chkDbmsCount" name="chkDbmsCount" value="무제한">
						   <label for="chkDbmsCount"></label><span class="margin17">무제한</span>
					   </div>
						<input type="number" id="dbmsCountView" name="dbmsCountView" class="form-control viewForm" value="0">
				    </div>
				</c:when>
		        <c:when test="${viewType eq 'update' || viewType eq 'issuedback' || viewType eq 'updateback'}">
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
			         	<label class="labelFontSize">iGRIFFIN Agent 수량</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkIGRIFFINAgentCount" name="chkIGRIFFINAgentCount" value="무제한">
		    				<label for="chkIGRIFFINAgentCount"></label><span class="margin17">무제한</span>
		    			</div>
			         	<input type="number" id="igriffinAgentCountView" name="igriffinAgentCountView" class="form-control viewForm" value="${license.igriffinAgentCount}">
			         </div>
			         <div class="pading5Width450">
			         	<label class="labelFontSize">TOS 5.0 Agent 수량</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos5AgentCount" name="chkTos5AgentCount" value="무제한">
		    				<label for="chkTos5AgentCount"></label><span class="margin17">무제한</span>
		    			</div>
			         	<input type="number" id="tos5AgentCountView" name="tos5AgentCountView" class="form-control viewForm" value="${license.tos5AgentCount}">
					 </div>
					 <div class="pading5Width450">
			         	<label class="labelFontSize">TOS 2.0 Agent 수량</label><label class="colorRed">*</label>
			         	<div class="floatRight">
			         		<input class="cssCheck" type="checkbox" id="chkTos2AgentCount" name="chkTos2AgentCount" value="무제한">
		    				<label for="chkTos2AgentCount"></label><span class="margin17">무제한</span>
		    			</div>
			         	<input type="number" id="tos2AgentCountView" name="tos2AgentCountView" class="form-control viewForm" value="${license.tos2AgentCount}">
					</div>
					<div class="newLicense scribePeriod">
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Network 수량</label><label class="colorRed">*</label>
			        	 	<div class="floatRight">
			        	 		<input class="cssCheck" type="checkbox" id="chkNetworkCount" name="chkNetworkCount" value="무제한">
		    					<label for="chkNetworkCount"></label><span class="margin17">무제한</span>
		    				</div>
			        	 	<input type="number" id="networkCountView" name="networkCountView" class="form-control viewForm" value="${license.networkCount}">
						</div>
					</div>
					<div class="pading5Width450">
						<label class="labelFontSize">DBMS 수량</label><label class="colorRed">*</label>
						<div class="floatRight">
							<input class="cssCheck" type="checkbox" id="chkDbmsCount" name="chkDbmsCount" value="무제한">
						   <label for="chkDbmsCount"></label><span class="margin17">무제한</span>
					   </div>
						<input type="number" id="dbmsCountView" name="dbmsCountView" class="form-control viewForm" value="${license.dbmsCount}">
				   </div>
				</c:when>
	        </c:choose>
	    </div>
        <div class="rightDiv">
        	<c:choose>
				<c:when test="${viewType eq 'issued'}">
					<div class="newLicense scribePeriod">
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">AIX(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="aixCountView" name="aixCountView" class="form-control viewForm" value="0">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">HPUX(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="hpuxCountView" name="hpuxCountView" class="form-control viewForm" value="0">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Solaris(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="solarisCountView" name="solarisCountView" class="form-control viewForm" value="0">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Linux(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="linuxCountView" name="linuxCountView" class="form-control viewForm" value="0">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Windows(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="windowsCountView" name="windowsCountView" class="form-control viewForm" value="0">
						</div>
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
						<select class="form-control selectpicker" id="productVersionView" name="productVersionView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="5.0.21">5.0.21</option>
							<option value="5.0.20" selected>5.0.20</option>
							<option value="5.0.19">5.0.19</option>
						</select>
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">라이선스 파일명</label><label class="colorRed">*</label>
			         	<span class="colorRed licenseShow" id="NotLicenseFilePath" style="display: none; line-height: initial; float: right;">라이선스 파일명을 입력해주세요.</span>
			         	<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="licens-고객사명-사업명-날짜.xml" readonly>
			        </div>
	       		</c:when>
		        <c:when test="${viewType eq 'update' || viewType eq 'issuedback' || viewType eq 'updateback'}">
					<div class="newLicense scribePeriod">
		        		<div class="pading5Width450">
			        	 	<label class="labelFontSize">AIX(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="aixCountView" name="aixCountView" class="form-control viewForm" value="${license.aixCount}">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">HPUX(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="hpuxCountView" name="hpuxCountView" class="form-control viewForm" value="${license.hpuxCount}">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Solaris(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="solarisCountView" name="solarisCountView" class="form-control viewForm" value="${license.solarisCount}">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Linux(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="linuxCountView" name="linuxCountView" class="form-control viewForm" value="${license.linuxCount}">
						</div>
						<div class="pading5Width450">
			        	 	<label class="labelFontSize">Windows(OS) 수량</label><label class="colorRed">*</label>
			        	 	<input type="number" id="windowsCountView" name="windowsCountView" class="form-control viewForm" value="${license.windowsCount}">
						</div>
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
						<select class="form-control selectpicker" id="productVersionView" name="productVersionView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="5.0.21" <c:if test="${'5.0.21' eq license.productVersion}">selected</c:if>>5.0.21</option>
							<option value="5.0.20" <c:if test="${'5.0.20' eq license.productVersion}">selected</c:if>>5.0.20</option>
							<option value="5.0.19" <c:if test="${'5.0.19' eq license.productVersion}">selected</c:if>>5.0.19</option>
						</select>
					</div>
					<div class="pading5Width450">
			         	<label class="labelFontSize">라이선스 파일명</label><label class="colorRed">*</label>
			         	<span class="colorRed licenseShow" id="NotLicenseFilePath" style="display: none; line-height: initial; float: right;">라이선스 파일명을 입력해주세요.</span>
			         	<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="${license.licenseFilePath}" readonly>
			        </div>
		        </c:when>
	        </c:choose>
	        <div class="pading5Width450">
	         	<label class="labelFontSize">요청자</label>
	         	<!-- <input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}"> -->
				<input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}" style="width: 90%;">
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
        <input type="hidden" id="licenseKeyNum" name="licenseKeyNum" value="${license.licenseKeyNum}">
        <input type="hidden" id="viewType" name="viewType" value="${viewType}">
        <input type="hidden" id="expirationDaysView" name="expirationDaysView" value="${license.expirationDays}">
		<input type="hidden" id="licenseTypeView" name="licenseTypeView" value="${license.licenseType}">
	</form>
</div>
<div class="modal-footer">
	<div class="newLicense">
		<button class="btn btn-default btn-outline-info-add" onClick="existenceCheck()">발급</button>
		<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
	</div>
	<div class="oldLicense">
		<button class="btn btn-default btn-outline-info-add" onClick="oldExistenceCheck()">발급</button>
		<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
	</div>
	<div class="scribePeriod">
		<button class="btn btn-default btn-outline-info-add" onClick="existenceCheck()">발급</button>
		<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
	</div>
	<div class="scribeMetering">
		<button class="btn btn-default btn-outline-info-add" onClick="meteringExistenceCheck()">발급</button>
		<button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
	</div>
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

		if('${license.licenseType}' == '(구)' || '${license.licenseTypeView}' == '(구)') {
			btnOldLicense();
		} else 	if('${license.licenseType}' == '(신)' || '${license.licenseTypeView}' == '(신)') {
			btnNewLicense();
		} else if('${license.licenseType}' == '구독(기간)' || '${license.licenseTypeView}' == '구독(기간)') {
			btnScribePeriod();
		} else if('${license.licenseType}' == '구독(미터링)' || '${license.licenseTypeView}' == '구독(미터링)') {
			btnScribeMetering();
		}

		if($('#viewType').val() == 'issued') {
			var customerName = $('#customerNameView').val();
			var businessName = $('#businessNameView').val();
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			if('${license.licenseType}' == '(구)') {
				$('#licenseFilePathView').val('license-'+customerName+'-'+issueDate+".xml");
			} else if('${license.licenseType}' == '(신)') {
				if(additionalInformation == "") {
					$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
				} else {
					$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
				}
				
			} else if('${license.licenseType}' == '구독(기간)') {
				if(additionalInformation == "") {
					$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
				} else {
					$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
				}
			} else if('${license.licenseType}' == '구독(미터링)') {
				// 개발 예정
			}
		}
		
		if($('#viewType').val() == 'update' || $('#viewType').val() == 'issuedback' || $('#viewType').val() == 'updateback') {
			if($('#expirationDaysView').val() == "무제한" || $('#expirationDaysView').val() == "") {
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
			
			if($('#igriffinAgentCountView').val() == "") {
				$('#chkIGRIFFINAgentCount').prop("checked",true);
				$("#igriffinAgentCountView").val(0);
				$("#igriffinAgentCountView").attr("disabled",true);
			}
			
			if($('#tos5AgentCountView').val() == "") {
				$('#chkTos5AgentCount').prop("checked",true);
				$("#tos5AgentCountView").val(0);
				$("#tos5AgentCountView").attr("disabled",true);
			}
			
			if($('#tos2AgentCountView').val() == "") {
				$('#chkTos2AgentCount').prop("checked",true);
				$("#tos2AgentCountView").val(0);
				$("#tos2AgentCountView").attr("disabled",true);
			}
			
			if($('#dbmsCountView').val() == "") {
				$('#chkDbmsCount').prop("checked",true);
				$("#dbmsCountView").val(0);
				$("#dbmsCountView").attr("disabled",true);
			}
			
			if($('#networkCountView').val() == "") {
				$('#chkNetworkCount').prop("checked",true);
				$("#networkCountView").val(0);
				$("#networkCountView").attr("disabled",true);
			}
		}
		
		$("#customerNameView").change(function() {
			if($('#customerNameChange').text() == "직접입력") {
				var customerName = $('#customerNameView').val();
			} else if($('#customerNameChange').text() == "선택입력") {
				var customerName = $('#customerNameSelf').val();
			}

			if($('#businessNameChange').text() == "직접입력") {
				var businessName = $('#businessNameView').val();
			} else if($('#businessNameChange').text() == "선택입력") {
				var businessName = $('#businessNameSelf').val();
			}
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			if(additionalInformation == "") {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
			} else {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
			}
		});

		$("#customerNameSelf").change(function() {
			if($('#customerNameChange').text() == "직접입력") {
				var customerName = $('#customerNameView').val();
			} else if($('#customerNameChange').text() == "선택입력") {
				var customerName = $('#customerNameSelf').val();
			}

			if($('#businessNameChange').text() == "직접입력") {
				var businessName = $('#businessNameView').val();
			} else if($('#businessNameChange').text() == "선택입력") {
				var businessName = $('#businessNameSelf').val();
			}
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			if(additionalInformation == "") {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
			} else {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
			}
		});

		$("#additionalInformationView").change(function() {
			if($('#customerNameChange').text() == "직접입력") {
				var customerName = $('#customerNameView').val();
			} else if($('#customerNameChange').text() == "선택입력") {
				var customerName = $('#customerNameSelf').val();
			}

			if($('#businessNameChange').text() == "직접입력") {
				var businessName = $('#businessNameView').val();
			} else if($('#businessNameChange').text() == "선택입력") {
				var businessName = $('#businessNameSelf').val();
			}
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			var activeId = $('.customerManagentActive').attr('id');
			if(activeId == "btnNewLicense") {
				if(additionalInformation == "") {
					$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
				} else {
					$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
				}
			}
		});
		
		$("#businessNameView").change(function() {
			if($('#customerNameChange').text() == "직접입력") {
				var customerName = $('#customerNameView').val();
			} else if($('#customerNameChange').text() == "선택입력") {
				var customerName = $('#customerNameSelf').val();
			}

			if($('#businessNameChange').text() == "직접입력") {
				var businessName = $('#businessNameView').val();
			} else if($('#businessNameChange').text() == "선택입력") {
				var businessName = $('#businessNameSelf').val();
			}
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			if(additionalInformation == "") {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
			} else {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
			}
		});

		$("#businessNameSelf").change(function() {
			if($('#customerNameChange').text() == "직접입력") {
				var customerName = $('#customerNameView').val();
			} else if($('#customerNameChange').text() == "선택입력") {
				var customerName = $('#customerNameSelf').val();
			}

			if($('#businessNameChange').text() == "직접입력") {
				var businessName = $('#businessNameView').val();
			} else if($('#businessNameChange').text() == "선택입력") {
				var businessName = $('#businessNameSelf').val();
			}
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			if(additionalInformation == "") {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
			} else {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
			}
		});
		
		$("#issueDateView").change(function() {
			if($('#customerNameChange').text() == "직접입력") {
				var customerName = $('#customerNameView').val();
			} else if($('#customerNameChange').text() == "선택입력") {
				var customerName = $('#customerNameSelf').val();
			}

			if($('#businessNameChange').text() == "직접입력") {
				var businessName = $('#businessNameView').val();
			} else if($('#businessNameChange').text() == "선택입력") {
				var businessName = $('#businessNameSelf').val();
			}
			var issueDate = $('#issueDateView').val();
			var additionalInformation = $('#additionalInformationView').val();
			issueDate = issueDate.replace(/\-/g, '');
			var activeId = $('.customerManagentActive').attr('id');
			if(activeId == "btnOldLicense") {
				customerName = $('#customerNameOldView').val();
				$('#licenseFilePathView').val('license-'+customerName+'-'+issueDate+".xml");
			} else {
				if(additionalInformation == "") {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+issueDate+".xml");
			} else {
				$('#licenseFilePathView').val('license-'+customerName+'-'+businessName+'-'+additionalInformation+"-"+issueDate+".xml");
			}
			}
		});
		
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
		
		$('#chkIGRIFFINAgentCount').change(function() {
			if($("#chkIGRIFFINAgentCount").is(":checked")){
				$("#igriffinAgentCountView").attr("disabled",true);
			} else {
				$("#igriffinAgentCountView").attr("disabled",false);
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
		document.getElementById('expirationDaysCalender').valueAsDate = new Date();
	}

	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	function existenceCheck() {
		var customerName = $('#customerNameView').val();
		var customerNameSelf = $('#customerNameSelf').val();
		var businessName = $('#businessNameView').val();
		var businessNameSelf = $('#businessNameSelf').val();
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
				var urlRoute = "<c:url value='/license5/existenceCheckInsert'/>";
			}
			if("${viewType}" == "update" || "${viewType}" == "updateback") {
				var urlRoute = "<c:url value='/license5/existenceCheckUpdate'/>";
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
			url: "<c:url value='/license5/licenseIssuanceConfirm'/>",
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

	function selfInput(data) {
		if (data == "customerNameChange") {
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
			url: "<c:url value='/license5/licenseUpdateConfirm'/>",
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

	function btnOldLicense() {
		$('#licenseModal').css('height','755px');
		$('.scribeMetering').css("display","none");
		$('.scribePeriod').css("display","none");		
		$('.newLicense').css("display","none");
		$('.oldLicense').css("display","block");
		$('#btnOldLicense').addClass('customerManagentActive');
		$('#btnNewLicense').removeClass('customerManagentActive');
		$('#btnScribeMetering').removeClass('customerManagentActive');
		$('#btnScribePeriod').removeClass('customerManagentActive');
		$('#licenseTypeView').val("(구)");

		$("input[name='chkIGRIFFINAgentCount']").prop("checked", false);
		$("#igriffinAgentCountView").attr("disabled",false);
		$("input[name='chkTos5AgentCount']").prop("checked", false);
		$("#tos5AgentCountView").attr("disabled",false);
		$("input[name='chkTos2AgentCount']").prop("checked", false);
		$("#tos2AgentCountView").attr("disabled",false);
		$("input[name='chkDbmsCount']").prop("checked", false);
		$("#dbmsCountView").attr("disabled",false);
	}

	function btnNewLicense() {
		$('#licenseModal').css('height','820px');
		$('.scribeMetering').css("display","none");
		$('.scribePeriod').css("display","none");
		$('.oldLicense').css("display","none");
		$('.newLicense').css("display","block");
		$('#btnNewLicense').addClass('customerManagentActive');
		$('#btnOldLicense').removeClass('customerManagentActive');
		$('#btnScribeMetering').removeClass('customerManagentActive');
		$('#btnScribePeriod').removeClass('customerManagentActive');
		$('#licenseTypeView').val("(신)");

		$("input[name='chkIGRIFFINAgentCount']").prop("checked", false);
		$("#igriffinAgentCountView").attr("disabled",false);
		$("input[name='chkTos5AgentCount']").prop("checked", false);
		$("#tos5AgentCountView").attr("disabled",false);
		$("input[name='chkTos2AgentCount']").prop("checked", false);
		$("#tos2AgentCountView").attr("disabled",false);
		$("input[name='chkNetworkCount']").prop("checked", false);
		$("#networkCountView").attr("disabled",false);
		$("input[name='chkDbmsCount']").prop("checked", false);
		$("#dbmsCountView").attr("disabled",false);
	}

	function btnScribePeriod() {
		$('#licenseModal').css('height','820px');
		$('.oldLicense').css("display","none");
		$('.newLicense').css("display","none");
		$('.scribeMetering').css("display","none");
		$('.scribePeriod').css("display","block");
		$('#btnScribePeriod').addClass('customerManagentActive');
		$('#btnOldLicense').removeClass('customerManagentActive');
		$('#btnNewLicense').removeClass('customerManagentActive');
		$('#btnScribeMetering').removeClass('customerManagentActive');
		$('#licenseTypeView').val("구독(기간)");

		$("input[name='chkIGRIFFINAgentCount']").prop("checked", true);
		$("#igriffinAgentCountView").attr("disabled",true);
		$("input[name='chkTos5AgentCount']").prop("checked", true);
		$("#tos5AgentCountView").attr("disabled",true);
		$("input[name='chkTos2AgentCount']").prop("checked", true);
		$("#tos2AgentCountView").attr("disabled",true);
		$("input[name='chkNetworkCount']").prop("checked", true);
		$("#networkCountView").attr("disabled",true);
		$("input[name='chkDbmsCount']").prop("checked", true);
		$("#dbmsCountView").attr("disabled",true);
	}

	function btnScribeMetering() {
		$('#licenseModal').css('height','820px');
		$('.oldLicense').css("display","none");
		$('.newLicense').css("display","none");
		$('.scribeMetering').css("display","block");
		$('.scribePeriod').css("display","none");
		$('#btnScribePeriod').removeClass('customerManagentActive');
		$('#btnOldLicense').removeClass('customerManagentActive');
		$('#btnNewLicense').removeClass('customerManagentActive');
		$('#btnScribeMetering').addClass('customerManagentActive');
		$('#licenseTypeView').val("구독(미터링)");
	}

	$("#customerNameOldView").change(function() {
		var customerName = $('#customerNameOldView').val();
		var issueDate = $('#issueDateView').val();
		issueDate = issueDate.replace(/\-/g, '');
		$('#licenseFilePathView').val('license-'+customerName+'-'+issueDate+".xml");
	});

	function isKoreanCharacter(char) {
	    var unicode = char.charCodeAt(0);
	    return unicode >= 44032 && unicode <= 55203; // 가(44032) ~ 힣(55203)
	}

	function oldExistenceCheck() {
		var customerName = $('#customerNameOldView').val();
		var macAddress = $('#macAddressView').val();
		var issueDate = $('#issueDateView').val();
		var expirationDays = $('#expirationDaysView').val();
		var productVersion = $('#productVersionView').val();
		var licenseFilePath = $('#licenseFilePathView').val();
		var viewType = $('#viewType').val();

		var containsOnlyKorean = true;

		for (var i = 0; i < customerName.length; i++) {
		    if (isKoreanCharacter(customerName[i])) {
		        containsOnlyKorean = false;
		        break;
		    }
		}

		if(!containsOnlyKorean) {
		    Swal.fire(
			  '한글 입력 불가!',
			  '(구) 버전의 경우 고객사명 한글 입력이 불가능 합니다.',
			  'error'
			)
			return false;
		}

		if(customerName.includes("\"") || licenseFilePath.includes("\"") || customerName.includes("/") || licenseFilePath.includes("/") || customerName.includes("\\") || licenseFilePath.includes("\\")) {
			Swal.fire(
			  '특수 문자 사용 불가!',
			  '특수문자 : \", \/, \\',
			  'error'
			)
			return false;
		}

		if(customerName.charAt(0) === "\-" || licenseFilePath.charAt(0) === "\-") {
			Swal.fire(
			  '사용 불가!',
			  '첫글자 \- 입력이 불가능합니다.',
			  'error'
			)
			return false;
		}
		
		$('.licenseShow').hide();
		if(customerName == "") {
			$('#NotCustomerNameOld').show();
		} else if(macAddress == "") {
			$('#NotMacAddress').show();			
		} else if(productVersion == "") {
			$('#NotProductVersion').show();
		} else if(licenseFilePath == "") {
			$('#NotLicenseFilePath').show();
		} else if(issueDate == "") {
			$('#NotIssueDate').show();
		} else { 
			<c:choose>
				<c:when test="${viewType eq 'issued' || viewType eq 'issuedback'}">
					BtnInsert();
				</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'updateback'}">
					BtnUpdate();	
				</c:when>
		    </c:choose>
		}
	}

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
	/* #requesterView, #salesManagerNameView {
		background-color: #efefef !important; 
		color: black !important;           
	} */

	#salesManagerNameView {
		background-color: #efefef !important; /* disabled 비슷한 회색 */
		color: black !important;           /* 글자색도 연하게 */
	}
</style>