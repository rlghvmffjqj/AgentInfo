$.modal = function (modalContent, size) {

    $('#modal').remove();

    var html = '';
    html += '<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">';
    html += '	<div class="modal-dialog';
    if(size=='l')  html += ' modal-lg';
    if(size=='ls')  html += ' modal-ls';
    if(size=='ll')  html += ' modal-ll';
    if(size=='s')  html += ' modal-sm';
    if(size=='ss')  html += ' modal-ss';
    if(size=='sr')  html += ' modal-sr';
    if(size=='sl')  html += ' modal-sl';
    if(size=='se')  html += ' modal-se';
    if(size=='ssl') html += ' modal-ssl';
    if(size=='full') html += ' modal-full';
    if(size=='requests')  html += ' modal-requests';
    if(size=='notice')  html += ' modal-notice';
    if(size=='calendar')  html += ' modal-calendar';
    if(size=='serverCalendar')  html += ' modal-serverCalendar';
    if(size=='sendPackage') html += ' modal-sendPackage';
    if(size=='packages') html += ' modal-packages';
    if(size=='licenseConfirm') html += ' modal-licenseConfirm';
    if(size=='xmlImport') html += ' modal-xmlImport';
    if(size=='license5') html += ' modal-license5';
    if(size=='customerLicense') html += ' modal-customerLicense';
    if(size=='engineerUnassigned') html += ' modal-engineerUnassigned';
	if(size=='testCaseForm') html += ' modal-testCaseForm';
	if(size=='customerConsolidation') html += ' modal-customerConsolidation';
	if(size=='customerConsolidationSearch') html += ' modal-customerConsolidationSearch';
    
    
    if(size=='r') html += ' modal-r';
    if(size=='rs') html += ' modal-rs';
    html += '" role="document">';
    
    if(size=='customerConsolidation') {
	    html += '<div style="display: flex; width: 100%;">';
		html += 	'<button class="btn btn-sales btnm customerConsolidationActive" type="button" id="btnSales" onClick="btnSales();">';
		html += 		'<span>영업본부</span>';
		html += 	'</button>';
		html += 	'<button class="btn btn-security btnm" type="button" id="btnSecurity" onClick="btnSecurity();">';
		html += 		'<span>보안기술사업본부</span>';
        html += 	'</button>';
        html += 	'<button class="btn btn-evaluation btnm" type="button" id="btnEvaluation" onClick="btnEvaluation();">';
		html += 		'<span>평가 인증실</span>';
		html += 	'</button>';
        html += '</div>';
        html += '<div id="securitySub" style="height: 30px; background: white; display: flex; width: 100%; display: none;">';
        html +=     '<div class="btn-securitySub">';
        html +=     '</div>';
        html +=     '<div class="btn-securitySub">';
        html +=        '<button class="hoverBtn customerConsolidationActiveSub" id="defaultInfo" style="height: 30px; border: none; width: 50%; background: white;" onClick="defaultInfo();">사업기본정보</button>'
        html +=        '<button class="hoverBtn" id="licenseInfo" style="height: 30px; border: none; width: 50%; background: white; border-left: 1px solid #dbdbdb;" onClick="licenseInfo();">라이선스 발급 정보</button>'
        html +=     '</div>';
        html +=     '<div class="btn-securitySub">';
        html +=     '</div>';
        html += '</div>';
	} 

    if(size=='customerLicense') {
	    html += '<div style="display: flex; width: 100%;">';
		html += 	'<button class="btn btn-sales btnm customerManagentActive" type="button" id="btnSales">';
		html += 		'<span>영업본부</span>';
		html += 	'</button>';
		html += 	'<button class="btn btn-security btnm" type="button" id="btnSecurity">';
		html += 		'<span>보안기술사업본부</span>';
        html += 	'</button>';
        html += 	'<button class="btn btn-evaluation btnm" type="button" id="btnEvaluation">';
		html += 		'<span>평가 인증실</span>';
		html += 	'</button>';
        html += '</div>';
        html += '<div id="securitySub" style="height: 30px; background: white; display: flex; width: 100%; display: none;">';
        html +=     '<div class="btn-securitySub">';
        html +=     '</div>';
        html +=     '<div class="btn-securitySub">';
        html +=        '<button class="hoverBtn customerManagentActiveSub" id="defaultInfo" style="height: 30px; border: none; width: 50%; background: white;">사업기본정보</button>'
        html +=        '<button class="hoverBtn" id="licenseInfo" style="height: 30px; border: none; width: 50%; background: white; border-left: 1px solid #dbdbdb;">라이선스 발급 정보</button>'
        html +=     '</div>';
        html +=     '<div class="btn-securitySub">';
        html +=     '</div>';
        html += '</div>';
	} 
    
    if(size=='se') {
	    html += '<div style="display: flex; width: 30%; margin-bottom: -3px;">';
		html += 	'<button class="btn btn-customer btnm" type="button" id="btnCustomer">';
		html += 		'<span>고객사</span>';
		html += 	'</button>';
		html += 	'<button class="btn btn-product btnm" type="button" id="btnProduct">';
		html += 		'<span>제품</span>';
		html += 	'</button>';
		html += '</div>';
    }
    
     if(size=='license5') {
	    html += '<div style="display: flex; width: 100%; margin-bottom: -3px;">';
	    html += 	'<button class="btn btn-sales btnm customerManagentActive" type="button" style="height:40px;" id="btnOldLicense" onClick="btnOldLicense()">';
		html += 		'<span>(구)라이선스</span>';
		html += 	'</button>';
		html += 	'<button class="btn btn-sales btnm" type="button" style="height:40px;" id="btnNewLicense" onClick="btnNewLicense()">';
		html += 		'<span>(신)라이선스</span>';
		html += 	'</button>';
		html += '</div>';
    }
     
    if(size=='customerLicense') {
        html += '		<div class="modal-content" style="border-top: 1px solid #dbdbdb!important; border-radius: 0;">';
    } else {
        html += '		<div class="modal-content">';
    }
    
    html += modalContent;
    html += '		</div>';
    html += '	</div>';
    html += '</div>';

    $('#page-wrapper').append(html);

    $('#modal').modal({backdrop: 'static'}); // 모달 배경 눌러서 닫히는 동작 막음

    $('#modal').on('hidden.bs.modal', function (e) {
        $('#modal').remove();
    });
};

$.closeModal = function(fnCallback, param1, param2) {
    $('#modal').on('hidden.bs.modal', function (e) {
        $('#modal').remove();
        if(fnCallback) {
            fnCallback(param1, param2);
        }
    });
    $('#modal').modal('hide');
};

