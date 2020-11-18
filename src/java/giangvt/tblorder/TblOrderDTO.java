/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblorder;

import java.io.Serializable;
import java.util.UUID;

/**
 *
 * @author MY HP
 */
public class TblOrderDTO implements Serializable {
    private UUID orderId;
    private String userId;
    private double total;
    private String date;
    private String name;
    private String address;
    private String status;
    private String phone;

    public TblOrderDTO() {
    }

    public TblOrderDTO(UUID orderId, String userId, double total, String date, String name, String address, String status, String phone) {
        this.orderId = orderId;
        this.userId = userId;
        this.total = total;
        this.date = date;
        this.name = name;
        this.address = address;
        this.status = status;
        this.phone = phone;
    }

    public UUID getOrderId() {
        return orderId;
    }

    public void setOrderId(UUID orderId) {
        this.orderId = orderId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    
}
