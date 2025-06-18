//20120324 jqGrid 컬럼 순서, 보이기속성을 저장/불러오기 기능 추가
//20120417 default 버튼을 기본기능으로 추가
//20120726 doExportExec() 추가
//20120816 setAutoResize() 추가
//20121017 moveUpRow, moveDownRow 추가


	// 전체 row 개수
	function getRowCount(gridName)
	{
		return $(gridName).getDataIDs().length;
	}

	// 선택된 아이템들을 복사한다
	// return: 복사한 아이템 수
	function copySelectedRows(gridName1, gridName2, limitCount)
	{
		var jqGrid1 = $(gridName1);
		var jqGrid2 = $(gridName2);

		var selRows = jqGrid1.getGridParam('selarrrow');

		// 선택 된 row 갯수와 list2의 row 갯수의 합이 limitCount 를 넘지 않을경우에만
		var totalCount = selRows.length + jqGrid2.getDataIDs().length;
		//console.log(totalCount);
		if ( totalCount > limitCount ) {
			alert(limitCount + "개 까지만 등록 가능합니다");
			return selRows.length;
		}

		if ( selRows.length > 0 )
		{
			$.each(selRows, function(i, rowid) {
				var rowData1 = jqGrid1.getRowData(rowid);
				var rowData2 = jqGrid2.getRowData(rowid);

				// list2 에 rowid 에 해당하는 row 가 존재하지 않을 경우에만 데이터 추가
				if ( jQuery.isEmptyObject(rowData2) ) {
					jqGrid2.addRowData(rowid, rowData1);
				}
			});
		}

		return selRows.length;
	}

	// 선택된 아이템들을 삭제한다
	// return: 삭제한 아이템 수
	function deleteSelectedRows(gridName)
	{
		var jqGrid = $(gridName);

		var selRows = jqGrid.getGridParam('selarrrow');
		if ( selRows.length > 0 )
		{
			selRows = selRows.slice(0); // copy by value
			$.each(selRows, function(i, rowid) {
				jqGrid.delRowData(rowid);
			});
		}

		return selRows.length;
	}

	function reloadGridData(gridName, postData)
	{
		var jqGrid = $(gridName);

		jqGrid.clearGridData();
		jqGrid.setGridParam({ postData: postData });
		jqGrid.trigger("reloadGrid");
	}

	// 선택된 줄을 한 줄 위로 이동
	function moveUpRow(gridName)
	{
		var jqGrid = $(gridName);

		var selRows = jqGrid.getGridParam('selarrrow');
		// 단일 아이템만 기능 지원
		if ( selRows.length != 1 ){
			return selRows.length;
		}

		var rowid = selRows[0];
		var idx = jqGrid.getInd(rowid) - 1;
		if ( idx == 0 )
			return ; // 첫번째 아이템 무시

		var totalRowids = jqGrid.getDataIDs();
		var beforeRowid = totalRowids[idx-1];
		//var afterRowid = totalRowids[idx+1];

		var rowData = jqGrid.getRowData(rowid);
		jqGrid.delRowData(rowid);
		jqGrid.addRowData(rowid, rowData, 'before', beforeRowid);
		//jqGrid.resetSelection();
		jqGrid.setSelection(rowid);
	}

	// 선택된 줄을 한 줄 아래로 이동
	function moveDownRow(gridName)
	{
		var jqGrid = $(gridName);

		var selRows = jqGrid.getGridParam('selarrrow');
		if ( selRows.length != 1 ){
			return selRows.length;
		}

		var rowid = selRows[0];
		var idx = jqGrid.getInd(rowid) - 1;
		var totalRowids = jqGrid.getDataIDs();
		if ( idx == totalRowids.length-1 )
			return ; // 마지막 아이템 무시

		//var beforeRowid = totalRowids[idx-1];
		var afterRowid = totalRowids[idx+1];

		var rowData = jqGrid.getRowData(rowid);
		jqGrid.delRowData(rowid);
		jqGrid.addRowData(rowid, rowData, 'after', afterRowid);
		//jqGrid.resetSelection();
		jqGrid.setSelection(rowid);
	}

	//------------------------------------------------------------------------
	//20120815 YANG jQuery.smartresize 추가
	//
	//http://paulirish.com/2009/throttled-smartresize-jquery-event-handler/
	//
	//$(window).bind('resize', function 을 그대로 쓰면 IE8 에서 hang 이 발생한다.
	//jQuery (1.8.0) 에서 자동으로 처리해주면 좋을것을...
	//
	(function($, sr) {

		// debouncing function from John Hann
		// http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
		var debounce = function(func, threshold, execAsap) {
			var timeout = null;

			return function debounced() {
				var obj = this, args = arguments;
				function delayed() {
					if (!execAsap)
						func.apply(obj, args);
					timeout = null;
				}
				;

				if (timeout)
					clearTimeout(timeout);
				else if (execAsap)
					func.apply(obj, args);

				timeout = setTimeout(delayed, threshold || 100);
			};
		};

		// smartresize
		jQuery.fn[sr] = function(fn) {
			return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr);
		};

	})(jQuery, 'smartresize');
	//------------------------------------------------------------------------

	// jqGrid 의 폭을 윈도우 최대 크기로 자동 크기조절되도록 설정
	function setAutoWidth()
	{
		$(".ui-jqgrid").css("width", "100%");
		$(".ui-jqgrid-view").css("width", "100%");
		$(".ui-jqgrid-hdiv").css("width", "100%");
		$(".ui-jqgrid-bdiv").css("width", "100%");
	}

	// 브라우저 윈도우 크기에 따라 자동 크기조절
	//
	// 문제점. 엘리먼트의 크기에 따라 자동 반응하는 구조가 아니기 때문에 창 크기 기준의 offset 이 필요하며
	// 또한, 창이 문서보다 작아졌을 때 문서는 작아지지 않지만 그리드는 작아지는 문제가 있다.
	function setAutoResize(gridName, offsetx, offsety)
	{
		//alert($.browser.msie + ", " + $.browser.version);
		// 20130418: IE 10버전 구분하기 위해서 문자열 비교 대신 float 로 형변환해서 비교
		if ( $.browser.msie && parseFloat($.browser.version) < '9.0' ) {
			__setAutoResizeIE7(gridName, offsetx, offsety);
		} else {
			__setAutoResizeIE9(gridName, offsetx, offsety);
		}
	}

	function __setAutoResizeIE9(gridName, offsetx, offsety)
	{
		$(window).bind('resize', function() {
			if (offsetx !== undefined ) {
				var width = $(window).width()-offsetx;
				$(gridName).setGridWidth(width);
			}

			if (offsety !== undefined ) {
				var height = $(window).height()-offsety;
				$(gridName).setGridHeight(height);
			}
		}).trigger('resize');
	}

	function __setAutoResizeIE7(gridName, offsetx, offsety)
	{
		if ( offsetx !== undefined ) {
			offsetx = offsetx - 18;
		}

		// IE 7 호환성 문제
		$(window).smartresize(function(){
			if ( offsetx !== undefined ) {
				var width = $(window).width()-offsetx;
				$(gridName).setGridWidth(width);
			}

			if (offsety !== undefined ) {
				var height = $(window).height()-offsety;
				$(gridName).setGridHeight(height);
			}
		}).trigger('resize');
	}

	// jqGrid 엑셀파일 다운로드 공통코드
	// jquery.fileDownload.js 파일 필요
	//
	// gridName: '#list'
	// formName: '#form'
	// url: 'ExportExec'
	function doExportExec(formName, gridName, url)
	{
		if ( formName === undefined ) {
			formName = "#form";
		}

		if ( gridName === undefined ) {
			gridName = "#list";
		}
		if ( url === undefined ) {
			url = "export";
		}

		var jqGrid = $(gridName);

		// 1. 화면에 보이는 컬럼 순서와 헤더정보 가져오기
		var sidx = jqGrid.getGridParam("sortname"); // 정렬컬럼
		var sord = jqGrid.getGridParam("sortorder"); // 정렬방향
		var colModel = jqGrid.getGridParam("colModel"); // 컬럼순서
		var colNames = jqGrid.getGridParam("colNames"); // 헤더정보

		var columns = [];
		var headers = [];
		for(var i=1; i < colModel.length; i++)
		{
			// 숨겨진 컬럼을 제외하고 순서데로 저장
			var item = colModel[i];
			if (item.hidedlg || item.hidden)
				continue;

			columns.push(item.name);
			headers.push(colNames[i]);
		}

		// 2. 파일 다운로드에 필요한 formData 구성
		var formData = $(formName).serializeObject();

		formData.sidx = sidx; // 정렬컬럼
		formData.sord = sord; // 정렬방향
		formData.columns = columns.join(','); // 컬럼순서
		formData.headers = headers.join(','); // 헤더정보
		

		// 3. 완성된 formData 로 파일 다운로드 요청
		$.fileDownload(
				url,
				{httpMethod: "POST", data: formData}
		);
	}

	// 컬럼 선택 (컬럼선택 후 컬럼정보를 쿠키에 저장한다.)
	//
	function selectColumns(gridId, viewId) {
		$(gridId).setColumns({
			afterSubmitForm: function() {
				saveColumns(gridId, viewId);
			},
			onDefault: function() {
				defaultColumns(gridId, viewId);
			}
		});
	}

	// 현재 컬럼정보 저장
	//
	// 데이터 형식: [{컬럼명, 보이기옵션}, ...]
	// 예: [{name: 'serverName', hidden: false},{name: 'ip', hidden: false},...]
	function saveColumns(gridId, viewId) {
		var jqGrid = $(gridId);
		var cookieId = viewId + ".saveColumns";
		//console.log("saveColumns: gridId:"+gridId + ", cookieId:" + cookieId);

		// 현재 컬럼상태를 저장한다. "이름/상태"
		var colModel = jqGrid.getGridParam("colModel");
		var saveColumns = [];
		$.each(colModel, function(i, col) {
			saveColumns.push({
				name: col.name,
				hidden: col.hidden
				//width: col.width
			});
		});

		saveCookie(cookieId, saveColumns);
	}

	// 저장된 컬럼정보 불러오기
	//
	function loadColumns(gridId, viewId) {
		var jqGrid = $(gridId);
		var cookieId = viewId + ".saveColumns";

		var saveColumns = loadCookie(cookieId);
		if ( saveColumns == null ) {
			return; // skip
		}

		// 저장된 컬럼속성의 hidden 속성에 따라서 컬럼 show/hide 결정
		//console.log("loadColumns: gridId:"+gridId + ", cookieId:" + cookieId);
		var colModel = jqGrid.getGridParam("colModel");
		$.each(saveColumns, function(i, value) {
			if ( value.hidden ) {
				jqGrid.hideCol(value.name);
			} else {
				jqGrid.showCol(value.name);
			}
		});

		// 저장된 컬럼속성의 컬럼순서로 현재의 컬럼순서를 remap 한다.
		// 현재 컬럼순서를 맵으로 변환한다.
		var colMap = {};
		$.each(colModel, function(i, col) {
			colMap[col.name] = i;
		});

		// 저장된 컬럼들을 읽어와서 새로운 컬럼순서 perm 를 만든다.
		// 저장된 컬럼들과 현재 뷰의 컬럼들이 서로 다를경우는 컬럼순서 복원에 사용하지 않고 에러처리한다.
		var perm = [];
		$.each(saveColumns, function(i, value) {
			if ( value.name in colMap ) {
				var idx = colMap[value.name];
				perm.push(idx);
			}
		});

		if ( colModel.length != perm.length ) {
			// 현재 컬럼개수와 저장된 컬럼개수가 다르다면 지난 정보는 삭제처리
			//console.log("ERROR: Invalid saveColumns length : " + saveColumns.length);
			//console.log(saveColumns);
			deleteCookie(cookieId);
		} else {
			// 쿠키에 저장된 컬럼순서로 jqGrid를 컬럼순서 재배치 한다.
			//console.log("remapColumns: " + perm);
			jqGrid.remapColumns(perm, true, false);
		}
	}

	// 컬럼 설정을 기본값으로 되돌린다
	// 쿠키에 저장된 설정값을 모두 초기화 하고, 화면을 reload
	function defaultColumns(gridId, viewId)
	{
		var cookieId = viewId + ".saveColumns";

		deleteCookie(cookieId);
		window.location.reload(true);
	}

	// 쿠키에 값 저장
	function saveCookie(id, obj)
	{
		var json = $.toJSON(obj);
		//console.log(json);
		$.cookie(id, json, {expires: 365, path: '/'});
		// expire: 365; 365일 동안
		// expire: null; 세션 중단 시

		// 사용자가 저장한 컬럼보기옵션 정보를 로컬 디스크에 쿠키로 저장
		// ==> 서버의 사용자별 환경설정에 저장하는 방법도 있다.
	}

	// 쿠기에 값 읽어오기
	//function loadCookie(id)
	//{
	//	var json = $.cookie(id);
		//console.log(json);
	//	return $.evalJSON(json);
	//}
	
	function loadCookie(id) {
	    var json = $.cookie(id);
	
	    if (json && json !== "undefined") {
	        try {
	            return $.evalJSON(json);
	        } catch (e) {
	            console.error("Invalid JSON in cookie '" + id + "':", json);
	            return null; // or default value
	        }
	    }
	
	    return null; // or {} or default value
	}

	// 쿠기에 저장된 값 삭제
	function deleteCookie(id)
	{
		$.cookie(id, null, {expires: -1, path: '/'});
	}
