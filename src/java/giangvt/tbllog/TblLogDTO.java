/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.tbllog;

import java.io.Serializable;

/**
 *
 * @author MY HP
 */
public class TblLogDTO implements Serializable {
    private int logId;
    private String userId;
    private int proId;
    private String date;

    public TblLogDTO() {
    }

    public TblLogDTO(int logId, String userId, int proId, String date) {
        this.logId = logId;
        this.userId = userId;
        this.proId = proId;
        this.date = date;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getProId() {
        return proId;
    }

    public void setProId(int proId) {
        this.proId = proId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
}
