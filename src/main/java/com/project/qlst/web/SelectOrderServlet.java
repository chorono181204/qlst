package com.project.qlst.web;

import com.project.qlst.dao.OrderDAO;
import com.project.qlst.model.Order;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "WarehouseStaffProcessOrderServlet", value = "/warehouse-staff/process-order")
public class SelectOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Order> pendingOrders = orderDAO.getOrderByStatus("Pending");
        request.setAttribute("orders", pendingOrders);
        request.getRequestDispatcher("/WEB-INF/views/SelectOrderView.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

