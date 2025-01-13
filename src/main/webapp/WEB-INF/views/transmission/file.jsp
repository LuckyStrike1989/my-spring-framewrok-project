<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <head>
        <title>대용량 파일 리스트</title>
        <link rel="stylesheet" type="text/css" href="/css/common.css">
        <link rel="stylesheet" type="text/css" href="/css/file.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="basicLayout">
            <form:form modelAttribute="uploadFileSearch" autocomplete="off">
                <form:hidden path="pagination.pageNo" />
                <form:hidden path="pagination.pageLastNo" />
                <div>
                    카테고리 :
                    <form:select path="category">
                        <form:options items="${categoryList}" itemLabel="category" itemValue="categoryID" />
                    </form:select>
                </div>
                <div>
                    검색 조건 :
                    <form:select path="searchType">
                        <form:option value="" label="전체" />
                        <form:option value="fileName" label="파일명" />
                    </form:select>
                    <form:select path="searchCondition">
                        <form:option value="equal" label="일치" />
                        <form:option value="like" label="포함" />
                    </form:select>
                    <form:input path="searchKeyword" placeholder="검색할 키워드를 입력하세요." />
                    <button id="searchBtn" type="button">검색</button>
                </div>
            	<div class="search-result">
                    <div>
                        검색 결과 : ${uploadFileSearch.pagination.recordTotalCount}건
                    </div>
                    <div>
                        <form:select path="pagination.recordCountPerPage">
                            <form:option value="1" label="1" />
                            <form:option value="2" label="2" />
                            <form:option value="3" label="3" />
                            <form:option value="5" label="5" />
                            <form:option value="10" label="10" />
                        </form:select>
                    </div>
                </div>
            </form:form>
            <div class="file_list">
                <c:choose>
                    <c:when test="${empty uploadFileSearch.resultList}">
                        <div>검색된 파일이 없습니다.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="resultItem" items="${uploadFileSearch.resultList}" varStatus="status">
                            <div class="fileInfo fileItem_${resultItem.fileID}">
                                <div class="fileName">
                                    <div class="downloadFileName">${resultItem.orginFileName} (${resultItem.orginFileSize}byte, ${resultItem.regDate})</div>
                                    <div class="downloadProgress">
                                        <div class="downloadBar"></div>
                                        <div class="downloadPercent"></div>
                                    </div>
                                </div>
                                <div class="downloadButtons">
                                    <button type="button" class="btn btn-success btn-sm downloadPlay" data-value="${resultItem.fileID}">다운로드</button>
                                    <button type="button" class="btn btn-danger btn-sm downloadStop hidden" data-value="${resultItem.fileID}">취소</button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
			<c:if test="${not empty uploadFileSearch.resultList}">
                <div>
                    <ul id="boardPagination" class="pagination">
                        <li class="page-item<c:if test="${!uploadFileSearch.pagination.isEnablePageFirstNo()}"> disabled</c:if>"><a class="page-link page-first" data-pageno="1" href="javascript:void(0)">First</a></li>
                        <li class="page-item<c:if test="${!uploadFileSearch.pagination.isEnablePrevPageSizeNo()}"> disabled</c:if>"><a class="page-link page-prev" data-pageno="${uploadFileSearch.pagination.pageStartNo - 1}" href="javascript:void(0)">&lt;</a></li>
                        <c:forEach var="page" begin="${uploadFileSearch.pagination.pageStartNo}" end="${uploadFileSearch.pagination.pageEndNo}" step="1">
                            <li class="page-item<c:if test="${uploadFileSearch.pagination.pageNo == page}"> active</c:if>">
                                <a class="page-link page-no" data-pageno="${page}" href="javascript:void(0)">${page}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item<c:if test="${!uploadFileSearch.pagination.isEnableNextPageSizeNo()}"> disabled</c:if>"><a class="page-link page-next" data-pageno="${uploadFileSearch.pagination.pageEndNo + 1}" href="javascript:void(0)">&gt;</a></li>
                        <li class="page-item<c:if test="${!uploadFileSearch.pagination.isEnablePageLastNo()}"> disabled</c:if>"><a class="page-link page-last" data-pageno="${uploadFileSearch.pagination.pageLastNo}" href="javascript:void(0)">Last</a></li>
                    </ul>
                </div>
            </c:if>
		</div>
		<script src="/scripts/transmission/download.js"></script>
		<script src="/scripts/test/file.js"></script>
    </body>
</html>