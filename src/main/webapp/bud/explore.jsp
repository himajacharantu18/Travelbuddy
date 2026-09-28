<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset ="UTF-8">
<title>Explore Trips - TravelBuddy</title>

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

.section h2{
color:#ff6b35;
}

.cards{
display:flex;
justify-content:center;
flex-wrap:wrap;
gap:25px;
padding:20px;
}

.card{
background:white;
width:260px;
border-radius:10px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
overflow:hidden;
}

.card img{
width:100%;
height:160px;
object-fit:cover;
}

.card h3{
margin:10px;
}

.card p{
margin:0 10px 10px;
color:gray;
}

.card button{
background:#1e3a8a;
color:white;
border:none;
padding:8px 15px;
border-radius:5px;
cursor:pointer;
margin-bottom:10px;
}
</style>
</head>

<body>

<div class="navbar">
<div class="logo">TravelBuddy</div>
<div class="nav-links">
<a href="index.html">Home</a>
<a href="explore.jsp">Explore</a>
<a href="create.html">Create Trip</a>
<a href="profile.jsp">Profile</a>
</div>
</div>

<div class="section">
<h2>Explore Trips</h2>
</div>

<div class="cards">

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/travelbuddy","root","123456");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select * from trips");

while(rs.next()){
%>

<div class="card">
<img src="images/default.jpeg">

<h3><%= rs.getString("destination") %></h3>

<p><%= rs.getString("description") %></p>

<p><b>By:</b> <%= rs.getString("user_email") %></p>

<form action="join.jsp" method="post">

<input type="hidden" name="trip_id" value="<%= rs.getInt("id") %>">

<button type="submit">Join Trip</button>

</form>
</div>

<%
}
%>

</div>

</body>
</html>