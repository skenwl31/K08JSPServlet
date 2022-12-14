<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - url</title>
</head>
<body>
<!-- url태그
 : url을 생성할 때 사용한다. 절대경로로 사용시 컨텍스트 루트
 경로는 제외한다. var속성을 지정하지 않은 경우 해당 위치에
 생성된 url이 출력된다.  --> 
	<h4>url 태그로 링크걸기</h4>
	<!-- HOST(도메인부분)을 제외한 나머지 경로를 반환한다. var속성이
	지정되었으므로 위치에는 출력되지 않는다. -->
	<c:url value="/11JSTL/inc/OtherPage.jsp" var="url">
		<c:param name="user_param1" value="Must"/>
		<c:param name="user_param2" value="Have">Have</c:param>
	</c:url>
	<!--  앞에서 생성된 URL은 a태그에 포함된다. -->
	<a href="${url }">OtherPage.jsp 바로가기</a>
</body>
</html>