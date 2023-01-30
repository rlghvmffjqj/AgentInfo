<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 700px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="packagesKeyNum" name="packagesKeyNum" class="form-control viewForm" value="${packages.packagesKeyNum}">
		<input type="hidden" id="packagesKeyNumOrigin" name="packagesKeyNumOrigin" class="form-control viewForm" value="${packages.packagesKeyNumOrigin}">
		<input type="hidden" id="sendPackageKeyNum" name="sendPackageKeyNum" class="form-control viewForm" value="${sendPackage.sendPackageKeyNum}">
		<input type="hidden" id="sendPackageCountView" name="sendPackageCountView" class="form-control viewForm" value="${sendPackage.sendPackageCount}">
		<input type="hidden" id="sendPackageRandomUrl" name="sendPackageRandomUrl" class="form-control viewForm" value="${sendPackage.sendPackageRandomUrl}">  
		<div class="leftDiv">
			 <c:choose>
				<c:when test="${viewType eq 'insert'}">
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
						<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">사업명</label>
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
						<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
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
	         	<label class="labelFontSize">망 구분</label>
	         	<input type="text" id="networkClassificationView" name="networkClassificationView" class="form-control viewForm" value="${packages.networkClassification}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">요청일자</label>
	         	<input type="date" id="requestDateView" name="requestDateView" class="form-control viewForm" value="${packages.requestDate}" max="9999-12-31">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">전달일자</label>
	         	<input type="date" id="deliveryDataView" name="deliveryDataView" class="form-control viewForm" value="${packages.deliveryData}" max="9999-12-31">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">패키지 종류</label>
					  		<a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="managementServerViewSelf">
						  	<select class="form-control selectpicker selectForm" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${managementServer}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">일반/커스텀</label>
					  		<a href="#" class="selfInput" id="generalCustomChange" onclick="selfInput('generalCustomChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="generalCustomSelf" name="generalCustomSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="generalCustomViewSelf">
						  	<select class="form-control selectpicker selectForm" id="generalCustomView" name="generalCustomView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${generalCustom}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">Agent ver</label>
					  		<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentVerViewSelf">
						  	<select class="form-control selectpicker selectForm" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${agentVer}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">패키지 종류</label>
					  		<a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="managementServerViewSelf">
				         	<select class="form-control selectpicker selectForm" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.managementServer ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.managementServer eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${managementServer}">
									<option value="${item}" <c:if test="${item eq packages.managementServer}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">일반/커스텀</label>
					  		<a href="#" class="selfInput" id="generalCustomChange" onclick="selfInput('generalCustomChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="generalCustomSelf" name="generalCustomSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="generalCustomViewSelf">
				         	<select class="form-control selectpicker selectForm" id="generalCustomView" name="generalCustomView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.generalCustom ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.generalCustom eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${generalCustom}">
									<option value="${item}" <c:if test="${item eq packages.generalCustom}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">Agent ver</label>
					  		<a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentVerViewSelf">
				         	<select class="form-control selectpicker selectForm" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.agentVer ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.agentVer eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${agentVer}">
									<option value="${item}" <c:if test="${item eq packages.agentVer}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			    </c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">패키지명</label>
	         	<input type="text" id="packageNameView" name="packageNameView" class="form-control viewForm" value="${packages.packageName}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">담당자</label>
	         	<input type="text" id="managerView" name="managerView" class="form-control viewForm" value="${packages.manager}">
	         </div>
	     </div>
         <div class="rightDiv">
         	<c:choose>
				<c:when test="${viewType eq 'insert'}">
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">OS종류</label>
					  		<a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="osTypeViewSelf">
			                <select class="form-control selectpicker selectForm" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5">
			                	<option value=""></option>
								<c:forEach var="item" items="${osType}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">OS종류</label>
					  		<a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="osTypeViewSelf">
			                <select class="form-control selectpicker selectForm" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5">
			                	<c:if test="${packages.osType ne ''}"><option value=""></option></c:if>
			                	<c:if test="${packages.osType eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${osType}">
									<option value="${item}" <c:if test="${item eq packages.osType}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			    </c:when>
			 </c:choose>
			 <div class="pading5Width450">
	         	<label class="labelFontSize">패키지 상세버전</label>
	         	<input type="text" id="osDetailVersionView" name="osDetailVersionView" class="form-control viewForm" value="${packages.osDetailVersion}">
	         </div>
	         <c:choose>
				<c:when test="${viewType eq 'insert'}">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">Agent OS</label>
					  		<a href="#" class="selfInput" id="agentOSChange" onclick="selfInput('agentOSChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentOSSelf" name="agentOSSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentOSViewSelf">
						  	<select class="form-control selectpicker selectForm" id="agentOSView" name="agentOSView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${agentOS}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">기존/신규</label>
					  		<a href="#" class="selfInput" id="existingNewChange" onclick="selfInput('existingNewChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="existingNewSelf" name="existingNewSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="existingNewViewSelf">
						  	<select class="form-control selectpicker selectForm" id="existingNewView" name="existingNewView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${existingNew}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">요청 제품 구분</label>
					  		<a href="#" class="selfInput" id="requestProductCategoryChange" onclick="selfInput('requestProductCategoryChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="requestProductCategorySelf" name="requestProductCategorySelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="requestProductCategoryViewSelf">
						  	<select class="form-control selectpicker selectForm" id="requestProductCategoryView" name="requestProductCategoryView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${requestProductCategory}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
					 <div class="pading5Width450">
					 	<div>
					  		<label class="labelFontSize">전달 방법</label>
					  		<a href="#" class="selfInput" id="deliveryMethodChange" onclick="selfInput('deliveryMethodChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="deliveryMethodSelf" name="deliveryMethodSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="deliveryMethodViewSelf">
			                <select class="form-control selectpicker selectForm" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5">
			                	<option value=""></option>
								<c:forEach var="item" items="${deliveryMethod}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			 	</c:when>
				<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">Agent OS</label>
					  		<a href="#" class="selfInput" id="agentOSChange" onclick="selfInput('agentOSChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="agentOSSelf" name="agentOSSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="agentOSViewSelf">
				         	<select class="form-control selectpicker selectForm" id="agentOSView" name="agentOSView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.agentOS ne ''}"><option value=""></option></c:if>	
				         		<c:if test="${packages.agentOS eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${agentOS}">
									<option value="${item}" <c:if test="${item eq packages.agentOS}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">기존/신규</label>
					  		<a href="#" class="selfInput" id="existingNewChange" onclick="selfInput('existingNewChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="existingNewSelf" name="existingNewSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="existingNewViewSelf">
				         	<select class="form-control selectpicker selectForm" id="existingNewView" name="existingNewView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.existingNew ne ''}"><option value=""></option></c:if>	
				         		<c:if test="${packages.existingNew eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${existingNew}">
									<option value="${item}" <c:if test="${item eq packages.existingNew}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
					<div class="pading5Width450">
						<div>
					  		<label class="labelFontSize">요청 제품 구분</label>
					  		<a href="#" class="selfInput" id="requestProductCategoryChange" onclick="selfInput('requestProductCategoryChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="requestProductCategorySelf" name="requestProductCategorySelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="requestProductCategoryViewSelf">
				         	<select class="form-control selectpicker selectForm" id="requestProductCategoryView" name="requestProductCategoryView" data-live-search="true" data-size="5">
				         		<c:if test="${packages.requestProductCategory ne ''}"><option value=""></option></c:if>
				         		<c:if test="${packages.requestProductCategory eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${requestProductCategory}">
									<option value="${item}" <c:if test="${item eq packages.requestProductCategory}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
			         </div>
			         <div class="pading5Width450">
			         	<div>
					  		<label class="labelFontSize">전달 방법</label>
					  		<a href="#" class="selfInput" id="deliveryMethodChange" onclick="selfInput('deliveryMethodChange');">직접입력</a>
					  	</div>
					  	<input type="hidden" id="deliveryMethodSelf" name="deliveryMethodSelf" class="form-control viewForm" placeholder="직접입력" value="">
					  	<div id="deliveryMethodViewSelf">
			                <select class="form-control selectpicker selectForm" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5">
			                	<c:if test="${packages.deliveryMethod ne ''}"><option value=""></option></c:if>
			                	<c:if test="${packages.deliveryMethod eq ''}"><option value=""></option></c:if>
								<c:forEach var="item" items="${deliveryMethod}">
									<option value="${item}" <c:if test="${item eq packages.deliveryMethod}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					 </div>
			    </c:when>
			 </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">비고</label>
	         	<input type="text" id="noteView" name="noteView" class="form-control viewForm" value="${packages.note}">
	         </div>
	         <div style="background: chocolate; height: 1px; margin: 5px;"></div>
	         <div style="float: right;">
	         	<input class="cssCheck" type="checkbox" id="chkEssential" checked>
			 	<label for="chkEssential"></label><span class="margin17">필수</span>
			 </div>
	         <div class="pading5Width450">
		     	<div><label class="labelFontSize">다운로드 가능기간</label><label class="colorRed sendPackageEssential">*</label></div>
		     	<input type="text" class="form-control viewForm" id="sendPackageStartDateView" name="sendPackageStartDateView"  value="${sendPackage.sendPackageStartDate}" max="9999-12-31" style="width: 48%;float: left;">
		     	~
		     	<input type="text" id="sendPackageEndDateView" name="sendPackageEndDateView" class="form-control viewForm" value="${sendPackage.sendPackageEndDate}" max="9999-12-31" style="width: 48%;float: right;">
		     	<span class="colorRed" id="NotSendPackageDate" style="display: none; float: left; line-height: initial;">다운로드 기간 입력 바랍니다.</span>
		     	<span class="colorRed" id="PeriodSendPackageDate" style="display: none; float: left; line-height: initial;">다운로드 가능 시작 기간이 종료 기간보다 크지 않아야 합니다.</span>
		    </div>
			<div class="pading5Width450">
				<div>
					<label class="labelFontSize">최대 다운로드 횟수</label><label class="colorRed sendPackageEssential">*</label>
				</div>
				<c:choose>
					<c:when test="${viewType eq 'insert'}">
						<input type="number" id="sendPackageLimitCountView" name="sendPackageLimitCountView" class="form-control viewForm" value="1">
					</c:when>
					<c:when test="${viewType eq 'update' || viewType eq 'copy'}">
						<input type="number" id="sendPackageLimitCountView" name="sendPackageLimitCountView" class="form-control viewForm" value="${sendPackage.sendPackageLimitCount}">
					</c:when>
				</c:choose>
				<span class="colorRed" id="NotSendPackageCount" style="display: none; line-height: initial; float: left; width: 100%;">1이상의 값을 입력 바랍니다.</span>
			</div>
			<div class="pading5Width450">
				<div>
					<label class="labelFontSize">패키지</label><label class="colorRed sendPackageEssential">*</label>
				</div>
				<input class="form-control viewForm" type="file" name="sendPackageView" id="sendPackageView" />
				<span class="colorRed" id="NotSendPackageView" style="display: none; line-height: initial;">패키지를 등록 해주세요.</span>
				<c:choose>
					<c:when test="${viewType eq 'update'}">
						<span class="colorRed" style="line-height: initial;">패키지 변경 할 경우만 파일 선택 해주세요.</span>
					</c:when>
				</c:choose>
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
		<c:when test="${viewType eq 'copy'}">
			<button class="btn btn-default btn-outline-info-add" id="copyBtn">복사</button>
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<!-- progress Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="margin-top: 25%;">
        <div class="modal-content" style="border:1px solid !important; width: 95%; margin-left: 3%;">
            <div class="modal-header" style="background: burlywood;">
                <h3 style="font-weight: bold; font-family: none; color: white;">패키지 업로드 ...</h3>
            </div>
            <div class="modal-body">
                <!-- progress , bar, percent를 표시할 div 생성한다. -->
                <div class="progress">
                    <div class="bar"></div>
                    <div class="percent">0%</div>
                </div>
                <div id="status"></div>
            </div>
        </div>
    </div>
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	$('#sendPackageStartDateView').datetimepicker();
	$('#sendPackageEndDateView').datetimepicker();
	
	$(function () {
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		if(sendPackageLimitCountView == '') {
			$('#sendPackageLimitCountView').val(1);
		}
		var sendPackageKeyNum = $('#sendPackageKeyNum').val();
		if(sendPackageKeyNum == '') {
			$('#sendPackageKeyNum').val(0);
		}
		
		if("${viewType}" == 'update' || "${viewType}" == 'copy') {
			var sendPackageKeyNum = $('#sendPackageKeyNum').val();
			if(sendPackageKeyNum > 0) {
				$("#chkEssential").prop("checked", true);
			} else {
				$("#chkEssential").prop("checked", false);
				$('.sendPackageEssential').hide();
			}
		}
		var sendPackageStartDate = $('#sendPackageStartDateView').val();
		var sendPackageEndDate = $('#sendPackageEndDateView').val();
		if(sendPackageStartDate == "") {
			$('#sendPackageStartDateView').val(new Date().toISOString().slice(0, 10));
			
		}
		if(sendPackageEndDate == "") {
			$('#sendPackageEndDateView').val(new Date().toISOString().slice(0, 10));
		}
	});
	
	/* =========== 패키지 추가 ========= */
	function packagesInsert() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/insert'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result.result == "NotCustomerName") { // 고객사명 미 입력 시
					$('#NotCustomerName').show();
				} else {
					$('#NotCustomerName').hide();
				} 
	        	
				if(result.result == "OK") {
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
	};
	
	/* =========== 패키지 정보 수정 ========= */
	function packagesUpdate() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/update'/>",
            type: 'post',
            data: postData,
            async: false,
            success: function(result) {
				if(result.result == "OK") {
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
				
				if(result.result == "NotCustomerName") {  // 고객사명 미 입력 시
					$('#NotCustomerName').show();
				} else {
					$('#NotCustomerName').hide();
				}
			},
			error: function(error) {
				console.log(error);
			}
        });
	};
	
	/* =========== 패키지 복사 ========= */
	function packagesCopy() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/copy'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
	        	if(result.result == "NotCustomerName") { // 고객사명 미 입력 시
					$('#NotCustomerName').show();
	        		
				} else {
					$('#NotCustomerName').hide();
				} 
				
				if(result.result == "OK") {
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
	};
	
	/* =========== 직접입력 <--> 선택입력 변경 ========= */
	function selfInput(data) {
		if(data == "managementServerChange") {
			if($("#managementServerChange").text() == "직접입력") {
				$('#managementServerViewSelf').hide();
				$('#managementServerSelf').attr('type','text');
				$('#managementServerView').val('');
				$("#managementServerChange").text("선택입력");
			} else if($("#managementServerChange").text() == "선택입력") {
				$('#managementServerViewSelf').show();
				$('#managementServerSelf').attr('type','hidden');
				$('#managementServerSelf').val('');
				$("#managementServerChange").text("직접입력");
			}
		} else if (data == "generalCustomChange") {
			if($('#generalCustomChange').text() == "직접입력") {
				$('#generalCustomViewSelf').hide();
				$('#generalCustomSelf').attr('type','text');
				$('#generalCustomView').val('');
				$("#generalCustomChange").text("선택입력");
			} else if($('#generalCustomChange').text() == "선택입력") {
				$('#generalCustomViewSelf').show();
				$('#generalCustomSelf').attr('type','hidden');
				$('#generalCustomSelf').val('');
				$("#generalCustomChange").text("직접입력");
			}
		} else if (data == "agentVerChange") {
			if($('#agentVerChange').text() == "직접입력") {
				$('#agentVerViewSelf').hide();
				$('#agentVerSelf').attr('type','text');
				$('#agentVerView').val('');
				$("#agentVerChange").text("선택입력");
			} else if($('#agentVerChange').text() == "선택입력") {
				$('#agentVerViewSelf').show();
				$('#agentVerSelf').attr('type','hidden');
				$('#agentVerSelf').val('');
				$("#agentVerChange").text("직접입력");
			}
		} else if (data == "osTypeChange") {
			if($('#osTypeChange').text() == "직접입력") {
				$('#osTypeViewSelf').hide();
				$('#osTypeSelf').attr('type','text');
				$('#osTypeView').val('');
				$("#osTypeChange").text("선택입력");
			} else if($('#osTypeChange').text() == "선택입력") {
				$('#osTypeViewSelf').show();
				$('#osTypeSelf').attr('type','hidden');
				$('#osTypeSelf').val('');
				$("#osTypeChange").text("직접입력");
			}
		} else if (data == "agentOSChange") {
			if($('#agentOSChange').text() == "직접입력") {
				$('#agentOSViewSelf').hide();
				$('#agentOSSelf').attr('type','text');
				$('#agentOSView').val('');	
				$("#agentOSChange").text("선택입력");
			} else if($('#agentOSChange').text() == "선택입력") {
				$('#agentOSViewSelf').show();
				$('#agentOSSelf').attr('type','hidden');
				$('#agentOSSelf').val('');	
				$("#agentOSChange").text("직접입력");
			}
		} else if (data == "existingNewChange") {
			if($('#existingNewChange').text() == "직접입력") {
				$('#existingNewViewSelf').hide();
				$('#existingNewSelf').attr('type','text');
				$('#existingNewView').val('');
				$("#existingNewChange").text("선택입력");
			} else if($('#existingNewChange').text() == "선택입력") {
				$('#existingNewViewSelf').show();
				$('#existingNewSelf').attr('type','hidden');
				$('#existingNewSelf').val('');
				$("#existingNewChange").text("직접입력");
			}
		} else if (data == "requestProductCategoryChange") {
			if($('#requestProductCategoryChange').text() == "직접입력") {
				$('#requestProductCategoryViewSelf').hide();
				$('#requestProductCategorySelf').attr('type','text');
				$('#requestProductCategoryView').val('');
				$("#requestProductCategoryChange").text("선택입력");
			} else if($('#requestProductCategoryChange').text() == "선택입력") {
				$('#requestProductCategoryViewSelf').show();
				$('#requestProductCategorySelf').attr('type','hidden');
				$('#requestProductCategorySelf').val('');
				$("#requestProductCategoryChange").text("직접입력");
			}
		} else if (data == "deliveryMethodChange") {
			if($('#deliveryMethodChange').text() == "직접입력") {
				$('#deliveryMethodViewSelf').hide();
				$('#deliveryMethodSelf').attr('type','text');
				$('#deliveryMethodView').val('');	
				$("#deliveryMethodChange").text("선택입력");
			} else if($('#deliveryMethodChange').text() == "선택입력") {
				$('#deliveryMethodViewSelf').show();
				$('#deliveryMethodSelf').attr('type','hidden');
				$('#deliveryMethodSelf').val('');	
				$("#deliveryMethodChange").text("직접입력");
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
	
	
	$('#insertBtn').click(function() {
		 /* progressbar 정보 */
       var bar = $('.bar');
       var percent = $('.percent');
       var status = $('#status');
       
       var check = 1;
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		var customerNameView = $('#customerNameView').val();
		var businessNameView = $('#businessNameView').val();
		var networkClassificationView = $('#networkClassificationView').val();
		var managerView = $('#managerView').val();
		var requestDateView = $('#requestDateView').val();
		var managementServerView = $('#managementServerView').val();
		var sendPackageView = $('#sendPackageView')[0];
		
		if(customerNameView == '') {
			customerNameView = $('#customerNameSelf').val();
		}
		if(businessNameView == '') {
			businessNameView = $('#businessNameSelf').val();
		}
		if(managementServerView == '') {
			managementServerView = $('#managementServerSelf').val();
		}
		
		const postData = new FormData();
		
		postData.append('sendPackageView',sendPackageView.files[0]);
		postData.append('sendPackageStartDateView',sendPackageStartDateView);
		postData.append('sendPackageEndDateView',sendPackageEndDateView);
		postData.append('sendPackageLimitCountView',sendPackageLimitCountView);
		postData.append('customerNameView',customerNameView);
		postData.append('businessNameView',businessNameView);
		postData.append('networkClassificationView',networkClassificationView);
		postData.append('managerView',managerView);
		postData.append('requestDateView',requestDateView);
		postData.append('managementServerView',managementServerView);
		
		if ($('#chkEssential').is(":checked")) {
			if(sendPackageStartDateView>sendPackageEndDateView) {
				$('#PeriodSendPackageDate').show();
				check = 0;
			} else {
				$('#PeriodSendPackageDate').hide();
			}
			if(sendPackageStartDateView == "" || sendPackageEndDateView == "") {
				$('#NotSendPackageDate').show();
				check = 0;
			} else {
				$('#NotSendPackageDate').hide();
			}
			if(sendPackageLimitCountView < 1) {
				$('#NotSendPackageCount').show();
				check = 0;
			} else {
				$('#NotSendPackageCount').hide();
			}
			if(customerNameView == "") {
				$('#NotCustomerName').show();
				check = 0;
			} else {
				$('#NotCustomerName').hide();
			}
			if(check == 0) {
				return false;
			}
			
			if (sendPackageView.value == "") {  
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '파일을 업로드해주세요.',
				});
				$('#NotSendPackageView').show();
			 	return false;  
			} 
			$('#NotSendPackageView').hide();
		} else {
			packagesInsert();
			return;
		}
       
		$.ajax({
			xhr: function() {
	           var xhr = new window.XMLHttpRequest();
	           xhr.upload.addEventListener("progress", function(evt) {
	               if (evt.lengthComputable) {
	                   var percentComplete = Math.floor((evt.loaded / evt.total) * 100);
	
	                   var percentVal = percentComplete + '%';
	                   bar.width(percentVal);
	                   percent.html(percentVal);
	
	               }
	           }, false);
	           return xhr;
	       },
			url: "<c:url value='/sendPackage/insert'/>",
			type: 'post',
		    data: postData,
		    processData: false,
		    contentType: false,
		    beforeSend:function(){
	           // progress Modal 열기
	           $("#pleaseWaitDialog").modal('show');
	
	           status.empty();
	           var percentVal = '0%';
	           bar.width(percentVal);
	           percent.html(percentVal);
	
	       },
	       complete:function(){
	           // progress Modal 닫기
	           setTimeout(() => {
		           $("#pleaseWaitDialog").modal('hide');
		           packagesInsert();
	           } ,500);
	       },
		    success: function(result) {
				$('#sendPackageKeyNum').val(result.sendPackageKeyNum);
			}	
		});
	});
	
	$('#updateBtn').click(function() {
		var check = 1;
		var sendPackageKeyNum = $('#sendPackageKeyNum').val();
		var sendPackageRandomUrl = $('#sendPackageRandomUrl').val();
		var sendPackageCountView = $('#sendPackageCountView').val();
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		var customerNameView = $('#customerNameView').val();
		var businessNameView = $('#businessNameView').val();
		var networkClassificationView = $('#networkClassificationView').val();
		var managerView = $('#managerView').val();
		var requestDateView = $('#requestDateView').val();
		var managementServerView = $('#managementServerView').val();
		var existenceConfirmation;
		var sendPackageView = $('#sendPackageView')[0];
		
		if(sendPackageView.files[0] != null) {
			var sendPackageFileName = sendPackageView.files[0].name;
		}
		if(customerNameView == '') {
			customerNameView = $('#customerNameSelf').val();
		}
		if(businessNameView == '') {
			businessNameView = $('#businessNameSelf').val();
		}
		if(managementServerView == '') {
			managementServerView = $('#managementServerSelf').val();
		}
		
		const postData = new FormData();
		postData.append('sendPackageView',sendPackageView.files[0]);
		postData.append('sendPackageKeyNum',sendPackageKeyNum);
		postData.append('sendPackageRandomUrl',sendPackageRandomUrl);
		postData.append('sendPackageCountView',sendPackageCountView);
		postData.append('sendPackageStartDateView',sendPackageStartDateView);
		postData.append('sendPackageEndDateView',sendPackageEndDateView);
		postData.append('sendPackageLimitCountView',sendPackageLimitCountView);
		postData.append('customerNameView',customerNameView);
		postData.append('businessNameView',businessNameView);
		postData.append('networkClassificationView',networkClassificationView);
		postData.append('managerView',managerView);
		postData.append('requestDateView',requestDateView);
		postData.append('managementServerView',managementServerView);
		
		if ($('#chkEssential').is(":checked")) {
			if(sendPackageStartDateView>sendPackageEndDateView) {
				$('#PeriodSendPackageDate').show();
				check = 0;
			} else {
				$('#PeriodSendPackageDate').hide();
			}
			if(sendPackageStartDateView == "" || sendPackageEndDateView == "") {
				$('#NotSendPackageDate').show();
				check = 0;
			} else {
				$('#NotSendPackageDate').hide();
			}
			if(sendPackageLimitCountView < 1) {
				$('#NotSendPackageCount').show();
				check = 0;
			} else {
				$('#NotSendPackageCount').hide();
			}
			if(customerNameView == "") {
				$('#NotCustomerName').show();
				check = 0;
			} else {
				$('#NotCustomerName').hide();
			}
			if(check == 0) {
				return false;
			}
		} else {
			sendPackageUpdateInfo();
			packagesUpdate();
			return;
		}
		
		if(sendPackageView.files[0] == null && sendPackageKeyNum == 0) {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '패키지 기간 만료 또는 다운로드 초과 되어 기존 정보가 삭제되었습니다. 파일을 새로 등록 하여 사용바랍니다.',
			});
			return;
		}
		
		// 파일 존재 유무 확인
		$.ajax({
	        type: 'post',
	        url: "<c:url value='/sendPackage/existenceConfirmation'/>",
	        async: false,
	        //processData: false,
		    //contentType: false,
	        data: {"sendPackageFileName":sendPackageFileName+"_"+sendPackageRandomUrl},
	        success: function (data) {
	        	existenceConfirmation = data;
	        },
	    });
		
		// 동일한 이름의 파일이 존재할 경우 덮어쓰기 선택
		if(existenceConfirmation == "existence") {
			Swal.fire({
				  title: '덮어쓰기!',
				  text: "선택한 파일과 동일한 이름의 파일이 존재합니다. 덮어쓰기 하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
				if (result.isConfirmed) {
					sendPackageUpdate(postData);	// update
				}
			});
		} else {
			sendPackageUpdate(postData);		// update
		}
	});
	
	function sendPackageUpdate(postData) {
		/* progressbar 정보 */
		var bar = $('.bar');
		var percent = $('.percent');
		var status = $('#status');
		   
		$.ajax({
			xhr: function() {
		        var xhr = new window.XMLHttpRequest();
		        xhr.upload.addEventListener("progress", function(evt) {
		            if (evt.lengthComputable) {
		                var percentComplete = Math.floor((evt.loaded / evt.total) * 100);
	
		                var percentVal = percentComplete + '%';
		                bar.width(percentVal);
		                percent.html(percentVal);
	
		            }
		        }, false);
		        return xhr;
		    },
	        url: "<c:url value='/sendPackage/update'/>",
	        type: 'post',
	        data: postData,
	        processData: false,
		    contentType: false,
		    beforeSend:function(){
		        // progress Modal 열기
		        $("#pleaseWaitDialog").modal('show');
	
		        status.empty();
		        var percentVal = '0%';
		        bar.width(percentVal);
		        percent.html(percentVal);
	
		    },
		    complete:function(){
		    	setTimeout(() => {
		            // progress Modal 닫기
		            $("#pleaseWaitDialog").modal('hide');
		            packagesUpdate();
		    	}, 500);
		    },
	        success: function(result) {
	        	$('#sendPackageKeyNum').val(result.sendPackageKeyNum);
			},
			error: function(error) {
				console.log(error);
			}
	    });
	}
	
	function sendPackageUpdateInfo() {
		var sendPackageKeyNum = $('#sendPackageKeyNum').val();
		var customerNameView = $('#customerNameView').val();
		var businessNameView = $('#businessNameView').val();
		var networkClassificationView = $('#networkClassificationView').val();
		var managerView = $('#managerView').val();
		var requestDateView = $('#requestDateView').val();
		var managementServerView = $('#managementServerView').val();
		
		const postData = new FormData();
		postData.append('sendPackageKeyNum',sendPackageKeyNum);
		postData.append('customerNameView',customerNameView);
		postData.append('businessNameView',businessNameView);
		postData.append('networkClassificationView',networkClassificationView);
		postData.append('managerView',managerView);
		postData.append('requestDateView',requestDateView);
		postData.append('managementServerView',managementServerView);
		
		$.ajax({
	        type: 'POST',
	        url: "<c:url value='/sendPackage/updateInfo'/>",
	        data: postData,
	        async: false,
	        processData: false,
		    contentType: false,
	        success: function () {

	        },
	        error: function(e) {
	            // TODO 에러 화면
	        }
	    });	
	}
	
	
	$('#copyBtn').click(function() {
		var check = 1;
		var sendPackageRandomUrl = $('#sendPackageRandomUrl').val();
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		var customerNameView = $('#customerNameView').val();
		var businessNameView = $('#businessNameView').val();
		var networkClassificationView = $('#networkClassificationView').val();
		var managerView = $('#managerView').val();
		var requestDateView = $('#requestDateView').val();
		var managementServerView = $('#managementServerView').val();
		var existenceConfirmation;
		var sendPackageView = $('#sendPackageView')[0];
		
		if(customerNameView == '') {
			customerNameView = $('#customerNameSelf').val();
		}
		if(businessNameView == '') {
			businessNameView = $('#businessNameSelf').val();
		}
		if(managementServerView == '') {
			managementServerView = $('#managementServerSelf').val();
		}
		
		const postData = new FormData();
		postData.append('sendPackageView',sendPackageView.files[0]);
		postData.append('sendPackageRandomUrl',sendPackageRandomUrl);
		postData.append('sendPackageStartDateView',sendPackageStartDateView);
		postData.append('sendPackageEndDateView',sendPackageEndDateView);
		postData.append('sendPackageLimitCountView',sendPackageLimitCountView);
		postData.append('customerNameView',customerNameView);
		postData.append('businessNameView',businessNameView);
		postData.append('networkClassificationView',networkClassificationView);
		postData.append('managerView',managerView);
		postData.append('requestDateView',requestDateView);
		postData.append('managementServerView',managementServerView);
		
		if ($('#chkEssential').is(":checked")) {
			if(sendPackageStartDateView>sendPackageEndDateView) {
				$('#PeriodSendPackageDate').show();
				check = 0;
			} else {
				$('#PeriodSendPackageDate').hide();
			}
			if(sendPackageStartDateView == "" || sendPackageEndDateView == "") {
				$('#NotSendPackageDate').show();
				check = 0;
			} else {
				$('#NotSendPackageDate').hide();
			}
			if(sendPackageLimitCountView < 1) {
				$('#NotSendPackageCount').show();
				check = 0;
			} else {
				$('#NotSendPackageCount').hide();
			}
			if(customerNameView == "") {
				$('#NotCustomerName').show();
				check = 0;
			} else {
				$('#NotCustomerName').hide();
			}
			if(check == 0) {
				return false;
			}
			
			if (sendPackageView.value == "") {  
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '파일을 업로드해주세요.',
				});
				$('#NotSendPackageView').show();
			 	return false;  
			} 
			$('#NotSendPackageView').hide();
		} else {
			packagesCopy();
			return;
		}
		
		var sendPackageFileName = sendPackageView.files[0].name;
		// 파일 존재 유무 확인
		setTimeout(() => {
			$.ajax({
		        type: 'post',
		        url: "<c:url value='/sendPackage/existenceConfirmation'/>",
		        async: false,
		        //processData: false,
		        //contentType: false,
		        data: {"sendPackageFileName":sendPackageFileName},
		        success: function (data) {
		        	existenceConfirmation = data;
		        },
		    });
			// 동일한 이름의 파일이 존재할 경우 덮어쓰기 선택
			if(existenceConfirmation == "existence") {
				Swal.fire({
					  title: '덮어쓰기!',
					  text: "선택한 파일과 동일한 이름의 파일이 존재합니다. 덮어쓰기 하시겠습니까?",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#7066e0',
					  cancelButtonColor: '#FF99AB',
					  confirmButtonText: '예'
				}).then((result) => {
					if (result.isConfirmed) {
						copy(postData);	// insert
					} 
				});
			} else {
				copy(postData);		// insert
			}
		}, "100");
	});
	
	
	function copy(postData) {
		 /* progressbar 정보 */
        var bar = $('.bar');
        var percent = $('.percent');
        var status = $('#status');
        
		$.ajax({
			xhr: function() {
                var xhr = new window.XMLHttpRequest();
                xhr.upload.addEventListener("progress", function(evt) {
                    if (evt.lengthComputable) {
                        var percentComplete = Math.floor((evt.loaded / evt.total) * 100);

                        var percentVal = percentComplete + '%';
                        bar.width(percentVal);
                        percent.html(percentVal);

                    }
                }, false);
                return xhr;
            },
			url: "<c:url value='/sendPackage/copy'/>",
			type: 'post',
		    data: postData,
		    //async: false,
		    processData: false,
		    contentType: false,
		    beforeSend:function(){
                // progress Modal 열기
                $("#pleaseWaitDialog").modal('show');

                status.empty();
                var percentVal = '0%';
                bar.width(percentVal);
                percent.html(percentVal);

            },
            complete:function(){
            	setTimeout(() => {
	                // progress Modal 닫기
	                $("#pleaseWaitDialog").modal('hide');
	                packagesCopy();
            	}, 500);
            },
		    success: function(result) {

		    }	
		});
	}
	
	$('#chkEssential').change(function () {
		if ($(this).prop("checked")) {
			$('.sendPackageEssential').show();
        }
        else {
        	$('.sendPackageEssential').hide();
        }
	});
</script>
<style>
	.progress { position:relative; width:100%; border: 1px solid #ddd; padding: 1px; border-radius: 3px; color: black; }
	.bar { background-color: #337ab7; width:0%; height:30px; border-radius: 3px; }
	.percent { position:absolute; display:inline-block; top:1px; left:48%; }
</style>