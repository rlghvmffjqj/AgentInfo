<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" id="customerLicenseModal" style="width: 100%; height: 790px;">	
	<input type="hidden" id="customerConsolidationKeyNum" name="customerConsolidationKeyNum" class="form-control viewForm" value="${customerConsolidation.customerConsolidationKeyNum}">
	<form id="modalFormSales" name="form" method ="post">
		<div id="sales">
			<div class="leftDiv">
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
						<span class="colorRed" id="NotCustomer" style="display: none; line-height: initial; font-size: 12px;">고객사를 입력해주세요.</span>
				 		<input type="text" id="customerConsolidationCustomerView" name="customerConsolidationCustomerView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationCustomer}">
				 	</div>
				</div>
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
						<span class="colorRed" id="NotBussiness" style="display: none; line-height: initial; font-size: 12px;">사업명을 입력해주세요.</span>
				 		<input type="text" id="customerConsolidationBusinessView" name="customerConsolidationBusinessView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationBusiness}">
					</div>
				</div>
				<c:if test="${role eq 'Sales'}">
					<c:if test="${viewType eq 'insert'}">
						<div class="pading5Width450">
			    			<label class="labelFontSize">수량</label>
		    				<input type="number" id="customerConsolidationQuantityView" name="customerConsolidationQuantityView" class="form-control viewForm" value="1">
			    		</div>
			    		<div class="pading5Width450">
			    			<label class="labelFontSize">사업(계약)기간</label>
							<div>
		    					<input type="date" id="customerConsolidationBusinessPeriodStartView" name="customerConsolidationBusinessPeriodStartView" class="form-control viewForm" style="width:48%; float: left;">
								<span style="width: 4%; float: left; text-align: center;">~</span>
								<input type="date" id="customerConsolidationBusinessPeriodEndView" name="customerConsolidationBusinessPeriodEndView" class="form-control viewForm" style="width:48%; float: right;">
							</div>
			    		</div>
			    		<div class="pading5Width450">
			    			<label class="labelFontSize">계약일</label>
		    				<input type="date" id="customerConsolidationContractDateView" name="customerConsolidationContractDateView" class="form-control viewForm">
			    		</div>
					</c:if>
				</c:if>
				<c:if test="${viewType eq 'update' || role ne 'Sales'}">
					<div class="pading5Width450">
			    		<label class="labelFontSize">수량</label>
		    			<input type="number" id="customerConsolidationQuantityView" name="customerConsolidationQuantityView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationQuantity}">
			    	</div>
			    	<div class="pading5Width450">
			    		<label class="labelFontSize">사업(계약)기간</label>
						<div>
		    				<input type="date" id="customerConsolidationBusinessPeriodStartView" name="customerConsolidationBusinessPeriodStartView" class="form-control viewForm" style="width:48%; float: left;" value="${customerConsolidation.customerConsolidationBusinessPeriodStart}">
							<span style="width: 4%; float: left; text-align: center;">~</span>
							<input type="date" id="customerConsolidationBusinessPeriodEndView" name="customerConsolidationBusinessPeriodEndView" class="form-control viewForm" style="width:48%; float: right;" value="${customerConsolidation.customerConsolidationBusinessPeriodEnd}">
						</div>
			    	</div>
			    	<div class="pading5Width450">
			    		<label class="labelFontSize">계약일</label>
		    			<input type="date" id="customerConsolidationContractDateView" name="customerConsolidationContractDateView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationContractDate}">
			    	</div>
				</c:if>
			</div>
			<div class="rightDiv">
				<div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="" name="" class="form-control viewForm">
			    </div>
				<div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="" name="" class="form-control viewForm">
			    </div>
				<div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="" name="" class="form-control viewForm">
			    </div>
				<div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="" name="" class="form-control viewForm">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="" name="" class="form-control viewForm">
			    </div>
			</div>
		</div>
	</form>
	<div id="security" style="display:none">
		<form id="modalFormEngineerLeader" name="form" method ="post">
			<div id="securityInfo">
				<div class="leftDiv">
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
					 		<input type="text" id="" name="" class="form-control viewForm" value="${customerConsolidation.customerConsolidationCustomer}" disabled="disabled">
					 	</div>
					</div>
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
					 		<input type="text" id="" name="" class="form-control viewForm" value="${customerConsolidation.customerConsolidationBusiness}" disabled="disabled">
						</div>
					</div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">사용처</label><label class="colorRed">*</label>
						<span class="colorRed" id="NotLocation" style="display: none; line-height: initial; font-size: 12px;">사용처를 입력해주세요.</span>
			    		<input type="text" id="customerConsolidationLocationView" name="customerConsolidationLocationView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationLocation}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">담당 엔지니어</label>
			    		<input type="text" id="customerConsolidationEngineerView" name="customerConsolidationEngineerView" class="form-control viewForm" style="width: 93%;	float: left;" value="${customerConsolidation.customerConsolidationEngineer}" readonly>
						<input type="hidden" id="customerConsolidationEngineerIdView" name="customerConsolidationEngineerIdView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationEngineerId}" readonly>
						<button class="searchBtn" type="button" onclick="engineerSearch();"><img class="img-fluid" src="/AgentInfo/images/search.png" style="width: 100%;"></button>
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">고객 담당자</label>
			    		<input type="text" id="customerConsolidationCustomerManagerView" name="customerConsolidationCustomerManagerView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationCustomerManager}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">고객 이메일</label>
			    		<input type="text" id="customerConsolidationEmailView" name="customerConsolidationEmailView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationEmail}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">고객 전화번호</label>
			    		<input type="text" id="customerConsolidationContactView" name="customerConsolidationContactView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationContact}">
				    </div>
				</div>
				<div class="rightDiv">
					<div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="" name="" class="form-control viewForm">
				    </div>
					<div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="" name="" class="form-control viewForm">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="" name="" class="form-control viewForm">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="" name="" class="form-control viewForm">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="" name="" class="form-control viewForm">
				    </div>
					<div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="" name="" class="form-control viewForm">
				    </div>
				</div>
			</div>
		</form>
		<form id="modalFormSecurityLicense" name="form" method ="post">
			<div id="securitylicense" style="display:none">
				<div class="leftDiv">
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
					 		<input type="text" id="" name="customerConsolidationCustomerView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationCustomer}" disabled="disabled">
					 	</div>
					</div>
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
					 		<input type="text" id="" name="customerConsolidationBusinessView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationBusiness}" disabled="disabled">
						</div>
					</div>
					<div class="pading5Width450">
				    	<label class="labelFontSize">제품유형</label><label class="colorRed">*</label>
				    	<select class="form-control selectpicker selectForm" id="productTypeView" name="productTypeView" data-live-search="true" data-size="5" data-actions-box="true">
							<option value="mGRIFFIN">mGRIFFIN</option>
							<option value="iGRIFFIN" selected>iGRIFFIN</option>
							<option value="TOS">TOS</option>
							<option value="TOSSuite">TOSSuite</option>
						</select>
				    </div>
				    <div class="pading5Width450">
			         	<label class="labelFontSize">MAC주소</label><label class="colorRed">*</label>
			         	<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">MAC주소를 입력해주세요.</span>
			         	<input type="text" id="macAddressView" name="macAddressView" class="form-control viewForm" value="${license.macAddress}">
			         </div>
			          <div class="pading5Width450">
			         	<label class="labelFontSize">시작일</label><label class="colorRed">*</label>
			         	<input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm" value="${license.issueDate}">
			         </div>
			         <div class="pading5Width450">
				      	<label class="labelFontSize">만료일</label><label class="colorRed">*</label>
				      	<div class="floatRight">
				      		<input class="cssCheck" type="checkbox" id="chkExpirationDays" name="chkExpirationDays" value="무제한">
			    			<label for="chkExpirationDays"></label><span class="margin17">무제한</span>
			    		</div>
			    		<a href="#" class="selfInput" style="margin-right: 2%;" id="expirationDaysChange" onclick="selfInput('expirationDaysChange');">달력</a>
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
				      	<input type="number" id="igriffinAgentCountView" name="igriffinAgentCountView" class="form-control viewForm" value="1">
				      </div>
				      <div class="pading5Width450">
				      	<label class="labelFontSize">TOS 5.0 Agent 수량</label><label class="colorRed">*</label>
				      	<div class="floatRight">
				      		<input class="cssCheck" type="checkbox" id="chkTos5AgentCount" name="chkTos5AgentCount" value="무제한">
			    			<label for="chkTos5AgentCount"></label><span class="margin17">무제한</span>
			    		</div>
				      	<input type="number" id="tos5AgentCountView" name="tos5AgentCountView" class="form-control viewForm" value="1">
					 </div>
					 <div class="pading5Width450">
				      	<label class="labelFontSize">TOS 2.0 Agent 수량</label><label class="colorRed">*</label>
				      	<div class="floatRight">
				      		<input class="cssCheck" type="checkbox" id="chkTos2AgentCount" name="chkTos2AgentCount" value="무제한">
			    			<label for="chkTos2AgentCount"></label><span class="margin17">무제한</span>
			    		</div>
				      	<input type="number" id="tos2AgentCountView" name="tos2AgentCountView" class="form-control viewForm" value="1">
					</div>
					<div class="pading5Width450">
				      	<label class="labelFontSize">DBMS 수량</label><label class="colorRed">*</label>
				      	<div class="floatRight">
				      		<input class="cssCheck" type="checkbox" id="chkDbmsCount" name="chkDbmsCount" value="무제한">
			    			<label for="chkDbmsCount"></label><span class="margin17">무제한</span>
			    		</div>
				      	<input type="number" id="dbmsCountView" name="dbmsCountView" class="form-control viewForm" value="1">
					</div>
					<div class="pading5Width450">
				      	<label class="labelFontSize">Network 수량</label><label class="colorRed">*</label>
				      	<div class="floatRight">
				      		<input class="cssCheck" type="checkbox" id="chkNetworkCount" name="chkNetworkCount" value="무제한">
			    			<label for="chkNetworkCount"></label><span class="margin17">무제한</span>
			    		</div>
				       	<input type="number" id="networkCountView" name="networkCountView" class="form-control viewForm" value="1">
					</div>
				</div>
				<div class="rightDiv">
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
				     	<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="licens-고객사명-사업명-날짜.xml">
				    </div>
				</div>
			</div>
		</form>
	</div>
	<form id="modalFormEvaluation" name="form" method ="post">
		<div id="evaluation" style="display:none">
			<div class="leftDiv">
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
				 		<input type="text" id="" name="customerConsolidationCustomerView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationCustomer}" disabled="disabled">
				 	</div>
				</div>
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
				 		<input type="text" id="" name="customerConsolidationBusinessView" class="form-control viewForm" value="${customerConsolidation.customerConsolidationBusiness}" disabled="disabled">
					</div>
				</div>
				<div class="pading5Width450">
	         		<label class="labelFontSize">하위사업구분</label>
	         		<input type="text" id="additionalInformationView" name="additionalInformationView" class="form-control viewForm" value="${license.additionalInformation}" max="9999-12-31">
	         	</div>
				<div class="pading5Width450">
			    	<label class="labelFontSize">제품유형</label><label class="colorRed">*</label>
			    	<select class="form-control selectpicker selectForm" id="productTypeView" name="productTypeView" data-live-search="true" data-size="5" data-actions-box="true">
						<option value="mGRIFFIN">mGRIFFIN</option>
						<option value="iGRIFFIN" selected>iGRIFFIN</option>
						<option value="TOS">TOS</option>
						<option value="TOSSuite">TOSSuite</option>
					</select>
			    </div>
			    <div class="pading5Width450">
			     	<label class="labelFontSize">MAC주소</label><label class="colorRed">*</label>
			     	<span class="colorRed licenseShow" id="NotMacAddress" style="display: none; line-height: initial; float: right; font-size: 11px;">MAC주소를 입력해주세요.</span>
			     	<input type="text" id="macAddressView" name="macAddressView" class="form-control viewForm" value="${license.macAddress}">
			     </div>
			      <div class="pading5Width450">
			     	<label class="labelFontSize">시작일</label><label class="colorRed">*</label>
			     	<input type="date" id="issueDateView" name="issueDateView" class="form-control viewForm" value="${license.issueDate}">
			     </div>
			     <div class="pading5Width450">
			      	<label class="labelFontSize">만료일</label><label class="colorRed">*</label>
			      	<div class="floatRight">
			      		<input class="cssCheck" type="checkbox" id="chkExpirationDays" name="chkExpirationDays" value="무제한">
						<label for="chkExpirationDays"></label><span class="margin17">무제한</span>
					</div>
					<a href="#" class="selfInput" style="margin-right: 2%;" id="expirationDaysChange" onclick="selfInput('expirationDaysChange');">달력</a>
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
			      	<input type="number" id="igriffinAgentCountView" name="igriffinAgentCountView" class="form-control viewForm" value="1">
			      </div>
			      <div class="pading5Width450">
			      	<label class="labelFontSize">TOS 5.0 Agent 수량</label><label class="colorRed">*</label>
			      	<div class="floatRight">
			      		<input class="cssCheck" type="checkbox" id="chkTos5AgentCount" name="chkTos5AgentCount" value="무제한">
						<label for="chkTos5AgentCount"></label><span class="margin17">무제한</span>
					</div>
			      	<input type="number" id="tos5AgentCountView" name="tos5AgentCountView" class="form-control viewForm" value="1">
				 </div>
				 <div class="pading5Width450">
			      	<label class="labelFontSize">TOS 2.0 Agent 수량</label><label class="colorRed">*</label>
			      	<div class="floatRight">
			      		<input class="cssCheck" type="checkbox" id="chkTos2AgentCount" name="chkTos2AgentCount" value="무제한">
						<label for="chkTos2AgentCount"></label><span class="margin17">무제한</span>
					</div>
			      	<input type="number" id="tos2AgentCountView" name="tos2AgentCountView" class="form-control viewForm" value="1">
				</div>
				<div class="pading5Width450">
			      	<label class="labelFontSize">DBMS 수량</label><label class="colorRed">*</label>
			      	<div class="floatRight">
			      		<input class="cssCheck" type="checkbox" id="chkDbmsCount" name="chkDbmsCount" value="무제한">
						<label for="chkDbmsCount"></label><span class="margin17">무제한</span>
					</div>
			      	<input type="number" id="dbmsCountView" name="dbmsCountView" class="form-control viewForm" value="1">
				</div>
				<div class="pading5Width450">
			      	<label class="labelFontSize">Network 수량</label><label class="colorRed">*</label>
			      	<div class="floatRight">
			      		<input class="cssCheck" type="checkbox" id="chkNetworkCount" name="chkNetworkCount" value="무제한">
						<label for="chkNetworkCount"></label><span class="margin17">무제한</span>
					</div>
			       	<input type="number" id="networkCountView" name="networkCountView" class="form-control viewForm" value="1">
				</div>
			</div>
			<div class="rightDiv">
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
			     	<input type="text" id="licenseFilePathView" name="licenseFilePathView" class="form-control viewForm" value="licens-고객사명-사업명-날짜.xml">
			    </div>
			    <div class="pading5Width450">
	         		<label class="labelFontSize">요청자</label>
	         		<input type="text" id="requesterView" name="requesterView" class="form-control viewForm" value="${license.requester}">
	        	</div>
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<sec:authorize access="hasAnyRole('ADMIN','SALES')">
				<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="insertSalesBtn" onClick="insertSalesBtn();" style="display: none;">등록</button>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','ENGINEERLEADER')">
				<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="insertEngineerLeaderBtn" onClick="insertEngineerLeaderBtn();" style="display: none;">배정</button>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','ENGINEERLEADER','ENGINEER')">
				<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="insertEngineerBtn" onClick="insertEngineerBtn();" style="display: none;">발급 요청</button>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','LICENSE')">
				<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="insertLicenseBtn" onClick="insertLicenseBtn();" style="display: none;">발급</button>
			</sec:authorize>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<sec:authorize access="hasAnyRole('ADMIN','SALES')">
				<c:if test="${customerConsolidation.customerConsolidationDepartment eq '영업본부'}">
					<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="updateSalesBtn" onClick="updateSalesBtn();" style="display: none;">수정</button>
				</c:if>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','ENGINEERLEADER')">
				<c:if test="${customerConsolidation.customerConsolidationDepartment eq '보안기술사업본부'}">
					<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="updateEngineerLeaderBtn" onClick="updateEngineerLeaderBtn();" style="display: none;">수정</button>
				</c:if>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('ADMIN','LICENSE')">
				<c:if test="${customerConsolidation.customerConsolidationDepartment eq '보안기술사업본부'}">
					<button class="btn btn-default btn-outline-info-add customerConsolidationView" id="updateLicenseBtn" onClick="updateLicenseBtn();" style="display: none;">재발급</button>
				</c:if>
			</sec:authorize>
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<!-- 기본 스크립트 -->
<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	$(function() {
		if("Sales" == "${role}") {
			if("insert" == "${viewType}") {
				document.getElementById('customerConsolidationBusinessPeriodStartView').value = new Date().toISOString().substring(0, 10);
				document.getElementById('customerConsolidationBusinessPeriodEndView').value = new Date().toISOString().substring(0, 10);
				document.getElementById('customerConsolidationContractDateView').value = new Date().toISOString().substring(0, 10);
			}
			btnSales();
		}
		if("EngineerLeader" == "${role}" || "Engineer" == "${role}") {
			btnSecurity();
		}

		if("Engineer" == "${role}") {
			licenseInfo();
		}

		if("License" == "${role}") {
			btnEvaluation();
		}

		if("Admin" == "${role}") {
			btnSales();
		}
	});
	
	function btnSales() {
		$('#customerLicenseModal').css('height','400px');
		$('#sales').css("display","block");
		$('#security').css("display","none");
		$('#evaluation').css("display","none");
		$('#securitySub').css("display","none");
		$('#btnSales').addClass('customerConsolidationActive');
		$('#btnSecurity').removeClass('customerConsolidationActive');
		$('#btnEvaluation').removeClass('customerConsolidationActive');
		$('.customerConsolidationView').hide();
		$('#insertSalesBtn').show();
		$('#updateSalesBtn').show();
	};
	
	function btnSecurity() {
		//$('#customerLicenseModal').css('height','730px');
		$('#sales').css("display","none");
		$('#security').css("display","block");
		$('#evaluation').css("display","none");
		$('#securitySub').css("display","flex");
		$('#btnSales').removeClass('customerConsolidationActive');
		$('#btnSecurity').addClass('customerConsolidationActive');
		$('#btnEvaluation').removeClass('customerConsolidationActive');
		
		if("Engineer" == "${role}") {
			licenseInfo();
		} else {
			defaultInfo();
		}
	}
	
	function btnEvaluation() {
		$('#customerLicenseModal').css('height','790px');
		$('#sales').css("display","none");
		$('#security').css("display","none");
		$('#evaluation').css("display","block");
		$('#securitySub').css("display","none");
		$('#btnSales').removeClass('customerConsolidationActive');
		$('#btnSecurity').removeClass('customerConsolidationActive');
		$('#btnEvaluation').addClass('customerConsolidationActive');
		$('.customerConsolidationView').hide();
		$('#insertLicenseBtn').show();
		$('#updateLicenseBtn').show();
	}
	
	function defaultInfo() {
		$('#customerLicenseModal').css('height','550px');
		$('#defaultInfo').addClass('customerConsolidationActiveSub');
		$('#licenseInfo').removeClass('customerConsolidationActiveSub');
		$('#securitylicense').css("display","none");
		$('#securityInfo').css("display","block");
		$('.customerConsolidationView').hide();
		$('#insertEngineerLeaderBtn').show();
		$('#updateEngineerLeaderBtn').show();
	}
	
	function licenseInfo() {
		$('#customerLicenseModal').css('height','730px');
		$('#licenseInfo').addClass('customerConsolidationActiveSub');
		$('#defaultInfo').removeClass('customerConsolidationActiveSub');
		$('#securitylicense').css("display","block");
		$('#securityInfo').css("display","none");
		$('.customerConsolidationView').hide();
		$('#insertEngineerBtn').show();
		$('#updateEngineerBtn').show();
	}
	
	
