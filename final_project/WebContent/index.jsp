<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" session="false"%>
<%
	HttpSession session = request.getSession(false);

	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD = "1234";

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

		String sql = "SELECT * FROM post LIMIT 0,3";

		pstmt = con.prepareStatement(sql);

		rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./index_styles.css" />
<link rel="shortcut icon" type="image⁄x-icon" href="./images/lgtwins.png" />
<title>야구 개막하게 해 주세요</title>
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
				%>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='./signIn.jsp'">Sign in</button>
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
	<div style="position: relative; float: left;">
		<nav style="float: left;">
			<aside id="sidebar">
				<div id="category">
					<div>
						<div id="category_title">
							Category
							<div style="position: relative; float: right; padding-left: 120px">
								<img src="./images/plus.png" width="25px" height="20px">
							</div>
						</div>
					</div>
					<ul class="category_list">
						<li class="big_list">기술공간
							<ul class="small_list">
								<li>React</li>
								<li>Spring</li>
								<li>C/C++</li>
							</ul>
						</li>
						<li class="big_list">여행공간
							<ul class="small_list">
								<li>스페인</li>
								<li>홍콩</li>
								<li>일본</li>
							</ul>
						</li>
						<li class="big_list">일상공간
							<ul class="small_list">
								<li>맛집 소개</li>
								<li>책</li>
								<li>유용한 정보들</li>
							</ul>
						</li>
					</ul>
				</div>
				<div>
					<input id="category_search" type="text" name="search" value="검색 내용을 입력하세요.">
					<button id="searchBtn" type="submit">검색</button>
				</div>
			</aside>
		</nav>
		<article style="padding-left: 30px; position: absolute; top: 0px; left: 240px; width: 750px; float: left;">
			<h2>
				<div class="content_title">
					최근 게시물
					<div style="position: relative; float: right; padding-left: 120px; padding: 10px">
						<%
							if (session == null || session.getAttribute("login.id") == null) {
						%>
						<a href="./signIn.jsp"> <img src="./images/plus.png" width="35px" height="28px"></a>
						<%
							} else {
						%>
						<a href="./input.jsp"> <img src="./images/plus.png" width="35px" height="28px"></a>
						<%
							}
						%>
					</div>
				</div>
			</h2>
			<%
				while (rs.next()) {
			%>
			<div style="padding-top: 10px;">
			<%if(rs.getString("imageFile")!=null){ %>
				<img src="./upload/<%=rs.getString("imageFile")%>" width="150" height="100">
				<%
				}
				%>
				<div style="position: relative; float: right; padding: 0px 10px 10px; width: 500px;">
					<h4><%=rs.getString("title")%></h4>
					<p><%=rs.getString("contents")%></p>
				</div>
			</div>
			<%
				}
					rs.close();
					pstmt.close();
					con.close();
				} catch (SQLException e) {
					out.println(e);
				}
			%>
			<div style="padding-top: 10px;">
				<img src="./images/ww.jpg" width="150" height="100">
				<div style="position: relative; float: right; padding: 0px 10px 10px; width: 500px;">
					<h4>프로야구의 계절이 돌아왔습니다.</h4>
					<p>야구 개막 해주세요...코로나 언제 사라질까요ㅠㅠㅠ윌슨 보고싶습니다ㅠㅠ</p>
				</div>
			</div>
			<div style="padding-top: 10px;">
				<img src="./images/ww.jpg" width="150" height="100">
				<div style="position: relative; float: right; padding: 0px 10px 10px; width: 500px;">
					<h4>프로야구의 계절이 돌아왔습니다.</h4>
					<p>야구 개막 해주세요...코로나 언제 사라질까요ㅠㅠㅠ윌슨 보고싶습니다ㅠㅠ</p>
				</div>
			</div>
			<div style="padding-top: 10px;">
				<img src="./images/ww.jpg" width="150" height="100">
				<div style="position: relative; float: right; padding: 0px 10px 10px; width: 500px;">
					<h4>프로야구의 계절이 돌아왔습니다.</h4>
					<p>야구 개막 해주세요...코로나 언제 사라질까요ㅠㅠㅠ윌슨 보고싶습니다ㅠㅠ</p>
				</div>
			</div>
		</article>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>