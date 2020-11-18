/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblorder;

import giangvt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
import javax.naming.NamingException;

/**
 *
 * @author MY HP
 */
public class TblOrderDAO implements Serializable {

    public boolean addOrder(TblOrderDTO dto)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert Into TblOrder(userId, total, date, name, address, status, phone) "
                        + "Values(?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUserId());
                stm.setDouble(2, dto.getTotal());
                stm.setString(3, dto.getDate());
                stm.setString(4, dto.getName());
                stm.setString(5, dto.getAddress());
                stm.setString(6, dto.getStatus());
                stm.setString(7, dto.getPhone());
                int row = stm.executeUpdate();

                if (row > 0) {
                    result = true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }

    public UUID getKey(TblOrderDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UUID key = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select orderId "
                        + "From tblOrder "
                        + "Where userId = ? And date = ? And total = ? And "
                        + "address = ? And status like ? And "
                        + "phone = ? And name = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUserId());
                stm.setString(2, dto.getDate());
                stm.setDouble(3, dto.getTotal());
                stm.setString(4, dto.getAddress());
                stm.setString(5, dto.getStatus());
                stm.setString(6, dto.getPhone());
                stm.setString(7, dto.getName());
                rs = stm.executeQuery();
                if (rs.next()) {
                    key = UUID.fromString(rs.getString("orderId"));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return key;
    }

    public UUID getKey(String date, double total, String addr,
            String status, String phone, String name)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UUID key = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select orderId "
                        + "From tblOrder "
                        + "Where userId Is NULL And date = ? And total = ? And "
                        + "address = ? And status like ? And "
                        + "phone = ? And name = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, date);
                stm.setDouble(2, total);
                stm.setString(3, addr);
                stm.setString(4, status);
                stm.setString(5, phone);
                stm.setString(6, name);
                rs = stm.executeQuery();
                if (rs.next()) {
                    key = UUID.fromString(rs.getString("orderId"));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return key;
    }

    public TblOrderDTO searchOrder(UUID orderId, String userId)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblOrderDTO dto = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select total, date, name, address, status, phone "
                        + "From tblOrder "
                        + "Where userId = ? And orderId = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setString(2, orderId + "");

                rs = stm.executeQuery();
                if (rs.next()) {
                    double total = rs.getDouble("total");
                    String date = rs.getString("date");
                    String name = rs.getString("name");
                    String addr = rs.getString("address");
                    String status = rs.getString("status");
                    String phone = rs.getString("phone");
                    
                    dto = new TblOrderDTO(orderId, userId, total, date, name, addr, status, phone);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }

}
