<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%
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

		String sql = "SELECT recommendNum FROM post WHERE idx=?";

		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);

		rs = pstmt.executeQuery();
		rs.next();

		int reco = rs.getInt("recommendNum");

		reco++;
		sql = "UPDATE post SET recommendNum=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, reco);
		pstmt.setInt(2, idx);
		pstmt.executeUpdate();

		rs.close();
		pstmt.close();
		con.close();
		
	} catch (SQLException e) {
		out.println(e);
	}
	response.sendRedirect("postView.jsp?idx="+idx);
%>