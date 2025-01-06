<%@page import="java.sql.*"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    String query = request.getParameter("query");
    if (query == null) {
        out.print("[]"); // Return an empty array if no query
        return;
    }

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/mydatabase", "app", "app");
        String sql = "SELECT DISTINCT MENTOR_NAME FROM USERS WHERE ROLE = 'mentor' AND MENTOR_NAME LIKE ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, query + "%"); // Use wildcard for matching
        rs = pstmt.executeQuery();

        List<String> mentors = new ArrayList<>();
        while (rs.next()) {
            mentors.add(rs.getString("MENTOR_NAME"));
        }

        // Return the list of mentor names as JSON
        out.print(new Gson().toJson(mentors));
    } catch (SQLException e) {
        e.printStackTrace();
        out.print("[]"); // Return an empty array on error
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
