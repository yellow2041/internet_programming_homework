<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" session="false"%>
<%
	HttpSession session = request.getSession(false);
	
	request.setCharacterEncoding("utf-8");
	int idx = Integer.parseInt(request.getParameter("idx"));

	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD = "1234";

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

		String sql = "SELECT * FROM post WHERE idx=?";

		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);

		rs = pstmt.executeQuery();
		rs.next();
		if(session==null||session.getAttribute("login.idx")==null||(int)session.getAttribute("login.idx")!=rs.getInt("writerIdx")){
			response.sendRedirect("index.jsp");
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./index_styles.css" />
<link rel="shortcut icon" type="image⁄x-icon" href="./images/lgtwins.png" />
<title>게시글 수정</title>
</head>
<body>
	<header>
		<div style="height: 20%; background-color: lightskyblue; padding: 50px 20px;">
			<div>
				<h1 style="width: 90%; text-align: center; display: inline-block;">
					<a id="main_title" href="./index.jsp">아무말 대잔치</a>
				</h1>
			</div>
			<div style="float: right;">
				<%
					if (session == null || session.getAttribute("login.id") == null) {
						response.sendRedirect("index.jsp");
				%>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='./signInp.jsp'">Sign in</button>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='./addUser.jsp'">Sign up</button>
				<%
					} else {
				%>
				<h4 class="align-bottom">
					안녕하세요! &nbsp<%=(String) session.getAttribute("login.name")%>님
					<form action="logout.jsp" style="display: inline">
						<button type="submit" class="btn btn-outline-secondary btn-sm" style="margin-bottom: 7px">Logout</button>
					</form>
				</h4>
				<%
					}
				%>
			</div>
		</div>


		<div style="height: 20px"></div>
	</header>
	<div style="position: relative; float: left;width:250px">
		<nav style="float: left; width: 100%; padding-right: 20px">
			<aside id="sidebar">
				<div id="category">
					<div>
						<div id="category_title">
							Category
						</div>
					</div>
					<ul class="category_list">
						<li class="big_list">기술공간
							<ul class="small_list">
								<li><a href="categoryView.jsp?category=React" style="color:black; text-decoration:none">React</a></li>
								<li><a href="categoryView.jsp?category=Spring" style="color:black; text-decoration:none">Spring</a></li>
							</ul>
						</li>
						<li class="big_list">여행공간
							<ul class="small_list">
								<li><a href="categoryView.jsp?category=스페인" style="color:black; text-decoration:none">스페인</a></li>
								<li><a href="categoryView.jsp?category=홍콩" style="color:black; text-decoration:none">홍콩</a></li>
								<li><a href="categoryView.jsp?category=일본" style="color:black; text-decoration:none">일본</a></li>
							</ul>
						</li>
						<li class="big_list">일상공간
							<ul class="small_list">
								<li><a href="categoryView.jsp?category=맛집" style="color:black; text-decoration:none">맛집</a></li>
								<li><a href="categoryView.jsp?category=정보" style="color:black; text-decoration:none">정보</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<form class="form-row" action="searchResult.jsp" method="post">
				<div class="form-row" style="margin-bottom:20px">
					<input class="form-control" style="width: 60%; margin-left: 20px" type="text" name="search" placeholder="게시글 검색">
					<div class="col-auto" >
						<button class="btn btn-info" type="submit">검색</button>
					</div>
				</div>
				</form>
			</aside>
		</nav>
		<article style="padding-left: 30px; position: absolute; top: 0px; left: 240px; width: 750px; float: left;">
			<form action="postModifyDo.jsp?idx=<%=idx %>" method="post" enctype="multipart/form-data">
				<div>
					<h2>
						<div class="content_title">게시물 작성</div>
					</h2>
				</div>
				<div>
					<span>게시판 선택</span> <span style="padding-left: 50px;"> 
					<select name="category" class="form-control" id="exampleFormControlSelect1" style="width: 300px; display: inline;">
							<option value="<%=rs.getString("category") %>" selected hidden><%=rs.getString("category") %></option>
							<option value="React">React</option>
							<option value="Spring">Spring</option>
							<option value="스페인">스페인</option>
							<option value="홍콩">홍콩</option>
							<option value="일본">일본</option>
							<option value="맛집">맛집</option>
							<option value="정보">정보</option>
					</select>
					</span>
				</div>
				<div style="padding-top: 15px">
					<span>제목</span> <span style="padding-left: 93px;"> <input type="text" class="form-control" id="exampleFormControlInput1" name="title" value="<%=rs.getString("title") %>" style="width: 500px; display: inline;">
					</span>
				</div>
				<div style="padding-top: 15px">
					<div>
						<div>
							<span style="padding-right: 3px">내용 <span style="float: right; margin-bottom: 3px"> 
							현재 파일: <%=rs.getString("imageFile")%>
							<input type="file" class="btn btn-info btn-sm pull-right" name="fileName" id="file" accept="image/*" />
							</span>
							</span>
						</div>
						<div style="padding-top: 5px">
							<textarea class="form-control" id="exampleFormControlTextarea1" name="content" row="50" placeholder="내용을 입력해주세요." style="height: 300px"><%=rs.getString("contents")%></textarea>
						</div>
					</div>
				</div>

				<div style="float: right;">
					<button class="btn btn-info btn-lg" style="margin-top: 5px" type="submit">수 정</button>
				</div>
			</form>
			<%
					rs.close();
					pstmt.close();
					con.close();
				} catch (SQLException e) {
					out.println(e);
				}
			%>
		</article>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>