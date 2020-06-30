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
		int visit = rs.getInt("readNum");
		visit++;
		int contentsIdx=rs.getInt("idx");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./index_styles.css" />
<link rel="shortcut icon" type="image⁄x-icon" href="./images/lgtwins.png" />
<title>게시글 보기</title>
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
		<article style="padding-left: 20px; position: absolute; top: 0px; left: 250px; width: 750px; float: left;">
			<h2 style="margin-bottom: 0px">
				<%=rs.getString("title")%>
			</h2>
			<script>
				function confirmDelete(idx) {
					var answer = confirm('해당 게시물을 삭제하시겠습니까?');
					if (answer === true)
						location.href = "postDeleteDo.jsp?idx="+idx;
				}
			</script>
			<div style="text-align: right; color: gray;">
				작성자:
				<%=rs.getString("writer")%>&nbsp
				<%=rs.getString("datetime").substring(0, 19)%>&nbsp 조회수:
				<%=rs.getInt("readNum")%>&nbsp 추천수:
				<%=rs.getInt("recommendNum")%>&nbsp 댓글수: 
				<%=rs.getInt("commentNum") %>&nbsp
				 &nbsp
				<%
				//String loginIdx=(String)session.getAttribute("login.idx");
					if (session != null && session.getAttribute("login.idx") != null) {
						if ((int) session.getAttribute("login.idx") == rs.getInt("writerIdx")) {
			%>
				<a href="postModify.jsp?idx=<%=rs.getInt("idx")%>" style="color: gray;">수정</a> &nbsp &nbsp<a href="#" onclick="confirmDelete(<%=rs.getInt("idx")%>)" style="color: gray;">삭제</a>
				<%
					}
						}
				%>
			</div>
			<hr style="border: 0.05mm solid lightslategray; margin-top: 3px">
			<div style="padding-top: 10px;">
				<%
					if (rs.getString("imageFile") != null) {
				%>
				<div style="text-align: center;">
					<img src="./upload/<%=rs.getString("imageFile")%>" width="80%" />
				</div>
				<div style="text-align: center">
					<p><%=rs.getString("contents")%></p>
				</div>
				<%
					} else {
				%>
				<div style="position: relative; padding: 0px 0px 10px;">
					<p><%=rs.getString("contents")%></p>
				</div>

				<%
					}
				%>
				<div style="text-align: center; margin-bottom: 20px;">
					<button class="btn btn-info btn-lg" onclick="location.href='./increaseReco.jsp?idx=<%=idx%>'">추천하기</button>
				</div>
			</div>
			<div>
				<hr style="border: 0.05mm solid lightslategray; margin-top: 3px">
				<h4 style="margin-bottom: 8px">댓글</h4>
				<form action="commentAddDo.jsp?idx=<%=idx%>" method="post">
					<div class="form-row" style="margin-bottom: 20px">
						<textarea class="form-control" name="comment" id="exampleFormControlTextarea1" style="width: 88%; height: 60px" rows="2"></textarea>
						<button class="btn btn-info btn-lg" type="submit" style="height: 60px; margin-left: 3px; float: right" type="submit">입 력</button>
					</div>
				</form>
				<%
					sql = "SELECT * FROM comment WHERE contentsIdx=?";

						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, idx);

						rs = pstmt.executeQuery();
						while (rs.next()) {
				%>
				<div>
					<div class="form-row">
						<h5 style="margin-bottom: 8px">
							<%=rs.getString("writerName")%>
							&nbsp &nbsp
						</h5>
						<script>
				function confirmDelete2(contentsIdx,commentIdx) {
					var answer = confirm('해당 댓글을 삭제하시겠습니까?');
					if (answer === true)
						location.href = "commentDeleteDo.jsp?commentIdx="+commentIdx+"&contentsIdx="+contentsIdx;
				}
			</script>
						<div style="text-align: right; color: gray;">
							<%=rs.getString("writeTime").substring(0, 19)%>&nbsp &nbsp
							<%
								if (session != null && session.getAttribute("login.idx") != null) {
											if ((int) session.getAttribute("login.idx") == rs.getInt("writerIdx")) {
							%>
							<a href="commentModify.jsp?commentIdx=<%=rs.getInt("idx")%>&contentsIdx=<%=contentsIdx %>" style="color: gray;">수정</a> &nbsp &nbsp<a href="#" onclick="confirmDelete2(<%=contentsIdx%>,<%=rs.getInt("idx")%>)" style="color: gray;">삭제</a>
							<%
								}
										}
							%>
						</div>
					</div>
					<div style="margin-block-start: 0px;"><%=rs.getString("comment")%></div>
					<hr>
				</div>
				<%
					}
				%>
			</div>
			<%
				sql = "UPDATE post SET readNum=? WHERE idx=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, visit);
					pstmt.setInt(2, idx);
					pstmt.executeUpdate();

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