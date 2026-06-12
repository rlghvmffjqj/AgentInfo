<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="modal-body" style="width: 100%; height: 810px; overflow-y: scroll;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="workManageKeyNum" name="workManageKeyNum" class="form-control viewForm" value="${workManage.workManageKeyNum}">
		<div style="display: flow-root; padding-bottom: 10px;">
			<div class="pading5Width33">
				<div>
					<label class="labelFontSize" style="float: left;">고객사</label><label class="colorRed" style="float: left;">*</label>
				 	<select class="form-control selectpicker selectForm" id="workManageCustomerView" name="workManageCustomerView" data-live-search="true" data-size="5">
				 		<option value=""></option>
						<c:forEach var="item" items="${workManageCustomer}">
							<option value="${item}" <c:if test="${item eq workManage.workManageCustomer}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
				<span class="colorRed" id="NotWorkManageCustomer" style="display: none; line-height: initial;">고객사명을 입력해주세요.</span>
			 </div>
			 <div class="pading5Width33">
				<div>
			 		<label class="labelFontSize">엔지니어</label>
					<input type="text" id="workManageEngineerView" name="workManageEngineerView" class="form-control viewForm" value="${workManage.workManageEngineer}">
				</div>
			</div>
			<div class="pading5Width33">
				<label class="labelFontSize">요청구분</label>
				<div>
					<select class="form-control selectpicker" id="workManageDivisionView" name="workManageDivisionView" data-size="5" data-actions-box="true">
						<option value="이메일" <c:if test="${'이메일' eq workManage.workManageDivision}">selected</c:if>>이메일</option>
						<option value="전화" <c:if test="${'전화' eq workManage.workManageDivision}">selected</c:if>>전화</option>
						<option value="방문" <c:if test="${'방문' eq workManage.workManageDivision}">selected</c:if>>방문</option>
					</select>
				</div>
			</div>
			<div class="pading5Width33">
				<div>
					<label class="labelFontSize">요청일자</label>
	    		    <input type="date" id="workManageRequestDateView" name="workManageRequestDateView" class="form-control viewForm" value="${workManage.workManageRequestDate}" max="9999-12-31">
				</div>
			</div>
			<div class="pading5Width33">
				<div>
					<label class="labelFontSize">희망 완료일자</label>
	    		    <input type="date" id="workManageCompleteDateView" name="workManageCompleteDateView" class="form-control viewForm" value="${workManage.workManageRequestDate}" max="9999-12-31">
				</div>
			</div>
		</div>

		<div style="padding-bottom: 10px; border-top: 1px solid #d17c7c;">
		    <!-- 추가 버튼 -->
			<div style="margin: 10px 0;">
			    <button type="button" id="addProductBtn" class="btn btn-primary" style="border-radius: 25px !important; background: #3473ff;">+ 제품유형 추가</button>
				<button type="button" id="delProductBtn" class="btn btn-danger" style="border-radius: 25px !important; background: #ff5252;">- 제품유형 삭제</button>
			</div>

			<!-- 제품유형 영역 -->
			<div>
			    <!-- 기본 1개 -->
			    <div class="packageItem" style="display: flow-root; margin-bottom: 15px; border-bottom: 1px dashed #ccc; padding-bottom: 15px; height: 90px;">
			        <div class="packageRow">
					
			            <!-- [주의] 기존 pading5Width33의 width: 200px 스타일은 건드리지 않고 그대로 유지합니다 -->
			            <div class="pading5Width33" style="width: 150px;">
						
			                <!-- [상단] 제품유형 라벨 -->
			                <div>
			                    <label class="labelFontSize">제품유형</label>
			                </div>
						
			                <div class="fields-container" style="display: flex; gap: 15px; width: max-content;">
							
			                    <!-- 최초 1개 입력 폼 세트 -->
			                    <div class="field-item" style="width: 150px; flex-shrink: 0;">
			                        <!-- 제품유형 선택 -->
			                        <div>
			                            <select class="form-control selectpicker selectForm productType" name="workManageProductTypeView[]" data-live-search="true" data-size="5">
			                                <option value=""></option>
			                                <c:forEach var="item" items="${workManageProductType}">
			                                    <option value="${item}">
			                                        <c:out value="${item}"/>
			                                    </option>
			                                </c:forEach>
			                            </select>
			                        </div>
								
			                        <!-- [하단] 있어 보이는 인라인 수량 입력창 (라벨 삭제) -->
			                        <div class="premiumQuantityBox" style="margin-top: 5px;">
			                            <input type="number" class="form-control premiumCount" name="workManageProductTypeCountView[]" min="0" placeholder="0">
			                            <span class="qtyUnit">개</span>
			                        </div>
			                    </div>
							
			                </div>
						
			            </div>
					
			        </div>
			    </div>
			</div>

		</div>

		<div style="padding-bottom: 10px; border-top: 1px solid #d17c7c;">
		    <!-- 추가 버튼 -->
		    <div style="margin: 10px 0;">
		        <button type="button" id="addPackageBtn" class="btn btn-primary" style="border-radius: 25px !important; background: #3473ff;">+ 패키지 추가</button>
		    </div>
		
		    <!-- 패키지 영역 -->
		    <div id="packageArea">
			
		        <!-- 기본 1개 -->
		        <div class="packageItem" style="display: flow-root; margin-bottom: 15px; border-bottom: 1px dashed #ccc; padding-bottom: 10px;">
					<div class="packageRow">
		            	<div class="pading5Width33 packageHeight" style="width: 66%;">
		            	    <div>
		            	        <label class="labelFontSize">패키지명</label>
		            	        <input type="text" name="workManagePackageNameView[]" class="form-control viewForm">
		            	    </div>
		            	</div>
					
		            	<div class="pading5Width33 packageHeight">
		            	    <div class="packageFile">
		            	        <input type="file" name="workManagePackageFileView[]" hidden class="packageFileInput">
								<input type="hidden" name="workManagePackageFileNameView[]" class="packageFileNameInput">
		            	        <div style="width: 65px; height:12px">
									<label class="workManagePackageSizeView">0MB</label>
								</div>
		            	        <sec:authorize access="hasRole('ADMIN')">
									<button type="button" class="package-upload-btn">패키지 선택</button>
								</sec:authorize>
								<button type="button" class="package-download-btn packageDownLoadBtn" style="display: none;">다운로드</button>
								<sec:authorize access="hasRole('ADMIN')">
		            	        	<button type="button" class="package-delete-btn">제거</button>
								</sec:authorize>
		            	    </div>
		            	</div>
					</div>
		        </div>
		    </div>
		</div>
		<div style="border-top: 1px solid #d17c7c; padding-top: 10px;">
			<div class="pading5Width33">
				<div>
					<label class="labelFontSize">테스터</label>
	    		    <input type="text" id="workManageTesterView" name="workManageTesterView" class="form-control viewForm" value="${workManage.workManageTester}" placeholder="김기호, 박범수, 이상민">
				</div>
			</div>
			<div class="pading5Width33">
				<label class="labelFontSize">진행상태</label>
				<div>
					<sec:authorize access="!hasRole('ADMIN')">
					    <input type="hidden" name="workManageProgressStatusView" value="${workManage.workManageProgressStatus}" />
					</sec:authorize>
					<select class="form-control selectpicker"
						id="workManageProgressStatusView"
						name="workManageProgressStatusView"
						data-size="5"
						data-actions-box="true"
						<sec:authorize access="!hasRole('ADMIN')">disabled="disabled"</sec:authorize>>
						<option value="진행중" <c:if test="${'진행중' eq workManage.workManageProgressStatus}">selected</c:if>>진행중</option>
						<option value="보류" <c:if test="${'보류' eq workManage.workManageProgressStatus}">selected</c:if>>보류</option>
						<option value="완료" <c:if test="${'완료' eq workManage.workManageProgressStatus}">selected</c:if>>완료</option>
						<option value="미처리 완료" <c:if test="${'미처리 완료' eq workManage.workManageProgressStatus}">selected</c:if>>미처리 완료</option>
					</select>
				</div>
			</div>
			<div class="pading5Width33">
				<div class="percent-wrap" style="width: 100%;">
					<label class="labelFontSize">진행률</label>
	    		    <input type="number" id="workManageProgressView" name="workManageProgressView" class="form-control viewForm" min="0" max="100" value="${workManage.workManageProgress}" style="text-align: right; font-weight: bold; <sec:authorize access="!hasRole('ADMIN')">background: #e9ecefb5 !important;</sec:authorize>" <sec:authorize access="!hasRole('ADMIN')">readonly="readonly";</sec:authorize>>
					<span style="top: 65%;">%</span>
				</div>
			</div>
			<div class="pading5Width33">
				<label class="labelFontSize">테스트일정</label>
				<div style="display: ruby-text;">
	    		    <input type="date" id="workManageTestScheduleStart" name="workManageTestScheduleStart" class="form-control viewForm" value="${workManage.workManageTestScheduleStart}" max="9999-12-31">
					~
					<input type="date" id="workManageTestScheduleEnd" name="workManageTestScheduleEnd" class="form-control viewForm" value="${workManage.workManageTestScheduleEnd}" max="9999-12-31">
				</div>
			</div>
			<div class="pading5Width33" style="width: 100%;">
				<div>
					<label class="labelFontSize">한줄설명</label>
	    		    <input type="text" id="workManageOneLineView" name="workManageOneLineView" class="form-control viewForm" value="${workManage.workManageOneLine}" placeholder="주간 업무 작성을위한 한줄 설명 간략하게 입력바랍니다.">
				</div>
			</div>
			<div class="pading5Width33" style="width: 100%;">
	    		<label class="labelFontSize">상세 내용</label>
	    		<textarea class="form-control" id="workManageDetailNoteView" name="workManageDetailNoteView" spellcheck="false" placeholder="이슈내용 또는 테스트 내용 상세히 입력 바랍니다." style="resize: none;">${workManage.workManageDetailNote}</textarea>
			</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<c:choose>
		<c:when test="${viewType eq 'insert'}">
			<button class="btn btn-default btn-outline-info-add" id="insertBtn" style="border-radius: 25px !important;">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateBtn" style="border-radius: 25px !important;">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal" style="border-radius: 25px !important;">닫기</button>
    
