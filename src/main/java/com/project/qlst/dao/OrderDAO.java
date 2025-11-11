package com.project.qlst.dao;

import com.project.qlst.model.*;
import com.project.qlst.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    
    public List<Order> getOrderByStatus(String status) {
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT o.*, c.customerCode, c.id as customerId, " +
                        "u.firstName, u.lastName, u.email, u.phone, u.id as userId, " +
                        "a.id as addressId, a.province, a.district, a.ward, a.street " +
                        "FROM tblOrder o " +
                        "INNER JOIN tblCustomer c ON o.tblCustomerId = c.id " +
                        "INNER JOIN tblMember u ON c.tblUserId = u.id " +
                        "INNER JOIN tblAddress a ON u.tblAddressId = a.id " +
                        "WHERE o.status = ? " +
                        "ORDER BY o.orderDate DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Address address = new Address(
                    rs.getString("province"),
                    rs.getString("district"),
                    rs.getString("ward"),
                    rs.getString("street")
                );
                address.setId(rs.getInt("addressId"));

                Member user = new Member(
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    null,
                    address
                );
                user.setId(rs.getInt("userId"));
                
                Customer customer = new Customer(
                    rs.getString("customerCode"),
                    user
                );
                customer.setId(rs.getInt("customerId"));
                
                Order order = new Order(
                    rs.getString("code"),
                    rs.getDate("orderDate"),
                    rs.getString("status"),
                    rs.getFloat("totalAmount"),
                    rs.getString("paymentMethod"),
                    customer
                );
                order.setId(rs.getInt("o.id"));
                orders.add(order);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return orders;
    }
    
    public Order getOrderById(int orderId) {
        Order order = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT o.*, c.customerCode, c.id as customerId, " +
                        "u.firstName, u.lastName, u.email, u.phone, u.id as userId, " +
                        "a.id as addressId, a.province, a.district, a.ward, a.street " +
                        "FROM tblOrder o " +
                        "INNER JOIN tblCustomer c ON o.tblCustomerId = c.id " +
                        "INNER JOIN tblMember u ON c.tblUserId = u.id " +
                        "INNER JOIN tblAddress a ON u.tblAddressId = a.id " +
                        "WHERE o.id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                Address address = new Address(
                    rs.getString("province"),
                    rs.getString("district"),
                    rs.getString("ward"),
                    rs.getString("street")
                );
                address.setId(rs.getInt("addressId"));

                Member user = new Member(
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    null,
                    address
                );
                user.setId(rs.getInt("userId"));
                
                Customer customer = new Customer(
                    rs.getString("customerCode"),
                    user
                );
                customer.setId(rs.getInt("customerId"));
                
                order = new Order(
                    rs.getString("code"),
                    rs.getDate("orderDate"),
                    rs.getString("status"),
                    rs.getFloat("totalAmount"),
                    rs.getString("paymentMethod"),
                    customer
                );
                order.setId(rs.getInt("o.id"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return order;
    }
    
    
    public boolean updateOrderStatus(int orderId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "UPDATE tblOrder SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
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

