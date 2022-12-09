<%@page import="model1.homework.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model1.homework.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//DB연결 및 CRUD작업을 위한 DAO 객체 생성
BoardDAO dao = new BoardDAO(application);

/*검색어가 있는경우 클라이언트가 선택한 필드명과 검색*/
Map<String, Object> param = new HashMap<String, Object>();

String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//사용자가 입력한 검색어가 있다면
if (searchWord != null){
	/* Map컬렉션에 컬럼명과 검색어를 추가한다.*/
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}


//Map컬렉션을 인수로 게시물의 갯수를 카운트한다.
int totalCount = dao.selectCount(param);
//목록에 출력한 게시물을 추출하여 반환받는다.
List<BoardDTO> boardLists = dao.selectList(param);
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
    <!-- 상단네비게이션 인클루드 -->
    	<%@ include file="./inc/top.jsp" %>  
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
            <h3>게시판 목록 - <small>자유게시판</small></h3>

            <div class="row ">
                <!-- 검색부분 -->
                <form method="get">
                    <div class="input-group ms-auto" style="width: 400px;">
                    
                    
                        <select name="searchField" class="form-control">
                            <option value="title">제목</option>
                            <option value="id">작성자</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" name="searchWord" class="form-control" style="width: 150px;"/>
                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-secondary">
                                <i class="bi bi-search" style='font-size:20px'></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="row mt-3 mx-1">
                <!-- 게시판리스트부분 -->
                <table class="table table-bordered table-hover table-striped">
                    <colgroup>
                        <col width="60px" />
                        <col width="*" />
                        <col width="120px" />
                        <col width="120px" />
                        <col width="80px" />
                        <col width="60px" />
                    </colgroup>
                    <thead>
                        <tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>첨부</th>
                        </tr>
                    </thead>
                    <%
					//컬렉션에 입력된 데이터가 없는지 확인한다.
					if (boardLists.isEmpty()) {
					%>
				        <tr>
				            <td colspan="5" align="center">
				                등록된 게시물이 없습니다^^*
				            </td>
				        </tr>
					<%
					}
					else{
					int virtualNum = 0;
					for (BoardDTO dto : boardLists){
						
						virtualNum = totalCount--;   
						
					%>					
                   <%--  <tbody> ㅋㅋㅋ
                        <%for(int i=1 ; i<=5 ; i++){ %> 
                        <!-- 리스트반복 -->
                        <tr>
                            <td class="text-center"><%= i %></td>
                            <td class="text-left"><a href="boardView.jsp">제목</a></td>
                            <td class="text-center">작성자</td>
                            <td class="text-center">작성일</td>
                            <td class="text-center">조회수</td>
                            <td class="text-center"><i class="bi bi-pin-angle-fill" style="font-size:20px"></i></td>
                        </tr>
                     </tbody>  --%>
                     <tr align="center">
        	<!--  게시물의 가상 번호 -->
            <td><%= virtualNum %></td>
            <!-- 제목 -->  
            <td align="left"> 
                <a href="boardView.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a> 
            </td>
           <!-- 작성자 아이디 -->
            <td align="center"><%= dto.getId() %></td>
            <!--  작성일 -->   
            <td align="center"><%= dto.getPostdate() %></td>
            <!--  조회수 -->                    
            <td align="center"><%= dto.getVisitcount() %></td>
         </tr>
<% 
	} 
}                   
%>
                </table>
            </div>
            <div class="row">
                <div class="col d-flex justify-content-end">
                    <!-- 각종 버튼 부분 -->
                    
                    <button type="button" class="btn btn-primary" onclick="location.href='boardWrite.jsp';">글쓰기</button>
                    
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <!-- 페이지번호 부분 -->
                    <ul class="pagination justify-content-center">
                        <li class="page-item">
                            <a href="#" class="page-link"><i class='bi bi-skip-backward-fill'></i></a>
                        </li>
                        <li class="page-item">
                            <a href="#" class="page-link"><i class='bi bi-skip-start-fill'></i></a>
                        </li>
                        <li class="page-item"><a href="#" class="page-link">1</a></li>
                        <li class="page-item"><a href="#" class="page-link">2</a></li>
                        <li class="page-item"><a href="#" class="page-link">3</a></li>
                        <li class="page-item"><a href="#" class="page-link">4</a></li>
                        <li class="page-item"><a href="#" class="page-link">5</a></li>
                        <li class="page-item">
                            <a href="#" class="page-link"><i class='bi bi-skip-end-fill'></i></a>
                        </li>
                        <li class="page-item">
                            <a href="#" class="page-link"><i class='bi bi-skip-forward-fill'></i></a>
                        </li>
                    </ul>
                </div>
            </div>
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