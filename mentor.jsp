<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<html>
<head>
    <title>Mentor Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXKhTnSF-DwL-ZYzeXQmYJG2a1vyUnvf2p4NfvIv_1-nFllGGkt4xswD4c4A&s');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            margin-top: 30px;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
            font-size: 32px;
            font-weight: bold;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.4);
        }

        .logout-link {
            text-align: right;
            margin-bottom: 20px;
        }

        .logout-link a {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 18px;
            text-decoration: none;
            font-weight: bold;
        }

        .logout-link a:hover {
            background-color: #0056b3; /* Darker blue on hover */
            text-decoration: none;
        }

        .student-header {
            margin-bottom: 15px;
            font-size: 24px;
            color: #333;
            font-weight: bold;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: black;
            font-weight: bold;
        }

        td a {
            color: #007bff;
            text-decoration: none;
        }

        td a:hover {
            text-decoration: underline;
        }

        .achievements-header {
            margin-top: 15px;
            font-size: 20px;
            color: #333;
            font-weight: bold;
        }

        .card {
            margin: 15px 0;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            color: #666;
            font-size: 14px;
        }

        .btn-success {
            margin-top: 20px;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>

</head>
<body>
    <div class="container">
        <h2>Welcome, Mentor</h2>

        <!-- Logout Link -->
        <div class="logout-link">
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <!-- Student Selection Form -->
        <form method="get" action="">
            <div class="form-group">
                <label for="studentSelect">Select a Student:</label>
                <select id="studentSelect" name="studentUsername" class="form-control" required>
                    <option value="">-- Select Student --</option>
                    <%
                        String mentorUsername = (String) session.getAttribute("username");

                        // Fetch students allocated to this mentor from 'users' table
                        try {
                            Connection conn = DBConnection.getConnection();
                            PreparedStatement psStudents = conn.prepareStatement("SELECT * FROM users WHERE mentor_name = ?", 
                                                   ResultSet.TYPE_SCROLL_INSENSITIVE, 
                                                   ResultSet.CONCUR_READ_ONLY);
                            psStudents.setString(1, mentorUsername);

                            ResultSet rsStudents = psStudents.executeQuery();

                            while (rsStudents.next()) {
                                String studentUsername = rsStudents.getString("username");
                                out.println("<option value='" + studentUsername + "'>" + studentUsername + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error fetching students</option>");
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">View Achievements</button>
        </form>

        <%
            String selectedStudentUsername = request.getParameter("studentUsername");
            if (selectedStudentUsername != null && !selectedStudentUsername.isEmpty()) {
                out.println("<div class='student-header'>Achievements for: " + selectedStudentUsername + "</div>");

                try {
                    Connection conn = DBConnection.getConnection();

                    // General Achievements
                    PreparedStatement psGeneral = conn.prepareStatement("SELECT * FROM achievements WHERE username = ?");
                    psGeneral.setString(1, selectedStudentUsername);
                    ResultSet rsGeneral = psGeneral.executeQuery();

                    out.println("<div class='card'><div class='card-body'>");
                    out.println("<h5 class='achievements-header'>General Achievements</h5>");
                    out.println("<table class='table table-striped'><thead><tr><th>Event Name</th><th>Event Date</th><th>Status</th><th>Certificate Link</th><th>Cash Prize</th></tr></thead><tbody>");

                    while (rsGeneral.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rsGeneral.getString("event_name") + "</td>");
                        out.println("<td>" + rsGeneral.getString("event_date") + "</td>");
                        out.println("<td>" + rsGeneral.getString("status") + "</td>");
                        out.println("<td><a href='" + rsGeneral.getString("certificate_link") + "' target='_blank'>" + rsGeneral.getString("certificate_link") + "</a></td>");
                        out.println("<td>" + rsGeneral.getString("cash_prize") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</tbody></table>");
                    out.println("</div></div>"); // Close card

                    // Coding Achievements
                    PreparedStatement psCoding = conn.prepareStatement("SELECT * FROM coding_achievements WHERE username = ?");
                    psCoding.setString(1, selectedStudentUsername);
                    ResultSet rsCoding = psCoding.executeQuery();

                    out.println("<div class='card'><div class='card-body'>");
                    out.println("<h5 class='achievements-header'>Coding Achievements</h5>");
                    out.println("<table class='table table-striped'><thead><tr><th>Platform</th><th>Medal</th><th>Rank</th></tr></thead><tbody>");

                    while (rsCoding.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rsCoding.getString("platform") + "</td>");
                        out.println("<td>" + rsCoding.getString("medal") + "</td>");
                        out.println("<td>" + rsCoding.getString("rank") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</tbody></table>");
                    out.println("</div></div>"); // Close card

                    // Internship Achievements
                    PreparedStatement psInternships = conn.prepareStatement("SELECT * FROM internships WHERE username = ?");
                    psInternships.setString(1, selectedStudentUsername);
                    ResultSet rsInternships = psInternships.executeQuery();

                    out.println("<div class='card'><div class='card-body'>");
                    out.println("<h5 class='achievements-header'>Internships</h5>");
                    out.println("<table class='table table-striped'><thead><tr><th>Intern Name</th><th>Duration</th><th>Certificate Link</th></tr></thead><tbody>");

                    while (rsInternships.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rsInternships.getString("intern_name") + "</td>");
                        out.println("<td>" + rsInternships.getString("duration") + "</td>");
                        out.println("<td><a href='" + rsInternships.getString("certificate_link") + "' target='_blank'>" + rsInternships.getString("certificate_link") + "</a></td>");
                        out.println("</tr>");
                    }
                    out.println("</tbody></table>");
                    out.println("</div></div>"); // Close card

                    // NPTEL Courses
                    PreparedStatement psNPTEL = conn.prepareStatement("SELECT * FROM nptel_courses WHERE username = ?");
                    psNPTEL.setString(1, selectedStudentUsername);
                    ResultSet rsNPTEL = psNPTEL.executeQuery();

                    out.println("<div class='card'><div class='card-body'>");
                    out.println("<h5 class='achievements-header'>NPTEL Courses</h5>");
                    out.println("<table class='table table-striped'><thead><tr><th>Course Name</th><th>Duration</th><th>Remark</th><th>Certificate Link</th></tr></thead><tbody>");

                    while (rsNPTEL.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rsNPTEL.getString("course_name") + "</td>");
                        out.println("<td>" + rsNPTEL.getString("duration") + "</td>");
                        out.println("<td>" + rsNPTEL.getString("remark") + "</td>");
                        out.println("<td><a href='" + rsNPTEL.getString("certificate_link") + "' target='_blank'>" + rsNPTEL.getString("certificate_link") + "</a></td>");
                        out.println("</tr>");
                    }
                    out.println("</tbody></table>");
                    out.println("</div></div>"); // Close card

                    out.println("<div class='download-link'>");
                    out.println("<a href='downloadAchievements.jsp?studentUsername=" + selectedStudentUsername + "' class='btn btn-success'><i class='fas fa-download'></i> Download Achievements</a>");
                    out.println("</div>");

                } catch (SQLException e) {
                    out.println("<p>Error retrieving achievements: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
