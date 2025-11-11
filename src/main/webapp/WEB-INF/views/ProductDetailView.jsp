<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/product-detail.css">
</head>
<body>
    <div class="container">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/customer/search-product" class="back-btn">← Back to Search</a>
        </div>
        
        <c:if test="${empty product}">
            <div class="error-message">
                <h2>Product not found</h2>
                <p>The product you are looking for does not exist.</p>
                <a href="${pageContext.request.contextPath}/customer/search-product" class="back-btn">Back to Search</a>
            </div>
        </c:if>
        
        <c:if test="${not empty product}">
            <div class="product-detail">
                <h1>Product Details</h1>
                
                <div class="product-info">
                    <div class="info-row">
                        <span class="label">Product Code:</span>
                        <span class="value">${product.code}</span>
                    </div>
                    
                    <div class="info-row">
                        <span class="label">Product Name:</span>
                        <span class="value name">${product.name}</span>
                    </div>
                    
                    <div class="info-row">
                        <span class="label">Description:</span>
                        <span class="value description">${product.description}</span>
                    </div>
                    
                    <div class="info-row">
                        <span class="label">Price:</span>
                        <span class="value price">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                        </span>
                    </div>
                    
                    <div class="info-row">
                        <span class="label">Stock:</span>
                        <span class="value stock ${product.stock == 0 ? 'out-of-stock' : 'in-stock'}">
                            <c:choose>
                                <c:when test="${product.stock == 0}">
                                    Out of Stock
                                </c:when>
                                <c:otherwise>
                                    ${product.stock} items 
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

