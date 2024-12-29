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
		</style>
	</head>
	<body>
		<div class="board">
			<form:form modelAttribute="boardSearch" autocomplete="off">
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
						검색 결과 : ${boardSearch.pagingVO.recordTotalCount}건
					</div>
					<div>
						<form:select path="pagingVO.recordCountPerPage">
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
					<c:forEach var="boardItem" items="${boardList}" varStatus="status">
					<tr>
						<td>${fn:length(boardList) - status.count + 1}</td>
						<td>${boardItem.subject}</td>
						<td>${boardItem.registrationId}</td>
						<td>${boardItem.registrationDateTime}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
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
				$('select[name="pagingVO.recordCountPerPage"]').change(function(event) {
					boardSearch.submit();
				});
			});
		</script>
	</body>
</html>