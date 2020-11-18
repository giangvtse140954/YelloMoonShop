/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblorderdetail;

import giangvt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.naming.NamingException;

/**
 *
 * @author MY HP
 */
public class TblOrderDetailDAO implements Serializable {
    public boolean addDetail(UUID orderId, int proId, double price, int quantity) 
        throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert Into tblOrderDetail (orderId, proId, price, quantity) "
                        + "Values(?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderId + "");
                stm.setInt(2, proId);
                stm.setDouble(3, price);
                stm.setInt(4, quantity);
                
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
    
    public List<TblOrderDetailDTO> getDetail(UUID orderId) 
        throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<TblOrderDetailDTO> list = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select detailId, proId, price, quantity "
                        + "From tblOrderDetail "
                        + "Where orderId = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderId + "");
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("detailId");
                    int proId = rs.getInt("proId");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(new TblOrderDetailDTO(id, orderId, proId, price, quantity));
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
        return list;
    }
}
