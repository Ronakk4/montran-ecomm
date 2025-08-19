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
    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .page-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 25px;
        }
        .page-header h2 { margin: 0; font-weight: 600; }
        .profile-card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            padding: 25px; margin-bottom: 20px;
        }
        .profile-avatar {
            width: 90px; height: 90px;
            border-radius: 50%; object-fit: cover;
            border: 3px solid #e9ecef;
        }
        .info-label { font-weight: 600; color: #495057; }
        .info-value { color: #212529; }
        .section-title {
            font-size: 1rem; font-weight: 600;
            margin-top: 20px; margin-bottom: 10px;
            color: #495057;
        }
        .btn-action { margin-top: 15px; }
    </style>
</head>
<body class="container mt-4">

    <!-- HEADER -->
    <div class="page-header">
        <div class="d-flex align-items-center gap-2">
            <a href="dashboard" class="btn btn-outline-secondary btn-sm">← Back to Dashboard</a>
            <h2>👤 Seller Profile</h2>
        </div>
    </div>

    <!-- PROFILE CARD -->
    <div class="profile-card">
        <div class="d-flex align-items-center gap-4 mb-4">
            <img id="profileImage" src="https://i.postimg.cc/Kv2cV0vK/default-profile.png" class="profile-avatar">
            <div>
                <h4 id="storeName">Loading...</h4>
                <p class="mb-1 text-muted" id="sellerEmail"></p>
                <button class="btn btn-sm btn-outline-primary" onclick="$('#uploadLogo').click()">Change Logo</button>
                <input type="file" id="uploadLogo" style="display:none" accept="image/*">
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <span class="info-label">About store:</span>
                <p class="info-value" id="profileStoreName"></p>
            </div>
            <div class="col-md-6 mb-3">
                <span class="info-label">Phone:</span>
                <p class="info-value" id="profilePhone"></p>
            </div>
            <div class="col-md-12 mb-3">
                <span class="info-label">Business Address:</span>
                <p class="info-value" id="businessAddress"></p>
            </div>
            <div class="col-md-6 mb-3">
                <span class="info-label">GST Number:</span>
                <p class="info-value" id="gstNumber"></p>
            </div>
            <div class="col-md-6 mb-3">
                <span class="info-label">Date Joined:</span>
                <p class="info-value" id="joinedDate"></p>
            </div>
        </div>

        <div class="d-flex gap-2 btn-action">
            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editSellerModal">Edit Profile</button>
            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change Password</button>
        </div>
    </div>

    <!-- EDIT SELLER MODAL -->
    <div class="modal fade" id="editSellerModal" tabindex="-1">
        <div class="modal-dialog">
            <form id="editSellerForm">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Edit Business Profile</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">About store</label>
                            <input type="text" id="editStoreName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" id="editPhone" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Business Address</label>
                            <textarea id="editBusinessAddress" class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">GST Number</label>
                            <input type="text" id="editGst" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- CHANGE PASSWORD MODAL -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1">
        <div class="modal-dialog">
            <form id="changePasswordForm">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Change Password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
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
                        <button type="submit" class="btn btn-warning">Change</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

<script>
$(function(){
    const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    if(!sellerId) { alert("You are not logged in!"); return; }

    // load profile
    $.get(`/ecomm.capstone/users/id/${userId}`, function(data) {
		
        $('#profileImage').attr('src', data.logoUrl || 'https://i.postimg.cc/Kv2cV0vK/default-profile.png');
        $('#storeName').text(data.shopName);
        $('#sellerEmail').text(data.email);
        $('#profileStoreName').text(data.shopDescription);
        $('#profilePhone').text(data.phoneNumber || 'N/A');
        $('#businessAddress').text(data.shippingAddress || 'N/A');
        $('#gstNumber').text(data.gstNumber || 'N/A');
        if (data.createdAt) {
            const createdAt = new Date(data.createdAt[0], data.createdAt[1] - 1, data.createdAt[2], data.createdAt[3], data.createdAt[4]);

            // Format to "13 Aug 2025, 10:30 AM"
            const options = { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' };
            $('#joinedDate').text(createdAt.toLocaleDateString('en-GB', options));
        } else {
            $('#joinedDate').text('N/A');
        }

        $('#editStoreName').val(data.storeName);
        $('#editPhone').val(data.phoneNumber || '');
        $('#editBusinessAddress').val(data.businessAddress || '');
        $('#editGst').val(data.gstNumber || '');
    });

    // save profile
    $('#editSellerForm').submit(function(e){
        e.preventDefault();
        $.ajax({
            url: `${apiBase}/ecomm.capstone/sellers/${sellerId}`,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                storeName: $('#editStoreName').val(),
                phoneNumber: $('#editPhone').val(),
                businessAddress: $('#editBusinessAddress').val(),
                gstNumber: $('#editGst').val(),
                
            }),
            success: function(){
                $('#editSellerModal').modal('hide');
                loadSellerProfile();
                alert("Profile updated successfully");
            }
        });
    });

    // change password
    $('#changePasswordForm').submit(function(e){
        e.preventDefault();
        if($('#newPassword').val() !== $('#confirmNewPassword').val()) {
            alert("Passwords do not match!"); return;
        }
        $.ajax({
            url: `/ecomm.capstone/users/changepassword`,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                oldPassword: $('#currentPassword').val(),
                newPassword: $('#newPassword').val(),
                id: sellerId
            }),
            success: function(){
                $('#changePasswordModal').modal('hide');
                alert("Password changed!");
            }
        });
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
