$(function () {
    const uploadFileSearch = $('#uploadFileSearch');
    $('#searchBtn').click(function() {
        $(this).attr("disabled", "disabled");
        uploadFileSearch.submit();
    });
    $('#searchKeyword').keypress(function(event){
        if (13 == event.which) {
            $('#searchBtn').click();
            return false;
        }
    });
    $('select[name="pagination.recordCountPerPage"]').change(function(event) {
        uploadFileSearch.submit();
    });
    $('#boardPagination .page-link').click(function(event) {
        event.preventDefault();
        event.stopPropagation();
        const pageLastNo = uploadFileSearch.find('input:hidden[name="pagination.pageLastNo"]').val();
        const pageNo = uploadFileSearch.find('input:hidden[name="pagination.pageNo"]').val();
        const moveToPageNo = $(this).attr("data-pageno");
        if ((pageNo == moveToPageNo) || (pageNo == 1 && moveToPageNo == 1) || (pageNo == pageLastNo && moveToPageNo == pageLastNo)) {
            return;
        }
        if (moveToPageNo > 0 && moveToPageNo <= pageLastNo) {
            uploadFileSearch.find('input:hidden[name="pagination.pageNo"]').val(moveToPageNo);
            uploadFileSearch.submit();
        }
    });
    $('select[name="category"]').change(function(event) {
        uploadFileSearch.find('input:hidden[name="pagination.pageLastNo"]').val(1);
        uploadFileSearch.find('input:hidden[name="pagination.pageNo"]').val(1);
        uploadFileSearch.submit();
    });

    const download1 = new Transmission_Download();

    // category
    const category = $('#uploadFileSearch select[name="category"] option:selected').val();
    download1.category = category;

    // 다운로드 진행 프로그레스 (CallBack)
    function downloadProgress(fileID, percent) {
        const downloadProgress = $(".fileItem_" + fileID + " .downloadProgress");
        let percentWidth = "0";
        let percentText = "";
        if (percent > 0) {
            percentWidth = percent.toFixed(2);
            percentText = percent.toFixed(2) + "%";
        }
        downloadProgress.find(".downloadBar").width(percentWidth + "%");
        downloadProgress.find(".downloadPercent").text(percentText);
    }
    download1.onDownloadProgress = downloadProgress;

    // 다운로드 완료 (CallBack)
    function downloadDone(fileID) {
        let downloadPlayBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadPause");
        if (downloadPlayBtn.length > 0) {
            downloadPlayBtn.addClass('btn-success downloadPlay');
            downloadPlayBtn.html('다운로드');
            downloadPlayBtn.removeClass('btn-warning downloadPause');
        } else {
            downloadPlayBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadPlay");
            downloadPlayBtn.html('다운로드');
        }

        const downloadStopBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadStop");
        downloadStopBtn.addClass('hidden');

        $(".fileItem_" + fileID).css("grid-template-columns", "auto 90px");
    }
    download1.onDownloadDone = downloadDone;

    // 다운로드 시작
    $('.downloadButtons').on('click', '.downloadPlay', function(event) {
        event.stopPropagation();
        event.stopImmediatePropagation();
        const fileID = $(this).data('value');
        download1.downloadStart(fileID);

        const downloadPlayBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadPlay");
        downloadPlayBtn.addClass('btn-warning downloadPause');
        downloadPlayBtn.html('중지');
        downloadPlayBtn.removeClass('btn-success downloadPlay');

        const downloadStopBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadStop");
        downloadStopBtn.addClass('hidden');

        $(".fileItem_" + fileID).css("grid-template-columns", "auto 65px");
    });

    // 다운로드 중지
    $('.downloadButtons').on('click', '.downloadPause', function(event) {
        event.stopPropagation();
        event.stopImmediatePropagation();
        const fileID = $(this).data('value');
        download1.downloadPause(fileID);

        const downloadPlayBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadPause");
        downloadPlayBtn.addClass('btn-success downloadPlay');
        downloadPlayBtn.html('이어받기');
        downloadPlayBtn.removeClass('btn-warning downloadPause');

        const downloadStopBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadStop");
        downloadStopBtn.removeClass('hidden');

        $(".fileItem_" + fileID).css("grid-template-columns", "auto 150px");
    });

    // 다운로드 취소
    $('.downloadButtons').on('click', '.downloadStop', function(event) {
        event.stopPropagation();
        event.stopImmediatePropagation();
        const fileID = $(this).data('value');
        download1.downloadStop(fileID);

        const downloadPlayBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadPlay");
        downloadPlayBtn.html('다운로드');

        const downloadStopBtn = $(".fileItem_" + fileID + " > .downloadButtons > .downloadStop");
        downloadStopBtn.addClass('hidden');

        $(".fileItem_" + fileID).css("grid-template-columns", "auto 90px");
    });
});
