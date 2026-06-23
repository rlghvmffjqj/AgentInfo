<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	input, filter-option-inner-inner {
		color: black !important;
	}
	
	input::placeholder,
	textarea::placeholder {
  		color: #989ba3 !important;
  		opacity: 1 !important;
	}
	
	.bootstrap-select .dropdown-toggle.bs-placeholder {
    	color: #989ba3 !important;
  		opacity: 1 !important;
	}
	
	.package-modal {
		width: 100%;
		max-height: 770px;
		padding: 0;
		background: #fff;
		border-radius: 10px;
		overflow: hidden;
		color: #172033;
		font-family: "Noto Sans KR", "Malgun Gothic", Arial, sans-serif;
	}

	.package-modal *,
	.package-modal *::before,
	.package-modal *::after {
		box-sizing: border-box;
	}

	.package-modal__header {
		display: flex;
		align-items: center;
		gap: 12px;
		padding: 22px 24px 12px;
	}

	.package-modal__title {
		margin: 0;
		font-size: 20px;
		font-weight: 700;
		color: #172033;
	}

	.package-modal__subtitle {
		font-size: 14px;
		font-weight: 500;
		color: #7b8798;
	}

	.package-modal__content {
		height: 770px;
		padding: 12px 24px 18px;
		overflow-y: auto;
	}

	.package-modal__grid {
		display: grid;
		grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
		gap: 18px;
	}

	.package-modal__column {
		display: flex;
		flex-direction: column;
		gap: 18px;
		min-width: 0;
	}

	.package-card{
	    background:#fff;
	    /* border:1px solid #eef2f7; */
	    border-radius:14px;
	    padding:26px;
	    box-shadow:
	        0 2px 6px rgba(16,24,40,.04),
	        0 12px 24px rgba(16,24,40,.05);
	    transition:.2s;
	}

	.package-card:hover{
	    box-shadow:
	        0 6px 12px rgba(16,24,40,.06),
	        0 20px 40px rgba(16,24,40,.08);
	}

	.package-card__title {
		display: flex;
		align-items: center;
		gap: 10px;
		margin: 0 0 20px;
		font-size: 16px;
		font-weight: 700;
		color: #172033;
	}

	.package-card__icon {
		width: 20px;
		height: 20px;
		color: #1f66e5;
		flex: 0 0 auto;
	}

	.package-form-grid {
		display: grid;
		grid-template-columns: repeat(2, minmax(0, 1fr));
		column-gap: 26px;
		row-gap: 18px;
	}

	.package-field {
		min-width: 0;
	}

	.package-field--full {
		grid-column: 1 / -1;
	}

	.package-field__head {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 8px;
		margin-bottom: 2px;
	}

	.package-field label,
	.package-field__label {
		margin: 0;
		margin-bottom: 2px;
		font-size: 13px;
		font-weight: 700;
		color: #172033;
	}

	.bootstrap-select > .dropdown-toggle.bs-placeholder, .bootstrap-select > .dropdown-toggle.bs-placeholder:hover {
		border: 1px solid gray;
	}

	.package-field .colorRed,
	.package-required {
		margin-left: 3px;
		color: #e32929;
		font-weight: 700;
	}

	.package-field .selfInput {
		font-size: 12px;
		font-weight: 600;
		color: #1f66e5;
		text-decoration: none;
	}

	.package-field .form-control,
	.package-field .bootstrap-select > .dropdown-toggle {
		/* width: 100% !important; */
		/* height: 45px; */
		/* min-height: 45px; */
		/* padding: 10px 14px; */
		border: 1px solid #d6dee9;
		border-radius: 6px;
		background-color: #fff;
		box-shadow: none;
		font-size: 12px;
		color: black;
		border-radius: 0px !important;

	}

	.package-field .form-control::placeholder {
		color: #8b97a8;
	}

	.package-field textarea.form-control {
		height: 72px;
		min-height: 72px;
		resize: vertical;
	}

	.package-date-range {
		display: grid;
		grid-template-columns: minmax(0, 1fr) auto minmax(0, 1fr) auto;
		align-items: center;
		gap: 10px;
	}

	.selectForm {
		border: none !important;
	}

	.package-date-presets {
		display: flex;
		justify-content: flex-end;
		gap: 5px;
		margin: -4px 0 8px;
	}

	.package-date-presets button {
		height: 28px;
		padding: 0 13px;
		border: 1px solid #d6dee9;
		border-radius: 6px;
		background: #f4f7fb;
		color: #344054;
		font-size: 12px;
		font-weight: 600;
	}
	
	.package-date-presets button:hover {
		background: #959595;
    	color: white;
	}

	.package-check {
		display: inline-flex;
		align-items: center;
		gap: 6px;
		white-space: nowrap;
		font-size: 13px;
		font-weight: 700;
		color: #25324a;
	}

	.package-help,
	.package-field span[id^="Not"],
	.package-field span[id^="Period"] {
		display: block;
		margin-top: 7px;
		font-size: 12px;
		line-height: 1.4;
	}

	.package-help {
		color: #7b8798;
	}

	.package-upload {
		position: relative;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		gap: 7px;
		min-height: 86px;
		border: 1px dashed #b8c5d8;
		border-radius: 8px;
		background: #fff;
		text-align: center;
		color: #172033;
	}

	.package-upload input[type="file"] {
		position: absolute;
		inset: 0;
		width: 100%;
		height: 100%;
		opacity: 0;
		cursor: pointer;
	}

	.package-upload__icon {
		width: 24px;
		height: 24px;
		color: #e5581f;
	}

	.package-upload__title {
		font-size: 14px;
		font-weight: 700;
	}

	.package-upload__desc {
		font-size: 12px;
		color: #7b8798;
	}

	.package-modal-footer {
		display: flex;
		justify-content: flex-end;
		gap: 5px;
		padding: 16px 24px;
		border-top: 1px solid #e5ebf2;
		background: #fff;
	}

	.package-modal-footer .btn {
		min-width: 104px;
		height: 46px;
		border-radius: 7px;
		font-size: 14px;
		font-weight: 700;
	}

	.package-modal-footer .btn-primary-save {
		border: 1px solid #1f66e5;
		background: white;
		color: #1f66e5;
	}

	.package-modal-footer .btn-cancel {
		border: 1px solid #d6dee9;
		background: #fff;
		color: #25324a;
	}

	@media (max-width: 1100px) {
		.package-modal__grid,
		.package-form-grid {
			grid-template-columns: 1fr;
		}

		.package-modal__content {
			height: auto;
			max-height: 90vh;
		}

		.package-date-range {
			grid-template-columns: 1fr;
		}
	}
