// 업로드
const Transmission_Upload = function() {
    // 업로드 가능한 파일 수 (기본값 3)
    this.maxUploadFileCount = 3;
    // 업로드 가능한 파일 크기 (기본값 100MB)
    this.maxUploadFileSizeText = "100MB";
    // 업로드 가능한 전체 파일 크기 (기본값 1GB)
    this.maxUploadFileAllSizeText = "1GB";
    // 업로드 가능한 파일 타입
    this.fileTypes = [];
    // 카테고리
    this.category = "";
    // 업로드 파일 일련번호
    this.uploadFileOrder = 1;
    // 업로드 파일 리스트
    this.uploadFileList = [];
    // Form 아이디
    this.formID = "";
    // 초기화
    this.init = function(uploadPanelID) {
        this.formID = "UPLOAD_FORM_" + uploadPanelID;
        let uploadFormHtml = "<div>"
            + "<form id=\"" + this.formID + "\">"
                + "<input type=\"file\" name=\"files\" multiple>"
            + "</form>"
            + "<div class=\"file_list\"></div>"
            + "</div>";
        $("#" + uploadPanelID).append(uploadFormHtml);

        // 이벤트 처리
        const me = this;
        // 파일 선택 이벤트
        $("#" + this.formID + " > input[name=files]").change(function(event) {
            me.selectedFile(event);
        });
        // 시작 버튼 클릭 이벤트
        $("#" + this.formID).next().on('click', '.uploadPlay', function(event) {
            event.stopPropagation();
            event.stopImmediatePropagation();
            const fileOrder = $(this).data('value');
            const uploadFileItem = me.uploadFileList.find(function(item, index) {
                return item.fileOrder == fileOrder;
            });
            if (uploadFileItem.state == 0) {
                uploadFileItem.state = 1;
            } else if (uploadFileItem.state == 4) {
                uploadFileItem.state = 3;
            }
            $(this).addClass('btn-warning uploadPause');
            $(this).html('중지');
            $(this).removeClass('btn-success uploadPlay');
            $(this).parent().find('.uploadRemove').addClass('hidden');
            setTimeout(function() {
                me.uploadLoop();
            }, 100);
        });
        // 중지 버튼 클릭 이벤트
        $("#" + this.formID).next().on('click', '.uploadPause', function(event) {
            event.stopPropagation();
            event.stopImmediatePropagation();
            const fileOrder = $(this).data('value');
            const uploadFileItem = me.uploadFileList.find(function(item, index) {
                return item.fileOrder == fileOrder;
            });
            uploadFileItem.state = 4;
            $(this).addClass('btn-success uploadPlay');
            $(this).html('시작');
            $(this).removeClass('btn-warning uploadPause');
            $(this).parent().find('.uploadRemove').removeClass('hidden');
        });
        // 삭제 버튼 클릭 이벤트
        $("#" + this.formID).next().on('click', '.uploadRemove', function(event) {
            event.stopPropagation();
            event.stopImmediatePropagation();
            const result = confirm("업로드 파일을 삭제하시겠습니까?");
            if (result) {
                const fileOrder = $(this).data('value');
                const uploadFileItem = me.uploadFileList.find(function(item, index) {
                    return item.fileOrder == fileOrder;
                });
                if (uploadFileItem != undefined) {
                    uploadFileItem.state = 8;
                }
                $(me.formID + "_fileItem_" + fileOrder).remove();
                setTimeout(function() {
                    me.uploadLoop();
                }, 100);
            }
        });
    }
    // FORM에 있는 파일 입력 태그 초기화
    this.initFormInput = function() {
        $("#" + this.formID).find("input[name=files]").val("");
        const newFormInput = $("#" + this.formID).find("input[name=files]").clone(true);
        $("#" + this.formID).find("input[name=files]").replaceWith(newFormInput);

        $("#" + this.formID).next().children().remove();
    }
    // 파일 크기 문자열을 숫자로 변환
    this.getFileSize = function(sizeText) {
        let result = -1;
        const sizeUnitText = ["BYTES", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
        const regx = /^([0-9]+)(BYTES|KB|MB|GB|TB|PB|EB|ZB|YB)$/;
        sizeText = sizeText.toUpperCase();
        if (regx.test(sizeText)) {
            const match = sizeText.match(regx);
            const sizeUnitPos = sizeUnitText.indexOf(match[2]);
            result = parseInt(match[1]) * Math.pow(1024, sizeUnitPos);
        }
        return result;
    }
    // 파일 크기 숫자를 문자열로 변환
    this.getFileSizeText = function(size) {
        let sizeUnitText = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
        let sizeUnitPos = Math.floor(Math.log(size) / Math.log(1024));
        return (size / Math.pow(1024, sizeUnitPos)).toFixed(2) + sizeUnitText[sizeUnitPos];
    }
    // 파일 선택
    this.selectedFile = function(event) {
        event.preventDefault();
        const files = event.target.files ? event.target.files : event.originalEvent.dataTransfer.files;
        if (files.length == 0) {
            return false;
        } else if (files.length > this.maxUploadFileCount) {
            alert("업로드할 파일은 최대 " + this.maxUploadFileCount + "개까지만 가능합니다.\n" + this.maxUploadFileCount + "개이하로 파일을 선택해주세요.");
            this.initFormInput();
            return false;
        }

        // 업로드 파일 타입 및 크기 체크
        var maxUploadFileSize = this.getFileSize(this.maxUploadFileSizeText);
        var maxUploadFileAllSize = this.getFileSize(this.maxUploadFileAllSizeText);
        for (let index = 0; index < files.length; index++) {
            const file = files[index];
            let addYN = true;
            const fileExt = file.name.split(".").pop().toLowerCase();
            if ($.inArray(fileExt, this.fileTypes) == -1) { // 파일 포맷 확인
                addYN = false;
                alert(file.name + "은 업로드 할 수 없는 파일 포맷입니다.\n업로드에서 제외됩니다.");
            } else if (maxUploadFileSize > 0 && file.size > maxUploadFileSize) { // 파일 용량 확인
                addYN = false;
                alert(file.name + "의 파일 크기(" + this.getFileSizeText(file.size) + ")가 업로드 할 수 있는 최대 파일 크기(" + this.maxUploadFileSizeText + ") 보다 큽니다.\n업로드에서 제외됩니다.");
            }

            if (addYN) {
                uploadFileItem = {
                    'fileOrder' : this.uploadFileOrder++, // 업로드 파일 일련번호
                    'state' : 0, // 업로드 상태 (0:준비, 1:대기, 2:체크, 3:진행, 4:중지, 5:완료, 8:삭제, 9:에러)
                    'stateMessage' : '', // 업로드 상태 메시지
                    'file' : file, // 업로드 파일
                    'fileID' : '', // 업로드 파일 ID
                    'chunkSize' : (1024 * 100), // 청크 크기 - 기본값 100KB
                    'chunkCount' : 0, // 청크 수
                    'chunkPos' : 0 // 청크 위치
                };
                this.uploadFileList.push(uploadFileItem);
            }
        }

        if (this.uploadFileList.length == 0) {
            this.initFormInput();
            return false;
        }

        for (let index = 0; index < this.uploadFileList.length; index++) {
            const uploadFileItem = this.uploadFileList[index];
            if (uploadFileItem.state == 0) {
                uploadFileItem.state = 1;
                let uploadFileHtml = "<div class=\"" + this.formID + "_fileItem_" + uploadFileItem.fileOrder + "\">"
                    + "<div class=\"fileInfo\">"
                        + "<span class=\"fileName\">" + uploadFileItem.file.name + "</span>"
                        + "<span class=\"fileSize\">" + this.getFileSizeText(uploadFileItem.file.size) + "</span>"
                    + "</div>"
                    + "<div class=\"uploadProgress\"><div class=\"uploadBar\"></div></div>"
                    + "<div class=\"uploadButtons\">"
                        + "<button type=\"button\" class=\"btn btn-success btn-sm uploadPlay\" data-value=\"" + uploadFileItem.fileOrder + "\">시작</button>"
                        + "<button type=\"button\" class=\"btn btn-danger btn-sm uploadRemove\" data-value=\"" + uploadFileItem.fileOrder + "\">삭제</button>"
                    + "</div>"
                + "</div>";
                $("#" + this.formID).next().append(uploadFileHtml);
            }
        }
    }
    // 업로드 루프
    this.uploadLoop = function() {
        let complete = true;
        let completeCount = 0;
        for (let index = 0; index < this.uploadFileList.length; index++) {
            const uploadFileItem = this.uploadFileList[index];
            if (uploadFileItem.state == 1) {
                const resultData = this.uploadFileCheck(uploadFileItem);
                if (resultData.result == "success") {
                    uploadFileItem.state = 2;
                    uploadFileItem.fileID = resultData.fileID;
                    uploadFileItem.chunkSize = resultData.chunkSize;
                    uploadFileItem.chunkCount = resultData.chunkCount;
                    uploadFileItem.chunkPos = resultData.chunkPos;
                    uploadFileItem.publicKey = resultData.publicKey;
                    uploadFileItem.useCrypto = resultData.useCrypto;

                    var process = true;
                    // 이전에 업로드된 위치가 있으면 처리
                    if (uploadFileItem.chunkPos > 0) {
                        let result = true;
                        if (uploadFileItem.state == 2) {
                            result = confirm("동일한 파일 이름으로 업로드 중 중지된 파일입니다.\n이어서 업로드 할까요?\n취소하면 다시 처음부터 업로드 합니다.");
                        }
                        if (result) {
                            this.uploadProgressPos(uploadFileItem);
                        } else {
                            const resultDeleteData = this.uploadFileDelete(uploadFileItem);
                            if (resultDeleteData.result == "success") {
                                const resultNewData = this.uploadFileCheck(uploadFileItem);
                                if (resultNewData.result == "success") {
                                    uploadFileItem.fileID = resultNewData.fileID;
                                    uploadFileItem.chunkSize = resultNewData.chunkSize;
                                    uploadFileItem.chunkCount = resultData.chunkCount;
                                    uploadFileItem.chunkPos = resultNewData.chunkPos;
                                    uploadFileItem.publicKey = resultData.publicKey;
                                    uploadFileItem.useCrypto = resultData.useCrypto;
                                } else {
                                    process = false;
                                    alert(resultNewData.errorMessage);
                                }
                            }
                        }
                    }
                    uploadFileItem.state = 3;

                    if (process) {
                        this.uploadFileProcess(uploadFileItem);
                    }
                } else {
                    uploadFileItem.state = 9;
                    uploadFileItem.stateMessage = resultData.errorMessage;
                    this.uploadState(uploadFileItem);
                }
            } else if (uploadFileItem.state == 3) {
               this.uploadFileProcess(uploadFileItem);
            } else if (uploadFileItem.state == 5) {
                completeCount++;
            } else if (uploadFileItem.state == 8) {
                // 삭제 처리
                if (uploadFileItem.fileID != "") {
                    var resultData = this.uploadFileDelete(uploadFileItem);
                    if (resultData.result == "success") {
                        this.uploadFileList.splice(index, 1);
                        index++;
                    }
                } else {
                    this.uploadFileList.splice(index, 1);
                    index++;
                }
            }

            if (uploadFileItem.state <= 4) {
                // 완료 체크
                complete = false;
            }
        }

        // 폼 초기화
        if (this.uploadFileList.length == 0) {
            this.initFormInput();
        }

        // 완료 처리
        if (complete && this.uploadFileList.length > 0) {
            // 업로드 파일 리스트 초기화
            this.uploadFileList.length = 0;
            this.uploadFileList = [];
            if (completeCount > 0) {
                this.initFormInput();
                alert(completeCount + "개 파일이 업로드를 완료 했습니다.");
            }
        }
    }
    // 업로드 파일 체크
    this.uploadFileCheck = function(uploadFileItem) {
        const formData = new FormData();
        formData.append("category", this.category);
        formData.append("fileName", uploadFileItem.file.name);
        formData.append("fileSize", uploadFileItem.file.size);

        let resultData = {};
        $.ajax({
            url: '/repository/uploadCheck',
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
    // 업로드 파일 삭제
    this.uploadFileDelete = function(uploadFileItem) {
        const formData = new FormData();
        formData.append("fileID", uploadFileItem.fileID);

        let resultData = {};
        $.ajax({
            url: '/repository/uploadDelete',
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
    // 업로드 진행 프로그레스 바 위치
    this.uploadProgressPos = function(uploadFileItem) {
        const percentComplete = uploadFileItem.chunkPos / uploadFileItem.chunkCount;
        percent = percentComplete * 100;

        let barPos = $("." + this.formID + "_fileItem_" + uploadFileItem.fileOrder).find(".uploadProgress > .uploadBar");
        barPos.width(percent.toFixed(2) + "%");
        barPos.text(percent.toFixed(2) + "%");
    }
    // 업로드 진행
    // 파일을 청크 크기로 잘라서 업로드 (청크 수 만큼 재귀 호출)
    this.uploadFileProcess = async function(uploadFileItem) {
        if (uploadFileItem.state != 3) {
            const me = this;
            setTimeout(function() {
                me.uploadLoop();
            }, 100);
            return;
        }

        // 업로드 파일 시작 위치 (Byte)
        const startPos = uploadFileItem.chunkPos * uploadFileItem.chunkSize;
        // 업로드 파일 종료 위치 (Byte)
        const endPos = Math.min(uploadFileItem.file.size, startPos + uploadFileItem.chunkSize);
        // 청크 데이터
        let chunkData = uploadFileItem.file.slice(startPos, endPos);
        // 무결성 검증 해시 코드
        let verificationCode = "";

        // Base64
        if (uploadFileItem.useCrypto >= 1) {
            try {
                const base64String = await this.convertToBase64(chunkData);
                chunkData = base64String;
            } catch (error) {
                uploadFileItem.state = 9;
                uploadFileItem.stateMessage = error.message;
                const me = this;
                me.uploadState(uploadFileItem);
                setTimeout(function() {
                    me.uploadLoop();
                }, 100);
                return;
            }

            // 1일 때만 압축 테스트
            if (uploadFileItem.useCrypto == 1) {
                // pako로 압축
                const compressed = pako.gzip(chunkData, { to: 'string' });
                //console.log(compressed);
                //const compressed2 = pako.ungzip(compressed, { to: 'string' });
                //console.log(compressed2);

                // LZString로 압축
                //const compressed = LZString.compress(chunkData);

                // 압축된 데이터를 Base64로 인코딩
                const compressedData = window.btoa(String.fromCharCode.apply(null, compressed));
                //console.log(compressedData);
                console.log(chunkData.length, compressedData.length);

                chunkData = compressedData;
            }
        }

        // Base64 + RSA + AES
        if (uploadFileItem.useCrypto == 2) {
            // AES 키 생성
            // 키 랜덤 생성 (256bit, words:(8))
            const aesKey = CryptoJS.lib.WordArray.random(32);
            //console.log("aesKey", aesKey.toString(CryptoJS.enc.Hex));
            // IV 랜덤 생성 (128bit, words:(4))
            const aesIv = CryptoJS.lib.WordArray.random(16);
            //console.log("aesIv", aesIv.toString(CryptoJS.enc.Hex));

            // AES 암호화
            const encrypted = CryptoJS.AES.encrypt(chunkData, aesKey, {
                   iv: aesIv,
                   mode: CryptoJS.mode.CBC,
                   keySize: 256 / 32,
                   padding: CryptoJS.pad.Pkcs7
               });
            const encryptData = encrypted.toString();
            //console.log(encryptData);

            // AES 키 암호화
            const encryptedAESKey = await this.encryptAESKeyWithRSA(aesKey, uploadFileItem.publicKey);
            //console.log(encryptedAESKey);

            const encryptedAESIv = this.encodeIvToBase64(aesIv);
            //console.log(encryptedAESIv);

            chunkData = encryptedAESKey + "<<split>>" + encryptedAESIv +  "<<split>>" + encryptData;
        }

        // 무결성 검증
        if (uploadFileItem.useCrypto >= 1) {
            verificationCode = CryptoJS.SHA256(chunkData).toString();
        }

        const me = this;

        var formData = new FormData();
        formData.append("fileID", uploadFileItem.fileID);
        formData.append("chunkPos", uploadFileItem.chunkPos);
        formData.append("file", chunkData);
        formData.append("verificationCode", verificationCode);

        $.ajax({
            url: '/repository/uploadProcess',
            type: 'POST',
            enctype : "multipart/form-data",
            data: formData,
            async: false,
            contentType: false,
            processData: false,
            success: function(resData) {
                uploadFileItem.chunkPos = resData.chunkPos;
                uploadFileItem.chunkCount = resData.chunkCount;
                me.uploadProgressPos(uploadFileItem);
                if (uploadFileItem.chunkPos == uploadFileItem.chunkCount) {
                    uploadFileItem.state = 5;
                    uploadFileItem.stateMessage = "업로드 완료";
                    me.uploadState(uploadFileItem);
                    setTimeout(function() {
                        me.uploadLoop();
                    }, 100);
                } else {
                    setTimeout(function() {
                        me.uploadFileProcess(uploadFileItem);
                    }, 10);
                }
            },
            error: function(request, status, error) {
                uploadFileItem.state = 9;
                if (request.status == 400) {
                    uploadFileItem.stateMessage = request.responseJSON.errorMessage;
                } else {
                    uploadFileItem.stateMessage = "서버 오류로 인해 업로드가 중지되었습니다.";
                }
                me.uploadState(uploadFileItem);
                setTimeout(function() {
                    me.uploadLoop();
                }, 100);
            }
        });
    }
    // Blob를 Base64로 변환
    this.convertToBase64 = function(blobData) {
        return new Promise(function(resolve, reject) {
            const reader = new FileReader();
            reader.readAsDataURL(blobData);
            reader.onloadend = function () {
                if (reader.result) {
                    let base64String = reader.result;
                    // data:application/octet-stream;base64,
                    resolve(base64String.split(",")[1]);
                }
            }
            reader.onerror = () => {
                reject(new Error("Base64로 변환되지 않았습니다."));
            };
        });
    }
    // AES IV 값을 Base64로 변환
    this.encodeIvToBase64 = function(iv) {
        const ivArray = iv.words.map(word => [
            (word >> 24) & 0xff,
            (word >> 16) & 0xff,
            (word >> 8) & 0xff,
            word & 0xff,
        ]).flat();
        return btoa(String.fromCharCode(...ivArray));
    }
    // AES Key를 공개키로 암호화
    this.encryptAESKeyWithRSA = async function(aesKey, publicKey) {
        // AES Key를 ArrayBuffer로 변환
        const words = aesKey.words;
        const keyBytes = [];
        for (let index = 0; index < words.length; index++) {
            const word = words[index];
            keyBytes.push((word >> 24) & 0xff);
            keyBytes.push((word >> 16) & 0xff);
            keyBytes.push((word >> 8) & 0xff);
            keyBytes.push(word & 0xff);
        }
        const arrayBufferAESKey = new Uint8Array(keyBytes).buffer;
        //console.log(arrayBufferAESKey);

        // PEM 인코딩 퍼블 키
        //const pemHeader = "-----BEGIN PUBLIC KEY-----";
        //const pemFooter = "-----END PUBLIC KEY-----";
        //publicKey = publicKey.substring(pemHeader.length, publicKey.length - pemFooter.length);
        //publicKey = publicKey.replaceAll("\\n", "");

        // RSA 공개키를 ArrayBuffer로 변환
        const binaryPublicKey = window.atob(publicKey);
        const arrayPublicKey = new Uint8Array(binaryPublicKey.length);
        for (let index = 0; index < binaryPublicKey.length; index++) {
            arrayPublicKey[index] = binaryPublicKey.charCodeAt(index);
        }
        const arrayBufferPublicKey = arrayPublicKey.buffer;
        //console.log(arrayBufferPublicKey);

        // CryptoKey 개체 가져오기 - https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/importKey
        // window.crypto.subtle.importKey를 이용하여 CryptoKey 개체를 가져온다.
        // format : 가져올 키의 형식 - spki(SubjectPublicKeyInfo) - RSA 공개키 형식
        // keyData : 가져올 키 데이터 - ArrayBuffer (plaintext, ArrayBuffer, TypedArray) - RSA 공개키 ArrayBuffer
        // algorithm : 사용할 알고리즘 - RsaHashedImportParams (name: 사용할 알고리즘 - RSA-OAEP, hash: 사용할 다이제스트 함수의 이름 - SHA-256)
        // extractable : 키 추출 여부 - true
        // keyUsages : 키를 사용할 작업 - encrypt(암호화)
        const RSAPublicKey = await window.crypto.subtle.importKey(
            "spki",
            arrayBufferPublicKey,
            {
                name: "RSA-OAEP",
                hash: { name: "SHA-256" }
            },
            true,
            ["encrypt"]
        );

        // 암호화 - https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/encrypt
        // window.crypto.subtle.encrypt를 이용하여 암호화 한다.
        // algorithm : 사용할 알고리즘 - RSA-OAEP(RsaOaepParams)
        // key : 암호화에 사용할 키 - CryptoKey 개체
        // data : 암호화할 데이터 - ArrayBuffer (plaintext, ArrayBuffer, TypedArray)
        const encryptedAESKey = await window.crypto.subtle.encrypt(
            {
                name: "RSA-OAEP"
            },
            RSAPublicKey,
            arrayBufferAESKey
        );
        //
        return window.btoa(String.fromCharCode(...new Uint8Array(encryptedAESKey)));
    }
    // 업로드 진행 오류
    this.uploadState = function(uploadFileItem) {
        const fileItem = $("." + this.formID + "_fileItem_" + uploadFileItem.fileOrder)
        fileItem.find(".uploadButtons").remove();
        if (uploadFileItem.state == 5) {
            fileItem.append("<div class=\"message\">" + uploadFileItem.stateMessage + "</div>");
        } else if (uploadFileItem.state == 9) {
            fileItem.addClass("fileError");
            fileItem.append("<div class=\"errorMessage\">" + uploadFileItem.stateMessage + "</div>");
        }
    }
}

/*
    // 한글 테스트
    const test = "한글";
    var test2 = window.btoa(unescape(encodeURIComponent(test)));
    console.log(test2);
    var test3 = decodeURIComponent(escape(window.atob(test2)));
    console.log(test3);
*/
