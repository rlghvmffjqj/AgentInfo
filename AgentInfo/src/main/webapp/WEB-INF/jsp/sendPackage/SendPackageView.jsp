<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 350px;">
	<div id="loadImage" style="position:absolute; top:50%; left:50%;width:0px;height:0px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; text-align:center; display:none;">
		<img src="/AgentInfo/images/loding.gif" style="width:100px; height:100px;">
	</div>
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="sendPackageKeyNum" name="sendPackageKeyNum" class="form-control viewForm" value="${sendPackage.sendPackageKeyNum}">
		<input type="hidden" id="sendPackageCountView" name="sendPackageCountView" class="form-control viewForm" value="${sendPackage.sendPackageCount}">
		<input type="hidden" id="sendPackageRandomUrl" name="sendPackageRandomUrl" class="form-control viewForm" value="${sendPackage.sendPackageRandomUrl}">
			<div class="pading5Width450">
				<div>
					<label class="labelFontSize">사원명</label><label class="colorRed">*</label>
				</div>
				<input type="text" id="employeeNameView" name="employeeNameView" class="form-control viewForm" value="${sendPackage.employeeName}">
				<span class="colorRed" id="NotEmployeeName" style="display: none; line-height: initial;">패키지 전달 받을 사원 이름 입력 바랍니다.</span>
			</div>
			<div class="pading5Width450">
	         	<div><label class="labelFontSize">다운로드 가능기간</label><label class="colorRed">*</label></div>
	         	<input type="text" class="form-control viewForm" id="sendPackageStartDateView" name="sendPackageStartDateView"  value="${sendPackage.sendPackageStartDate}" max="9999-12-31" style="width: 48%;float: left;">
	         	~
	         	<input type="text" id="sendPackageEndDateView" name="sendPackageEndDateView" class="form-control viewForm" value="${sendPackage.sendPackageEndDate}" max="9999-12-31" style="width: 48%;float: right;">
	         	<span class="colorRed" id="NotSendPackageDate" style="display: none; float: left; line-height: initial;">다운로드 기간 입력 바랍니다.</span>
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

<script>
	$(function () {
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
		var employeeNameView = $('#employeeNameView').val();
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
		var existenceConfirmation;
		var sendPackageView = $('#sendPackageView')[0];
		
		const postData = new FormData();
		postData.append('sendPackageView',sendPackageView.files[0]);
		postData.append('employeeNameView',employeeNameView);
		postData.append('sendPackageStartDateView',sendPackageStartDateView);
		postData.append('sendPackageEndDateView',sendPackageEndDateView);
		postData.append('sendPackageLimitCountView',sendPackageLimitCountView);
		
		if(employeeNameView == "") {
			$('#NotEmployeeName').show();
			check = 0;
		} else {
			$('#NotEmployeeName').hide();
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
		var sendPackageFileName = sendPackageView.files[0].name;
		$('#NotSendPackageView').hide();
		
		// 파일 존재 유무 확인
		$('#loadImage').css('display','block');
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
					} else {
						$("#loadImage").hide();
					}
				});
			} else {
				insert(postData);		// insert
			}
		}, "100");
	});
	
	/* =========== 등록(중복 분리) ========= */
	function insert(postData) {
		$.ajax({
			url: "<c:url value='/sendPackage/insert'/>",
			type: 'post',
		    data: postData,
		    async: false,
		    processData: false,
		    contentType: false,
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
						text: '작업을 실패하였습니다.',
					});
				}
			},
			beforeSend:function(){
				$("#loadImage").show();
		    },
		    complete:function(){
		    	$("#loadImage").hide();
		    },
			error: function(error) {
				console.log(error);
			}
		});
	}
	
	/* =========== 패키지 수정 ========= */
	$('#updateBtn').click(function() {
		var sendPackageKeyNum = $('#sendPackageKeyNum').val();
		var sendPackageRandomUrl = $('#sendPackageRandomUrl').val();
		var sendPackageCountView = $('#sendPackageCountView').val();
		var employeeNameView = $('#employeeNameView').val();
		var sendPackageStartDateView = $('#sendPackageStartDateView').val();
		var sendPackageEndDateView = $('#sendPackageEndDateView').val();
		var sendPackageLimitCountView = $('#sendPackageLimitCountView').val();
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
		postData.append('employeeNameView',employeeNameView);
		postData.append('sendPackageStartDateView',sendPackageStartDateView);
		postData.append('sendPackageEndDateView',sendPackageEndDateView);
		postData.append('sendPackageLimitCountView',sendPackageLimitCountView);
		
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
		$.ajax({
            url: "<c:url value='/sendPackage/update'/>",
            type: 'post',
            data: postData,
            async: false,
            processData: false,
	        contentType: false,
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
			},
			error: function(error) {
				console.log(error);
			}
        });
	}
	
</script>
<style>
	.pading5Width450 {
		height: 75px;
	} 
</style>