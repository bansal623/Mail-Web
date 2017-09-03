<html>
<head>
<body>
<% 	session.invalidate();
System.out.println("logout");
	response.sendRedirect("index.jsp");
%>
</body>
</head>
</html>