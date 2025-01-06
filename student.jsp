<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<html>
<head>
    <title>Student Achievements</title>
    <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-image: url('https://images.shiksha.com/mediadata/images/1495696344php7XB8ir.png');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
        margin: 0;
        padding: 0;
        color: #333;
    }
    .container {
        width: 80%;
        max-width: 800px; /* Limit max width for better readability */
        margin: 20px auto;
        background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent background */
        padding: 20px;
        border-radius: 10px; /* Rounded corners */
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* Softer shadow */
    }

    h2, h3 {
        text-align: center;
        color: #333;
    }
    .form-group {
        margin-bottom: 15px;
    }

    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #555;
    }

    .form-group input, .form-group select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        transition: border-color 0.3s; /* Transition for border color */
    }

    .form-group input:focus, .form-group select:focus {
        border-color: #007BFF; /* Blue border on focus */
        outline: none; /* Remove default outline */
    }

                    .form-group input[type="submit"] {
    background-color: #333; /* Dark background */
    color: white; /* White text */
    border: 2px solid #007bff; /* Keep the blue border if desired */
    cursor: pointer;
    font-size: 18px;
    border-radius: 5px; /* Rounded corners */
    padding: 10px 20px; /* Padding for better look */
    transition: background-color 0.3s, color 0.3s, transform 0.3s;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
}

.form-group input[type="submit"]:hover {
    background-color: #555; /* Lighter shade on hover */
}                    /* Unique styles for each form's submit button */
    input[name="addAchievement"] {
        background-color:#fd7e14; /* Green */
    }
    input[name="addAchievement"]:hover {
        background-color:#e4600f;
    }

    input[name="addCodingAchievement"] {
        background-color: #fd7e14/* Blue */
    }
    input[name="addCodingAchievement"]:hover {
        background-color: #e4600f;
    }

    input[name="addInternship"] {
        background-color:#fd7e14 /* Yellow */
    }
    input[name="addInternship"]:hover {
        background-color: #e4600f;
    }

    input[name="addNPTEL"] {
        background-color: #fd7e14 /* Cyan */
    }
    input[name="addNPTEL"]:hover {
        background-color: #e4600f;
    }

    input[name="addNonTechnical"] {
        background-color: #fd7e14; /* Orange */
    }
    input[name="addNonTechnical"]:hover {
        background-color: #e4600f;
    }

    /* Add subtle scaling effect on hover */
    input[type="submit"]:hover {
        transform: translateY(-3px); /* Lift the button slightly */
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }

    table, th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #f4f4f4;
    }

    /* Responsive Design */
    @media (max-width: 600px) {
        .container {
            width: 95%; /* Full width on small screens */
        }
        .form-group input, .form-group select {
            font-size: 14px; /* Smaller text on mobile */
        }
        .form-group input[type="submit"] {
            font-size: 16px; /* Smaller button text */
        }
    }

    /* Logout link styling */
    .logout-link {
        text-align: right;
        margin-bottom: 20px;
    }
    .logout-link a {
        color: #007BFF;
        text-decoration: none;
        font-weight: bold;
    }
    .logout-link a:hover {
        text-decoration: underline;
    }
</style>

</head>
<body>
    <div class="container">
        
        <!-- Logout Link -->
    <div class="logout-link">
        <a href="logout.jsp">Logout</a>
    </div>  
        
        
        
        <h2>Your Achievements</h2>

        <!-- Form to add new achievement -->
        <form method="post" action="student.jsp">
    <h3>General Achievements</h3>
    <table>
        <tr>
            <td><label for="eventName">Event Name:</label></td>
            <td><input type="text" id="eventName" name="eventName" required></td>
        </tr>
        <tr>
            <td><label for="eventDate">Event Date (YYYY-MM-DD):</label></td>
            <td><input type="date" id="eventDate" name="eventDate" required></td>
        </tr>
        <tr>
            <td><label for="participationOrWinner">Status:</label></td>
            <td>
                <select id="participationOrWinner" name="participationOrWinner" required>
                    <option value="Participation">Participation</option>
                    <option value="Winner">Winner</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="certificateLink">Certificate Link:</label></td>
            <td><input type="text" id="certificateLink" name="certificateLink"></td>
        </tr>
        <tr>
            <td><label for="cashPrize">Cash Prize:</label></td>
            <td><input type="number" id="cashPrize" name="cashPrize"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" name="addAchievement" value="Add Achievement"></td>
        </tr>
    </table>
