<%@ page contentType="text/html;charset=utf-8" import="java.sql.*, java.io.*" %>
<%
request.setCharacterEncoding("utf-8");
 
try {
	String idx = request.getParameter("idx");

	Class.forName("org.mariadb.jdbc.Driver");
	
  
	String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD= "1234";

	Connection con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	
	String sql = "SELECT imageFile FROM post WHERE idx=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1,Integer.parseInt(idx));
	
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	
	String filename = rs.getString("imageFile");
	 
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	
	File file = new File(realFolder + "\\"+filename);
	
	file.delete();
	
	sql = "DELETE FROM post WHERE idx=?";
	
	pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1,Integer.parseInt(idx));
	
	pstmt.executeUpdate();
	
	rs.close();
	pstmt.close();
	con.close();
} catch (SQLException e) {
	out.println(e.toString());
	return;
} catch (Exception e) { 
	out.println(e.toString());
	return;
}
response.sendRedirect("index.jsp");   
%> 