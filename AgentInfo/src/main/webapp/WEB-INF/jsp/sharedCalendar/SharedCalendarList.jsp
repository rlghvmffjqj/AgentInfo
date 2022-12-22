<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- fullcalendar -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/fullcalendar/fullcalendar.min.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/fullcalendar/fullcalendar.print.css'/>"  media="print">
		<script type="text/javascript" src="<c:url value='/fullcalendar/moment.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/fullcalendar/fullcalendar.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/fullcalendar/locale-all.min.js'/>"></script>

		<!-- datetimepicker -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/datetimepicker/jquery.datetimepicker.min.css'/>">
		<script type="text/javascript" src="<c:url value='/datetimepicker/jquery.datetimepicker.full.min.js'/>"></script>
		
		<!-- map -->
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8yvu58b01c&submodules=geocoder"></script>
	
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','sharedCalendar');
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
			
			#sharedCalendar-container {
			  position: relative;
			  z-index: 0;
			}
			
			#sharedCalendar {
			  max-width: 85%;
    		  margin-left: 230px;
			}
			
			.fc-time-grid-event .fc-content {
				color: white;
			}
			
			.fc-time-grid-container {
				height: 100% !important;
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
									            <h5 class="m-b-10">부서 일정 관리</h5>
									            <p class="m-b-0">Department Schedule Management</p>
									        </div>
									    </div>
									    <div class="col-md-4">
									        <ul class="breadcrumb-title">
									            <li class="breadcrumb-item">
									                <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
									            </li>
									            <li class="breadcrumb-item"><a href="#!">부서 일정 관리</a>
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
															<c:forEach var="item" items="${sharedCalendarList}">
																<div class="fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event" style="color: white; background-color:${item.sharedCalendarListColor}; border: 1px ${item.sharedCalendarListColor}">${item.sharedCalendarListContents}</div>
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
												
												<div id='sharedCalendar-container'>
													<div id="sharedCalendarTrash" class="sharedCalendar-trash" style="margin-left: 14.5%; margin-bottom: 5px;">
														<img  src="/AgentInfo/images/trash.png" style="width:25px">
													</div>
												  	<div id='sharedCalendar'></div>
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
		var list = JSON.parse('${sharedCalendar}'); // List 결과 (자바스크립트 객체)를 문자열로 변환하여 list에 담음
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
			obj._id = list[i].sharedCalendarKeyNum;
			obj.title = list[i].sharedCalendarContents;
			obj.start = list[i].sharedCalendarStart;
			if(list[i].sharedCalendarEnd != null){
				obj.end = list[i].sharedCalendarEnd;
			}
			obj.allDay = list[i].sharedCalendarAllDay;
			obj.backgroundColor = list[i].sharedCalendarColor;
			obj.borderColor = list[i].sharedCalendarColor
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
			
			$('#sharedCalendar').fullCalendar({
				header: {
				  left: 'prev,next today',
				  center: 'title',
				  right: 'month,agendaWeek,agendaDay,listMonth'
				},
				locale : 'ko', // 한국어설정
				events : dataList,
				timeFormat: 'H:mm',
				navLinks: true,
				//dayMaxEvents: true,
				eventLimit : true, // 달력에 표시될 일정 개수 제한
				selectable : true, // 마우스로 클릭한 위치확인용(추가용으로는 쓰지않음)
				editable: true,
				droppable: true, // 외부 UI 드래그 가능 여부
				loading: function(bool) {
					$('#loading').toggle(bool);
				},
				drop: function (date, allDay) {
					var originalEventObject = $(this).data('eventObject');
					var copiedEventObject = $.extend({}, originalEventObject);
					copiedEventObject.start = date;
					copiedEventObject.allDay = allDay;
					copiedEventObject.backgroundColor = rgbToHex($(this).css("background-color"));
					copiedEventObject.borderColor = rgbToHex($(this).css("border-color"));
					copiedEventObject.color = rgbToHex($(this).css("color"));

					$.ajax({
						url: "<c:url value='/sharedCalendar/insert'/>",
						type: 'post',
						data : {
							'sharedCalendarStartDate' : copiedEventObject.start._d.getTime(),
							'sharedCalendarContents' : copiedEventObject.title,
							'sharedCalendarColor' : copiedEventObject.backgroundColor,
							'sharedCalendarAllDay' : copiedEventObject.start._ambigTime
						},
						async: false,
						success : function(result) {
							copiedEventObject.sharedCalendarKeyNum = result.result;
							copiedEventObject._id = result.result;
						},
							error: function(error) {
							console.log(error);
						}
					});
					$('#sharedCalendar').fullCalendar('renderEvent', copiedEventObject, true);
				    
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
							event.start._d.setHours(event.start._d.getHours() -9);
							event.end._d.setHours(event.end._d.getHours() -9);
							$.ajax({
								type: 'post',
								url: "<c:url value='/sharedCalendar/move'/>",
								data : {
									'sharedCalendarKeyNum' : event._id,
									'sharedCalendarStartDate' : event.start._d.getTime(),
									'sharedCalendarEndDate' : event.end._d.getTime(),
									'sharedCalendarAllDay' : event.allDay
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
							$('#sharedCalendar').fullCalendar('render');
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
								url: "<c:url value='/sharedCalendar/move'/>",
								data : {
									'sharedCalendarKeyNum' : event._id,
									'sharedCalendarStartDate' : event.start._d.getTime(),
									'sharedCalendarEndDate' : (event.end != null) ? event.end._d.getTime() : event.start._d.getTime(),
									'sharedCalendarAllDay' : event.allDay									
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
							$('#sharedCalendar').fullCalendar('render');
						} else {
							revertFunc();
						}
					});
				},
				eventDragStop: function(event,jsEvent) {
					var trashEl = jQuery('#sharedCalendarTrash');
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
								$('#sharedCalendar').fullCalendar('removeEvents', event._id);
								$.ajax({
									type: 'post',
									url: "<c:url value='/sharedCalendar/delete'/>",
									data : {
										'sharedCalendarKeyNum' : event._id
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
							$('#sharedCalendar').fullCalendar('render');
						});
					}
				},
				eventClick: function(calEvent, jsEvent, view) {
					$.ajax({
					    type: 'POST',
					    url: "<c:url value='/sharedCalendar/view'/>",
					    data: {"sharedCalendarKeyNum":calEvent._id},
					    async: false,
					    success: function (data) {
							if(data.indexOf("<!DOCTYPE html>") != -1) 
								location.reload();
					    	$.modal(data, 'sharedCalendar'); //modal창 호출
					    },
					    error: function(e) {
					        alert(e);
					    }
					});	
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
					url: "<c:url value='/sharedCalendarList/insert'/>",
					type: 'post',
					data: {
						'sharedCalendarListContents':val,
						'sharedCalendarListColor':currColor
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
		
		function rgbToHex ( rgbType ){ 
		    /* 
		    ** 컬러값과 쉼표만 남기고 삭제하기. 
		    ** 쉼표(,)를 기준으로 분리해서, 배열에 담기. 
		    */ 
		    var rgb = rgbType.replace( /[^%,.\d]/g, "" ).split( "," ); 
		    
		    rgb.forEach(function (str, x, arr){ 
		    
		        /* 컬러값이 "%"일 경우, 변환하기. */ 
		        if ( str.indexOf( "%" ) > -1 ) str = Math.round( parseFloat(str) * 2.55 ); 
		        
		        /* 16진수 문자로 변환하기. */ 
		        str = parseInt( str, 10 ).toString( 16 ); 
		        if ( str.length === 1 ) str = "0" + str; 
		        
		        arr[ x ] = str; 
		    }); 
		    
		    return "#" + rgb.join( "" ); 
		} 
	</script>
</html>