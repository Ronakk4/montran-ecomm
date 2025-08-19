<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile | Ecommerce</title>

    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .profile-container { max-width: 900px; margin: 50px auto; padding: 20px; }
        .profile-card { display: flex; flex-wrap: wrap; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .profile-photo { flex: 1 1 200px; text-align: center; }
        .profile-photo img { width: 150px; height: 150px; border-radius: 50%; object-fit: cover; }
        .profile-details { flex: 2 1 400px; padding: 20px; }
        .profile-details h2 { margin: 0; margin-bottom: 10px; }
        .profile-actions { margin-top: 20px; }
        .profile-actions a { margin-right: 10px; }
        .orders { margin-top: 40px; }
        .orders h3 { margin-bottom: 20px; }
        .order-card { display: flex; justify-content: space-between; background: #f9f9f9; padding: 15px; border-radius: 8px; margin-bottom: 15px; }
        .order-card span { font-weight: 500; }
    </style>
</head>

<body>
    <header class="l-header">
        <nav class="nav bd-grid">
            <a href="<%= request.getContextPath() %>" class="nav-logo">Ecommerce</a>
            <div class="nav-menu" id="nav-menu">
                <ul class="nav-list">
                    <li class="nav-item"><a href="<%= request.getContextPath() %>" class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="#orders" class="nav-link">Orders</a></li>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/app/logout" class="nav-link">Logout</a></li>
                </ul>
            </div>
        </nav>
    </header>

    <main class="profile-container">
        <div class="profile-card">
            <div class="profile-photo">
                <img src="https://i.postimg.cc/Kv2cV0vK/default-profile.png" alt="User Photo" id="profileImage">
                <input type="file" id="uploadPhoto" style="display:none;" accept="image/*">
                <br>
                <button class="button-light" onclick="document.getElementById('uploadPhoto').click()">Change Photo</button>
            </div>
            <div class="profile-details">
                <h2 id="userName">John Doe</h2>
                <p>Email: <span id="userEmail">john.doe@example.com</span></p>
                <p>Member since: <span id="memberSince">Jan 2023</span></p>

                <div class="profile-actions">
                    <a href="#" class="button">Edit Profile</a>
                    <a href="#" class="button-light">Change Password</a>
                </div>
            </div>
        </div>

        <div class="orders" id="orders">
            <h3>My Orders</h3>
            <div class="order-card">
                <span>Order #12345</span>
                <span>Delivered</span>
                <span>$149.99</span>
            </div>
            <div class="order-card">
                <span>Order #12346</span>
                <span>Processing</span>
                <span>$79.99</span>
            </div>
            <div class="order-card">
                <span>Order #12347</span>
                <span>Shipped</span>
                <span>$199.99</span>
            </div>
        </div>
    </main>

    <script>
        // Preview uploaded profile photo
        document.getElementById("uploadPhoto").addEventListener("change", function(event){
            const reader = new FileReader();
            reader.onload = function(){
                document.getElementById("profileImage").src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        });
    </script>
</body>
</html>
