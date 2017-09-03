<html>
<body>
<%@ page language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<% String name=request.getParameter("email");
   String pass=request.getParameter("pass");
   Statement stmt;
	ResultSet rs;
	int found=0;
	try
			{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        Connection con=DriverManager.getConnection("Jdbc:Odbc:Online");
		    stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	        rs=stmt.executeQuery("SELECT * FROM Q");
				
	        while (rs.next())
	        {
	       		System.out.println("fg");
	        	if(name.equals(rs.getString("Name"))&& pass.equals(rs.getString("Password")) )
	        	{
	        		System.out.println("fgehdfdjsd");
	        		found++;
	        		break;
	        	}
	        	else
	        	{
	        		found=0;	
	        	}

	        }
	        out.println(found);
	        if(found==0)
	        {
	        		out.println("<html><head><body><center>Username or Password Incorrect</center></body></html>");
	        		pageContext.include("login.html");
	        		
	        }
	        else
	        {
				session=request.getSession();
	        	session.setAttribute("user",name);
				response.sendRedirect("inbox.jsp");
	        }	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
 %>  
 </body>
 </html>