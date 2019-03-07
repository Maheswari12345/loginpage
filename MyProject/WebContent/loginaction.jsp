<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
     pageEncoding="ISO-8859-1"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login page</title>
</head>
<body>
     <%
           String username = request.getParameter("username");
     String password=request.getParameter("password");
           
           try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/test";
                Connection conn = DriverManager.getConnection(url, "root", "root");
                Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = stmt.executeQuery("select * from login where username='" + username + "'");
                int status=0;
                if(rs.next())
                {
                     status=rs.getInt(7);
                     if(password.equals(rs.getString(2)) && (rs.getString(4)).equals("librarian"))
                     {
                           status=0;
                           rs.updateInt(7,status);
                           rs.updateRow();
                           HttpSession ses=request.getSession();
                           ses.setAttribute("username",username);
                           response.sendRedirect("add.html");
                     }
                    
                     else if(status<3)
                     {
                           rs.updateInt(7,++status);
                           rs.updateRow();
                           response.sendRedirect("login.html");  
                           
                     }
                     else
                     {
                    	 out.println("Invalid Attempt!!!");
                     }
                }
                else
                {
                     out.println("Invalid Username!!");
                }
                rs.close();
                stmt.close();
                conn.close();
                     
           } catch (Exception e) {
                out.println(e.getMessage());
           }
           
     %>
</body>
</html>
