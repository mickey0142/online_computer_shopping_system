/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Mickey
 */
public class Customers extends Users{
    private String address;
    
    public Customers()
    {
        
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    public String addToDB(Connection conn)
    {
        try
        {
            String sql = "insert into customers (firstname, lastname, username, password, phone, email, address) values (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, firstname);
            ps.setString(2, lastname);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, phoneNumber);
            ps.setString(6, email);
            ps.setString(7, address);
            if (ps.executeUpdate() < 0)
            {
                System.out.println("insert error");
            }
            else
            {
                return "success";
            }
        }
        catch (SQLException e)
        {
            // check for duplicated entry in unique column
            if (e.getSQLState().startsWith("23"))
            {
                return "duplicatedUsername";
            }
            else
            {
                e.printStackTrace();
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return "end of Customers addToDB method";
    }
}
