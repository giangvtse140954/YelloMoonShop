/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tbllog;

import giangvt.util.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author MY HP
 */
public class TblLogDAO implements Serializable {
    public boolean addLog(TblLogDTO dto) 
        throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert Into tblLog(userId, proId, date) "
                        + "Values(?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUserId());
                stm.setInt(2, dto.getProId());
                stm.setString(3, dto.getDate());
                
                int result = stm.executeUpdate();
                if (result > 0) {
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
