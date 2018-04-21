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
public class ProductType2 extends Products{
    private double powerConsumption;
    private String compatibility;
    
    public ProductType2()
    {
        
    }

    public double getPowerConsumption() {
        return powerConsumption;
    }

    public void setPowerConsumption(double powerConsumption) {
        this.powerConsumption = powerConsumption;
    }

    public String getCompatibility() {
        return compatibility;
    }

    public void setCompatibility(String compatibility) {
        this.compatibility = compatibility;
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
            sql = "update producttype2 set powerConsumption = ?, compatibility = ? where productId = ?";
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, powerConsumption);
            ps.setString(2, compatibility);
            ps.setString(3, id);
            ps.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
    
    @Override
    public void addToDB(int inStock, Connection conn)
    {
        try
        {
            String sql = "insert into products values (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, name);
            ps.setString(3, description);
            ps.setInt(4, inStock);
            ps.setDouble(5, price);
            ps.setString(6, "type2");
            ps.executeUpdate();
            sql = "insert into producttype2 values (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setDouble(2, powerConsumption);
            ps.setString(3, compatibility);
            ps.executeUpdate();
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
}
