<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<nav class="navbar header-navbar pcoded-header iscollapsed">
    <div class="navbar-wrapper">
        <div class="navbar-logo">
            <a class="mobile-menu waves-effect waves-light" id="mobile-collapse" href="#!">
                <i class="ti-menu"></i>
            </a>
            
            <a href="<c:url value='/index'/>">
                <img class="img-fluid" src="/AgentInfo/images/logo2.png" alt="Theme-Logo" style="margin-left: -10px;">
            </a>
            
        </div>
      
        <div class="navbar-container container-fluid">
            <ul class="nav-left">
                <li>
                    <div class="sidebar_toggle"><a href="javascript:void(0)"><i class="ti-menu"></i></a></div>
                </li>
                <li>
                    <a href="#!" onclick="javascript:toggleFullScreen()" class="waves-effect waves-light">
                        <i class="ti-fullscreen"></i>
                    </a>
                </li>
                <sec:authorize access="hasRole('ADMIN')">
	                <li style="height:55px">
	                	<label class="switch" style="margin-top: 12px;">
					        <input type="checkbox" id="customerSwitch" onclick="toggle(this)">
					        <span class="slider round"></span>
					    </label>
	                </li>
                </sec:authorize>
            </ul>
            <ul class="nav-right">
                <li class="user-profile header-notification">
                    <a href="#!" class="waves-effect waves-light">
                        <img src="/AgentInfo/images/profile.png" class="img-radius" alt="User-Profile-Image">
                        <span style="color:black;"><sec:authentication property="name"/></span>
                        <i class="ti-angle-down"></i>
                    </a>
                    <ul class="show-notification profile-notification">
                        <li class="waves-effect waves-light">
                            <a href="#" onclick="profileView()">
                                <i class="ti-user"></i> Profile
                            </a>
                        </li>
                        <li class="waves-effect waves-light">
                            <a href="<c:url value='/users/logout' />">
                                <i class="ti-layout-sidebar-left"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<script>
    $.ajax({
		url: "<c:url value='/users/alarm'/>",
	    type: 'post',
	    async: false,
	    success: function(result) {
            var table = $(".nav-right");           
            var rowItem = "<ul class='nav-right'>";
            rowItem += "<li class='user-profile header-notification'>";
            rowItem += "<a href='#!' class='waves-effect waves-light'>";
            if(result.notRead > 0) {
                rowItem += "<img src='/AgentInfo/images/AlramRed.png' class='img-radius' alt='User-Profile-Image' style='width: 40px; height: 40px; border-radius: 0px'>";
            } else {
                rowItem += "<img src='/AgentInfo/images/AlramBlack.png' class='img-radius' alt='User-Profile-Image' style='width: 35px; height: 35px; border-radius: 0px'>";
            }
            rowItem += "</a>";
            rowItem += "<ul class='show-notification profile-notification' style='min-width: 230px; max-width: 350px; width: max-content; max-height: 202px; overflow-y: auto;'>";
            $.each(result.list, function(index, item) {
                if(item.questionKeyNum) {
                    rowItem += "<li class='waves-effect waves-light'>";
                    rowItem += "<a href='#' onclick='questionClick("+'"'+item.questionKeyNum+'"'+")'>";
                    rowItem += "<i class='ti-bell'></i>"+item.questionTitle;
                    rowItem += "</a>";
                    rowItem += "</li>";
                } else {
                    if(item.userAlarmURL.includes("issue")) {
                        rowItem += "<li class='waves-effect waves-light'>";
                        rowItem += "<a href='#' onclick='issueAlarmClick("+'"'+item.userAlarmURL+'"'+","+'"'+item.userAlarmParameter+'"'+")'>";
                        if(item.userAlarmStateN == 'N') {
                            rowItem += "<img src='/AgentInfo/images/AlramRed.png' class='img-radius' alt='User-Profile-Image' style='width: 21px; height: 21px; border-radius: 0px; margin-right: 3px; margin-left: -2.5px;'>"+item.userAlarmTitle;
                        } else {
                            rowItem += "<i class='ti-bell'></i>"+item.userAlarmTitle;
                        }
                        rowItem += "</a>";
                        rowItem += "</li>";
                    } else {
                        rowItem += "<li class='waves-effect waves-light'>";
                        rowItem += "<a href='#' onclick='alarmClick("+'"'+item.userAlarmURL+'"'+","+'"'+item.userAlarmParameter+'"'+")'>";
                        rowItem += "<i class='ti-bell'></i>"+item.userAlarmTitle;
                        rowItem += "</a>";
                        rowItem += "</li>";
                    }
                }
            });
            rowItem += "</ul>";
            rowItem += "</li>";
            rowItem += "</ul>";
            table.after(rowItem);
            setTimeout(() => {
                $('.profile-notification').focus();
            }, 0);

            // } else {
            //     var rowItem = "<ul class='nav-right'>";
            //     rowItem += "<li class='user-profile header-notification'>";
            //     rowItem += "<a href='#!' class='waves-effect waves-light'>";
            //     rowItem += "<img src='/AgentInfo/images/AlramBlack.png' class='img-radius' alt='User-Profile-Image' style='width: 35px; height: 35px; border-radius: 0px'>";
            //     rowItem += "</a>";
            //     rowItem += "<ul class='show-notification profile-notification' style='width: 260px !important; max-height: 380px; overflow: auto;'>";
            //     rowItem += "<li class='waves-effect waves-light'>";
            //     rowItem += "표시할 알림이 존재 하지 않습니다.";
            //     rowItem += "</li>";
            //     rowItem += "</ul>";
            //     rowItem += "</li>";
            //     rowItem += "</ul>";
            //     table.after(rowItem);
            // }
		},
		error: function(error) {
			console.log(error);
		}
	});
