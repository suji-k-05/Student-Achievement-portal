<%@ page import="java.sql.*, java.io.*, db.DBConnection" %>
<%@ page contentType="text/csv;charset=UTF-8" %>
<%@ page language="java" %>
<%
    // Get the username of the student whose achievements are to be downloaded
    String studentUsername = request.getParameter("studentUsername");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + studentUsername + "_achievements.csv\"");

    // Write CSV headers

    try {
        Connection conn = DBConnection.getConnection();

        // General Achievements
        out.println("General Achievements"); // Heading for General Achievements
        out.println("Event Name,Event Date,Status,Certificate Link,Cash Prize"); // Column headings
        PreparedStatement psGeneral = conn.prepareStatement("SELECT * FROM achievements WHERE username = ?");
        psGeneral.setString(1, studentUsername);
        ResultSet rsGeneral = psGeneral.executeQuery();

        // Iterate through General Achievements and write to CSV
        while (rsGeneral.next()) {
            String eventName = rsGeneral.getString("event_name");
            String status = rsGeneral.getString("status");
            String certificateLink = rsGeneral.getString("certificate_link");
            String cashPrize = rsGeneral.getString("cash_prize");

            out.println(eventName + ","  + "," + status + "," + certificateLink + "," + cashPrize);
        }
        out.println(); // Add a blank line for separation

        // Coding Achievements
        out.println("Coding Achievements"); // Heading for Coding Achievements
        out.println("Platform,Medal,Rank"); // Column headings
        PreparedStatement psCoding = conn.prepareStatement("SELECT * FROM coding_achievements WHERE username = ?");
        psCoding.setString(1, studentUsername);
        ResultSet rsCoding = psCoding.executeQuery();

        // Iterate through Coding Achievements and write to CSV
        while (rsCoding.next()) {
            String platform = rsCoding.getString("platform");
            String medal = rsCoding.getString("medal");
            String rank = rsCoding.getString("rank");

            out.println(platform + "," + medal + "," + rank);
        }
        out.println(); // Add a blank line for separation

        // Internship Achievements
        out.println("Internship Achievements"); // Heading for Internship Achievements
        out.println("Intern Name,Duration,Certificate Link"); // Column headings
        PreparedStatement psInternships = conn.prepareStatement("SELECT * FROM internships WHERE username = ?");
        psInternships.setString(1, studentUsername);
        ResultSet rsInternships = psInternships.executeQuery();

        // Iterate through Internship Achievements and write to CSV
        while (rsInternships.next()) {
            String internName = rsInternships.getString("intern_name");
            String duration = rsInternships.getString("duration");
            String certificateLink = rsInternships.getString("certificate_link");

            out.println(internName + "," + duration + "," + certificateLink);
        }
        out.println(); // Add a blank line for separation

        // NPTEL Courses
        out.println("NPTEL Courses"); // Heading for NPTEL Courses
        out.println("Course Name,Duration,Remark,Certificate Link"); // Column headings
        PreparedStatement psNPTEL = conn.prepareStatement("SELECT * FROM nptel_courses WHERE username = ?");
        psNPTEL.setString(1, studentUsername);
        ResultSet rsNPTEL = psNPTEL.executeQuery();

        // Iterate through NPTEL Courses and write to CSV
        while (rsNPTEL.next()) {
            String courseName = rsNPTEL.getString("course_name");
            String duration = rsNPTEL.getString("duration");
            String remark = rsNPTEL.getString("remark");
            String certificateLink = rsNPTEL.getString("certificate_link");

            out.println(courseName + "," + duration + "," + remark + "," + certificateLink);
        }

        // Close all resources
        rsGeneral.close();
        rsCoding.close();
        rsInternships.close();
        rsNPTEL.close();
        conn.close();

    } catch (SQLException e) {
        out.println("Error retrieving achievements: " + e.getMessage());
    }
%>
