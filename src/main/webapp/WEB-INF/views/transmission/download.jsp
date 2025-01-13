<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>대용량 파일 다운로드</title>
        <link rel="stylesheet" type="text/css" href="/css/transmission.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    </head>
    <body>
        <p>대용량 파일 다운로드</p>
        <button class="downloadBtn">다운로드</button>
        <div id="fileList1" class="file_list" style="width:400px; height:100px;"></div>
    </body>
    <script src="/scripts/test/common.js"></script>
    <script src="/scripts/test/download.js"></script>
</html>