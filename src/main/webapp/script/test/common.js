// 파일 크기(숫자)를 문자열 처리
function getFileSizeText(size) {
    let sizeUnitText = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    let sizeUnitPos = Math.floor(Math.log(size) / Math.log(1024));
    return (size / Math.pow(1024, sizeUnitPos)).toFixed(2) + sizeUnitText[sizeUnitPos];
}

// 파일 리스트에 파일 아이템 추가
function addFileItem(fileListID, fileItemNo, fileName, fileSize) {
    // 다운로드 파일 프로그레스
    var fileHtml = "<div class=\"fileItem_" + fileItemNo + "\">"
        + "<div class=\"fileInfo\">"
            + "<span class=\"fileName\">" + fileName + "</span>"
            + "<span class=\"fileSize\">" + getFileSizeText(fileSize) + "</span>"
        + "</div>"
        + "<div class=\"uploadProgress\"><div class=\"uploadBar\"></div></div>"
        + "</div>";
    // 파일 리스트에 추가
    $("#" + fileListID).append(fileHtml);
}

// 프로그레스 바 위치 변경
function setProgressPos(fileItemNo, percent) {
    let bar = $(".fileItem_" + fileItemNo).find(".uploadProgress > .uploadBar");
    bar.width(percent + "%");
    bar.text(percent.toFixed(2) + "%");
}