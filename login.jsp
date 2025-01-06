<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<html>
<head>
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://i.ytimg.com/vi/y05CLRrEtLo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB0B3uMaHuqQHzDpnBsrZb7FxCebQ'); /* Replace with your image path */
            background-size: cover;
            background-position: center; /* Center the background image */
            background-repeat: no-repeat; /* Prevent repeating the image */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff; /* Change default text color to white for contrast */
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            background-color: rgba(255, 255, 255, 0.9); /* White background with transparency */
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            backdrop-filter: blur(10px); /* Blur effect for background */
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333; /* Dark text for heading */
            font-size: 24px; /* Larger font size for the heading */
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
            border: 2px solid #ccc; /* Border styling */
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s; /* Transition for border color on focus */
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #4CAF50; /* Change border color on focus */
            outline: none; /* Remove default outline */
        }

        .form-group input[type="submit"] {
            background-color: #0000FF;
            color: white;
            cursor: pointer;
            font-size: 18px;
            border: none;
            transition: background-color 0.3s; /* Transition for background color */
        }

        .form-group input[type="submit"]:hover {
            background-color: #45a049; /* Darker shade on hover */
        }

        .error-message {
            color: red;
            text-align: center;
        }

        /* Style for Sign Up text */
        .signup-text {
            color: black; /* Set "Don't have an account?" text to black */
        }

        .signup-link {
            color: #ff6600; /* Bright orange color for visibility */
            font-weight: bold;
        }

        .signup-link:hover {
            color: #ff4500; /* Darker shade of orange on hover */
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .login-container {
                width: 90%; /* Responsive width for smaller screens */
            }
        }
    </style>
    <script>
        function updateForm() {
            var roleSelect = document.getElementById("role");
            var mentorField = document.getElementById("mentor-group");
            mentorField.style.display = roleSelect.value === "student" ? "block" : "none";
        }

        function validateForm() {
            var role = document.getElementById("role").value;
            var mentor = document.getElementById("mentor").value;
            if (role === "student" && mentor.trim() === "") {
                alert("Please enter the mentor's name if you're a student.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body onload="updateForm()">
    <div class="login-container">
        <h2>Student Achievement Portal</h2>
        <form method="post" action="login.jsp" onsubmit="return validateForm()">
            <!-- Login form remains unchanged -->
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="role">Login As:</label>
                <select id="role" name="role" required onchange="updateForm()">
                    <option value="">Select Login</option>
                    <option value="student">Student </option>
                    <option value="mentor">Mentor </option>
                </select>
            </div>

            <div class="form-group" id="mentor-group" style="display:none;">
                <label for="mentor">Mentor Name:</label>
                <input type="text" id="mentor" name="mentor">
            </div>
            
            <div class="form-group">
                <input type="submit" value="Login">
            </div>
        </form>
        
        <!-- Add Sign Up option -->
        <div class="form-group">
            <p class="signup-text">Don't have an account? <a href="signup.jsp" class="signup-link">Sign Up</a></p>
        </div>

        <%
             if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String mentor = request.getParameter("mentor"); // Get mentor name from form

                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "SELECT * FROM users WHERE username=? AND password=? AND role=?";
                    if (role.equalsIgnoreCase("student") && mentor != null && !mentor.isEmpty()) {
                        sql += " AND mentor_name=?";
                    }
                    
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, role);
                    
                    // If student role and mentor provided, set mentor name
                    if (role.equalsIgnoreCase("student") && mentor != null && !mentor.isEmpty()) {
                        ps.setString(4, mentor);
                    }

                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);  // Store role in session
                        if ("student".equalsIgnoreCase(role)) {
                            response.sendRedirect("student.jsp");
                        } else if ("mentor".equalsIgnoreCase(role)) {
                            session.setAttribute("mentorID", username); // Set mentor ID in session
                            response.sendRedirect("mentor.jsp");
                        }
                    } else {
                        out.println("<p class='error-message'>Invalid login credentials or mentor not found!</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='error-message'>An error occurred: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
