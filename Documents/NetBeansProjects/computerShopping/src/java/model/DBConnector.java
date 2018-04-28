/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mickey
 */
public class DBConnector {
    private Connection conn;
    
    public DBConnector()
    {
        
    }
    
    public DBConnector(Connection conn)
    {
        this.conn = conn;
    }
    
    public void selectFromProducts(String sql, HttpSession session)
    {
        ArrayList<Products> ar = new ArrayList<Products>();
        Products pd = new Products();
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                pd = new Products();
                pd.setId(rs.getString("productId"));
                pd.setName(rs.getString("productName"));
                pd.setDescription(rs.getString("description"));
                pd.setPrice(rs.getDouble("price"));
                ar.add(pd);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        session.setAttribute("queryResult", ar);
    }
    
    public void selectFromOrders(String sql, HttpSession session)
    {
        ArrayList<Orders> ar = new ArrayList<Orders>();
        Orders ord = new Orders();
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                ord = new Orders();
                ord.setId(rs.getString("orderId"));
                ord.setStatus(rs.getString("status"));
                ord.setTotalPrice(rs.getDouble("totalPrice"));
                ar.add(ord);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        session.setAttribute("queryResult", ar);
    }
    
    public void selectFromProducttype1(String sql, HttpSession session)
    {
        ArrayList<ProductType1> ar = new ArrayList<ProductType1>();
        ProductType1 pd = new ProductType1();
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                pd = new ProductType1();
                pd.setId(rs.getString("productId"));
                pd.setName(rs.getString("productName"));
                pd.setDescription(rs.getString("description"));
                pd.setPrice(rs.getDouble("price"));
                pd.setPowerConsumption(rs.getDouble("powerConsumption"));
                ar.add(pd);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        session.setAttribute("queryResult", ar);
    }
    
    public void selectFromProducttype2(String sql, HttpSession session)
    {
        ArrayList<ProductType2> ar = new ArrayList<ProductType2>();
        ProductType2 pd = new ProductType2();
        try
        {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                pd = new ProductType2();
                pd.setId(rs.getString("productId"));
                pd.setName(rs.getString("productName"));
                pd.setDescription(rs.getString("description"));
                pd.setPrice(rs.getDouble("price"));
                pd.setPowerConsumption(rs.getDouble("powerConsumption"));
                pd.setCompatibility(rs.getString("compatibility"));
                ar.add(pd);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        session.setAttribute("queryResult", ar);
    }
}
