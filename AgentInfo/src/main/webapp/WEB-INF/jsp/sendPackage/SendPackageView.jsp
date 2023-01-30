<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 720px;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="sendPackageKeyNum" name="sendPackageKeyNum" class="form-control viewForm" value="${sendPackage.sendPackageKeyNum}">
		<input type="hidden" id="sendPackageCountView" name="sendPackageCountView" class="form-control viewForm" value="${sendPackage.sendPackageCount}">
		<input type="hidden" id="sendPackageRandomUrl" name="sendPackageRandomUrl" class="form-control viewForm" value="${sendPackage.sendPackageRandomUrl}">
		<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<div class="pading5Width450">
						<div>
							<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
						</div>
						<div id="customerNameViewSelf">
						  	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
						  		<option value=""></option>
								<c:forEach var="item" items="${customerName}">
									<option value="${item}"><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
						<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력 바랍니다.</span>
					</div>
					<div class="pading5Width450">
						<div>
							<label class="labelFontSize">사업명</label>
						</div>
						<div id="businessNameViewSelf">
						  	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
						  		<option value=""></option>
							</select>
						</div>
					</div>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<div class="pading5Width450">
						<div>
							<label class="labelFontSize">고객사명</label><label class="colorRed">*</label>
						</div>
						<div id="customerNameViewSelf">
						  	<select class="form-control selectpicker selectForm" id="customerNameView" name="customerNameView" data-live-search="true" data-size="5">
				         		<c:if test="${sendPackage.customerName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${sendPackage.customerName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${customerName}">
									<option value="${item}" <c:if test="${item eq sendPackage.customerName}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
						<span class="colorRed" id="NotCustomerName" style="display: none; line-height: initial;">고객사명을 입력 바랍니다.</span>
					</div>
					<div class="pading5Width450">
						<div>
							<label class="labelFontSize">사업명</label>
						</div>
						<div id="businessNameViewSelf">
						  	<select class="form-control selectpicker selectForm" id="businessNameView" name="businessNameView" data-live-search="true" data-size="5">
				         		<c:if test="${sendPackage.businessName ne ''}"><option value=""></option></c:if>
				         		<c:if test="${sendPackage.businessName eq ''}"><option value=""></option></c:if>
				         		<c:forEach var="item" items="${businessName}">
									<option value="${item}" <c:if test="${item eq sendPackage.businessName}">selected</c:if>><c:out value="${item}"/></option>
								</c:forEach>
							</select>
						</div>
					</div>
				</c:when>
			</c:choose>
		<div class="pading5Width450">
			<div>
				<label class="labelFontSize">망구분</label>
			</div>
			<input type="text" id="networkClassificationView" name="networkClassificationView" class="form-control viewForm" value="${sendPackage.networkClassification}">
		</div>
		<div class="pading5Width450">
			<div>
				<label class="labelFontSize">담당자</label>
			</div>
			<input type="text" id="managerView" name="managerView" class="form-control viewForm" value="${sendPackage.manager}">
		</div>
		<div class="pading5Width450">
			<div>
				<label class="labelFontSize">요청일자</label>
			</div>
			<input type="date" id="requestDateView" name="requestDateView" class="form-control viewForm" value="${sendPackage.requestDate}">
		</div>
		<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<div class="pading5Width450">
						<div>
							<label class="labelFontSize">패키지종류</label>
						</div>
						<select class="form-control selectpicker selectForm" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
							<option value=""></option>
							<c:forEach var="item" items="${managementServer}">
								<option value="${item}"><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<div class="pading5Width450">
						<div>
							<label class="labelFontSize">패키지종류</label>
						</div>
						<select class="form-control selectpicker selectForm" id="managementServerView" name="managementServerView" data-live-search="true" data-size="5">
				        	<c:if test="${sendPackage.managementServer ne ''}"><option value=""></option></c:if>
				        	<c:if test="${sendPackage.managementServer eq ''}"><option value=""></option></c:if>
				        	<c:forEach var="item" items="${managementServer}">
								<option value="${item}" <c:if test="${item eq sendPackage.managementServer}">selected</c:if>><c:out value="${item}"/></option>
							</c:forEach>
						</select>
					</div>
				</c:when>
			</c:choose>
		<div class="pading5Width450">
	     	<div><label class="labelFontSize">다운로드 가능기간</label><label class="colorRed">*</label></div>
	     	<input type="text" class="form-control viewForm" id="sendPackageStartDateView" name="sendPackageStartDateView"  value="${sendPackage.sendPackageStartDate}" max="9999-12-31" style="width: 48%;float: left;">
	     	~
	     	<input type="text" id="sendPackageEndDateView" name="sendPackageEndDateView" class="form-control viewForm" value="${sendPackage.sendPackageEndDate}" max="9999-12-31" style="width: 48%;float: right;">
	     	<span class="colorRed" id="NotSendPackageDate" style="display: none; float: left; line-height: initial;">다운로드 기간 입력 바랍니다.</span>
	     	<span class="colorRed" id="PeriodSendPackageDate" style="display: none; float: left; line-height: initial;">다운로드 가능 시작 기간이 종료 기간보다 크지 않아야 합니다.</span>
	    </div>
		<div class="pading5Width450">
			<div>
				<label class="labelFontSize">최대 다운로드 횟수</label><label class="colorRed">*</label>
			</div>
			<c:choose>
				<c:when test="${viewType eq 'insert'}">
					<input type="number" id="sendPackageLimitCountView" name="sendPackageLimitCountView" class="form-control viewForm" value="1">
				</c:when>
				<c:when test="${viewType eq 'update'}">
					<input type="number" id="sendPackageLimitCountView" name="sendPackageLimitCountView" class="form-control viewForm" value="${sendPackage.sendPackageLimitCount}">
				</c:when>
			</c:choose>
			<span class="colorRed" id="NotSendPackageCount" style="display: none; line-height: initial;">1이상의 값을 입력 바랍니다.</span>
		</div>
		<div class="pading5Width450">
			<div>
				<label class="labelFontSize">패키지</label><label class="colorRed">*</label>
			</div>
			<input class="form-control viewForm" type="file" name="sendPackageView" id="sendPackageView" />
			<span class="colorRed" id="NotSendPackageView" style="display: none; line-height: initial;">패키지를 등록 해주세요.</span>
			<c:choose>
				<c:when test="${viewType eq 'update'}">
					<span class="colorRed" style="line-height: initial;">패키지 변경 할 경우만 파일 선택 해주세요.</span>
				</c:when>
			</c:choose>
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

