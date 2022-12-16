<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%>

<style>
	.modal-footer {
		padding: 0;
	}
	
	.sharedCalendarColor {
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
	
	.sharedCalendarColor::-webkit-color-swatch {
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

<div class="modal-body" style="width: 100%; height: 700px;">
	<div style="padding: 5px;">
		<form class="form-material" id="modalForm" name="form" method ="post">
			<input type="hidden" id="sharedCalendarKeyNum" name="sharedCalendarKeyNum" class="form-control viewForm" value="${sharedCalendar.sharedCalendarKeyNum}">
			<div class="form-group form-default" style="float: left; width: 93%; margin-top: 10px;">
				<input type="text" class="form-control" id="sharedCalendarContents" name="sharedCalendarContents" maxlength="50" value="${sharedCalendar.sharedCalendarContents}" required>
				<span class="form-bar"></span>
				<label class="float-label">제목</label>
			</div>
			<input class="sharedCalendarColor" type="color" id="sharedCalendarColor" name="sharedCalendarColor" value="${sharedCalendar.sharedCalendarColor}">
			<div style="margin-top: 35px;">
				<img class="img-fluid" src="/AgentInfo/images/24H.png" style="width:30px; float:left;">
				<h4 style="float:left; width: 76%; margin: 5px; font-weight: bold; margin-left: 12px;">하루 종일</h4>
				<label class="switch" style="margin-top: 2px; float: right;">
				    <input type="checkbox" id="sharedCalendarAllDay" name="sharedCalendarAllDay" onclick="" <c:if test="${sharedCalendar.sharedCalendarAllDay}">checked</c:if>>
				    <span class="slider round"></span>
				</label>
			</div>
			<div style="margin-top:20px;">
				<input type='text' class="form-control" id='sharedCalendarStart' name="sharedCalendarStart" style="width:205px; float:left; font-size: 1.375rem; margin-top: 25px;" value="${sharedCalendar.sharedCalendarStart}"/>
				<img class="img-fluid" src="/AgentInfo/images/right.png" style="width: 25px; margin-top: 30px; float:left;">
				<input type='text' class="form-control" id='sharedCalendarEnd' name="sharedCalendarEnd" style="width:210px; float:left; font-size: 1.375rem;; margin-top: 20px; margin-left: 15px;" value="${sharedCalendar.sharedCalendarEnd}" />
			</div>
			<div style="margin-top: 165px;">
				<img class="img-fluid" src="/AgentInfo/images/email.png" style="width:35px; float:left; margin-top: 3px;">
				<div class="form-group form-default" style="float: right; width: 90%;">
					<input type="text" class="form-control" id="sharedCalendarDepartment" name="sharedCalendarDepartment" maxlength="50" value="${sharedCalendar.sharedCalendarDepartment}" required>
					<span class="form-bar"></span>
					<label class="float-label">부서</label>
				</div>
			</div>
			<div style="margin-top: 240px;">
				<img class="img-fluid" src="/AgentInfo/images/watch.png" style="float:left; width: 30px; margin-left: 3px;">
				<h4 style="float:left; width: 76%;"><input type="time" id="sharedCalendarAlarm" name="sharedCalendarAlarm" style="border: 0; margin: 4px; margin-left: 11px; font-weight: bold;" value="${sharedCalendar.sharedCalendarAlarm}"></h4>
				<label class="switch" style="margin-top: 2px; float: right;">
				    <input type="checkbox" id="sharedCalendarAlarmYn" name="sharedCalendarAlarmYn" onclick="" <c:if test="${sharedCalendar.sharedCalendarAlarmYn}">checked</c:if>>
				    <span class="slider round"></span>
				</label>
			</div>
			<div style="margin-top: 310px;">
				<img class="img-fluid" src="/AgentInfo/images/map.png" style="float:left; width: 35px; margin-bottom: 3px;">
				<a href="#" id="addresBtn"><img class="img-fluid" src="/AgentInfo/images/search.png" style="float:right; width: 22px; padding-top: 10px;"></a>
				<div class="form-group form-default" style="float: right; width: 85%; height: 30px; margin-top: -4px;">
					<input type="text" class="form-control" id="sharedCalendarAddress" name="sharedCalendarAddress" maxlength="50" value="${sharedCalendar.sharedCalendarAddress}" required>
					<span class="form-bar"></span>
					<label class="float-label">주소</label>
				</div>
			</div>
			<div style="margin-top: 370px">
				<div style="width:100%; height:240px;">
					<div id="map" style="width:460px; height:240px; border: 1px solid darkgoldenrod;"></div>
				</div>
			</div>
		</form>
	</div>
</div>
<div class="modal-footer">
	<button class="calendarModalFooter" id="sharedCalendarSave" style="border-right: 1px solid navajowhite;">저장</button>
	<button class="calendarModalFooter" id="sharedCalendarClose">닫기</button>
</div>

<script>
	$(function () {
		$('#sharedCalendarStart').datetimepicker();
		$('#sharedCalendarEnd').datetimepicker();
	});
	
	$("#sharedCalendarStart").change(function() {
		var start = $('#sharedCalendarStart').val();
		var end = $('#sharedCalendarEnd').val();
		if(start > end) {
			Swal.fire({
				icon: 'error',
				title: '기간!',
				text: '시작기간이 종료기간 보다 큼니다.',
			});
		} else if(start == end) {
			$("#sharedCalendarAllDay").prop("checked", true);
		} else if(start != end) {
			$("#sharedCalendarAllDay").prop("checked", false);
		}
	});
	
	$("#sharedCalendarEnd").change(function() {
		var start = $('#sharedCalendarStart').val();
		var end = $('#sharedCalendarEnd').val();
		if(start > end) {
			Swal.fire({
				icon: 'error',
				title: '기간!',
				text: '시작기간이 종료기간 보다 큼니다.',
			});
		} else if(start == end) {
			$("#sharedCalendarAllDay").prop("checked", true);
		} else if(start != end) {
			$("#sharedCalendarAllDay").prop("checked", false);
		}
	});
	
	$('#sharedCalendarClose').click(function() {
		$('#modal').modal("hide"); // 모달 닫기
	});
	
	$('#sharedCalendarSave').click(function() {
		var postData = $('#modalForm').serializeObject();
		$.ajax({
			url: "<c:url value='/sharedCalendar/save'/>",
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

<script>
	var map = new naver.maps.Map("map", {
	    center: new naver.maps.LatLng(37.5666805, 126.9784147),
	    zoom: 17,
	    mapTypeControl: false
	});
	
	var infoWindow = new naver.maps.InfoWindow({
	    anchorSkew: true
	});
	
	map.setCursor('pointer');
	
	function searchCoordinateToAddress(latlng) {

	    infoWindow.close();

	    naver.maps.Service.reverseGeocode({
	        coords: latlng,
	        orders: [
	            naver.maps.Service.OrderType.ADDR,
	            naver.maps.Service.OrderType.ROAD_ADDR
	        ].join(',')
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }

	        var items = response.v2.results,
	            address = '',
	            htmlAddresses = [];

	        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	            item = items[i];
	            address = makeAddress(item) || '';
	            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';

	            htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
	        }

	        infoWindow.setContent([
	            '<div style="padding:5px;min-width:200px;line-height:100%;">',
	            '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
	            htmlAddresses.join('<br />'),
	            '</div>'
	        ].join('\n'));

	        infoWindow.open(map, latlng);
	    });
	}

	function searchAddressToCoordinate(address) {
	    naver.maps.Service.geocode({
	        query: address
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }

	        if (response.v2.meta.totalCount === 0) {
	            return alert('totalCount' + response.v2.meta.totalCount);
	        }

	        var htmlAddresses = [],
	            item = response.v2.addresses[0],
	            point = new naver.maps.Point(item.x, item.y);

	        if (item.roadAddress) {
	            htmlAddresses.push('<span style="font-size:10px;">[도로명 주소] ' + item.roadAddress) + '</span>';
	        }

	        if (item.jibunAddress) {
	            //htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	        }

	        if (item.englishAddress) {
	            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	        }

	        infoWindow.setContent([
	            '<div style="padding:10px;min-width:200px;line-height:150%;">',
	            '<span style="margin-top:5px; font-size:12px; font-weight: bold;">검색 주소 : '+ address +'</span><br />',
	            htmlAddresses.join('<br />'),
	            '</div>'
	        ].join('\n'));

	        map.setCenter(point);
	        infoWindow.open(map, point);
	    });
	}

	function initGeocoder() {
	    map.addListener('click', function(e) {
	        searchCoordinateToAddress(e.coord);
	    });

	    $('#sharedCalendarAddress').on('keydown', function(e) {
	        var keyCode = e.which;

	        if (keyCode === 13) { // Enter Key
	            searchAddressToCoordinate($('#sharedCalendarAddress').val());
	        }
	    });

	    $('#addresBtn').on('click', function(e) {
	        e.preventDefault();

	        searchAddressToCoordinate($('#sharedCalendarAddress').val());
	    });

	    searchAddressToCoordinate('서울 구로구 디지털로26길 111 제이앤케이디지털타워');
	}
	if("${sharedCalendar.sharedCalendarAddress}" == "") {
		searchAddressToCoordinate('서울 구로구 디지털로26길 111 제이앤케이디지털타워');	
	} else {
		searchAddressToCoordinate('${sharedCalendar.sharedCalendarAddress}');	
	}
	
	
	$('#addresBtn').on('click', function(e) {
        e.preventDefault();

        searchAddressToCoordinate($('#sharedCalendarAddress').val());
    });
	
	$("#sharedCalendarAddress").keypress(function(event) {
		if (window.event.keyCode == 13) {
			searchAddressToCoordinate($('#sharedCalendarAddress').val());
		}
	});

	function makeAddress(item) {
	    if (!item) {
	        return;
	    }

	    var name = item.name,
	        region = item.region,
	        land = item.land,
	        isRoadAddress = name === 'roadaddr';

	    var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

	    if (hasArea(region.area1)) {
	        sido = region.area1.name;
	    }

	    if (hasArea(region.area2)) {
	        sigugun = region.area2.name;
	    }

	    if (hasArea(region.area3)) {
	        dongmyun = region.area3.name;
	    }

	    if (hasArea(region.area4)) {
	        ri = region.area4.name;
	    }

	    if (land) {
	        if (hasData(land.number1)) {
	            if (hasData(land.type) && land.type === '2') {
	                rest += '산';
	            }

	            rest += land.number1;

	            if (hasData(land.number2)) {
	                rest += ('-' + land.number2);
	            }
	        }

	        if (isRoadAddress === true) {
	            if (checkLastString(dongmyun, '면')) {
	                ri = land.name;
	            } else {
	                dongmyun = land.name;
	                ri = '';
	            }

	            if (hasAddition(land.addition0)) {
	                rest += ' ' + land.addition0.value;
	            }
	        }
	    }

	    return [sido, sigugun, dongmyun, ri, rest].join(' ');
	}

	function hasArea(area) {
	    return !!(area && area.name && area.name !== '');
	}

	function hasData(data) {
	    return !!(data && data !== '');
	}

	function checkLastString (word, lastString) {
	    return new RegExp(lastString + '$').test(word);
	}

	function hasAddition (addition) {
	    return !!(addition && addition.value);
	}

	naver.maps.onJSContentLoaded = initGeocoder;
	
	// 위치 맞추기 위해 추가
	//document.getElementById('map').firstChild.style.left = "170px";
</script>