<html>
<head>
<style>
body
{
background-image:url("w03.jpg");
background-repeat:repeat-y;
background-position:center;
margin:250px;
background-attachment:fixed;
}
</style>
<body>
<font size="5">
<hr>
<%@ page language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="java.util.*"%>
<%@ page import="mailauth.*"%>
<% 
	Statement stmt;
	ResultSet rs;
	String	arr1[]=new String[100];String arr2[]=new String[100];
	String	arr3[]=new String[100];String arr4[]=new String[100]; 
	String arr5[]=new String[100];
	String no,from,sub,date,body;
	String from1,pwd;
	String compose="Compose";
	String log="Logout";
	String draft="Draft";
	String sent="Send";
	String trash="Trash";
	String save="Save";
	String s="Sent";
	String DA="DeleteAll";
	String RA="RestoreAll";
	String FA="Forward";
	String to;
	String F=request.getParameter("f");
	String S=request.getParameter("s");
	String H=request.getParameter("s1");
	String D=request.getParameter("d");
	String T=request.getParameter("t");
	String Save=request.getParameter("s3");
	String Sent=request.getParameter("s4");
	String delete=request.getParameter("da");
	String r1=request.getParameter("r1");
	String d2=request.getParameter("d2");
	String r2=request.getParameter("r2");
	String f1=request.getParameter("f1");
	out.println("<form action=inbox.jsp method=post>");
	Properties props;  
	Session session1;	
	 Message msg; 
	boolean flag=false;    %>               	
<%!	Stack st=new Stack();%>
<%	st.add("A");
			from1="mohit.bansal623@gmail.com";
			pwd="himanshu2931";
			props = new Properties();
			props.put("mail.smtp.host","smtp.gmail.com");
			props.put("mail.smtp.port", "465"); // default port 25
			props.put("mail.smtp.auth","true"); 
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.debug", "false");
			session1 = Session.getDefaultInstance(props,new SimpleMailAuthenticator(from1,pwd));
	
	session=request.getSession();
	String user=(String)session.getAttribute("user");
	if(user==null)
	{
	pageContext.include("index.html");      		
	}
	
	out.println("Welcome "+user);
	out.println("<br>");
	
