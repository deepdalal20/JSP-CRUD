<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
response.setHeader("Cache-Control","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
	String id = (String)session.getAttribute("sid");
	if(id == null)
	{
		response.sendRedirect("login.jsp");
	}
	String pid = request.getParameter("id");
%>   
 <%@ page import="java.sql.*, java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>
      Update Product
    </title>
  </head>
<style>
input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  width: 100%;
  background-color: #fa9200;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #fa9200;
}

div {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<body>
<%
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/jms","root","");
		Statement statement = connection.createStatement();
		String query = "select * from tblproduct where p_id = '"+pid+"'";
		ResultSet set = statement.executeQuery(query);
		if(set.next())
		{
			String pname = set.getString(2);
			String pimage = set.getString(3);
			String pcat = set.getString(4);
			String ptype = set.getString(5);
			String pprice = set.getString(6);
		%>
<h3>Update Product</h3>
<div>
  <form action="" method="post">
    <label for="fname">Product Name: </label>
    <input type="text" id="fname" name="p_name" value="<%out.print(pname);%>" required>

    <label for="fname">Product Price: </label>
    <input type="text" id="fname" name="p_price" value="<%out.print(pprice);%>" required>

    <label for="country">Category: </label>
    <select name="p_cat" id="country" class="box">
         <option value="gold">Gold</option>
         <option value="silver">Silver</option>
         <option value="ruby">Ruby</option>
         <option value="diamond">Diamond</option>
      </select><br>

    <label for="lname">Product Image: </label>
    <input type="file" id="lname" name="p_image" value="<%out.print(pimage);%>" required> <br><br>

    <label for="country">Type: </label>
    <select name="p_type" id="country" class="box">
         <option value="value="<%out.print(ptype);%>"><%out.print(ptype);%></option>
      </select>
  
    <input type="submit" name="upproduct" value="Submit">
  </form>
</div>
<%
		}
		String btn = request.getParameter("upproduct");
		if(btn != null)
		{
			String name = request.getParameter("p_name");
	    	String image = request.getParameter("p_image");
	    	String cat = request.getParameter("p_cat");
	    	String price = request.getParameter("p_price");
	    	
			String query1 = "UPDATE `tblproduct` SET `p_name`='"+name+"', `p_image`='"+image+"', `p_cat`='"+cat+"', `p_price`='"+price+"' WHERE p_id='"+pid+"'";
			statement.executeUpdate(query1);
			response.sendRedirect("master.jsp");
		}
	}
	catch(Exception e)
	{
		System.out.print(e);
	}
%>

</body>
</html>