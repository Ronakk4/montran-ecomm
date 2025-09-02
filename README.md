# E-Commerce Spring MVC REST API - Complete Guide

## Know all Details

### Project Overview

* **Architecture:** Spring MVC + Hibernate + JWT Authentication
* **Purpose:** An e-commerce application with distinct roles for Buyers and Sellers.
* **Database:** Relational database using PostgreSQL with Hibernate ORM.
* **Security:** JWT token-based authentication using HttpOnly cookies for secure, role-based access.

### Entity Relationships

* **User (1)** ←→ **(0..1) Buyer**
* **User (1)** ←→ **(0..1) Seller**
* **Seller (1)** → **(\*) Product**
* **Buyer (1)** → **(\*) Cart**
* **Cart (1)** → **(\*) CartItem**
* **Buyer (1)** → **(\*) OrderHeader**
* **OrderHeader (1)** → **(\*) OrderItem**

<br>

## Complete API Endpoints Summary

### Authentication Endpoints

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| `POST` | `/users` | Register a new user (Buyer/Seller) | No |
| `POST` | `/users/login` | User login (returns JWT cookie) | No |
| `GET` | `/users/logout` | User logout (clears JWT cookie) | No |
| `GET` | `/users/id/{id}` | Get user details by ID | No |
| `PUT` | `/users/changepassword` | Change user password | No |
| `PUT` | `/users/{id}` | Update user profile information | No |

### Public Endpoints

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| `GET` | `/products/category/{category}` | Get products by category | No |
| `GET` | `/app/home` | Home page | No |
| `GET` | `/app/about` | About page | No |
| `GET` | `/app/contact` | Contact page | No |
| `GET` | `/app/product` | Product list page | No |
| `GET` | `/app/product-details` | Product details page | No |
| `GET` | `/app/login` | Login page | No |
| `GET` | `/app/registerBuyer` | Buyer registration page | No |
| `GET` | `/app/registerSeller` | Seller registration page | No |

### Cart Management Endpoints

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| `GET` | `/api/cart` | Get buyer's cart items | Yes (Buyer) |
| `POST` | `/api/cart` | Add product to cart | Yes (Buyer) |
| `PUT` | `/api/cart` | Update product quantity in cart | Yes (Buyer) |
| `DELETE` | `/api/cart` | Remove product from cart | Yes (Buyer) |

### Buyer Order Management Endpoints

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| `GET` | `/buyer/orders` | Get all orders for a buyer | No |
| `GET` | `/buyer/orders/{id}` | Get specific order details | No |
| `POST` | `/buyer/orders` | Place a new order | No |
| `PUT` | `/buyer/orders/{id}` | Cancel an order | No |
| `POST` | `/buyer/checkout` | Checkout from cart (session-based) | No |

### Seller Management Endpoints

| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| `POST` | `/api/seller/products` | Add new product | Yes (Seller) |
| `GET` | `/api/seller/products` | Get all products for a seller | Yes (Seller) |
| `GET` | `/api/seller/products/{id}` | Get specific product details | Yes (Seller) |
| `PUT` | `/api/seller/products/{id}` | Update product information | Yes (Seller) |
| `DELETE` | `/api/seller/products/{id}` | Delete a product | Yes (Seller) |
| `GET` | `/api/seller/orders` | Get all orders for a seller | Yes (Seller) |
| `PUT` | `/api/seller/order-status` | Update order status | Yes (Seller) |
| `GET` | `/api/seller/category` | Get all product categories | Yes (Seller) |
| `GET` | `/api/seller/searchProducts` | Search products with filters | Yes (Seller) |
| `GET` | `/api/seller/searchOrders` | Search orders with filters | Yes (Seller) |
| `GET` | `/api/seller/analytics` | Get monthly sales and revenue analytics | Yes (Seller) |

<br>

## Postman Testing JSON Examples

### 1. Register a Buyer

```json
POST http://localhost:8080/montran-ecomm-production/users
Content-Type: application/json

{
    "role": "buyer",
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "password": "Password@123",
    "address": "123 Main St, Anytown"
}

. Register a Seller
JSON

POST http://localhost:8080/montran-ecomm-production/users
Content-Type: application/json

{
    "role": "seller",
    "firstName": "Jane",
    "lastName": "Smith",
    "email": "jane.smith@example.com",
    "password": "Password@123",
    "companyName": "Tech Emporium",
    "address": "456 Business Blvd, Anytown"
}
3. User Login
JSON

POST http://localhost:8080/montran-ecomm-production/users/login
Content-Type: application/json

{
    "email": "john.doe@example.com",
    "password": "Password@123"
}
4. Add a Product (Seller)
JSON

POST http://localhost:8080/montran-ecomm-production/api/seller/products
Content-Type: application/json
Authorization: Bearer {SELLER_JWT_TOKEN}

{
    "name": "Laptop",
    "description": "Powerful laptop for all your needs.",
    "price": 1200.00,
    "stockQuantity": 50,
    "category": "Electronics"
}
5. Add to Cart (Buyer)
JSON

POST http://localhost:8080/montran-ecomm-production/api/cart
Content-Type: application/json
Authorization: Bearer {BUYER_JWT_TOKEN}

{
    "productId": 1,
    "quantity": 2
}
6. Get Monthly Sales Analytics (Seller)
GET http://localhost:8080/montran-ecomm-production/api/seller/analytics
Content-Type: application/json
Authorization: Bearer {SELLER_JWT_TOKEN}
<br>

Validation & Exception Handling
Bean Validation Annotations
@NotBlank, @Email, @Size for user and product data.

@NotNull for required fields.

Custom validation for password strength.

Custom Business Validations
Role-based access control: Controllers validate user roles based on the JWT token (/api/cart/* for Buyers, /api/seller/* for Sellers).

Product uniqueness: Preventing duplicate products from being added by a seller.

Sufficient stock: Checking if the requested quantity is available before adding to cart or placing an order.

Exception Handling
Custom Exceptions:

DuplicateEmailException: For new user registration with an existing email.

ProductNotFoundException: When a product ID is not found.

UserNotFoundException: When a user is not found.

Global Exception Handler (@ControllerAdvice):

A centralized handler for exceptions to return standardized error responses (e.g., HTTP 404 Not Found, HTTP 409 Conflict).

<br>

Security Implementation
JWT Authentication Flow
User logs in with credentials.

AuthController validates credentials.

A JWT is generated and stored in an HttpOnly cookie.

Subsequent requests include this cookie, and the JwtAuthenticationFilter validates the token.

Based on the token, the user's identity and role are set in the SecurityContext.

Role-Based Access Control
Buyer Role: Can manage their cart, place orders, and view their order history.

Seller Role: Can add, update, and delete their products, manage orders from buyers, and view sales analytics.

Access to protected endpoints (/api/cart/*, /api/seller/*) is restricted based on the user's role.

<br>

Database Design & Hibernate Features
Key Hibernate Features Used
Session Management: Handled via Spring and @Transactional for efficient database interactions.

Criteria Queries: Used for building dynamic searches on products and orders.

Entity Mappings: @OneToMany, @ManyToOne, etc., to define relationships between entities like Product and Seller.

Testing Workflow in Postman

Register a new buyer and a new seller.

Login as each user and save the JWT token from the cookie.

As a seller, add new products and update their details.

As a buyer, add items to the cart, update quantities, and place an order.

Test protected endpoints to ensure only authorized users can access them.

Test for validation errors by sending invalid JSON data.

Verify error handling with invalid IDs or actions.
