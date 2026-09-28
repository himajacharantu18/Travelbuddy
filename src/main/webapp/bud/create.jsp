<%@ page import="java.sql.*" %>

<%
String user = (String)session.getAttribute("user");

String dest = request.getParameter("destination");
String start = request.getParameter("start_date");
String end = request.getParameter("end_date");
String budget = request.getParameter("budget");
String desc = request.getParameter("description");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","123456");

PreparedStatement ps = con.prepareStatement(
"insert into trips(user_email,destination,start_date,end_date,budget,description) values(?,?,?,?,?,?)");

ps.setString(1,user);
ps.setString(2,dest);
ps.setString(3,start);
ps.setString(4,end);
ps.setString(5,budget);
ps.setString(6,desc);

ps.executeUpdate();

response.sendRedirect("explore.jsp");
%>