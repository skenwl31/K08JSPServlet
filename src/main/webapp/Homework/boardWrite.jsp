<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %> 
<%
/* 목록에서 제목을 클릭하면 게시물의 일련번호를 ?num=99와 같이
받아온다. 따라서 내용보기를 위해 해당 파라미터를 받아온다. */
String userId = session.getAttribute("UserId").toString();
//DAO 객체 생성을 통해 오라클에 연결한다. 
BoardDAO dao = new BoardDAO(application);
//게시물의 내용을 인출하여 DTO로 반환받는다.
dao.close();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">    
	<script type="text/javascript">
	function validateForm(form) {  // 폼 내용 검증
	    if (form.title.value == "") {
	        alert("제목을 입력하세요.");
	        form.title.focus();
	        return false;
	    }
	    if (form.content.value == "") {
	        alert("내용을 입력하세요.");
	        form.content.focus();
	        return false;
	    }
	}
	</script>
</head>
<body>
<div class="container">
    <div class="row">
        <!-- 상단 네비게이션 인클루드 -->
        <%@ include file ="./inc/top.jsp" %>
    </div>
    <div class="row">
        <!-- 사이드바 인클루드 -->
		<%@ include file = "./inc/side.jsp" %>
        <div class="col-9 pt-3">
            <h3>게시판 작성 - <small>자유게시판</small></h3>

            <form name="writeFrm" method="post" action="WriteProcess.jsp"
      				onsubmit="return validateForm(this);">
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td>
                            <input type="text" class="form-control" 
                                style="width:100px;" value="<%= userId %>" readonly />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center"
                            style="vertical-align:middle;">제목</th>
                        <td>
                            <input type="text" class="form-control"  name="title" />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea rows="5" class="form-control" name="content" ></textarea>
                        </td>
                    </tr>
                </tbody>
                </table>

                <div class="row">
                    <div class="col d-flex justify-content-end mb-4">
                        <!-- 각종 버튼 부분 -->
                        <button type="submit" class="btn btn-danger me-1">작성완료</button>
                        <button type="reset" class="btn btn-dark me-1">다시입력</button>
                        <button type="button" class="btn btn-warning" onclick="location.href='boardList.jsp';" >목록이동</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="row border border-dark border-bottom-0 border-right-0 border-left-0"></div>
   	<!-- 바텀 인클루드 -->
	<%@ include file = "./inc/bottom.jsp" %>
</div>
</body>
</html>