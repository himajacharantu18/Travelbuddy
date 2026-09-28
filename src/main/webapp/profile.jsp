<%@ page import="java.sql.*" %>

<%
String user = (String)session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.html");
}
%>
<%
String name = "";

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","123456");

PreparedStatement ps = con.prepareStatement(
"select name from users where email=?");

ps.setString(1,user);

ResultSet rsUser = ps.executeQuery();

if(rsUser.next()){
    name = rsUser.getString("name");
}
%>
<%
PreparedStatement ps2 = con.prepareStatement(
"select count(*) from joined_trips where user_email=?");

ps2.setString(1,user);

ResultSet rs2 = ps2.executeQuery();

int joinedCount = 0;

if(rs2.next()){
    joinedCount = rs2.getInt(1);
}
%>
<%
PreparedStatement ps3 = con.prepareStatement(
"select count(*) from trips where user_email=?");

ps3.setString(1,user);

ResultSet rs3 = ps3.executeQuery();

int createdCount = 0;

if(rs3.next()){
    createdCount = rs3.getInt(1);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset ="UTF-8">
<title>Profile - TravelBuddy</title>

<style>

body{
margin:0;
font-family:Arial;
background:linear-gradient(to bottom,#fff5f2,#f0f4ff);
}

.navbar{
background:#ff6b35;
padding:15px 40px;
display:flex;
justify-content:space-between;
align-items:center;
}

.logo{
color:white;
font-size:22px;
font-weight:bold;
}

.nav-links a{
color:white;
text-decoration:none;
margin-left:25px;
font-weight:bold;
}

.profile{
text-align:center;
padding:50px;
}

.profile img{
width:120px;
height:120px;
border-radius:50%;
}

.profile h2{
margin:10px 0;
color:#ff6b35;
}

.info{
max-width:400px;
margin:20px auto;
background:white;
padding:20px;
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

.section{
text-align:center;
padding:40px;
}

.cards{
display:flex;
justify-content:center;
gap:20px;
flex-wrap:wrap;
}

.card{
background:white;
padding:20px;
border-radius:10px;
width:220px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

.card button{
background:#1e3a8a;
color:white;
border:none;
padding:8px 15px;
border-radius:5px;
cursor:pointer;
}


.footer{
background:#1e3a8a;
color:white;
padding:30px;
text-align:center;
margin-top:50px;
}

.footer a{
color:#ff6b35;
text-decoration:none;
margin:0 10px;
}

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


<div class="profile">

<img src="images/profile.jpg">

<h2><%= name %></h2>

</div>

<div class="info">

<p><strong>Email:</strong> <%= user %></p>
<p><strong>Travel Style:</strong> Adventure</p>
<p><strong>Trips Joined:</strong> <%= joinedCount %></p>
<p><strong>Trips Created:</strong> <%= createdCount %></p>

</div>

<div class="section">
<h2>Trips Joined</h2>

<div class="cards">

<%
PreparedStatement psJoin = con.prepareStatement(
"SELECT t.* FROM trips t JOIN joined_trips j ON t.id = j.trip_id WHERE j.user_email=?");

psJoin.setString(1,user);

ResultSet rsJoin = psJoin.executeQuery();

while(rsJoin.next()){
%>

<div class="card">
<h3><%= rsJoin.getString("destination") %></h3>
<p><%= rsJoin.getString("start_date") %> to <%= rsJoin.getString("end_date") %></p>
<a href="explore.jsp">
<button>View Trip</button>
</a>
</div>

<%
}
%>

</div>
</div>

</div>


<div class="section">
<h2>Your Trips</h2>

<div class="cards">

<%
PreparedStatement psTrips = con.prepareStatement(
"select * from trips where user_email=?");

psTrips.setString(1,user);

ResultSet rsTrips = psTrips.executeQuery();

while(rsTrips.next()){
%>

<div class="card">
<h3><%= rsTrips.getString("destination") %></h3>
<p><%= rsTrips.getString("start_date") %> to <%= rsTrips.getString("end_date") %></p>
<button>Manage</button>
</div>

<%
}
%>

</div>
</div>

</div>

<div class="footer">

<p>TravelBuddy - Making group travel easy and fun.</p>

<p>
<a href="index.jsp">About</a> |
<a href="index.jsp">Contact</a> |
<a href="index.jsp">FAQ</a> |
<a href="index.jsp">Safety</a>
</p>

<p>TravelBuddy</p>

</div>

</body>
</html>
