<%@ page import="java.io.*" %>
<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
