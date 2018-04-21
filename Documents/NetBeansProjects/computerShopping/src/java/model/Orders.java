/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;

/**
 *
 * @author Mickey
 */
public class Orders implements java.io.Serializable{
    private String id;
    private String paymentProof;
    private String status;
    private double totalPrice;
    private ArrayList<ProductLists> productList;
    private String orderDate;
    private String customerId;
    private Connection conn;

    public Orders()
    {
        status = "";// set default status in here
        productList = new ArrayList<ProductLists>();
    }

    public Orders(String id, String paymentProof, String status, double totalPrice, String orderDate, String customerId)
    {
        this.id = id;
        this.paymentProof = paymentProof;
        this.status = status;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.customerId = customerId;
        productList = new ArrayList<ProductLists>();
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

    public ArrayList<ProductLists> getProductList() {
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
    
    public void setConnection(Connection conn)
    {
        this.conn = conn;
    }
    
    public void addItem(String id)// change how all of this work with product type
    {
        try
        {
            Statement stmt = conn.createStatement();
            String sql = "select * from products where productId = '" + id + "'";
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                Products pd = new Products();
                pd.setId(id);
                pd.setName(rs.getString("productName"));
                pd.setDescription(rs.getString("description"));
                pd.setPrice(rs.getDouble("price"));
                boolean duplicate = false;
                for (ProductLists p : productList)
                {
                    if (p.getProduct().getName().equals(pd.getName()))
                    {
                        p.setQuantity(p.getQuantity() + 1);
                        duplicate = true;
                        break;
                    }
                }
                if (!duplicate)
                {
                    ProductLists pl = new ProductLists();
                    pl.setProduct(pd);
                    pl.setQuantity(1);
                    productList.add(pl);
                }
                Collections.sort(productList, new Comparator<ProductLists>() {
                    @Override
                    public int compare(final ProductLists o1, final ProductLists o2)
                    {
                        return o1.getProduct().getId().compareTo(o2.getProduct().getId());
                    }
                });
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public void removeItem(String name)
    {
        for (ProductLists p : productList)
        {
            if (p.getProduct().getName().equals(name))
            {
                productList.remove(p);
                break;
            }
        }
    }
    
    public void addToDB(String type)
    {
        try
            {
            String sql = "insert into orders (status, totalPrice, customerId, orderDate) values (?, ? , ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            if (type.equals("bank"))
            {
                ps.setString(1, "not paid");
            }
            else if (type.equals("credit"))
            {
                ps.setString(1, "paid");
            }
            ps.setDouble(2, totalPrice);
            ps.setInt(3, Integer.parseInt(customerId));
            java.sql.Date sqlDate = new Date(Calendar.getInstance().getTime().getTime());
            ps.setDate(4, sqlDate);
            if (ps.executeUpdate() < 0) {
                System.out.println("insert order error");
            }
            ResultSet rs = ps.getGeneratedKeys();

            // orderId is work as a primary key to insert data in orderdetails
            // this will work if number of row affected is equal to orderId
            int orderId = -1;
            if (rs.next())
            {
                orderId = rs.getInt(1);
            }
            for (ProductLists i : productList)
            {
                sql = "insert into orderdetails values (?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, orderId);
                ps.setString(2, i.getProduct().getId());
                ps.setInt(3, i.getQuantity());
                ps.setDouble(4, i.getProduct().getPrice() * i.getQuantity());
                if (ps.executeUpdate() < 0) {
                    System.out.println("insert order details error");
                }
            }
            productList.clear();
            totalPrice = 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateDB()
    {
        try
        {
            String sql = "update orders set status = ? where orderId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
