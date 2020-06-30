<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.io.*" session="false"%>
<!DOCTYPE html>
<html>
<%
	request.setCharacterEncoding("utf-8");

	HttpSession session = request.getSession(false);

	int contentsIdx = Integer.parseInt(request.getParameter("contentsIdx"));
	int commentIdx=Integer.parseInt(request.getParameter("commentIdx"));

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
			String query = "UPDATE comment SET writeTime=NOW(),comment=? WHERE idx=?";

			pstmt = con.prepareStatement(query);
			pstmt.setString(1,comment);
			pstmt.setInt(2, commentIdx);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			out.println("err: " + e.toString());
		}
		pstmt.close();
		con.close();
		
		response.sendRedirect("postView.jsp?idx=" + contentsIdx);
	}
%>
</html>