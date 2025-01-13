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
            <form:form modelAttribute="categoryForm" autocomplete="off">
                <form:hidden path="categoryID" />
                <input type="hidden" id="mode" value="${mode}" />
                <table class="editForm">
                    <colgroup>
                        <col style="width:25%">
                        <col style="width:auto">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row">카테고리 명</th>
                            <td>
                                <form:input path="category" placeholder="카테고리 명을 입력하세요." required="required" class="form-input" />
                                <div class="invalid-feedback">카테고리 명을 입력하세요.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">업로드 임시 파일 경로</th>
                            <td>
                                <form:input path="upTempFilePath" placeholder="업로드 임시 파일 경로를 입력하세요." required="required" class="form-input" />
                                <div class="invalid-feedback">업로드 임시 파일 경로를 입력하세요.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">업로드 파일 경로</th>
                            <td>
                                <form:input path="upFilePath" placeholder="업로드 파일 경로를 입력하세요." required="required" class="form-input" />
                                <div class="invalid-feedback">업로드 파일 경로를 입력하세요.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">업로드 청크 크기</th>
                            <td>
                                <form:input path="upChunkSize" type="number" min="1024" max="1048576" placeholder="업로드 청크 크기를 입력하세요." required="required" class="form-input" />
                                <div class="invalid-feedback">다운로드 청크 크기는 최소 1024(1KB), 최대 1048576(1MB)이내로 입력하세요.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">업로드 전송 암호화</th>
                            <td>
                                <form:select path="upUseCrypto" required="required">
                                    <form:option value="0" label="Blob" />
                                    <form:option value="1" label="Base64 + 검증 + 압축" />
                                    <form:option value="2" label="Base64 + 암호화 + 검증" />
                                </form:select>
                                <div class="invalid-feedback">업로드 전송 암호화는 0:Blob 전송, 1:Base64 + 검증 + 압축 전송, 2:Base64 + 암호화 + 검증 전송만 지원합니다.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">다운로드 임시 파일 경로</th>
                            <td>
                                <form:input path="downTempFilePath" placeholder="다운로드 임시 파일 경로를 입력하세요." required="required" class="form-input" />
                                <div class="invalid-feedback">다운로드 임시 파일 경로를 입력하세요.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">다운로드 청크 크기</th>
                            <td>
                                <form:input path="downChunkSize" type="number" min="1024" max="1048576" placeholder="다운로드 청크 크기를 입력하세요." required="required" class="form-input" />
                                <div class="invalid-feedback">다운로드 청크 크기는 최소 1024(1KB), 최대 1048576(1MB)이내로 입력하세요.</div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">다운로드 전송 암호화</th>
                            <td>
                                <form:select path="downUseCrypto" required="required" class="form-input">
                                    <form:option value="0" label="Base64" />
                                </form:select>
                                <div class="invalid-feedback">다운로드 전송 암호화는 0:Base64 전송만 지원합니다.</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form:form>
            <div class="buttons">
                <div class="right">
                    <button id="saveBtn" class="button blue">
                        <c:choose>
                            <c:when test="${mode == 'add'}">등록</c:when>
                            <c:when test="${mode == 'edit'}">수정</c:when>
                        </c:choose>
                    </button>
                    <button id="cancelBtn" class="button">취소</button>
                </div>
            </div>
		</div>
		<script src="/scripts/test/category/form.js"></script>
		<spring:hasBindErrors name="categoryForm">
        	<script type="text/javascript">
        		$('#categoryForm').addClass('was-validated');
        		$(function($, window) {
        			<c:forEach var="error" items="${errors.fieldErrors}">
        				setTimeout(function() {
        					$('#${error.field}').addClass("is-invalid");
        					$('#${error.field}').on("change", function(event) {
        						if ($(this).hasClass("is-invalid") && $(event.target).is(':valid')) {
        							$(this).removeClass("is-invalid");
        						}
        					});
        				}, 0);
        			</c:forEach>
        		});
        	</script>
        </spring:hasBindErrors>
    </body>
</html>