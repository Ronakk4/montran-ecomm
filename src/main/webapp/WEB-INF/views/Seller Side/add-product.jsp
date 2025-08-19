<%--
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
    Cookie jwtToken = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwtToken".equals(cookie.getName())) {
                jwtToken = cookie;
                break;
            }
        }
    }
    
    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;

%>
<html>
<head>
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2>Add New Product</h2>

    <form id="newProductForm">
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" name="prodName" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="prodDescription" class="form-control" rows="3"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Price</label>
            <input type="number" step="0.01" name="price" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Stock Quantity</label>
            <input type="number" name="stockQuantity" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <select id="categoryDropdown" name="category" class="form-select mb-2"></select>
            <input type="text" id="customCategory" placeholder="Or enter a new category" class="form-control" />
        </div>

        <button type="submit" class="btn btn-success">Save Product</button>
        <a href="seller-products.jsp" class="btn btn-secondary">Cancel</a>
    </form>

<script>
	const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
    console.log(sellerId);

    // Load categories
    function loadCategories() {
        $.get(`${apiBase}/category`, function(categories) {
            let options = `<option value="">--Select Category--</option>`;
            categories.forEach(c => {
                options += `<option value="${c}">${c}</option>`;
            });
            $("#categoryDropdown").html(options);
        });
    }

    $("#newProductForm").submit(function(e) {
        e.preventDefault();

        // Use dropdown if selected, else take custom category
        let category = $("#categoryDropdown").val();
        if (!category) {
            category = $("#customCategory").val();
        }

        const product = {
            prodName: $("input[name='prodName']").val(),
            prodDescription: $("textarea[name='prodDescription']").val(),
            price: parseFloat($("input[name='price']").val()),
            stockQuantity: parseInt($("input[name='stockQuantity']").val()),
            category: category,
            sellerId: sellerId
        };

        $.ajax({
            url: `${apiBase}/products`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(product),
            success: function() {
                alert("Product added successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products"; // redirect back
            },
            error: function(xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    });

    // Initial load
    loadCategories();
</script>

</body>
</html>

--%>



<%--
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
    Cookie jwtToken = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwtToken".equals(cookie.getName())) {
                jwtToken = cookie;
                break;
            }
        }
    }
    
    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
%>
<html>
<head>
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .is-invalid {
            border-color: #dc3545 !important;
        }
        .is-valid {
            border-color: #198754 !important;
        }
        .validation-summary {
            background-color: #f8d7da;
            color: #721c24;
            padding: 0.75rem 1rem;
            border: 1px solid #f1aeb5;
            border-radius: 0.375rem;
            margin-bottom: 1rem;
            display: none;
        }
        .spinner-border-sm {
            width: 1rem;
            height: 1rem;
        }
    </style>
</head>
<body class="container mt-4">

    <h2>Add New Product</h2>

    <!-- Validation Summary -->
    <div id="validationSummary" class="validation-summary">
        <strong>Please correct the following errors:</strong>
        <ul id="validationList"></ul>
    </div>

    <form id="newProductForm">
        <!-- Product Name -->
        <div class="mb-3">
            <label class="form-label">Product Name <span class="text-danger">*</span></label>
            <input type="text" id="prodName" name="prodName" required class="form-control" 
                   maxlength="100" placeholder="Enter product name (3-100 characters)" />
            <div class="error-message" id="prodNameError"></div>
            <div class="form-text">Product name must be unique and between 3-100 characters</div>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea id="prodDescription" name="prodDescription" class="form-control" rows="3" 
                      maxlength="1000" placeholder="Enter product description (max 1000 characters)"></textarea>
            <div class="error-message" id="prodDescriptionError"></div>
            <div class="form-text"><span id="descCharCount">0</span>/1000 characters</div>
        </div>

        <!-- Price -->
        <div class="mb-3">
            <label class="form-label">Price <span class="text-danger">*</span></label>
            <div class="input-group">
                <span class="input-group-text">₹</span>
                <input type="number" id="price" name="price" required class="form-control" 
                       step="0.01" min="0.01" max="999999.99" placeholder="0.00" />
            </div>
            <div class="error-message" id="priceError"></div>
            <div class="form-text">Price must be between ₹0.01 and ₹999,999.99</div>
        </div>

        <!-- Stock Quantity -->
        <div class="mb-3">
            <label class="form-label">Stock Quantity <span class="text-danger">*</span></label>
            <input type="number" id="stockQuantity" name="stockQuantity" required class="form-control" 
                   min="0" max="99999" placeholder="Enter stock quantity" />
            <div class="error-message" id="stockQuantityError"></div>
            <div class="form-text">Stock quantity must be between 0 and 99,999</div>
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label class="form-label">Category <span class="text-danger">*</span></label>
            <select id="categoryDropdown" name="category" class="form-select mb-2">
                <option value="">--Select Category--</option>
            </select>
            <input type="text" id="customCategory" placeholder="Or enter a new category (3-50 characters)" 
                   class="form-control" maxlength="50" />
            <div class="error-message" id="categoryError"></div>
            <div class="form-text">Select from dropdown or create new category (3-50 characters, letters and spaces only)</div>
        </div>

        <!-- Submit Buttons -->
        <div class="d-flex gap-2">
            <button type="submit" id="submitBtn" class="btn btn-success">
                <span class="spinner-border spinner-border-sm d-none" id="submitSpinner"></span>
                Save Product
            </button>
            <a href="seller-products.jsp" class="btn btn-secondary">Cancel</a>
        </div>
    </form>

<script>
    const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
    
    // Validation patterns
    const validationPatterns = {
        productName: /^[a-zA-Z0-9\s\-_()&.]{3,100}$/,
        description: /^[\s\S]{0,1000}$/,
        price: /^\d+(\.\d{1,2})?$/,
        stockQuantity: /^\d+$/,
        category: /^[a-zA-Z\s]{3,50}$/
    };

    // Validation state
    let validationState = {
        prodName: false,
        price: false,
        stockQuantity: false,
        category: false,
        prodDescription: true // Optional field
    };

    let existingProducts = []; // Store existing products for duplicate check

    // Load categories and existing products
    function loadInitialData() {
        // Load categories
        $.get(`${apiBase}/category`, function(categories) {
            let options = `<option value="">--Select Category--</option>`;
            categories.forEach(c => {
                options += `<option value="${c}">${c}</option>`;
            });
            $("#categoryDropdown").html(options);
        }).fail(function() {
            console.error("Failed to load categories");
        });

        // Load existing products for duplicate check
        if (sellerId) {
            $.get(`${apiBase}/products`, function(products) {
                existingProducts = products.map(p => p.prodName.toLowerCase().trim());
            }).fail(function() {
                console.warn("Could not load existing products for duplicate check");
            });
        }
    }

    // Real-time validation functions
    function validateProductName() {
        const input = $("#prodName");
        const value = input.val().trim();
        const errorDiv = $("#prodNameError");
        
        if (!value) {
            showFieldError(input, errorDiv, "Product name is required");
            return false;
        }
        
        if (value.length < 3) {
            showFieldError(input, errorDiv, "Product name must be at least 3 characters long");
            return false;
        }
        
        if (value.length > 100) {
            showFieldError(input, errorDiv, "Product name cannot exceed 100 characters");
            return false;
        }
        
        if (!validationPatterns.productName.test(value)) {
            showFieldError(input, errorDiv, "Product name contains invalid characters. Use only letters, numbers, spaces, and basic symbols");
            return false;
        }
        
        // Check for duplicates
        if (existingProducts.includes(value.toLowerCase())) {
            showFieldError(input, errorDiv, "A product with this name already exists in your inventory");
            return false;
        }
        
        showFieldSuccess(input, errorDiv);
        return true;
    }

    function validateDescription() {
        const input = $("#prodDescription");
        const value = input.val();
        const errorDiv = $("#prodDescriptionError");
        const charCount = $("#descCharCount");
        
        charCount.text(value.length);
        
        if (value.length > 1000) {
            showFieldError(input, errorDiv, "Description cannot exceed 1000 characters");
            return false;
        }
        
        showFieldSuccess(input, errorDiv);
        return true;
    }

    function validatePrice() {
        const input = $("#price");
        const value = input.val().trim();
        const errorDiv = $("#priceError");
        
        if (!value) {
            showFieldError(input, errorDiv, "Price is required");
            return false;
        }
        
        const numValue = parseFloat(value);
        
        if (isNaN(numValue)) {
            showFieldError(input, errorDiv, "Please enter a valid number");
            return false;
        }
        
        if (numValue <= 0) {
            showFieldError(input, errorDiv, "Price must be greater than 0");
            return false;
        }
        
        if (numValue > 999999.99) {
            showFieldError(input, errorDiv, "Price cannot exceed ₹999,999.99");
            return false;
        }
        
        // Check decimal places
        const decimalPlaces = (value.split('.')[1] || []).length;
        if (decimalPlaces > 2) {
            showFieldError(input, errorDiv, "Price can have maximum 2 decimal places");
            return false;
        }
        
        showFieldSuccess(input, errorDiv);
        return true;
    }

    function validateStockQuantity() {
        const input = $("#stockQuantity");
        const value = input.val().trim();
        const errorDiv = $("#stockQuantityError");
        
        if (!value && value !== "0") {
            showFieldError(input, errorDiv, "Stock quantity is required");
            return false;
        }
        
        const numValue = parseInt(value);
        
        if (isNaN(numValue)) {
            showFieldError(input, errorDiv, "Please enter a valid whole number");
            return false;
        }
        
        if (numValue < 0) {
            showFieldError(input, errorDiv, "Stock quantity cannot be negative");
            return false;
        }
        
        if (numValue > 99999) {
            showFieldError(input, errorDiv, "Stock quantity cannot exceed 99,999");
            return false;
        }
        
        if (!Number.isInteger(numValue)) {
            showFieldError(input, errorDiv, "Stock quantity must be a whole number");
            return false;
        }
        
        showFieldSuccess(input, errorDiv);
        return true;
    }

    function validateCategory() {
        const dropdown = $("#categoryDropdown");
        const customInput = $("#customCategory");
        const errorDiv = $("#categoryError");
        
        const dropdownValue = dropdown.val();
        const customValue = customInput.val().trim();
        
        if (!dropdownValue && !customValue) {
            showFieldError(dropdown, errorDiv, "Please select a category or enter a new one");
            return false;
        }
        
        if (customValue) {
            if (customValue.length < 3) {
                showFieldError(customInput, errorDiv, "Category name must be at least 3 characters long");
                return false;
            }
            
            if (customValue.length > 50) {
                showFieldError(customInput, errorDiv, "Category name cannot exceed 50 characters");
                return false;
            }
            
            if (!validationPatterns.category.test(customValue)) {
                showFieldError(customInput, errorDiv, "Category name can only contain letters and spaces");
                return false;
            }
        }
        
        showFieldSuccess(dropdown, errorDiv);
        showFieldSuccess(customInput, errorDiv);
        return true;
    }

    // Helper functions
    function showFieldError(input, errorDiv, message) {
        input.addClass('is-invalid').removeClass('is-valid');
        errorDiv.text(message).show();
    }

    function showFieldSuccess(input, errorDiv) {
        input.addClass('is-valid').removeClass('is-invalid');
        errorDiv.hide();
    }

    function updateValidationSummary() {
        const errors = [];
        $('.error-message:visible').each(function() {
            const errorText = $(this).text().trim();
            if (errorText) {
                errors.push(errorText);
            }
        });
        
        const summaryDiv = $("#validationSummary");
        const listDiv = $("#validationList");
        
        if (errors.length > 0) {
            listDiv.html(errors.map(error => `<li>${error}</li>`).join(''));
            summaryDiv.show();
        } else {
            summaryDiv.hide();
        }
    }

    function isFormValid() {
        return Object.values(validationState).every(state => state);
    }

    // Event listeners for real-time validation
    $("#prodName").on('input blur', function() {
        validationState.prodName = validateProductName();
        updateValidationSummary();
    });

    $("#prodDescription").on('input', function() {
        validationState.prodDescription = validateDescription();
        updateValidationSummary();
    });

    $("#price").on('input blur', function() {
        validationState.price = validatePrice();
        updateValidationSummary();
    });

    $("#stockQuantity").on('input blur', function() {
        validationState.stockQuantity = validateStockQuantity();
        updateValidationSummary();
    });

    $("#categoryDropdown, #customCategory").on('change input blur', function() {
        validationState.category = validateCategory();
        updateValidationSummary();
    });

    // Form submission
    $("#newProductForm").submit(function(e) {
        e.preventDefault();
        
        // Run all validations
        validationState.prodName = validateProductName();
        validationState.prodDescription = validateDescription();
        validationState.price = validatePrice();
        validationState.stockQuantity = validateStockQuantity();
        validationState.category = validateCategory();
        
        updateValidationSummary();
        
        if (!isFormValid()) {
            $('html, body').animate({
                scrollTop: $("#validationSummary").offset().top - 20
            }, 500);
            return;
        }
        
        // Check seller authentication
        if (!sellerId) {
            alert("Authentication error. Please log in again.");
            window.location.href = "login.jsp";
            return;
        }
        
        // Show loading state
        const submitBtn = $("#submitBtn");
        const spinner = $("#submitSpinner");
        submitBtn.prop('disabled', true);
        spinner.removeClass('d-none');
        
        // Prepare data
        let category = $("#categoryDropdown").val();
        if (!category) {
            category = $("#customCategory").val().trim();
        }

        const product = {
            prodName: $("#prodName").val().trim(),
            prodDescription: $("#prodDescription").val().trim(),
            price: parseFloat($("#price").val()),
            stockQuantity: parseInt($("#stockQuantity").val()),
            category: category,
            sellerId: sellerId
        };

        // Submit to server
        $.ajax({
            url: `${apiBase}/products`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(product),
            timeout: 30000,
            success: function(response) {
                alert("Product added successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
            },
            error: function(xhr, status, error) {
                let errorMessage = "Failed to add product. ";
                
                if (xhr.status === 400) {
                    errorMessage += "Invalid product data.";
                } else if (xhr.status === 401) {
                    errorMessage += "Authentication failed. Please log in again.";
                } else if (xhr.status === 409) {
                    errorMessage += "A product with this name already exists.";
                } else if (xhr.status >= 500) {
                    errorMessage += "Server error. Please try again later.";
                } else if (status === 'timeout') {
                    errorMessage += "Request timed out. Please check your connection.";
                } else {
                    errorMessage += xhr.responseText || error || "Unknown error occurred.";
                }
                
                alert(errorMessage);
            },
            complete: function() {
                // Reset loading state
                submitBtn.prop('disabled', false);
                spinner.addClass('d-none');
            }
        });
    });

    // Prevent form submission on Enter in text inputs (except textarea)
    $("#newProductForm input[type='text'], #newProductForm input[type='number']").keypress(function(e) {
        if (e.which === 13) {
            e.preventDefault();
            $(this).blur();
        }
    });

    // Initialize
    $(document).ready(function() {
        loadInitialData();
        
        // Set focus on first input
        $("#prodName").focus();
        
        // Initialize character counter
        $("#prodDescription").trigger('input');
    });
</script>

</body>
</html>

--%>



<%--
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
    Cookie jwtToken = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwtToken".equals(cookie.getName())) {
                jwtToken = cookie;
                break;
            }
        }
    }
    
    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
