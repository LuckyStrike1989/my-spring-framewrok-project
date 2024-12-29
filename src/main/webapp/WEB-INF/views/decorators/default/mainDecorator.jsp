<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<title><sitemesh:write property='title'/></title>
		<%@ include file="headInclude.jsp" %>
		<sitemesh:write property='head'/>
	</head>
	<body>
		<%@ include file="headerInclude.jsp" %>
		<div class="main">
			<sitemesh:write property='body'/>
		</div>
		<%@ include file="footerInclude.jsp" %>
	</body>
</html>