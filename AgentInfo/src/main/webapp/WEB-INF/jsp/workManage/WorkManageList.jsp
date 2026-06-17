<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html
  lang="en"
  class="js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths"
>
  <head>
    <%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
    <!-- SummerNote -->
    <script type="text/javascript" src="<c:url value='/js/summernote/summernote.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/datetimepicker/jquery.datetimepicker.full.min.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/js/summernote/summernote.css'/>" />
    
    <script>
      /* =========== 페이지 쿠키 값 저장 ========= */
      $(function () {
        $.cookie("name", "workManage");
      });
    </script>
    <script>
      $(document).ready(function () {
        var formData = $("#form").serializeObject();
        $("#list").jqGrid({
          url: "<c:url value='/workManage'/>",
          mtype: "POST",
          postData: formData,
          datatype: "json",
          colNames: ["Key", "메일발송", "관리번호", "고객사", "한줄요약", "테스트 대상 제품유형", "패키지명", "엔지니어", "요청구분", "요청일자", "작성자", "테스터", "진행률", "진행상태", "테스트일정", "유형", "패키지명"],
          colModel: [
            { name: "workManageKeyNum", index: "workManageKeyNum", align: "center", width: 35, hidden: true },
            { name: "workManageTestSchedule", index: "workManageTestSchedule", align: "center", width: 70, formatter: mailFormatter },
            { name: "workManageKeyNum", index: "workManageKeyNum", align: "center", width: 50, formatter: managerNumber },
            { name: "workManageCustomer", index: "workManageCustomer", align: "center", width: 200, formatter: linkFormatter },
            { name: "workManageOneLine", index: "workManageOneLine", align: "left", width: 400 },
            { name: "workManageProductType", index: "workManageProductType", align: "center", width: 180, formatter: subPackage },
            { name: "workManagePackageName", index: "workManagePackageName", align: "center", width: 400, hidden: true },
            { name: "workManageEngineer", index: "workManageEngineer", align: "center", width: 60 },
            { name: "workManageDivision", index: "workManageDivision", align: "center", width: 80 },
            { name: "workManageRequestDate", index: "workManageRequestDate", align: "center", width: 80 },
            { name: "workManageAuthor", index: "workManageAuthor", align: "center", width: 60 },
            { name: "workManageTester", index: "workManageTester", align: "center", width: 150 },
            {
              name: "workManageProgress",
              index: "workManageProgress",
              align: "center",
              width: 40,
              formatter: function (cellvalue) {
                return cellvalue + "%";
              },
            },
            { name: "workManageProgressStatus", index: "workManageProgressStatus", align: "center", width: 55, formatter: stateFormatter },
            { name: "workManageTestSchedule", index: "workManageTestSchedule", align: "center", width: 140, formatter: testScheduleFormatter },
            { name: "workManageProductType", index: "workManageProductType", align: "center", width: 100, hidden: true },
            { name: "workManagePackageNameTwo", index: "workManagePackageName", align: "center", width: 100, hidden: true },
          ],
          jsonReader: {
            id: "workManageKeyNum",
            repeatitems: false,
          },
          pager: "#pager", // 페이징
          rowNum: 25, // 보여중 행의 수
          sortname: "workManageKeyNum", // 기본 정렬
          sortorder: "desc", // 정렬 방식

          multiselect: true, // 체크박스를 이용한 다중선택
          viewrecords: false, // 시작과 끝 레코드 번호 표시
          gridview: true, // 그리드뷰 방식 랜더링
          sortable: true, // 컬럼을 마우스 순서 변경
          height: "650",
          autowidth: true, // 가로 넒이 자동조절
          shrinkToFit: false, // 컬럼 폭 고정값 유지
          altRows: false, // 라인 강조
        });
        loadColumns("#list", "workManageKeyNum");
      });

      $(window).on("resize.list", function () {
        jQuery("#list").jqGrid("setGridWidth", $(".page-wrapper").width());
      });
    </script>
  </head>
  <body>
    <div id="pcoded" class="pcoded iscollapsed">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
        <%@ include file="/WEB-INF/jsp/common/_LoginSession.jsp"%> <%@ include file="/WEB-INF/jsp/common/_TopMenu.jsp"%>
        <div class="pcoded-main-container" style="margin-top: 56px">
          <div class="pcoded-wrapper">
            <%@ include file="/WEB-INF/jsp/common/_LeftMenu.jsp"%>
            <div class="pcoded-content" id="page-wrapper">
              <div class="page-header">
                <div class="page-block">
                  <div class="row align-items-center">
                    <div class="col-md-8">
                      <div class="page-header-title">
                        <h5 class="m-b-10">테스트 업무 관리</h5>
                        <p class="m-b-0">test workManage List</p>
                      </div>
                    </div>
                    <div class="col-md-4">
                      <ul class="breadcrumb-title">
                        <li class="breadcrumb-item">
                          <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
                        </li>
                        <li class="breadcrumb-item"><a href="#!">테스트 업무 관리</a></li>
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
                        <div style="float: right">
                          <button type="button" class="btn btn-info btn-sm" id="btnToggleSearch">
                            <span id="toggleIcon">▼</span>
                          </button>
                        </div>
                        <form id="form" name="form" method="post" style="display: flex">
                          <div id="searchFields" style="display: none" class="clearfix">
                            <div style="padding-left: 15px; width: 100%; float: left">
                              <label class="labelFontSize">요청일자</label>
                              <div>
                                <input class="form-control" style="width: 12.5%; float: left" type="date" id="workManageRequestDateStart" name="workManageRequestDateStart" max="9999-12-31" />
                                <span style="float: left; padding-left: 10px; padding-right: 10px; padding-top: 5px"> ~ </span>
                                <input class="form-control" style="width: 12.5%; float: left" type="date" id="workManageRequestDateEnd" name="workManageRequestDateEnd" max="9999-12-31" />
                              </div>
                              <div style="padding-left: 50px; float: left">
                                <div class="form-check radioDate">
                                  <input class="form-check-input" type="radio" name="workManageRequestDate" id="toDay" value="0" />
                                  <label class="form-check-label" for="toDay"> 당일 </label>
                                </div>
                                <div class="form-check radioDate">
                                  <input class="form-check-input" type="radio" name="workManageRequestDate" id="oneWeek" value="7" />
                                  <label class="form-check-label" for="oneWeek"> 1주일 </label>
                                </div>
                                <div class="form-check radioDate">
                                  <input class="form-check-input" type="radio" name="workManageRequestDate" id="oneMonth" value="30" />
                                  <label class="form-check-label" for="oneMonth"> 1개월 </label>
                                </div>
                                <div class="form-check radioDate">
                                  <input class="form-check-input" type="radio" name="workManageRequestDate" id="threeMonth" value="90" />
                                  <label class="form-check-label" for="threeMonth"> 3개월 </label>
                                </div>
                                <div class="form-check radioDate">
                                  <input class="form-check-input" type="radio" name="workManageRequestDate" id="dateFull" value="full" checked />
                                  <label class="form-check-label" for="dateFull"> 전체 </label>
                                </div>
                              </div>
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">관리번호</label>
                              <input type="text" id="managerNumber" name="managerNumber" class="form-control" />
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">고객사</label>
                              <select class="form-control selectpicker" id="workManageCustomerMulti" name="workManageCustomerMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
                                <c:forEach var="item" items="${workManageCustomer}">
                                  <option value="${item}"><c:out value="${item}" /></option>
                                </c:forEach>
                              </select>
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">패키지명</label>
                              <select class="form-control selectpicker" id="workManagePackageNameMulti" name="workManagePackageNameMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
                                <c:forEach var="item" items="${workManagePackageName}">
                                  <option value="${item}"><c:out value="${item}" /></option>
                                </c:forEach>
                              </select>
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">엔지니어</label>
                              <input type="text" id="workManageEngineer" name="workManageEngineer" class="form-control" />
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">요청구분</label>
                              <select class="form-control selectpicker" id="workManageDivisionMulti" name="workManageDivisionMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
                                <option value="" selected><c:out value="" /></option>
                                <option value="email">이메일</option>
                                <option value="phoine">전화</option>
                                <option value="visit">방문</option>
                              </select>
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">작성자</label>
                              <input type="text" id="workManageAuthor" name="workManageAuthor" class="form-control" />
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">테스터</label>
                              <input type="text" id="workManageTester" name="workManageTester" class="form-control" />
                            </div>
                            <div class="col-lg-2">
                              <label class="labelFontSize">진행상태</label>
                              <select class="form-control selectpicker" id="workManageProgressStatusMulti" name="workManageProgressStatusMulti" data-live-search="true" data-size="5" data-actions-box="true" multiple>
                                <c:forEach var="item" items="${workManageProgressStatus}">
                                  <option value="${item}"><c:out value="${item}" /></option>
                                </c:forEach>
                              </select>
                            </div>

                            <input type="hidden" id="workManageCustomer" name="workManageCustomer" class="form-control" />
                            <input type="hidden" id="workManagePackageName" name="workManagePackageName" class="form-control" />
                            <input type="hidden" id="workManageDivision" name="workManageDivision" class="form-control" />
                            <input type="hidden" id="workManageProgressStatus" name="workManageProgressStatus" class="form-control" />
                            <input type="hidden" id="workManageDelFlag" name="workManageDelFlag" class="form-control" />

                            <div class="col-lg-12 text-right">
                              <p class="search-btn">
                                <button class="btn btn-search btnm" type="button" id="btnSearch"><i class="fa fa-search"></i>&nbsp;<span>검색</span></button>
                                <button class="btn btn-default btnm" type="button" id="btnReset">
                                  <span>초기화</span>
                                </button>
                              </p>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                    <table style="width: 99%">
                      <tbody>
                        <tr>
                          <td style="padding: 0px 0px 0px 0px" class="box">
                            <table style="width: 100%">
                              <tbody>
                                <tr>
                                  <td>
                                    <div class="work-toolbar">
                                      <div class="toolbar-title">
                                        <span>📋 작업 관리</span>
                                      </div>

                                      <div class="toolbar-group">
                                        <div class="group-label">기본 작업</div>

                                        <button class="btn2 btn-primary listBtn myBtn" id="BtnInsert">➕ 추가</button>
                                        <button class="btn2 btn-danger listBtn myBtn" id="BtnDelect">🗑 삭제</button>
                                      </div>

                                      <div class="toolbar-group">
                                        <div class="group-label">업무 관리</div>

                                        <button class="btn2 btn-warning listBtn myBtn" id="BtnComplete">🔄 진행상태 변경</button>
                                      </div>

                                      <div class="toolbar-group">
                                        <div class="group-label">보고서</div>

                                        <button class="btn2 btn-light listBtn myBtn" id="BtnResultsReport">📄 결과 보고서</button>
                                        <button class="btn2 btn-light listBtn myBtn" id="BtnAllReport">📊 통합</button>
                                        <button class="btn2 btn-light listBtn myBtn" id="BtnWeeklyReport">📈 주간</button>
                                        <button class="btn2 btn-light listBtn myBtn" id="BtnDailyReport">📅 일일</button>
                                      </div>

                                      <div class="toolbar-group">
                                        <div class="group-label">기타</div>

                                        <button class="btn2 btn-light listBtn myBtn" id="BtnMailSendList">📧 메일 이력</button>
                                        <button class="btn2 btn-light listBtn myBtn" id="BtnDelectList">🗂 삭제 업무</button>
                                        <button class="btn2 btn-light listBtn myBtn" onclick="selectColumns('#list', 'workManageKeyNum')">⚙ 컬럼 설정</button>
                                      </div>
                                    </div>
                                  </td>
                                </tr>
                                <tr>
                                  <td class="border1" colspan="2">
                                    <!------- Grid ------->
                                    <div class="jqGrid_wrapper">
                                      <table id="list"></table>
                                      <div id="pager"></div>
                                    </div>
                                    <!------- Grid ------->
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </td>
                        </tr>
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

  <script>
    /* =========== 작업 추가 Modal ========= */
    $("#BtnInsert").click(function () {
      $.ajax({
        type: "POST",
        url: "<c:url value='/workManage/insertView'/>",
        async: false,
        success: function (data) {
          if (data.indexOf("<!DOCTYPE html>") != -1) location.reload();
          $.modal(data, "workManage"); //modal창 호출
        },
        error: function (e) {
          // TODO 에러 화면
        },
      });
    });

    /* =========== 검색 ========= */
    $("#btnSearch").click(function () {
      var workManageRequestDateStart = $("#workManageRequestDateStart").val();
      var workManageRequestDateEnd = $("#workManageRequestDateEnd").val();
      if (workManageRequestDateStart > workManageRequestDateEnd) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "전달일자 시작일이 종료일자 보다 큽니다.",
        });
      } else if (workManageRequestDateStart == "" && workManageRequestDateEnd != "") {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "전달일자 시작일을 입력해주세요.",
        });
      } else if (workManageRequestDateEnd == "" && workManageRequestDateStart != "") {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "전달일자 종료일을 입력해주세요.",
        });
      } else {
        tableRefresh();
      }
    });

    /* =========== 테이블 새로고침 ========= */
    function tableRefresh() {
      setTimerSessionTimeoutCheck(); // 세션 타임아웃 리셋
      $("#workManageCustomer").val($("#workManageCustomerMulti").val().join());
      $("#workManagePackageName").val($("#workManagePackageNameMulti").val().join());
      $("#workManageDivision").val($("#workManageDivisionMulti").val().join());
      $("#workManageProgressStatus").val($("#workManageProgressStatusMulti").val().join());

      var _postDate = $("#form").serializeObject();

      var jqGrid = $("#list");
      jqGrid.clearGridData();
      jqGrid.setGridParam({ postData: _postDate });
      jqGrid.trigger("reloadGrid");
    }

    /* =========== Enter 검색 ========= */
    $("input[type=text]").keypress(function (event) {
      if (window.event.keyCode == 13) {
        tableRefresh();
      }
    });

    /* =========== 갤린더 검색 ========= */
    $("#requestDate").change(function () {
      tableRefresh();
    });

    /* =========== Select Box 선택 ========= */
    $("select").change(function () {
      tableRefresh();
    });

    /* =========== 검색 초기화 ========= */
    $("#btnReset").click(function () {
      $("input[type='text']").val("");
      $("input[type='hidden']").val("");
      $("input[type='date']").val("");
      $("#dateFull").prop("checked", true);

      $(".selectpicker").val("");
      $(".filter-option-inner-inner").text("");

      tableRefresh();
    });

    /* =========== 작업 삭제 ========= */
    $("#BtnDelect").click(function () {
      var chkList = $("#list").getGridParam("selarrrow");
      if (chkList == 0) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "선택한 행이 존재하지 않습니다.",
        });
      } else {
        Swal.fire({
          title: "삭제!",
          text: "선택한 업무를 삭제하시겠습니까?",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#7066e0",
          cancelButtonColor: "#FF99AB",
          confirmButtonText: "OK",
        }).then((result) => {
          if (result.isConfirmed) {
            //   $.ajax({
            // 	url: "<c:url value='/workManage/delete'/>",
            // 	type: "POST",
            // 	data: {chkList: chkList},
            // 	dataType: "text",
            // 	traditional: true,
            // 	async: false,
            // 	success: function(data) {
            // 		if(data == "OK")
            // 			Swal.fire(
            // 			  '성공!',
            // 			  '삭제 완료하였습니다.',
            // 			  'success'
            // 			)
            // 		else
            // 			Swal.fire(
            // 			  '실패!',
            // 			  '삭제 실패하였습니다.',
            // 			  'error'
            // 			)
            // 		tableRefresh();
            // 	},
            // 	error: function(error) {
            // 		console.log(error);
            // 	}
            //   });

            $.ajax({
              type: "POST",
              url: "<c:url value='/workManage/deleteFlagView'/>",
              data: { chkList: chkList },
              async: false,
              traditional: true,
              success: function (data) {
                if (data.indexOf("<!DOCTYPE html>") != -1) location.reload();
                $.modal(data, "r"); //modal창 호출
              },
              error: function (e) {
                // TODO 에러 화면
              },
            });
          }
        });
      }
    });

    $("#BtnDelectList").click(function () {
      $("#workManageDelFlag").val("Y");
      tableRefresh();
    });

    $("#BtnMailSendList").click(function () {
      var chkList = $("#list").getGridParam("selarrrow");
      if (chkList == 0) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "선택한 행이 존재하지 않습니다.",
        });
      } else if (chkList.length > 1) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "한개의 행만 선택 바랍니다.",
        });
      } else {
        $.ajax({
          type: "POST",
          url: "<c:url value='/workManage/mailSendListView'/>",
          data: { chkList: chkList },
          async: false,
          traditional: true,
          success: function (data) {
            if (data.indexOf("<!DOCTYPE html>") != -1) location.reload();
            $.modal(data, "r"); //modal창 호출
          },
          error: function (e) {
            // TODO 에러 화면
          },
        });
      }
    });

    $("#BtnComplete").click(function () {
      var chkList = $("#list").getGridParam("selarrrow");
      if (chkList == 0) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "선택한 행이 존재하지 않습니다.",
        });
      } else {
        $.ajax({
          type: "POST",
          url: "<c:url value='/workManage/progressView'/>",
          data: { chkList: chkList },
          async: false,
          traditional: true,
          success: function (data) {
            if (data.indexOf("<!DOCTYPE html>") != -1) location.reload();
            $.modal(data, "r"); //modal창 호출
          },
          error: function (e) {
            // TODO 에러 화면
          },
        });
      }
    });

    $("#BtnAllReport").click(function () {
      window.location = "<c:url value='/workManage/allReportDownload'/>";
    });

    $("#BtnWeeklyReport").click(function () {
      window.location = "<c:url value='/workManage/weeklyReportDownload'/>";
    });

    $("#BtnDailyReport").click(function () {
      window.location = "<c:url value='/workManage/dailyReportDownload'/>";
    });

    $("#BtnResultsReport").click(function () {
      var chkList = $("#list").getGridParam("selarrrow");
      if (chkList == 0) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "선택한 행이 존재하지 않습니다.",
        });
      } else if (chkList.length > 1) {
        Swal.fire({
          icon: "error",
          title: "실패!",
          text: "한개의 행만 선택 바랍니다.",
        });
      } else {
        $.ajax({
          type: "POST",
          url: "<c:url value='/resultsReport/selectTemplatList'/>",
          async: false,
          data: { workManageKeyNum: chkList[0] },
          success: function (result) {
            if (result === "WorkManage") {
              location.href = "<c:url value='/resultsReport/updateWorkManageView'/>?workManageKeyNum=" + chkList[0];
            } else if (result === "ResultsReport") {
              insertTemplatList(chkList[0]);
            }
          },
          error: function (e) {
            alert(e);
          },
          complete: function () {
            modalOpened = false; // 요청이 완료되면 모달이 닫혔다고 가정
          },
        });
      }
    });

    function insertTemplatList(workManageKeyNum) {
      $.ajax({
        type: "POST",
        url: "<c:url value='/resultsReport/insertTemplatList'/>",
        async: false,
        data: { workManageKeyNum: workManageKeyNum },
        success: function (data) {
          $.modal(data, "resultsReportTemplateList"); //modal창 호출
          modalOpened = true; // 모달이 열렸음을 표시
        },
        error: function (e) {
          alert(e);
        },
        complete: function () {
          modalOpened = false; // 요청이 완료되면 모달이 닫혔다고 가정
        },
      });
    }

    /* =========== 작업 수정 Modal ========= */
    function updateView(data) {
      $.ajax({
        type: "POST",
        url: "<c:url value='/workManage/updateView'/>",
        data: { workManageKeyNum: data },
        async: false,
        success: function (data) {
          if (data.indexOf("<!DOCTYPE html>") != -1) location.reload();
          $.modal(data, "workManage"); //modal창 호출
        },
        error: function (e) {
          // TODO 에러 화면
        },
      });
    }

    /* =========== 전달일자 업데이트 ========= */
    function changeDate(term) {
      const dateTo = new Date();
      const dateFrom = new Date(Date.parse(dateTo) - term * 1000 * 60 * 60 * 24);

      if (term == "full") {
        $("#workManageRequestDateStart").val("");
        $("#workManageRequestDateEnd").val("");
      } else {
        $("#workManageRequestDateStart").val($.datepicker.formatDate("yy-mm-dd", dateFrom));
        $("#workManageRequestDateEnd").val($.datepicker.formatDate("yy-mm-dd", dateTo));
      }
    }

    /* =========== 전달일자 라이오 버튼 클릭 ========= */
    $(function () {
      $("#managerNumber").val("${managerNumber}").trigger("change");
      setTimeout(function () {
        tableRefresh();
      }, 300);

      $('input[name="workManageRequestDate"]').click(function () {
        const value = $(this).val();
        if (value !== undefined) {
          changeDate(value);
        }
      });
    });

    function urlOpen(url) {
      window.open(url, "_blank");
    }

    /* =========== jpgrid의 formatter 함수 ========= */
    function linkFormatter(cellValue, options, rowdata, action) {
      return '<a onclick="updateView(' + "'" + rowdata.workManageKeyNum + "'" + ')" style="color:#366cb3;">' + cellValue + "</a>";
    }

    function managerNumber(cellValue, options, rowdata, action) {
      return "S" + String(rowdata.workManageKeyNum).padStart(5, "0");
    }

    function testScheduleFormatter(cellValue, options, rowdata, action) {
      return rowdata.workManageTestScheduleStart + " ~ " + rowdata.workManageTestScheduleEnd;
    }

    function mailFormatter(cellValue, options, rowdata, action) {
      var cls = rowdata.mailSendYn == "Y" ? "btn-mail sent" : "btn-mail";

      return '<button type="button" class="' + cls + '" onclick="sendMail(\'' + rowdata.workManageKeyNum + "')\">메일발송</button>";
    }

    function subPackage(cellvalue, options, rowObject) {
      return "<a href='javascript:void(0)' onclick='toggleDetail(" + options.rowId + ")' style='color:#366cb3;'>" + cellvalue + "</a>";
    }

    function toggleDetail(rowId) {
      var detailId = "detail_" + rowId;

      // 이미 존재하면 toggle
      if ($("#" + detailId).length > 0) {
        $("#" + detailId).toggle();
        return;
      }

      var rowData = $("#list").jqGrid("getRowData", rowId);

      // [수정] 제품유형(Type) 제거, 오직 패키지명(Name) 쉼표 문자열만 배열로 변환
      var nameArray = (rowData.workManagePackageName || "").split(",");

      var html = "";
      html += "<tr id='" + detailId + "' class='detail-row'>";
      html += "<td colspan='13' style='padding:10px; background:#f4f6f9;'>";

      // 카드 시작
      html += "<div style='background:white; border-radius:10px; padding:20px; box-shadow:0 2px 6px rgba(0,0,0,0.08); border:1px solid #e5e7eb;'>";

      // 제목
      html += "<div style='font-size:16px; font-weight:bold; color:#2F5597; margin-bottom:20px;'>패키지 상세 정보</div>";

      // 패키지 영역
      html += "<div style='display:flex; flex-direction:column; gap:12px;'>";

      // [수정] 패키지명 배열의 개수만큼만 반복문 수행
      for (var i = 0; i < nameArray.length; i++) {
        var name = nameArray[i] ? nameArray[i].trim() : "";

        // 패키지명 데이터가 존재하는 경우에만 HTML 태그 생성
        if (name != "") {
          html += "<div style='padding:14px; border-radius:8px; background:#f8f9fa; border:1px solid #e5e7eb;'>";
          // [수정] 제품유형 표시 영역 제거, 패키지명만 크게 노출
          html += "  <div style='font-size:15px; font-weight:bold; color:#222;'>" + name + "</div>";
          html += "</div>";
        }
      }

      html += "</div>"; // 패키지 영역 끝
      html += "</div>"; // 카드 끝
      html += "</td>";
      html += "</tr>";

      $("#" + rowId).after(html);
    }

    function stateFormatter(value, options, row) {
      var state = row.workManageProgressStatus.toUpperCase();
      if (state == "진행중") {
        return '<div><img src="/AgentInfo/images/inprogress2.png" style="width:50px;"></div';
      } else if (state == "완료") {
        return '<div><img src="/AgentInfo/images/complete.png" style="width:50px;"></div';
      } else if (state == "보류") {
        return '<div><img src="/AgentInfo/images/hold.png" style="width:50px;"></div';
      } else if (state == "미처리 완료") {
        return '<div><img src="/AgentInfo/images/unprocessed2.png" style="width:50px;"></div';
      }

      return "<div></div>";
    }

    function sendMail(workManageKeyNum) {
      $.ajax({
        type: "POST",
        url: "<c:url value='/workManage/mailSend'/>",
        data: { workManageKeyNum: workManageKeyNum },
        async: false,
        success: function (result) {
          if (result == "OK") {
            Swal.fire({
              icon: "success",
              title: "성공!",
              text: "메일발송 완료했습니다.",
            });
          } else if (result == "SizeFull") {
            Swal.fire({
              icon: "success",
              title: "성공!",
              text: "첨부파일 중 5MB 이상 파일은 제외하여 전송하였습니다.",
            });
          } else if (result == "Korean") {
            Swal.fire({
              icon: "info",
              title: "메일 계정 확인!",
              text: "테스터 다시 확인 바랍니다.",
            });
          } else if (result == "ToFail") {
            Swal.fire({
              icon: "error",
              title: "테스터 미지정!",
              text: "테스터 지정 후 메일 발송 바랍니다.",
            });
          } else {
            Swal.fire({
              icon: "error",
              title: "실패!",
              text: "작업에 실패하였습니다.",
            });
          }
        },
        error: function (e) {
          // TODO 에러 화면
        },
      });
    }

    $(document).ready(function () {
      $("#btnToggleSearch").on("click", function (e) {
        e.preventDefault();

        var $fields = $("#searchFields");
        var $icon = $("#toggleIcon");

        $fields.slideToggle(300, function () {
          if ($fields.is(":visible")) {
            $icon.text("▲"); // 열려있을 때는 접기 모양
          } else {
            $icon.text("▼"); // 닫혀있을 때는 펼치기 모양
          }
        });
      });
    });
  </script>
  <style>
    .btn-mail {
      padding: 4px 8px;
      font-size: 12px;
      color: #555;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.2s;
    }

    .btn-mail:hover {
      color: #6366f1; /* 마우스 올렸을 때 포인트 컬러 (보라/블루 계열) */
      border-color: #6366f1;
      background-color: #f8fafc;
    }

    /* 그리드 테이블 레이아웃 고정 및 줄바꿈 방지 */
    .ui-jqgrid .ui-jqgrid-btable {
      table-layout: fixed !important;
    }

    /* 모든 셀 내부의 텍스트가 넘치면 숨기고 말줄임(...) 처리 */
    .ui-jqgrid tr.jqgrow td {
      text-overflow: ellipsis !important;
      overflow: hidden !important;
      white-space: nowrap !important;
      word-break: break-all !important;
    }

    .btn-mail.sent {
      background: #4c84ff !important;
      color: #fff;
    }
  </style>
</html>
