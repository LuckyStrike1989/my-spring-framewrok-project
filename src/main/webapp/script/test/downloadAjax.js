// 다운로드 파일 번호
let downloadFileOrder = 0;

// 대용량 파일 다운로드 - ajax
async function download() {
    // 콘텐츠 크기
    let contentLength = 0;
    // 최대 청크 크기
    let chunkSize = 0;
    // 다운로드 받을 파일의 이름
    let fileName = "";
    $.ajax({
        url: '/repository/download',
        type: 'HEAD',
        enctype : "application/x-www-form-urlencoded",
        async: false,
        contentType: false,
        processData: false,
        success: function(resData, status, xhr) {
            contentLength = xhr.getResponseHeader('X-Content-Length');
            console.log("다운로드 파일 크기: " + contentLength + "bytes");
            chunkSize = parseInt(xhr.getResponseHeader("X-Max-Chunk-Size"), 10);
            console.log("최대 청크 크기: " + chunkSize + "bytes");
            const contentDisposition =  xhr.getResponseHeader("content-disposition");
            const dispositions = contentDisposition.split(';');
            fileName = dispositions[1].split('=')[1];
            fileName = fileName.replaceAll("\"", "");
            console.log("파일 명: " + fileName);
        },
        error: function(request, status, error) {
            console.log(error);
            return;
        }
    });

    downloadFileOrder++;
    // 다운로드 파일 프로그레스
    addFileItem("fileList1", downloadFileOrder, fileName, contentLength);

    // Blob 배열
    const blobData = [];
    // 시작 바이트 위치
    let startIndex = 0;
    while (startIndex < contentLength) {
        // 종료 바이트 위치
        const endIndex = Math.min(startIndex + chunkSize - 1, contentLength - 1);
        console.log("다운로드 바이트 범위: ", startIndex, endIndex);

        // HTTP 범위 요청으로 데이터를 받아옵니다.
        var resData = await partialDownload(startIndex, endIndex);
        if (resData.result == "success") {
            blobData.push(resData.data);
        } else {
            console.log(resData.error);
        }

        // 다운로드 진햏률
        let percentComplete = endIndex / contentLength;
        percentComplete = percentComplete * 100;
        setProgressPos(downloadFileOrder, percentComplete);

        startIndex = endIndex + 1;
    }

    // 다운로드 완료
    setProgressPos(downloadFileOrder, 100);
    // Blob 객체
    const blob = new Blob(blobData);
    const aTag = document.createElement('a');
    aTag.href = URL.createObjectURL(blob);
    aTag.download = fileName;
    aTag.click();
    URL.revokeObjectURL(aTag.href);

    console.log("다운로드 완료");
}

function partialDownload(startIndex, endIndex) {
    // 동기(async: false)로 할 경우에는 responseType이 설정되지 않습니다.
    // Failed to set the 'responseType' property on 'XMLHttpRequest': The response type cannot be changed for synchronous requests made from a document.
    // 그래서 비동기식 ajax를 Promise로 처리합니다.
    return new Promise(function(resolve, reject) {
        // HTTP 범위 요청으로 데이터를 받아옵니다.
        $.ajax({
            url: '/repository/download',
            type: 'GET',
            async: true,
            enctype : "application/x-www-form-urlencoded",
            contentType: false,
            processData: false,
            cache:false,
            xhrFields: {
                responseType: 'blob'
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Range", "bytes=" + startIndex + "-" + endIndex);
            },
            success: function(resData, status, xhr) {
                // Blob를 가져옵니다.
                //console.log(resData);
                resolve({'result': 'success', 'data': resData});
            },
            error: function(request, status, error) {
                //console.log(error);
                reject({'result': 'failure', 'error': error});
            }
        });
    });
}

$(function () {
    $('.downloadBtn').on('click', function(event) {
        event.stopPropagation();
        event.preventDefault();
        download();
    });
})