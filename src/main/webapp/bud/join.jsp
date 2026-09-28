<%@ page import="java.sql.*" %>

<%
String user = (String)session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.html");
}

String tripId = request.getParameter("trip_id");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","123456");

PreparedStatement ps = con.prepareStatement(
"insert into joined_trips(user_email, trip_id) values(?,?)");

ps.setString(1,user);
ps.setInt(2,Integer.parseInt(tripId));

ps.executeUpdate();

response.sendRedirect("profile.jsp");
%>