<%@ page import="java.sql.*" %>
<%
String user = (String)session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.html");
    return;
}

String tripIdStr = request.getParameter("trip_id");
if (tripIdStr != null) {
    int tripId = Integer.parseInt(tripIdStr);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/travelbuddy","root","123456");

        // 1. Check if user is the creator
        PreparedStatement psCheck = con.prepareStatement("select user_email from trips where id=?");
        psCheck.setInt(1, tripId);
        ResultSet rsCheck = psCheck.executeQuery();
        if (rsCheck.next() && user.equals(rsCheck.getString("user_email"))) {
            // Cannot join your own trip
            response.sendRedirect("dashboard.jsp?msg=own_trip");
            return;
        }

        // 2. Check if already joined
        PreparedStatement psJoinCheck = con.prepareStatement("select * from joined_trips where user_email=? and trip_id=?");
        psJoinCheck.setString(1, user);
        psJoinCheck.setInt(2, tripId);
        ResultSet rsJoinCheck = psJoinCheck.executeQuery();
        if (rsJoinCheck.next()) {
            // Already joined
            response.sendRedirect("profile.jsp?msg=already_joined");
            return;
        }

        // 3. Insert and join
        PreparedStatement ps = con.prepareStatement("insert into joined_trips(user_email, trip_id) values(?,?)");
        ps.setString(1,user);
        ps.setInt(2,tripId);
        ps.executeUpdate();

        response.sendRedirect("profile.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("explore.jsp");
    }
}
%>