<%@ page import="java.sql.*" %>
<%
String user = (String)session.getAttribute("user");
String tripIdStr = request.getParameter("id");
int tripId = 0;
if (tripIdStr != null) {
    tripId = Integer.parseInt(tripIdStr);
}

String destination = "";
String description = "";
String creator = "";
String startDate = "";
String endDate = "";
String budget = "";
String highlights = "";
String style = "";
int maxPeople = 0;
String location = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/travelbuddy","root","123456");
    PreparedStatement ps = con.prepareStatement("select * from trips where id=?");
    ps.setInt(1, tripId);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        destination = rs.getString("destination");
        description = rs.getString("description");
        creator = rs.getString("user_email");
        startDate = rs.getString("start_date");
        endDate = rs.getString("end_date");
        budget = rs.getString("budget");
        // For backwards compatibility if highlights column doesn't exist, we fall back gracefully
        try { highlights = rs.getString("highlights"); } catch(Exception e) {}
        try { style = rs.getString("style"); } catch(Exception e) {}
        try { maxPeople = rs.getInt("max_people"); } catch(Exception e) {}
        try { location = rs.getString("location"); } catch(Exception e) {}
    }
} catch (Exception e) {}

if (budget == null) budget = "Standard";
if (style == null) style = "Standard";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= destination %> - TravelBuddy</title>
<style>
body{ margin:0; font-family:Arial; background:linear-gradient(to bottom,#fff5f2,#f0f4ff); }
.navbar{ background:#ff6b35; padding:15px 40px; display:flex; justify-content:space-between; align-items:center; }
.logo{ color:white; font-size:22px; font-weight:bold; }
.nav-links a{ color:white; text-decoration:none; margin-left:25px; font-weight:bold; }
.container { max-width: 800px; margin: 40px auto; background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); overflow: hidden; }
.hero-img { width: 100%; height: 350px; object-fit: cover; }
.content { padding: 40px; }
.content h1 { margin-top: 0; color: #ff6b35; font-size: 32px; }
.creator-badge { display: inline-block; background: #ffe4cc; color: #ff6b35; padding: 5px 12px; border-radius: 20px; font-size: 14px; font-weight: bold; margin-bottom: 20px; }
.details-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; background: #f9f9f9; padding: 20px; border-radius: 8px; }
.detail-item strong { color: #1e3a8a; display: block; margin-bottom: 5px; }
.desc { line-height: 1.6; color: #444; margin-bottom: 40px; font-size: 16px; }
.join-btn { background: #1e3a8a; color: white; border: none; padding: 15px 30px; border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; width: 100%; transition: 0.3s; }
.join-btn:hover { background: #142a63; transform: scale(1.02); }
</style>
</head>
<body>

<div class="navbar">
<div class="logo">🌍 TravelBuddy</div>
<div class="nav-links">
    <a href="index.jsp">Home</a>
    <a href="explore.jsp">Explore</a>
<% if (user != null) { %>
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

<div class="container">
    <img src="images/default.jpeg" onerror="this.src='images/hero.jpg'" class="hero-img">
    <div class="content">
        <h1><%= destination %></h1>
        <div class="creator-badge">Hosted by: <%= creator %></div>
        
        <div class="details-grid">
            <div class="detail-item"><strong>Dates</strong> <%= startDate %> to <%= endDate %></div>
            <div class="detail-item"><strong>Budget</strong> <%= budget %></div>
            <div class="detail-item"><strong>Style</strong> <%= style %></div>
            <div class="detail-item"><strong>Meeting Point</strong> <%= location != null ? location : "TBA" %></div>
            <div class="detail-item"><strong>Group Size</strong> <%= maxPeople > 0 ? maxPeople : "Unlimited" %></div>
            <div class="detail-item"><strong>Highlights</strong> <%= highlights != null ? highlights : "Mystery Adventure!" %></div>
        </div>

        <h3>About this Trip</h3>
        <div class="desc"><%= description %></div>

        <form action="join.jsp" method="post">
            <input type="hidden" name="trip_id" value="<%= tripId %>">
            <button type="submit" class="join-btn">Book My Spot Now</button>
        </form>
    </div>
</div>

</body>
</html>
