<%@ page import="java.sql.*" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","123456");

PreparedStatement ps = con.prepareStatement(
"select * from users where email=? and password=?");

ps.setString(1,email);
ps.setString(2,password);

ResultSet rs = ps.executeQuery();

if(rs.next()){
    session.setAttribute("user",email);
    response.sendRedirect("index.jsp");
}else{
    out.println("<h3>Invalid Login </h3>");
}
%>