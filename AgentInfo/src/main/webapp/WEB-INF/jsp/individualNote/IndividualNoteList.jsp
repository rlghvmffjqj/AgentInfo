<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
			/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','individualNote');
		    });
		</script>
		
		<link rel="stylesheet" type="text/css" href="<c:url value='/gridstack/gridstack.min.css'/>">
		<script type="text/javascript" src="<c:url value='/gridstack/gridstack-h5.js'/>"></script>
		
		<style type="text/css">
		  .grid-stack { background: white; }
		  .grid-stack-item-content { background-color: #FFFF6D; }
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
							    <div class="row align-dataList-center">
							        <div class="col-md-8">
							            <div class="page-header-title" >
							                <h5 class="m-b-10">개인 노트</h5>
							                <p class="m-b-0">Individual Note</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">개인 노트</a>
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
	                                	<div class="searchbos">
											<form id="form" name="form" method ="post">
												<div class="col-lg-2">
	                      							<label class="labelFontSize">제목</label>
	                      							<input hidden="hidden" />
													<input type="text" id="individualNoteTitle" name="individualNoteTitle" class="form-control">
												</div>
		                      					<div class="col-lg-12 text-right">
													<p class="search-btn">
														<button class="btn btn-primary btnm" type="button" id="btnSearch">
															<i class="fa fa-search"></i>&nbsp;<span>검색</span>
														</button>
														<button class="btn btn-default btnm" type="button" id="btnReset">
															<span>초기화</span>
														</button>
													</p>
												</div>
											</form>
		                     			</div>
		                     		</div>
		                     			<table style="width:99%;">
											<tbody>
												<tr>
													<td style="padding:0px 0px 0px 0px;" class="box">
														<table style="width:100%">
														<tbody>
															<tr>
																<td style="font-weight:bold;">노트 관리 :
																	<button class="btn btn-outline-info-add myBtn" id="BtnInsert" onclick="addWidget()">추가</button>
																	<button class="btn btn-outline-info-del myBtn" id="BtnSave">저장</button>
																</td>
															</tr>
															<tr>
																<td class="border1" colspan="2">
																	<div class="grid-stack"></div>
																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tbody>
										</table>				
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>

	<script type="text/javascript">
		let grid = GridStack.init({
		  float: true,
		  disableOneColumnMode: true, 
		  cellHeight: 100 
		});
		let text = document.querySelector('#column-text');
		let layout = 'moveScale';
		
		grid.on('added removed change', function(e, items) {
		  let str = '';
		  items.forEach(function(item) { str += ' (x,y)=' + item.x + ',' + item.y; });
		});
		
		var items = [
			<c:forEach items="${list}" var="item">
				{keynum: "${item.individualNoteKeyNum}", title: "${item.individualNoteTitle}", contents: '${item.individualNoteContents}'},
			</c:forEach>
		];
		
		items.forEach(n => {
			n.content = '<a onClick="grid.removeWidget(this.parentNode.parentNode)" style="float: right; margin: 5px;">X</a><br><br><input type="hidden" value=' + n.keynum + '><laber style="font-weight: bold;color: mediumvioletred;">' + n.title +'</laber>' + n.contents;
			grid.addWidget(n); 
		});
		
		function addWidget() {
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/individualNote/insertView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'full'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		};
		
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
	        $('.selectpicker').val('');
			stackRefresh();
		});
		
		function stackRefresh(individualNoteTitle) {
			grid.removeAll();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/individualNote/search'/>",
			    data: {
			    	"individualNoteTitle" : individualNoteTitle
			    },
			    async: false,
			    success: function (data) {
			    	var dataList = [];
			    	for(var i=0; i<data.length; i++) {
			    		dataList.push({keynum: data[i].individualNoteKeyNum, title: data[i].individualNoteTitle, contents: data[i].individualNoteContents});
			    	};
			    	dataList.forEach(n => {
			    		n.content = '<a onClick="grid.removeWidget(this.parentNode.parentNode)" style="float: right; margin: 5px;">X</a><br><br><input type="hidden" value=' + n.keynum + '><laber style="font-weight: bold;color: mediumvioletred;">' + n.title +'</laber>' + n.contents;
						grid.addWidget(n); 
					});
			    },
			    error: function(e) {
			        alert(e);
			    }
			});
			$('.grid-stack-item-content').trigger("dblclick");
		}
		
		$('#btnSearch').click(function() {
			var individualNoteTitle = $('#individualNoteTitle').val();
			stackRefresh(individualNoteTitle);
		});
		
		/* =========== Enter 검색 ========= */
		$("input[type=text]").keypress(function(event) {
			if (window.event.keyCode == 13) {
				$('#btnSearch').trigger("click");
			}
		});
		
		$(".grid-stack-item-content").on('dblclick', (e) => {
			var individualNoteKeyNum = e.currentTarget.childNodes[3].defaultValue;
			console.log(individualNoteKeyNum);
			$.ajax({
			    type: 'POST',
			    data: {'individualNoteKeyNum': individualNoteKeyNum},
			    url: "<c:url value='/individualNote/updateView'/>",
			    async: false,
			    success: function (data) {
			    	$.modal(data, 'full'); //modal창 호출
			    },
			    error: function(e) {
			        alert(e);
			    }
			});	
		})
		
	</script>
</html>