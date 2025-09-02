# Secure Online E-Commerce Platform (SOECP)  
**A full-featured Spring MVC E-Commerce application with JWT Authentication, Hibernate ORM, and PostgreSQL.**  

---

## **Project Overview**  
- **Architecture:** Spring MVC + Hibernate + JWT Authentication  
- **Purpose:** An e-commerce application with distinct roles for Buyers and Sellers.  
- **Database:** Relational database using PostgreSQL with Hibernate ORM.  
- **Security:** JWT token-based authentication using HttpOnly cookies for secure, role-based access.  

---

## **Entity Relationships**  
- User (1) ←→ (0..1) Buyer  
- User (1) ←→ (0..1) Seller  
- Seller (1) → (*) Product  
- Buyer (1) → (*) Cart  
- Cart (1) → (*) CartItem  
- Buyer (1) → (*) OrderHeader  
- OrderHeader (1) → (*) OrderItem  

---

## **Complete API Endpoints Summary**  

### **Authentication Endpoints**  
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/users` | Register a new user (Buyer/Seller) | No |
| POST | `/users/login` | User login (returns JWT cookie) | No |
| GET | `/users/logout` | User logout (clears JWT cookie) | No |
| GET | `/users/id/{id}` | Get user details by ID | Yes |
| PUT | `/users/changepassword` | Change user password | Yes |
| PUT | `/users/{id}` | Update user profile information | Yes |

### **Public Endpoints**  
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/products/category/{category}` | Get products by category | No |
| GET | `/app/home` | Home page | No |
| GET | `/app/about` | About page | No |
| GET | `/app/contact` | Contact page | No |
| GET | `/app/product` | Product list page | No |
| GET | `/app/product-details` | Product details page | No |
| GET | `/app/login` | Login page | No |
| GET | `/app/registerBuyer` | Buyer registration page | No |
| GET | `/app/registerSeller` | Seller registration page | No |

### **Cart Management Endpoints (Buyer)**  
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/api/cart` | Get buyer's cart items | Yes (Buyer) |
| POST | `/api/cart` | Add product to cart | Yes (Buyer) |
| PUT | `/api/cart` | Update product quantity in cart | Yes (Buyer) |
| DELETE | `/api/cart` | Remove product from cart | Yes (Buyer) |

### **Buyer Order Management Endpoints**  
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/buyer/orders` | Get all orders for a buyer | Yes |
| GET | `/buyer/orders/{id}` | Get specific order details | Yes |
| POST | `/buyer/orders` | Place a new order | Yes |
| PUT | `/buyer/orders/{id}` | Cancel an order | Yes |
| POST | `/buyer/checkout` | Checkout from cart (session-based) | Yes |

### **Seller Management Endpoints**  
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/seller/products` | Add new product | Yes (Seller) |
| GET | `/api/seller/products` | Get all products for a seller | Yes (Seller) |
| GET | `/api/seller/products/{id}` | Get specific product details | Yes (Seller) |
| PUT | `/api/seller/products/{id}` | Update product information | Yes (Seller) |
| DELETE | `/api/seller/products/{id}` | Delete a product | Yes (Seller) |
| GET | `/api/seller/orders` | Get all orders for a seller | Yes (Seller) |
| PUT | `/api/seller/order-status` | Update order status | Yes (Seller) |
| GET | `/api/seller/category` | Get all product categories | Yes (Seller) |
| GET | `/api/seller/searchProducts` | Search products with filters | Yes (Seller) |
| GET | `/api/seller/searchOrders` | Search orders with filters | Yes (Seller) |
| GET | `/api/seller/analytics` | Get monthly sales and revenue analytics | Yes (Seller) |

---

## **Postman Testing JSON Examples**  

### **1. Register a Buyer**
```json
POST http://localhost:8080/ecomm.capstone/users
Content-Type: application/json

{
  "name": "Harsh Singh",
  "email": "hsingh@example.com",
  "password": "Harsh@2025",
  "role": "BUYER",
  "shippingAddress": "123 adarsh nagar, goregaon east, 2345",
  "phoneNumber": "9302827890"
}
```

### **2. Update a User**
```json
PUT http://localhost:8080/ecomm.capstone/users
Content-Type: application/json

