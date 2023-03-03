<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.PrintWriter" %>
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
%>
<!DOCTYPE html>
<html>
<head>
    <title>
      Add Product
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

<h3>Add New Product</h3>

<div>
  <form action="" method="post">
    <label for="fname">Product Name: </label>
    <input type="text" id="fname" name="p_name" placeholder="Enter Product name" required>

    <label for="fname">Product Price: </label>
    <input type="text" id="fname" name="p_price" placeholder="Enter Product price" required>

    <label for="country">Category: </label>
    <select name="p_cat" id="country" class="box">
         <option value="gold">Gold</option>
         <option value="silver">Silver</option>
         <option value="ruby">Ruby</option>
         <option value="diamond">Diamond</option>
      </select><br>

    <label for="lname">Product Image: </label>
    <input type="file" id="lname" name="p_image" placeholder="Upload Product image" required> <br><br>

    <label for="country">Type: </label>
    <select name="p_type" id="country" class="box">
         <option value="ring">Ring</option>
         <option value="necklace">Necklace</option>
      </select>
  
    <input type="submit" name="newproduct" value="Submit">
  </form>
</div>
<%
	String a = request.getParameter("newproduct");
    if(a!= null)
    {
    	String name = request.getParameter("p_name");
    	String image = request.getParameter("p_image");
    	String cat = request.getParameter("p_cat");
    	String type = request.getParameter("p_type");
    	String price = request.getParameter("p_price");
    	
    	if(name != null && image != null && cat != null && type != null && price != null)
    	{
    		Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/jms","root","");
			Statement statement = connection.createStatement(); 
			String query1 = "select p_name from tblproduct where p_name = '"+name+"'";
			ResultSet set = statement.executeQuery(query1);
			if(set.next())
			{
				out.print("<script>alert('Product already exists');</script>");
			}
			else
			{
				String query = "insert into tblproduct(`p_name`,`p_image`,`p_cat`,`p_type`, `p_price`) values ('"+name+"','"+image+"','"+cat+"','"+type+"','"+price+"')";
				statement.executeUpdate(query);
				response.sendRedirect("master.jsp");
			}
    	}
    	else
    	{
    		out.print("<script>alert('Enter all the Details properly...');</script>");
    	}
    }
%>
</body>
</html>