</style>

<div class="modal-body package-modal">
	<form id="modalForm" name="form" method="post">
		<input type="hidden" id="packagesKeyNum" name="packagesKeyNum" class="form-control viewForm" value="${packages.packagesKeyNum}">
		<input type="hidden" id="packagesKeyNumOrigin" name="packagesKeyNumOrigin" class="form-control viewForm" value="${packages.packagesKeyNumOrigin}">
		<input type="hidden" id="sendPackageCountView" name="sendPackageCountView" class="form-control viewForm" value="${sendPackage.sendPackageCount}">
		<input type="hidden" id="sendPackageRandomUrl" name="sendPackageRandomUrl" class="form-control viewForm" value="${sendPackage.sendPackageRandomUrl}">

		<div class="package-modal__header">
			<h2 class="package-modal__title">패키지 배포</h2>
			<span class="package-modal__subtitle">패키지 정보를 입력해주세요.</span>
		</div>

		<div class="package-modal__content">
			<div class="package-modal__grid">
				<div class="package-modal__column">
					<section class="package-card">
						<h3 class="package-card__title">
							<svg class="package-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M16 4h2a2 2 0 0 1 2 2v14H4V6a2 2 0 0 1 2-2h2"/><rect x="8" y="2" width="8" height="4" rx="1"/></svg>
							기본 정보
						</h3>

						<div class="package-form-grid">
							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">고객사명<span class="package-required">*</span></span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="customerNameChange" onclick="selfInput('customerNameChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="customerNameSelf" name="customerNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="customerNameViewSelf">
									<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${customerName}">
											<option value="${item}" <c:if test="${item eq packages.customerName}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
								<span class="colorRed" id="NotCustomerName" style="display: none;">고객사명을 입력해주세요.</span>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">사업명</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="businessNameChange" onclick="selfInput('businessNameChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="businessNameSelf" name="businessNameSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="businessNameViewSelf">
									<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${businessName}">
											<option value="${item}" <c:if test="${item eq packages.businessName}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<label for="managerView">담당자</label>
								<input type="text" id="managerView" name="managerView" class="form-control viewForm" value="${packages.manager}" placeholder="입력해주세요">
							</div>

							<div class="package-field">
								<label for="networkClassificationView">망 구분</label>
								<input type="text" id="networkClassificationView" name="networkClassificationView" class="form-control viewForm" value="${packages.networkClassification}" placeholder="입력해주세요">
							</div>

							<div class="package-field">
								<label for="requestDateView">요청일자</label>
								<input type="date" id="requestDateView" name="requestDateView" class="form-control viewForm" value="${packages.requestDate}" max="9999-12-31">
							</div>

							<div class="package-field">
								<label for="deliveryDataView">전달일자</label>
								<input type="date" id="deliveryDataView" name="deliveryDataView" class="form-control viewForm" value="${packages.deliveryData}" max="9999-12-31">
							</div>
						</div>
					</section>

					<section class="package-card" style="height: 58%;">
						<h3 class="package-card__title">
							<svg class="package-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M8 6h13"/><path d="M8 12h13"/><path d="M8 18h13"/><rect x="3" y="4" width="2" height="2"/><rect x="3" y="10" width="2" height="2"/><rect x="3" y="16" width="2" height="2"/></svg>
							패키지 정보
						</h3>

						<div class="package-form-grid">
							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">패키지 종류</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="managementServerChange" onclick="selfInput('managementServerChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="managementServerSelf" name="managementServerSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="managementServerViewSelf">
									<select class="form-control selectpicker selectForm" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${managementServer}">
											<option value="${item}" ${fn:toLowerCase(fn:trim(item)) eq fn:toLowerCase(fn:trim(packages.managementServer)) ? 'selected="selected"' : ''}>${item}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">일반/커스텀</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="generalCustomChange" onclick="selfInput('generalCustomChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="generalCustomSelf" name="generalCustomSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="generalCustomViewSelf">
									<select class="form-control selectpicker selectForm" id="generalCustomView" name="generalCustomView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${generalCustom}">
											<option value="${item}" <c:if test="${item eq packages.generalCustom}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="package-field" style="margin-top: 18px; margin-bottom: 18px;">
							<label for="packageNameView">패키지명</label>
							<input type="text" id="packageNameView" name="packageNameView" class="form-control viewForm" value="${packages.packageName}" placeholder="패키지명을 입력해주세요">
						</div>
						<div class="package-field" style="margin-bottom: 18px;">
							<label for="osDetailVersionView">패키지 상세버전</label>
							<input type="text" id="osDetailVersionView" name="osDetailVersionView" class="form-control viewForm" value="${packages.osDetailVersion}" placeholder="상세 버전을 입력해주세요">
						</div>
						<div class="package-form-grid">
							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">Agent ver</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="agentVerChange" onclick="selfInput('agentVerChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="agentVerSelf" name="agentVerSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="agentVerViewSelf">
									<select class="form-control selectpicker selectForm" id="agentVerView" name="agentVerView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${agentVer}">
											<option value="${item}" <c:if test="${item eq packages.agentVer}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">Agent OS</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="agentOSChange" onclick="selfInput('agentOSChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="agentOSSelf" name="agentOSSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="agentOSViewSelf">
									<select class="form-control selectpicker selectForm" id="agentOSView" name="agentOSView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${agentOS}">
											<option value="${item}" <c:if test="${item eq packages.agentOS}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">OS종류</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="osTypeChange" onclick="selfInput('osTypeChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="osTypeSelf" name="osTypeSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="osTypeViewSelf">
									<select class="form-control selectpicker selectForm" id="osTypeView" name="osTypeView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${osType}">
											<option value="${item}" <c:if test="${item eq packages.osType}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</section>
				</div>

				<div class="package-modal__column">
					<section class="package-card">
						<h3 class="package-card__title">
							<svg class="package-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
							배포 정책
						</h3>

						<div class="package-form-grid">
							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">기존/신규</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="existingNewChange" onclick="selfInput('existingNewChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="existingNewSelf" name="existingNewSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="existingNewViewSelf">
									<select class="form-control selectpicker selectForm" id="existingNewView" name="existingNewView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${existingNew}">
											<option value="${item}" <c:if test="${item eq packages.existingNew}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">요청 제품 구분</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="requestProductCategoryChange" onclick="selfInput('requestProductCategoryChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="requestProductCategorySelf" name="requestProductCategorySelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="requestProductCategoryViewSelf">
									<select class="form-control selectpicker selectForm" id="requestProductCategoryView" name="requestProductCategoryView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${requestProductCategory}">
											<option value="${item}" <c:if test="${item eq packages.requestProductCategory}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">전달 방법</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="deliveryMethodChange" onclick="selfInput('deliveryMethodChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="deliveryMethodSelf" name="deliveryMethodSelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="deliveryMethodViewSelf">
									<select class="form-control selectpicker selectForm" id="deliveryMethodView" name="deliveryMethodView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${deliveryMethod}">
											<option value="${item}" <c:if test="${item eq packages.deliveryMethod}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field">
								<div class="package-field__head">
									<span class="package-field__label">구매구분</span>
									<c:if test="${viewType ne 'im'}"><a href="#" class="selfInput" id="purchaseCategoryChange" onclick="selfInput('purchaseCategoryChange');">직접입력</a></c:if>
								</div>
								<input type="hidden" id="purchaseCategorySelf" name="purchaseCategorySelf" class="form-control viewForm" placeholder="직접입력" value="">
								<div id="purchaseCategoryViewSelf">
									<select class="form-control selectpicker selectForm" id="purchaseCategoryView" name="purchaseCategoryView" data-live-search="true" data-size="5" title="선택해주세요">
										<option value=""></option>
										<c:forEach var="item" items="${purchaseCategory}">
											<option value="${item}" <c:if test="${item eq packages.purchaseCategory}">selected</c:if>><c:out value="${item}"/></option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="package-field package-field--full">
								<label for="noteView">비고</label>
								<textarea id="noteView" name="noteView" class="form-control viewForm" placeholder="비고를 입력해주세요 (선택)">${packages.note}</textarea>
							</div>
						</div>
					</section>

					<section class="package-card">
						<div style="float: right;">
	         				<input class="cssCheck" type="checkbox" id="chkEssential">
			 				<label for="chkEssential"></label><span class="margin17">필수</span>
			 			</div>
						<h3 class="package-card__title">
							<svg class="package-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21.44 11.05 12.25 20.24a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"/></svg>
							첨부 파일
						</h3>

						<div class="package-field">
							<label for="sendPackageView">패키지 파일<span class="package-required sendPackageEssential">*</span></label>
							<div class="package-upload">
								<svg class="package-upload__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3v12"/><path d="m7 8 5-5 5 5"/><path d="M5 21h14"/></svg>
								<div class="package-upload__title">파일을 드래그하거나 클릭하여 업로드</div>
								<div class="package-upload__desc">패키지 파일을 업로드 바랍니다.</div>
								<input type="file" name="sendPackageView" id="sendPackageView" multiple>
							</div>
							<span class="colorRed" id="NotSendPackageView" style="display: none;">패키지를 등록해주세요.</span>
							<c:if test="${viewType eq 'update' || viewType eq 'im'}">
								<span class="package-help">패키지를 변경할 경우에만 파일을 선택해주세요.</span>
							</c:if>
						</div>

						<div class="package-field package-field--full" style="margin-top: 10px">
								<div class="package-field__head">
									<span class="package-field__label">다운로드 가능기간<label class="colorRed sendPackageEssential">*</label></span>
									<div class="package-date-presets">
										<button type="button" data-days="0">오늘</button>
										<button type="button" data-days="7">7일</button>
										<button type="button" data-days="30">30일</button>
										<button type="button" data-days="90">90일</button>
									</div>
								</div>
								<div class="package-date-range">
									<input type="text" class="form-control viewForm" id="sendPackageStartDateView" name="sendPackageStartDateView" value="${sendPackage.sendPackageStartDate}" max="9999-12-31" placeholder="시작일 선택">
									<span>~</span>
									<input type="text" id="sendPackageEndDateView" name="sendPackageEndDateView" class="form-control viewForm" value="${sendPackage.sendPackageEndDate}" max="9999-12-31" placeholder="종료일 선택">
									<label class="package-check">
								</div>
								<span class="colorRed" id="NotSendPackageDate" style="display: none;">다운로드 기간을 입력해주세요.</span>
								<span class="colorRed" id="PeriodSendPackageDate" style="display: none;">시작 기간은 종료 기간보다 늦을 수 없습니다.</span>
							</div>

							<div class="package-field package-field--full" style="padding-top: 10px">
								<!-- <label for="sendPackageLimitCountView" style="margin-top: 2px;">최대 다운로드 횟수</label> -->
								<span class="package-field__label">최대 다운로드 횟수</span><label class="colorRed sendPackageEssential">*</label>
								<c:choose>
									<c:when test="${viewType eq 'insert'}">
										<input type="number" id="sendPackageLimitCountView" name="sendPackageLimitCountView" class="form-control viewForm" value="1" style="margin-top: 5px;">
									</c:when>
									<c:when test="${viewType eq 'update' || viewType eq 'im' || viewType eq 'copy'}">
										<input type="number" id="sendPackageLimitCountView" name="sendPackageLimitCountView" class="form-control viewForm" value="${sendPackage.sendPackageLimitCount}" style="margin-top: 5px;">
									</c:when>
								</c:choose>
								<span class="package-help">숫자만 입력 가능합니다.</span>
								<span class="colorRed" id="NotSendPackageCount" style="display: none;">1 이상의 값을 입력해주세요.</span>
							</div>
					</section>
				</div>
			</div>
		</div>
	</form>
</div>

<div class="modal-footer package-modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-outline-info-add" id="insertBtn">저장</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-primary-save" id="updateBtn">저장</button>
		</c:when>
		<c:when test="${viewType eq 'copy'}">
			<button class="btn btn-primary-save" id="copyBtn">저장</button>
		</c:when>
	</c:choose>
	<button class="btn btn-outline-info-nomal" data-dismiss="modal">닫기</button>
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

		if("${viewType}" == 'insert') {
			$("#chkEssential").prop("checked", false);
			$('.sendPackageEssential').hide();
		}
		
		if("${viewType}" == 'update') {
			$.ajax({
		        type: 'post',
		        url: "<c:url value='/sendPackage/packagesCount'/>",
		        async: false,
		        data: {"packagesKeyNum":$('#packagesKeyNum').val()},
		        success: function (data) {
		        	if(data == 0) {
		        		$("#chkEssential").prop("checked", false);
						$('.sendPackageEssential').hide();
		        	}
		        },
		    });
		}
		
		var sendPackageStartDate = $('#sendPackageStartDateView').val();
		var sendPackageEndDate = $('#sendPackageEndDateView').val();
		if(sendPackageStartDate == "") {
			$('#sendPackageStartDateView').val(new Date().toISOString().slice(0, 10));
			
		}
		if(sendPackageEndDate == "") {
			$('#sendPackageEndDateView').val(new Date().toISOString().slice(0, 10));
		}

		function formatDate(date) {
		    const yyyy = date.getFullYear();
		    const MM = String(date.getMonth() + 1).padStart(2, "0");
		    const dd = String(date.getDate()).padStart(2, "0");

		    return yyyy+"-"+MM+"-"+dd;
		}

		$(".package-date-presets button").on("click", function () {
		    const days = Number($(this).data("days"));
		
		    const startDate = new Date(); // 오늘
		    const endDate = new Date();
		
		    endDate.setDate(startDate.getDate() + days);
		
		    $("#sendPackageStartDateView").val(formatDate(startDate));
		    $("#sendPackageEndDateView").val(formatDate(endDate));
		});
		
	});
	
	
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
		} else if (data == "purchaseCategoryChange") {
			if($('#purchaseCategoryChange').text() == "직접입력") {
				$('#purchaseCategoryViewSelf').hide();
				$('#purchaseCategorySelf').attr('type','text');
				$('#purchaseCategoryView').val('');	
				$("#purchaseCategoryChange").text("선택입력");
			} else if($('#purchaseCategoryChange').text() == "선택입력") {
				$('#purchaseCategoryViewSelf').show();
				$('#purchaseCategorySelf').attr('type','hidden');
				$('#purchaseCategorySelf').val('');	
				$("#purchaseCategoryChange").text("직접입력");
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

		var selectedValue = $(this).val();

		$.ajax({
	        url: "<c:url value='/packages/selectManager'/>",
	        type: "post",
	        dataType: "text",
	        data: { "manager": selectedValue },
	        success: function(result) {
	            $("#managerView").val(result);
	        }
	    });
	});
	
	
	$('#insertBtn').click(function() {
		var check = 1;
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		var customerNameView = $('#customerNameView').val();
		var managementServerView = $('#managementServerView').val();
		var sendPackageView = $('#sendPackageView')[0];
		
		// 고객사명 유효성검사
		if(customerNameView == "" && $('#customerNameSelf').val() == "") {
			$('#NotCustomerName').show();
			return false;
		} else {
			$('#NotCustomerName').hide();
		}
		
		// 패키지 전송 유효성 검사
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
		}
		
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
					if ($('#chkEssential').is(":checked")) {
						$('#packagesKeyNum').val(result.packagesKeyNum);
						sendPackageInsert();
					} else {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$('#modal').modal("hide"); // 모달 닫기
		        		$('#modal').on('hidden.bs.modal', function () {
		        			tableRefresh();
		        		});
					}
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
	});
	
	function sendPackageInsert() {
		/* progressbar 정보 */
	    var bar = $('.bar');
	    var percent = $('.percent');
	    var status = $('#status');
	       
		const postData = new FormData($('#modalForm')[0]);
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
			enctype: 'multipart/form-data',
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
	        	Swal.fire({
					icon: 'success',
					title: '성공!',
					text: '작업을 완료했습니다.',
				});
	        	setTimeout(() => {
				    $("#pleaseWaitDialog").modal('hide');
				    $('#modal').modal("hide");
				    $('#modal').on('hidden.bs.modal', function () {
			        	tableRefresh();
					});
	        	}, 500);
	       }
		});
	}
	
	$('#updateBtn').click(function() {
		var check = 1;
		var sendPackageRandomUrl = $('#sendPackageRandomUrl').val();
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		var customerNameView = $('#customerNameView').val();
		var managementServerView = $('#managementServerView').val();
		var existenceConfirmation;
		var sendPackageView = $('#sendPackageView')[0];
		
		if(sendPackageView.files[0] != null) {
			var sendPackageFileName = sendPackageView.files[0].name;
		}
		
		const postData = new FormData($('#modalForm')[0]);
		
		if(customerNameView == "" && $('#customerNameSelf').val() == "") {
			$('#NotCustomerName').show();
			return false;
		} else {
			$('#NotCustomerName').hide();
		}
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
			if(check == 0) {
				return false;
			}
			
			var result = false;
			if(sendPackageView.files[0] == null) {			
				$.ajax({
			        type: 'post',
			        url: "<c:url value='/sendPackage/packagesCount'/>",
			        async: false,
			        data: {"packagesKeyNum":$('#packagesKeyNum').val()},
			        success: function (data) {
			        	if(data == 0) {
				        	Swal.fire({
				        		icon: 'error',
				        		title: '실패!',
				        		text: '패키지 기간 만료 또는 다운로드 초과 되어 기존 정보가 삭제되었습니다. 파일을 새로 등록 하여 사용바랍니다.',
				        	});
			        		result = true;	
			        	}
			        },
			    });
			}
			if(result)
				return false;
			
			// 파일 존재 유무 확인
			$.ajax({
		        type: 'post',
		        url: "<c:url value='/sendPackage/existenceConfirmation'/>",
		        async: false,
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
					  confirmButtonText: 'OK'
				}).then((result) => {
					if (result.isConfirmed) {
						packagesUpdate();	// 덮어쓰기 선택한 경우
					}
				});
			} else {
				packagesUpdate();	// 동일한 파일이 존재하지 않는 경우
			}
		} else {
			packagesUpdate();	// 체크박스 체크되어있지 않은 경우
		}
	});
		
	function packagesUpdate() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/packages/update'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result.result == "OK") {
					if ($('#chkEssential').is(":checked")) {
						sendPackageUpdate();
					} else {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$('#modal').modal("hide"); // 모달 닫기
	            		$('#modal').on('hidden.bs.modal', function () {
	            			tableRefresh();
	            		});
					}
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
		
	function sendPackageUpdate() {
		/* progressbar 정보 */
		var bar = $('.bar');
		var percent = $('.percent');
		var status = $('#status');
		const postData = new FormData($('#modalForm')[0]);
		   
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
	        url: "<c:url value='/sendPackage/packagesUpdate'/>",
	        enctype: 'multipart/form-data',
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
		    	Swal.fire({
					icon: 'success',
					title: '성공!',
					text: '작업을 완료했습니다.',
				});
		    	setTimeout(() => {
			    	$("#pleaseWaitDialog").modal('hide');
					$('#modal').modal("hide");
					$('#modal').on('hidden.bs.modal', function () {
				     	tableRefresh();
					});
		    	}, 500);
		    },
			error: function(error) {
				console.log(error);
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
		var existenceConfirmation;
		var sendPackageView = $('#sendPackageView')[0];
		
		if(customerNameView == "" && $('#customerNameSelf').val() == "") {
			$('#NotCustomerName').show();
			return false;
		} else {
			$('#NotCustomerName').hide();
		}
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
			
			var sendPackageFileName = sendPackageView.files[0].name;
			// 파일 존재 유무 확인
			$.ajax({
			    type: 'post',
			    url: "<c:url value='/sendPackage/existenceConfirmation'/>",
			    async: false,
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
					  confirmButtonText: 'OK'
				}).then((result) => {
					if (result.isConfirmed) {
						packagesCopy();	// insert
					} 
				});
			} else {
				packagesCopy();		// insert
			}
		} else {
			packagesCopy();
		}
	});
	
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
					if ($('#chkEssential').is(":checked")) {
						$('#packagesKeyNum').val(result.packagesKeyNum);
						$('#sendPackageRandomUrl').val(result.sendPackageRandomUrl);
						if ($('#chkEssential').is(":checked")) {
							sendPackageCopy();
						}
					} else {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
						$("#pleaseWaitDialog").modal('hide');
						$('#modal').modal("hide");
						$('#modal').on('hidden.bs.modal', function () {
					    	tableRefresh();
						});
					}
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
	
	
	function sendPackageCopy() {
		 /* progressbar 정보 */
        var bar = $('.bar');
        var percent = $('.percent');
        var status = $('#status');
        
        const postData = new FormData($('#modalForm')[0]);
        
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
			enctype: 'multipart/form-data',
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
            	Swal.fire({
					icon: 'success',
					title: '성공!',
					text: '작업을 완료했습니다.',
				});
            	setTimeout(() => {
			        $("#pleaseWaitDialog").modal('hide');
			        $('#modal').modal("hide");
			        $('#modal').on('hidden.bs.modal', function () {
		        		tableRefresh();
					});
            	}, 500);
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