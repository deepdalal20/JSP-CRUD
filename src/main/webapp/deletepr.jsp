<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.PrintWriter" %>
<% 
	String id = (String)session.getAttribute("sid");
	if(id == null)
	{
		response.sendRedirect("login.jsp");
	}
	String pid = request.getParameter("id");
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/jms","root","");
		Statement statement = connection.createStatement();
		String query = "DELETE FROM tblproduct WHERE p_id='"+pid+"'";
		statement.executeUpdate(query);
		response.sendRedirect("master.jsp");
	}
	catch(Exception e)
	{
		System.out.print(e);
	}
%>  