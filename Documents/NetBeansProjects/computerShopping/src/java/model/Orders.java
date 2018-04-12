/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Mickey
 */
public class Orders implements java.io.Serializable{
    private String id;
    private String paymentProof;
    private String status;
    private double totalPrice;
    private ArrayList<Products> productList;
    private String orderDate;
    private String customerId;
    private Connection conn;

    public Orders()
    {
        
    }

    public Orders(String id, String paymentProof, String status, double totalPrice, String orderDate, String customerId)
    {
        this.id = id;
        this.paymentProof = paymentProof;
        this.status = status;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.customerId = customerId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPaymentProof() {
        return paymentProof;
    }

    public void setPaymentProof(String paymentProof) {
        this.paymentProof = paymentProof;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public ArrayList<Products> getProductList() {
        return productList;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }
    
    public void addItem(String id)
    {
        try
        {
            Statement stmt = conn.createStatement();
            String sql = "select * from product where id = '" + id + "'";
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                Products pd = new Products();
                pd.setId(id);
                pd.setName(rs.getString("name"));
                pd.setDescription(rs.getString("description"));
                pd.setPrice(rs.getDouble("price"));
                if (id.startsWith("01"))// check from id if that product have compatibility
                {
                    pd.setCompatibility(rs.getString("compatibility"));
                }
                if (id.startsWith("02"))// check from id if that product have power consumption
                {
                    pd.setPowerConsumption(rs.getDouble("power_consumption"));
                }
                productList.add(pd);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public void removeItem(String name)
    {
        for (Products p : productList)
        {
            if (p.getName().equals(name))
            {
                productList.remove(p);
                break;
            }
        }
    }
}
