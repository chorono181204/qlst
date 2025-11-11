<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Order</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/warehouse-process-order.css">
</head>
<body>
    <div class="container">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/warehouse-staff/main" class="back-btn">← Back to Home</a>
        </div>
        
        <h1>Select Order</h1>
        
        <c:if test="${param.success == '1'}">
            <div class="alert alert-success">
                Order exported successfully!
            </div>
        </c:if>
        
        <c:if test="${param.error == '1'}">
            <div class="alert alert-error">
                Error exporting order. Please try again.
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty orders or orders.size() == 0}">
                <div class="no-orders">
                    <p>No pending orders found.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Order Code</th>
                            <th>Customer</th>
                            <th>Order Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${order.code}</td>
                                <td>${order.customer.user.firstName} ${order.customer.user.lastName}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></td>
                                <td class="price">
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                                </td>
                                <td class="status ${order.status.toLowerCase()}">${order.status}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/warehouse-staff/export-invoice?orderId=${order.id}" class="export-btn">
                                        Export
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>








