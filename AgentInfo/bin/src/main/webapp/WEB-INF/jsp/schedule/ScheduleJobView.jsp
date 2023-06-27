<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<div class="modelHead">
	<div class="modelHeadFont">스케쥴 설정</div>
</div>
<div class="modal-body modalBody" style="width: 100%; height: 275px;">
	<table style="width: 100%;">
		<tbody>
			<tr class="height36">
				<td>스케쥴명 :</td><td><input class="form-control" type="text" id="scheduleName" value="${scheduleJob.scheduleName}" readonly></td>
			</tr>
			<tr class="height36">
				<td>설명 : </td><td><input class="form-control" type="text" id="scheduleExplantion" value="${scheduleJob.scheduleExplantion}" readonly></td>
			</tr>
			<tr class="height36">
				<td>CronExpression : </td><td><input class="form-control" type="text" id="scheduleCron" value="${scheduleJob.scheduleCron}"></td>
			</tr>
			<tr class="height36">
				<td>상태 : </td><td><input class="form-control" type="text" id="scheduleStateResult" value="${scheduleJob.scheduleState}" readonly></td>
			</tr>
			<tr class="height36">
				<td>시작 시간:</td>
				<td>
					<select id="startHour">
							<option value="0">00</option>
							<option value="1">01</option>
							<option value="2">02</option>
							<option value="3">03</option>
							<option value="4">04</option>
							<option value="5">05</option>
							<option value="6">06</option>
							<option value="7">07</option>
							<option value="8">08</option>
							<option value="9">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
					</select> :
					<select id="startMinute">
							<option value="0">00</option>
							<option value="1">01</option>
							<option value="2">02</option>
							<option value="3">03</option>
							<option value="4">04</option>
							<option value="5">05</option>
							<option value="6">06</option>
							<option value="7">07</option>
							<option value="8">08</option>
							<option value="9">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
					</select> 스케줄
				</td>
			</tr>
			<tr class="height36">
				<td>반복 주기:</td>
				<td>
					<select id="intervalHour">
							<option value="0">00</option>
							<option value="1">01</option>
							<option value="2">02</option>
							<option value="3">03</option>
							<option value="4">04</option>
							<option value="5">05</option>
							<option value="6">06</option>
							<option value="7">07</option>
							<option value="8">08</option>
							<option value="9">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
					</select> 
					<select id="intervalMinute" style="display: none;">
							<option value="0">00</option>
							<option value="1">01</option>
							<option value="2">02</option>
							<option value="3">03</option>
							<option value="4">04</option>
							<option value="5">05</option>
							<option value="6">06</option>
							<option value="7">07</option>
							<option value="8">08</option>
							<option value="9">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
					</select> 
					<select id="timeUnit">
						<option value="hour">시</option>
						<option value="minute">분</option>
					</select> 마다
				</td>
			</tr>
			<tr class="height36">
				<td>사용여부 : </td>
				<td>
					<select class="form-control" id="scheduleState" name="scheduleState" style="width:110px">
						<option value="사용안함" <c:if test="${scheduleJob.scheduleState eq '사용안함'}">selected</c:if>>미사용</option>
						<option value="사용" <c:if test="${scheduleJob.scheduleState eq '사용'}">selected</c:if>>사용</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="modal-footer">
	<button class="btn btn-default btn-outline-info-add" id="BtnScheduleView" onClick="BtnScheduleView()">확인</button>
    <button class="btn btn-default btn-outline-info-nomal" data-dismiss="modal">닫기</button>
</div>

