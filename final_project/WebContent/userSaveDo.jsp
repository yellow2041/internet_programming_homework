<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, myBean.DB.*, javax.naming.*"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String name = request.getParameter("name");
String birth=request.getParameter("birth");
String pwd = request.getParameter("pwd");

Article art = new Article();
art.setId(id);
art.setName(name);
art.setBirth(birth);
art.setPwd(pwd);

try {
	ArticleDB db = new ArticleDB();
	
	db.insertRecord(art);
	db.close();
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}
response.sendRedirect("index.jsp");

%>