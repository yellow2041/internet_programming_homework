<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" import="java.sql.*, java.io.*"%>
<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

int maxsize = 1024*1024*10;

try {
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

	MultipartRequest multi = new MultipartRequest(request, realFolder,maxsize,"utf-8", policy);

	String writer = (String)session.getAttribute("login.name");
	String category = multi.getParameter("category");
	String title = multi.getParameter("title");
	String contents = multi.getParameter("content");
	
	String imageFile = multi.getFilesystemName("fileName");

	Connection con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	
	String sql = "INSERT INTO post(category, title, writer, imageFile, contents, datetime) VALUES(?,?,?,?,?,NOW())";
	
	PreparedStatement pstmt = con.prepareStatement(sql);

	pstmt.setString(1, category);
	pstmt.setString(2, title);
	pstmt.setString(3,writer);
	pstmt.setString(4,imageFile);
	pstmt.setString(5,contents);

	pstmt.executeQuery();

	pstmt.close();
	con.close();

} catch(IOException e) { 
	out.println(e);
	return;
} catch(SQLException e) {
	out.println(e);
	return;
}
response.sendRedirect("index.jsp");
	%>