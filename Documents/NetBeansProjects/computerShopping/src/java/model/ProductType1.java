/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Mickey
 */
public class ProductType1 extends Products{
    private double powerConsumption;
    
    public ProductType1()
    {
        
    }

    public double getPowerConsumption() {
        return powerConsumption;
    }

    public void setPowerConsumption(double powerConsumption) {
        this.powerConsumption = powerConsumption;
    }
    
    @Override
    public void updateDB(int inStock, Connection conn)
    {
        try
        {
            String sql = "update products set productName = ?, description = ?, inStock = ?, price = ? where productId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, inStock);
            ps.setDouble(4, price);
            ps.setString(5, id);
            ps.executeUpdate();
            sql = "update producttype1 set powerConsumption = ? where productId = ?";
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, powerConsumption);
            ps.setString(2, id);
            ps.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
