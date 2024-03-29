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
public class Products implements java.io.Serializable{

    protected String id;
    protected String name;
    protected String description;
    protected double price;

    public Products() {

    }

    public Products(String id, String name, String description, double price) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
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
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
    
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
            ps.setString(6, "normal");
            ps.executeUpdate();
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
    
    public void removeFromDB(Connection conn)
    {
        try
        {
            String sql = "delete from products where productId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
            if (id.startsWith("01") || id.startsWith("02") || id.startsWith("03"))
            {
                sql = "delete from producttype2 where productId = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, id);
            }
            if (id.startsWith("04") || id.startsWith("05") || id.startsWith("06"))
            {
                sql = "delete from producttype1 where productId = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, id);
            }
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
}
