<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판</title>
		<style>
			.board { width:800px; margin: 20px auto; }
			.board table { width:100%; border-top:2px solid #1d4281; border-spacing:0; }
			.board table thead th { padding:8px 10px 10px 10px; vertical-align:middle; color:#1d4281; font-size:14px; border-bottom:1px solid #ccc; background:#f8f8f8; }
			.board table tbody td { padding:7px 10px 9px 10px; text-align:center; vertical-align:middle; border-bottom:1px solid #ccc; font-size:14px; line-heighT:150%; }
			.board table tbody td:nth-child(2) { text-align:left;}
			.board form { margin-bottom: 10px; }
			.board form select { padding: 4px 4px; }
			.board form input[type="text"] { padding: 4px 4px; width: 200px; }
			.board form button { display: inline-flex; height: 27px; font-size: 14px; }
			.board form .search-result { display: flex; justify-content: space-between; margin-top: 10px; }
			.board ul.pagination { display: flex; list-style: none; padding: 0; justify-content: center!important; flex-wrap: wrap; }
			.board ul.pagination li.page-item a { display: block; padding: 0.5em 0.75em; border: 1px solid #dee2e6; margin-left: -1px; text-decoration: none; color: #333; }
			.board ul.pagination li.page-item.active a  { color: #fff; background-color: #0d6efd; }
			.board ul.pagination li.page-item:first-child a.page-link { border-top-left-radius: 0.5em; border-bottom-left-radius: 0.5em; }
			.board ul.pagination li.page-item:last-child a.page-link { border-top-right-radius: 0.5em; border-bottom-right-radius: 0.5em; }
			.board ul.pagination li.disabled { pointer-events: none; }
			.board ul.pagination li.disabled a { color: #cccccc; }
			.board ul.pagination li.page-item.active a { color: #fff; background-color: #0d6efd; pointer-events: none; }
			.buttons { position:relative; height:32px; margin-top:20px; }
			.buttons > div.right { position:absolute; height:32px; right:0; }
			.buttons > div > .button { overflow:visible; cursor:pointer; min-width:125px; height:32px; margin:0 2px; padding:0 15px; line-height:32px; font-size:14px; border:1px solid #dfdfdf; background:#fff; border-radius:10px; }
			.buttons > div > .button.blue { color:#fff; border-color:#0099d2 !important; background:#0099d2 !important; }
		</style>
	</head>
	<body>
		<div class="board">
			<div class="buttons">
				<div class="right">
					<button id="addBtn" class="button blue">등록</button>
				</div>
			</div>
			<form:form modelAttribute="boardSearch" autocomplete="off">
				<form:hidden path="paginationVO.pageNo" />
				<form:hidden path="paginationVO.pageLastNo" />
				<div>
					<form:select path="searchType">
						<form:option value="subject" label="제목" />
						<form:option value="subjectandcontent" label="제목+내용" />
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
						검색 결과 : ${boardSearch.paginationVO.recordTotalCount}건
					</div>
					<div>
						<form:select path="paginationVO.recordCountPerPage">
							<form:option value="5" label="5" />
							<form:option value="10" label="10" />
							<form:option value="25" label="25" />
							<form:option value="50" label="50" />
							<form:option value="100" label="100" />
						</form:select>
					</div>
				</div>
			</form:form>
			<table>
				<colgroup>
					<col style="width:10%">
					<col style="width:*">
					<col style="width:15%">
					<col style="width:25%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty boardList}">
							<tr><td colspan="4">검색된 게시물이 없습니다.</td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="boardItem" items="${boardList}" varStatus="status">
							<tr class="board-item" data-sequence="${boardItem.sequence}">
								<td>${boardSearch.paginationVO.recordTotalCount - ((boardSearch.paginationVO.pageNo - 1) * boardSearch.paginationVO.recordCountPerPage) - status.count + 1}</td>
								<td>${boardItem.subject}</td>
								<td>${boardItem.registrationId}</td>
								<td>${boardItem.registrationDateTime}</td>
							</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<c:if test="${not empty boardList}">
				<div>
					<ul id="boardPagination" class="pagination">
						<li class="page-item<c:if test="${!boardSearch.paginationVO.isEnablePageFirstNo()}"> disabled</c:if>"><a class="page-link page-first" data-pageno="1" href="javascript:void(0)">First</a></li>
						<li class="page-item<c:if test="${!boardSearch.paginationVO.isEnablePrevPageSizeNo()}"> disabled</c:if>"><a class="page-link page-prev" data-pageno="${boardSearch.paginationVO.prevPageSizeNo}" href="javascript:void(0)">&lt;</a></li>
						<c:forEach var="page" begin="${boardSearch.paginationVO.pageStartNo}" end="${boardSearch.paginationVO.pageEndNo}" step="1">
							<li class="page-item<c:if test="${boardSearch.paginationVO.pageNo == page}"> active</c:if>">
								<a class="page-link page-no" data-pageno="${page}" href="javascript:void(0)">${page}</a>
							</li>
						</c:forEach>
						<li class="page-item<c:if test="${!boardSearch.paginationVO.isEnableNextPageSizeNo()}"> disabled</c:if>"><a class="page-link page-next" data-pageno="${boardSearch.paginationVO.nextPageSizeNo}" href="javascript:void(0)">&gt;</a></li>
						<li class="page-item<c:if test="${!boardSearch.paginationVO.isEnablePageLastNo()}"> disabled</c:if>"><a class="page-link page-last" data-pageno="${boardSearch.paginationVO.pageLastNo}" href="javascript:void(0)">Last</a></li>
					</ul>
				</div>
			</c:if>
		</div>
		<script type="text/javascript">
			$(function() {
				var boardSearch = $('#boardSearch');
				$('#searchBtn').click(function() {
					$(this).attr("disabled", "disabled");
					boardSearch.submit();
				});
				
				$('#searchKeyword').keypress(function(event){
					if (13 == event.which) {
						$('#searchBtn').click();
						return false;
					}
				});
				
				$('select[name="paginationVO.recordCountPerPage"]').change(function(event) {
					boardSearch.submit();
				});
				
				$('#boardPagination .page-link').click(function(event) {
					event.preventDefault();
					event.stopPropagation();
					var pageLastNo = boardSearch.find('input:hidden[name="paginationVO.pageLastNo"]').val();
					var pageNo = boardSearch.find('input:hidden[name="paginationVO.pageNo"]').val();
					var moveToPageNo = $(this).attr("data-pageno");
					
					if ((pageNo == moveToPageNo) || (pageNo == 1 && moveToPageNo == 1) || (pageNo == pageLastNo && moveToPageNo == pageLastNo)) {
						return;
					}
					if (moveToPageNo > 0 && moveToPageNo <= pageLastNo) {
						boardSearch.find('input:hidden[name="paginationVO.pageNo"]').val(moveToPageNo);
						boardSearch.submit();
					}
				});
				$('#addBtn').click(function() {
					$(location).attr("href", "/board/addform.do");
				});
			});
		</script>
	</body>
</html>