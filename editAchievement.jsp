<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Achievement</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Edit Achievement</h2>
        <%
            String id = request.getParameter("id");
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/mydatabase", "app", "app");
                String query = "SELECT * FROM ACHIEVEMENTS WHERE ID = " + id; // Adjust based on your table structure
                stmt = con.createStatement();
                rs = stmt.executeQuery(query);
                if (rs.next()) {
        %>
        <form method="post" action="updateAchievement.jsp">
            <input type="hidden" name="id" value="<%= id %>" />
            <!-- Add form fields for the achievement data -->
            <div class="mb-3">
                <label for="eventName" class="form-label">Event Name</label>
                <input type="text" class="form-control" name="eventName" value="<%= rs.getString("EVENT_NAME") %>" required>
            </div>
            <div class="mb-3">
                <label for="eventDate" class="form-label">Event Date</label>
                <input type="date" class="form-control" name="eventDate" value="<%= rs.getString("EVENT_DATE") %>" required>
            </div>
            <!-- Add other fields as necessary -->
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <%
                } else {
                    out.println("<p>No record found.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
