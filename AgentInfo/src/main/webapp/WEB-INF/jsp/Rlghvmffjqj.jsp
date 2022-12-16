<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=8yvu58b01c&submodules=geocoder"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Rlghvmffjqj Page</title>
</head>
<body>
	<div id="map" style="width:100%;height:400px; border: 1px solid darkgoldenrod;"></div>
	<div style="background: bisque; width: 420px; height: 50px; float: left;">
		<span>문자전송</span><br>
		<input type="text" id="phoneNum" placeholder="전화번호">
		<input type="text" id="phoneContent" placeholder="내용">
		<button id="phone">전송</button>
	</div>
	<div style="background: burlywood; width: 600px; height: 50px; float: left;">
		<span>이메일전송</span><br>
		<input type="text" id="emailId" placeholder="이메일">
		<input type="text" id="emailTitle" placeholder="제목">
		<input type="text" id="emailContent" placeholder="내용">
		<button id="email">전송</button>
	</div>
</body>

<script>
	$('#phone').click(function() {
		var phoneNum = $("#phoneNum").val();
		var phoneContent = $("#phoneContent").val();
		$.ajax({
			url: "<c:url value='/rlghvmffjqj/phone'/>",
	        type: 'post',
	        data: 
	        {
	        	"phoneNum":phoneNum,
	        	"phoneContent":phoneContent
	        },
	        async: false,
	        success: function(result) {
	        	alert("성공");
			},
			error: function(error) {
				console.log(error);
			}
	    });
	});
	
	$('#email').click(function() {
		var emailId = $("#emailId").val();
		var emailTitle = $("#emailTitle").val();
		var emailContent = $("#emailContent").val();
		$.ajax({
			url: "<c:url value='/rlghvmffjqj/email'/>",
	        type: 'post',
	        data: 
	        {
	        	"emailId":emailId,
	        	"emailTitle":emailTitle,
	        	"emailContent":emailContent
	        },
	        async: false,
	        success: function(result) {
	        	alert("성공");
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
	
	    $('#calendarAddress').on('keydown', function(e) {
	        var keyCode = e.which;
	
	        if (keyCode === 13) { // Enter Key
	            searchAddressToCoordinate($('#calendarAddress').val());
	        }
	    });
	
	    $('#addresBtn').on('click', function(e) {
	        e.preventDefault();
	
	        searchAddressToCoordinate($('#calendarAddress').val());
	    });
	
	    searchAddressToCoordinate('서울 구로구 디지털로26길 111 제이앤케이디지털타워');
	}
	if("${calendar.calendarAddress}" == "") {
		searchAddressToCoordinate('서울 구로구 디지털로26길 111 제이앤케이디지털타워');	
	} else {
		searchAddressToCoordinate('${calendar.calendarAddress}');	
	}
	
	
	$('#addresBtn').on('click', function(e) {
	    e.preventDefault();
	
	    searchAddressToCoordinate($('#calendarAddress').val());
	});
	
	$("#calendarAddress").keypress(function(event) {
		if (window.event.keyCode == 13) {
			searchAddressToCoordinate($('#calendarAddress').val());
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
	document.getElementById('map').firstChild.style.left = "170px";
	</script>
</script>
</html>