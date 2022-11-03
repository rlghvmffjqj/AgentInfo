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
													<input type="hidden" id="individualNoteTitle" name="individualNoteTitle" class="form-control">
													<select class="form-control selectpicker" id="individualNoteTitleMulti" name="individualNoteTitleMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
														<c:forEach var="item" items="${individualNoteTitle}">
															<option value="${item}"><c:out value="${item}"/></option>
														</c:forEach>
													</select>
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
																	<button class="btn btn-outline-info-del myBtn" id="BtnSave" onclick="BtnSave()">저장</button>
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
		/* =========== 로딩시 실행 ========= */
		var grid = GridStack.init({
		  float: true,
		  disableOneColumnMode: true, 
		  cellHeight: 100 
		});
		
		var items = [
			<c:forEach items="${list}" var="item">
				{keynum: "${item.individualNoteKeyNum}", title: "${item.individualNoteTitle}", contents: '${item.individualNoteContents}'},
			</c:forEach>
		];
		
		items.forEach(n => {
			n.content = '<a onClick="individualNoteDelete(this.parentNode.childNodes[3].value)" style="float: right; margin: 5px;">X</a><br><br><input type="hidden" value=' + n.keynum + '><laber style="font-weight: bold;color: mediumvioletred;">' + n.title +'</laber>' + n.contents;
			grid.addWidget(n); 
		});
		
		/* =========== 노트 추가 View ========= */
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
		
		/* =========== 초기화 ========= */
		$('#btnReset').click(function() {
			$("input[type='text']").val("");
			$('.selectpicker').val('');
			$('.filter-option-inner-inner').text('');
			stackRefresh();
		});
		
		/* =========== 새로고침 ========= */
		function stackRefresh(individualNoteTitle) {
			$('#individualNoteTitle').val($('#individualNoteTitleMulti').val().join());
			var postDate = $("#form").serializeObject();
			grid.removeAll();
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/individualNote/search'/>",
			    data: postDate,
			    async: false,
			    success: function (data) {
			    	var items = [];
			    	for(var i=0; i<data.length; i++) {
			    		items.push({'keynum': data[i].individualNoteKeyNum, 'title': data[i].individualNoteTitle, 'contents': data[i].individualNoteContents});
			    	};
			    	items.forEach(n => {
			    		n.content = '<a onClick="individualNoteDelete(this.parentNode.childNodes[3].value)" style="float: right; margin: 5px;">X</a><br><br><input type="hidden" value=' + n.keynum + '><laber style="font-weight: bold;color: mediumvioletred;">' + n.title +'</laber>' + n.contents;
						grid.addWidget(n);
					});
			    },
			    error: function(e) {
			        alert(e);
			    }
			});
			$(".grid-stack-item-content").on('dblclick', (e) => {
				var individualNoteKeyNum = e.currentTarget.childNodes[3].defaultValue;
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
			});
		}
		
		/* =========== 검색 ========= */
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
		
		/* =========== 노트 수정 View ========= */
		$(".grid-stack-item-content").on('dblclick', (e) => {
			var individualNoteKeyNum = e.currentTarget.childNodes[3].defaultValue;
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
		});
		
		/* =========== 노트 삭제 ========= */
		function individualNoteDelete(individualNoteKeyNum) {
			Swal.fire({
				  title: '삭제!',
				  text: "선택한 노트를 제거하시겠습니까?",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#7066e0',
				  cancelButtonColor: '#FF99AB',
				  confirmButtonText: '예'
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
					url: "<c:url value='/individualNote/delete'/>",
					data: {'individualNoteKeyNum': individualNoteKeyNum},
					type: "POST",
					dataType: "text",
					traditional: true,
					async: false,
					success: function(data) {
						if(data == "OK")
							Swal.fire(
							  '성공!',
							  '삭제 완료하였습니다.',
							  'success'
							)
						else
							Swal.fire(
							  '실패!',
							  '삭제 실패하였습니다.',
							  'error'
							)
						$('#btnSearch').trigger("click");
					},
					error: function(error) {
						console.log(error);
					}
				  });
			  	}
			})
		}
		
		/* =========== 노트 정렬 저장 ========= */
		function BtnSave(content = true, full = true) {
			options = grid.save(content, full);
			var individualNoteTitle = [];
			var individualNoteContents = [];
			for(var num = 0; num<options.children.length; num++) {
				individualNoteTitle.push(options.children[num].title);
				individualNoteContents.push(options.children[num].contents);
			}
			$.ajax({
				url: "<c:url value='/individualNote/save'/>",
		        type: 'post',
		        data: {
		        	'individualNoteTitle': individualNoteTitle,
		        	'individualNoteContents': individualNoteContents
		        },
		        async: false,
		        success: function(result) {
					if(result == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: '작업을 완료했습니다.',
						});
		        		$('#btnReset').trigger("click");
						//stackRefresh();
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
		
		/* =========== Select Box 선택 ========= */
		$("select").change(function() {
			stackRefresh();
		});
	</script>
</html>