{
  "email": "akash2.buyer@example.com",
  "password": "akyAa@123",
  "role": "BUYER",
  "shippingAddress": "123 Main St, City, State 12345",
  "phoneNumber": "+1931951890"
}
```

### **3. Register a Seller**
```json
POST http://localhost:8080/ecomm.capstone/users
Content-Type: application/json

{
  "name": "Shivam Singh",
  "email": "ssingh@example.com",
  "password": "Shivam@2025",
  "role": "SELLER",
  "phoneNumber": "9302827890",
  "shopName": "Shivam's Emporium",
  "shopDescription": "A curated selection of tech gadgets and accessories",
  "gstNumber": "27ABCDE1234F1Z5"
}
```

### **4. User Login**
```json
POST http://localhost:8080/ecomm.capstone/users/login
Content-Type: application/json

{
  "email": "ansh.shah@example.com",
  "password": "Ansh@2025"
}
```
**Expected Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "message": "Login successful"
}
```

### **5. Add a Product (Seller)**
```json
POST http://localhost:8080/ecomm.capstone/api/seller/products
Content-Type: application/json
Authorization: Bearer {SELLER_JWT_TOKEN}

{
  "prodName": "Titan watch",
  "prodDescription": "Latest digital branded costly watch with advanced features",
  "price": 2299.99,
  "stockQuantity": 50,
  "category": "Electronics",
  "sellerId": 5,
  "images": [
    "https://example.com/iphone1.jpg",
    "https://example.com/iphone2.jpg"
  ]
}
```

### **6. Place an Order (Buyer)**
```json
POST http://localhost:8080/ecomm.capstone/api/buyer/orders
Content-Type: application/json
Authorization: Bearer {BUYER_JWT_TOKEN}

{
  "status": "PENDING",
  "totalAmount": 109.99,
  "buyerId": 23,
  "items": [
    {
      "productId": 14.9,
      "sellerId": 17,
      "quantity": 1,
      "price": 108.99
    }
  ]
}
```

### **7. Get All Orders for a Buyer**
```json
GET http://localhost:8080/ecomm.capstone/api/buyer/orders?buyerId=23
Content-Type: application/json
Authorization: Bearer {BUYER_JWT_TOKEN}
```
--- 
## **Validation & Exception Handling**  

### **Bean Validation Annotations**
- `@NotBlank`, `@Email`, `@Size` for user and product data.  
- `@NotNull` for required fields.  
- Custom validation for password strength.  

### **Custom Business Validations**
- Role-based access control: Controllers validate user roles using JWT token.  
- Product uniqueness: Prevent duplicate products for the same seller.  
- Sufficient stock: Validate stock before adding to cart or placing an order.  

### **Exception Handling**
**Custom Exceptions:**  
- `DuplicateEmailException` – Email already exists during registration  
- `ProductNotFoundException` – Product ID not found  
- `UserNotFoundException` – User not found  

**Global Exception Handler (@ControllerAdvice):**  
- Centralized handler for standardized JSON error responses (HTTP 404, 409, etc.)  

---

## **Security Implementation**  

### **JWT Authentication Flow**
1. User logs in with credentials.  
2. `AuthController` validates credentials.  
3. A JWT is generated and stored in an HttpOnly cookie.  
4. Subsequent requests include the cookie and `JwtAuthenticationFilter` validates it.  
5. User identity and role are set in the `SecurityContext`.  

### **Role-Based Access Control**
- **Buyer Role:** Manage cart, place orders, view order history.  
- **Seller Role:** Add/update/delete products, manage buyer orders, view analytics.  
- Access to `/api/cart/*` and `/api/seller/*` is restricted by role.  

---

## **Database Design & Hibernate Features**  

- **Session Management:** via Spring `@Transactional`  
- **Criteria Queries:** for dynamic product & order searches  
- **Entity Mappings:** `@OneToMany`, `@ManyToOne`, etc. for Product-Seller relationships  

---

## **Testing Workflow in Postman**  

1. Register a new buyer and seller.  
2. Login as each user and save JWT token from cookie.  
3. Seller: Add new products and update details.  
4. Buyer: Add items to cart, update quantities, place orders.  
5. Test protected endpoints to verify role-based access.  
6. Send invalid JSON to test validation errors.  
7. Test invalid IDs or unauthorized actions to verify error handling.  

---

**Developed using Java, Spring MVC, Hibernate, and PostgreSQL.**
