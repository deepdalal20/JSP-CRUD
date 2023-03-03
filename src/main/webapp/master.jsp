<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.PrintWriter" %>
<% 
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	String em = (String)session.getAttribute("semail");
	if(em == null)
	{
		response.sendRedirect("login.jsp");
	}
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/jms","root","");
	Statement statement = connection.createStatement();
	String query = "select * from tbluser where email = '"+em+"'";
	ResultSet set = statement.executeQuery(query);
	if(set.next())
	{
		String id = set.getString("id");
		session.setAttribute("sid", id);
	}
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Master Page</title>
    <link rel="stylesheet" href="./Font-Awesome-master/css/all.min.css">
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./select2/css/select2.min.css">
    <style>
        :root{
            --bs-success-rgb:71, 222, 152 !important;
        }
        html,body{
            height:100%;
            width:100%;
        }
        @media screen{
            body{
                background-size:cover;
                background-repeat:no-repeat;
                background-position:center center;
                backdrop-filter: brightness(0.7);
            }
        }
        main{
            height:100%;
            display:flex;
            flex-flow:column;
        }
        #page-container{
            flex: 1 1 auto; 
            overflow:auto;
        }
        #topNavBar{
            flex: 0 1 auto; 
        }
        .thumbnail-img{
            width:50px;
            height:50px;
            margin:2px
        }
        .truncate-1 {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
        }
        .truncate-3 {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }
        .modal-dialog.large {
            width: 80% !important;
            max-width: unset;
        }
        .modal-dialog.mid-large {
            width: 50% !important;
            max-width: unset;
        }
        @media (max-width:720px){
            
            .modal-dialog.large {
                width: 100% !important;
                max-width: unset;
            }
            .modal-dialog.mid-large {
                width: 100% !important;
                max-width: unset;
            }  
        
        }
        .display-select-image{
            width:60px;
            height:60px;
            margin:2px
        }
        img.display-image {
            width: 100%;
            height: 45vh;
            object-fit: cover;
            background: black;
        }
        /* width */
        ::-webkit-scrollbar {
        width: 5px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
        background: #f1f1f1; 
        }
        
        /* Handle */
        ::-webkit-scrollbar-thumb {
        background: #888; 
        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
        background: #555; 
        }
        .img-del-btn{
            right: 2px;
            top: -3px;
        }
        .img-del-btn>.btn{
            font-size: 10px;
            padding: 0px 2px !important;
        }
    </style>
  </head>
  <body>
<div class="card h-100 d-flex flex-column rounded-0 shadow">
    <div class="card-body flex-grow-1">
        <div class="col-12 h-90">
            <div class="row h-100">
                <div class="col-md-6 h-100 d-flex flex-column">
                    <div class="w-100 d-flex border-bottom border-dark py-1 mb-1">
                        <div class="fs-5 col-auto flex-grow-1"><b>Master Page</b></div>
                        <div class="col-auto flex-grow-0 d-flex justify-content-end">
                            <a href="newpr.jsp" id="new_category" class="btn btn-dark btn-sm bg-gradient rounded-2" title="Add Category"><span class="fa fa-plus"></span></a>
                        </div>
                        <div class="col-auto flex-grow-0 d-flex justify-content-end">
                            <a href="logout.jsp" id="new_category" class="btn btn-dark btn-sm bg-gradient rounded-2" title="Add Category"><span>Logout</span></a>
                        </div>
                    </div>
                    <div class="h-100 overflow-auto border rounded-1 border-dark">
                        <ul class="list-group">
                            <li class="list-group-item d-flex">
                                <div class="col-auto flex-grow-1">
                                    <h6> Name</h6>
                                </div>
                                <div class="col-auto flex-grow-1">
                                	<h6> Image</h6>
                                </div>
                                <div class="col-auto flex-grow-1">
                                    <h6> Category</h6>
                                </div>
                                <div class="col-auto flex-grow-1">
                                    <h6> Type</h6>
                                </div>
                                <div class="col-auto flex-grow-1">
                                    <h6> Price</h6>
                                </div>
                                <div class="col-auto d-flex justify-content-end">
                                    <h6>Action</h6>
                                </div>
                            </li>
                        </ul>
                    </div>
					<%
						try
						{
							String query1 = "select * from tblproduct";
							ResultSet set1 = statement.executeQuery(query1);
							while(set1.next())
							{
							%>
                    <div class="h-100 overflow-auto border rounded-1 border-dark">
                        <ul class="list-group">
                            <li class="list-group-item d-flex">
                                <div class="col-auto flex-grow-1">
                                    <%out.print(set1.getString(2)); %>
                                </div>
                                <div class="col-auto flex-grow-1">
                                	<img src="<%out.print(set1.getString(3)); %>"  style="width: 50px; height: 30px;">
                                    
                                </div>
                                <div class="col-auto flex-grow-1">
                                    <%out.print(set1.getString(4)); %>
                                </div>
                                <div class="col-auto flex-grow-1">
                                    <%out.print(set1.getString(5)); %>
                                </div>
                                <div class="col-auto flex-grow-1">
                                    <%out.print(set1.getString(6)); %>
                                </div>
                                <div class="col-auto d-flex justify-content-end">
                                    <a href="updatepr.jsp?id=<%out.print(set1.getString(1)); %>" class="edit_category btn btn-sm btn-primary bg-gradient py-0 px-1 me-1" title="Edit Category Details"><span class="fa fa-edit"></span></a>
                                    <a href="deletepr.jsp?id=<%out.print(set1.getString(1)); %>" class="delete_category btn btn-sm btn-danger bg-gradient py-0 px-1" title="Delete Category"><span class="fa fa-trash"></span></a>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <%
						}
					}
	               	catch(Exception e)
					{
						System.out.print(e);
					}
					%>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://kit.fontawesome.com/96531cd29f.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
    </script>
  </body>
</html>