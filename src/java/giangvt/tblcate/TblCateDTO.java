/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tblcate;

import java.io.Serializable;

/**
 *
 * @author MY HP
 */
public class TblCateDTO implements Serializable {
    private int cateId;
    private String name;

    public TblCateDTO() {
    }

    public TblCateDTO(int cateId, String name) {
        this.cateId = cateId;
        this.name = name;
    }

    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
}
