<%@ page import="java.sql.*" %>

<%
String user = (String)session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.html");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - TravelBuddy</title>

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

.section{
padding:50px;
text-align:center;
}

.actions{
display:flex;
justify-content:center;
gap:20px;
margin-top:20px;
}

.actions button{
background:#1e3a8a;
color:white;
border:none;
padding:12px 20px;
border-radius:5px;
cursor:pointer;
}

.actions button:hover{
background:#142a63;
}

.cards{
display:flex;
justify-content:center;
flex-wrap:wrap;
gap:25px;
margin-top:30px;
}

.card{
background:white;
width:250px;
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
padding:20px;
}

.card h3{
margin-top:0;
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

<!-- NAVBAR -->
<div class="navbar">

<div class="logo"> TravelBuddy</div>

<div style="color:white;">
Welcome, <%= user %> 👋
</div>

<div class="nav-links">
<a href="index.jsp">Home</a>
<a href="explore.jsp">Explore</a>
<a href="create.html">Create Trip</a>
<a href="profile.html">Profile</a>
</div>

</div>

<!-- ACTION SECTION -->
<div class="section">

<h2>Welcome Traveler</h2>
<p>Plan your next adventure and connect with fellow travelers.</p>

<div class="actions">

<a href="explore.jsp">
<button>Explore Trips</button>
</a>

<a href="create.html">
<button>Create Trip</button>
</a>

<a href="profile.html">
<button>My Profile</button>
</a>

</div>

</div>

<!-- YOUR JOINED TRIPS (DYNAMIC) -->
<div class="section">

<h2>Your Trips</h2>

<div class="cards">

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","YOUR_PASSWORD");

PreparedStatement ps = con.prepareStatement(
"SELECT t.destination, t.description FROM trips t JOIN joined_trips j ON t.id = j.trip_id WHERE j.user_email=?");

ps.setString(1,user);

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<div class="card">
<h3><%= rs.getString("destination") %></h3>
<p><%= rs.getString("description") %></p>
</div>

<%
}
%>

</div>

</div>

<!-- CREATED TRIPS (STATIC for now) -->
<div class="section">

<h2>Trips You Created</h2>

<div class="cards">

<div class="card">
<h3>Kerala Nature Trip</h3>
<p>4 Travelers Joined</p>
<button>Manage Trip</button>
</div>

</div>

</div>

<!-- FOOTER -->
<div class="footer">

<p>TravelBuddy - Making group travel easy and fun.</p>

<p>
<a href="index.jsp">About</a> |
<a href="index.jsp">Contact</a> |
<a href="index.jsp">FAQ</a> |
<a href="index.jsp">Safety</a>
</p>

<p> TravelBuddy</p>

</div>

</body>
</html>
