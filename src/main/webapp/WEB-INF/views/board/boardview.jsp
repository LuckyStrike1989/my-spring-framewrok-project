<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판</title>
		<style type="text/css">
			.boardview { width:800px; margin: 20px auto; }
			.boardview table { width:100%; border-top:2px solid #1d4281; border-spacing:0; }
			.boardview table th { padding:8px 10px 10px 10px; vertical-align:middle; color:#1d4281; font-size:14px; border-bottom:1px solid #ccc; background:#f8f8f8; }
			.boardview table td { padding:7px 20px 9px 20px; text-align:left; vertical-align:middle; border-bottom:1px solid #ccc; font-size:14px; line-heighT:150%; }
			.boardview table td.title { font-weight: bold; }
			.buttons { position:relative; height:32px; margin-top:20px; }
			.buttons > div.left { position:absolute; height:32px; left:0; }
			.buttons > div.right { position:absolute; height:32px; right:0; }
			.buttons > div > button { overflow:visible; cursor:pointer; min-width:125px; height:32px; margin:0 2px; padding:0 15px; line-height:32px; font-size:14px; border:1px solid #dfdfdf; background:#fff; border-radius:10px; }
		</style>
	</head>
	<body>
		<div class="boardview">
			<form id="boardview" method="post">
				<input type="hidden" name="sequence" value="${boardItem.sequence}" />
			</form>
			<table>
				<colgroup>
					<col style="width:18.5%">
					<col style="width:">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">제목</th>
						<td class="title">${boardItem.subject}</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td>${boardItem.content}</td>
					</tr>
					<tr>
						<th scope="row">작성자</th>
						<td>${boardItem.registrationId}</td>
					</tr>
					<tr>
						<th scope="row">작성일자</th>
						<td>${boardItem.registrationDateTime}</td>
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
		<script type="text/javascript">
			$(function() {
				$('#editBtn').click(function() {
					var result = confirm("수정하시겠습니까?");
					if (result) {
						var boardview = $('#boardview');
						boardview.attr("action", "/board/editform.do");
						boardview.submit();
					}
				});
				$('#deleteBtn').click(function() {
					var result = confirm("삭제하시겠습니까?");
					if (result) {
						var boardview = $('#boardview');
						boardview.attr("action", "/board/deleteboard.do");
						boardview.submit();
					}
				});
				$('#listBtn').click(function() {
					window.history.go(-1);
				});
			});
		</script>
	</body>
</html>