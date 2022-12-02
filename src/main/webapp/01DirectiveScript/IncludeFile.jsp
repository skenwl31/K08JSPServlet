<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<!--HTML주석 
보통의 경우 인클루드 되는 JSP파일은 HTMl 태그 없이
순수한 JSP코드만 작성하는 것이 좋다. 포함되었을때 html태그가
중복될수 있기 때문이다. -->

<%-- JSP주석
포함되는 페이지를 만들때에도 반드시 page지시어는
있어야 한다. page 지시어가 없는 jsp파일은 오류가 발생한다. --%> 
<%
LocalDate today = LocalDate.now(); //오늘 날짜
LocalDateTime tomorrow = LocalDateTime.now().plusDays(1); //내일 날짜
%>

