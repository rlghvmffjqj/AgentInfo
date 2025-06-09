<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js flexbox flexboxlegacy canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers no-applicationcache svg inlinesvg smil svgclippaths">
	<head>
		<%@ include file="/WEB-INF/jsp/common/_Head.jsp"%>
		<script>
		$(function() {
	    	$.cookie('name','resultsReport');
	    });
		</script>
	</head>
	<body>
	<div id="pcoded" class="pcoded iscollapsed">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
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
							                <h5 class="m-b-10">결과 보고서</h5>
							                <p class="m-b-0">Function Test</p>
							            </div>
							        </div>
							        <div class="col-md-4">
							            <ul class="breadcrumb-title">
							                <li class="breadcrumb-item">
							                    <a href="<c:url value='/index'/>"> <i class="fa fa-home"></i> </a>
							                </li>
							                <li class="breadcrumb-item"><a href="#!">결과 보고서</a>
							                </li>
							            </ul>
							        </div>
							    </div>
							</div>
						</div>
							<form id="form" name="form" method ="post">
			                	<div class='main-body'>
				                    <div class='page-wrapper'>
				                    	<div class='ibox'>	
											<button class="btn btn-outline-info-add" type="button" id="BtnPDFexport">PDF다운로드</button>
											<div class='writeDiv' style="color:black; padding-left: 40px; padding-right: 40px;">
												${resultsReportContent}
											</div>
										</div>
									</div>
								</div>
							</form> 
							<div style="position: fixed; top: 95%; right: 20px;">
								<button class="btn btn-outline-info-add myBtn" type="button" id="addRow">행 추가</button>
								<button class="btn btn-outline-info-del myBtn" type="button" id="deleteRow">행 삭제</button>
								<button class="btn btn-outline-info-nomal myBtn" type="button" id="mergeCells">셀 병합</button>
								<button class="btn btn-outline-info-nomal myBtn" type="button" id="splitCells">셀 나누기</button>
								<button class="btn btn-outline-info-nomal myBtn" type="button" id="selectNone">셀 선택 해제</button>
							</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>

	<script>
		$(document).ready(function() {
  		  const today = new Date();
  		  const formattedDate1 = today.getFullYear() + "년 " +
  		                        String(today.getMonth() + 1).padStart(2, '0') + "월 " +
  		                        String(today.getDate()).padStart(2, '0') + "일";
  		  $('.title5 input').val(formattedDate1);

			const formattedDate2 = today.getFullYear() + ". " +
  		                        String(today.getMonth() + 1).padStart(2, '0') + ". " +
  		                        String(today.getDate()).padStart(2, '0')
  		  $('#resultsReportTestDate').val(formattedDate2 + " ~ " + formattedDate2);

		  $('#resultsReportVerifier').val("QA / ${username}");
		  $('#resultsReportVerifier2').val("${username} / 양기석");
		  $('#resultsReportNumber').val("QA-${yearDate}-${maxNumber}");

  		});

		/* =========== 전달일자 오늘 날짜 입력 ========= */
		// document.getElementById('resultsReportDate').value = new Date().toISOString().substring(0, 10);
		$('#BtnPDFexport').click(function() {
			var styles = $("style#pdfStyle").html();
			var htmlContent = domupPDFdate();
			var jsp = "<style>" + styles + "</style>" + htmlContent;

			var resultsReportKeyNum = String(1).padStart(4, '0');;
			var resultsReportCustomerName = '시큐브';
			var resultsReportDate = "2025-03-17".replace(/-/g, "");
			$.ajax({
				url: "<c:url value='/resultsReport/pdf'/>",
				type: "POST",
				data: {
						"jsp": jsp,
						"resultsReportKeyNum":resultsReportKeyNum,
						"resultsReportCustomerName":resultsReportCustomerName,
						"resultsReportDate":resultsReportDate,
					},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "OK") {
						var fileName = resultsReportKeyNum + "_테스트_결과보고서_" + resultsReportCustomerName + "_" + resultsReportDate + ".pdf";
						pdfDown(fileName);
					} else {
						Swal.fire({               
							icon: 'error',          
							title: '실패!',           
							text: 'PDF Download Error!\n관리자에게 문의 바랍니다.',    
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			});
		})

		function pdfDown(fileName) {
			window.location ="<c:url value='/resultsReport/fileDownload?fileName="+fileName+"'/>";
			setTimeout(function() {
				fileDelete(fileName);
			},300);
		}

		function fileDelete(fileName) {
			$.ajax({
				url: "<c:url value='/resultsReport/fileDelete'/>",
				type: "POST",
				data: {
						"fileName": fileName,
					},
				dataType: "text",
				traditional: true,
				async: false,
				success: function(data) {
					if(data == "OK") {
						Swal.fire({
							icon: 'success',
							title: '성공!',
							text: 'PDF다운로드 완료되었습니다.'
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '실패!',
							text: 'PDF파일이 존재하지 않습니다.',
						});
					}
				},
				error: function(error) {
					console.log(error);
				}
			  });
		}

		function autoResize(textarea) {
		  textarea.style.height = 'auto'; // 높이 초기화
		  textarea.style.height = (textarea.scrollHeight) + 'px'; // 내용에 맞게 높이 설정
		}
	</script>
	
	<script>
		let selectedCells = [];

		function clearSelection() {
		    $(".selected").removeClass("selected");
		    selectedCells = [];
		}

		// 전체 선택 해제
		$("#selectNone").click(function () {
			clearSelection();
		});

        // 셀 선택/해제
        $(document).on("click", "td", function () {
		    if ($(this).hasClass("selected")) {
		        $(this).removeClass("selected");
		        selectedCells = selectedCells.filter(cell => cell !== this);
		    } else {
		        $(this).addClass("selected");
		        selectedCells.push(this);
		    }
			console.log(selectedCells);
		});


        // 행 추가
        $("#addRow").click(function () {
			const $report = $(selectedCells[0]).closest("table");

		    if (selectedCells.length !== 1) {
		        Swal.fire({
		            icon: 'error',
		            title: '실패!',
		            text: selectedCells.length === 0
		                ? '추가할 셀을 선택하세요.'
		                : '하나의 셀만 선택해 주세요.',
		        });
		        clearSelection();
		        return;
		    }
		
		    let $cell = $(selectedCells[0]);
		    let rowspan = parseInt($cell.attr("rowspan")) || 1;
		
		    if (rowspan > 1) {
		        Swal.fire({
		            icon: 'error',
		            title: '실패!',
		            text: '세로 병합된 셀 선택 시 행 추가가 불가능합니다.',
		        });
		        clearSelection();
		        return;
		    }
		
		    let $row = $cell.closest("tr");
		    let $table = $row.closest("table");
		    let rowIndex = $table.find("tr").index($row);
		    let $rows = $table.find("tr");
		
		    // 위쪽부터 rowspan 조정
		    for (let i = rowIndex; i >= 0; i--) {
		        $rows.eq(i).find("td[rowspan], th[rowspan]").each(function () {
		            let $rCell = $(this);
		            let rSpan = parseInt($rCell.attr("rowspan")) || 1;
		            let rIndex = $rows.index($rCell.closest("tr"));
				
		            if (rIndex + rSpan - 1 >= rowIndex) {
		                $rCell.attr("rowspan", rSpan + 1);
		                i = -1; // 반복 종료
		                return false;
		            }
		        });
		    }
		
		    // 새 행 생성
		    let $newRow = $("<tr></tr>");
		    $row.children("td, th").each(function () {
		        let $cell = $(this);
		        let rSpan = parseInt($cell.attr("rowspan")) || 1;
			
		        if (rSpan > 1) return; // rowspan 셀은 skip
			
		        let $newCell = $cell.clone();
			
		        $newCell.find("input, textarea").val(""); // 입력 초기화
		        if ($newCell.children().length === 0) $newCell.text(""); // 텍스트 초기화
			
		        $newRow.append($newCell);
		    });
		
		    $row.after($newRow);
		    clearSelection();

			var tableId = $report[0].id;
			if(tableId === "report7") {
				let rowIndex = $table.find("tr").index($row);
				addVerification(rowIndex);
			}

			if(tableId === "report11") {
				let rowIndex = $table.find("tr").index($row);
				addVerification2(rowIndex);
			}

			if(tableId === "report6") {
				let rowIndex = $table.find("tr").index($row);
				addCommVerification(rowIndex);
			}

			if(tableId === "report9") {
				let rowIndex = $table.find("tr").index($row);
				addCommVerification2(rowIndex);

				let $addedRow = $table.find("tr").eq(rowIndex + 1);
	    		let $lastCell = $addedRow.children("td, th").last();

	    		if ($lastCell.find("input").length > 0) {
	    		    $lastCell.find("input").val("○");
	    		} else if ($lastCell.find("textarea").length > 0) {
	    		    $lastCell.find("textarea").val("○");
	    		} else {
	    		    $lastCell.text("○");
	    		}
			}
		});


        // 행 삭제
        $("#deleteRow").click(function () {		
			const $report = $(selectedCells[0]).closest("table");
		    if (selectedCells.length !== 1) {
		        Swal.fire({
		            icon: 'error',
		            title: '실패!',
		            text: selectedCells.length === 0
		                ? '삭제할 행을 선택하세요.'
		                : '하나의 셀만 선택해주세요.',
		        });
		        clearSelection();
		        return;
		    }
		
		    let $cell = $(selectedCells[0]);
		    let $row = $cell.closest("tr");
		    let $table = $row.closest("table");
		    let $rows = $table.find("tr");
		    let rowIndex = $rows.index($row);
		
		    let rowspan = parseInt($cell.attr("rowspan")) || 1;
		    let deleteCount = rowspan;
		
		    // 최소 행 수 확인
		    if ($rows.length - deleteCount < 1) {
		        Swal.fire({
		            icon: 'error',
		            title: '실패!',
		            text: '최소 한 개의 행은 남겨야 합니다.',
		        });
		        return;
		    }
		
		    let $rowsToDelete = $rows.slice(rowIndex, rowIndex + deleteCount);

			// 삭제 전 데이터 보존을 위해 앞쪽에 위치(KIHO)
			var tableId = $report[0].id;
			if(tableId === "report6") {
				delCommVerification();
			}

			if(tableId === "report9") {
				delCommVerification2();
			}
		
		    //셀 복사 후 아래 행으로 이관 (rowspan, colspan 모두)
		    $rowsToDelete.each(function (rIdx, tr) {
		        let $tr = $(tr);
		        $tr.children("td, th").each(function () {
		            let $cell = $(this);
		            let rowspan = parseInt($cell.attr("rowspan")) || 1;
		            let colspan = parseInt($cell.attr("colspan")) || 1;
		            let cellIndex = $cell.index();
				
		            if (rowspan > 1) {
		                let $targetRow = $rows.eq(rowIndex + 1); // 다음 행
					
		                if ($targetRow.length) {
		                    let $clone = $cell.clone().removeAttr("rowspan");
		                    $cell.remove();
						
		                    // 다음 행의 적절한 위치에 삽입
		                    let $nextCells = $targetRow.children("td, th");
		                    if (cellIndex >= $nextCells.length) {
		                        $targetRow.append($clone);
		                    } else {
		                        $nextCells.eq(cellIndex).before($clone);
		                    }
						
		                    // 남은 rowspan 조정
		                    $clone.attr("rowspan", rowspan - 1);
		                }
		            } else {
		                $cell.remove(); // rowspan 아닌 경우는 그냥 삭제
		            }
		        });
		    });
		
		    // 다른 셀의 rowspan 보정 (삭제 영역 포함된 셀)
		    $rows.each(function (i, tr) {
		        $(tr).children("td[rowspan], th[rowspan]").each(function () {
		            let $rCell = $(this);
		            let span = parseInt($rCell.attr("rowspan")) || 1;
		            let rIndex = $rows.index(tr);
		            let rEnd = rIndex + span - 1;
				
		            if (rIndex < rowIndex && rEnd >= rowIndex) {
		                let overlap = Math.min(rEnd, rowIndex + deleteCount - 1) - rowIndex + 1;
		                $rCell.attr("rowspan", span - overlap);
		            }
		        });
		    });
		
		    $rowsToDelete.remove();
		    
			if(tableId === "report7") {
				delVerification(rowIndex);
			}

			if(tableId === "report11") {
				delVerification2(rowIndex);
			}

			clearSelection();
			selectedCells = [];

		});


        // 셀 병합
		$("#mergeCells").click(function () {
			const $report = $(selectedCells[0]).closest("table");

			const $table = $(selectedCells[0]).closest("table");

		    const getSpan = ($cell, type) => parseInt($cell.attr(type)) || 1;
		    const showError = (text) => {
		        Swal.fire({ icon: 'error', title: '실패!', text });
		        clearSelection();
		    };

			if (selectedCells.length <= 1) return showError("두개 이상의 셀을 선택해주세요.");
		
		    // 테이블 셀 매핑
		    const buildCellMap = () => {
		        const map = [];
		        $table.find("tr").each((rowIdx, row) => {
		            map[rowIdx] = map[rowIdx] || [];
		            let colIdx = 0;
		            $(row).children("td, th").each(function () {
		                const $cell = $(this);
		                const rowspan = getSpan($cell, "rowspan");
		                const colspan = getSpan($cell, "colspan");
					
		                while (map[rowIdx][colIdx]) colIdx++;
					
		                for (let r = 0; r < rowspan; r++) {
		                    for (let c = 0; c < colspan; c++) {
		                        map[rowIdx + r] = map[rowIdx + r] || [];
		                        map[rowIdx + r][colIdx + c] = this;
		                    }
		                }
					
		                colIdx += colspan;
		            });
		        });
		        return map;
		    };
		
		    const cellMap = buildCellMap();
		
		    const findCellPos = (cell) => {
		        for (let i = 0; i < cellMap.length; i++) {
		            for (let j = 0; j < cellMap[i]?.length; j++) {
		                if (cellMap[i][j] === cell) return { row: i, col: j };
		            }
		        }
		        return null;
		    };
		
		    const sorted = selectedCells
		        .map(cell => ({ cell, ...findCellPos(cell) }))
		        .sort((a, b) => a.row - b.row || a.col - b.col);
		
		    const sameRow = sorted.every(c => c.row === sorted[0].row);
		    const sameCol = sorted.every(c => c.col === sorted[0].col);
		
		    if (!sameRow && !sameCol) return showError("같은 행 또는 같은 열의 셀만 병합할 수 있습니다.");
		
		    // 병합 제한 조건 검사
		    if (sameCol) {
		        const colspans = sorted.map(c => getSpan($(c.cell), "colspan"));
		        if (colspans.some(c => c > 1)) return showError("가로 병합된 셀은 세로 병합할 수 없습니다.");
		        if (!colspans.every(c => c === colspans[0])) return showError("세로 병합 시 셀들의 가로 길이가 같아야 합니다.");
		    }
		
		    if (sameRow) {
		        const rowspans = sorted.map(c => getSpan($(c.cell), "rowspan"));
		        if (rowspans.some(r => r > 1)) return showError("세로로 병합된 셀은 가로 병합할 수 없습니다.");
		        if (!rowspans.every(r => r === rowspans[0])) return showError("가로 병합 시 셀들의 세로 길이가 같아야 합니다.");
			
		        // 연속성 검사
		        for (let i = 1; i < sorted.length; i++) {
		            if (sorted[i].col !== sorted[i - 1].col + getSpan($(sorted[i - 1].cell), "colspan")) {
		                return showError("병합할 셀들이 가로로 연속되어 있지 않습니다.");
		            }
		        }
		    }
		
		    // 병합할 셀 정보
		    const $first = $(sorted[0].cell);
		    const inputVal = $first.find("input, textarea").val()?.trim() || $first.text().trim();
		    const totalRowspan = sorted.reduce((sum, c) => sum + getSpan($(c.cell), "rowspan"), 0);
		    const totalColspan = sorted.reduce((sum, c) => sum + getSpan($(c.cell), "colspan"), 0);
		
		    $first
		        .attr("rowspan", sameCol ? totalRowspan : null)
		        .attr("colspan", sameRow ? totalColspan : null)
		        .removeAttr(sameCol ? "colspan" : "rowspan")
		        .html(`<input class="borderDotted" type="text" value="${inputVal}">`)
		        .show();
		
		    // 나머지 셀 제거
		    sorted.slice(1).forEach(({ cell }) => {
		        const $cell = $(cell);
		        const rs = getSpan($cell, "rowspan");
		        const cs = getSpan($cell, "colspan");
		        const pos = findCellPos(cell);
			
		        for (let r = 0; r < rs; r++) {
		            const $tr = $table.find("tr").eq(pos.row + r);
		            for (let c = 0; c < cs; c++) {
		                const target = cellMap[pos.row + r]?.[pos.col + c];
		                if (target) $(target).remove();
		            }
		        }
		    });
		
		    $(".selected").removeClass("selected");
		    $first.addClass("selected");
		    selectedCells = [$first[0]];
		    clearSelection();
		});


		// 셀 나누기
		$("#splitCells").click(function () {
			const $report = $(selectedCells[0]).closest("table");

		    const showError = (msg) =>
		        Swal.fire({ icon: 'error', title: '실패!', text: msg });
				
		    if (selectedCells.length !== 1) return showError("분할할 셀 하나를 선택하세요.");
				
		    const $cell = $(selectedCells[0]);
		    const colspan = parseInt($cell.attr("colspan")) || 1;
		    const rowspan = parseInt($cell.attr("rowspan")) || 1;
				
		    if (colspan <= 1 && rowspan <= 1) return showError("분할할 병합 셀이 아닙니다.");
				
		    // 병합 속성 제거
		    $cell.removeAttr("colspan rowspan");
				
		    // width-* 클래스 제거
		    $cell.removeClass((_, cls) => cls.split(" ").filter(c => c.startsWith("width")).join(" "));
				
		    const $table = $cell.closest("table");
		    const $row = $cell.closest("tr");
		    const rowIndex = $row.index();
				
		    // 가로 분할: 같은 행에 td 추가
		    if (colspan > 1) {
		        const $newCells = Array(colspan - 1).fill().map(() =>
		            $('<td class="tableTd"><input class="borderDotted" type="text" value=""></td>')
		        );
		        $cell.after($newCells);
		    }
		
		    // 세로 분할: 아래 행에 td 추가
		    if (rowspan > 1) {
		        for (let i = 1; i < rowspan; i++) {
		            const $targetRow = $table.find("tr").eq(rowIndex + i);
		            if ($targetRow.length) {
		                $(`<td class="tableTd"><input class="borderDotted" type="text" value=""></td>`)
		                    .prependTo($targetRow);
		            }
		        }
		    }
		
		    clearSelection();
		});

		function addVerification(rowIndex) {
			const newScenarioNumber = calculateNextScenarioNumber();
		    const html = `
		        <p style="font-size: 15px; padding-top: 25px;">
		            <input class="borderDotted scenarioNumber" type="text" value="1.3.`+newScenarioNumber+`. 해당 사항 없음">
		        </p>
		        <div>
		            <table class="report8" style="width: 100%; border-collapse: collapse; border: 1px solid black;">
		                <tr>
		                    <th class="tableTd tableCenter">
		                        <input class="inputCenter borderDotted" type="text" value="요구사항">
		                    </th>
		                    <th class="tableTd tableCenter">
		                        <input class="borderDotted" type="text" value="1. 해당사항 없음">
		                    </th>
		                </tr>
		                <tr>
		                    <td class="tableTd tableCenter width15p" style="width: 15%;">
		                        <input class="inputCenter borderDotted" type="text" value="테스트 절차">
		                    </td>
		                    <td class="tableTd width15p" style="width: 85%; min-height: 50px;">
		                        <textarea class="borderDotted scenarioTextarea" oninput="autoResize(this)" style="resize:none;">해당사항 없음</textarea>
		                    </td>
		                </tr>
		            </table>
		        </div>
		    `;
			
		    const $scenarioContainer = $('#scenario').parent();
		    const $report8Tables = $scenarioContainer.find('table.report8');
			
		    if (rowIndex >= $report8Tables.length) {
		        $scenarioContainer.append(html);
		    } else {
		        const $targetDiv = $report8Tables.eq(rowIndex-1).closest('div');
		        $targetDiv.after(html);
		    }
			updateScenarioNumbers();
		
		    // textarea 자동 리사이즈
		    const $newTable = $(html).find('table.report8');  // 새로 추가된 테이블 선택
    		$newTable.find('textarea.autoResize').on('input', function () {
    		    this.style.height = 'auto';  // 높이 자동 설정
    		    this.style.height = this.scrollHeight + 'px';  // 텍스트 길이에 맞게 높이 설정
    		});
		
		    // report11 테이블 행 추가
		    const newRow = `
		        <tr>
		            <td class="tableTd tableCenter width15p"><input class="inputCenter borderDotted" type="text" value=""></td>
		            <td class="tableTd tableCenter width70p"><input class="inputCenter borderDotted" type="text" value=""></td>
		            <td class="tableTd tableCenter width15p"><input class="inputCenter borderDotted" type="text" value="○"></td>
		        </tr>
		    `;
		    const $report11Rows = $('#report11 tbody tr');
		    if (rowIndex >= $report11Rows.length) {
		        $('#report11 tbody').append(newRow);
		    } else {
		        $report11Rows.eq(rowIndex-1).after(newRow);
		    }
		
		    verificationTest();
		}

		function addVerification2(rowIndex) {
			const newScenarioNumber = calculateNextScenarioNumber();
		    const html = `
		        <p style="font-size: 15px; padding-top: 25px;">
		            <input class="borderDotted scenarioNumber" type="text" value="1.3.`+newScenarioNumber+`. 해당 사항 없음">
		        </p>
		        <div>
		            <table class="report8" style="width: 100%; border-collapse: collapse; border: 1px solid black;">
		                <tr>
		                    <th class="tableTd tableCenter">
		                        <input class="inputCenter borderDotted" type="text" value="요구사항">
		                    </th>
		                    <th class="tableTd tableCenter">
		                        <input class="borderDotted" type="text" value="1. 해당사항 없음">
		                    </th>
		                </tr>
		                <tr>
		                    <td class="tableTd tableCenter width15p" style="width: 15%;">
		                        <input class="inputCenter borderDotted" type="text" value="테스트 절차">
		                    </td>
		                    <td class="tableTd width15p" style="width: 85%; min-height: 50px;">
		                        <textarea class="borderDotted scenarioTextarea" oninput="autoResize(this)" style="resize:none;">해당사항 없음</textarea>
		                    </td>
		                </tr>
		            </table>
		        </div>
		    `;
			
		    const $scenarioContainer = $('#scenario').parent();
		    const $report8Tables = $scenarioContainer.find('table.report8');
			
		    if (rowIndex >= $report8Tables.length) {
		        $scenarioContainer.append(html);
		    } else {
		        const $targetDiv = $report8Tables.eq(rowIndex-1).closest('div');
		        $targetDiv.after(html);
		    }
			updateScenarioNumbers();
		
		    // textarea 자동 리사이즈
		    const $newTable = $(html).find('table.report8');  // 새로 추가된 테이블 선택
    		$newTable.find('textarea.autoResize').on('input', function () {
    		    this.style.height = 'auto';  // 높이 자동 설정
    		    this.style.height = this.scrollHeight + 'px';  // 텍스트 길이에 맞게 높이 설정
    		});
		
		    // report7 테이블 행 추가
		    const newRow = `
		        <tr>
		            <td class="tableTd tableCenter width15p"><input class="inputCenter borderDotted" type="text" value=""></td>
		            <td class="tableTd tableCenter width70p"><input class="inputCenter borderDotted" type="text" value=""></td>
		            <td class="tableTd tableCenter width15p"><input class="inputCenter borderDotted" type="text" value=""></td>
		        </tr>
		    `;
		    const $report7Rows = $('#report7 tbody tr');
		    if (rowIndex >= $report7Rows.length) {
		        $('#report7 tbody').append(newRow);
		    } else {
		        $report7Rows.eq(rowIndex-1).after(newRow);
		    }
		
		    verificationTest();
		}

		function calculateNextScenarioNumber() {
		    // 현재까지 존재하는 시나리오 번호들 추출
		    const $scenarioInputs = $('#scenario').parent().find('input.scenarioNumber');
		    const existingNumbers = [];

		    $scenarioInputs.each(function() {
		        const val = $(this).val();
		        const match = val.match(/^1\.3\.(\d+)\./);
		        if (match) {
		            existingNumbers.push(parseInt(match[1], 10)); // 번호만 추출하여 배열에 저장
		        }
		    });
		
		    // 새로운 번호는 기존 번호 중 최대값 + 1
		    let newNumber = 1;
		    if (existingNumbers.length > 0) {
		        newNumber = Math.max(...existingNumbers) + 1;
		    }
		
		    return newNumber;
		}

		function updateScenarioNumbers() {
		    // 모든 시나리오 번호 순차적으로 갱신
		    const $scenarioInputs = $('#scenario').parent().find('input.scenarioNumber');
			console.log($scenarioInputs);
		    let number = 2; // 번호를 1부터 시작
		    $scenarioInputs.each(function() {
		        const value = $(this).val();
		        const updatedValue = value.replace(/^1\.3\.\d+\./, `1.3.`+number+`.`);
		        $(this).val(updatedValue);
		        number++; // 번호 순차적으로 증가
		    });
		}

		function addCommVerification(rowIndex) {
		    const $targetTable = $("#report9");
		    const $rows = $targetTable.find("tr");
		    const $targetRow = $rows.eq(rowIndex);

		    // 위쪽부터 rowspan 조정
		    for (let i = rowIndex; i >= 0; i--) {
		        $rows.eq(i).find("td[rowspan], th[rowspan]").each(function () {
		            let $rCell = $(this);
		            let rSpan = parseInt($rCell.attr("rowspan")) || 1;
		            let rIndex = $rows.index($rCell.closest("tr"));
				
		            if (rIndex + rSpan - 1 >= rowIndex) {
		                $rCell.attr("rowspan", rSpan + 1);
		                i = -1;
		                return false;
		            }
		        });
		    }
		
		    // 새 행 생성
		    let $newRow = $("<tr></tr>");
		    let $cells = $targetRow.children("td, th");
		    $cells.each(function (index) {
		        let $cell = $(this);
		        let rSpan = parseInt($cell.attr("rowspan")) || 1;
			
		        if (rSpan > 1) return;
			
		        let $newCell = $cell.clone();
			
		        $newCell.find("input, textarea").val("");
		        if ($newCell.children().length === 0) $newCell.text("");
			
		        // 마지막 셀이라면 "O" 입력
		        if (index === $cells.length - 1) {
		            if ($newCell.find("input").length > 0) {
		                $newCell.find("input").val("○");
		            } else if ($newCell.find("textarea").length > 0) {
		                $newCell.find("textarea").val("○");
		            } else {
		                $newCell.text("○");
		            }
		        }
			
		        $newRow.append($newCell);
		    });
		
		    $targetRow.after($newRow);
			commVerification();
		}

		
		function addCommVerification2(rowIndex) {
			const $targetTable = $("#report6");
		    const $rows = $targetTable.find("tr");
		    const $targetRow = $rows.eq(rowIndex);
				
		    // 위쪽부터 rowspan 조정
		    for (let i = rowIndex; i >= 0; i--) {
		        $rows.eq(i).find("td[rowspan], th[rowspan]").each(function () {
		            let $rCell = $(this);
		            let rSpan = parseInt($rCell.attr("rowspan")) || 1;
		            let rIndex = $rows.index($rCell.closest("tr"));
				
		            if (rIndex + rSpan - 1 >= rowIndex) {
		                $rCell.attr("rowspan", rSpan + 1);
		                i = -1; // 반복 종료
		                return false;
		            }
		        });
		    }
		
		    // 새 행 생성
		    let $newRow = $("<tr></tr>");
		    $targetRow.children("td, th").each(function () {
		        let $cell = $(this);
		        let rSpan = parseInt($cell.attr("rowspan")) || 1;
			
		        if (rSpan > 1) return; // rowspan 셀은 skip
			
		        let $newCell = $cell.clone();
			
		        $newCell.find("input, textarea").val(""); // 입력 초기화
		        if ($newCell.children().length === 0) $newCell.text(""); // 텍스트 초기화
			
		        $newRow.append($newCell);
		    });
		
		    $targetRow.after($newRow);
			commVerification();
		}


		function verificationTest() {
		    const EXCLUDE_CELL_INDEX = -1; // -1이면 마지막 열을 자동 계산
		    let isSyncing = false; // 동기화 상태 추적 변수

		    // 입력 이벤트 바인딩: #report7 ➝ #report11
		    $('#report7 tbody input').off('input').on('input', function () {
		        if (isSyncing) return; // 동기화 중이면 처리하지 않음
			
		        const $td = $(this).closest('td');
		        const rowIndex = $(this).closest('tr').index();
		        const cellIndex = $td.index();
			
		        const totalCells = $td.closest('tr').find('td').length;
		        const excludeIndex = EXCLUDE_CELL_INDEX === -1 ? totalCells - 1 : EXCLUDE_CELL_INDEX;
			
		        if (cellIndex !== excludeIndex) {
		            isSyncing = true; // 동기화 시작
		            // 비동기적으로 동기화
		            setTimeout(() => {
		                $('#report11 tbody tr').eq(rowIndex).find('td').eq(cellIndex).find('input').val($(this).val());
		                isSyncing = false; // 동기화 끝
		            }, 0);
		        }

			        // verificationTest2 호출
			        verificationTest2(rowIndex);
			    });
			
			// 입력 이벤트 바인딩: #report11 ➝ #report7
			$('#report11 tbody input').off('input').on('input', function () {
			    if (isSyncing) return; // 동기화 중이면 처리하지 않음
			
			    const $td = $(this).closest('td');
			    const rowIndex = $(this).closest('tr').index();
			    const cellIndex = $td.index();
			
			    const totalCells = $td.closest('tr').find('td').length;
			    const excludeIndex = EXCLUDE_CELL_INDEX === -1 ? totalCells - 1 : EXCLUDE_CELL_INDEX;
			
			    if (cellIndex !== excludeIndex) {
			        isSyncing = true; // 동기화 시작
			        // 비동기적으로 동기화
			        setTimeout(() => {
			            $('#report7 tbody tr').eq(rowIndex).find('td').eq(cellIndex).find('input').val($(this).val());
			            isSyncing = false; // 동기화 끝
			        }, 0);
			    }
			
			    // verificationTest2 호출
			    verificationTest2(rowIndex);
			});
		}

		function commVerification() {
			const EXCLUDE_CELL_INDEX = -1;
    		let isSyncing = false;

    		// report6 ➝ report9
    		$('#report6 input, #report6 textarea').off('input').on('input', function () {
    		    if (isSyncing) return;
    		    const $td = $(this).closest('td');
    		    const rowIndex = $(this).closest('tr').index();
    		    const cellIndex = $td.index();
			
    		    const totalCells = $td.closest('tr').find('td').length;
    		    const excludeIndex = EXCLUDE_CELL_INDEX === -1 ? totalCells - 1 : EXCLUDE_CELL_INDEX;
			
    		    if (cellIndex !== excludeIndex) {
    		        isSyncing = true;
    		        setTimeout(() => {
    		            $('#report9 tr').eq(rowIndex).find('td').eq(cellIndex).find('input, textarea').val($(this).val());
    		            isSyncing = false;
    		        }, 0);
    		    }
    		});
		
    		// report9 ➝ report6
    		$('#report9 input, #report9 textarea').off('input').on('input', function () {
    		    if (isSyncing) return;
    		    const $td = $(this).closest('td');
    		    const rowIndex = $(this).closest('tr').index();
    		    const cellIndex = $td.index();
			
    		    const totalCells = $td.closest('tr').find('td').length;
    		    const excludeIndex = EXCLUDE_CELL_INDEX === -1 ? totalCells - 1 : EXCLUDE_CELL_INDEX;
			
    		    if (cellIndex !== excludeIndex) {
    		        isSyncing = true;
    		        setTimeout(() => {
    		            $('#report6 tr').eq(rowIndex).find('td').eq(cellIndex).find('input, textarea').val($(this).val());
    		            isSyncing = false;
    		        }, 0);
    		    }
    		});
		}

		function verificationTest2(rowIndex) {
		    const inputVal = $('#report7 tbody tr').eq(rowIndex).find('td').eq(1).find('input').val().trim();
		
		    // 아래쪽 <p>에 있는 borderDotted input 중 '1.3.'으로 시작하는 것만 필터링
		    const targetInputs = $('p input.borderDotted').filter(function () {
		        return $(this).val().trim().startsWith('1.3.');
		    });
		
		    // 해당 index에 맞는 input만 값 갱신
		    const target = targetInputs.eq(rowIndex);
		    if (target.length) {
		        const originalVal = target.val();
		        const prefixMatch = originalVal.match(/^1\.3\.\d+\.\s*/); // 예: '1.3.1. ' 패턴 추출
		        const prefix = prefixMatch ? prefixMatch[0] : '';
		        target.val(prefix + inputVal);
		    }
		}

		$(document).ready(function () {
		    verificationTest();
			commVerification();
		});

		function delCommVerification() {
			const $selectedCell = $(selectedCells[0]);
    		const $report6 = $selectedCell.closest("table");
    		const $rows6 = $report6.find("tr");

    		// 2. 선택된 셀의 행 인덱스와 열 인덱스 계산
    		const rowIndex2 = $rows6.index($selectedCell.closest("tr"));
    		const cellIndex = $selectedCell.closest("tr").children().index($selectedCell);

    		// 3. report9에서 동일한 위치의 셀 찾기
    		const $report9 = $("#report9");
    		const $rows9 = $report9.find("tr");
    		const $targetRow9 = $rows9.eq(rowIndex2);  // 동일한 행
    		const $targetCell9 = $targetRow9.children().eq(cellIndex);  // 동일한 열의 셀

			$targetCell9.addClass("selected");
			selectedCells = [$targetCell9[0]]; 

    		// 4. selectedCells[0]을 report9의 해당 셀로 변경

			const $report = $targetCell9.closest("table");
		
		    let $cell = $targetCell9;
		    let $row = $cell.closest("tr");
		    let $table = $row.closest("table");
		    let $rows = $table.find("tr");
		    let rowIndex = $rows.index($row);
		
		    let rowspan = parseInt($cell.attr("rowspan")) || 1;
		    let deleteCount = rowspan;
		
		    let $rowsToDelete = $rows.slice(rowIndex, rowIndex + deleteCount);
		
		    // 셀 복사 후 아래 행으로 이관 (rowspan, colspan 모두)
		    $rowsToDelete.each(function (rIdx, tr) {
		        let $tr = $(tr);
		        $tr.children("td, th").each(function () {
		            let $cell = $(this);
		            let rowspan = parseInt($cell.attr("rowspan")) || 1;
		            let colspan = parseInt($cell.attr("colspan")) || 1;
		            let cellIndex = $cell.index();
				
		            if (rowspan > 1) {
		                let $targetRow = $rows.eq(rowIndex + 1); // 다음 행
					
		                if ($targetRow.length) {
		                    let $clone = $cell.clone().removeAttr("rowspan");
		                    $cell.remove();
						
		                    // 다음 행의 적절한 위치에 삽입
		                    let $nextCells = $targetRow.children("td, th");
		                    if (cellIndex >= $nextCells.length) {
		                        $targetRow.append($clone);
		                    } else {
		                        $nextCells.eq(cellIndex).before($clone);
		                    }
						
		                    // 남은 rowspan 조정
		                    $clone.attr("rowspan", rowspan - 1);
		                }
		            } else {
		                $cell.remove(); // rowspan 아닌 경우는 그냥 삭제
		            }
		        });
		    });
		
		    // 다른 셀의 rowspan 보정 (삭제 영역 포함된 셀)
		    $rows.each(function (i, tr) {
		        $(tr).children("td[rowspan], th[rowspan]").each(function () {
		            let $rCell = $(this);
		            let span = parseInt($rCell.attr("rowspan")) || 1;
		            let rIndex = $rows.index(tr);
		            let rEnd = rIndex + span - 1;
				
		            if (rIndex < rowIndex && rEnd >= rowIndex) {
		                let overlap = Math.min(rEnd, rowIndex + deleteCount - 1) - rowIndex + 1;
		                $rCell.attr("rowspan", span - overlap);
		            }
		        });
		    });
		
		    $rowsToDelete.remove();
		    selectedCells = [];
		    clearSelection();
		}

		function delCommVerification2() {
			const $selectedCell = $(selectedCells[0]);
    		const $report9 = $selectedCell.closest("table");
    		const $rows9 = $report9.find("tr");

    		// 2. 선택된 셀의 행 인덱스와 열 인덱스 계산
    		const rowIndex2 = $rows9.index($selectedCell.closest("tr"));
    		const cellIndex = $selectedCell.closest("tr").children().index($selectedCell);

    		// 3. report6에서 동일한 위치의 셀 찾기
    		const $report6 = $("#report6");
    		const $rows6 = $report6.find("tr");
    		const $targetRow6 = $rows6.eq(rowIndex2);  // 동일한 행
    		const $targetCell6 = $targetRow6.children().eq(cellIndex);  // 동일한 열의 셀

			$targetCell6.addClass("selected");
			selectedCells = [$targetCell6[0]]; 

    		// 4. selectedCells[0]을 report6의 해당 셀로 변경

			const $report = $targetCell6.closest("table");
		
		    let $cell = $targetCell6;
		    let $row = $cell.closest("tr");
		    let $table = $row.closest("table");
		    let $rows = $table.find("tr");
		    let rowIndex = $rows.index($row);
		
		    let rowspan = parseInt($cell.attr("rowspan")) || 1;
		    let deleteCount = rowspan;
		
		    let $rowsToDelete = $rows.slice(rowIndex, rowIndex + deleteCount);
		
		    // 셀 복사 후 아래 행으로 이관 (rowspan, colspan 모두)
		    $rowsToDelete.each(function (rIdx, tr) {
		        let $tr = $(tr);
		        $tr.children("td, th").each(function () {
		            let $cell = $(this);
		            let rowspan = parseInt($cell.attr("rowspan")) || 1;
		            let colspan = parseInt($cell.attr("colspan")) || 1;
		            let cellIndex = $cell.index();
				
		            if (rowspan > 1) {
		                let $targetRow = $rows.eq(rowIndex + 1); // 다음 행
					
		                if ($targetRow.length) {
		                    let $clone = $cell.clone().removeAttr("rowspan");
		                    $cell.remove();
						
		                    // 다음 행의 적절한 위치에 삽입
		                    let $nextCells = $targetRow.children("td, th");
		                    if (cellIndex >= $nextCells.length) {
		                        $targetRow.append($clone);
		                    } else {
		                        $nextCells.eq(cellIndex).before($clone);
		                    }
						
		                    // 남은 rowspan 조정
		                    $clone.attr("rowspan", rowspan - 1);
		                }
		            } else {
		                $cell.remove(); // rowspan 아닌 경우는 그냥 삭제
		            }
		        });
		    });
		
		    // 다른 셀의 rowspan 보정 (삭제 영역 포함된 셀)
		    $rows.each(function (i, tr) {
		        $(tr).children("td[rowspan], th[rowspan]").each(function () {
		            let $rCell = $(this);
		            let span = parseInt($rCell.attr("rowspan")) || 1;
		            let rIndex = $rows.index(tr);
		            let rEnd = rIndex + span - 1;
				
		            if (rIndex < rowIndex && rEnd >= rowIndex) {
		                let overlap = Math.min(rEnd, rowIndex + deleteCount - 1) - rowIndex + 1;
		                $rCell.attr("rowspan", span - overlap);
		            }
		        });
		    });
		
		    $rowsToDelete.remove();
		    selectedCells = [];
		    clearSelection();
		}

		function delVerification(rowIndex) {
			rowIndex = rowIndex - 1;
		    const $container = $('#scenario').parent();

		    // 1. 선택된 행의 index에 해당하는 시나리오 삭제
		    const $report8Tables = $container.find('table.report8');
		    if ($report8Tables.length > rowIndex) {
		        const targetTable = $report8Tables.eq(rowIndex);
		        const report8Wrapper = targetTable.closest('div'); // 해당 테이블을 감싸는 div
			
		        // 해당 div와 그 이전의 <p> 요소 삭제
		        report8Wrapper.prev('p').remove();
		        report8Wrapper.remove();
		    }
		
		    // 2. report11 테이블에서 선택된 행 삭제
		    const $report11Rows = $('#report11 tbody tr');
		    if ($report11Rows.length > rowIndex) {
		        $report11Rows.eq(rowIndex).remove();  // 해당 rowIndex의 tr 삭제
		    }
		
		    // 3. 입력 동기화 다시 바인딩
		    verificationTest();
			commVerification();
		}

		function delVerification2(rowIndex) {
			rowIndex = rowIndex - 1;
		    const $container = $('#scenario').parent();

		    // 1. 선택된 행의 index에 해당하는 시나리오 삭제
		    const $report11Tables = $container.find('table.report11');
		    if ($report11Tables.length > rowIndex) {
		        const targetTable = $report11Tables.eq(rowIndex);
		        const report11Wrapper = targetTable.closest('div'); // 해당 테이블을 감싸는 div
			
		        // 해당 div와 그 이전의 <p> 요소 삭제
		        report11Wrapper.prev('p').remove();
		        report11Wrapper.remove();
		    }
		
		    // 2. report8 테이블에서 선택된 행 삭제
		    const $report8Rows = $('#report8 tbody tr');
		    if ($report8Rows.length > rowIndex) {
		        $report8Rows.eq(rowIndex).remove();  // 해당 rowIndex의 tr 삭제
		    }
		
		    // 3. 입력 동기화 다시 바인딩
		    verificationTest();
			commVerification();
		}

		/* =========== Ctrl + S 사용시 저장 ========= */
		document.onkeydown = function(e) {
		    if (e.which == 17)  isCtrl = true;
		    if (e.which == 83 && isCtrl == true) {  // Ctrl + s
		    	resultsReportSave();
		    	isCtrl = false;
		    	return false;
		    }
		}

		function resultsReportSave() {
			$("#selectNone").click();
			var resultsReportCustomerName = $("#resultsReportCustomerName").val();
			var resultsReportNumber = $("#resultsReportNumber").val();
			var resultsReportClient = $("#resultsReportClient").val();
			var resultsReportVerifier = $("#resultsReportVerifier").val();
			var resultsReportReviewer = $("#resultsReportReviewer").val();
			var resultsReportDate = $("#resultsReportDate").val();
			var resultsReportTestDate = $("#resultsReportTestDate").val();
			var resultsReportContent = domupdate();
			if(resultsReportNumber == "") {
				Swal.fire({
					icon: 'error',
					title: '실패!',
					text: '문서 번호 필수 입력 바랍니다.',
				});
			} else {
				$.ajax({
					url: "<c:url value='/resultsReport/resultsReportCopy'/>",
			        type: 'post',
			        data: {
						"resultsReportNumber" : resultsReportNumber,
						"resultsReportCustomerName" : resultsReportCustomerName,
						"resultsReportClient" : resultsReportClient,
						"resultsReportVerifier" : resultsReportVerifier,
						"resultsReportReviewer" : resultsReportReviewer,
						"resultsReportContent" : resultsReportContent,
						"resultsReportDate" : resultsReportDate,
						"resultsReportTestDate" : resultsReportTestDate
					},
			        async: false,
			        success: function(result2) {
			        	if(result2.result == "OK") {
			        		Swal.fire({
								  title: '저장 완료!',
								  text: "결과 보고서를 PDF로 출력하시겠습니까?",
								  icon: 'success',
								  showCancelButton: true,
								  confirmButtonColor: '#7066e0',
								  cancelButtonColor: '#FF99AB',
								  confirmButtonText: '출력',
								  cancelButtonText: '저장',
							}).then((result) => {
								if (result.isConfirmed) {
									// location.href="<c:url value='/resultsReport/list'/>";
									$('#BtnPDFexport').click();  // 클릭 이벤트 트리거
								} else {
									location.href="<c:url value='/resultsReport/updateView'/>?resultsReportNumber="+result2.resultsReportNumber;
								}
							})
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
		}

		function domupdate() {
			var cloned = $('.writeDiv').clone();

			// input, textarea, select 요소의 현재 값을 속성에 반영
			cloned.find('input, textarea, select').each(function() {
			    var $el = $(this);
			
			    if ($el.is('input')) {
			        var type = $el.attr('type');
			        if (type === 'checkbox' || type === 'radio') {
			            if ($el.prop('checked')) {
			                $el.attr('checked', 'checked');
			            } else {
			                $el.removeAttr('checked');
			            }
			        } else {
			            $el.attr('value', $el.val());
			        }
			    } else if ($el.is('textarea')) {
			        $el.text($el.val()); // 텍스트 영역은 내부 텍스트로 값 반영
			    } else if ($el.is('select')) {
			        $el.find('option').each(function() {
			            if ($(this).prop('selected')) {
			                $(this).attr('selected', 'selected');
			            } else {
			                $(this).removeAttr('selected');
			            }
			        });
			    }
			});

			var resultsReportContent = cloned.html();
			return resultsReportContent;
		}

		function domupPDFdate() {
		  	// 1. .writeDiv 복제
			  var cloned = $('.writeDiv').clone();

			// 2. input, select, textarea 값 반영
			cloned.find('input, select, textarea').each(function () {
			  var $el = $(this);
			
			  if ($el.is('input')) {
				var type = $el.attr('type');
				if (type === 'checkbox' || type === 'radio') {
				  if ($el.prop('checked')) {
					$el.attr('checked', 'checked');
				  } else {
					$el.removeAttr('checked');
				  }
				} else {
				  $el.attr('value', $el.val());
				}
			  } else if ($el.is('select')) {
				$el.find('option').each(function () {
				  if ($(this).prop('selected')) {
					$(this).attr('selected', 'selected');
				  } else {
					$(this).removeAttr('selected');
				  }
				});
			  } else if ($el.is('textarea')) {
				if ($el.hasClass('scenarioTextarea')) {
				  // 👉 scenarioTextarea만 <div>로 변환
				  var content = $el.val()
					.replace(/</g, "&lt;")
					.replace(/>/g, "&gt;")
					.replace(/\n/g, "<br/>");
				
				  var style = $el.attr('style') || '';
				  style = style.replace(/height\s*:\s*[^;]+;?/gi, ''); // 기존 height 제거
				  style += ' min-height:50px; text-align:left; white-space:pre-wrap;';
				
				  var div = $('<div></div>')
					.addClass($el.attr('class'))
					.attr('style', style)
					.html(content);
				
				  $el.replaceWith(div);
				} else {
				  // ✅ 그 외 textarea는 값만 반영
				  $el.text($el.val());
				}
			  }
			});

			// 3. 최종 HTML 반환
			return cloned.html();
		}

	</script>

	<style>
		.pageBreak {
			border-bottom: 1px dotted gray;
			margin-top: 40px;
			margin-bottom: 40px;
		}

		.borderDotted {
			/* border: 1px dotted #bababa !important; */
			width: 100%;
		}

		.myBtn {
			padding: 5px 5px;
		}

		table td.selected {
			background: #afdcff70 !important;
		}

		input:not([disabled]) {
			background: none !important;
		}
	</style>

	<style id="pdfStyle">
		.middleTitle {
			margin-top: 30px;
		}

		.table1 {
			border: 1px solid black;
			width: 200px;
			padding: 5px;
			
		}

		.table2 {
			border: 1px solid black;
			width: 400px;
			padding: 5px;
		}

		.tableTd {
			border: 1px solid black;
			padding: 5px;
		}

		.tableCenter {
			text-align: center;
		}

		.pageBreak {
			page-break-before: always;
		}

		#BtnPDFexport {
			text-align: -webkit-right;
    		float: left;
    		border-radius: 0 !important;
    		font-size: 15px;
    		color: #ff1500;
    		border: 1px solid #ff0000;
			padding: 5px 7px;
		}

		#BtnPDFexport:hover {
			color: white;
			background: #4451ff;
			border: 1px solid blue;
		}

		.writeDiv {
			width: 100%;
		    height: 100%;
		    background: white;
		    min-height: 700px;
		    padding: 2%;
		}

		.title1 {
			color: red;
    		border: 10px double red;
    		padding: 10px;
    		width: 170px;
    		text-align: center;
    		float: right;
			font-size: 16px;
			font-weight: bolder;
			margin-top: 10px;
			margin-right: 10px;
		}

		.title2 {
			width: 100%;
    		text-align: center;
    		font-size: 50px;
    		font-weight: bolder;
    		color: #7F7F7F;
    		font-style: italic !important;
		}

		.title3 {
			width: 100%;
    		text-align: center;
    		font-size: 50px;
    		margin-top: 25px;
    		color: #7F7F7F;
		}
		
		.title4 {
			font-size: 25px;
			color: black;
			text-align: center;
		}

		.title5 {
			font-size: 25px;
    		color: black;
    		margin-top: 15px;
			text-align: center;
		}

		.title6 {
			font-size: 35px;
    		color: black;
		}

		.title7 {
			font-size: 20px;
    		font-weight: bold;
    		color: black;
			margin-bottom: 10px;
			text-align: center;
		}

		.title8 {
			font-size: 22px;
    		font-weight: bold;
    		margin-bottom: 20px;
		}

		.titleScope1 {
			text-align: -webkit-right;
    		width: 100%;
    		height: 130px;
		}

		.titleScope3 {
			margin-top: 200px;
			text-align: center;
		}

		.titleScope4 {
			margin-top: 250px;
			text-align: center;
		}

		.titleScope5 {
			text-align: -webkit-center;
		}

		input {
			border: none;
		}

		textarea {
			border: none;
			background-color: transparent;
		}

		.inputCenter {
			text-align: center;
		}

		.textareaDouble  {
			height: 50px;
			resize: none;
			border-radius: 50px;
		}

		input {
			width: 100%
		}

		.width10p {
			width: 10%;
		}

		.width20p {
			width: 20%;
		}

		.width15p {
			width: 15%;
		}

		.width65p {
			width: 65%;
		}

		.width35p {
			width: 35%;
		}

		.width25p {
			width: 25%;
		}

		.width70p {
			width: 70%;
		}

		.width60p {
			width: 60%;
		}
	</style>
</html>