<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		</style>
	</head>
	<body>
		<div class="board">
			<form action="/index.do" method="post">
				<select name="searchType">
					<option value="subject" <c:if test="${boardSearchVO.searchType == 'subject'}">selected="selected"</c:if>>제목</option>
					<option value="subjectandcontent" <c:if test="${boardSearchVO.searchType == 'subjectandcontent'}">selected="selected"</c:if>>제목+내용</option>
				</select>
				<select name="searchCondition">
					<option value="equal" <c:if test="${boardSearchVO.searchCondition == 'equal'}">selected="selected"</c:if>>일치</option>
					<option value="like" <c:if test="${boardSearchVO.searchCondition == 'like'}">selected="selected"</c:if>>포함</option>
				</select>
				<input name="searchKeyword" placeholder="검색할 키워드를 입력하세요." type="text" value="${boardSearchVO.searchKeyword}">
				<input type="submit" value="검색">
			</form>
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
	</body>
</html>