</div>

<!-- progress Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="margin-top: 20%;">
        <div class="modal-content" style="border:1px solid !important; width: 95%; margin-left: 3%;">
            <div class="modal-header" style="background: burlywood;">
                <h3 style="font-weight: bold; font-family: none; color: white;">파일 업로드 중 ...</h3>
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
	$(document).ready(function () {
		const isAdmin = <sec:authorize access="hasRole('ADMIN')">true</sec:authorize><sec:authorize access="!hasRole('ADMIN')">false</sec:authorize>;
	    // 패키지 추가
	    $("#addPackageBtn").on("click", function () {
	        var html = '';

	        html += '<div class="packageItem" style="display: flow-root; margin-bottom: 15px; border-bottom: 1px dashed #ccc; padding-bottom: 10px;">';
			html += '<div class="packageRow">'

	        // 패키지명
	        html += '    <div class="pading5Width33 packageHeight" style="width: 66%;">';
	        html += '        <div>';
	        html += '            <label class="labelFontSize">패키지명</label>';

	        html += '            <input type="text" name="workManagePackageNameView[]" class="form-control viewForm">';
	        html += '        </div>';
	        html += '    </div>';

	        // 파일
	        html += '    <div class="pading5Width33 packageHeight">';
	        html += '        <div class="packageFile">';

	        html += '            <input type="file" name="workManagePackageFileView[]" hidden class="packageFileInput">';

	        html += '            <div style="width: 65px; height: 12px">';
	        html += '                <label class="workManagePackageSizeView">0MB</label>';
	        html += '            </div>';

			if (isAdmin) {
	        	html += '            <button type="button" class="package-upload-btn">패키지 선택</button>';
	        	html += '            <button type="button" class="package-delete-btn">제거</button>';
			}
	        html += '        </div>';
	        html += '    </div>';

			html += '</div>';
	        html += '</div>';

	        $("#packageArea").append(html);
	        $('.selectpicker').selectpicker('refresh');
	    });

		$(document).on("change", "#workManageCompleteDateView", function() {
    	    // 현재 입력되거나 선택된 날짜 값을 가져옵니다.
    	    var selectedDate = $(this).val();
			
    	    // 2. 테스트 종료일(workManageTestScheduleEnd)의 값을 동일하게 변경합니다.
    	    $("#workManageTestScheduleEnd").val(selectedDate);
    	});


	    // 파일 선택 버튼
	    // .off("click")을 추가하여 중복 등록된 기존 이벤트를 먼저 지워줍니다.
		$(document).off("click", ".package-upload-btn").on("click", ".package-upload-btn", function () {
		    const packageRow = $(this).closest(".packageRow");
		   
		    packageRow.find(".packageFileInput").click();
		});


		$(document).on("change", ".packageFileInput", function () {
		    const packageRow = $(this).closest(".packageRow");
		    const file = this.files[0];

		    if (!file) {
		        return;
		    }
		
		    // 파일명
		    const fileName = file.name;
		
		    // 패키지명 입력
		    packageRow
		        .find("input[name='workManagePackageNameView[]']")
		        .val(fileName);
		
		    // 파일 크기 계산
		    const fileSize = file.size;
		
		    let sizeText = "";
		
		    if (fileSize >= 1024 * 1024 * 1024) {
		        sizeText = (fileSize / (1024 * 1024 * 1024)).toFixed(2) + "GB";
			
		    } else if (fileSize >= 1024 * 1024) {
		        sizeText = (fileSize / (1024 * 1024)).toFixed(2) + "MB";
		    } else if (fileSize >= 1024) {
		        sizeText = (fileSize / 1024).toFixed(2) + "KB";
		    } else {
		        sizeText = fileSize + "B";
		    }
		
		    // 라벨 표시
		    packageRow
		        .find(".workManagePackageSizeView")
		        .text(sizeText);
		});


	    // 패키지 제거
	    $(document).on("click", ".package-delete-btn", function () {
			Swal.fire({
				  title: '삭제!',
				  text: "선택한 작업를 삭제하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: 'OK'
			}).then((result) => {
	        	$(this)
	        	    .closest(".packageItem")
	        	    .remove();
			});
	    });

	});

	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
	
	/* =========== 추가 ========= */
	$('#insertBtn').click(function () {
		if($('#workManageCustomerView').val() == "") {
			$('#NotWorkManageCustomer').show();
			Swal.fire({
	            icon: 'error',
	            title: '실패!',
	            text: '필수 값 입력 바랍니다.'
	        });
			return false;
		}
		
	   	var postData = $('#modalForm').serializeObject();
		var formData = new FormData();

		// Progress Bar 객체
		var bar = $('.bar');
		var percent = $('.percent');
		var status = $('#status');

		var hasFile = false;

		// 1. 일반 데이터 추가 (파일명 배열 및 파일 관련 Key는 중복 방지를 위해 제외)
		$.each(postData, function (key, value) {
		    if (key === 'workManagePackageFileNameView' || 
		        key === 'workManagePackageFileNameView[]' ||
		        key === 'workManagePackageFileView' ||
		        key === 'workManagePackageFileView[]') {
		        return true; // continue와 동일 (스킵)
		    }
		    formData.append(key, value);
		});

		// 2. 파일명 추가 (순서 유지를 위해 input을 순회하며 직접 추가)
		$('.packageFileNameInput').each(function(index) {
		    formData.append(
		        'workManagePackageFileNameView[' + index + ']',
		        $(this).val() || ''
		    );
		});

		// 3. 파일 추가 (★개선: 파일이 없더라도 빈 파일 객체를 보내 순서를 명시)
		$('.packageFileInput').each(function (index) {
		    if (this.files && this.files.length > 0) {
		        hasFile = true;
		        formData.append(
		            'workManagePackageFileView[' + index + ']',
		            this.files[0]
		        );
		    } else {
		        // 파일이 없는 칸은 빈 Blob 객체를 보내어 서버가 이 자리를 인식하게 만듭니다.
		        // 스프링 MultipartFile에서 '파일은 선택되었으나 내용이 없는 상태'로 받아 리스트 크기가 유지됩니다.
		        formData.append(
		            'workManagePackageFileView[' + index + ']',
		            new Blob([], { type: 'application/octet-stream' }), 
		            "" // 파일명을 빈 값으로 지정
		        );
		    }
		});

		// [확인용 콘솔 로그] 제대로 데이터가 구성되었는지 브라우저 콘솔에서 확인 가능합니다.
		for (let pair of formData.entries()) {
		    console.log(pair[0], pair[1]);
		}

	    $.ajax({
	        url: "<c:url value='/workManage/insert'/>",
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,

	        // 업로드 진행률
	        xhr: function () {
	            var xhr = $.ajaxSettings.xhr();
	            if (xhr.upload) {
	                xhr.upload.addEventListener('progress', function (event) {
	                    if (event.lengthComputable) {
	                        var percentVal =
	                            Math.round((event.loaded / event.total) * 100);

	                        bar.css('width', percentVal + '%');
	                        percent.html(percentVal + '%');
	                        status.html(
	                            event.loaded.toLocaleString() +
	                            ' / ' +
	                            event.total.toLocaleString() +
	                            ' bytes'
	                        );
	                    }

	                }, false);
	            }
	            return xhr;
	        },

	        beforeSend: function () {
        	    if (hasFile) {
        	        $("#pleaseWaitDialog").modal('show');
        	        status.empty();
        	        bar.css('width', '0%');
        	        percent.html('0%');
				
        	        // 시간 계산용 (적용 중이신 로직 유지)
        	        startTime = new Date().getTime(); 
        	    }
        	},
			
        	complete: function () {
        	    if (hasFile) {
        	        var elapsed = new Date().getTime() - startTime;
        	        var minDisplayTime = 400; // 너무 짧으면 애니메이션이 꼬이므로 최소 400ms 추천
        	        var delay = Math.max(0, minDisplayTime - elapsed);
				
        	        setTimeout(function () {
        	            // 1. 우선 모달 정상 종료 시도
        	            $("#pleaseWaitDialog").modal('hide');
					
        	            // 2. ★핵심 안전장치: 너무 빨라서 꼬인 부트스트랩 잔여물 강제 철거
        	            // 모달 창을 강제로 숨김 처리하고, 회색 배경을 무조건 지웁니다.
        	            setTimeout(function() {
        	                $("#pleaseWaitDialog").hide(); 
        	                $('.modal-backdrop').remove(); // 회색 화면 강제 삭제
        	                $('body').removeClass('modal-open').css('overflow', ''); // 스크롤 잠금 강제 해제
        	            }, 150); // hide 명령 후 잔여물이 남는 타이밍에 즉시 처형
					
        	        }, delay);
        	    }
        	},

	        success: function (data) {
	            if (data.result === "OK") {
	                Swal.fire({
	                    icon: 'success',
	                    title: '성공!',
	                    text: '작업을 완료했습니다.'
	                });
	                $('#modal').modal('hide');

	                $('#modal').one('hidden.bs.modal', function () {
	                    tableRefresh();
	                });
	            } else {
	                Swal.fire({
	                    icon: 'error',
	                    title: '실패!',
	                    text: '작업을 실패하였습니다.'
	                });
	            }
	        },

	        error: function (xhr, statusText, error) {
	            console.error(xhr);
	            console.error(statusText);
	            console.error(error);

	            Swal.fire({
	                icon: 'error',
	                title: '오류!',
	                text: '업로드 중 오류가 발생했습니다.'
	            });
	        }
	    });

	});
	
	$('#updateBtn').click(function () {
	    var postData = $('#modalForm').serializeObject();
		var formData = new FormData();
			
		// Progress Bar 객체
		var bar = $('.bar');
		var percent = $('.percent');
		var status = $('#status');
			
		var hasFile = false;
			
		// 1. 일반 데이터 추가 (파일명 배열 및 파일 관련 Key는 중복 방지를 위해 제외)
		$.each(postData, function (key, value) {
		    if (key === 'workManagePackageFileNameView' || 
		        key === 'workManagePackageFileNameView[]' ||
		        key === 'workManagePackageFileView' ||
		        key === 'workManagePackageFileView[]') {
		        return true; // continue와 동일 (스킵)
		    }
		    formData.append(key, value);
		});
		
		// 2. 파일명 추가 (순서 유지를 위해 input을 순회하며 직접 추가)
		$('.packageFileNameInput').each(function(index) {
		    formData.append(
		        'workManagePackageFileNameView[' + index + ']',
		        $(this).val() || ''
		    );
		});
		
		// 3. 파일 추가 (★개선: 파일이 없더라도 빈 파일 객체를 보내 순서를 명시)
		$('.packageFileInput').each(function (index) {
		    if (this.files && this.files.length > 0) {
		        hasFile = true;
		        formData.append(
		            'workManagePackageFileView[' + index + ']',
		            this.files[0]
		        );
		    } else {
		        // 파일이 없는 칸은 빈 Blob 객체를 보내어 서버가 이 자리를 인식하게 만듭니다.
		        // 스프링 MultipartFile에서 '파일은 선택되었으나 내용이 없는 상태'로 받아 리스트 크기가 유지됩니다.
		        formData.append(
		            'workManagePackageFileView[' + index + ']',
		            new Blob([], { type: 'application/octet-stream' }), 
		            "" // 파일명을 빈 값으로 지정
		        );
		    }
		});
		
		// [확인용 콘솔 로그] 제대로 데이터가 구성되었는지 브라우저 콘솔에서 확인 가능합니다.
		for (let pair of formData.entries()) {
		    console.log(pair[0], pair[1]);
		}

	
	    $.ajax({
	        url: "<c:url value='/workManage/update'/>",
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,
		
	        xhr: function () {
	            var xhr = $.ajaxSettings.xhr();
	            if (hasFile && xhr.upload) {
	                xhr.upload.addEventListener('progress', function (event) {
	                    if (event.lengthComputable) {
	                        var percentVal = Math.round(
	                            (event.loaded / event.total) * 100
	                        );
	                        bar.css('width', percentVal + '%');
	                        percent.html(percentVal + '%');
	                        status.html(
	                            event.loaded.toLocaleString() +
	                            ' / ' +
	                            event.total.toLocaleString() +
	                            ' bytes'
	                        );
	                    }
	                }, false);
	            }
	            return xhr;
	        },
		
			beforeSend: function () {
        	    if (hasFile) {
        	        $("#pleaseWaitDialog").modal('show');
        	        status.empty();
        	        bar.css('width', '0%');
        	        percent.html('0%');
				
        	        // 시간 계산용 (적용 중이신 로직 유지)
        	        startTime = new Date().getTime(); 
        	    }
        	},
			
        	complete: function () {
        	    if (hasFile) {
        	        var elapsed = new Date().getTime() - startTime;
        	        var minDisplayTime = 400; // 너무 짧으면 애니메이션이 꼬이므로 최소 400ms 추천
        	        var delay = Math.max(0, minDisplayTime - elapsed);
				
        	        setTimeout(function () {
        	            // 1. 우선 모달 정상 종료 시도
        	            $("#pleaseWaitDialog").modal('hide');
					
        	            // 2. ★핵심 안전장치: 너무 빨라서 꼬인 부트스트랩 잔여물 강제 철거
        	            // 모달 창을 강제로 숨김 처리하고, 회색 배경을 무조건 지웁니다.
        	            setTimeout(function() {
        	                $("#pleaseWaitDialog").hide(); 
        	                $('.modal-backdrop').remove(); // 회색 화면 강제 삭제
        	                $('body').removeClass('modal-open').css('overflow', ''); // 스크롤 잠금 강제 해제
        	            }, 150); // hide 명령 후 잔여물이 남는 타이밍에 즉시 처형
					
        	        }, delay);
        	    }
        	},

	        success: function (data) {
	            if (data.result === "OK") {
	                Swal.fire({
	                    icon: 'success',
	                    title: '성공!',
	                    text: '작업을 완료했습니다.'
	                });
	                $('#modal').modal('hide');
	                $('#modal').one('hidden.bs.modal', function () {
	                    tableRefresh();
	                });
	            } else {
	                Swal.fire({
	                    icon: 'error',
	                    title: '실패!',
	                    text: '작업을 실패했습니다.'
	                });
	            }
	        },
		
	        error: function (xhr, status, error) {
	            console.error(xhr);
	            console.error(status);
	            console.error(error);
	            Swal.fire({
	                icon: 'error',
	                title: '오류!',
	                text: '업데이트 중 오류가 발생했습니다.'
	            });
	        }
	    });
	
	});

	
	$("#workManageTesterView").autocomplete({
	    minLength: 1,

	    source: function(request, response) {

	        // 마지막 검색어만 추출
	        let term = request.term.split(",").pop().trim();

	        $.ajax({
	            url: "<c:url value='/employee/inputSearch'/>",
	            type: "post",
	            dataType: "json",
	            data: { keyword: term },

	            success: function(data) {
	                response($.map(data, function(item) {
	                    return {
	                        label: item.employeeName + "(" + item.employeeId + ")",
	                        value: item.employeeName + "(" + item.employeeId + ")"
	                    };
	                }));
	            }
	        });
	    },

	    focus: function() {
	        return false;
	    },

	    select: function(event, ui) {
	        let current = $(this).val();
	        // 기존 값 배열화
	        let arr = current.split(",");
	        // 마지막 검색중인 값 제거
	        arr.pop();
	        // 새 값 추가
	        arr.push(ui.item.value);
	        // 마지막 콤마 추가 (다음 검색 가능)
	        arr.push("");
	        $(this).val(arr.join(", "));
	        return false;
	    }
	});

	// .off()와 .on()을 함께 사용하여 중복 등록을 방지하고 동적 버튼을 지원합니다.
	$(document).off("click", ".packageDownLoadBtn").on("click", ".packageDownLoadBtn", function () {
	    // 1. 클릭한 버튼이 속한 현재 행(줄)을 찾습니다.
	    const packageRow = $(this).closest(".packageItem"); // 또는 구조에 따라 .packageRow 등 부모 클래스 지정
	
	    // 2. 현재 행 내부에 있는 .packageFileNameInput의 값을 정확하게 가져옵니다.
	    const fileName = packageRow.find(".packageFileNameInput").val();
	
	    // 3. 고유 Key 번호를 가져옵니다.
	    const workManageKeyNum = "${workManageKeyNum}";
	
	    // 4. 파일명 유효성 체크
	    if (!fileName || fileName.trim() === "") {
	        Swal.fire({
	            icon: 'error',
	            title: '실패!',
	            text: '다운로드할 패키지 파일명이 존재하지 않습니다.',
	        });
	        return;
	    }
	
	    // 5. 조립된 경로로 파일 다운로드 실행
	    window.location = "<c:url value='/workManageDownLoad/fileDownload'/>?fileName=" + workManageKeyNum + "_" + fileName;
	});

	$(function() {
	    setPackageData(
	        "${workManage.workManagePackageName}",
			"${workManage.workManagePackageFileName}",
	        "${workManage.workManagePackageSize}"
	    );

		loadEditData("${workManage.workManageProductType}", "${workManage.workManageProductTypeCount}");
	});

	function loadEditData(typeStr, countStr) {
	    // 콤마(,) 기준 분리 및 문자열 앞뒤 공백 제거하여 배열화
	    var typeArray = typeStr ? typeStr.split(',').map(function(item) { return item.trim(); }) : [];
	    var countArray = countStr ? countStr.split(',').map(function(item) { return item.trim(); }) : [];
		
	    // 매pping할 데이터가 없으면 함수를 빠져나감
	    if (typeArray.length === 0) return;

	    // 기존 화면에 복사되어 있던 필드들을 모두 청소하고 첫 번째 기본 틀만 남김
	    $('.field-item').not(':first').remove();
		
	    // [i = 0] 첫 번째 데이터는 이미 화면에 존재하는 기본 폼에 매핑
	    var $firstItem = $('.field-item').first();
	    $firstItem.find('select').val(typeArray[0]);
	    $firstItem.find('.premiumCount').val(countArray[0]);
	    $firstItem.find('select').selectpicker('refresh'); // 스타일 및 빨간 테두리 반영

	    // [i = 1부터] 두 번째 데이터부터 배열의 개수만큼 반복하며 우측으로 추가 및 값 매핑
	    for (var i = 1; i < typeArray.length; i++) {
	        // 첫 번째 폼을 원본 삼아 깨끗하게 복사
	        var $clone = $('.field-item').first().clone();
		
	        // ID 중복 방지 처리 및 현재 순서(i)의 배열 값 할당
	        $clone.find('select').removeAttr('id');
	        $clone.find('select').val(typeArray[i]);         // 해당 순서의 제품유형 값 매핑
	        $clone.find('.premiumCount').val(countArray[i]); // 해당 순서의 수량 값 매핑
		
	        // Bootstrap Selectpicker 깨짐 방지 구조 초기화
	        $clone.find('.bootstrap-select').replaceWith(function() {
	            return $('select', this);
	        });
		
	        // 우측 독립 컨테이너에 차례대로 붙이기
	        $('.fields-container').append($clone);
		
	        // 빨간 테두리 클래스 등 셀렉트박스 스타일 최종 반영
	        $clone.find('select').selectpicker('refresh');
	    }
	}

	function setPackageData(
	    workManagePackageNameView,
		workManagePackageFileNameView,
	    workManagePackageSizeView
	) {
    	const packageArea = $("#packageArea");

    	// 1. 순수한 템플릿(복사본) 만들기
    	const template = packageArea.find(".packageItem").first().clone();
		
    	template.find(".bootstrap-select").each(function() {
    	    const pureSelect = $(this).find("select");
    	    $(this).replaceWith(pureSelect);
    	});
	
    	template.find("select").show().removeClass('bs-select-hidden'); 

    	// [핵심 추가] 최초 등록이라 데이터가 전부 비어있는 경우 예외 처리
    	if (!workManagePackageNameView && !workManagePackageSizeView && !workManagePackageFileNameView) {
    	    // 기존 영역을 비우고, 기본값(0MB 등)이 그대로 살아있는 순수 템플릿 1개만 노출
    	    packageArea.empty();
    	    packageArea.append(template);
    	    packageArea.find('.selectpicker').selectpicker('render');
    	    return; // 함수 종료
    	}

    	// 데이터가 존재하는 경우에만 split 진행
    	workManagePackageNameView = (workManagePackageNameView || "").split(",");
		workManagePackageFileNameView = (workManagePackageFileNameView || "").split(",");
    	workManagePackageSizeView = (workManagePackageSizeView || "").split(",");

    	// 기존 전체 제거
    	packageArea.empty();

    	// 데이터 개수만큼 생성
    	for (let i = 0; i < workManagePackageNameView.length; i++) {
    	    const item = template.clone();

    	    // 패키지명 세팅
    	    item
    	        .find("input[name='workManagePackageNameView[]']")
    	        .val(workManagePackageNameView[i]);

			item
    	        .find("input[name='workManagePackageFileNameView[]']")
    	        .val(workManagePackageFileNameView[i]);

    	    // 파일 사이즈 세팅 (값이 없거나 공백이면 기본값 0MB 유지)
    	    const sizeText = workManagePackageSizeView[i] ? workManagePackageSizeView[i] : "0MB";
    	    item.find(".workManagePackageSizeView").text(sizeText);

    	    // 추가
    	    if (workManagePackageSizeView[i] && workManagePackageSizeView[i] !== "0MB") {
    	    	item.find(".packageDownLoadBtn").show();
    		} else {
    		    item.find(".packageDownLoadBtn").hide();
    		}

    		packageArea.append(item);
    	}

    	// 2. 부트스트랩 다시 적용
    	packageArea.find('.selectpicker').selectpicker('render');
	}

	$(document).ready(function() {
	    $('#addProductBtn').on('click', function() {
	        // 1. 첫 번째 입력 폼 세트(.field-item)만 깨끗하게 복사
	        var $clone = $('.field-item').first().clone();
		
	        // 2. 복사본의 입력값 초기화
	        $clone.find('select').val('');
	        $clone.find('input[type="number"]').val('');
		
	        // 3. ID 중복 방지 및 Bootstrap Selectpicker 내부 껍데기 제거
	        $clone.find('select').removeAttr('id');
	        $clone.find('.bootstrap-select').replaceWith(function() {
	            return $('select', this);
	        });
		
	        // 4. 가로로만 늘어나는 독립 박스(.fields-container)에 우측으로 붙이기
	        $('.fields-container').append($clone);
		
	        // 5. 새 Select 박스에 selectpicker 스타일 다시 입히기
	        $clone.find('select').selectpicker('refresh');
	    });

		// ★ [삭제 버튼 클릭] 가장 우측 항목부터 제거
    	$('#delProductBtn').on('click', function() {
    	    // 현재 화면에 있는 field-item의 개수를 파악
    	    var itemCount = $('.field-item').length;
		
    	    // 최소 1개는 남겨두고, 2개 이상일 때만 맨 우측(.last()) 요소를 삭제
    	    if (itemCount > 1) {
    	        $('.field-item').last().remove();
    	    } else {
				Swal.fire({
	                icon: 'error',
	                title: '오류!',
	                text: '최소 하나의 제품유형은 유지해야 합니다.'
	            });
    	    }
    	});

		$('#workManageCustomerView').on('change', function () {
    	    var selectedValue = $(this).val();

			$.ajax({
	            url: "<c:url value='/packages/selectManager'/>",
	            type: "post",
	            dataType: "text",
	            data: { "manager": selectedValue },
	            success: function(result) {
	                $("#workManageEngineerView").val(result);
	            }
	        });
    	});
	});


