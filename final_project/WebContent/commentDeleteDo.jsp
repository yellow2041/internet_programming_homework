<%@ page contentType="text/html;charset=utf-8" import="java.sql.*, java.io.*" %>
<%
request.setCharacterEncoding("utf-8");
String idx = request.getParameter("commentIdx");
int contentsIdx=Integer.parseInt(request.getParameter("contentsIdx"));
try {
	Class.forName("org.mariadb.jdbc.Driver");
	
  
	String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD= "1234";

	Connection con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	
	String sql = "DELETE FROM comment WHERE idx=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1,Integer.parseInt(idx));
	
	pstmt.executeUpdate();
	
	sql="SELECT commentNum FROM post WHERE idx=?";
	
	ResultSet rs=null;
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, contentsIdx);
	rs=pstmt.executeQuery();
	rs.next();
	int tmp=rs.getInt("commentNum");
	tmp--;
	
	sql="UPDATE post SET commentNum=? WHERE idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1,tmp);
	pstmt.setInt(2,contentsIdx);
	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
} catch (SQLException e) {
	out.println(e.toString());
	return;
} catch (Exception e) { 
	out.println(e.toString());
	return;
}
idx=request.getParameter("contentsIdx");
response.sendRedirect("postView.jsp?idx="+idx);   
%> 