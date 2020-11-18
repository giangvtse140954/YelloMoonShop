/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.cart;

import giangvt.tblproduct.TblProductDTO;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author MY HP
 */
public class CartObject implements Serializable {

    private Map<Integer, TblProductDTO> items;

    public Map<Integer, TblProductDTO> getItems() {
        return this.items;
    }

    public void addItemToCart(TblProductDTO item) {
        if (this.items == null) {
            this.items = new HashMap<>();
        }

        int quantity = 1;
        if (this.items.containsKey(item.getProId())) {
            quantity = this.items.get(item.getProId()).getQuantity() + 1;
        }
        item.setQuantity(quantity);
        this.items.put(item.getProId(), item);
    }

    public void subCake(int id) {
        if (this.items == null) {
            return;
        }
        
        int quantity = 0;
        if (this.items.containsKey(id)) {
            TblProductDTO value = items.get(id);
            quantity = value.getQuantity() - 1;
            
            value.setQuantity(quantity);
            if (quantity <= 0) {
                items.remove(id);
            }
            if (items.isEmpty()) {
                items = null;
            }
        }
    }
    
    public void removeItemFromCart(Integer id) {
        if (this.items == null) {
            return;
        }
        if (this.items.containsKey(id)) {
            this.items.remove(id);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }
    
    public void addOrder(TblProductDTO dto) {
        if (this.items == null) {
            this.items = new HashMap<>();
        }
        this.items.put(dto.getProId(), dto);
    }
    
}
