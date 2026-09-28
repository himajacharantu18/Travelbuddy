<%@ page import="java.sql.*" %>
<%
String search = request.getParameter("search");
String query = "select * from trips";
if (search != null && !search.trim().isEmpty()) {
    // using parameterized queries to be absolutely safe
    query = "select * from trips where destination like ?";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Explore Trips - TravelBuddy</title>
<style>
body{ margin:0; font-family:Arial; background:linear-gradient(to bottom,#fff5f2,#f0f4ff); }
.navbar{ background:#ff6b35; padding:15px 40px; display:flex; justify-content:space-between; align-items:center; }
.logo{ color:white; font-size:22px; font-weight:bold; }
.nav-links a{ color:white; text-decoration:none; margin-left:25px; font-weight:bold; }
.section{ max-width:1000px; margin:40px auto; }
.cards{ display:flex; flex-wrap:wrap; gap:20px; justify-content:flex-start; }
.card{ background:white; width:300px; border-radius:10px; overflow:hidden; box-shadow:0 4px 15px rgba(0,0,0,0.1); transition:0.3s; padding-bottom:15px; text-align:center; }
.card:hover{ transform:translateY(-8px); }
.card img{ width:100%; height:160px; object-fit:cover; }
.card h3{ margin:10px; color:#1e3a8a; }
.card p{ margin:5px 10px; color:gray; font-size:14px; }
.card button{ background:#1e3a8a; color:white; border:none; padding:10px 15px; border-radius:5px; cursor:pointer; margin-top:10px; width:90%; transition:0.3s; }
.card button:hover{ background:#142a63; }
.empty-state{ text-align:center; padding:60px 20px; width:100%; }
.empty-state h3{ color:#ff6b35; font-size:24px; }
.empty-state p{ font-size:16px; color:#555; }
.empty-cta{ display:inline-block; margin-top:20px; padding:12px 25px; background:#1e3a8a; color:white; text-decoration:none; border-radius:5px; font-weight:bold; }
</style>
</head>
<body>

<div class="navbar">
<div class="logo">🌍 TravelBuddy</div>
<div class="nav-links">
    <a href="index.jsp">Home</a>
    <a href="explore.jsp">Explore</a>
<% if (session.getAttribute("user") != null) { %>
    <a href="create_ui.jsp">Create Trip</a>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="profile.jsp">Profile</a>
    <a href="logout.jsp">Logout</a>
<% } else { %>
    <a href="login.html">Login</a>
    <a href="register.html">Register</a>
<% } %>
</div>
</div>

<div class="section">
    <h2 style="color:#1e3a8a;"><%= (search != null && !search.trim().isEmpty()) ? "Search Results for '" + search + "'" : "Explore All Trips" %></h2>
    <div class="cards">
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/travelbuddy","root","123456");
    PreparedStatement ps;
    if (search != null && !search.trim().isEmpty()) {
        ps = con.prepareStatement(query);
        ps.setString(1, "%" + search + "%");
    } else {
        ps = con.prepareStatement(query);
    }
    
    ResultSet rs = ps.executeQuery();
    boolean hasRows = false;
    
    while(rs.next()){
        hasRows = true;
        String destTop = rs.getString("destination");
        String safeImage = "images/" + destTop.toLowerCase().replaceAll("\\s+", "") + ".jpg";
%>
        <div class="card">
            <img src="<%= safeImage %>" onerror="this.src='images/default.jpeg'">
            <h3><%= destTop %></h3>
            <p><%= rs.getString("description") %></p>
            <p><strong>Dates:</strong> <%= rs.getString("start_date") %> to <%= rs.getString("end_date") %></p>
            <p style="font-size:12px; margin-top:10px;">Created by: <%= rs.getString("user_email") %></p>
            
            <a href="trip_details.jsp?id=<%= rs.getInt("id") %>">
                <button type="button">View Trip Details</button>
            </a>
        </div>
<%
    }
    
    if(!hasRows) {
%>
        <div class="empty-state">
            <h3>No trips found!</h3>
            <p>Seems like nobody has planned a trip here yet. Why don't you be the pioneer?</p>
            <a href="create_ui.jsp" class="empty-cta">Create a Trip</a>
        </div>
<%
    }
} catch (Exception e) {
    out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
}
%>
    </div>
</div>

</body>
</html>