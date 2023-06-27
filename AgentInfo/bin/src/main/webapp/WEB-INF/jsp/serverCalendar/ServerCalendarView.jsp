<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<style>
	.modal-footer {
		padding: 0;
	}
	
	.serverCalendarColor {
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		background-color: transparent;
		width: 30px;
		height: 30px;
		border: none;
		cursor: pointer;
		margin-top: 20px;
	}
	
	.serverCalendarColor::-webkit-color-swatch {
		border-radius: 50%;
		border: 0;
	}
	
	.form-control {
		color: black;
	}
	
	h4 {
		color: black;
	}
	
</style>

<div class="modal-body" style="width: 100%; height: 400px;">
	<div style="padding: 5px;">
		<form class="form-material" id="modalForm" name="form" method ="post">
			<input type="hidden" id="serverCalendarKeyNum" name="serverCalendarKeyNum" class="form-control viewForm" value="${serverCalendar.serverCalendarKeyNum}">
			<div class="form-group form-default" style="float: left; width: 93%; margin-top: 10px;">
				<input type="text" class="form-control" id="serverCalendarContents" name="serverCalendarContents" maxlength="50" value="${serverCalendar.serverCalendarContents}" required>
				<span class="form-bar"></span>
				<label class="float-label">제목</label>
			</div>
			<input class="serverCalendarColor" type="color" id="serverCalendarColor" name="serverCalendarColor" value="${serverCalendar.serverCalendarColor}">
			<div style="margin-top: 35px;">
				<img class="img-fluid" src="/AgentInfo/images/24H.png" style="width:30px; float:left;">
				<h4 style="float:left; width: 76%; margin: 5px; font-weight: bold; margin-left: 12px;">하루 종일</h4>
				<label class="switch" style="margin-top: 2px; float: right;">
				    <input type="checkbox" id="serverCalendarAllDay" name="serverCalendarAllDay" onclick="" <c:if test="${serverCalendar.serverCalendarAllDay}">checked</c:if>>
				    <span class="slider round"></span>
				</label>
			</div>
			<div style="margin-top:20px;">
				<input type='text' class="form-control" id='serverCalendarStart' name="serverCalendarStart" style="width:205px; float:left; font-size: 1.375rem; margin-top: 25px;" value="${serverCalendar.serverCalendarStart}"/>
				<img class="img-fluid" src="/AgentInfo/images/right.png" style="width: 25px; margin-top: 30px; float:left;">
				<input type='text' class="form-control" id='serverCalendarEnd' name="serverCalendarEnd" style="width:210px; float:left; font-size: 1.375rem;; margin-top: 20px; margin-left: 15px;" value="${serverCalendar.serverCalendarEnd}" />
			</div>
			<div style="margin-top: 165px;">
				<img class="img-fluid" src="/AgentInfo/images/email.png" style="width:35px; float:left; margin-top: 3px;">
				<div class="form-group form-default" style="float: right; width: 90%;">
					<input type="text" class="form-control" id="serverCalendarDepartment" name="serverCalendarDepartment" maxlength="50" value="${serverCalendar.serverCalendarDepartment}" required>
					<span class="form-bar"></span>
					<label class="float-label">부서</label>
				</div>
			</div>
			<div style="margin-top: 240px;">
				<img class="img-fluid" src="/AgentInfo/images/watch.png" style="float:left; width: 30px; margin-left: 3px;">
				<h4 style="float:left; width: 76%;"><input type="time" id="serverCalendarAlarm" name="serverCalendarAlarm" style="border: 0; margin: 4px; margin-left: 11px; font-weight: bold;" value="${serverCalendar.serverCalendarAlarm}"></h4>
				<label class="switch" style="margin-top: 2px; float: right;">
				    <input type="checkbox" id="serverCalendarAlarmYn" name="serverCalendarAlarmYn" onclick="" <c:if test="${serverCalendar.serverCalendarAlarmYn}">checked</c:if>>
				    <span class="slider round"></span>
				</label>
			</div>
		</form>
	</div>
</div>
<div class="modal-footer">
	<button class="calendarModalFooter" id="serverCalendarSave" style="border-right: 1px solid navajowhite;">저장</button>
	<button class="calendarModalFooter" id="serverCalendarClose">닫기</button>
</div>

<script>
	$(function () {
		$('#serverCalendarStart').datetimepicker();
		$('#serverCalendarEnd').datetimepicker();
	});
	
	$("#serverCalendarStart").change(function() {
		var start = $('#serverCalendarStart').val();
		var end = $('#serverCalendarEnd').val();
		if(start > end) {
			Swal.fire({
				icon: 'error',
				title: '기간!',
				text: '시작기간이 종료기간 보다 큼니다.',
			});
		} else if(start == end) {
			$("#serverCalendarAllDay").prop("checked", true);
		} else if(start != end) {
			$("#serverCalendarAllDay").prop("checked", false);
		}
	});
	
	$("#serverCalendarEnd").change(function() {
		var start = $('#serverCalendarStart').val();
		var end = $('#serverCalendarEnd').val();
		if(start > end) {
			Swal.fire({
				icon: 'error',
				title: '기간!',
				text: '시작기간이 종료기간 보다 큼니다.',
			});
		} else if(start == end) {
			$("#serverCalendarAllDay").prop("checked", true);
		} else if(start != end) {
			$("#serverCalendarAllDay").prop("checked", false);
		}
	});
	
	$('#serverCalendarClose').click(function() {
		$('#modal').modal("hide"); // 모달 닫기
	});
	
	$('#serverCalendarSave').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/serverCalendar/save'/>",
	        type: 'post',
	        data: postData,
	        async: false,
	        success: function(result) {
				if(result.result == "OK") {
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '작업을 완료했습니다.',
					}).then((result) => {
						console.log(result);
						if(result.isConfirmed == true) {
							$('#modal').modal("hide"); // 모달 닫기
			        		$('#modal').on('hidden.bs.modal', function () {
			        			location.reload();
			        		});
						}
					});
				} else if(result.result == "DateOver") {
					Swal.fire({
						icon: 'error',
						title: '기간!',
						text: '시작기간이 종료기간 보다 큼니다.',
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
</script>

