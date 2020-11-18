/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblcate;

import giangvt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author MY HP
 */
public class TblCateDAO implements Serializable {
    public String getName(int cateId) 
        throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String name = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select name "
                        + "From tblCate "
                        + "Where cateId = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, cateId);
                rs = stm.executeQuery();
                
                if (rs.next()) {
                    name = rs.getString("name");
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
        return name;
    }
    
    public List<TblCateDTO> getCateList() 
        throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<TblCateDTO> list = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select cateId, name "
                        + "From tblCate";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                
                while (rs.next()) {
                    int id = rs.getInt("cateId");
                    String name = rs.getString("name");
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(new TblCateDTO(id, name));
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
