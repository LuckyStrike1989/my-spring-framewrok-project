<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>대용량 파일 업로드</title>
        <link rel="stylesheet" type="text/css" href="/css/common.css">
        <link rel="stylesheet" type="text/css" href="/css/transmission.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    </head>
    <body>
        <p>대용량 파일 전송 개발을 위한 프로토타입 버전입니다.</p>
        <p>1. 대용량 파일 업로드 - Blob - 문서 파일</p>
        <div id="uploadPanel1" class="uploadPanel"></div>
        <p>2. 대용량 파일 업로드 - Base64 (SHA256) + GZip - 이미지 파일</p>
        <div id="uploadPanel2" class="uploadPanel"></div>
        <p>3. 대용량 파일 업로드 - Base64 + RSA + AES (SHA256) - 동영상 파일</p>
        <div id="uploadPanel3" class="uploadPanel"></div>
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lz-string/1.4.4/lz-string.min.js"></script>
    <!--
    <script src="/scripts/lzstring/lz-string-1.4.4.js"></script>
    -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pako/2.1.0/pako.min.js"></script>
    <script src="/scripts/transmission/upload.js"></script>
    <script src="/scripts/test/upload.js"></script>
</html>