<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<link href="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.5/dist/fullcalendar.min.css" rel="stylesheet">
		<link href="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.5/dist/fullcalendar.print.css" rel="stylesheet" media="print">
		<script src="https://cdn.jsdelivr.net/npm/moment@2/min/moment.min.js"></script>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.5/dist/fullcalendar.min.js"></script>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','calendar');
		    });
	    </script>
	    <style>
	    	html, body {
			  margin: 0;
			  padding: 0;
			  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
			  font-size: 14px;
			}
			
			.fl_left {
				float: left;
				margin: 1px;
			}
			
			#external-events {
			  position: fixed;
			  z-index: 2;
			  top: 28%;
			  width: 210px;
			  padding: 10px 10px 10px 10px;
			  border: 1px solid #ccc;
			  background: #eee;
			  height: 340px;
			}
			
			#external-events2 {
				position: fixed;
			    z-index: 2;
			    top: 65%;
			    width: 210px;
			    padding: 10px 10px 10px 10px;
			    border: 1px solid #ccc;
			    background: #eee;
	    	}
			
			#external-events .fc-event {
			  cursor: move;
			  margin: 3px 0;
			  padding: 1px;
			}
			
			#calendar-container {
			  position: relative;
			  z-index: 0;
			}
			
			#calendar {
			  max-width: 85%;
    		  margin-left: 230px;
			}
	    	
	    </style>
	</head>
	<body>
		<div id="pcoded" class="pcoded iscollapsed">
			<div class="pcoded-overlay-box"></div>
			<div class="pcoded-container navbar-wrapper">
				<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>
				<%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
				<div class="pcoded-main-container" style="margin-top: 56px;">
					<div class="pcoded-wrapper">
						<%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
						<div class="pcoded-content" id="page-wrapper">
							<div class="page-header">
								<div class="page-block">
									<div class="row align-items-center">
									    <div class="col-md-8">
									        <div class="page-header-title" >
									            <h5 class="m-b-10">달력</h5>
									            <p class="m-b-0">Calendar</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">달력</a>
									            </li>
									        </ul>
									    </div>
									</div>
								</div>
							</div>
	                        <div class="pcoded-inner-content">
	                            <div class="main-body">
	                                <div class="page-wrapper">
	                                	<div class="ibox">
	                                		<div style="background: white; padding: 20px; box-shadow: 1px 1px 1px grey; width: 1627px;">
	                                			<div id='external-events'>
												  <div class="box box-solid" id="dragEvent">
													<div class="box-header with-border">
														<h4 class="box-title">일정 목록</h4>
													</div>
													<div class="box-body">
														<div class="add-node external-events" style="height: 265px; margin-bottom: 5px;">
															<c:forEach var="item" items="${calendarList}">
																<div class="fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event" style="color: white; background-color:${item.calendarListColor}; border: 1px ${item.calendarListColor}">${item.calendarListContents}</div>
															</c:forEach>
														</div>
														<div class="checkbox">
															<label for="drop-remove"> <input type="checkbox"
																id="drop-remove"> 이동 후 삭제
															</label>
														</div>
													</div>
													</div>
												</div>
												<div id='external-events2'>
													<div class="box box-solid" id="createEvent">
														<div class="box-header with-border">
															<h4 class="box-title">일정 생성</h4>
														</div>
														<div class="box-body">
															<div class="btn-group" style="width: 100%; margin-bottom: 10px;">
																<ul class="fc-color-picker" id="color-chooser">
																	<li class="fl_left"><a class="text-primary" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-warning" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-default" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-danger" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-success" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-inverse" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-info" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-custom" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-pink" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-purple" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-dark" href="#"><i class="fa fa-square"></i></a></li>
																	<li  class="fl_left"><a class="text-muted" href="#"><i class="fa fa-square"></i></a></li>
																</ul>
															</div>
															<div class="input-group">
																<input id="new-event" type="text" class="form-control" placeholder="Event Title">
																<div class="input-group-btn">
																	<button id="add-new-event" type="button" class="btn btn-primary btn-flat">Add</button>
																</div>
															</div>
														</div>
													</div>
												</div>
												
												<div id='calendar-container'>
													<div id="calendarTrash" class="calendar-trash" style="margin-left: 14.5%; margin-bottom: 5px;">
														<img  src="/AgentInfo/images/trash.png" style="width:25px">
													</div>
												  	<div id='calendar'></div>
												</div>
	                                		</div>
	                     				</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>
	
	<script>
		var list = JSON.parse('${calendar}'); // List 결과 (자바스크립트 객체)를 문자열로 변환하여 list에 담음
		var dataList = [];
	
		// 날짜 변환 함수
		function myDateConverter(data){ // return된 날짜 잘라서 Date형식으로 집어넣으려고 만듬
			var month = data.split("월")[0];
			var day = data.split(" ")[1].split(",")[0];
			var year = data.split(", ")[1];

			return new Date(year, month-1, day); // month 배열형식으로들어가서 -1 해줘야 +1월안됨
		}
		
		for(var i in list){
			var obj = {};
			obj._id = list[i].calendarKeyNum;
			obj.title = list[i].calendarContents;
			obj.start = list[i].calendarStart;
			if(list[i].calendarEnd != null){
				obj.end = list[i].calendarEnd;
			}
			obj.allDay = false;
			obj.backgroundColor = list[i].calendarColor;
			obj.borderColor = list[i].calendarColor
			dataList.push(obj);
		}
	
		$(function() {
			function ini_events(ele) {
				ele.each(function () {
					var eventObject = {
						title: $.trim($(this).text())
					};

					$(this).data('eventObject', eventObject);
					
					$(this).draggable({
						zIndex: 1070,
						revert: true,
						revertDuration: 0
					});
				});
			}
			ini_events($('#external-events div.fc-event'));
			
			var date = new Date();
			var d = date.getDate(), m = date.getMonth(), y = date.getFullYear();

			$('#calendar').fullCalendar({
				header: {
				  left: 'prev,next today',
				  center: 'title',
				  right: 'month,agendaWeek,agendaDay,listMonth'
				},
				events : dataList,
				timeFormat: 'H:mm',
				locale : 'ko', // 한국어설정
				navLinks: true,
				dayMaxEvents: true,		      
				eventLimit : true, // 달력에 표시될 일정 개수 제한
				selectable : true, // 마우스로 클릭한 위치확인용(추가용으로는 쓰지않음)
				editable: true,
				droppable: true,
				loading: function(bool) {
					$('#loading').toggle(bool);
				},
				drop: function (date, allDay) {
					var originalEventObject = $(this).data('eventObject');
					var copiedEventObject = $.extend({}, originalEventObject);
					copiedEventObject.start = date;
					copiedEventObject.allDay = allDay;
					copiedEventObject.backgroundColor = $(this).css("background-color");
					copiedEventObject.borderColor = $(this).css("border-color");
					copiedEventObject.color = $(this).css("color");
					$.ajax({
						url: "<c:url value='/calendar/insert'/>",
						type: 'post',
						data : {
							'calendarStartDate' : copiedEventObject.start._d.getTime(),
							'calendarContents' : copiedEventObject.title,
							'calendarColor' : copiedEventObject.backgroundColor
						},
						async: false,
						success : function(result) {
							copiedEventObject.calendarKeyNum = result.result;
							copiedEventObject._id = result.result;
						},
							error: function(error) {
							console.log(error);
						}
					});
					$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
				    
					if ($('#drop-remove').is(':checked')) {
						$(this).remove();
					}
				},
				eventResize : function(event, delta, revertFunc, jsEvent, ui, view) {
					Swal.fire({
						title: '변경!',
						text: "기간을 변경 하시겠습니까?",
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#7066e0',
						cancelButtonColor: '#FF99AB',
						confirmButtonText: '예'
					}).then((result) => {
						if (result.isConfirmed) {
							$.ajax({
								type: 'post',
								url: "<c:url value='/calendar/move'/>",
								data : {
									'calendarKeyNum' : event._id,
									'calendarStartDate' : event.start._d.getTime(),
									'calendarEndDate' : event.end._d.getTime()
								},
								async: false,
								success : function(result){
									if(result.result == "FALSE") {
										Swal.fire(
										  '실패!',
										  '실패하였습니다.',
										  'error'
										)
									}
								}, error : function(error){
									console.log(error);
								}
							});
						} else {
							revertFunc();
						}
					});
				},
				eventDrop: function(event, delta, revertFunc) {
					event.start._d.setHours(event.start._d.getHours() -9);
					if(event.end != null)
						event.end._d.setHours(event.end._d.getHours() -9);
					Swal.fire({
						title: '변경!',
						text: "일정을 변경 하시겠습니까?",
						icon: 'warning',
						showCancelButton: true,
						confirmButtonColor: '#7066e0',
						cancelButtonColor: '#FF99AB',
						confirmButtonText: '예'
					}).then((result) => {
						if (result.isConfirmed) {
							$.ajax({
								type: 'post',
								url: "<c:url value='/calendar/move'/>",
								data : {
									'calendarKeyNum' : event._id,
									'calendarStartDate' : event.start._d.getTime(),
									'calendarEndDate' : (event.end != null) ? event.end._d.getTime() : event.start._d.getTime()
								},
								async: false,
								success : function(result){
									if(result.result == "FALSE") {
										Swal.fire(
											'실패!',
											'실패하였습니다.',
											'error'
										)
									}
								}, error : function(error){
									console.log(error);
								}
							});
						} else {
							revertFunc();
						}
					});
				},
				eventDragStop: function(event,jsEvent) {
					var trashEl = jQuery('#calendarTrash');
					var ofs = trashEl.offset();
					var x1 = ofs.left;
					var x2 = ofs.left + trashEl.outerWidth(true);
					var y1 = ofs.top;
					var y2 = ofs.top + trashEl.outerHeight(true);
					if (jsEvent.pageX >= x1 && jsEvent.pageX<= x2 && jsEvent.pageY >= y1 && jsEvent.pageY <= y2) {
						Swal.fire({
							title: '삭제!',
							text: "일정을 삭제 하시겠습니까?",
							icon: 'warning',
							showCancelButton: true,
							confirmButtonColor: '#7066e0',
							cancelButtonColor: '#FF99AB',
							confirmButtonText: '예'
						}).then((result) => {
							if (result.isConfirmed) {
								$('#calendar').fullCalendar('removeEvents', event._id);
								$.ajax({
									type: 'post',
									url: "<c:url value='/calendar/delete'/>",
									data : {
										'calendarKeyNum' : event._id
									},
									async: false,
									success : function(result){
										if(result.result == "FALSE") {
											Swal.fire(
												'실패!',
												'실패하였습니다.',
												'error'
											)
										}
									}, error : function(error){
										console.log(error);
									}
								});
							}
						});
					}
				},
				eventClick: function(calEvent, jsEvent, view) {
					console.log(calEvent);
					console.log(jsEvent);
					console.log(view);
				}
			});
		    
			var currColor = 'darkgoldenrod';
			var colorChooser = $('#color-chooser-btn');
			$('#color-chooser > li > a').click(function(e) {
				e.preventDefault();
				currColor = $(this).css('color');
				$('#add-new-event').css({
					'background-color' : currColor,
					'border-color' : currColor
				});
			});
			
			$('#add-new-event').click(function(e) {
				var tabCount = $(".ui-draggable-handle").length;
				if(tabCount >= 12) {
					Swal.fire({               
						icon: 'error',          
						title: '제한',           
						text: '일정 생성은 최대 12개로 제한 하였습니다. 일정 목록 정리 후 생성 바랍니다.',    
					}); 
					return;
				}
				e.preventDefault();
				var val = $('#new-event').val()
				if (val.length == 0) {
					return;
				}
				$.ajax({
					url: "<c:url value='/calendarList/insert'/>",
					type: 'post',
					data: {
						'calendarListContents':val,
						'calendarListColor':currColor
					},
					async: false,
					success: function(result) {
						if(result.result == "OK") {
							var event = $('<div class="fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event ui-draggable ui-draggable-handle" />');
							event.css({
								'background-color' : currColor,
								'border-color' : currColor,
								'color' : '#fff'
							}).addClass('external-event');
							event.html(val);
							$('.add-node').prepend(event);
							ini_events(event);
							$('#new-event').val('');
						} else if(result.result == "overlap") {
							Swal.fire({
								icon: 'error',
								title: '중복!',
								text: '중복된 일정 목록이 존재합니다.',
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
		});
	</script>
</html>