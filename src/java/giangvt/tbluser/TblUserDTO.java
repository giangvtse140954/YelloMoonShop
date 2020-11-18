/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tbluser;

import java.io.Serializable;

/**
 *
 * @author MY HP
 */
public class TblUserDTO implements Serializable {
    private String userId;
    private String name;
    private String phone;
    private String address;
    private int roleId;
    private String password;

    public TblUserDTO() {
    }

    public TblUserDTO(String userId, String name, String phone, String address, int roleId, String password) {
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.roleId = roleId;
        this.password = password;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

}
