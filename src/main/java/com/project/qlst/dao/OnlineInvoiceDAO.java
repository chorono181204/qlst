package com.project.qlst.dao;

import com.project.qlst.model.*;
import com.project.qlst.util.JDBCUtil;

import java.sql.*;

public class OnlineInvoiceDAO {
    
    private OrderDAO orderDAO;
    
    public OnlineInvoiceDAO() {
        this.orderDAO = new OrderDAO();
    }
    
    public OnlineInvoice createOnlineInvoice(int orderId, int warehouseStaffId, int deliveryStaffId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "INSERT INTO tblOnlineInvoice (tblOrderId, tblWareHouseStaffId, tblDeliveryStaffId, deliveryFee, deliveryDate) " +
                        "VALUES (?, ?, ?, 0, CURDATE())";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            stmt.setInt(2, warehouseStaffId);
            stmt.setInt(3, deliveryStaffId);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
           
                String selectSql = "SELECT * FROM tblOnlineInvoice WHERE tblOrderId = ?";
                PreparedStatement selectStmt = conn.prepareStatement(selectSql);
                selectStmt.setInt(1, orderId);
                rs = selectStmt.executeQuery();
                
                if (rs.next()) {
                    Order order = orderDAO.getOrderById(orderId);
                    
                    // Lấy thông tin Warehouse Staff bằng query trực tiếp
                    String warehouseStaffSql = "SELECT s.id as staffId, s.position, u.firstName, u.lastName, u.email, u.phone, u.id as userId " +
                                             "FROM tblStaff s " +
                                             "INNER JOIN tblMember u ON s.tblUserId = u.id " +
                                             "WHERE s.id = ?";
                    PreparedStatement warehouseStmt = conn.prepareStatement(warehouseStaffSql);
                    warehouseStmt.setInt(1, warehouseStaffId);
                    ResultSet warehouseRs = warehouseStmt.executeQuery();
                    
                    Staff warehouseStaff = null;
                    if (warehouseRs.next()) {
                        Member warehouseUser = new Member(
                            warehouseRs.getString("firstName"),
                            warehouseRs.getString("lastName"),
                            warehouseRs.getString("email"),
                            warehouseRs.getString("phone"),
                            null,
                            null
                        );
                        warehouseUser.setId(warehouseRs.getInt("userId"));
                        
                        warehouseStaff = new Staff(
                            warehouseRs.getString("position"),
                            warehouseUser
                        );
                        warehouseStaff.setId(warehouseRs.getInt("staffId"));
                    }
                    warehouseRs.close();
                    warehouseStmt.close();
                    
                    // Lấy thông tin Delivery Staff bằng query trực tiếp
                    String deliveryStaffSql = "SELECT s.id as staffId, s.position, u.firstName, u.lastName, u.email, u.phone, u.id as userId " +
                                             "FROM tblStaff s " +
                                             "INNER JOIN tblMember u ON s.tblUserId = u.id " +
                                             "WHERE s.id = ?";
                    PreparedStatement deliveryStmt = conn.prepareStatement(deliveryStaffSql);
                    deliveryStmt.setInt(1, deliveryStaffId);
                    ResultSet deliveryRs = deliveryStmt.executeQuery();
                    
                    Staff deliveryStaff = null;
                    if (deliveryRs.next()) {
                        Member deliveryUser = new Member(
                            deliveryRs.getString("firstName"),
                            deliveryRs.getString("lastName"),
                            deliveryRs.getString("email"),
                            deliveryRs.getString("phone"),
                            null,
                            null
                        );
                        deliveryUser.setId(deliveryRs.getInt("userId"));
                        
                        deliveryStaff = new Staff(
                            deliveryRs.getString("position"),
                            deliveryUser
                        );
                        deliveryStaff.setId(deliveryRs.getInt("staffId"));
                    }
                    deliveryRs.close();
                    deliveryStmt.close();
                    
                    OnlineInvoice onlineInvoice = new OnlineInvoice(
                        rs.getDate("deliveryDate"),
                        order,
                        warehouseStaff,
                        deliveryStaff
                    );
                    onlineInvoice.setId(rs.getInt("id"));
                    
                    selectStmt.close();
                    return onlineInvoice;
                }
                selectStmt.close();
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return null;
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
