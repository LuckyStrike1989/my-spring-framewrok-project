// 업로드
const Transmission_Download = function() {
    // 카테고리
    this.category = "";
    // 다운로드 진행 프로그레스 (CallBack)
    this.onDownloadProgress = null;
    // 다운로드 완료 (CallBack)
    this.onDownloadDone = null;
    // 다운로드 파일 리스트
    this.downloadFileList = [];
    // 다운로드 시작
    this.downloadStart = function(fileID) {
        let downloadFileItem = this.downloadFileList.find(function(item, index) {
            return item.fileID == fileID;
        });

        if (downloadFileItem == null) {
            downloadFileItem = {
                'state' : 1, // 다운로드 상태 (0:준비, 1:대기, 2:체크, 3:진행, 4:중지, 5:완료, 8:삭제, 9:에러)
                'stateMessage' : '', // 다운로드 상태 메시지
                'fileID' : fileID, // 파일 ID
                'fileName' : '', // 파일 명
                'downloadFileID' : '', // 다운로드 파일 ID
                'chunkSize' : 0, // 청크 크기
                'chunkCount' : 0, // 청크 수
                'chunkPos' : 0, // 청크 위치
                'chunkData' : [] // 청크 데이터
            };
            this.downloadFileList.push(downloadFileItem);
        } else {
            if (downloadFileItem.state == 4) {
                downloadFileItem.state = 3;
            }
        }

        const me = this;
        setTimeout(function() {
            me.downloadLoop();
        }, 100);
    }
    // 다운로드 중지
    this.downloadPause = function(fileID) {
        const downloadFileItem = this.downloadFileList.find(function(item, index) {
            return item.fileID == fileID;
        });
        if (downloadFileItem.state < 5) {
            downloadFileItem.state = 4;
        }
    }
    // 다운로드 취소
    this.downloadStop = function(fileID) {
        const downloadFileItem = this.downloadFileList.find(function(item, index) {
            return item.fileID == fileID;
        });
        if (downloadFileItem.state == 4) {
            downloadFileItem.state = 8;
            const me = this;
            setTimeout(function() {
                me.downloadLoop();
            }, 100);
        }
    }
    // 다운로드 루프
    this.downloadLoop = function() {
        for (let index = 0; index < this.downloadFileList.length; index++) {
            const downloadFileItem = this.downloadFileList[index];
            if (downloadFileItem.state == 1) {
                const resultData = this.downloadFileCheck(downloadFileItem);
                if (resultData.result == "success") {
                    downloadFileItem.state = 2;
                    downloadFileItem.downloadFileID = resultData.fileID;
                    downloadFileItem.fileName = resultData.fileName;
                    downloadFileItem.chunkSize = resultData.chunkSize;
                    downloadFileItem.chunkCount = resultData.chunkCount;
                    downloadFileItem.chunkPos = resultData.chunkPos;
                    downloadFileItem.stateMessage = resultData.message;

                    var process = true;

                    downloadFileItem.state = 3;

                    if (process) {
                        this.downloadProcess(downloadFileItem);
                    }
                 } else {
                    downloadFileItem.state = 9;
                    downloadFileItem.stateMessage = resultData.message;
                }
            } else if (downloadFileItem.state == 3) {
                this.downloadProcess(downloadFileItem);
            } else if (downloadFileItem.state == 5 || downloadFileItem.state == 8) {
                if (this.onDownloadProgress != null) {
                    this.onDownloadProgress(downloadFileItem.fileID, 0);
                }
                if (this.onDownloadDone != null) {
                    this.onDownloadDone(downloadFileItem.fileID);
                }

                this.downloadFileList.splice(index, 1);
                index++;
            }
        }
    }
    // 다운로드 파일 체크
    this.downloadFileCheck = function(downloadFileItem) {
        const formData = new FormData();
        formData.append("category", this.category);
        formData.append("fileID", downloadFileItem.fileID);

        let resultData = {};
        $.ajax({
            url: '/repository/downloadCheck',
            type: 'POST',
            enctype : "application/x-www-form-urlencoded",
            data: formData,
            dataType: 'json',
            async: false,
            contentType: false,
            processData: false,
            success: function(resData) {
                resultData = resData;
            },
            error: function(request, status, error) {
                if (request.status == 400) {
                    resultData = request.responseJSON;
                } else {
                    resultData = {'result': 'failure', 'errorCode': '500', 'errorMessage': '서버 오류로 인해 정보를 가져오지 못하였습니다.'};
                }
            }
        });

        return resultData;
    }
    // 다운로드 파일 진행
    this.downloadFileProcess = function(downloadFileItem) {
        const formData = new FormData();
        formData.append("fileID", downloadFileItem.downloadFileID);
        formData.append("chunkPos", downloadFileItem.chunkPos);

        let resultData = {};
        $.ajax({
            url: '/repository/downloadProcess',
            type: 'POST',
            enctype : "application/x-www-form-urlencoded",
            data: formData,
            dataType: 'json',
            async: false,
            contentType: false,
            processData: false,
            success: function(resData) {
                resultData = resData;
            },
            error: function(request, status, error) {
                if (request.status == 400) {
                    resultData = request.responseJSON;
                } else {
                    resultData = {'result': 'failure', 'errorCode': '500', 'errorMessage': '서버 오류로 인해 정보를 가져오지 못하였습니다.'};
                }
            }
        });

        return resultData;
    }
    // 다운로드 진행
    // 청크 데이터 다운로드 (청크 수 만큼 재귀 호출)
    this.downloadProcess = function(downloadFileItem) {
        const me = this;
        if (downloadFileItem.state != 3) {
            setTimeout(function() {
                me.downloadLoop();
            }, 100);
            return;
        }

        const resultData = this.downloadFileProcess(downloadFileItem);
        if (resultData.result == "success") {
            downloadFileItem.chunkCount = resultData.chunkCount;
            downloadFileItem.chunkPos = resultData.chunkPos;

            // Base64를 이진 데이터로 변환
            const binaryData = window.atob(resultData.chunkData);
            // 이진 데이터를 Uint8Array로 변환
            const byteArray = new Uint8Array(binaryData.length);
            for (let index = 0; index < binaryData.length; index++) {
                byteArray[index] = binaryData.charCodeAt(index);
            }
            downloadFileItem.chunkData.push(byteArray);

            this.downloadProgress(downloadFileItem);

            if (downloadFileItem.chunkPos == downloadFileItem.chunkCount) {
                downloadFileItem.state = 5;
                downloadFileItem.stateMessage = "업로드 완료";

                // 다운로드
                const blob = new Blob(downloadFileItem.chunkData);
                const aTag = document.createElement('a');
                aTag.href = URL.createObjectURL(blob);
                aTag.download = downloadFileItem.fileName;
                aTag.click();
                URL.revokeObjectURL(aTag.href);

                // 청크 데이터 삭제
                downloadFileItem.chunkData = [];

                setTimeout(function() {
                    me.downloadLoop();
                }, 100);
            } else {
                setTimeout(function() {
                    me.downloadProcess(downloadFileItem);
                }, 10);
            }
        } else {
            downloadFileItem.state = 9;
            downloadFileItem.stateMessage = resultData.message;
            setTimeout(function() {
                me.downloadLoop();
            }, 100);
        }
    }
    // 다운로드 진행 프로그레스 바 위치
    this.downloadProgress = function(downloadFileItem) {
        if (this.onDownloadProgress != null) {
            const percentComplete = downloadFileItem.chunkPos / downloadFileItem.chunkCount;
            const percent = percentComplete * 100;
            this.onDownloadProgress(downloadFileItem.fileID, percent);
        }
    }
}