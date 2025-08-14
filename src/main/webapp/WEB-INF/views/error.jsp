<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
</head>
<body class="container mt-5 text-center">
    <h1 class="text-danger">Oops! Something went wrong.</h1>
    <p>${errorMessage}</p>
    <a href="index.jsp" class="btn btn-primary">Go to Home</a>
</body>
</html>
