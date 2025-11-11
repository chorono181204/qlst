package com.project.qlst.dao;

import com.project.qlst.model.Product;
import com.project.qlst.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public List<Product> getProductsByName(String keyword) {
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT * FROM tblProduct WHERE name LIKE ? OR code LIKE ? OR description LIKE ?";
            stmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = new Product(
                    rs.getString("code"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getFloat("price"),
                    rs.getInt("stock")
                );
                product.setId(rs.getInt("id"));
                products.add(product);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return products;
    }
    
    public Product getProductDetail(int productId) {
        Product product = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT * FROM tblProduct WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                product = new Product(
                    rs.getString("code"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getFloat("price"),
                    rs.getInt("stock")
                );
                product.setId(rs.getInt("id"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return product;
    }
    
    private void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