<!-- progress Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="margin-top: 50%;">
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
	$(function () {
		$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수
		$('#sendPackageStartDateView').datetimepicker();
		$('#sendPackageEndDateView').datetimepicker();
	});

	$(function () {
		var sendPackageStartDate = $('#sendPackageStartDateView').val();
		var sendPackageEndDate = $('#sendPackageEndDateView').val();
		if(sendPackageStartDate == "") {
			$('#sendPackageStartDateView').val(new Date().toISOString().slice(0, 10));
			
		}
		if(sendPackageEndDate == "") {
			$('#sendPackageEndDateView').val(new Date().toISOString().slice(0, 10));
		}
	});

	/* =========== 패키지 등록 ========= */
	$('#insertBtn').click(function() {
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
		var existenceConfirmation;
		var sendPackageView = $('#sendPackageView')[0];
		
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
		
		if(customerNameView == "") {
			$('#NotCustomerName').show();
			check = 0;
		} else {
			$('#NotCustomerName').hide();
		}
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
						insert(postData);	// insert
					} 
				});
			} else {
				insert(postData);		// insert
			}
		}, "100");
	});
	
	/* =========== 등록(중복 분리) ========= */
	function insert(postData) {
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
			url: "<c:url value='/sendPackage/insert'/>",
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
                // progress Modal 닫기
                $("#pleaseWaitDialog").modal('hide');
            },
		    success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('.modal-backdrop').hide();
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
			}	
		});
	}
	
	/* =========== 패키지 수정 ========= */
	$('#updateBtn').click(function() {
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
		
		if(sendPackageView.files[0] != null) {
			// 파일 존재 유무 확인
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
						update(postData);	// update
					}
				});
			} else {
				update(postData);		// update
			}
		} else {
			update(postData);
		}
		
		
	});
	
	/* =========== 수정(중복 분리) ========= */
	function update(postData) {
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
		            packagesInsert();
	        	}, 500);
	        },
            success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					});
					$('.modal-backdrop').hide();
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
			},
			error: function(error) {
				console.log(error);
			}
        });
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
<style>
	.pading5Width450 {
		height: 75px;
	} 
	
	.progress { position:relative; width:100%; border: 1px solid #ddd; padding: 1px; border-radius: 3px; color: black; }
	.bar { background-color: #337ab7; width:0%; height:30px; border-radius: 3px; }
	.percent { position:absolute; display:inline-block; top:1px; left:48%; }
</style>