%>
<html>
<head>
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: block;
        }
        .is-invalid {
            border-color: #dc3545 !important;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath d='m5.8 3.6.4.4.4-.4M6 7h.01'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right calc(0.375em + 0.1875rem) center;
            background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
        }
        .is-valid {
            border-color: #198754 !important;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%23198754' d='m2.3 6.73.4-.4 1.4-1.4L6.7 2.3l.4.4-3 3z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right calc(0.375em + 0.1875rem) center;
            background-size: calc(0.75em + 0.375rem) calc(0.75em + 0.375rem);
        }
        .validation-summary {
            background-color: #f8d7da;
            color: #721c24;
            padding: 0.75rem 1rem;
            border: 1px solid #f1aeb5;
            border-radius: 0.375rem;
            margin-bottom: 1rem;
            display: none;
        }
        .char-counter {
            font-size: 0.875rem;
            color: #6c757d;
            text-align: right;
        }
        .char-counter.warning {
            color: #fd7e14;
        }
        .char-counter.danger {
            color: #dc3545;
        }
        .spinner-border-sm {
            width: 1rem;
            height: 1rem;
        }
        .form-text {
            font-size: 0.875rem;
            color: #6c757d;
        }
        .required-field::after {
            content: ' *';
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body class="container mt-4">

    <div class="row justify-content-center">
        <div class="col-md-8">
            <h2 class="mb-4">Add New Product</h2>

            <!-- Authentication Alert -->
            <div id="authAlert" class="alert alert-danger d-none">
                <strong>Authentication Error!</strong> Please log in to continue.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>

            <!-- Validation Summary -->
            <div id="validationSummary" class="validation-summary">
                <strong><i class="bi bi-exclamation-triangle"></i> Please correct the following errors:</strong>
                <ul id="validationList" class="mb-0 mt-2"></ul>
            </div>

            <form id="newProductForm" novalidate>
                <!-- Product Name Field -->
                <div class="mb-3">
                    <label for="prodName" class="form-label required-field">Product Name</label>
                    <input type="text" id="prodName" name="prodName" class="form-control" 
                           maxlength="150" autocomplete="off" 
                           placeholder="Enter unique product name (3-150 characters)" />
                    <div class="error-message" id="prodNameError"></div>
                    <div class="form-text">Product name must be unique in your inventory and between 3-150 characters</div>
                </div>

                <!-- Description Field -->
                <div class="mb-3">
                    <label for="prodDescription" class="form-label">Description</label>
                    <textarea id="prodDescription" name="prodDescription" class="form-control" 
                              rows="4" maxlength="1000" 
                              placeholder="Enter detailed product description (optional, max 1000 characters)"></textarea>
                    <div class="error-message" id="prodDescriptionError"></div>
                    <div class="d-flex justify-content-between">
                        <div class="form-text">Provide detailed information about your product</div>
                        <div class="char-counter" id="descCharCount">0/1000</div>
                    </div>
                </div>

                <!-- Price Field -->
                <div class="mb-3">
                    <label for="price" class="form-label required-field">Price</label>
                    <div class="input-group">
                        <span class="input-group-text">₹</span>
                        <input type="number" id="price" name="price" class="form-control" 
                               step="0.01" min="0.01" max="999999.99" 
                               placeholder="0.00" />
                    </div>
                    <div class="error-message" id="priceError"></div>
                    <div class="form-text">Enter price in rupees (minimum ₹0.01, maximum ₹999,999.99)</div>
                </div>

                <!-- Stock Quantity Field -->
                <div class="mb-3">
                    <label for="stockQuantity" class="form-label required-field">Stock Quantity</label>
                    <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" 
                           min="0" max="999999" step="1" 
                           placeholder="Enter available stock quantity" />
                    <div class="error-message" id="stockQuantityError"></div>
                    <div class="form-text">Enter current stock quantity (0 for out of stock, maximum 999,999)</div>
                </div>

                <!-- Category Field -->
                <div class="mb-3">
                    <label for="categoryDropdown" class="form-label required-field">Category</label>
                    <select id="categoryDropdown" name="category" class="form-select mb-2">
                        <option value="">-- Loading Categories --</option>
                    </select>
                    <div class="input-group">
                        <span class="input-group-text">OR</span>
                        <input type="text" id="customCategory" class="form-control" 
                               maxlength="50" placeholder="Enter new category name (3-50 characters)" />
                    </div>
                    <div class="error-message" id="categoryError"></div>
                    <div class="form-text">Select existing category or create new one (letters and spaces only)</div>
                </div>

                <!-- Submit Buttons -->
                <div class="d-flex gap-2 justify-content-end">
                    <a href="seller-products.jsp" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Cancel
                    </a>
                    <button type="submit" id="submitBtn" class="btn btn-success">
                        <span class="spinner-border spinner-border-sm d-none" id="submitSpinner"></span>
                        <i class="bi bi-plus-circle" id="submitIcon"></i>
                        Save Product
                    </button>
                </div>
            </form>
        </div>
    </div>

<script>
    // Configuration and State
    const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
    
    // Validation patterns matching backend constraints
    const validationRules = {
        prodName: {
            required: true,
            minLength: 3,
            maxLength: 150,
            pattern: /^[a-zA-Z0-9\s\-_()&.,!@#$%^*+=<>?|[\]{}:;"'\\\/`~]{3,150}$/,
            unique: true
        },
        prodDescription: {
            required: false,
            maxLength: 1000,
            pattern: /^[\s\S]{0,1000}$/
        },
        price: {
            required: true,
            min: 0.01,
            max: 999999.99,
            pattern: /^\d+(\.\d{1,2})?$/,
            positive: true
        },
        stockQuantity: {
            required: true,
            min: 0,
            max: 999999,
            integer: true
        },
        category: {
            required: true,
            minLength: 3,
            maxLength: 50,
            pattern: /^[a-zA-Z\s]{3,50}$/
        }
    };

    // Validation state
    let formValidation = {
        prodName: { valid: false, checked: false },
        prodDescription: { valid: true, checked: true }, // Optional field
        price: { valid: false, checked: false },
        stockQuantity: { valid: false, checked: false },
        category: { valid: false, checked: false }
    };

    let existingProductNames = [];
    let categoriesLoaded = false;

    // Initialize application
    $(document).ready(function() {
        initializeApp();
    });

    function initializeApp() {
        // Check authentication
        if (!sellerId) {
            showAuthenticationError();
            return;
        }

        // Load initial data
        loadCategories();
        loadExistingProducts();

        // Setup event listeners
        setupEventListeners();

        // Focus on first input
        setTimeout(() => $("#prodName").focus(), 100);
    }

    function showAuthenticationError() {
        $("#authAlert").removeClass('d-none');
        $("#newProductForm").addClass('d-none');
        setTimeout(() => {
            window.location.href = "login.jsp";
        }, 3000);
    }

    function loadCategories() {
        $.get(`${apiBase}/category`)
            .done(function(categories) {
                let options = `<option value="">-- Select Category --</option>`;
                categories.forEach(category => {
                    options += `<option value="${escapeHtml(category)}">${escapeHtml(category)}</option>`;
                });
                $("#categoryDropdown").html(options);
                categoriesLoaded = true;
            })
            .fail(function(xhr) {
                console.error("Failed to load categories:", xhr);
                $("#categoryDropdown").html(`<option value="">-- Error Loading Categories --</option>`);
            });
    }

    function loadExistingProducts() {
        $.get(`${apiBase}/products`, { sellerId: sellerId })
            .done(function(products) {
                existingProductNames = products.map(p => p.prodName.toLowerCase().trim());
                console.log("Loaded existing products for duplicate check:", existingProductNames.length);
            })
            .fail(function(xhr) {
                console.warn("Could not load existing products for duplicate check:", xhr);
                existingProductNames = [];
            });
    }

    function setupEventListeners() {
        // Real-time validation on input/change/blur
        $("#prodName").on('input blur', () => validateField('prodName'));
        $("#prodDescription").on('input', () => {
            validateField('prodDescription');
            updateCharacterCount();
        });
        $("#price").on('input blur', () => validateField('price'));
        $("#stockQuantity").on('input blur', () => validateField('stockQuantity'));
        $("#categoryDropdown, #customCategory").on('change input blur', () => validateField('category'));

        // Form submission
        $("#newProductForm").on('submit', handleFormSubmit);

        // Prevent Enter key submission except in textarea
        $("#newProductForm input[type='text'], #newProductForm input[type='number']").on('keypress', function(e) {
            if (e.which === 13) {
                e.preventDefault();
                $(this).blur();
                return false;
            }
        });

        // Clear custom category when dropdown is selected
        $("#categoryDropdown").on('change', function() {
            if ($(this).val()) {
                $("#customCategory").val('').removeClass('is-valid is-invalid');
            }
        });

        // Clear dropdown when custom category is typed
        $("#customCategory").on('input', function() {
            if ($(this).val().trim()) {
                $("#categoryDropdown").val('').removeClass('is-valid is-invalid');
            }
        });
    }

    function updateCharacterCount() {
        const textarea = $("#prodDescription");
        const counter = $("#descCharCount");
        const currentLength = textarea.val().length;
        const maxLength = 1000;

        counter.text(`${currentLength}/${maxLength}`);

        // Color coding for character count
        counter.removeClass('warning danger');
        if (currentLength > maxLength * 0.9) {
            counter.addClass('danger');
        } else if (currentLength > maxLength * 0.7) {
            counter.addClass('warning');
        }
    }

    // Field Validation Functions
    function validateField(fieldName) {
        const validator = fieldValidators[fieldName];
        if (validator) {
            const result = validator();
            formValidation[fieldName] = { valid: result, checked: true };
            updateValidationSummary();
            return result;
        }
        return false;
    }

    const fieldValidators = {
        prodName: function() {
            const input = $("#prodName");
            const value = input.val().trim();
            const rule = validationRules.prodName;

            // Required check
            if (!value) {
                return showFieldError(input, "prodNameError", "Product name is required");
            }

            // Length validation
            if (value.length < rule.minLength) {
                return showFieldError(input, "prodNameError", `Product name must be at least ${rule.minLength} characters`);
            }
            if (value.length > rule.maxLength) {
                return showFieldError(input, "prodNameError", `Product name cannot exceed ${rule.maxLength} characters`);
            }

            // Pattern validation (less restrictive for product names)
            if (!rule.pattern.test(value)) {
                return showFieldError(input, "prodNameError", "Product name contains invalid characters");
            }

            // Uniqueness check
            if (existingProductNames.includes(value.toLowerCase())) {
                return showFieldError(input, "prodNameError", "A product with this name already exists in your inventory");
            }

            return showFieldSuccess(input, "prodNameError");
        },

        prodDescription: function() {
            const input = $("#prodDescription");
            const value = input.val();
            const rule = validationRules.prodDescription;

            // Length validation
            if (value.length > rule.maxLength) {
                return showFieldError(input, "prodDescriptionError", `Description cannot exceed ${rule.maxLength} characters`);
            }

            return showFieldSuccess(input, "prodDescriptionError");
        },

        price: function() {
            const input = $("#price");
            const value = input.val().trim();
            const rule = validationRules.price;

            // Required check
            if (!value) {
                return showFieldError(input, "priceError", "Price is required");
            }

            const numValue = parseFloat(value);

            // Numeric validation
            if (isNaN(numValue)) {
                return showFieldError(input, "priceError", "Please enter a valid number");
            }

            // Positive validation (backend constraint)
            if (numValue <= 0) {
                return showFieldError(input, "priceError", "Price must be greater than 0 (positive number required)");
            }

            // Range validation
            if (numValue < rule.min) {
                return showFieldError(input, "priceError", `Price must be at least ₹${rule.min}`);
            }
            if (numValue > rule.max) {
                return showFieldError(input, "priceError", `Price cannot exceed ₹${rule.max.toLocaleString()}`);
            }

            // Decimal places validation
            const decimalPlaces = (value.split('.')[1] || '').length;
            if (decimalPlaces > 2) {
                return showFieldError(input, "priceError", "Price can have maximum 2 decimal places");
            }

            return showFieldSuccess(input, "priceError");
        },

        stockQuantity: function() {
            const input = $("#stockQuantity");
            const value = input.val().trim();
            const rule = validationRules.stockQuantity;

            // Required check
            if (value === '') {
                return showFieldError(input, "stockQuantityError", "Stock quantity is required");
            }

            const numValue = parseInt(value);

            // Numeric validation
            if (isNaN(numValue)) {
                return showFieldError(input, "stockQuantityError", "Please enter a valid whole number");
            }

            // Integer validation
            if (!Number.isInteger(numValue) || numValue.toString() !== value) {
                return showFieldError(input, "stockQuantityError", "Stock quantity must be a whole number");
            }

            // Non-negative validation (backend constraint)
            if (numValue < rule.min) {
                return showFieldError(input, "stockQuantityError", "Stock quantity cannot be negative");
            }

            // Maximum validation
            if (numValue > rule.max) {
                return showFieldError(input, "stockQuantityError", `Stock quantity cannot exceed ${rule.max.toLocaleString()}`);
            }

            return showFieldSuccess(input, "stockQuantityError");
        },

        category: function() {
            const dropdown = $("#categoryDropdown");
            const customInput = $("#customCategory");
            const dropdownValue = dropdown.val();
            const customValue = customInput.val().trim();
            const rule = validationRules.category;

            // One of them must be selected/filled
            if (!dropdownValue && !customValue) {
                showFieldError(dropdown, "categoryError", "Please select a category or enter a new one");
                return false;
            }

            // If custom category is provided, validate it
            if (customValue) {
                if (customValue.length < rule.minLength) {
                    showFieldError(customInput, "categoryError", `Category name must be at least ${rule.minLength} characters`);
                    return false;
                }
                if (customValue.length > rule.maxLength) {
                    showFieldError(customInput, "categoryError", `Category name cannot exceed ${rule.maxLength} characters`);
                }
                if (!rule.pattern.test(customValue)) {
                    showFieldError(customInput, "categoryError", "Category name can only contain letters and spaces");
                    return false;
                }
                showFieldSuccess(customInput, "categoryError");
            }

            if (dropdownValue) {
                showFieldSuccess(dropdown, "categoryError");
            }

            return true;
        }
    };

    function showFieldError(input, errorId, message) {
        input.addClass('is-invalid').removeClass('is-valid');
        $(`#${errorId}`).text(message).show();
        return false;
    }

    function showFieldSuccess(input, errorId) {
        input.addClass('is-valid').removeClass('is-invalid');
        $(`#${errorId}`).hide();
        return true;
    }

    function updateValidationSummary() {
        const errors = [];
        $('.error-message:visible').each(function() {
            const errorText = $(this).text().trim();
            if (errorText) {
                errors.push(errorText);
            }
        });

        const summaryDiv = $("#validationSummary");
        const listDiv = $("#validationList");

        if (errors.length > 0) {
            listDiv.html(errors.map(error => `<li>${escapeHtml(error)}</li>`).join(''));
            summaryDiv.show();
        } else {
            summaryDiv.hide();
        }
    }

    function isFormValid() {
        // Run all validations
        Object.keys(fieldValidators).forEach(field => validateField(field));
        
        // Check if all fields are valid
        return Object.values(formValidation).every(field => field.valid);
    }

    function handleFormSubmit(e) {
        e.preventDefault();

        // Validate authentication
        if (!sellerId) {
            alert("Authentication error. Please log in again.");
            window.location.href = "login.jsp";
            return;
        }

        // Validate all fields
        if (!isFormValid()) {
            // Scroll to validation summary
            $('html, body').animate({
                scrollTop: $("#validationSummary").offset().top - 20
            }, 500);
            return;
        }

        // Show loading state
        const submitBtn = $("#submitBtn");
        const spinner = $("#submitSpinner");
        const icon = $("#submitIcon");
        
        submitBtn.prop('disabled', true);
        spinner.removeClass('d-none');
        icon.addClass('d-none');

        // Prepare product data
        const productData = prepareProductData();

        // Submit to backend
        $.ajax({
            url: `${apiBase}/products`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(productData),
            timeout: 30000,
            success: function(response) {
                alert("Product added successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
            },
            error: function(xhr, status, error) {
                handleSubmitError(xhr, status, error);
            },
            complete: function() {
                // Reset loading state
                submitBtn.prop('disabled', false);
                spinner.addClass('d-none');
                icon.removeClass('d-none');
            }
        });
    }

    function prepareProductData() {
        // Get category value (dropdown or custom)
        let category = $("#categoryDropdown").val();
        if (!category) {
            category = $("#customCategory").val().trim();
        }

        return {
            prodName: $("#prodName").val().trim(),
            prodDescription: $("#prodDescription").val().trim() || null,
            price: parseFloat($("#price").val()),
            stockQuantity: parseInt($("#stockQuantity").val()),
            category: category,
            sellerId: sellerId
        };
    }

    function handleSubmitError(xhr, status, error) {
        let errorMessage = "Failed to add product. ";

        switch (xhr.status) {
            case 400:
                errorMessage += "Invalid product data provided.";
                break;
            case 401:
                errorMessage += "Authentication failed. Please log in again.";
                setTimeout(() => window.location.href = "login.jsp", 2000);
                break;
            case 409:
                errorMessage += "A product with this name already exists.";
                break;
            case 422:
                errorMessage += "Validation failed: " + (xhr.responseText || "Invalid input data.");
                break;
            case 500:
                errorMessage += "Server error. Please try again later.";
                break;
            default:
                if (status === 'timeout') {
                    errorMessage += "Request timed out. Please check your connection and try again.";
                } else {
                    errorMessage += xhr.responseText || error || "An unexpected error occurred.";
                }
        }

        alert(errorMessage);
        console.error("Submit error:", { xhr, status, error });
    }

    // Utility functions
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Initialize character counter
    setTimeout(() => {
        updateCharacterCount();
    }, 100);
</script>

</body>
</html>
--%>


<%--
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
Cookie jwtToken = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("jwtToken".equals(cookie.getName())) {
            jwtToken = cookie;
            break;
        }
    }
}
Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
%>

<html>
<head>
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

<h2>Add New Product</h2>

<form id="newProductForm" novalidate>
    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" name="prodName" id="prodName" required class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea name="prodDescription" id="prodDescription" class="form-control" rows="3"></textarea>
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Price</label>
        <input type="number" step="0.01" name="price" id="price" required class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Stock Quantity</label>
        <input type="number" name="stockQuantity" id="stockQuantity" required class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Category</label>
        <select id="categoryDropdown" name="category" class="form-select mb-2"></select>
        <input type="text" id="customCategory" placeholder="Or enter a new category" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <button type="submit" class="btn btn-success">Save Product</button>
    <a href="seller-products.jsp" class="btn btn-secondary">Cancel</a>
</form>

<script>
const sellerId = <%= sellerId != null ? sellerId : "null" %>;
const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";

// Load categories
function loadCategories() {
    $.get(`${apiBase}/category`, function(categories) {
        let options = `<option value="">--Select Category--</option>`;
        categories.forEach(c => {
            options += `<option value="${c}">${c}</option>`;
        });
        $("#categoryDropdown").html(options);
    });
}

// === VALIDATION MESSAGES (same as backend) ===
const messages = {
    prodName: {
        required: "Product name is required",
        length: "Product name must be between 3 and 150 characters",
        unique: "Product name must be unique for this seller"
    },
    prodDescription: {
        length: "Description must not exceed 1000 characters"
    },
    price: {
        positive: "Price must be a positive number"
    },
    stockQuantity: {
        min: "Product not available in stock"
    },
    category: {
        required: "Please select or enter a category"
    }
};

// === FRONTEND VALIDATION ===
function validateForm() {
    let valid = true;

    // Product name
    const prodName = $("#prodName").val().trim();
    if (!prodName) {
        showError("#prodName", messages.prodName.required); valid = false;
    } else if (prodName.length < 3 || prodName.length > 150) {
        showError("#prodName", messages.prodName.length); valid = false;
    } else {
        clearError("#prodName");
    }

    // Description
    const desc = $("#prodDescription").val().trim();
    if (desc.length > 1000) {
        showError("#prodDescription", messages.prodDescription.length); valid = false;
    } else {
        clearError("#prodDescription");
    }

    // Price
    const price = parseFloat($("#price").val());
    if (isNaN(price) || price <= 0) {
        showError("#price", messages.price.positive); valid = false;
    } else {
        clearError("#price");
    }

    // Stock
    const stock = parseInt($("#stockQuantity").val());
    if (isNaN(stock) || stock < 0) {
        showError("#stockQuantity", messages.stockQuantity.min); valid = false;
    } else {
        clearError("#stockQuantity");
    }

    // Category
    let category = $("#categoryDropdown").val();
    if (!category) category = $("#customCategory").val().trim();
    if (!category) {
        showError("#categoryDropdown", messages.category.required); valid = false;
    } else {
        clearError("#categoryDropdown");
    }

    return valid;
}

function showError(selector, message) {
    $(selector).addClass("is-invalid");
    $(selector).siblings(".invalid-feedback").text(message);
}

function clearError(selector) {
    $(selector).removeClass("is-invalid");
    $(selector).siblings(".invalid-feedback").text("");
}

// === UNIQUE PRODUCT NAME CHECK ===
function checkUniqueProductName(prodName, callback) {
    $.get(`${apiBase}/products?sellerId=${sellerId}`, function(products) {
        const exists = products.some(p => p.prodName.toLowerCase() === prodName.toLowerCase());
        callback(exists);
    });
}

// === FORM SUBMIT ===
$("#newProductForm").submit(function(e) {
    e.preventDefault();

    if (!validateForm()) return;

    const prodName = $("#prodName").val().trim();
    checkUniqueProductName(prodName, function(exists) {
        if (exists) {
            showError("#prodName", messages.prodName.unique);
            return;
        }

        // Prepare payload
        let category = $("#categoryDropdown").val();
        if (!category) category = $("#customCategory").val().trim();

        const product = {
            prodName: prodName,
            prodDescription: $("#prodDescription").val().trim(),
            price: parseFloat($("#price").val()),
            stockQuantity: parseInt($("#stockQuantity").val()),
            category: category,
            sellerId: sellerId
        };

        $.ajax({
            url: `${apiBase}/products`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(product),
            success: function() {
                alert("Product added successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
            },
            error: function(xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    });
});

// Initial load
loadCategories();
</script>

</body>
</html>
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
Cookie jwtToken = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("jwtToken".equals(cookie.getName())) {
            jwtToken = cookie;
            break;
        }
    }
}
Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
%>

<html>
<head>
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

<h2>Add New Product</h2>

<form id="newProductForm" novalidate>
    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" name="prodName" id="prodName" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea name="prodDescription" id="prodDescription" class="form-control" rows="3"></textarea>
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Price</label>
        <input type="number" step="0.01" name="price" id="price" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Stock Quantity</label>
        <input type="number" name="stockQuantity" id="stockQuantity" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Category</label>
        <select id="categoryDropdown" name="category" class="form-select mb-2"></select>
        <input type="text" id="customCategory" placeholder="Or enter a new category" class="form-control mt-2" />
        <div class="invalid-feedback"></div>
    </div>

    <button type="submit" class="btn btn-success">Save Product</button>
    <a href="seller-products.jsp" class="btn btn-secondary">Cancel</a>
</form>

<script>
const sellerId = <%= sellerId != null ? sellerId : "null" %>;
const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";

// Load categories
function loadCategories() {
    $.get(`${apiBase}/category`, function(categories) {
        let options = `<option value="">--Select Category--</option>`;
        categories.forEach(c => {
            options += `<option value="${c}">${c}</option>`;
        });
        $("#categoryDropdown").html(options);
    });
}

// === Validation messages (copied from Product.java annotations) ===
const messages = {
    prodName: {
        required: "Product name is required",
        length: "Product name must be between 3 and 150 characters",
        unique: "Product name must be unique for this seller"
    },
    prodDescription: {
        length: "Description must not exceed 1000 characters"
    },
    price: {
        positive: "Price must be a positive number"
    },
    stockQuantity: {
        min: "Product not available in stock"
    },
    category: {
        required: "Please select or enter a category"
    }
};

function showError(selector, message) {
    $(selector).addClass("is-invalid");
    $(selector).siblings(".invalid-feedback").text(message);
}
function clearError(selector) {
    $(selector).removeClass("is-invalid");
    $(selector).siblings(".invalid-feedback").text("");
}

// === Unique Product Name check ===
function checkUniqueProductName(prodName) {
    return new Promise((resolve) => {
        $.get(`${apiBase}/products?sellerId=${sellerId}`, function(products) {
            const exists = products.some(p => p.prodName.toLowerCase() === prodName.toLowerCase());
            resolve(exists);
        });
    });
}

// === Field-specific validation ===
async function validateField(field) {
    const val = $(field).val().trim();
    switch(field.id) {
        case "prodName":
            if (!val) { showError(field, messages.prodName.required); return false; }
            if (val.length < 3 || val.length > 150) { showError(field, messages.prodName.length); return false; }
            const exists = await checkUniqueProductName(val);
            if (exists) { showError(field, messages.prodName.unique); return false; }
            clearError(field); return true;

        case "prodDescription":
            if (val.length > 1000) { showError(field, messages.prodDescription.length); return false; }
            clearError(field); return true;

        case "price":
            const price = parseFloat(val);
            if (isNaN(price) || price <= 0) { showError(field, messages.price.positive); return false; }
            clearError(field); return true;

        case "stockQuantity":
            const stock = parseInt(val);
            if (isNaN(stock) || stock <= 0) { showError(field, messages.stockQuantity.min); return false; }
            clearError(field); return true;

        case "categoryDropdown":
        case "customCategory":
            let category = $("#categoryDropdown").val() || $("#customCategory").val().trim();
            if (!category) { showError("#categoryDropdown", messages.category.required); return false; }
            clearError("#categoryDropdown"); return true;
    }
}

// Attach real-time validation
$("#prodName, #prodDescription, #price, #stockQuantity, #categoryDropdown, #customCategory")
    .on("blur input", function() {
        validateField(this);
    });

// === Form submit ===
$("#newProductForm").submit(async function(e) {
    e.preventDefault();

    // validate all fields
    let valid = true;
    for (const f of ["#prodName","#prodDescription","#price","#stockQuantity","#categoryDropdown"]) {
        const ok = await validateField($(f)[0]);
        if (!ok) valid = false;
    }
    if (!valid) return;

    let category = $("#categoryDropdown").val() || $("#customCategory").val().trim();

    const product = {
        prodName: $("#prodName").val().trim(),
        prodDescription: $("#prodDescription").val().trim(),
        price: parseFloat($("#price").val()),
        stockQuantity: parseInt($("#stockQuantity").val()),
        category: category,
        sellerId: sellerId
    };

    $.ajax({
        url: `${apiBase}/products`,
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify(product),
        success: function() {
            alert("Product added successfully!");
            window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
        },
        error: function(xhr) {
            alert("Error: " + xhr.responseText);
        }
    });
});

// Initial load
loadCategories();
</script>

</body>
</html>