</form>

        
        
        <!-- Form to add coding achievement -->
       <form method="post" action="student.jsp">
    <h3>Coding Achievements</h3>
    <table>
        <tr>
            <td><label for="platform">Platform:</label></td>
            <td><input type="text" id="platform" name="platform" required></td>
        </tr>
        <tr>
            <td><label for="medal">Medal:</label></td>
            <td><input type="text" id="medal" name="medal"></td>
        </tr>
        <tr>
            <td><label for="rank">Rank:</label></td>
            <td><input type="text" id="rank" name="rank"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" name="addCodingAchievement" value="Add Coding Achievement"></td>
        </tr>
    </table>
</form>


        
        
        <%-- Form to add internship completion --%>
       <form method="post" action="student.jsp">
    <h3>Internship Completion</h3>
    <table>
        <tr>
            <td><label for="internName">Internship Name:</label></td>
            <td><input type="text" id="internName" name="internName" required></td>
        </tr>
        <tr>
            <td><label for="duration">Duration:</label></td>
            <td><input type="text" id="duration" name="duration" required></td>
        </tr>
        <tr>
            <td><label for="internCertificateLink">Certificate Link:</label></td>
            <td><input type="text" id="internCertificateLink" name="internCertificateLink"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" name="addInternship" value="Add Internship"></td>
        </tr>
    </table>
</form>


        
        
        <%-- Form to add NPTEL course --%>
       <form method="post" action="student.jsp">
    <h3>NPTEL Courses</h3>
    <table>
        <tr>
            <td><label for="courseName">Course Name:</label></td>
            <td><input type="text" id="courseName" name="courseName" required></td>
        </tr>
        <tr>
            <td><label for="courseDuration">Duration:</label></td>
            <td><input type="text" id="courseDuration" name="courseDuration" required></td>
        </tr>
        <tr>
            <td><label for="remark">Remark:</label></td>
            <td><input type="text" id="remark" name="remark"></td>
        </tr>
        <tr>
            <td><label for="nptelCertificateLink">Certificate Link:</label></td>
            <td><input type="text" id="nptelCertificateLink" name="nptelCertificateLink"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" name="addNPTEL" value="Add NPTEL Course"></td>
        </tr>
    </table>
</form>

        
        
        <%-- Form to add non-technical achievement --%>
        <form method="post" action="student.jsp">
    <h3>Non-Technical Achievements</h3>
    <table>
        <tr>
            <td><label for="competitionName">Competition Name:</label></td>
            <td><input type="text" id="competitionName" name="competitionName" required></td>
        </tr>
        <tr>
            <td><label for="competitionStatus">Status:</label></td>
            <td>
                <select id="competitionStatus" name="competitionStatus" required>
                    <option value="Participation">Participation</option>
                    <option value="Winner">Winner</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" name="addNonTechnical" value="Add Non-Technical Achievement"></td>
        </tr>
    </table>
