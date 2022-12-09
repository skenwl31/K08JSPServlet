<%@page import="model1.homework.BoardDTO"%>
<%@page import="model1.homework.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    
String num = request.getParameter("num");
//DAO객체 생성을 통해 오라클에 연결한다.
BoardDAO dao = new BoardDAO(application);
//게시물의 조회수 증가
dao.updateVisitCount(num);
//게시물의 내용을 인출하여 DTO로 반환받는다.
BoardDTO dto = dao.selectView(num);
//자원해제
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
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-12">
            <!-- 
				.bg-primary, .bg-success, .bg-info, .bg-warning, .bg-danger, .bg-secondary, 
				.bg-dark, .bg-light
			-->
            <nav class="navbar navbar-expand-sm bg-warning navbar-secondary">
                <!-- Brand/logo -->
                <a class="navbar-brand" href="#">
                    <img src="https://tjoeun.co.kr/images/logo.gif?v=20190918" style="width:150px;">
                </a>

                <!-- Links -->
                <ul class="navbar-nav ms-3">
                    <li class="nav-item">
                        <a class="nav-link" href="#">자유게시판</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">자료실</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">방명록</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">드롭다운</a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">SubMenu 1</a>
                            <a class="dropdown-item" href="#">SubMenu 2</a>
                            <a class="dropdown-item" href="#">SubMenu 3</a>
                        </div>
                    </li>
                </ul>

                <form class="form-inline mt-3 ms-3" method="get" action="">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Search">
                        <div class="input-group-append">
                            <button class="btn btn-danger" type="submit"><i class='bi bi-search'
                                    style='font-size:20px'></i></button>
                        </div>
                    </div>
                </form>

                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
						<a class="nav-link" href="#"><i class='bi bi-person-plus-fill' style='font-size:20px'></i>회원가입</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#"><i class='bi bi-person-lines-fill' style='font-size:20px'></i>회원정보수정</a>
					</li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class='bi bi-box-arrow-in-right'
                                style='font-size:20px'></i>로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class='bi bi-box-arrow-right'
                                style='font-size:20px'></i>로그아웃</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-3">
            <div style="height: 100px; line-height: 100px; margin:10px 0; text-align: center; 
				color:#ffffff; background-color:rgb(133, 133, 133); border-radius:10px; font-size: 1.5em;">
                웹사이트제작
            </div>
            <div class="nav flex-column nav-pills dropdown dropend" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab"
                    aria-controls="v-pills-home" aria-selected="true">자유게시판</a>
                <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab"
                    aria-controls="v-pills-profile" aria-selected="false">자료실</a>
                <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab"
                    aria-controls="v-pills-messages" aria-selected="false">방명록</a>
                <a class="nav-link dropdown-toggle " data-bs-toggle="dropdown" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab"
                    aria-controls="v-pills-messages" aria-selected="false">드롭다운</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">SubMenu 1</a>
                        <a class="dropdown-item" href="#">SubMenu 2</a>
                        <a class="dropdown-item" href="#">SubMenu 3</a>
                    </div>
            </div>
        </div>
        <div class="col-9 pt-3">
            <h3>게시판 내용보기 - <small>자유게시판</small></h3>

            <form>
            <table class="table table-bordered">
            <colgroup>
                <col width="20%"/>
                <col width="30%"/>
                <col width="20%"/>
                <col width="*"/>
            </colgroup>
            <tbody>
                <tr>
                    <th class="text-center" 
                        style="vertical-align:middle;">작성자</th>
                    <td>
                        <%= dto.getName() %>
                    </td>
                    <th class="text-center" 
                        style="vertical-align:middle;">작성일</th>
                    <td>
                        <%= dto.getPostdate() %>
                    </td>
                </tr>
                <tr>
                    <th class="text-center" 
                        style="vertical-align:middle;">이메일</th>
                    <td>
                        nakjasabal@naver.com
                    </td>
                    <th class="text-center" 
                        style="vertical-align:middle;">조회수</th>
                    <td>
                        <%= dto.getVisitcount() %>
                    </td>
                </tr>
                <tr>
                    <th class="text-center" 
                        style="vertical-align:middle;">제목</th>
                    <td colspan="3">
                        <%= dto.getTitle().replace("\r\n", "<br>") %>
                    </td>
                </tr>
                <tr>
                    <th class="text-center" 
                        style="vertical-align:middle;">내용</th>
                    <td colspan="3">
                    <%= dto.getContent().replace("\r\n", "<br/>") %>
                    </td>
                </tr>
                <tr>
                    <th class="text-center" 
                        style="vertical-align:middle;">첨부파일</th>
                    <td colspan="3">
                        파일명.jpg
                    </td>
                </tr>
            </tbody>
            
            </table>
            
            <div class="row">
                <div class="col text-right mb-4">
			<%
			if(session.getAttribute("UserId")!=null &&
				dto.getId().equals(session.getAttribute("UserId").toString())){
			%>
				<button type="button" class="btn btn-primary" onclick="location.href='boardWrite.jsp';">글쓰기</button>
			    <button type="button" class="btn btn-secondary" onclick="location.href='boardModify.jsp?num=<%= dto.getNum() %>';">
			    수정하기</button>
			    <button type="button" class="btn btn-warning">리스트보기</button> 
			    <button type="button" class="btn btn-success" onclick="deletePost();">삭제하기</button>
                <!-- 각종 버튼 부분 -->
                    
                 
                 
                    
                </div>
            </div> 
			<%
			}
			%>
			    
            </form> 
        </div>
    </div>
    <div class="row border border-dark border-bottom-0 border-right-0 border-left-0"></div>
    <div class="row mb-5 mt-3">
        <div class="col-2">
            <h3>겸이아빠&trade;</h3>
        </div>
        <div class="col-10 text-center">
            Email : nakjasabal@naver.com&nbsp;&nbsp;
            Mobile : 010-7906-3600&nbsp;&nbsp;
            Address : 서울시 금천구 가산동 426-5 월드메르디앙2차 1강의실
            <br />
            copyright &copy; 2019 한국소프트웨어인재개발원.
            All right reserved.
        </div>
    </div>
</div>
</body>
</html>


