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
    if(size=='r') html += ' modal-r';
    html += '" role="document">';
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

