package com.project.qlst.web;

import com.project.qlst.dao.OrderDAO;
import com.project.qlst.dao.StaffDAO;
import com.project.qlst.dao.OnlineInvoiceDAO;
import com.project.qlst.model.Order;
import com.project.qlst.model.OnlineInvoice;
import com.project.qlst.model.Staff;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "WarehouseStaffExportInvoiceServlet", value = "/warehouse-staff/export-invoice")
public class ExportOnlineInvoiceServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    private StaffDAO staffDAO;
    private OnlineInvoiceDAO onlineInvoiceDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        staffDAO = new StaffDAO();
        onlineInvoiceDAO = new OnlineInvoiceDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/warehouse-staff/process-order");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/warehouse-staff/process-order");
                return;
            }
            
            List<Staff> deliveryStaffList = staffDAO.getStaffByPosition("Delivery Staff");
            
            request.setAttribute("order", order);
            request.setAttribute("deliveryStaffList", deliveryStaffList);
            request.setAttribute("onlineOrder", null);
            
            request.getRequestDispatcher("/WEB-INF/views/ExportOnlineInvoiceView.jsp")
                   .forward(request, response);
                   
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/warehouse-staff/process-order");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        String deliveryStaffIdStr = request.getParameter("deliveryStaffId");
        String action = request.getParameter("action");
        
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/warehouse-staff/process-order");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            
            if ("export".equals(action)) {
                // Chỉ update status của đơn hàng
                boolean updated = orderDAO.updateOrderStatus(orderId, "Shipped");
                
                // Lấy lại thông tin đơn hàng sau khi cập nhật
                Order order = orderDAO.getOrderById(orderId);
                List<Staff> deliveryStaffList = staffDAO.getStaffByPosition("Delivery Staff");
                
                request.setAttribute("order", order);
                request.setAttribute("deliveryStaffList", deliveryStaffList);
                request.setAttribute("onlineOrder", null);
                
                if (updated) {
                    request.setAttribute("success", "Order exported successfully!");
                } else {
                    request.setAttribute("error", "Error exporting order. Please try again.");
                }
                
                // Forward lại trang export invoice với thông báo
                request.getRequestDispatcher("/WEB-INF/views/ExportOnlineInvoiceView.jsp")
                       .forward(request, response);
                       
            } else if ("print".equals(action)) {
                // Lấy warehouseStaffId từ session hoặc request (tạm thời dùng 1)
                // TODO: Lấy từ session khi có authentication
                int warehouseStaffId = 1; // Tạm thời hardcode
                
                if (deliveryStaffIdStr == null || deliveryStaffIdStr.trim().isEmpty()) {
                    request.setAttribute("error", "Please select delivery staff before printing invoice.");
                    doGet(request, response);
                    return;
                }
                
                int deliveryStaffId = Integer.parseInt(deliveryStaffIdStr);
                OnlineInvoice onlineOrder = onlineInvoiceDAO.createOnlineInvoice(orderId, warehouseStaffId, deliveryStaffId);
                
                if (onlineOrder == null) {
                    request.setAttribute("error", "Error creating invoice. Please try again.");
                    doGet(request, response);
                    return;
                }
                
                // Lấy lại thông tin đơn hàng
                Order order = orderDAO.getOrderById(orderId);
                List<Staff> deliveryStaffList = staffDAO.getStaffByPosition("Delivery Staff");
                
                request.setAttribute("order", order);
                request.setAttribute("deliveryStaffList", deliveryStaffList);
                request.setAttribute("onlineOrder", onlineOrder);
                
                // Forward lại trang để in
                request.getRequestDispatcher("/WEB-INF/views/ExportOnlineInvoiceView.jsp")
                       .forward(request, response);
                       
            } else {
                // Hiển thị lại form
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/warehouse-staff/process-order");
        }
    }
}