</script>

<!-- 영업본부 스크립트 -->
<script>
	function insertSalesBtn() {
		var customerConsolidationCustomerView = $('#customerConsolidationCustomerView').val();
		var customerConsolidationBusinessView = $('#customerConsolidationBusinessView').val();

		// 고객사 유효성검사
		if(customerConsolidationCustomerView == "") { 
			$('#NotCustomer').show();	
			return false;
		} else {
			$('#NotCustomer').hide();
		}

		// 사업명 유효성검사
		if(customerConsolidationBusinessView == "") { 
			$('#NotBussiness').show();	
			return false;
		} else {
			$('#NotBussiness').hide();
		}

		var postData = $('#modalFormSales').serializeObject();
		$.ajax({
			url: "<c:url value='/customerConsolidation/insertSales'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result == "NotCustomer") { // 고객사명 미 입력 시
					$('#NotCustomer').show();
				} else {
					$('#NotCustomer').hide();
				} 

				if(result == "NotBussiness") { // 고객사명 미 입력 시
					$('#NotBussiness').show();
				} else {
					$('#NotBussiness').hide();
				} 

				if(result == "Duplication") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '중복된 고객사 및 사업명이 존재합니다.',
					});
				} else if(result == "OK") {
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
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}

	function updateSalesBtn() {
		var customerConsolidationCustomerView = $('#customerConsolidationCustomerView').val();
		var customerConsolidationBusinessView = $('#customerConsolidationBusinessView').val();

		// 고객사 유효성검사
		if(customerConsolidationCustomerView == "") { 
			$('#NotCustomer').show();	
			return false;
		} else {
			$('#NotCustomer').hide();
		}

		// 사업명 유효성검사
		if(customerConsolidationBusinessView == "") { 
			$('#NotBussiness').show();	
			return false;
		} else {
			$('#NotBussiness').hide();
		}

		var postData = $('#modalFormSales').serializeArray();
		postData.push({name : "customerConsolidationKeyNum", value : $('#customerConsolidationKeyNum').val()});
		$.ajax({
			url: "<c:url value='/customerConsolidation/updateSales'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result == "NotCustomer") { // 고객사명 미 입력 시
					$('#NotCustomer').show();
				} else {
					$('#NotCustomer').hide();
				} 

				if(result == "NotBussiness") { // 고객사명 미 입력 시
					$('#NotBussiness').show();
				} else {
					$('#NotBussiness').hide();
				} 

				if(result == "Duplication") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '중복된 고객사 및 사업명이 존재합니다.',
					});
				} else if(result == "OK") {
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
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}
</script>

