<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("username") == null || !"student".equalsIgnoreCase((String) session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
    }

    int achievementId = Integer.parseInt(request.getParameter("id"));

    try {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM achievements WHERE achievement_id=?");
        ps.setInt(1, achievementId);
        ps.executeUpdate();
        conn.close();
        response.sendRedirect("student.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
