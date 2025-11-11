package com.project.qlst.web;

import com.project.qlst.dao.ProductDAO;
import com.project.qlst.model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerSearchProductServlet", value = "/customer/search-product")
public class SearchProductServlet extends HttpServlet {
    
    private ProductDAO productDAO;
    
    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
      
        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Product> products = productDAO.getProductsByName(keyword.trim());
            request.setAttribute("products", products);
            request.setAttribute("keyword", keyword);
        }
        request.getRequestDispatcher("/WEB-INF/views/CustomerSearchProductView.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
