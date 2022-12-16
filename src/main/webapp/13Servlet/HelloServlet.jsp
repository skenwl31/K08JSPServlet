<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HelloServlet.jsp</title>
</head>
<body>
	<h2>web.xml에서 매핑 후 JSP 출력하기</h2>
	<p>
		<strong><%= request.getAttribute("message") %></strong>
		<br>
		<!-- request내장객체를 이용해서 현재 프로젝트의
		컨텍스트루트 경로를 얻어온 후 링크에 적용한다.
		이런경우 절대경로로 링크를 설정하게 된다. -->
		<a href="./HelloServlet.do">바로가기</a>
	</p>
</body>
</html>