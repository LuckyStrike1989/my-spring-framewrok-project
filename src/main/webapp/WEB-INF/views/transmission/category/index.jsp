<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
    <head>
        <title>카테고리 관리</title>
        <link rel="stylesheet" type="text/css" href="/css/common.css">
        <link rel="stylesheet" type="text/css" href="/css/category.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="basicLayout">
            <div class="buttons">
                <div class="right">
                    <button id="addCategoryBtn" class="button blue">등록</button>
                </div>
            </div>
            <form id="gotoForm" method="GET">
                <input type="hidden" name="pageNo" value="${categorySearch.pagination.pageNo}">
                <input type="hidden" name="recordCountPerPage" value="${categorySearch.pagination.recordCountPerPage}">
            </form>
            <form:form modelAttribute="categorySearch" autocomplete="off">
                <form:hidden path="pagination.pageNo" />
                <form:hidden path="pagination.pageLastNo" />
                <div>
                    검색 조건 :
                    <form:select path="searchType">
                        <form:option value="" label="전체" />
                        <form:option value="categoryName" label="카테고리명" />
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
                        검색 결과 : ${categorySearch.pagination.recordTotalCount}건
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
			<table class="list">
				<colgroup>
					<col style="width:10%">
					<col style="width:*">
					<col style="width:25%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">카테고리</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
				<tbody>
                    <c:choose>
                        <c:when test="${empty categorySearch.resultList}">
                            <tr><td colspan="3">검색된 카테고리가 없습니다.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="resultItem" items="${categorySearch.resultList}" varStatus="status">
                                <tr class="item" data-value="${resultItem.categoryID}">
                                    <td>${categorySearch.pagination.recordTotalCount - ((categorySearch.pagination.pageNo - 1) * categorySearch.pagination.recordCountPerPage) - status.count + 1}</td>
                                    <td>${resultItem.category}</td>
                                    <td>${resultItem.regDate}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
				</tbody>
			</table>
			<c:if test="${not empty categorySearch.resultList}">
                <div>
                    <ul id="boardPagination" class="pagination">
                        <li class="page-item<c:if test="${!categorySearch.pagination.isEnablePageFirstNo()}"> disabled</c:if>"><a class="page-link page-first" data-pageno="1" href="javascript:void(0)">First</a></li>
                        <li class="page-item<c:if test="${!categorySearch.pagination.isEnablePrevPageSizeNo()}"> disabled</c:if>"><a class="page-link page-prev" data-pageno="${categorySearch.pagination.pageStartNo - 1}" href="javascript:void(0)">&lt;</a></li>
                        <c:forEach var="page" begin="${categorySearch.pagination.pageStartNo}" end="${categorySearch.pagination.pageEndNo}" step="1">
                            <li class="page-item<c:if test="${categorySearch.pagination.pageNo == page}"> active</c:if>">
                                <a class="page-link page-no" data-pageno="${page}" href="javascript:void(0)">${page}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item<c:if test="${!categorySearch.pagination.isEnableNextPageSizeNo()}"> disabled</c:if>"><a class="page-link page-next" data-pageno="${categorySearch.pagination.pageEndNo + 1}" href="javascript:void(0)">&gt;</a></li>
                        <li class="page-item<c:if test="${!categorySearch.pagination.isEnablePageLastNo()}"> disabled</c:if>"><a class="page-link page-last" data-pageno="${categorySearch.pagination.pageLastNo}" href="javascript:void(0)">Last</a></li>
                    </ul>
                </div>
            </c:if>
		</div>
		<script src="/scripts/test/category/index.js"></script>
    </body>
</html>