<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="modal-body" style="width: 100%; height: 810px;">
	<form id="modalForm" name="form" method ="post" enctype="multipart/form-data"> 
		<input type="hidden" id="workManageKeyNum" name="workManageKeyNum" class="form-control viewForm" value="${workManage.workManageKeyNum}">
		<div style="display: flow-root; padding-bottom: 10px;">
			<div class="pading5Width33">
				<div>
					<label class="labelFontSize">고객사</label><label class="colorRed">*</label>
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
		<div style="display: flow-root; padding-bottom: 10px; border-top: 1px solid #d17c7c;">
			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">제품유형 1</label>
				  	<select class="form-control selectpicker selectForm" id="workManageProductTypeOneView" name="workManageProductTypeOneView" data-live-search="true" data-size="5">
				  		<option value=""></option>
						<c:forEach var="item" items="${workManageProductType}">
							<option value="${item}" <c:if test="${item eq workManage.workManageProductTypeOne}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">패키지명 1</label>
	    		    <input type="text" id="workManagePackageNameOneView" name="workManagePackageNameOneView" class="form-control viewForm" value="${workManage.workManagePackageNameOne}">
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div class="packageFile">
					<input type="file" id="workManagePackageFileOneView" name="workManagePackageFileOneView" hidden>
					<div style="width: 55px;"><label>${workManage.workManagePackageSizeOne}</label></div>
					<button type="button" class="package-upload-btn" id="packageUploadOneBtn">패키지 선택</button>
					<c:if test="${not empty workManage.workManagePackageFileOne}">
						<button type="button" class="package-download-btn" id="packageDownLoadOneBtn">다운로드</button>
						<button type="button" class="package-delete-btn" id="packageFileDeleteOneBtn">제거</button>
					</c:if>
					
				</div>
			</div>

			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">제품유형 2</label>
				  	<select class="form-control selectpicker selectForm" id="workManageProductTypeTwoView" name="workManageProductTypeTwoView" data-live-search="true" data-size="5">
				  		<option value=""></option>
						<c:forEach var="item" items="${workManageProductType}">
							<option value="${item}" <c:if test="${item eq workManage.workManageProductTypeTwo}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">패키지명 2</label>
	    		    <input type="text" id="workManagePackageNameTwoView" name="workManagePackageNameTwoView" class="form-control viewForm" value="${workManage.workManagePackageNameTwo}">
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div class="packageFile">
					<input type="file" id="workManagePackageFileTwoView" name="workManagePackageFileTwoView" hidden>
					<div style="width: 55px;"><label>${workManage.workManagePackageSizeTwo}</label></div>
					<button type="button" class="package-upload-btn" id="packageUploadTwoBtn">패키지 선택</button>
					<c:if test="${not empty workManage.workManagePackageFileTwo}">
						<button type="button" class="package-download-btn" id="packageDownLoadTwoBtn">다운로드</button>
						<button type="button" class="package-delete-btn" id="packageFileDeleteTwoBtn">제거</button>
					</c:if>
				</div>
			</div>

			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">제품유형 3</label>
				  	<select class="form-control selectpicker selectForm" id="workManageProductTypeThreeView" name="workManageProductTypeThreeView" data-live-search="true" data-size="5">
				  		<option value=""></option>
						<c:forEach var="item" items="${workManageProductType}">
							<option value="${item}" <c:if test="${item eq workManage.workManageProductTypeThree}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">패키지명 3</label>
	    		    <input type="text" id="workManagePackageNameThreeView" name="workManagePackageNameThreeView" class="form-control viewForm" value="${workManage.workManagePackageNameThree}">
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div class="packageFile">
					<input type="file" id="workManagePackageFileThreeView" name="workManagePackageFileThreeView" hidden>
					<div style="width: 55px;"><label>${workManage.workManagePackageSizeThree}</label></div>
					<button type="button" class="package-upload-btn" id="packageUploadThreeBtn">패키지 선택</button>
					<c:if test="${not empty workManage.workManagePackageFileThree}">
						<button type="button" class="package-download-btn" id="packageDownLoadThreeBtn">다운로드</button>
						<button type="button" class="package-delete-btn" id="packageFileDeleteThreeBtn">제거</button>
					</c:if>
				</div>
			</div>

			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">제품유형 4</label>
				  	<select class="form-control selectpicker selectForm" id="workManageProductTypeFourView" name="workManageProductTypeFourView" data-live-search="true" data-size="5">
				  		<option value=""></option>
						<c:forEach var="item" items="${workManageProductType}">
							<option value="${item}" <c:if test="${item eq workManage.workManageProductTypeFour}">selected</c:if>><c:out value="${item}"/></option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div>
					<label class="labelFontSize">패키지명 4</label>
	    		    <input type="text" id="workManagePackageNameFourView" name="workManagePackageNameFourView" class="form-control viewForm" value="${workManage.workManagePackageNameFour}">
				</div>
			</div>
			<div class="pading5Width33 packageHeight">
				<div class="packageFile">
					<input type="file" id="workManagePackageFileFourView" name="workManagePackageFileFourView" hidden>
					<div style="width: 55px;"><label>${workManage.workManagePackageSizeFour}</label></div>
					<button type="button" class="package-upload-btn" id="packageUploadFourBtn">패키지 선택</button>
					<c:if test="${not empty workManage.workManagePackageFileFour}">
						<button type="button" class="package-download-btn" id="packageDownLoadFourBtn">다운로드</button>
						<button type="button" class="package-delete-btn" id="packageFileDeleteFourBtn">제거</button>
					</c:if>
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
					<select class="form-control selectpicker"
						id="workManageProgressStatusView"
						name="workManageProgressStatusView"
						data-size="5"
						data-actions-box="true"
						<sec:authorize access="!hasRole('ADMIN')">disabled="disabled"</sec:authorize>>
						<option value="진행중" <c:if test="${'진행중' eq workManage.workManageProgressStatus}">selected</c:if>>진행중</option>
						<option value="보류" <c:if test="${'보류' eq workManage.workManageProgressStatus}">selected</c:if>>보류</option>
						<option value="완료" <c:if test="${'완료' eq workManage.workManageProgressStatus}">selected</c:if>>완료</option>
					</select>
				</div>
			</div>
			<div class="pading5Width33">
				<div class="percent-wrap" style="width: 100%;">
					<label class="labelFontSize">진행률</label>
	    		    <input type="number" id="workManageProgressView" name="workManageProgressView" class="form-control viewForm" min="0" max="100" value="${workManage.workManageProgress}" style="text-align: right; font-weight: bold;" <sec:authorize access="!hasRole('ADMIN')">disabled="disabled"</sec:authorize>>
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
			<button class="btn btn-default btn-outline-info-add" id="insertBtn">추가</button>
		</c:when>
		<c:when test="${viewType eq 'update'}">
			<button class="btn btn-default btn-outline-info-add" id="updateBtn">수정</button>	
		</c:when>
	</c:choose>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
    
