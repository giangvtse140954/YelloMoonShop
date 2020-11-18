/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tbluser;

import giangvt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author MY HP
 */
public class TblUserDAO implements Serializable {

    public TblUserDTO checkLogin(String userId, String password)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblUserDTO dto = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select userId, name, roleId, phone, address "
                        + "From tblUser "
                        + "Where userId = ? And password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setString(2, password);
                rs = stm.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    int role = rs.getInt("roleId");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");

                    dto = new TblUserDTO(userId, name, phone, address, role, "");
                }
            }
        } finally {
            if (rs != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                rs.close();
            }
        }
        return dto;
    }

    public boolean createAccount(TblUserDTO dto, String pwd)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert Into tblUser(userId, name, phone, address, roleId, password) "
                        + "Values(?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUserId());
                stm.setString(2, dto.getName());
                stm.setString(3, dto.getPhone());
                stm.setString(4, dto.getAddress());
                stm.setInt(5, dto.getRoleId());
                stm.setString(6, pwd);

                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
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

        return false;
    }
}
