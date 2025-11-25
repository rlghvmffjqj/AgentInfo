<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modelHead">
	<div class="modelHeadFont">담당자 변경</div>
</div>
<div class="modal-body" style="width: 100%; height: 175px;">
	<div style="width: 100%;height: 80px; text-align: center;">
		<div class="form-check radioDate">
		    <input class="cssCheck" type="checkbox" id="CheckRequester" name="requester" checked>
		    <label for="CheckRequester"><span class="margin17">요청자(담당 엔지니어)</span></label>
		</div>
		
		<div class="form-check radioDate">
		    <input class="cssCheck" type="checkbox" id="CheckSalesManager" name="salesManager">
		    <label for="CheckSalesManager"><span class="margin17">담당 영업</span></label>
		</div>
	</div>

	<div class="pading5Width450" style="padding-left: 10%; padding-right: 10%;">
		<label class="labelFontSize">사원명(계정)</label>
		<input type="text" id="employeeNameId" name="employeeNameId" class="form-control viewForm">
		<button class="btn custom-btn" type="button" onclick="employeeSearch()" style="margin-right: 7px; background: #ffc4c4; margin-top: -32px; height: 35px; float: right; margin-right: -20px;">검색</button>
	</div>
</div>
<div class="modal-footer">
    <button class="btn btn-default btn-outline-info-add" onClick="BtnChange()">변경</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	function BtnChange() {
		var selectedManager = $(".form-check input[type='checkbox']:checked").attr("name");
		var employeeNameId = $('#employeeNameId').val();
		var chkList = JSON.parse('${chkListJson}');

		$.ajax({
			url: "<c:url value='/${licenseType}/managerChange'/>",
			type: "POST",
			data: {
				"selectedManager" : selectedManager,
				"employeeNameId" : employeeNameId,
				chkList : chkList
			},
			dataType: "text",
			async: false,
			traditional: true,
			success: function(data) {
				if(data == "OK"){
					Swal.fire({
						icon: 'success',
						title: '성공!',
						text: '담당자 변경 성공하였습니다.',
					});
					$('#modal').modal("hide"); // 모달 닫기
		    		$('#modal').on('hidden.bs.modal', function () {
	            		tableRefresh();
	            	});
				} else{
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '작업을 실패하였습니다.',
					});
				}
			},
			error: function(e) {
		    	console.log(e);
		    }
		});
	};

	$(document).ready(function () {
	    $("#CheckRequester").change(function () {
	        if ($(this).is(":checked")) {
	            $("#CheckSalesManager").prop("checked", false);
	        }
	    });

	    $("#CheckSalesManager").change(function () {
	        if ($(this).is(":checked")) {
	            $("#CheckRequester").prop("checked", false);
	        }
	    });
	});

	$(function() {
		function split(val) {
		    return val.split(/,\s*/);
		}

		function extractLast(term) {
		    return split(term).pop();
		}

		$("#employeeNameId").on("keydown", function(event) {
		    if (event.keyCode === $.ui.keyCode.TAB &&
		        $(this).data("ui-autocomplete")?.menu.active) {
		        event.preventDefault();
		    }
		}).autocomplete({
		    minLength: 1,
		    source: function(request, response) {
		        const term = extractLast(request.term);
		        $.ajax({
		            url: "<c:url value='/employee/inputSearch'/>",
		            type: 'post',
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
		        return false; // 입력창에 자동 채우기 방지
		    },
		    select: function(event, ui) {
		        let terms = split(this.value);
		        terms.pop(); // 현재 입력중인 단어 제거
		        terms.push(ui.item.value);
		        terms.push(""); // 다음 입력을 위해 빈 문자열 추가
		        this.value = terms.join("");
		        return false;
		    }
		});

	})

	function employeeSearch() {
		window.open("<c:url value='/employee/salesManagerSearch'/>?selectType=requester", '', 'width=1000,height=690,scrollbars=yes,resizable=yes');
	}

	function setRequester(employeeId, employeeName) {
		$('#employeeNameId').val(employeeName+"("+employeeId+")");
	}

</script>
<style>
	.radioDate {
	    float: left;
	    width: 50%;
	    height: 60px;
	    align-content: center;
		text-align: left;
    	padding-left: 10%;
	}

	.margin17 {
		display: ruby-text;
	}
</style>