<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
    <head>
        <title>카테고리 등록</title>
        <link rel="stylesheet" type="text/css" href="/css/common.css">
        <link rel="stylesheet" type="text/css" href="/css/category.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="basicLayout">
            <form id="gotoForm" method="POST">
                <input type="hidden" name="searchType" value="${gotoForm.searchType}">
                <input type="hidden" name="searchCondition" value="${gotoForm.searchCondition}">
                <input type="hidden" name="searchKeyword" value="${gotoForm.searchKeyword}">
                <input type="hidden" name="pageNo" value="${gotoForm.pageNo}">
                <input type="hidden" name="recordCountPerPage" value="${gotoForm.recordCountPerPage}">
            </form>
            <form id="categoryView" method="POST">
                <input type="hidden" name="categoryID" value="${categoryItem.categoryID}" />
                <input type="hidden" name="searchType" value="${gotoForm.searchType}">
                <input type="hidden" name="searchCondition" value="${gotoForm.searchCondition}">
                <input type="hidden" name="searchKeyword" value="${gotoForm.searchKeyword}">
                <input type="hidden" name="pageNo" value="${gotoForm.pageNo}">
                <input type="hidden" name="recordCountPerPage" value="${gotoForm.recordCountPerPage}">
            </form>
            <table class="editForm">
                <colgroup>
                    <col style="width:25%">
                    <col style="width:auto">
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">카테고리 명</th>
                        <td>${categoryItem.category}</td>
                    </tr>
                    <tr>
                        <th scope="row">업로드 임시 파일 경로</th>
                        <td>${categoryItem.upTempFilePath}</td>
                    </tr>
                    <tr>
                        <th scope="row">업로드 파일 경로</th>
                        <td>${categoryItem.upFilePath}</td>
                    </tr>
                    <tr>
                        <th scope="row">업로드 청크 크기</th>
                        <td>${categoryItem.upChunkSize}</td>
                    </tr>
                    <tr>
                        <th scope="row">업로드 전송 암호화</th>
                        <td>${categoryItem.upUseCrypto}</td>
                    </tr>
                    <tr>
                        <th scope="row">다운로드 임시 파일 경로</th>
                        <td>${categoryItem.downTempFilePath}</td>
                    </tr>
                    <tr>
                        <th scope="row">다운로드 청크 크기</th>
                        <td>${categoryItem.downChunkSize}</td>
                    </tr>
                    <tr>
                        <th scope="row">다운로드 전송 암호화</th>
                        <td>${categoryItem.downUseCrypto}</td>
                    </tr>
                </tbody>
            </table>
            <div class="buttons">
                <div class="left">
                    <button id="editBtn" class="button">수정</button>
                    <button id="deleteBtn" class="button">삭제</button>
                </div>
                <div class="right">
                    <button id="listBtn" class="button">목록</button>
                </div>
            </div>
		</div>
		<script src="/scripts/test/category/view.js"></script>
    </body>
</html>