</form>


        
        

        <%
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect("login.jsp");
            }

            // Handle form submission to add achievement
            if (request.getParameter("addAchievement") != null) {
                String eventName = request.getParameter("eventName");
                String eventDate = request.getParameter("eventDate");
                String participationOrWinner = request.getParameter("participationOrWinner");
                String certificateLink = request.getParameter("certificateLink");
                String cashPrize = request.getParameter("cashPrize");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO achievements (username, event_name, event_date, status, certificate_link, cash_prize) VALUES (?, ?, ?, ?, ?, ?)");
                    ps.setString(1, username);  // Associate achievement with logged-in student
                    ps.setString(2, eventName);
                    ps.setString(3, eventDate);
                    ps.setString(4, participationOrWinner);
                    ps.setString(5, certificateLink);
                    ps.setString(6, cashPrize);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p>Achievement added successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }

            
             // Handle form submission to add coding achievement
            if (request.getParameter("addCodingAchievement") != null) {
                String platform = request.getParameter("platform");
                String medal = request.getParameter("medal");
                String rank = request.getParameter("rank");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO coding_achievements (username, platform, medal, rank) VALUES (?, ?, ?, ?)");
                    ps.setString(1, username);
                    ps.setString(2, platform);
                    ps.setString(3, medal);
                    ps.setString(4, rank);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p style='color: green;'>Coding achievement added successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                }
            }

            
              // Handle form submission to add internship completion
            if (request.getParameter("addInternship") != null) {
                String internName = request.getParameter("internName");
                String duration = request.getParameter("duration");
                String internCertificateLink = request.getParameter("internCertificateLink");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO internships (username, intern_name, duration, certificate_link) VALUES (?, ?, ?, ?)");
                    ps.setString(1, username);
                    ps.setString(2, internName);
                    ps.setString(3, duration);
                    ps.setString(4, internCertificateLink);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p style='color: green;'>Internship added successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                }
            }

             // Handle form submission to add NPTEL course
            if (request.getParameter("addNPTEL") != null) {
                String courseName = request.getParameter("courseName");
                String courseDuration = request.getParameter("courseDuration");
                String remark = request.getParameter("remark");
                String nptelCertificateLink = request.getParameter("nptelCertificateLink");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO nptel_courses (username, course_name, duration, remark, certificate_link) VALUES (?, ?, ?, ?, ?)");
                    ps.setString(1, username);
                    ps.setString(2, courseName);
                    ps.setString(3, courseDuration);
                    ps.setString(4, remark);
                    ps.setString(5, nptelCertificateLink);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p style='color: green;'>NPTEL course added successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                }
            }

            // Handle form submission to add non-technical achievement
            if (request.getParameter("addNonTechnical") != null) {
                String competitionName = request.getParameter("competitionName");
                String competitionStatus = request.getParameter("competitionStatus");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO non_technical_achievements (username, competition_name, status) VALUES (?, ?, ?)");
                    ps.setString(1, username);
                    ps.setString(2, competitionName);
                    ps.setString(3, competitionStatus);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p style='color: green;'>Non-technical achievement added successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                }
            }


            
            // Handle deletion of achievement
            if (request.getParameter("deleteAchievement") != null) {
                String eventNameToDelete = request.getParameter("deleteAchievement");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("DELETE FROM achievements WHERE username = ? AND event_name = ?");
                    ps.setString(1, username);  // Ensure only the student's own achievements are deleted
                    ps.setString(2, eventNameToDelete);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p>Achievement deleted successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
            
            if (request.getParameter("deleteCodingAchievement") != null) {
                String platformToDelete = request.getParameter("deleteCodingAchievement");

                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("DELETE FROM coding_achievements WHERE username = ? AND platform = ?");
                    ps.setString(1, username);  // Ensure only the student's own achievements are deleted
                    ps.setString(2, platformToDelete);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<p>Coding achievement deleted successfully!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }

            // Handle deletion of internship
    if (request.getParameter("deleteInternship") != null) {
        String internNameToDelete = request.getParameter("deleteInternship");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM internships WHERE username = ? AND intern_name = ?");
            ps.setString(1, username);
            ps.setString(2, internNameToDelete);

            int result = ps.executeUpdate();
            if (result > 0) {
                out.println("<p>Internship deleted successfully!</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }

    // Handle deletion of NPTEL course
    if (request.getParameter("deleteNPTEL") != null) {
        String courseNameToDelete = request.getParameter("deleteNPTEL");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM nptel_courses WHERE username = ? AND course_name = ?");
            ps.setString(1, username);
            ps.setString(2, courseNameToDelete);

            int result = ps.executeUpdate();
            if (result > 0) {
                out.println("<p>NPTEL course deleted successfully!</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }

    // Handle deletion of non-technical achievement
    if (request.getParameter("deleteNonTechnical") != null) {
        String competitionNameToDelete = request.getParameter("deleteNonTechnical");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("DELETE FROM non_technical_achievements WHERE username = ? AND competition_name = ?");
            ps.setString(1, username);
            ps.setString(2, competitionNameToDelete);

            int result = ps.executeUpdate();
            if (result > 0) {
                out.println("<p>Non-technical achievement deleted successfully!</p>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
            // Display only the logged-in student's achievements
            try {
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM achievements WHERE username = ?");
                ps.setString(1, username);  // Filter achievements by logged-in student

                ResultSet rs = ps.executeQuery();
                out.println("<h3>Your General  Achievements</h3>");
                out.println("<table>");
                out.println("<tr><th>Event Name</th><th>Event Date</th><th>Status</th><th>Certificate Link</th><th>Cash Prize</th><th>Action</th></tr>");

                while (rs.next()) {
                    String eventName = rs.getString("event_name");
                    String eventDate = rs.getString("event_date");
                    String status = rs.getString("status");
                    String certificateLink = rs.getString("certificate_link");
                    String cashPrize = rs.getString("cash_prize");

                    out.println("<tr>");
                    out.println("<td>" + eventName + "</td>");
                    out.println("<td>" + eventDate + "</td>");
                    out.println("<td>" + status + "</td>");
                    out.println("<td><a href='" + certificateLink + "' target='_blank'>" + certificateLink + "</a></td>");
                    out.println("<td>" + cashPrize + "</td>");
                    out.println("<td><form method='post' action='student.jsp'><input type='hidden' name='deleteAchievement' value='" + eventName + "'><input type='submit' value='Delete'></form></td>");
                    out.println("</tr>");
                }

                out.println("</table>");
                conn.close();
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
            // Display only the logged-in student's coding achievements
try {
    Connection conn = DBConnection.getConnection();
    PreparedStatement psCoding = conn.prepareStatement("SELECT * FROM coding_achievements WHERE username = ?");
    psCoding.setString(1, username);  // Filter coding achievements by logged-in student

    ResultSet rsCoding = psCoding.executeQuery();

    out.println("<h3>Your Coding Achievements</h3>");
    out.println("<table>");
    out.println("<tr><th>Platform</th><th>Medal</th><th>Rank</th><th>Action</th></tr>");

    while (rsCoding.next()) {
        String codingPlatform = rsCoding.getString("platform");
        String codingMedal = rsCoding.getString("medal");
        String codingRank = rsCoding.getString("rank");

        out.println("<tr>");
        out.println("<td>" + codingPlatform + "</td>");
        out.println("<td>" + codingMedal + "</td>");
        out.println("<td>" + codingRank + "</td>");
        out.println("<td><form method='post' action='student.jsp'><input type='hidden' name='deleteCodingAchievement' value='" + codingPlatform + "'><input type='submit' value='Delete'></form></td>");
        out.println("</tr>");
    }
    out.println("</table>");
    conn.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
// Display only the logged-in student's internships
try {
    Connection conn = DBConnection.getConnection();
    PreparedStatement psInternships = conn.prepareStatement("SELECT * FROM internships WHERE username = ?");
    psInternships.setString(1, username);  // Filter internships by logged-in student

    ResultSet rsInternships = psInternships.executeQuery();

    out.println("<h3>Your Internships</h3>");
    out.println("<table>");
    out.println("<tr><th>Intern Name</th><th>Duration</th><th>Certificate Link</th><th>Action</th></tr>");

    while (rsInternships.next()) {
        String internName = rsInternships.getString("intern_name");
        String duration = rsInternships.getString("duration");
        String internCertificateLink = rsInternships.getString("certificate_link");

        out.println("<tr>");
        out.println("<td>" + internName + "</td>");
        out.println("<td>" + duration + "</td>");
        out.println("<td><a href='" + internCertificateLink + "' target='_blank'>" + internCertificateLink + "</a></td>");
        out.println("<td><form method='post' action='student.jsp'><input type='hidden' name='deleteInternship' value='" + internName + "'><input type='submit' value='Delete'></form></td>");
        out.println("</tr>");
    }
    out.println("</table>");
    conn.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
// Display only the logged-in student's NPTEL courses
try {
    Connection conn = DBConnection.getConnection();
    PreparedStatement psNPTEL = conn.prepareStatement("SELECT * FROM nptel_courses WHERE username = ?");
    psNPTEL.setString(1, username);  // Filter NPTEL courses by logged-in student

    ResultSet rsNPTEL = psNPTEL.executeQuery();

    out.println("<h3>Your NPTEL Courses</h3>");
    out.println("<table>");
    out.println("<tr><th>Course Name</th><th>Duration</th><th>Remark</th><th>Certificate Link</th><th>Action</th></tr>");

    while (rsNPTEL.next()) {
        String courseName = rsNPTEL.getString("course_name");
        String courseDuration = rsNPTEL.getString("duration");
        String remark = rsNPTEL.getString("remark");
        String nptelCertificateLink = rsNPTEL.getString("certificate_link");

        out.println("<tr>");
        out.println("<td>" + courseName + "</td>");
        out.println("<td>" + courseDuration + "</td>");
        out.println("<td>" + remark + "</td>");
        out.println("<td><a href='" + nptelCertificateLink + "' target='_blank'>" + nptelCertificateLink + "</a></td>");
        out.println("<td><form method='post' action='student.jsp'><input type='hidden' name='deleteNPTEL' value='" + courseName + "'><input type='submit' value='Delete'></form></td>");
        out.println("</tr>");
    }
    out.println("</table>");
    conn.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
// Display only the logged-in student's non-technical achievements
try {
    Connection conn = DBConnection.getConnection();
    PreparedStatement psNonTechnical = conn.prepareStatement("SELECT * FROM non_technical_achievements WHERE username = ?");
    psNonTechnical.setString(1, username);  // Filter non-technical achievements by logged-in student

    ResultSet rsNonTechnical = psNonTechnical.executeQuery();

    out.println("<h3>Your Non-Technical Achievements</h3>");
    out.println("<table>");
    out.println("<tr><th>Competition Name</th><th>Status</th><th>Action</th></tr>");

    while (rsNonTechnical.next()) {
        String competitionName = rsNonTechnical.getString("competition_name");
        String competitionStatus = rsNonTechnical.getString("status");

        out.println("<tr>");
        out.println("<td>" + competitionName + "</td>");
        out.println("<td>" + competitionStatus + "</td>");
        out.println("<td><form method='post' action='student.jsp'><input type='hidden' name='deleteNonTechnical' value='" + competitionName + "'><input type='submit' value='Delete'></form></td>");
        out.println("</tr>");
    }
    out.println("</table>");
    conn.close();
} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}

        %>
    </div>
</body>
</html>