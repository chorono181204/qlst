<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Export Invoice</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/warehouse-export-invoice.css">
</head>
<body>
    <div class="container">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/warehouse-staff/process-order" class="back-btn">← Back to Orders</a>
        </div>
        
        <h1>Export Invoice</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ${error}
            </div>
        </c:if>
        
        <c:if test="${empty order}">
            <div class="error-message">
                <h2>Order not found</h2>
                <p>The order you are looking for does not exist.</p>
            </div>
        </c:if>
        
        <c:if test="${not empty order}">
            <div class="invoice-section">
                <h2>Order Information</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="label">Order Code:</span>
                        <span class="value">${order.code}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Order Date:</span>
                        <span class="value"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></span>
                    </div>
                    <div class="info-item">
                        <span class="label">Customer:</span>
                        <span class="value">${order.customer.user.firstName} ${order.customer.user.lastName}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Phone:</span>
                        <span class="value">${order.customer.user.phone}</span>
                    </div>
                    <c:if test="${not empty order.customer.user.address}">
                        <div class="info-item">
                            <span class="label">Address:</span>
                            <span class="value">
                                ${order.customer.user.address.street},
                                ${order.customer.user.address.ward},
                                ${order.customer.user.address.district},
                                ${order.customer.user.address.province}
                            </span>
                        </div>
                    </c:if>
                    <div class="info-item">
                        <span class="label">Payment Method:</span>
                        <span class="value">${order.paymentMethod}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Status:</span>
                        <span class="value">${order.status}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Total Amount:</span>
                        <span class="value">
                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" maxFractionDigits="0" />₫
                        </span>
                    </div>
                </div>
            </div>

            <c:if test="${not empty onlineOrder}">
                <div class="invoice-section">
                    <h2>Invoice Information</h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="label">Delivery Date:</span>
                            <span class="value">
                                <fmt:formatDate value="${onlineOrder.deliveryDate}" pattern="yyyy-MM-dd" />
                            </span>
                        </div>
                    </div>
                </div>

                <div class="invoice-section">
                    <h2>Staff Information</h2>
                    <div class="info-grid">
                        <c:if test="${not empty onlineOrder.warehouseStaff}">
                            <div class="info-item">
                                <span class="label">Warehouse Staff:</span>
                                <span class="value">
                                    ${onlineOrder.warehouseStaff.user.firstName} ${onlineOrder.warehouseStaff.user.lastName}
                                    - ${onlineOrder.warehouseStaff.user.phone}
                                    (${onlineOrder.warehouseStaff.position})
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${not empty onlineOrder.deliveryStaff}">
                            <div class="info-item">
                                <span class="label">Delivery Staff:</span>
                                <span class="value">
                                    ${onlineOrder.deliveryStaff.user.firstName} ${onlineOrder.deliveryStaff.user.lastName}
                                    - ${onlineOrder.deliveryStaff.user.phone}
                                    (${onlineOrder.deliveryStaff.position})
                                </span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/warehouse-staff/export-invoice" method="post" class="export-form" id="exportForm">
                <input type="hidden" name="orderId" value="${order.id}">
                <input type="hidden" name="action" id="actionInput" value="export">
                
                <div class="form-group">
                    <label for="deliveryStaffId">Select Delivery Staff:</label>
                    <select name="deliveryStaffId" id="deliveryStaffId">
                        <option value="">-- Select Delivery Staff --</option>
                        <c:forEach var="staff" items="${deliveryStaffList}">
                            <option value="${staff.id}" ${not empty onlineOrder and onlineOrder.deliveryStaff.id == staff.id ? 'selected' : ''}>
                                ${staff.user.firstName} ${staff.user.lastName} - ${staff.user.phone}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="button-group-form">
                    <button type="submit" class="export-btn">Export order</button>
                    <button type="button" onclick="printInvoice()" class="print-btn">Print Invoice</button>
                </div>
            </form>
            
            <script>
                function printInvoice() {
                    var deliveryStaffId = document.getElementById('deliveryStaffId').value;
                    if (!deliveryStaffId) {
                        alert('Please select delivery staff before printing invoice.');
                        return;
                    }
                    document.getElementById('actionInput').value = 'print';
                    document.getElementById('exportForm').submit();
                }
            </script>
        </c:if>
    </div>
</body>
</html>

