<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<html>
<head>
    <title>Sign Up Page</title>
    <style>
        /* General body and form container styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('https://i.ytimg.com/vi/y05CLRrEtLo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB0B3uMaHuqQHzDpnBsrZb7FxCebQ'); /* Replace with your image path */
            background-size: cover; /* Ensures the image covers the whole background */
            background-repeat: no-repeat; /* Prevents image repetition */
            background-position: center; /* Centers the background image */
            background-attachment: fixed; /* Ensures the image stays in place during scrolling */
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .signup-container {
            background-color: #f0f0f0; /* Light grey color */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333333;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            color: #555555;
            margin-bottom: 5px;
            font-weight: bold; /* Bold labels */
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #dddddd;
            font-size: 14px;
            color: #333333;
        }

        .form-group input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .form-group input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .success-message {
            color: green;
            font-size: 14px;
            margin-top: 10px;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Make the mentor field hidden initially */
        #mentor-group {
            display: none;
        }

        /* Mobile responsive styling */
        @media (max-width: 400px) {
            .signup-container {
                width: 100%;
                padding: 20px;
                box-sizing: border-box;
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
    <div class="signup-container">
        <h2>Sign Up</h2>
        <form method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>
            
            <div class="form-group">
                <label for="role">Login As:</label>
                <select id="role" name="role" required onchange="updateForm()">
                    <option value="">Select Login</option>
                    <option value="student">Student</option>
                    <option value="mentor">Mentor</option>
                </select>
            </div>

            <div class="form-group" id="mentor-group">
                <label for="mentor">Mentor Name:</label>
                <input type="text" id="mentor" name="mentor" placeholder="Enter mentor's name">
            </div>
            
            <div class="form-group">
                <input type="submit" value="Sign Up">
            </div>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String mentor = request.getParameter("mentor");

                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "INSERT INTO users (username, password, role, mentor_name) VALUES (?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, role);
                    ps.setString(4, mentor.isEmpty() ? null : mentor); // Null if mentor not provided for students
                    
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        out.println("<p class='success-message'>Sign Up successful! You can now <a href='login.jsp'>login</a>.</p>");
                    } else {
                        out.println("<p class='error-message'>Sign Up failed. Please try again.</p>");
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
