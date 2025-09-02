<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>Error - Capstone App</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .error-box { 
            border: 2px solid #cc0000; 
            padding: 20px; 
            border-radius: 10px; 
            background: #ffeeee; 
            max-width: 600px; 
        }
        h2 { color: #cc0000; }
        .home-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: green;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .home-button:hover {
            background-color: #990000;
        }
    </style>
</head>
<body>
<div class="error-box">
    <h2>Oops! Something went wrong.</h2>
    <p>Please go back and try again or contact support if the problem persists.</p>
    
    <!-- Button to go back to home -->
    <a class="home-button" href="http://localhost:8080/ecomm.capstone/">Go to Home Page</a>
</div>
</body>
</html>
