/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblorderdetail;

import java.io.Serializable;
import java.util.UUID;

/**
 *
 * @author MY HP
 */
public class TblOrderDetailDTO implements Serializable {
    private int detailId;
    private UUID orderId;
    private int proId;
    private double price;
    private int quantity;

    public TblOrderDetailDTO() {
    }

    public TblOrderDetailDTO(int detailId, UUID orderId, int proId, double price, int quantity) {
        this.detailId = detailId;
        this.orderId = orderId;
        this.proId = proId;
        this.price = price;
        this.quantity = quantity;
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public UUID getOrderId() {
        return orderId;
    }

    public void setOrderId(UUID orderId) {
        this.orderId = orderId;
    }

    public int getProId() {
        return proId;
    }

    public void setProId(int proId) {
        this.proId = proId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