<!-- 보안기술사업본부 스크립트 -->
<script>
	function insertEngineerLeaderBtn() {
		var customerConsolidationLocationView = $('#customerConsolidationLocationView').val();

		// 사용처 유효성검사
		if(customerConsolidationLocationView == "") { 
			$('#NotLocation').show();	
			return false;
		} else {
			$('#NotLocation').hide();
		}

		var postData = $('#modalFormEngineerLeader').serializeArray();
		postData.push({name : "customerConsolidationKeyNum", value : $('#customerConsolidationKeyNum').val()});
		$.ajax({
			url: "<c:url value='/customerConsolidation/insertSecurityInfo'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result == "NotLocation") { // 사용처 미 입력 시
					$('#NotLocation').show();
				} else {
					$('#NotLocation').hide();
				} 

				if(result == "Duplication") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '중복된 사용처가 존재합니다.',
					});
				} else if(result == "OK") {
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
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}

	function updateEngineerLeaderBtn() {
		var customerConsolidationLocationView = $('#customerConsolidationLocationView').val();

		// 사용처 유효성검사
		if(customerConsolidationLocationView == "") { 
			$('#NotLocation').show();	
			return false;
		} else {
			$('#NotLocation').hide();
		}

		var postData = $('#modalFormEngineerLeader').serializeArray();
		postData.push({name : "customerConsolidationKeyNum", value : $('#customerConsolidationKeyNum').val()});
		$.ajax({
			url: "<c:url value='/customerConsolidation/updateSecurityInfo'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result == "NotLocation") { // 사용처 미 입력 시
					$('#NotLocation').show();
				} else {
					$('#NotLocation').hide();
				} 

				if(result == "Duplication") {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '중복된 사용처가 존재합니다.',
					});
				} else if(result == "OK") {
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
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}

	function engineerSearch() {
		var postData = $('#modalFormEngineerLeader').serializeArray();
		postData.push({name : "customerConsolidationKeyNum", value : $('#customerConsolidationKeyNum').val()});
		postData.push({name : "viewType", value : "${viewType}"});
		$.ajax({
		    type: 'POST',
			data: postData,
		    url: "<c:url value='/customerConsolidation/engineerSearchView'/>",
		    async: false,
		    success: function (data) {
				$('#modal').modal("hide"); // 모달 닫기
				setTimeout(function() {
		    		$.modal(data, 'customerConsolidationSearch'); 
		    	},300)
		    },
		    error: function(e) {
		        alert(e);
		    }
		});
	}
</script>

<!-- 평가인증실 스크립트 -->
<script>
	
</script>