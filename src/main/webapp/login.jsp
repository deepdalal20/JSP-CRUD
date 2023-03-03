<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="stylesheet" href="loginstyle.css">
    <title> Login </title>
</head>
<body>
    <div class="container">
        <div class="forms">
            <div class="form login">
                <span class="title">Login</span>
                <form action="" method="post">
                    <div class="input-field">
                        <input type="email" placeholder="Enter your email" name="logemail" required>
                        <i class="uil uil-envelope icon"></i>
                    </div>
                    <div class="input-field">
                        <input type="password" class="password" placeholder="Enter your password" name="logpass" required>
                        <i class="uil uil-lock icon"></i>
                        <i class="uil uil-eye-slash showHidePw"></i>
                    </div>
                    <div class="checkbox-text">
                        <div class="checkbox-content">
                            <input type="checkbox" id="logCheck">
                            <label for="logCheck" class="text" name="reme">Remember me</label>
                        </div>
                        <a href="forgetpass.jsp" class="text">Forgot password?</a>
                    </div>
                    <div class="input-field button">
                        <input type="submit" value="Login" name="logsub">
                    </div>
                </form>
                <div class="login-signup">
                    <span class="text">Not a user?
                        <a href="register.jsp" class="text signup-link">Signup Now</a>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <script>
        const container = document.querySelector(".container"),
            pwShowHide = document.querySelectorAll(".showHidePw"),
            pwFields = document.querySelectorAll(".password");

        pwShowHide.forEach(eyeIcon =>{
        eyeIcon.addEventListener("click", ()=>{
            pwFields.forEach(pwField =>{
                if(pwField.type ==="password"){
                    pwField.type = "text";

                    pwShowHide.forEach(icon =>{
                        icon.classList.replace("uil-eye-slash", "uil-eye");
                    })
                }else{
                    pwField.type = "password";

                    pwShowHide.forEach(icon =>{
                        icon.classList.replace("uil-eye", "uil-eye-slash");
                    })
                }
            }) 
        })
    })
    </script>
    <%@ page import="java.sql.*, java.io.PrintWriter" %>
	<%
	
	String a = request.getParameter("logsub");
    if(a!= null)
    {
    	String email = request.getParameter("logemail");
    	String pass = request.getParameter("logpass");
    	String rem = request.getParameter("reme");
		int pas = pass.length();
    	if(email != null && pass != null)
    	{
    			if(pas >= 8)
    			{
    				Class.forName("com.mysql.cj.jdbc.Driver");
    				Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/jms","root","");
    				Statement statement = connection.createStatement(); 
    				String query1 = "select * from tbluser where email = '"+email+"'";
    				ResultSet set = statement.executeQuery(query1);
    				if(set.next())
    				{
    					String em = set.getString("email");
    					String ps = set.getString("password");
    					
    					if(email.equals(em) && pass.equals(ps))
    					{
    						if(rem != null)
							{
    							String id = set.getString("id");
        						String name = set.getString("name");
        						String cont = set.getString("contact");
        						String add = set.getString("address");
        						String gen = set.getString("gender");
        						
        						session.setAttribute("sid", id);
    							session.setAttribute("sname", name);
    							session.setAttribute("semail", em);
    							session.setAttribute("scon", cont);
    							session.setAttribute("sadd", add);
    							session.setAttribute("sgen", gen);
    							    							
								Cookie Remid = new Cookie("RemId", em);
								Cookie Rempass = new Cookie("RemPass", ps);
								Remid.setMaxAge(60*60*24*15);
								Rempass.setMaxAge(60*60*24*15);
								response.addCookie(Remid);
								response.addCookie(Rempass);
								
								response.sendRedirect("master.jsp");
							}
    						else
    						{
    							String id = set.getString("id");
        						String name = set.getString("name");
        						String cont = set.getString("contact");
        						String add = set.getString("address");
        						String gen = set.getString("gender");
        						
        						session.setAttribute("sid", id);
    							session.setAttribute("sname", name);
    							session.setAttribute("semail", em);
    							session.setAttribute("scon", cont);
    							session.setAttribute("sadd", add);
    							session.setAttribute("sgen", gen);
    							response.sendRedirect("master.jsp");
    						}
    					}
    					else
    					{
    						out.print("<script>alert('Email or Password is Wrong');</script>");
    					}
    				}
    				else
    				{
    					out.print("<script>alert('User doesn't exist');</script>");
    				}
    			}
    			else
    			{
    				out.print("<script>alert('Enter PAssword Properly');</script>");
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