</script>

<style> 
    .profile-notification::-webkit-scrollbar {
        display: none; 
    }
</style>

<script>
/* =========== 프로필 조회 ========= */
function profileView() {	
	$.ajax({
	    type: 'POST',
	    url: "<c:url value='/users/profileView'/>",
	    async: false,
	    success: function (data) {
	    	if(data.indexOf("<!DOCTYPE html>") != -1) 
				location.reload();
	        $.modal(data, 'l'); //modal창 호출
	    },
	    error: function(e) {
	        // TODO 에러 화면
	    }
	});
 }
 
/* =========== 고객사 표시, 숨김(쿠키) ========= */
function toggle(element) {
    if(element.checked) {
    	$('.customerLog').show();
    	$('.menuSwitch').show();
    	$.cookie('customerSwitch','on',{path:'/'});
    } else {
    	$('.customerLog').hide();
    	$('.menuSwitch').hide();
    	$.cookie('customerSwitch','off',{path:'/'});
    }
    /* location.reload(); */
}

/* =========== 쿠키값 으로 고객사 표시, 숨김 ========= */
$(function() {
	<sec:authorize access="hasAnyRole('ENGINEER','MEMBER','LICENSE')">
		$.removeCookie('customerSwitch', { path: '/' });
	</sec:authorize>
	var cookieSwitch = $.cookie('customerSwitch');
	if(cookieSwitch == 'on') {
		$("#customerSwitch").prop("checked",true);
		customerSwitch(true);
	} else {
		$("#customerSwitch").prop("checked",false);
		customerSwitch(false);
	}
});

/* =========== 고객사 표시, 숨김 ========= */
function customerSwitch(result) {
	if(result) {
		$('.customerLog').show();
		$('.menuSwitch').show();
	} else {
		$('.customerLog').hide();
		$('.menuSwitch').hide();
	}
}

function alarmClick(userAlarmURL, keyNum) {
    var form = document.createElement("form");
  	form.method = "POST";
  	form.action = "<c:url value='"+userAlarmURL+"'/>"; // 이동할 페이지의 URL을 지

  	// 폼에 값을 추가
  	var input1 = document.createElement("input");
  	input1.type = "hidden"; // 숨겨진 필드로 설정
  	input1.name = "questionKeyNum"; // 서버에서 사용할 파라미터 이름
  	input1.value = keyNum; // 전달할 값
  	form.appendChild(input1)

  	// 폼을 문서에 추가하고 자동으로 제출
  	document.body.appendChild(form);
  	form.submit();
}

function issueAlarmClick (userAlarmURL, keyNum) {
    $.ajax({
		url: "<c:url value='/issue/alarmCheck'/>",
	    type: 'post',
	    data: {
			"userAlarmParameter": keyNum
		},
	    async: false,
	    success: function(result) {
			if(result == "OK") {
                location.href="<c:url value='"+userAlarmURL+"'/>?issueKeyNum="+keyNum;
            } else {
                Swal.fire({               
					icon: 'error',          
					title: '실패!',           
					text: '알림 확인 실패하였습니다.',    
				});
            }
		},
		error: function(error) {
			console.log(error);
		}
	});
}
    

function questionClick(keyNum) {
    var form = document.createElement("form");
  	form.method = "POST";
  	form.action = "<c:url value='/question/view'/>"; // 이동할 페이지의 URL을 지

  	// 폼에 값을 추가
  	var input1 = document.createElement("input");
  	input1.type = "hidden"; // 숨겨진 필드로 설정
  	input1.name = "questionKeyNum"; // 서버에서 사용할 파라미터 이름
  	input1.value = keyNum; // 전달할 값
  	form.appendChild(input1)

  	// 폼을 문서에 추가하고 자동으로 제출
  	document.body.appendChild(form);
  	form.submit();
}
</script>