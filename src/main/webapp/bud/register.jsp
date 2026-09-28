<%@ page import="java.sql.*" %>

<html>
<body>

<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","123456");

PreparedStatement ps = con.prepareStatement(
"insert into users(name,email,password) values(?,?,?)");

ps.setString(1,name);
ps.setString(2,email);
ps.setString(3,password);

ps.executeUpdate();
%>

<h2>Registration Successful </h2>

<a href="login.html">Click here to Login</a>

</body>
</html>