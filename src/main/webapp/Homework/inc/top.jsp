<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
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
          <%
          
          
          if(session.getAttribute("UserId") == null){
        	  System.out.println("=====session 에서 가져오는 값이 null");
          %>
              <li class="nav-item">
			<a class="nav-link" href="#"><i class='bi bi-person-plus-fill' style='font-size:20px'></i>회원가입</a>
			</li>
			 <li class="nav-item">
                   <a class="nav-link" href="./IsLoggedIn.jsp"><i class='bi bi-box-arrow-in-right'
                           style='font-size:20px'></i>로그인</a>
            </li>
            <%
            
            
          } else {
        	
            %>
            <li class="nav-item" style="padding-top:8px; padding-right:7px; font-weight:bold;">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-heart" viewBox="0 0 16 16">
  			<path d="M9 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h10s1 0 1-1-1-4-6-4-6 3-6 4Zm13.5-8.09c1.387-1.425 4.855 1.07 0 4.277-4.854-3.207-1.387-5.702 0-4.276Z"/>
			</svg>
            <i class="bi bi-person-heart" style='font-size:20px'></i>
            <%= session.getAttribute("UserName") %> 회원님<br>
            </li>
			<li class="nav-item">
				<a class="nav-link" href="#"><i class='bi bi-person-lines-fill' style='font-size:20px'></i>회원정보수정</a>
			</li>
              
            <li class="nav-item">
                <a class="nav-link" href="Logout.jsp"><i class='bi bi-box-arrow-right'
                        style='font-size:20px' ></i>로그아웃</a>
            </li>
            <%
          }
            %>
            
        </ul>
    </nav>
</div>