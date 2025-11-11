package com.project.qlst.dao;

import com.project.qlst.model.*;
import com.project.qlst.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {
    
    public List<Staff> getStaffByPosition(String position) {
        List<Staff> staffList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCUtil.getConnection();
            String sql = "SELECT s.id as staffId, s.position, u.firstName, u.lastName, u.email, u.phone, u.id as userId " +
                        "FROM tblStaff s " +
                        "INNER JOIN tblMember u ON s.tblUserId = u.id " +
                        "WHERE s.position = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, position);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Member user = new Member(
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    null,
                    null
                );
                user.setId(rs.getInt("userId"));
                
                Staff staff = new Staff(
                    rs.getString("position"),
                    user
                );
                staff.setId(rs.getInt("staffId"));
                staffList.add(staff);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return staffList;
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

