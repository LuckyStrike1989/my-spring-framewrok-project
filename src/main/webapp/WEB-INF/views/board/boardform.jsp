<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판</title>
		<style type="text/css">
			.board { width:800px; margin: 20px auto; }
			.board table { width:100%; border-top:2px solid #1d4281; border-spacing:0; }
			.board table th { padding:8px 10px 10px 10px; vertical-align:middle; color:#1d4281; font-size:14px; border-bottom:1px solid #ccc; background:#f8f8f8; }
			.board table td { padding:7px 20px 9px 20px; text-align:left; vertical-align:middle; border-bottom:1px solid #ccc; font-size:14px; line-heighT:150%; }
			.board table td input[type="text"], .board table td textarea { width:100%; color:#000 !important; } 
			.buttons { position:relative; height:32px; margin-top:20px; }
			.buttons > div.right { position:absolute; height:32px; right:0; }
			.buttons > div > .button { overflow:visible; cursor:pointer; min-width:125px; height:32px; margin:0 2px; padding:0 15px; line-height:32px; font-size:14px; border:1px solid #dfdfdf; background:#fff; border-radius:10px; }
			.buttons > div > .button.blue { color:#fff; border-color:#0099d2 !important; background:#0099d2 !important; }
			.form-input:invalid { border: 1px solid #dc3545; }
			.form-input:valid { border: 1px solid #198754; }
			.was-validated .form-input:invalid { border: 1px solid #dc3545; }
			.was-validated .form-input:valid { border: 1px solid #198754; }
			.invalid-feedback { display: none; width: 100%; margin-top: 4px; color: #dc3545; }
			.was-validated .form-input.is-invalid { border: 1px solid #dc3545; }
			.was-validated .form-input.is-invalid .invalid-feedback { display: block; }
		</style>
	</head>
	<body>
		<div class="board">
			<form:form modelAttribute="board" autocomplete="off">
			<table>
				<colgroup>
					<col style="width:18.5%">
					<col style="width:auto">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">작성자</th>
						<td>
							<form:input path="registrationId" placeholder="아이디를 입력하세요." minlength="2" maxlength="20" required="required" class="form-input" />
							<div class="invalid-feedback">아이디는 최소 2자이상 최대 20자 이내로 입력하세요.</div>
						</td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td>
							<form:input path="subject" placeholder="제목을 입력하세요." required="required" class="form-input" />
							<div class="invalid-feedback">제목을 입력하세요.</div>
						</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td><form:textarea path="content" placeholder="내용을 입력하세요." rows="10" /></td>
					</tr>
				</tbody>
			</table>
			</form:form>
			<div class="buttons">
				<div class="right">
					<button id="saveBtn" class="button blue">등록</button>
					<button id="cancelBtn" class="button">취소</button>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function() {
				$('#saveBtn').click(function() {
					/*
					var registrationId = $('#registrationId').val();
					if (registrationId == null || registrationId == "") {
						alert("아이디를 입력하세요.");
						$("#registrationId").focus();
						return;
					}
					var subject = $('#subject').val();
					if (subject == null || subject == "") {
						alert("제목을 입력하세요.");
						$("#subject").focus();
						return;
					}
					$('#board').attr("action", "/board/addboard.do");
					$('#board').submit();
					*/
					
					var registrationId = $('#registrationId')[0];
					if (!registrationId.checkValidity()) {
						if (registrationId.validity.valueMissing) {
							registrationId.setCustomValidity('작성자 입력란에 아이디가 입력되지 않았습니다.\n아이디를 입력하세요.');
						} else if (registrationId.validity.tooShort) {
							registrationId.setCustomValidity('작성자 입력란에 아이디는 최소 2자이상 최대 20자 이내로 입력하세요.');
						}
						alert(registrationId.validationMessage);
						$('#registrationId').focus();
						registrationId.setCustomValidity("");
						return;
					}
					var subject = $('#subject')[0];
					if (!subject.checkValidity()) {
						if (subject.validity.valueMissing) {
							subject.setCustomValidity('제목 입력란에 제목이 입력되지 않았습니다.\n제목을 입력하세요.');
						}
						alert(subject.validationMessage);
						$('#subject').focus();
						subject.setCustomValidity("");
						return;
					}
					$('#board').attr("action", "/board/addboard.do");
					$('#board').submit();
					
					
					/*var boardForm = $('#board')[0];
					if (!boardForm.checkValidity()) {
						var registrationId = $('#registrationId')[0];
						console.log(registrationId.validity);
						var subject = $('#subject')[0];
						console.log(subject.validity);
					} else {
						console.log("에러가 없습니다.");
					}*/
					
					/*var boardForm = $('#board');
					if (!boardForm[0].checkValidity()) {
						boardForm.addClass('was-validated');
					} else {
						boardForm.attr("action", "/board/addboard.do");
						boardForm.submit();
					}*/
				});
				$('#cancelBtn').click(function() {
					window.history.go(-1);
				});
			});
		</script>
	</body>
</html>