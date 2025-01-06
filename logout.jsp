<%@ page session="true" %>
<%
    // Invalidate the session
    if (session != null) {
        session.invalidate();
    }
%>
<html>
<head>
    <title>Logging Out...</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .logout-container {
            background-color: #ffffff;
            padding: 20px 40px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

       

        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }

        p {
            font-size: 16px;
            color: #666;
        }

        .redirect-message {
            font-size: 14px;
            color: #888;
            margin-top: 20px;
        }

        .spinner {
            margin-top: 20px;
            border: 4px solid #f3f3f3;
            border-radius: 50%;
            border-top: 4px solid #007bff;
            width: 40px;
            height: 40px;
            -webkit-animation: spin 1s linear infinite;
            animation: spin 1s linear infinite;
        }

        @-webkit-keyframes spin {
            0% { -webkit-transform: rotate(0deg); }
            100% { -webkit-transform: rotate(360deg); }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="logout-container">
        <h2>You have been logged out</h2>
        <p>Thank you for visiting. You are now being redirected to the login page.</p>
        <div class="spinner"></div>
        <p class="redirect-message">Redirecting in a few seconds...</p>
    </div>

    <%
        // Redirect to the login page after 3 seconds
        response.setHeader("Refresh", "3; URL=login.jsp"); // Adjust the redirection URL as needed
    %>
</body>
</html>
