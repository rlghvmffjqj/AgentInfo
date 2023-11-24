<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<!-- 쿠키 스크립트 -->
	    <script>
	    	/* =========== 페이지 쿠키 값 저장 ========= */
		    $(function() {
		    	$.cookie('name','packageAnalysis');
		    });
	    </script>
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
												<h5 class="m-b-10">패키지 분석</h5>
												<p class="m-b-0">Package Analysis</p>
											</div>
										</div>
										<div class="col-md-4">
											<ul class="breadcrumb-title">
												<li class="breadcrumb-item">
													<a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
												</li>
												<li class="breadcrumb-item"><a href="#!">패키지 분석</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="pcoded-inner-content">
								<div class="main-body">
									<div class="page-wrapper">
										<div>
											<div class="card">
												<div class="card-header" style="float: left;">
													<div style="float: left;">
														<h4>War 파일 업로드</h4>
														<h5 class="colorRed">서로 다른 War파일 업로드 하여 해시 값이 다른 파일을 조회 합니다.</h5>
													</div>
													<div style="float: right;">
														<select class="form-control selectpicker" id="packgeCount" name="packgeCount" data-size="5" data-actions-box="true">
															<option value="2" selected>2개</option>
															<option value="3">3개</option>
															<option value="4">4개</option>
														</select>
													</div>
												</div>
												<div class="card-block">
														<div style="width: 100%; height: 200px;">
														<div class="drop-area" id="drop-area1" style="width: 100%;">
															<span class="dropSpan">기존 패키지 파일 Drag & Drop</span>
														</div>
														<div class="drop-area updatePackageFile" id="drop-area2" style="width: 100%;">
															<span class="dropSpan">수정 패키지 파일1 Drag & Drop</span>
														</div>
														<div class="drop-area updatePackageFile" id="drop-area3" style="display: none; border-left: none;">
															<span class="dropSpan">수정 패키지 파일2 Drag & Drop</span>
														</div>
														<div class="drop-area updatePackageFile" id="drop-area4" style="display: none; border-left: none;">
															<span class="dropSpan">수정 패키지 파일3 Drag & Drop</span>
														</div>
													</div>
													<input type="file" id="file-input1" name="file1" style="display: none;">
													<input type="file" id="file-input2" name="file2" style="display: none;">
													<input type="file" id="file-input3" name="file3" style="display: none;">
													<input type="file" id="file-input4" name="file4" style="display: none;">
													<button class="btn btn-default btn-outline-info-add" type="button" id="sendButton" style="width: 100%;">분석</button>
												</div>
												<span id="resultSpan" style="padding-left: 30px; font-weight: bold; font-size: 1.1rem; border-top: 1px solid #ababab; padding-top: 20px; display: none;">패키지 분석 결과</span>
												<div class="card-block" id="resultFile">
													
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

		<!-- progress Modal -->
		<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		    <div class="modal-dialog" style="margin-top: 20%;">
		        <div class="modal-content" style="border:1px solid !important; width: 95%; margin-left: 3%;">
		            <div class="modal-header" style="background: burlywood;">
		                <h3 style="font-weight: bold; font-family: none; color: white;">패키지 분석 중 ...</h3>
		            </div>
		            <div class="modal-body">
		                <!-- progress , bar, percent를 표시할 div 생성한다. -->
		                <div class="progress">
		                    <div class="bar"></div>
		                    <div class="percent">0%</div>
		                </div>
		                <div id="status"></div>
		            </div>
		        </div>
		    </div>
		</div>
	</body>

	<script>
        var files1 = [];
        var files2 = [];

        function handleFiles(area, files) {
            var file = files[0];
            console.log("Area " + area + " - File name: " + file.name);
            console.log("Area " + area + " - File type: " + file.type);
            console.log("Area " + area + " - File size: " + file.size + " bytes");

			if(checkFileExtension(file.name)) {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: 'war 확장자만 업로드가 가능합니다.',
				});
				return false;
			}
            
			$('#'+area).text(file.name);
			if(area == "drop-area1") {
				var dataTransfer = new DataTransfer();
        		dataTransfer.items.add(file);
        		$('#file-input1')[0].files = dataTransfer.files;
			}
			if(area == "drop-area2") {
				var dataTransfer = new DataTransfer();
	        	dataTransfer.items.add(file);
        		$('#file-input2')[0].files = dataTransfer.files;
			}
			if(area == "drop-area3") {
				var dataTransfer = new DataTransfer();
	        	dataTransfer.items.add(file);
        		$('#file-input3')[0].files = dataTransfer.files;
			}
			if(area == "drop-area4") {
				var dataTransfer = new DataTransfer();
	        	dataTransfer.items.add(file);
        		$('#file-input4')[0].files = dataTransfer.files;
			}

            // 해당 영역에 따라 파일 정보를 저장
            if (area === 1) {
                files1 = files;
            } else if (area === 2) {
                files2 = files;
            }
        }

		function checkFileExtension(fileName) {
		    // 파일 이름에 ".war"이 포함되어 있는지 확인
		    if (fileName.indexOf(".war") !== -1) {
		        return false; // ".war"이 포함되어 있는 경우
		    }
		
		    // 파일 이름에 ".war"이 포함되어 있지 않은 경우
		    return true;
		}

        $(document).ready(function () {
            $('.drop-area').on('dragover', function (e) {
                e.preventDefault();
                $(this).css('border', '3px dashed #000');
            });

            $('.drop-area').on('dragleave', function (e) {
                e.preventDefault();
                $(this).css('border', '3px dashed #ccc');
				$('#drop-area3').css('border-left', 'none');
				$('#drop-area4').css('border-left', 'none');
				
            });

            $('.drop-area').on('drop', function (e) {
                e.preventDefault();
                $(this).css('border', '3px dashed #ccc');
				$('#drop-area3').css('border-left', 'none');
				$('#drop-area4').css('border-left', 'none');

                var files = e.originalEvent.dataTransfer.files;
                var areaId = $(this).attr('id');
                handleFiles(areaId, files);
            });

            $('#sendButton').on('click', function () {
				var packgeCount = $('#packgeCount :selected').val();
                var formData = new FormData();

				 /* progressbar 정보 */
				 var bar = $('.bar');
        		var percent = $('.percent');
        		var status = $('#status');

				var files1 = $('#file-input1')[0].files;
				var files2 = $('#file-input2')[0].files;
				var files3 = $('#file-input3')[0].files;
				var files4 = $('#file-input4')[0].files;

				if(files1.length == 0) {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '기존 패키지 파일 업로드 해주세요.',
					});
					return false;
				}

				if(files2.length == 0) {
					Swal.fire({
						icon: 'error',
						title: '실패!',
						text: '수정 패키지 파일1 업로드 해주세요.',
					});
					return false;
				}

				if(packgeCount >= 3) {
					if(files3.length == 0) {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '수정 패키지 파일2 업로드 해주세요.',
						});
						return false;
					}
				}

				if(packgeCount == 4) {
					if(files4.length == 0) {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: '수정 패키지 파일3 업로드 해주세요.',
						});
						return false;
					}
				}

				formData.append('file1', files1[0]);
				formData.append('file2', files2[0]);
				formData.append('file3', files3[0]);
				formData.append('file4', files4[0]);

            	$.ajax({
					xhr: function() {
            		    var xhr = new window.XMLHttpRequest();
            		    xhr.upload.addEventListener("progress", function(evt) {
            		        if (evt.lengthComputable) {
            		            var percentComplete = Math.floor((evt.loaded / evt.total) * 100);
							
            		            var percentVal = percentComplete + '%';
            		            bar.width(percentVal);
            		            percent.html(percentVal);
							
            		        }
            		    }, false);
            		    return xhr;
            		},
            	    url: "<c:url value='/packageAnalysis/analysis'/>",
            	    type: 'POST',
            	    data: formData,
            	    processData: false,
            	    contentType: false,
					beforeSend:function(){
            		    // progress Modal 열기
            		    $("#pleaseWaitDialog").modal('show');

            		    status.empty();
            		    var percentVal = '0%';
            		    bar.width(percentVal);
            		    percent.html(percentVal);

            		},
            		complete:function(){
            		    // progress Modal 닫기
            		    $("#pleaseWaitDialog").modal('hide');
            		},
            	    success: function (data) {
						$("#resultFile").empty();
						for (var i = 0; i < data.length; i++) {
            	        	var item = data[i];
							var listItem = "<div class='hover-div' onmouseover='changeBackgroundColor(this)' onmouseout='restoreBackgroundColor(this)' onclick='changFileRute(this)'><p>"+item+"</p></div>";
                    		$("#resultFile").append(listItem);	
							$("#resultSpan").show();
            	    	}
						$('.modal-backdrop').hide();
            	    },
            	    error: function (error) {
            	        console.error('Error:', error);
            	    }
            	});
            });
        });

		function changeBackgroundColor(element) {
		    element.style.backgroundColor = "#b598d77a";
		}

		function restoreBackgroundColor(element) {
		    element.style.backgroundColor = "white";
		}

		function changFileRute(element) {
			var packgeCount = $('#packgeCount :selected').val();
			var fileRute = element.innerText;
			var formData = new FormData();

			var files1 = $('#file-input1')[0].files;
			var files2 = $('#file-input2')[0].files;
			var files3 = $('#file-input3')[0].files;
			var files4 = $('#file-input4')[0].files;

			formData.append('file1', files1[0].name);
			formData.append('file2', files2[0].name);

			console.log(formData);

			if(packgeCount >= 3) {
				formData.append('file3', files3[0].name);
			} else {
				formData.append('file3', "");
			}
			if(packgeCount == 4) {
				formData.append('file4', files4[0].name);
			} else {
				formData.append('file4', "");
			}
			formData.append('fileRute',fileRute);
			
			$.ajax({
			    type: 'POST',
			    url: "<c:url value='/packageAnalysis/packageAnalysisResult'/>",
				data: formData,
				async: false,
            	processData: false,
            	contentType: false,
			    success: function (data) {
			    	if(data.indexOf("<!DOCTYPE html>") != -1) 
						location.reload();
			        $.modal(data, 'packageAnalysis'); //modal창 호출
			    },
			    error: function(e) {
			        // TODO 에러 화면
			    }
			});	
		}

		$("#packgeCount").change(function() {
			var count = $(this).val();
			if(count == 2) {
				$(".updatePackageFile").css("width","100%");
				$("#drop-area3").hide();
				$("#drop-area4").hide();
			} else if(count == 3) {
				$(".updatePackageFile").css("width","50%");
				$("#drop-area3").show();
				$("#drop-area4").hide();
			} else if(count == 4) {
				$(".updatePackageFile").css("width","33.33%");
				$("#drop-area3").show();
				$("#drop-area4").show();
			}
		});
    </script>
	<style>
		.drop-area {
			width: 50%;
			height: 200px;
			float: left;
			text-align: center;
			border: 3px dashed #ccc;
            padding-top: 5%;
            text-align: center;
            cursor: pointer;
            margin-bottom: 20px;
		}

		.bar {	
			background: #5858fd;
		}

		.dropSpan {
			font-size: 20px;
    		color: gray;
    		font-family: ui-monospace;
		}

		.hover-div {
		    width: 100%;
		    height: 50px;
		    background-color: white;
		    padding: 10px;
		    padding: 10px;
		    text-align: left;
		    cursor: pointer;
		}
		
		.hover-div:hover {
		    background-color: #b598d77a;
		}

		.btn-outline-info-add {
			background: #bfc6ff4f;
		}

	</style>
</html>