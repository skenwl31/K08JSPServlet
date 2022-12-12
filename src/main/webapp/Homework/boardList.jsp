<%@page import="utils.BoardPageboots"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//DB연결 및 CRUD작업을 위한 DAO객체를 생성한다.
BoardDAO dao = new BoardDAO(application);
/*
검색어가 있는경우 클라이언트가 선택한 필드명과 검색어를 저장할
Map컬렉션을 생성한다. 
*/
Map<String, Object> param = new HashMap<String, Object>();
/* 검색폼에서 입력한 검색어와 필드명을 파라미터로 받아온다.
해당 <form>의 전송방식은 get, action속성은 없는 상태이므로 현재
페이지로 폼값이 전송된다. */
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//사용자가 입력한 검색어가 있다면..
if (searchWord != null) {
	/* Map컬렉션에 컬럼명과 검색어를 추가한다. */
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}
//Map컬렉션을 인수로 게시물의 갯수를 카운트한다.
int totalCount = dao.selectCount(param);


/**페이징 코드 추가 부분 start************************/
//web.xml에 설정한 컨텍스트 초기화 파라미터를 읽어와서 산술연산을 위해
//정수(int)로 변환한다.
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

/*전체 페이지수를 계산한다. 
(전체게시물갯수 / 페이지당 출력할게시물 갯수) =>결과값의 올림처리
가령 게시물의 갯수가 51개라면 나눴을때의 결과가 5.1이 된다. 이때 무조건
올림처리 하여 6 페이지가 나오게 된다. 만약 totalCount를 double로 형변환
하지 않으면 정수의 결과가 나오게 되므로 6페이지가 아니라 5페이지라는 결과가 
나오게 되므로 주의해야 한다.
*/
int totalPage = (int)Math.ceil((double)totalCount / pageSize);

/*
목록에 처음 진입했을때는 페이지 관련 파라미터가 없는 상태이므로 무조건
1page로 지정한다. 만약 파라미터 pageNum이 있다면 request 내장객체를 통해
받아온 후 페이지 번호로 지정한다.
List.jsp => 이와같이 파라미터가 없는 상태일때는 null
List.jsp?pageNum ==> 이와같이 파라미터는 있는데 값이 없을때는 빈값으로 체크된다.
	따라서 아래 if문은 2개의 조건으로 구성해야 한다.
*/
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);

/*
게시물의 구간을 계산한다.
각 페이지의 시작번호와 종료번호를 현재페이지 번호와 페이지 사이즈를 통해
계산한 후 DAO로 전달하기 위해 MAP컬렉션에 추가한다.
*/
int start = (pageNum -1) * pageSize +1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);
	
/**페이징 코드 추가부분 end************************/


//목록에 출력할 게시물을 추출하여 반환받는다. 
List<BoardDTO> boardLists = dao.selectListPage(param);
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
    	<!-- 상단 네비게이션 인클루드 -->
        <%@ include file ="./inc/top.jsp" %>
    </div>
    <div class="row">
            <!-- 사이드바 인클루드 -->
			<%@ include file = "./inc/side.jsp" %>
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
                    </colgroup>
                    <thead>
                        <tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>
                    <tbody>
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
						else {
							//출력할 게시물이 있는 경우에는 확장 for문으로 List컬렉션에
							//저장된 데이터의 갯수만큼 반복하여 출력한다.
						    int virtualNum = 1; 
						    for (BoardDTO dto : boardLists)
						    {
						    	//현재 출력할 게시물의 갯수에 따라 출력번호는 달라지므로
						    	//totalCount를 사용하여 가상번호를 부여한다.
						        virtualNum = totalCount--;   
						%>
                        <tr>
                            <td class="text-center"><%= virtualNum %></td>
                            <td class="text-left"><a href="boardView.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a></td>
                            <td class="text-center"><%= dto.getId() %></td>
                            <td class="text-center"><%= dto.getPostdate() %></td>
                            <td class="text-center"><%= dto.getVisitcount() %></td>
                        </tr>
                        <%
						    }
						}
						%>
                    </tbody>
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
                <% System.out.println("현재경로" + request.getRequestURI()); %>
        		<%= BoardPageboots.pagingStr(totalCount, pageSize, blockPage, pageNum,
        				request.getRequestURI()) %>
                    <!-- <ul class="pagination justify-content-center">
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
                    </ul> -->
                </div>
            </div>
        </div>
    </div>
    <div class="row border border-dark border-bottom-0 border-right-0 border-left-0"></div>
    	<!-- 바텀 인클루드 -->
		<%@ include file = "./inc/bottom.jsp" %>
</div>
</body>
</html>