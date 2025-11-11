<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/customer-search.css">
</head>
<body>
    <div class="container">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/customer/main" class="back-btn">← Back to Home</a>
        </div>
        
        <h1>Search Products</h1>
        
        <form action="${pageContext.request.contextPath}/customer/search-product" 
              method="get" class="search-form">
            <input type="text" 
                   name="keyword" 
                   class="search-input" 
                   placeholder="Enter product name, code, or description..." 
                   value="${keyword}">
            <button type="submit" class="search-btn">Search</button>
        </form>
        
        <c:if test="${not empty keyword}">
            <div class="results-info">
                <strong>Keyword:</strong> "${keyword}" | 
                <strong>Results:</strong> ${products.size()}
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty products or products.size() == 0}">
                <c:if test="${not empty keyword}">
                    <div class="no-results">
                        <div class="no-results-icon">📭</div>
                        <h3>No products found</h3>
                        <p>Please try again with a different keyword</p>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <table class="product-table">
                    <thead>
                        <tr>
                            <th class="stt">STT</th>
                            <th>PRODUCT NAME</th>
                            <th>PRICE</th>
                            <th>STOCK</th>
                            <th>ACTION</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}" varStatus="status">
                            <tr>
                                <td class="stt">${status.index + 1}</td>
                                <td>${product.name}</td>
                                <td class="price">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                                </td>
                                <td class="stock ${product.stock == 0 ? 'out-of-stock' : ''}">
                                    <c:choose>
                                        <c:when test="${product.stock == 0}">
                                            Out of Stock
                                        </c:when>
                                        <c:otherwise>
                                            ${product.stock}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/customer/product-detail?id=${product.id}" class="view-detail-btn">
                                        View Details
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        function viewDetail(productId) {
            // Can be implemented later to navigate to product detail page
            alert('View product details for ID: ' + productId);
        }
    </script>
</body>
</html>
