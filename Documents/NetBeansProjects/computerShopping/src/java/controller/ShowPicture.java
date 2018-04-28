/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mickey
 */
@WebServlet(name = "ShowPicture", urlPatterns = {"/ShowPicture"})
public class ShowPicture extends HttpServlet {

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
        try
        {
            conn = (Connection) getServletContext().getAttribute("connection");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
            /* TODO output your page here. You may use following sample code. */
            String pid = request.getParameter("id");
            int id = Integer.parseInt(pid);
            String table = request.getParameter("table");
            String sql = "";
            if (table.equals("orders"))
            {
                sql = "select paymentProof from orders where orderId = ?";
            }
            else if (table.equals("productpictures"))
            {
                sql = "select picture from productpictures where productId = ?";
            }
            try
            {
                Blob image;
                byte[] imgData = null;
                PreparedStatement ps = conn.prepareStatement(sql);
                if (table.equals("orders"))
                {
                    ps.setInt(1, id);
                }
                else if (table.equals("productpictures"))
                {
                    ps.setString(1, pid);
                }
                ResultSet rs = ps.executeQuery();
                if(rs.next())
                {
                    if (table.equals("orders"))
                    {
                        image = rs.getBlob("paymentProof");
                    }
                    else if (table.equals("productpictures"))
                    {
                        image = rs.getBlob("picture");
                    }
                    else
                    {
                        image = null;
                    }
                    if (image == null)
                    {
                        throw new NullPointerException();
                    }
                    imgData = image.getBytes(1, (int) image.length());
                }
                response.setContentType("image/jpeg");
                OutputStream output = response.getOutputStream();
                output.write(imgData);
                output.flush();
                output.close();
            }
            catch(NullPointerException e)
            {
                
            }
            catch(Exception e)
            {
                e.printStackTrace();
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
