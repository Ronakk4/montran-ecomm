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