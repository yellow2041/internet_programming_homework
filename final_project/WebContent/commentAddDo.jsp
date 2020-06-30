<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*" session="false"%>
<!DOCTYPE html>
<html>
<%
	request.setCharacterEncoding("utf-8");

	HttpSession session = request.getSession(false);

	int contentsIdx = Integer.parseInt(request.getParameter("idx"));

	if (session == null || session.getAttribute("login.id") == null) {
		%>
		<script>
		alert('로그인이 필요합니다.');history.back();
		</script>
		<%
	} else {
		String comment = request.getParameter("comment");

		Class.forName("org.mariadb.jdbc.Driver");

		String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";

		String DB_USER = "admin";
		String DB_PASSWORD = "1234";

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;

		try {
			con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			String query = "INSERT INTO comment(contentsIdx, writerIdx, writerName, writeTime, comment) VALUES(?,?,?,NOW(),?)";

			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, contentsIdx);
			pstmt.setInt(2, (int) session.getAttribute("login.idx"));
			pstmt.setString(3, (String) session.getAttribute("login.name"));
			pstmt.setString(4, comment);
			
			pstmt.executeUpdate();
			
			query="SELECT commentNum FROM post WHERE idx=?";
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, contentsIdx);
			rs=pstmt.executeQuery();
			rs.next();
			int tmp=rs.getInt("commentNum");
			tmp++;
			
			query="UPDATE post SET commentNum=? WHERE idx=?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,tmp);
			pstmt.setInt(2,contentsIdx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			out.println("err: " + e.toString());
		}
		rs.close();
		pstmt.close();
		con.close();
		
		response.sendRedirect("postView.jsp?idx=" + contentsIdx);
	}
%>
</html>