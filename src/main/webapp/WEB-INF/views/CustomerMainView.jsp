<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/customer-main.css">
</head>
<body>
    <div class="container">
        <h1>Customer Main View</h1>
        
        
        <div class="menu">
            <a href="${pageContext.request.contextPath}/customer/search-product" class="menu-btn">
                Search Products
            </a>
        </div>
    </div>
</body>
</html>
