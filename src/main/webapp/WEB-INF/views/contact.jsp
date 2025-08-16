<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Contact Us</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Contact Us</h2>
<form id="contactForm">
    <div class="mb-3">
        <label>Name</label>
        <input type="text" id="name" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Email</label>
        <input type="email" id="email" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Message</label>
        <textarea id="message" class="form-control" required></textarea>
    </div>
    <button type="submit" class="btn btn-primary">Send</button>
</form>

<script>
    $('#contactForm').submit(function(e){
        e.preventDefault();
        $.ajax({
            url: '/ecomm.capstone/contact',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                name: $('#name').val(),
                email: $('#email').val(),
                message: $('#message').val()
            }),
            success: function(){
                alert('Message sent successfully!');
                $('#contactForm')[0].reset();
            }
        });
    });
</script>
</body>
</html>
