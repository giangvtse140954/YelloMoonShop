/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblproduct;

import giangvt.util.DBHelper;
import java.io.Serializable;
import java.sql.CallableStatement;
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
public class TblProductDAO implements Serializable {

    private final int ROW = 20;

    public List<TblProductDTO> searchCake(int pageNum, String sName, double lowPrice, double highPrice,
            int sCateId, int role)
            throws SQLException, NamingException {
        Connection con = null;
        CallableStatement stm = null;
        ResultSet rs = null;
        List<TblProductDTO> allPro = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                if (role == 1 && sCateId != -1) {
                    String sql = "{call getProFromAd(?, ?, ?, ?, ?, ?)}";
                    stm = con.prepareCall(sql);
                    stm.setInt(1, pageNum);
                    stm.setInt(2, ROW);
                    stm.setString(3, sName);
                    stm.setDouble(4, lowPrice);
                    stm.setDouble(5, highPrice);
                    stm.setInt(6, sCateId);
                } else if (role == 1 && sCateId == -1) {
                    String sql = "{call getProFromAdAcceptCate(?, ?, ?, ?, ?)}";
                    stm = con.prepareCall(sql);
                    stm.setInt(1, pageNum);
                    stm.setInt(2, ROW);
                    stm.setString(3, sName);
                    stm.setDouble(4, lowPrice);
                    stm.setDouble(5, highPrice);
                } else if (role != 1 && sCateId != -1) {
                    String sql = "{call getProFromEmp(?, ?, ?, ?, ?, ?)}";
                    stm = con.prepareCall(sql);
                    stm.setInt(1, pageNum);
                    stm.setInt(2, ROW);
                    stm.setString(3, sName);
                    stm.setDouble(4, lowPrice);
                    stm.setDouble(5, highPrice);
                    stm.setInt(6, sCateId);
                } else if (role != 1 && sCateId == -1) {
                    String sql = "{call getProFromEmpAcceptCate(?, ?, ?, ?, ?)}";
                    stm = con.prepareCall(sql);
                    stm.setInt(1, pageNum);
                    stm.setInt(2, ROW);
                    stm.setString(3, sName);
                    stm.setDouble(4, lowPrice);
                    stm.setDouble(5, highPrice);
                }
                if (stm != null) {
                    rs = stm.executeQuery();

                    while (rs.next()) {
                        int proId = rs.getInt("proId");
                        String name = rs.getString("name");
                        double price = rs.getDouble("price");
                        int quantity = rs.getInt("quantity");
                        int cateId = rs.getInt("cateId");
                        String image = rs.getString("image");
                        String createDate = rs.getString("createDate");
                        String description = rs.getString("description");
                        String expiredDate = rs.getString("expiredDate");
                        String st = rs.getString("status");

                        if (allPro == null) {
                            allPro = new ArrayList<>();
                        }
                        allPro.add(new TblProductDTO(proId, name, price, quantity, cateId,
                                image, description, createDate, expiredDate, st));
                    }
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
        return allPro;
    }

    public double getMaxPrice()
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        double max = 0;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select MAX(price) as maxPrice "
                        + "From tblProduct";

                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    max = rs.getDouble("maxPrice");
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
        return max;
    }

    public TblProductDTO getProductById(int proId)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TblProductDTO pro = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select name, price, quantity, cateId, image, description, "
                        + "expiredDate, createDate, status "
                        + "From tblProduct "
                        + "Where proId = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, proId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    int cateId = rs.getInt("cateId");
                    String image = rs.getString("image");
                    String des = rs.getString("description");
                    String expiredDate = rs.getString("expiredDate");
                    String createDate = rs.getString("createDate");
                    String status = rs.getString("status");

                    pro = new TblProductDTO(proId, name, price, quantity,
                            cateId, image, des, createDate, expiredDate, status);
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
        return pro;
    }

    public boolean updateCake(TblProductDTO dto)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update tblProduct "
                        + "Set name = ?, price = ?, quantity = ?, cateId = ?, image = ?, "
                        + "expiredDate = ?, createDate = ?, status = ? "
                        + "Where proId = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setDouble(2, dto.getPrice());
                stm.setInt(3, dto.getQuantity());
                stm.setInt(4, dto.getCateId());
                stm.setString(5, dto.getImage());
                stm.setString(6, dto.getExpiredDate());
                stm.setString(7, dto.getCreateDate());
                stm.setString(8, dto.getStatus());
                stm.setInt(9, dto.getProId());

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

    public int createCake(TblProductDTO dto)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String[] key = {"proId"};
        int id = -1;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert Into tblProduct (name, price, quantity, cateId, image, "
                        + "expiredDate, createDate, description, status) "
                        + "Values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql, key);
                stm.setString(1, dto.getName());
                stm.setDouble(2, dto.getPrice());
                stm.setInt(3, dto.getQuantity());
                stm.setInt(4, dto.getCateId());
                stm.setString(5, dto.getImage());
                stm.setString(6, dto.getExpiredDate());
                stm.setString(7, dto.getCreateDate());
                stm.setString(8, dto.getDescription());
                stm.setString(9, dto.getStatus());

                int result = stm.executeUpdate();
                if (result > 0) {
                    rs = stm.getGeneratedKeys();
                    if (rs.next()) {
                        id = rs.getInt(1);
                    }
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
        return id;
    }
    
    public boolean updateCake(int proId, int quantity, String status) 
        throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Update tblProduct "
                        + "Set quantity = ?, status = ? "
                        + "Where proId = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, quantity);
                stm.setString(2, status);
                stm.setInt(3, proId);
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