</script>
<style>
	.pading5Width33 {
		padding: 5px;
    	margin-bottom: 15px;
    	width: 33%;
		float: left;
		height: 55px;
	}

	.percent-wrap{
	    position:relative;
	    width:200px;
	}

	.percent-wrap input{
	    padding-right:30px;
	}

	.percent-wrap span{
	    position:absolute;
	    right:10px;
	    top:50%;
	    transform:translateY(-50%);
	}

	#workManageDetailNoteView {
		border: 1px solid #dab17d;
    	height: 150px;
	}

	.package-upload-btn {
	    display: inline-flex;
	    align-items: center;
	    gap: 8px;
	    padding: 8px 12px;
	    border: none;
	    border-radius: 8px;
	    background: #d77f7f;
	    color: white;
	    font-size: 14px;
	    font-weight: 600;
	    cursor: pointer;
	    transition: all 0.2s ease;
	}

	.package-upload-btn:hover {
	    background: #af5656;
	    transform: translateY(-1px);
	}

	.package-download-btn {
	    display: inline-flex;
	    align-items: center;
	    gap: 8px;
	    padding: 8px 12px;
	    border: none;
	    border-radius: 8px;
	    background: #a0d77f;
	    color: white;
	    font-size: 14px;
	    font-weight: 600;
	    cursor: pointer;
	    transition: all 0.2s ease;
	}

	.package-download-btn:hover {
	    background: #56af5d;
	    transform: translateY(-1px);
	}

	.package-delete-btn {
	    display: inline-flex;
	    align-items: center;
	    gap: 8px;
	    padding: 8px 12px;
	    border: none;
	    border-radius: 8px;
	    background: #ff6e6e;
	    color: white;
	    font-size: 14px;
	    font-weight: 600;
	    cursor: pointer;
	    transition: all 0.2s ease;
	}

	.package-delete-btn:hover {
	    background: #bd2525;
	    transform: translateY(-1px);
	}

	.packageFile {
		display: flex;
    	align-items: center;
    	justify-content: left;
    	height: 70px;
	}

	.packageHeight {
		height: 43px;
	}

	.bootstrap-select.disabled .dropdown-toggle {
	    background: #e9ecefb5 !important;
	    border-color: #ced4da !important;
	    color: #6c757d !important;
	    cursor: not-allowed !important;
	    opacity: 1 !important;
	}

	.bar {	
		background: #5858fd;
	}

	/* 상단 제품유형 기본 라벨 */
	.labelFontSize {
	    display: block;
	    font-size: 13px;
	    font-weight: 600;
	    margin-bottom: 6px;
	    color: #495057;
	}

	/* 아래 배치되는 고급스러운 수량 입력 그룹 */
	.premiumQuantityBox {
	    display: flex;
	    align-items: center;
	    margin-top: 8px; /* 제품유형 창과의 간격 */
	    background-color: #f8f9fa;
	    border: 1px solid #ced4da;
	    border-radius: 6px;
	    padding: 2px 10px 2px 0; /* 좌측 태그 영역 확보 */
	    transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
	    width: 100%; /* 부모 너비에 맞춤 */
	}

	/* 왼쪽에 고정된 미니 QTY 뱃지 (라벨 대신 세련미를 주는 포인트) */
	.qtyTag {
	    font-size: 10px;
	    font-weight: 800;
	    color: #4b5563;
	    background-color: #e5e7eb;
	    padding: 4px 8px;
	    border-radius: 4px;
	    margin-left: 6px;
	    letter-spacing: 0.5px;
	}

	/* 실제 input 스타일 (테두리를 없애고 투명하게 처리하여 그룹 박스에 동화됨) */
	.premiumCount {
	    flex: 1;
	    border: none !important;
	    background: transparent !important;
	    box-shadow: none !important;
	    height: 15px;
	    text-align: right;
	    font-size: 15px;
	    font-weight: 600;
	    color: #212529;
	    padding: 0 8px;
	}

	/* 포커스 되었을 때 전체 감싸는 상자가 함께 빛나는 효과 */
	.premiumQuantityBox:focus-within {
	    border-color: #4f46e5; /* 세련된 인디고 블루 색상 */
	    background-color: #ffffff;
	    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
	}

	/* 우측 단위 표시 */
	.qtyUnit {
	    font-size: 13px;
	    font-weight: 500;
	    color: #6b7280;
	    margin-left: 4px;
	    padding-right: 2px;
	}

	/* 크롬 숫자 화살표 크기 최적화 및 정렬 */
	.premiumCount::-webkit-inner-spin-button,
	.premiumCount::-webkit-outer-spin-button {
	    height: 24px;
	    margin-left: 4px;
	}

	.bootstrap-select.productType > button.dropdown-toggle {
	    border: 1px solid #b71a1a !important;
	}


</style>

