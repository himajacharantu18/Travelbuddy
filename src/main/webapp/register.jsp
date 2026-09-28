<%@ page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

if (email != null && password != null) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/travelbuddy","root","123456");

        PreparedStatement ps = con.prepareStatement("insert into users(name,email,password) values(?,?,?)");
        ps.setString(1,name);
        ps.setString(2,email);
        ps.setString(3,password);
        ps.executeUpdate();
        
        session.setAttribute("user", email);
        response.sendRedirect("index.jsp");
    } catch (Exception e) {
        out.println("<h3>Error: User may already exist or database is unavailable.</h3>");
        out.println("<a href='register.html'>Try Again</a>");
        e.printStackTrace();
    }
} else {
    response.sendRedirect("register.html");
}
%>