</div>

<script>
	$('.selectpicker').selectpicker(); // 부투스트랩 Select Box 사용 필수

	$("#packageUploadOneBtn").click(function () {
		var workManageProductTypeOne = $("#workManageProductTypeOneView").val();
		if(workManageProductTypeOne == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제품유형1을 선택해주세요.',
			});
		} else {
    		$("#workManagePackageFileOneView").click();
		}
	});

	$("#workManagePackageFileOneView").change(function () {
	    if (this.files.length > 0) {
	        let fileName = this.files[0].name;
	        $("#workManagePackageNameOneView").val(fileName);
	    }
	});

	$("#packageUploadTwoBtn").click(function () {
		var workManageProductTypeTwo = $("#workManageProductTypeTwoView").val();
		if(workManageProductTypeTwo == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제품유형2을 선택해주세요.',
			});
		} else {
    		$("#workManagePackageFileTwoView").click();
		}
	});

	$("#workManagePackageFileTwoView").change(function () {
	    if (this.files.length > 0) {
	        let fileName = this.files[0].name;
	        $("#workManagePackageNameTwoView").val(fileName);
	    }
	});

	$("#packageUploadThreeBtn").click(function () {
		var workManageProductTypeThree = $("#workManageProductTypeThreeView").val();
		if(workManageProductTypeThree == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제품유형3을 선택해주세요.',
			});
		} else {
    		$("#workManagePackageFileThreeView").click();
		}
	});

	$("#workManagePackageFileThreeView").change(function () {
	    if (this.files.length > 0) {
	        let fileName = this.files[0].name;
	        $("#workManagePackageNameThreeView").val(fileName);
	    }
	});

	$("#packageUploadFourBtn").click(function () {
		var workManageProductTypeFour = $("#workManageProductTypeFourView").val();
		if(workManageProductTypeFour == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '제품유형4을 선택해주세요.',
			});
		} else {
    		$("#workManagePackageFileFourView").click();
		}
	});

	$("#workManagePackageFileFourView").change(function () {
	    if (this.files.length > 0) {
	        let fileName = this.files[0].name;
	        $("#workManagePackageNameFourView").val(fileName);
	    }
	});

	$("#packageDownLoadOneBtn").click(function () {
		var fileName = "${workManage.workManagePackageFileOne}";
		if(fileName == null || fileName.trim() == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '패키지1이 존재하지 않습니다.',
			});
		} else {
			window.location ="<c:url value='/workManageDownLoad/fileDownload?fileName="+fileName+"'/>";
		}
	});

	$("#packageDownLoadTwoBtn").click(function () {
		var fileName = "${workManage.workManagePackageFileTwo}";
		if("${workManage.workManagePackageFileTwo}" == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '패키지2가 존재하지 않습니다.',
			});
		} else {
			window.location ="<c:url value='/workManageDownLoad/fileDownload?fileName="+fileName+"'/>";
		}
	});

	$("#packageDownLoadThreeBtn").click(function () {
		var fileName = "${workManage.workManagePackageFileThree}";
		if("${workManage.workManagePackageFileThree}" == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '패키지3이 존재하지 않습니다.',
			});
		} else {
			window.location ="<c:url value='/workManageDownLoad/fileDownload?fileName="+fileName+"'/>";
		}
	});

	$("#packageDownLoadFourBtn").click(function () {
		var fileName = "${workManage.workManagePackageFileFour}";
		if("${workManage.workManagePackageFileFour}" == "") {
			Swal.fire({
				icon: 'error',
				title: '실패!',
				text: '패키지4가 존재하지 않습니다.',
			});
		} else {
			window.location ="<c:url value='/workManageDownLoad/fileDownload?fileName="+fileName+"'/>";
		}
	});

	$("#packageFileDeleteOneBtn").click(function () {
		Swal.fire({
			title: '제거!',
			text: "첨부파일을 제거하시겠습니까?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#FF99AB',
			confirmButtonText: 'OK'
		}).then((result) => {
		  	if (result.isConfirmed) {
            	$("#workManageProductTypeOneView").val("");
				$("#workManageProductTypeOneView").selectpicker("refresh");
	            $("#workManagePackageNameOneView").val("");
	            $("#workManagePackageFileOneView").val("");
				$("#packageDownLoadOneBtn").remove();
            	$("#packageFileDeleteOneBtn").remove();
		  	}
		})
	});

	$("#packageFileDeleteTwoBtn").click(function () {
		Swal.fire({
			title: '제거!',
			text: "첨부파일을 제거하시겠습니까?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#FF99AB',
			confirmButtonText: 'OK'
		}).then((result) => {
		  	if (result.isConfirmed) {
            	$("#workManageProductTypeTwoView").val("");
				$("#workManageProductTypeTwoView").selectpicker("refresh");
	            $("#workManagePackageNameTwoView").val("");
	            $("#workManagePackageFileTwoView").val("");
				$("#packageDownLoadTwoBtn").remove();
            	$("#packageFileDeleteTwoBtn").remove();
		  	}
		})
	});

	$("#packageFileDeleteThreeBtn").click(function () {
		Swal.fire({
			title: '제거!',
			text: "첨부파일을 제거하시겠습니까?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#FF99AB',
			confirmButtonText: 'OK'
		}).then((result) => {
		  	if (result.isConfirmed) {
            	$("#workManageProductTypeThreeView").val("");
				$("#workManageProductTypeThreeView").selectpicker("refresh");
	            $("#workManagePackageNameThreeView").val("");
	            $("#workManagePackageFileThreeView").val("");
				$("#packageDownLoadThreeBtn").remove();
            	$("#packageFileDeleteThreeBtn").remove();
		  	}
		})
	});

	$("#packageFileDeleteFourBtn").click(function () {
		Swal.fire({
			title: '제거!',
			text: "첨부파일을 제거하시겠습니까?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#7066e0',
			cancelButtonColor: '#FF99AB',
			confirmButtonText: 'OK'
		}).then((result) => {
		  	if (result.isConfirmed) {
            	$("#workManageProductTypeFourView").val("");
				$("#workManageProductTypeFourView").selectpicker("refresh");
	            $("#workManagePackageNameFourView").val("");
	            $("#workManagePackageFileFourView").val("");
				$("#packageDownLoadFourBtn").remove();
            	$("#packageFileDeleteFourBtn").remove();
		  	}
		})
	});
	
	
	/* =========== 추가 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		var formData = new FormData();

    	// 일반 데이터 추가
    	$.each(postData, function(key, value) {
    	    formData.append(key, value);
    	});

    	// 파일 추가
    	var workManagePackageFileOneView = $('#workManagePackageFileOneView')[0];
		var workManagePackageFileTwoView = $('#workManagePackageFileTwoView')[0];
		var workManagePackageFileThreeView = $('#workManagePackageFileThreeView')[0];
		var workManagePackageFileFourView = $('#workManagePackageFileFourView')[0];

    	if (workManagePackageFileOneView.files.length > 0) {
    	    formData.append('workManagePackageFileOneView', workManagePackageFileOneView.files[0]);
    	}

		if (workManagePackageFileTwoView.files.length > 0) {
    	    formData.append('workManagePackageFileTwoView', workManagePackageFileTwoView.files[0]);
    	}

		if (workManagePackageFileThreeView.files.length > 0) {
    	    formData.append('workManagePackageFileThreeView', workManagePackageFileThreeView.files[0]);
    	}

		if (workManagePackageFileFourView.files.length > 0) {
    	    formData.append('workManagePackageFileFourView', workManagePackageFileFourView.files[0]);
    	}

		$.ajax({
			url: "<c:url value='/workManage/insert'/>",
	       	type: 'post',
	        data: formData,
	        async: false,
	        processData: false,
	        contentType: false,
	        success: function(data) {
				if(data.result == "OK") {
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
	});
	
	$('#updateBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		var formData = new FormData();

    	// 일반 데이터 추가
    	$.each(postData, function(key, value) {
    	    formData.append(key, value);
    	});

    	// 파일 추가
    	var workManagePackageFileOneView = $('#workManagePackageFileOneView')[0];
		var workManagePackageFileTwoView = $('#workManagePackageFileTwoView')[0];
		var workManagePackageFileThreeView = $('#workManagePackageFileThreeView')[0];
		var workManagePackageFileFourView = $('#workManagePackageFileFourView')[0];

    	if (workManagePackageFileOneView.files.length > 0) {
    	    formData.append('workManagePackageFileOneView', workManagePackageFileOneView.files[0]);
    	}

		if (workManagePackageFileTwoView.files.length > 0) {
    	    formData.append('workManagePackageFileTwoView', workManagePackageFileTwoView.files[0]);
    	}

		if (workManagePackageFileThreeView.files.length > 0) {
    	    formData.append('workManagePackageFileThreeView', workManagePackageFileThreeView.files[0]);
    	}

		if (workManagePackageFileFourView.files.length > 0) {
    	    formData.append('workManagePackageFileFourView', workManagePackageFileFourView.files[0]);
    	}

		$.ajax({
			url: "<c:url value='/workManage/update'/>",
	        type: 'post',
	        data: formData,
	        processData: false,
        	contentType: false,
        	async: false,
	        success: function(data) {
				if(data.result == "OK") {
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

</style>

