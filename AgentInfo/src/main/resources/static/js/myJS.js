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
    
    if(size=='r') html += ' modal-r';
    if(size=='rs') html += ' modal-rs';
    html += '" role="document">';
    
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
    html += '		<div class="modal-content">';
    
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

