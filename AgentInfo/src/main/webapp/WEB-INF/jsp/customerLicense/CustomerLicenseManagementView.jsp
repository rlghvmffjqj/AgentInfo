<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="modal-body" id="customerLicenseModal" style="width: 100%; height: 790px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="customerInfoKeyNum" name="customerInfoKeyNum" class="form-control viewForm" value="${customerInfo.customerInfoKeyNum}">
		<div id="sales">
			<div class="leftDiv">
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
				 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				 	</div>
				</div>
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
				 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
					</div>
				</div>
				<div class="pading5Width450">
			    	<label class="labelFontSize">설치 장소</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">사업(계약)기간</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">제품명</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">고객 담당자 정보</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">요청 근거</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">계약(납품) 금액</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">계약(납품) 업체</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">기타사항</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			</div>
			<div class="rightDiv">
				<div class="pading5Width450">
			    	<label class="labelFontSize">계약일</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">검수일(계산서)</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">검수 종류</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">SE 배정 상태</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">영업 본부 담당자</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">SE 담당자</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			    <div class="pading5Width450">
			    	<label class="labelFontSize">영업본부</label>
		    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
			    </div>
			</div>
		</div>
		<div id="security" style="display:none">
			<div id="securityInfo">
				<div class="leftDiv">
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
					 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}" disabled="disabled">
					 	</div>
					</div>
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
					 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}" disabled="disabled">
						</div>
					</div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">하위사업구분</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">품목</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">수량</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">OS</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">관리서버 DBMS</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">관리서버 Mac</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">설치 일자</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">납품 확인서 서명 일자</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				</div>
				<div class="rightDiv">
				    <div class="pading5Width450">
				    	<label class="labelFontSize">납품 업체명</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">납품 담당자명</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">확인 고객명</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">확인 담당자 정보</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">에이전트 OS 종류별 수량</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">라이선스 발급 상태</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술사업부 담당자</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				    <div class="pading5Width450">
				    	<label class="labelFontSize">보안기술</label>
			    		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" value="${networkClassificationView}">
				    </div>
				</div>
			</div>
			<div id="securitylicense" style="display:none">
				<div class="leftDiv">
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
					 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" disabled="disabled">
					 	</div>
					</div>
					<div class="pading5Width450">
						<div>
					 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
					 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" disabled="disabled">
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
		</div>
		<div id="evaluation" style="display:none">
			<div class="leftDiv">
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
				 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" disabled="disabled">
				 	</div>
				</div>
				<div class="pading5Width450">
					<div>
				 		<label class="labelFontSize">사업명</label><label class="colorRed">*</label>
				 		<input type="text" id="networkClassification" name="networkClassification" class="form-control viewForm" disabled="disabled">
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
			<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<!-- 기본 스크립트 -->
<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	$(function() {
		$('#customerLicenseModal').css('height','700px');
	});
	
	$('#btnSales').click(function() {
		$('#customerLicenseModal').css('height','700px');
		$('#sales').css("display","block");
		$('#security').css("display","none");
		$('#evaluation').css("display","none");
		$('#securitySub').css("display","none");
		$('#btnSales').addClass('customerManagentActive');
		$('#btnSecurity').removeClass('customerManagentActive');
		$('#btnEvaluation').removeClass('customerManagentActive');
	});
	
	$('#btnSecurity').click(function() {
		$('#customerLicenseModal').css('height','730px');
		$('#sales').css("display","none");
		$('#security').css("display","block");
		$('#evaluation').css("display","none");
		$('#securitySub').css("display","flex");
		$('#btnSales').removeClass('customerManagentActive');
		$('#btnSecurity').addClass('customerManagentActive');
		$('#btnEvaluation').removeClass('customerManagentActive');
	});
	
	$('#btnEvaluation').click(function() {
		$('#customerLicenseModal').css('height','790px');
		$('#sales').css("display","none");
		$('#security').css("display","none");
		$('#evaluation').css("display","block");
		$('#securitySub').css("display","none");
		$('#btnSales').removeClass('customerManagentActive');
		$('#btnSecurity').removeClass('customerManagentActive');
		$('#btnEvaluation').addClass('customerManagentActive');
	});
	
	$('#defaultInfo').click(function() {
		$('#defaultInfo').addClass('customerManagentActiveSub');
		$('#licenseInfo').removeClass('customerManagentActiveSub');
		$('#securitylicense').css("display","none");
		$('#securityInfo').css("display","block");
	});
	
	$('#licenseInfo').click(function() {
		$('#licenseInfo').addClass('customerManagentActiveSub');
		$('#defaultInfo').removeClass('customerManagentActiveSub');
		$('#securitylicense').css("display","block");
		$('#securityInfo').css("display","none");
	});
	
	
</script>

<!-- 영업본부 스크립트 -->
<script>
	
</script>

<!-- 보안기술사업본부 스크립트 -->
<script>
	
</script>

<!-- 평가인증실 스크립트 -->
<script>
	
</script>