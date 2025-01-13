// 다운로드 파일 번호
let downloadFileOrder = 0;

// 대용량 파일 다운로드 - fetch
async function download() {
    // HEAD 요청으로 다운로드 정보를 받아옵니다.
    const response = await fetch("/repository/download", {
        method: "HEAD"
    });
    if (!response.ok) {
        console.error("오류 :" + response.status);
        return;
    }

    // 콘텐츠 크기
    const contentLength = parseInt(response.headers.get("X-Content-Length"), 10);
    console.log("다운로드 파일 크기: " + contentLength + "bytes");

    // 최대 청크 크기
    const chunkSize = parseInt(response.headers.get("X-Max-Chunk-Size"), 10);
    console.log("최대 청크 크기: " + chunkSize + "bytes");

    // 다운로드 받을 파일의 이름
    // attachment; filename="test.mov"
    const contentDisposition =  response.headers.get("content-disposition");
    const dispositions = contentDisposition.split(';');
    fileName = dispositions[1].split('=')[1];
    fileName = fileName.replaceAll("\"", "");
    console.log("파일 명: " + fileName);

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
        const response2 = await fetch("/repository/download", {
            method: "GET",
            headers: {
                Range: "bytes=" + startIndex + "-" + endIndex
            },
        });

        if (!response2.ok && response2.status !== 206) {
            console.error("오류 :" + response.status);
            return;
        }

        // Blob를 가져옵니다.
        const chunkData = await response2.blob();
        //console.log(chunkData);
        blobData.push(chunkData);

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

$(function () {
    $('.downloadBtn').on('click', function(event) {
        event.stopPropagation();
        event.preventDefault();
        download();
    });
})