<script>
	/* =========== 스케쥴 설정 ========= */
	function BtnScheduleView() {
		var scheduleName = $('#scheduleName').val();
		var scheduleState = $('#scheduleState').val();
		var scheduleCron = $('#scheduleCron').val();
		$.ajax({
			url: "<c:url value='/schedule/update'/>",
			type: "POST",
			data: {
					"scheduleName": scheduleName,
					"scheduleState" : scheduleState,
					"scheduleCron" : scheduleCron,
				},
			async: false,
			success: function(data) {
				if(data == "OK"){
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
			error: function(e) {
		    	console.log(e);
		    }
		});
	}
	
	/* =========== 시간 설정 ========= */
	$(function() {
		updateSimpleSchedule();						// 초기 설정
        $("#timeUnit").change(onChangeTimeUnit);	// 반복 주기의 시, 분 변경 시
        $("#startHour,#startMinute,#intervalHour,#intervalMinute").change(updateCronExpression);	// 숫자 시간 변경 시 
	});
	
	/* =========== 반복 주기 시, 분 변경 ========= */
	function onChangeTimeUnit() {
        var timeUnit = $("#timeUnit").val();

        // 반복주기가 분단위 일경우는 시작시간은 00:00 으로 고정하고 변경불가.
        if ( timeUnit == "hour" ) {
                $("#startHour").attr('disabled', false);
                $("#startMinute").attr('disabled', false);
                $("#intervalHour").show();
                $("#intervalMinute").hide();
        } else {
                $("#startHour").attr('disabled', true);
                $("#startMinute").attr('disabled', true);
                $("#intervalHour").hide();
                $("#intervalMinute").show();
        }

        if ( timeUnit == "hour" ) {
                $("#startHour").val("0");
                $("#startMinute").val("0");
                $("#intervalHour").val("1");
                $("#intervalMinute").val("0");
        } else {
                $("#startHour").val("0");
                $("#startMinute").val("0");
                $("#intervalHour").val("0");
                $("#intervalMinute").val("1");
        }

        updateCronExpression();
	}
	
	/* =========== 숫자 시간 변경 Cron 변경 ========= */
    function updateCronExpression() {
            var startHour = $("#startHour").val();
            var startMinute = $("#startMinute").val();
            var intervalHour = "0";
            var intervalMinute = "0";
            var timeUnit = $("#timeUnit").val();

            if ( timeUnit == "hour" ) {
                    intervalHour = $("#intervalHour").val();
                    if ( intervalHour != "0" ) {
                            startHour = startHour + "/" + intervalHour;
                    }
            } else {
                    intervalMinute = $("#intervalMinute").val();
                    if ( intervalMinute != "0" ) {
                            // 반복주기가 분단위일 경우는 매 시간마다 반복하도록 설정
                            startHour = "*";
                            startMinute = startMinute + "/" + intervalMinute;
                    }
            }

            var scheduleCron = "0 " + startMinute + " " + startHour + " * * ?";

            $("#scheduleCron").val(scheduleCron);
    }
	
    /* =========== 초반 기본 설정 ========= */
	function updateSimpleSchedule() {
	    $("#startHour").val("0");
	    $("#startMinute").val("0");
	    $("#intervalHour").val("0").show();
	    $("#intervalMinute").val("0").hide();
	    $("#timeUnit").val("hour");
	
	    var scheduleCron = $("#scheduleCron").val();
	    var tokens = scheduleCron.split(" ");
	    var startHour = tokens[2];
	    var startMinute = tokens[1];
	    var interval = "";
	    var timeUnit = "";
	
	    var pos;
	    if ( (pos = startHour.indexOf("/")) > -1 ) {
	            interval = startHour.substring(pos+1);
	            timeUnit = "hour";
	            startHour = startHour.substring(0, pos);
	
	            $("#intervalHour").val(interval).show();
	            $("#intervalMinute").val("0").hide();
	            $("#timeUnit").val(timeUnit);
	    }
	    else if ( (pos = startMinute.indexOf("/")) > -1 ) {
	            interval = startMinute.substring(pos+1);
	            timeUnit = "minute";
	            startMinute = startMinute.substring(0, pos);
	
	            $("#intervalHour").val("0").hide();
	            $("#intervalMinute").val(interval).show();
	            $("#timeUnit").val(timeUnit);
	    }
	
	    $("#startHour").val(startHour);
	    $("#startMinute").val(startMinute);
	
	    var timeUnit = $("#timeUnit").val();
	
	    // 반복주기가 분단위 일경우는 시작시간은 00:00 으로 고정하고 변경불가.
	    if ( timeUnit == "hour" ) {
	            $("#startHour").attr('disabled', false);
	            $("#startMinute").attr('disabled', false);
	            $("#intervalHour").show();
	            $("#intervalMinute").hide();
	    } else {
	            $("#startHour").attr('disabled', true);
	            $("#startMinute").attr('disabled', true);
	            $("#intervalHour").hide();
	            $("#intervalMinute").show();
	    }
    };
</script>