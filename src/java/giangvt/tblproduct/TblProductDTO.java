/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblproduct;

import java.io.Serializable;

/**
 *
 * @author MY HP
 */
public class TblProductDTO implements Serializable {

    private int proId;
    private String name;
    private double price;
    private int quantity;
    private int cateId;
    private String image;
    private String description;
    private String createDate;
    private String expiredDate;
    private String status;

    public TblProductDTO() {
    }

    public TblProductDTO(int proId, String name, double price, int quantity, int cateId, String image, String description, String createDate, String expiredDate, String status) {
        this.proId = proId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.cateId = cateId;
        this.image = image;
        this.description = description;
        this.createDate = createDate;
        this.expiredDate = expiredDate;
        this.status = status;
    }

    public int getProId() {
        return proId;
    }

    public void setProId(int proId) {
        this.proId = proId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(String expiredDate) {
        this.expiredDate = expiredDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
