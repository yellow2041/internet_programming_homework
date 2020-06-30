<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" import="java.util.*,java.sql.*, java.io.*" session="false"%>
<%
	request.setCharacterEncoding("utf-8");
	HttpSession session = request.getSession(false);

	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD = "1234";

	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	int maxsize = 1024 * 1024 * 10;

	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

	MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, "utf-8", policy);

	int idx = Integer.parseInt(request.getParameter("idx"));
	String category = multi.getParameter("category");
	String title = multi.getParameter("title");
	String contents = multi.getParameter("content");
	String imageFile = multi.getFilesystemName("fileName");

	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

	if (imageFile != null) {
		
		sql = "SELECT category,imageFile FROM post WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);

		rs = pstmt.executeQuery();
		rs.next();
		String oldFileName = rs.getString("imageFile");
		if(category==null){
			category=rs.getString("category");
		}
		File oldFile = new File(realFolder + "\\" + oldFileName);
		oldFile.delete();

		sql = "UPDATE post SET category=?, title=?, imageFile=?, contents=?, datetime=NOW() WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, category);
		pstmt.setString(2, title);
		pstmt.setString(3, imageFile);
		pstmt.setString(4, contents);
		pstmt.setInt(5, idx);
	} else {
		sql = "SELECT category FROM post WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);

		rs = pstmt.executeQuery();
		rs.next();
		if(category==null){
			category=rs.getString("category");
		}
		sql = "UPDATE post SET category=?, title=?,contents=?,datetime=NOW() WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, category);
		pstmt.setString(2, title);
		pstmt.setString(3, contents);
		pstmt.setInt(4, idx);
	}

	pstmt.executeUpdate();
	if (pstmt != null)
		pstmt.close();
	if (rs != null)
		rs.close();
	if (con != null)
		con.close();

	response.sendRedirect("index.jsp");
%>