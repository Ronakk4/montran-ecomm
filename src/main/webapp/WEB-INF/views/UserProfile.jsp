	<%@ page contentType="text/html;charset=UTF-8" %>
	<%@ page import="com.capstone.util.JwtUtil" %>
	<%@ page isELIgnored="false" %>
	
	<%
	    Cookie jwtToken = null;
	    if(request.getCookies() != null) {
	        for(Cookie c : request.getCookies()) {
	            if("jwtToken".equals(c.getName())) {
	                jwtToken = c;
	                break;
	            }
	        }
	    }
	    Long userId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
	%>
	
	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <title>User Profile</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	    <style>
	        body { background: #f5f5f5; font-family: 'Poppins', sans-serif; }
	        .profile-header {
	            background: linear-gradient(135deg,#667eea,#764ba2);
	            color: #fff;
	            text-align: center;
	            padding: 60px 20px 40px 20px;
	            border-radius: 0 0 50% 50% / 0 0 10% 10%;
	            position: relative;
	        }
	        .profile-header img {
	            width: 150px; height: 150px;
	            border-radius: 50%;
	            border: 5px solid #fff;
	            object-fit: cover;
	            margin-top: -80px;
	        }
	        .profile-header h1 { margin: 15px 0 5px 0; font-size: 2rem; }
	        .profile-header p { margin: 0; font-size: 1rem; }
	        .profile-card {
	            background: #fff; 
	            padding: 30px; 
	            border-radius: 15px; 
	            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
	            margin-top: 40px;
	        }
	        .profile-card button { margin: 10px 5px 0 5px; }
	        .edit-profile-modal .modal-header,
	        .change-password-modal .modal-header {
	            background: #764ba2;
	            color: #fff;
	        }
	    </style>
	    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
	</head>
	<body>
	
	    <!-- Profile Header -->
	    <div class="profile-header">
	        <img id="profileImage" src="https://i.postimg.cc/Kv2cV0vK/default-profile.png" alt="Profile Photo">
	        <h1 id="userName">Loading...</h1>
	        <p id="userEmail"></p>
	        <button class="btn btn-light btn-sm" onclick="$('#uploadPhoto').click()">Change Photo</button>
	        <input type="file" id="uploadPhoto" style="display:none" accept="image/*">
	    </div>
	
	    <!-- Profile Card -->
	    <div class="container">
	        <div class="profile-card text-center">
	            <h3>Profile Details</h3>
	            <p><strong>Name:</strong> <span id="profileName"></span></p>
	            <p><strong>Email:</strong> <span id="profileEmail"></span></p>
	            <p><strong>Phone:</strong> <span id="profilePhone"></span></p>
	            <p><strong>Shipping Address:</strong> <span id="profileAddress"></span></p>
	            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">Edit Profile</button>
	            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change Password</button>
	            <button class="btn btn-success" onclick="window.location.href='orders'">See Orders</button>
	            <button class="btn btn-danger" onclick="window.location.href='<%=request.getContextPath()%>/users/logout'">
	    Logout
	</button>
	            
	        </div>
	    </div>
	
	    <!-- Edit Profile Modal -->
	    <div class="modal fade edit-profile-modal" id="editProfileModal" tabindex="-1">
	        <div class="modal-dialog">
	            <form id="editProfileForm">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title">Edit Profile</h5>
	                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
	                    </div>
	                    <div class="modal-body">
	                        <!-- Name -->
	                        <div class="mb-3">
	                            <label class="form-label">Name</label>
	                            <input type="text" id="editName" name="name" class="form-control" required>
	                        </div>
	                        <!-- Email (disabled) -->
	                        <div class="mb-3">
	                            <label class="form-label">Email (cannot be changed)</label>
	                            <input type="email" id="editEmail" name="email" class="form-control" disabled>
	                        </div>
	                        <!-- Phone Number -->
	                        <div class="mb-3">
	                            <label class="form-label">Phone Number</label>
	                            <input type="text" id="editPhone" name="phoneNumber" class="form-control">
	                        </div>
	                        <!-- Shipping Address -->
	                        <div class="mb-3">
	                            <label class="form-label">Shipping Address</label>
	                            <textarea id="editAddress" name="shippingAddress" class="form-control"></textarea>
	                        </div>
	                    </div>
	                    <div class="modal-footer">
	                        <button type="submit" class="btn btn-light">Save Changes</button>
	                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	    
	
	    <!-- Change Password Modal -->
	    <div class="modal fade change-password-modal" id="changePasswordModal" tabindex="-1">
	        <div class="modal-dialog">
	            <form id="changePasswordForm">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title">Change Password</h5>
	                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
	                    </div>
	                    <div class="modal-body">
	                        <div class="mb-3">
	                            <label class="form-label">Current Password</label>
	                            <input type="password" id="currentPassword" class="form-control" required>
	                        </div>
	                        <div class="mb-3">
	                            <label class="form-label">New Password</label>
	                            <input type="password" id="newPassword" class="form-control" required>
	                        </div>
	                        <div class="mb-3">
	                            <label class="form-label">Confirm New Password</label>
	                            <input type="password" id="confirmNewPassword" class="form-control" required>
	                        </div>
	                    </div>
	                    <div class="modal-footer">
	                        <button type="submit" class="btn btn-light">Change Password</button>
	                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	
	<script>
	$(document).ready(function() {
	    const userId = <%= userId != null ? userId : "null" %>;
	    if(!userId) { alert("You are not logged in!"); return; }
	
	    const apiBase = "<%= request.getContextPath() %>";
	    
	    history.pushState(null, null, location.href);
	    window.onpopstate = function () {
	        window.location.href = '<%=request.getContextPath()%>/'; // home page
	    };
	
	    // Load profile data
	    $.get(`${apiBase}/ecomm.capstone/users/id/${userId}`, function(data) {
	        $('#profileImage').attr('src', data.photoUrl || 'https://i.postimg.cc/Kv2cV0vK/default-profile.png');
	        $('#userName').text(data.name);
	        $('#userEmail').text(data.email);
	        $('#profileName').text(data.name);
	        $('#profileEmail').text(data.email);
	        $('#profilePhone').text(data.phoneNumber || 'N/A');
	        $('#profileAddress').text(data.shippingAddress || 'N/A');
	
	        // Fill modal fields
	        $('#editName').val(data.name);
	        $('#editEmail').val(data.email);
	        $('#editPhone').val(data.phoneNumber || '');
	        $('#editAddress').val(data.shippingAddress || '');
	    }).fail(function() {
	        alert("Failed to load profile.");
	    });
	
	    // Edit profile submit
	    $('#editProfileForm').submit(function(e) {
	        e.preventDefault();
	        $.ajax({
	            url: `${apiBase}/ecomm.capstone/users/${userId}`,
	            method: 'PUT',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                name: $('#editName').val(),
	                phoneNumber: $('#editPhone').val(),
	                shippingAddress: $('#editAddress').val(),
	                role:"BUYER",
	                password:"",
	                
	            }),
	            success: function() {
	                $('#editProfileModal').modal('hide');
	                $('#userName').text($('#editName').val());
	                $('#profileName').text($('#editName').val());
	                $('#profilePhone').text($('#editPhone').val() || 'N/A');
	                $('#profileAddress').text($('#editAddress').val() || 'N/A');
	                alert('Profile updated successfully!');
	            },
	            error: function() { alert('Failed to update profile.'); }
	        });
	    });
	
	    // Change password submit
	    $('#changePasswordForm').submit(function(e) {
	        e.preventDefault();
	        const newPassword = $('#newPassword').val();
	        const confirmPassword = $('#confirmNewPassword').val();
	
	        if(newPassword !== confirmPassword) {
	            alert("New passwords do not match!");
	            return;
	        }
	
	        $.ajax({
	            url: `${apiBase}/ecomm.capstone/users/changepassword`,
	            method: 'PUT',
	            contentType: 'application/json',
	            data: JSON.stringify({
	            		oldPassword: $('#currentPassword').val(),
	                newPassword: newPassword,
	                id:userId
	                
	            }),
	            success: function() {
	                $('#changePasswordModal').modal('hide');
	                $('#currentPassword').val('');
	                $('#newPassword').val('');
	                $('#confirmNewPassword').val('');
	                alert("Password changed successfully!");
	            },
	            error: function() { alert("Failed to change password. Please check current password."); }
	        });
	    });
	
	    // Profile photo preview
	    $('#uploadPhoto').change(function(event){
	        const reader = new FileReader();
	        reader.onload = function() { $('#profileImage').attr('src', reader.result); }
	        reader.readAsDataURL(event.target.files[0]);
	    });
	});
	
	//Logout handler
	
	
	
	
	</script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	</body>
	</html>
