<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modal-body" style="width: 100%; height: 545px;">
	<form id="modalForm" name="form" method ="post">
		<input type="hidden" id="serverListTypeView" name="serverListTypeView" class="form-control viewForm" value="${serverList.serverListType}">
		<input type="hidden" id="serverListKeyNum" name="serverListKeyNum" class="form-control viewForm" value="${serverList.serverListKeyNum}">
		<input type="hidden" id="serverCalendarKeyNum" name="serverCalendarKeyNum" class="form-control viewForm" value="${serverList.serverCalendarKeyNum}">
		<div class="leftDiv">
			<div class="pading5Width450">
				<label class="labelFontSize">구분</label>
	        	<select class="form-control selectpicker selectForm" id="serverListDivisionView" name="serverListDivisionView" data-live-search="true" data-size="5">
			    	<option value="Linux" <c:if test="${serverList.serverListDivision eq 'Linux'}">selected</c:if>>Linux</option>
			    	<option value="Windows" <c:if test="${serverList.serverListDivision eq 'Windows'}">selected</c:if>>Windows</option>
			    	<option value="AIX" <c:if test="${serverList.serverListDivision eq 'AIX'}">selected</c:if>>AIX</option>
			    	<option value="HP-UX" <c:if test="${serverList.serverListDivision eq 'HP-UX'}">selected</c:if>>HP-UX</option>
			    	<option value="Solaris" <c:if test="${serverList.serverListDivision eq 'Solaris'}">selected</c:if>>Solaris</option>
			    	<option value="기타" <c:if test="${serverList.serverListDivision eq '기타'}">selected</c:if>>기타</option>
				</select>
			</div>
			<div class="pading5Width450">
				<label class="labelFontSize">IP</label>
	        	<input type="text" id="serverListIpView" name="serverListIpView" class="form-control viewForm" value="${serverList.serverListIp}">
			</div>
			<div class="pading5Width450">
	        	<label class="labelFontSize">상태</label>
	        	<select class="form-control selectpicker selectForm" id="serverListStateView" name="serverListStateView" data-live-search="true" data-size="5">
			    	<option value="정상작동" <c:if test="${serverList.serverListState eq '정상작동'}">selected</c:if>>정상작동</option>
			    	<option value="접속불가" <c:if test="${serverList.serverListState eq '접속불가'}">selected</c:if>>접속불가</option>
			    	<option value="업데이트" <c:if test="${serverList.serverListState eq '업데이트'}">selected</c:if>>업데이트</option>
			    	<option value="외부반출" <c:if test="${serverList.serverListState eq '외부반출'}">selected</c:if>>외부반출</option>
			    	<option value="장비대여" <c:if test="${serverList.serverListState eq '장비대여'}">selected</c:if>>장비대여</option>
				</select>
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">MAC</label>
	        	<input type="text" id="serverListMacView" name="serverListMacView" class="form-control viewForm" value="${serverList.serverListMac}">
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">자산번호</label>
	        	<input type="text" id="serverListAssetNumView" name="serverListAssetNumView" class="form-control viewForm" value="${serverList.serverListAssetNum}">
	        	<span class="colorRed" id="NotServerListAssetNum" style="display: none; line-height: initial;">자산번호를 입력해주세요.</span>
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">HostName</label>
	        	<input type="text" id="serverListHostNameView" name="serverListHostNameView" class="form-control viewForm" value="${serverList.serverListHostName}">
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">용도</label>
	        	<input type="text" id="serverListPurposeView" name="serverListPurposeView" class="form-control viewForm" value="${serverList.serverListPurpose}">
	        </div>
	        <div class="pading5Width450">
	        	<label class="labelFontSize">운영체제</label>
	        	<input type="text" id="serverListOsView" name="serverListOsView" class="form-control viewForm" value="${serverList.serverListOs}">
	        </div>
	     </div>
         <div class="rightDiv">
         	<div class="pading5Width450">
	         	<label class="labelFontSize">서버 구분</label>
	         	<input type="text" id="serverListServerClassView" name="serverListServerClassView" class="form-control viewForm" value="${serverList.serverListServerClass}">
	         </div>
			 <div class="pading5Width450">
	         	<label class="labelFontSize">랙 위치</label>
	         	<select class="form-control selectpicker selectForm" id="serverListRackPositionView" name="serverListRackPositionView" data-live-search="true" data-size="5">
					<option value=""></option>	 
					<c:if test="${serverList.serverListType eq 'externalEquipment'}">        	
				    	<option value="P1" <c:if test="${serverList.serverListRackPosition eq 'P1'}">selected</c:if>>P1</option>
				    	<option value="Q1" <c:if test="${serverList.serverListRackPosition eq 'Q1'}">selected</c:if>>Q1</option>
				    	<option value="Q2" <c:if test="${serverList.serverListRackPosition eq 'Q2'}">selected</c:if>>Q2</option>
				    	<option value="Q3" <c:if test="${serverList.serverListRackPosition eq 'Q3'}">selected</c:if>>Q3</option>
				    	<option value="Q4" <c:if test="${serverList.serverListRackPosition eq 'Q4'}">selected</c:if>>Q4</option>
				    	<option value="W1" <c:if test="${serverList.serverListRackPosition eq 'W1'}">selected</c:if>>W1</option>
				    	<option value="S1" <c:if test="${serverList.serverListRackPosition eq 'S1'}">selected</c:if>>S1</option>
			    	</c:if>
			    	<c:if test="${serverList.serverListType eq 'internalEquipment'}">
			    		<option value="D1" <c:if test="${serverList.serverListRackPosition eq 'D1'}">selected</c:if>>D1</option>
			    		<option value="D2" <c:if test="${serverList.serverListRackPosition eq 'D2'}">selected</c:if>>D2</option>
			    		<option value="D3" <c:if test="${serverList.serverListRackPosition eq 'D3'}">selected</c:if>>D3</option>
			    		<option value="D4" <c:if test="${serverList.serverListRackPosition eq 'D4'}">selected</c:if>>D4</option>
			    		<option value="D5" <c:if test="${serverList.serverListRackPosition eq 'D5'}">selected</c:if>>D5</option>
			    		<option value="D6" <c:if test="${serverList.serverListRackPosition eq 'D6'}">selected</c:if>>D6</option>
			    		<option value="D7" <c:if test="${serverList.serverListRackPosition eq 'D7'}">selected</c:if>>D7</option>
			    		<option value="D8" <c:if test="${serverList.serverListRackPosition eq 'D8'}">selected</c:if>>D8</option>
			    		<option value="D9" <c:if test="${serverList.serverListRackPosition eq 'D9'}">selected</c:if>>D9</option>
			    		<option value="D10" <c:if test="${serverList.serverListRackPosition eq 'D10'}">selected</c:if>>D10</option>
			    		<option value="D11" <c:if test="${serverList.serverListRackPosition eq 'D11'}">selected</c:if>>D11</option>
			    		<option value="Q1" <c:if test="${serverList.serverListRackPosition eq 'Q1'}">selected</c:if>>Q1</option>
			    	</c:if>
			    	<c:if test="${serverList.serverListType eq 'hyperV'}">
			    		<option value="#90" <c:if test="${serverList.serverListRackPosition eq '#90'}">selected</c:if>>#90</option>
			    		<option value="#160" <c:if test="${serverList.serverListRackPosition eq '#160'}">selected</c:if>>#160</option>
			    		<option value="#210" <c:if test="${serverList.serverListRackPosition eq '#210'}">selected</c:if>>#210</option>
			    	</c:if>
				</select>
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize" style="width:100%">사용기간</label>
	         	<input type="date" id="serverListPeriodUseStartView" name="serverListPeriodUseStartView" class="form-control viewForm" value="${serverList.serverListPeriodUseStart}" style="float: left; width: 47%;" max="9999-12-31">
	         	<span style="margin-left: 9px;">~</span>
	         	<input type="date" id="serverListPeriodUseEndView" name="serverListPeriodUseEndView" class="form-control viewForm" value="${serverList.serverListPeriodUseEnd}" style="float: right; width: 47%;"  max="9999-12-31">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">사용자</label>
	         	<input type="text" id="serverListUserView" name="serverListUserView" class="form-control viewForm" value="${serverList.serverListUser}">
	         </div>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">관리자</label>
	         	<input type="text" id="serverListManagerView" name="serverListManagerView" class="form-control viewForm" value="${serverList.serverListManager}">
	         </div>
	         <c:choose>
		         <c:when test="${viewType eq 'insert'}">
			         <div class="pading5Width450">
			         	<label class="labelFontSize">최종 수정일</label>
			         	<input type="date" id="serverListLastModifiedDateView" name="serverListLastModifiedDateView" class="form-control viewForm" value="${serverList.nowDate}" max="9999-12-31">
			         </div>
		         </c:when>
		         <c:when test="${viewType eq 'update'}">
		         	<div class="pading5Width450">
			         	<label class="labelFontSize">최종 수정일</label>
			         	<input type="date" id="serverListLastModifiedDateView" name="serverListLastModifiedDateView" class="form-control viewForm" value="${serverList.serverListLastModifiedDate}" max="9999-12-31">
			         </div>
		         </c:when>
		     </c:choose>
	         <div class="pading5Width450">
	         	<label class="labelFontSize">비고</label>
	         	<input type="text" id="serverListNoteView" name="serverListNoteView" class="form-control viewForm" value="${serverList.serverListNote}">
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
	
	/* =========== 서버목록 추가 ========= */
	$('#insertBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		var serverListAssetNum = $('#serverListAssetNumView').val();
		if(serverListAssetNum == "") {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '자산번호를 반드시 입력 바랍니다.',    
			}); 
			$('#NotServerListAssetNum').show();
		} else {
			$('#NotServerListAssetNum').hide();
			$.ajax({
				url: "<c:url value='/serverList/insert'/>",
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
					} else if(result.result == "AssetNumOverlap") {
						Swal.fire({
							icon: 'error',
							title: '중복!',
							text: '중복되는 자산번호가 존재합니다.',
						});
					} else if(result.result == "DateOver") {
						Swal.fire({
							icon: 'error',
							title: '기간!',
							text: '사용기간이 종료기간 보다 큼니다.',
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
		}
	});
	
	/* =========== 서버목록 수정 ========= */
	$('#updateBtn').click(function() {
		var postData = $('#modalForm').serializeObject();
		if(serverListAssetNum == "") {
			Swal.fire({               
				icon: 'error',          
				title: '실패!',           
				text: '자산번호를 반드시 입력 바랍니다.',    
			}); 
			$('#NotServerListAssetNum').show();
		} else {
			$('#NotServerListAssetNum').hide();
			$.ajax({
				url: "<c:url value='/serverList/update'/>",
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
					} else if(result.result == "AssetNumOverlap") {
						Swal.fire({
							icon: 'error',
							title: '중복!',
							text: '중복되는 자산번호가 존재합니다.',
						});
					} else if(result.result == "DateOver") {
						Swal.fire({
							icon: 'error',
							title: '기간!',
							text: '사용기간이 종료기간 보다 큼니다.',
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
	});
	
	$("#serverListPeriodUseStartView").change(function() {
		var start = $('#serverListPeriodUseStartView').val();
		var end = $('#serverListPeriodUseEndView').val();
		if(end != "") {
			if(start > end) {
				Swal.fire({
					icon: 'error',
					title: '기간!',
					text: '사용기간이 종료기간 보다 큼니다.',
				});
			} 
		}
	});
	
	$("#serverListPeriodUseEndView").change(function() {
		var start = $('#serverListPeriodUseStartView').val();
		var end = $('#serverListPeriodUseEndView').val();
		if(start == "") {
			$('#serverListPeriodUseStartView').val(end);
		}
		if(start > end) {
			Swal.fire({
				icon: 'error',
				title: '기간!',
				text: '사용기간이 종료기간 보다 큼니다.',
			});
		} 
	});
	
</script>