if(user.equals("R"))
{
	try
			{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		    rs=stmt.executeQuery("SELECT * FROM Inbox");
				while(rs.next())
				{
					no=rs.getString("No");
					from=rs.getString("To");
					sub=rs.getString("Subject");
					date=rs.getString("Date1");
					body=rs.getString("Body");
					out.println(no+"     "+from+"    "+sub+"    "+date+"     "+body+"<br>");
				}
						
		    }
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}	
			out.println("<input type=submit name=f value=Compose>");
			
		
			out.println("<input type=submit name=s value=Logout>");
			out.println("<input type=submit name=d value=Draft>");
			out.println("<input type=submit name=s4 value=Sent>");
			out.println("<input type=submit name=t value=Trash>");
			out.println("<input type=submit name=da value=DeleteAll>");
			out.println("<input type=submit name=r1 value=RestoreAll>");
			out.println("<input type=submit name=d2 value=Delete>");
			out.println("<input type=submit name=r2 value=Restore>");
			out.println("<input type=submit name=f1 value=Forward>");
			out.println("<br><br><br>");	
		//	out.println("<input type=checkbox name=f2>");
		if(compose.equals(F))
			{
			pageContext.include("compose.html");
			}
	
			if(log.equals(S))
			{
				System.out.println("inside");
				response.sendRedirect("logout.jsp");
			}
				if(sent.equals(H))
			{
				  to=request.getParameter("n");
				 sub=request.getParameter("s2");
				 body=request.getParameter("t");
				
					try
					{
					msg=new MimeMessage(session1);
					msg.setFrom(new InternetAddress(from1));			
					msg.setRecipient(Message.RecipientType.TO,new InternetAddress(to));
					msg.setSubject(sub);
					msg.setText(body);
					Transport.send(msg);
					System.out.println("Sent Sucessfully");
					}
					catch(MessagingException me)
					{
					me.printStackTrace();
					}
					
					try
					{
					Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	       			 Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    		stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		   			 rs=stmt.executeQuery("SELECT * FROM Sent");
						if(rs.last())
						{
							no=rs.getString("No");
							int no1=Integer.parseInt(no);
							no1++;
							String dm=Calendar.getInstance().getTime().toString();
							String insert_Query="insert into Sent values(' " + no1 +" ',' " + to +" ',' " + sub + " ',' " + dm + " ',' " + body + " ')";
							System.out.println(insert_Query);
							stmt.execute(insert_Query);
						}
		    }
		catch(Exception e)
		{
			e.printStackTrace();
		}
				
			}
	
			if(save.equals(Save))
			{
				 to=request.getParameter("n");
				 sub=request.getParameter("s2");
				 body=request.getParameter("t");
				 
				 
				 	try
					{
						Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        			Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    			stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		   			 rs=stmt.executeQuery("SELECT * FROM Draft");
						if(rs.last())
						{
							no=rs.getString("No");
							int no1=Integer.parseInt(no);
							no1++;
							String dm=Calendar.getInstance().getTime().toString();
							String insert_Query="insert into Draft values(' " + no1 +" ',' " + to +" ',' " + sub + " ',' " + dm + " ',' " + body + " ')";
							System.out.println(insert_Query);
							stmt.execute(insert_Query);
						}
						else
						{
							int no1=1;
							String dm=Calendar.getInstance().getTime().toString();
							String insert_Query="insert into Draft values(' " + no1 +" ',' " + to +" ',' " + sub + " ',' " + dm + " ',' " + body + " ')";
							System.out.println(insert_Query);
							stmt.execute(insert_Query);
						}
		    		}	
				catch(Exception e)
				{
				e.printStackTrace();
				}
			
			}

		if(draft.equals(D))
		{
		st.add("Draft");
			try
			{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		    rs=stmt.executeQuery("SELECT * FROM Draft");
				while(rs.next())
				{
					no=rs.getString("No");
					from=rs.getString("To");
					sub=rs.getString("Subject");
					date=rs.getString("Date1");
					body=rs.getString("Body");
			//		out.println("<pre>"+ no+"   "+from+"    "+sub+"    "+date+"     "+body+"out.println("<input type=checkbox name=c>")<br></pre>");
		//		out.println("<pre>"+ no+"   "+from+"    "+sub+"    "+date+"     "+body+"        "+"<input type=checkbox name=f2><br></pre>");
	/*			<table>
<tr>
<td>Email:</td>
<td><input type="email" name="email"/>
</td></tr>
<tr><td>Password:</td>
<td><input type="password" name="password"/>
</td></tr>
<tr><td colspan="2" style="text-align:center">
<input class="sub" type="submit" value="login"/>
</td></tr>
</table>
*/	out.println("<table border=1><tr onclick=myfunction(this)><td>"+no+"</td><td>"+from+"</td><td>"+sub+"</td><td>"+date+"</td><td>"+body+"</td><td><input type=checkbox name=f2></td></tr></table>");
	//out.println("<script> function myfunction(x) {alert(Row Index is:+ x.rowIndex);}</script>");
//	pageContext.include("m.html");
	//response.sendRedirect("fun.js");
			//	out.println("<input type=checkbox name=f2>");
				}
						
		    }
			catch(Exception e)
			{
			e.printStackTrace();
			}
		
		}
			if(trash.equals(T))
		{
			st.add("trash");
			try
			{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		    rs=stmt.executeQuery("SELECT * FROM Trash");
				while(rs.next())
				{
					no=rs.getString("No");
					from=rs.getString("To");
					sub=rs.getString("Subject");
					date=rs.getString("Date1");
					body=rs.getString("Body");
			//		out.println(no+"     "+from+"    "+sub+"    "+date+"     "+body+"<br>");
				out.println("<table border=1><tr><td>"+no+"</td><td>"+from+"</td><td>"+sub+"</td><td>"+date+"</td><td>"+body+"</td><td><input type=checkbox name=f2></td></tr></table>");
				}
						
		    }
			catch(Exception e)
			{
			e.printStackTrace();
			}
		}
	//	out.println(sent+Sent);
		if(s.equals(Sent))
		{
		st.add("Sent");
//	st.add("abc");
		try
			{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		    rs=stmt.executeQuery("SELECT * FROM Sent");
				while(rs.next())
				{
					no=rs.getString("No");
					from=rs.getString("To");
					sub=rs.getString("Subject");
					date=rs.getString("Date1");
					body=rs.getString("Body");
				//	out.println("<pre>"+ no+"   "+from+"    "+sub+"    "+date+"     "+body+"<br></pre>");
				out.println("<table border=1><tr><td>"+no+"</td><td>"+from+"</td><td>"+sub+"</td><td>"+date+"</td><td>"+body+"</td><td><input type=checkbox name=f2></td></tr></table>");
				}
						
		    }
			catch(Exception e)
			{
			e.printStackTrace();
			}
		}
		System.out.println(st);
		
		
	
		if(DA.equals(delete))
			{
				int i=0;
			System.out.println(st.pop()); //A which is added onto stack is pop out and then required name appears at right place
		//	System.out.println(st.pop());
				
				String m=st.peek().toString();
				System.out.println(m);

					try
		    		{
		    			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        			Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    			stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		    			System.out.println(m+"Rohan Gandhi");
		    		    rs=stmt.executeQuery("SELECT * FROM "+m);
		    		    while(rs.next())
	             	    	{
	             	    	System.out.println(m);
	             	   	System.out. println(arr1[i]);
						arr1[i]=rs.getString("No");
	    	            arr2[i]=rs.getString("To");
	    	            arr3[i]=rs.getString("Subject");
	    	            arr4[i]=rs.getString("Date1");
	    	            arr5[i]=rs.getString("Body"); 
	    	       	    System.out.println(arr5[i]);
	    	            	++i; 
	    	              	}
		    		   	System.out.println(i);
		    		    int	p=i;
		    		    System.out.println(p);
		    		    for(i=0;i<p;i++)
		    		    {
		    		    	System.out.println(p);
		    		    	String insert_Query="insert into Trash values('" + arr1[i]+"','" + arr2[i] +"','" + arr3[i]+ "','" + arr4[i]+ "','" + arr5[i] + "' , '" + m + "')";
			         		stmt.execute(insert_Query);	
			         		System.out.println("Mohit");		
		    		    }
		    		    
		    		    try
						{
							
							String delete_Query="Delete from "+m;
							stmt.execute(delete_Query);
				
						}
						
						catch(Exception e4)
						{
						e4.printStackTrace();
						}
					
				}
		    	  	
	            		
				catch(Exception e4)
				{
							e4.printStackTrace();
				}
		    	  	
			}
			
			
			
				if(RA.equals(r1))
			{
				
			int	i=0;
				try
				{
						Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        			Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    			stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					 rs=stmt.executeQuery("SELECT * FROM Trash");
		    		    while(rs.next())
	             	    	{
	             	    		arr1[i]=rs.getString("No");
	    	           		    arr2[i]=rs.getString("To");
	    	            		arr3[i]=rs.getString("Subject");
	    	            		arr4[i]=rs.getString("Date1");
	             	    		arr5[i]=rs.getString("Where");
	             	    		i++;
	             	    	}	
				}
				catch(Exception e4)
				{
							e4.printStackTrace();
				}
				int p=i;
				for(i=0;i<p;i++)
				{
						System.out.println(arr5[i]);
						try
						{
						Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        			Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    			stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						 rs=stmt.executeQuery("SELECT * FROM "+arr5[i]);
							
						
						 	String insert_Query="insert into " +arr5[i]+" values('" + arr1[i]+"','" + arr2[i] +"','" + arr3[i]+ "','" + arr4[i]+ "','" + arr5[i] + "' )";
						 	System.out.println();
						 	System.out.println(insert_Query);
			         		stmt.execute(insert_Query);	
			         
						}
						catch(Exception e4)
						{
							e4.printStackTrace();
						}
						
						
				}
				try
						{
						Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	        			Connection con=DriverManager.getConnection("Jdbc:Odbc:Mail");
		    			stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							String delete_Query="Delete from Trash";
							stmt.execute(delete_Query);
				
						}
						
						catch(Exception e4)
						{
						e4.printStackTrace();
						}
					
			}
			
			if(FA.equals(f1))
			{
				pageContext.include("compose.html");
			}
			
			
			
			
	
			
	
%>
<br><br>
</body>
</head>
</html>