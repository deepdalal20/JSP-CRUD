<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
	.gradient-custom 
	{
		background: #f093fb;
		background: -webkit-linear-gradient(to bottom right, rgba(240, 147, 251, 1), rgba(245, 87, 108, 1));
		background: linear-gradient(to bottom right, rgba(0,0,0,0.75), rgba(0,0,0,0.75))
	}	
	.card-registration .select-input.form-control[readonly]:not([disabled]) 
	{
		font-size: 1rem;
		line-height: 2.15;
		padding-left: .75em;
		padding-right: .75em;
	}
	.card-registration .select-arrow 
	{
		top: 13px;
	}
</style>
</head>
<body>
<section class="vh-100 gradient-custom">
  <div class="container py-5 h-100">
    <div class="row justify-content-center align-items-center h-100">
      <div class="col-12 col-lg-9 col-xl-7">
        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
          <div class="card-body p-4 p-md-5">
            <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Registration Form</h3>
            <form>

              <div class="row">
                <div class="col-md-6 mb-4">

                  <div class="form-outline">
                    <input type="text" class="form-control form-control-lg" name="name"/>
                    <label class="form-label" for="firstName">Name</label>
                  </div>

                </div>
                <div class="col-md-6 mb-4">

                  <div class="form-outline">
                    <input type="email" class="form-control form-control-lg" name="email"/>
                    <label class="form-label" for="lastName">Email</label>
                  </div>

                </div>
              </div>

              <div class="row">
                <div class="col-md-6 mb-4 d-flex align-items-center">

                  <div class="form-outline datepicker w-100">
                    <input type="text" class="form-control form-control-lg" name="contact"/>
                    <label for="birthdayDate" class="form-label">Contact</label>
                  </div>
                </div>
                <div class="col-md-6 mb-4">
                	<div class="form-outline">
	                    <input type="password" class="form-control form-control-lg" name="password"/>
	                    <label class="form-label" for="phoneNumber">Password</label>
	                  </div>
              </div>
              <div class="row">
                <div class="col-md-6 mb-4 pb-2">
                  <div class="form-outline">
                  	<textarea class="form-control form-control-lg" rows = "2" cols = "60" name = "address"></textarea>
                    <label class="form-label" for="phoneNumber">Address</label>
                  </div>
                </div>
                <div class="col-md-6 mb-4 pb-2">
                  <h6 class="mb-2 pb-1">Gender: </h6>
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="male"/>
                    <label class="form-check-label" for="maleGender">Male</label>
                  </div>
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="female"/>
                    <label class="form-check-label" for="femaleGender">Female</label>
                  </div>
                </div>
                </div>
              </div>
              <div class="mt-4 pt-2">
               <input class="btn btn-primary btn-lg" type="submit" value="Submit" name="submit">
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ page import="java.sql.*, java.io.PrintWriter" %>
<%
	String a = request.getParameter("submit");
    if(a!= null)
    {
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	String con = request.getParameter("contact");
    	String pass = request.getParameter("password");
    	String add = request.getParameter("address");
    	String gen = request.getParameter("gender");

    	int conn = con.length();
		int pas = pass.length();
    	
    	if(name != null && email != null && con != null && pass != null && add != null && gen != null)
    	{
    		if(conn == 10)
    		{
    			if(pas >= 8)
    			{
    				Class.forName("com.mysql.cj.jdbc.Driver");
    				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/jms","root","");
    				Statement statement = connection.createStatement(); 
    				String query1 = "select email from tbluser where email = '"+email+"'";
    				ResultSet set = statement.executeQuery(query1);
    				if(set.next())
    				{
    					out.print("<script>alert('Email already exists');</script>");
    				}
    				else
    				{
    					String query = "insert into tbluser(`name`,`email`,`contact`,`password`, `address`, `gender`) values ('"+name+"','"+email+"','"+con+"','"+pass+"','"+add+"','"+gen+"')";
						statement.executeUpdate(query);
						session.setAttribute("semail", email);
						response.sendRedirect("master.jsp");
    				}
    			}
    			else
    			{
    				out.print("<script>alert('Password must be of 8 characters atleast');</script>");
    			}
    		}
    		else
    		{
    			out.print("<script>alert('Enter Contact Details properly...');</script>");
    		}
    	}
    	else
    	{
    		out.print("<script>alert('Enter Form Details properly...');</script>");
    	}
    }
%>
</body>
</html>