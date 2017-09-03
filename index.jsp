<html>
<head>
<body>
<%@ page language="java"%>
<%@ page import="java.io.*"%>
<% 
	session=request.getSession();
	String user=(String)session.getAttribute("user");
	if(user==null)
	{
		pageContext.include("login.html");      		
	}
	else
	{
		response.sendRedirect("inbox.jsp");
	}
%>
</body>
</head>
</html>