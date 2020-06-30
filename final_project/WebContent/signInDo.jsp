<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" session="false" %>
<%
request.setCharacterEncoding("utf-8");

HttpSession session = request.getSession(false);

	Class.forName("org.mariadb.jdbc.Driver");

	String DB_URL = "jdbc:mariadb://localhost:3307/snsboard?useSSL=false";

	String DB_USER = "admin";
	String DB_PASSWORD = "1234";

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	
	try {
	    con =  DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);

	    String query =  "SELECT * FROM user WHERE id=? AND pwd=?";
	
	    pstmt = con.prepareStatement(query);
		pstmt.setString(1,id);
		pstmt.setString(2,pwd);
	    
	    rs = pstmt.executeQuery();
	    
	    if(rs.next()){
	    	String loginId=rs.getString("id");
	    	String loginName=rs.getString("name");
	    	String loginBirth=rs.getString("birth");
	    	String loginPwd=rs.getString("pwd");
	    	int loginIdx=rs.getInt("idx");
	    	
	    	session.setAttribute("login.idx", loginIdx);
	    	session.setAttribute("login.id", loginId);
	    	session.setAttribute("login.name", loginName);
	    	session.setAttribute("login.birth", loginBirth);
	    	session.setAttribute("login.pwd", loginPwd);
	    	
	    	response.sendRedirect("index.jsp");
	    	
	    }else{
	    	%>
	    	<script>
	    	alert('아이디 혹은 비밀번호가 틀렸습니다.')
	    	history.go(-1)
	    	</script>
	    	<%
	    }
	}catch(SQLException e){
		out.println("err: "+e.toString());
	}
%>