<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .header {
            background-color: #007bff;
            color: white;
            padding: 20px;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <header class="header text-center">
        <h1>Admin Dashboard</h1>
    </header>
    
    <div class="container mt-4">
        <form method="post" action="admin.jsp">
            <div class="form-group mb-3">
                <label for="viewType">Select Achievement Type:</label>
                <select name="viewType" class="form-select" id="viewType">
                    <option value="achievements">Achievements</option>
                    <option value="coding_achievements">Coding Achievements</option>
                    <option value="internships">Internships</option>
                    <option value="non_technical_achievements">Non-Technical Achievements</option>
                    <option value="nptel_courses">NPTEL Courses</option>
                </select>
            </div>
            <div class="form-group mb-3">
                <label for="filterType">Filter By:</label>
                <select name="filterType" class="form-select" id="filterType">
                    <option value="all_students">All Students</option>
                    <option value="mentor_wise">Mentor Wise</option>
                </select>
            </div>
           <div class="form-group mb-3" id="mentorDiv" style="display:none;">
    <label for="mentorFilter">Select Mentor:</label>
    <select id="mentorFilter" class="form-select" name="mentorFilter">
        <option value="">Select a mentor</option>
        <%
            Connection conMentors = null;
            Statement stmtMentors = null;
            ResultSet rsMentors = null;

            try {
                conMentors = DriverManager.getConnection("jdbc:derby://localhost:1527/mydatabase", "app", "app");
                String mentorQuery = "SELECT DISTINCT MENTOR_NAME FROM USERS WHERE MENTOR_NAME IS NOT NULL AND MENTOR_NAME <> ''"; // Adjusted query to exclude null or empty names
                stmtMentors = conMentors.createStatement();
                rsMentors = stmtMentors.executeQuery(mentorQuery);

                while (rsMentors.next()) {
                    String mentorName = rsMentors.getString("MENTOR_NAME");
                    // Only add to dropdown if mentorName is not null or empty
                    if (mentorName != null && !mentorName.trim().isEmpty()) {
                        out.println("<option value='" + mentorName + "'>" + mentorName + "</option>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try { if (rsMentors != null) rsMentors.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmtMentors != null) stmtMentors.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conMentors != null) conMentors.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </select>
</div>

            <button type="submit" class="btn btn-primary">View</button>
        </form>

        <hr>

        <%
            String viewType = request.getParameter("viewType");
            String filterType = request.getParameter("filterType");
            String mentorFilter = request.getParameter("mentorFilter");

            if (viewType != null && !viewType.isEmpty()) {
                Connection conAchievements = null;
                Statement stmtAchievements = null;
                ResultSet rs = null;

                try {
                    conAchievements = DriverManager.getConnection("jdbc:derby://localhost:1527/mydatabase", "app", "app");
                    String query = "";

                    if ("achievements".equals(viewType)) {
                        query = "SELECT * FROM ACHIEVEMENTS";
                    } else if ("coding_achievements".equals(viewType)) {
                        query = "SELECT * FROM CODING_ACHIEVEMENTS";
                    } else if ("internships".equals(viewType)) {
                        query = "SELECT * FROM INTERNSHIPS";
                    } else if ("non_technical_achievements".equals(viewType)) {
                        query = "SELECT * FROM NON_TECHNICAL_ACHIEVEMENTS";
                    } else if ("nptel_courses".equals(viewType)) {
                        query = "SELECT * FROM NPTEL_COURSES";
                    }

                    if ("mentor_wise".equals(filterType) && mentorFilter != null && !mentorFilter.isEmpty()) {
                        query += " WHERE USERNAME IN (SELECT USERNAME FROM USERS WHERE MENTOR_NAME = '" + mentorFilter + "')";
                    }

                    stmtAchievements = conAchievements.createStatement();
                    rs = stmtAchievements.executeQuery(query);
        %>
        
        <h3 class="text-center">
            <% 
                if ("mentor_wise".equals(filterType) && mentorFilter != null && !mentorFilter.isEmpty()) {
                    out.println("Viewing " + viewType.replace("_", " ") + " for Mentor: " + mentorFilter);
                } else {
                    out.println("Viewing All " + viewType.replace("_", " "));
                }
            %>
        </h3>
        
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th>Username</th>
                        <%
                            if ("achievements".equals(viewType)) {
                                out.println("<th>Event Name</th><th>Event Date</th><th>Status</th><th>Certificate Link</th><th>Cash Prize</th>");
                            } else if ("coding_achievements".equals(viewType)) {
                                out.println("<th>Platform</th><th>Medal</th><th>Rank</th>");
                            } else if ("internships".equals(viewType)) {
                                out.println("<th>Intern Name</th><th>Duration</th><th>Certificate Link</th>");
                            } else if ("non_technical_achievements".equals(viewType)) {
                                out.println("<th>Competition Name</th><th>Status</th>");
                            } else if ("nptel_courses".equals(viewType)) {
                                out.println("<th>Course Name</th><th>Duration</th><th>Remark</th><th>Certificate Link</th>");
                            }
                        %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("USERNAME") + "</td>");
                            
                            if ("achievements".equals(viewType)) {
                                out.println("<td>" + rs.getString("EVENT_NAME") + "</td>");
                                out.println("<td>" + rs.getString("EVENT_DATE") + "</td>");
                                out.println("<td>" + rs.getString("STATUS") + "</td>");
                                out.println("<td><a href='" + rs.getString("CERTIFICATE_LINK") + "' target='_blank'>View Certificate</a></td>");
                                out.println("<td>" + rs.getString("CASH_PRIZE") + "</td>");
                            } else if ("coding_achievements".equals(viewType)) {
                                out.println("<td>" + rs.getString("PLATFORM") + "</td>");
                                out.println("<td>" + rs.getString("MEDAL") + "</td>");
                                out.println("<td>" + rs.getString("RANK") + "</td>");
                            } else if ("internships".equals(viewType)) {
                                out.println("<td>" + rs.getString("INTERN_NAME") + "</td>");
                                out.println("<td>" + rs.getString("DURATION") + "</td>");
                                out.println("<td><a href='" + rs.getString("CERTIFICATE_LINK") + "' target='_blank'>View Certificate</a></td>");
                            } else if ("non_technical_achievements".equals(viewType)) {
                                out.println("<td>" + rs.getString("COMPETITION_NAME") + "</td>");
                                out.println("<td>" + rs.getString("STATUS") + "</td>");
                            } else if ("nptel_courses".equals(viewType)) {
                                out.println("<td>" + rs.getString("COURSE_NAME") + "</td>");
                                out.println("<td>" + rs.getString("DURATION") + "</td>");
                                out.println("<td>" + rs.getString("REMARK") + "</td>");
                                out.println("<td><a href='" + rs.getString("CERTIFICATE_LINK") + "' target='_blank'>View Certificate</a></td>");
                            }
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <%
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (stmtAchievements != null) stmtAchievements.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (conAchievements != null) conAchievements.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
        %>
    </div>

    <footer class="footer">
        <p>&copy; 2024 Admin Dashboard</p>
    </footer>
    
    <script>
        $(document).ready(function(){
            $('#filterType').change(function(){
                if ($(this).val() == 'mentor_wise') {
                    $('#mentorDiv').show();
                } else {
                    $('#mentorDiv').hide();
                }
            });
        });
    </script>
</body>
</html>