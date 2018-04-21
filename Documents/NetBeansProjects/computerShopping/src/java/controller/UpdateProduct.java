/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductType1;
import model.ProductType2;
import model.Products;

/**
 *
 * @author Mickey
 */
@WebServlet(name = "UpdateProduct", urlPatterns = {"/UpdateProduct.emp"})
public class UpdateProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private Connection conn;

    @Override
    public void init()
    {
        conn = (Connection) getServletContext().getAttribute("connection");
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            int inStock = Integer.parseInt(request.getParameter("inStock"));
            double price = Double.parseDouble(request.getParameter("price"));
            String temp = request.getParameter("powerConsumption");
            double powerConsumption;
            if (temp != null)
            powerConsumption = Double.parseDouble(temp);
            else powerConsumption = -1;
            String compatibility = request.getParameter("compatibility");
            
            if (compatibility != null)
            {
                ProductType2 pt2 = new ProductType2();
                pt2.setId(productId);
                pt2.setName(productName);
                pt2.setDescription(description);
                pt2.setPrice(price);
                pt2.setPowerConsumption(powerConsumption);
                pt2.setCompatibility(compatibility);
                pt2.updateDB(inStock, conn);
            }
            else if (powerConsumption != 1)
            {
                ProductType1 pt1 = new ProductType1();
                pt1.setId(productId);
                pt1.setName(productName);
                pt1.setDescription(description);
                pt1.setPrice(price);
                pt1.setPowerConsumption(powerConsumption);
                pt1.updateDB(inStock, conn);
            }
            else
            {
                Products product = new Products();
                product.setId(productId);
                product.setName(productName);
                product.setDescription(description);
                product.setPrice(price);
                product.updateDB(inStock, conn);
            }
            try
            {
                String sql = "update products set productName = ?, description = ?, inStock = ?, price = ? where productId = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, productName);
                ps.setString(2, description);
                ps.setInt(3, inStock);
                ps.setDouble(4, price);
                ps.setString(5, productId);
                ps.executeUpdate();
                if (compatibility != null)
                {
                    sql = "update producttype2 set powerConsumption = ?, compatibility = ? where productId = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setDouble(1, powerConsumption);
                    ps.setString(2, compatibility);
                    ps.setString(3, productId);
                    ps.executeUpdate();
                }
                else if (powerConsumption != -1)
                {
                    sql = "update producttype1 set powerConsumption = ? where productId = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setDouble(1, powerConsumption);
                    ps.setString(2, productId);
                }
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
            response.sendRedirect("manageProduct.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
