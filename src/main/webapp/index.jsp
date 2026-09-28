<%@ page import="java.sql.*" %>

    <% String user=(String)session.getAttribute("user"); if(user==null){ response.sendRedirect("login.html"); } %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>TravelBuddy</title>


            <style>
                body {
                    margin: 0;
                    font-family: Arial, sans-serif;
                    background: linear-gradient(to bottom, #fff5f2, #f0f4ff);
                }

                .navbar {
                    background: #ff6b35;
                    padding: 15px 40px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .logo {
                    color: white;
                    font-size: 22px;
                    font-weight: bold;
                }

                .nav-links a {
                    color: white;
                    text-decoration: none;
                    margin-left: 25px;
                    font-weight: bold;
                }

                .nav-links a:hover {
                    text-decoration: underline;
                }


                .hero {
                    height: 450px;
                    background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url("images/hero.jpg");
                    background-size: cover;
                    background-position: center;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: center;
                    color: white;
                    text-align: center;
                }

                .hero h1 {
                    font-size: 45px;
                    margin-bottom: 10px;
                }

                .hero input {
                    padding: 10px;
                    margin: 5px;
                    border: none;
                    border-radius: 5px;
                }

                .hero button {
                    background: #1e3a8a;
                    color: white;
                    border: none;
                    padding: 10px 20px;
                    border-radius: 5px;
                    cursor: pointer;
                }

                .hero button:hover {
                    background: #142a63;
                }


                .section {
                    padding: 60px 20px;
                    text-align: center;
                }

                .section h2 {
                    color: #ff6b35;
                    margin-bottom: 30px;
                }


                .scroll-container {
                    display: flex;
                    overflow-x: auto;
                    gap: 20px;
                    padding: 20px;
                }

                .destination {
                    min-width: 220px;
                    background: white;
                    border-radius: 10px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    transition: 0.3s;
                    cursor: pointer;
                }

                .destination:hover {
                    transform: scale(1.05);
                }

                .destination img {
                    width: 100%;
                    height: 150px;
                    object-fit: cover;
                    border-radius: 10px 10px 0 0;
                }

                .destination h3 {
                    margin: 10px;
                }


                .cards {
                    display: flex;
                    justify-content: center;
                    flex-wrap: wrap;
                    gap: 25px;
                }

                .card {
                    background: white;
                    width: 260px;
                    border-radius: 10px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    transition: 0.3s;
                }

                .card:hover {
                    transform: translateY(-8px);
                }

                .card img {
                    width: 100%;
                    height: 160px;
                    object-fit: cover;
                }

                .card h3 {
                    margin: 10px;
                }

                .card p {
                    margin: 0 10px 10px;
                    color: gray;
                }

                .card button {
                    background: #1e3a8a;
                    color: white;
                    border: none;
                    padding: 8px 15px;
                    border-radius: 5px;
                    cursor: pointer;
                    margin-bottom: 10px;
                }

                .card button:hover {
                    background: #142a63;
                }

                .features {
                    display: flex;
                    justify-content: center;
                    flex-wrap: wrap;
                    gap: 30px;
                }

                .feature {
                    max-width: 200px;
                }


                .stats {
                    display: flex;
                    justify-content: center;
                    gap: 60px;
                }

                .stat h1 {
                    color: #ff6b35;
                    font-size: 40px;
                }


                .reviews {
                    display: flex;
                    justify-content: center;
                    flex-wrap: wrap;
                    gap: 25px;
                }

                .review-card {
                    background: white;
                    width: 250px;
                    padding: 20px;
                    border-radius: 12px;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    text-align: center;
                    transition: 0.3s;
                }

                .review-card:hover {
                    transform: translateY(-8px);
                }

                .review-card img {
                    width: 70px;
                    height: 70px;
                    border-radius: 50%;
                    margin-bottom: 10px;
                }


                .cta {
                    background: #ff6b35;
                    color: white;
                    padding: 40px;
                    text-align: center;
                }

                .cta button {
                    background: #1e3a8a;
                    color: white;
                    border: none;
                    padding: 12px 25px;
                    border-radius: 5px;
                    cursor: pointer;
                }

                .cta button:hover {
                    background: #142a63;
                }


                .footer {
                    background: #1e3a8a;
                    color: white;
                    padding: 40px;
                    text-align: center;
                }

                .footer a {
                    color: #ff6b35;
                    text-decoration: none;
                    margin: 0 10px;
                }
            </style>
        </head>

        <body>


            <div class="navbar">
                <div class="logo"> TravelBuddy</div>

                <div style="color:white;">
                    Welcome, <%= user %>
                </div>

                <div class="nav-links">
                    <a href="index.jsp">Home</a>
                    <a href="explore.jsp">Explore</a>
                    <% if (session.getAttribute("user") !=null) { %>
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


            <div class="hero">
                <h1>Find Your Perfect Travel Crew</h1>
                <p>Explore destinations and travel with amazing people</p>

                <input type="text" id="searchInput" placeholder="Destination">

                <button onclick="searchTrips()">Search Trips</button>
            </div>

            <script>
                function searchTrips() {
                    let destination = document.getElementById("searchInput").value;

                    if (destination.trim() === "") {
                        alert("Please enter a destination");
                        return;
                    }

                    window.location.href = "explore.jsp?search=" + destination;
                }
            </script>


            <div class="section">
                <h2>Popular Destinations</h2>

                <div class="scroll-container">
                    <% try { Class.forName("com.mysql.cj.jdbc.Driver"); Connection
                        conPop=DriverManager.getConnection("jdbc:mysql://localhost:3306/travelbuddy","root","123456");
                        Statement stPop=conPop.createStatement(); ResultSet rsPop=stPop.executeQuery("select
                        destination, count(*) as count from trips group by destination order by count desc limit 8");
                        boolean hasPop=false; while(rsPop.next()) { hasPop=true; String
                        destName=rsPop.getString("destination"); String imgPath="images/" +
                        destName.toLowerCase().replaceAll("\\s+", "" ) + ".jpg" ; %>
                        <a href="explore.jsp?search=<%= destName %>" style="text-decoration:none; color:black;">
                            <div class="destination">
                                <img src="<%= imgPath %>" onerror="this.src='images/default.jpeg'">
                                <h3>
                                    <%= destName %>
                                </h3>
                            </div>
                        </a>
                        <% } if(!hasPop){ out.println("<p style='padding:15px; color:#555;'>No trips currently planned! Be the first to add one.</p>");
                            }
                            } catch(Exception e) {}
                            %>
                </div>
            </div>


            <div class="section">
                <h2>Featured Trips</h2>

                <div class="cards">

                    <% Class.forName("com.mysql.cj.jdbc.Driver"); Connection
                        con=DriverManager.getConnection( "jdbc:mysql://localhost:3306/travelbuddy" ,"root","123456");
                        Statement st=con.createStatement(); ResultSet rs=st.executeQuery("select * from trips");
                        while(rs.next()){ %>

                        <div class="card">
                            <img src="images/default.jpeg" onerror="this.style.display='none'">
                            <h3>
                                <%= rs.getString("destination") %>
                            </h3>
                            <p>
                                <%= rs.getString("description") %>
                            </p>
                            <p style="margin: 0 10px; font-size:13px; color:#555;"><b>Budget:</b>
                                <%= rs.getString("budget") !=null ? rs.getString("budget") : "Standard" %>
                            </p>
                            <p style="margin: 5px 10px 15px; font-size:13px; color:#555;"><b>Dates:</b>
                                <%= rs.getString("start_date") %> to <%= rs.getString("end_date") %>
                            </p>

                            <a href="trip_details.jsp?id=<%= rs.getInt("id") %>">
                                <button type="button">View Trip Details</button>
                            </a>
                        </div>

                        <% } %>

                </div>
            </div>

            <div class="section">
                <h2>Why Choose TravelBuddy</h2>

                <div class="features">

                    <div class="feature">
                        <h3>Travel Companions</h3>
                        <p>Meet travelers with similar interests.</p>
                    </div>

                    <div class="feature">
                        <h3>Easy Planning</h3>
                        <p>Create and join trips easily.</p>
                    </div>

                    <div class="feature">
                        <h3>Trusted Community</h3>
                        <p>Connect with trusted travelers.</p>
                    </div>

                </div>

            </div>


            <div class="section">

                <h2>TravelBuddy Community</h2>

                <div class="stats">

                    <div class="stat">
                        <h1>500+</h1>
                        <p>Travelers</p>
                    </div>

                    <div class="stat">
                        <h1>120+</h1>
                        <p>Trips Created</p>
                    </div>

                    <div class="stat">
                        <h1>30+</h1>
                        <p>Destinations</p>
                    </div>

                </div>

            </div>

            <div class="section">
                <h2>Traveler Reviews</h2>

                <div class="reviews">

                    <div class="review-card">
                        <img src="images/riya.jpg">
                        <h3>Riya Sharma</h3>
                        <p>⭐⭐⭐⭐⭐</p>
                        <p>TravelBuddy helped me find amazing travel partners for my Manali trip!</p>
                    </div>

                    <div class="review-card">
                        <img src="images/arjun.jpg">
                        <h3>Arjun Mehta</h3>
                        <p>⭐⭐⭐⭐</p>
                        <p>I met great people and had an unforgettable Goa trip.</p>
                    </div>

                    <div class="review-card">
                        <img src="images/sara.jpg">
                        <h3>Sara Khan</h3>
                        <p>⭐⭐⭐⭐⭐</p>
                        <p>The platform makes group travel easy and fun.</p>
                    </div>

                </div>

            </div>

            <div class="cta">
                <h2>Ready to start your adventure?</h2>

                <a href="register.html">
                    <button>Create Your Trip</button>
                </a>

            </div>


            <div class="footer">

                <h2>TravelBuddy</h2>

                <p>Making group travel easy and fun.</p>

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