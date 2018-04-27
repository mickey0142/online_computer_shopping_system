/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Mickey
 */
@WebServlet(name = "InsertPicture", urlPatterns = {"/InsertPicture"})
@javax.servlet.annotation.MultipartConfig
public class InsertPicture extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            InputStream input = null;
            Part filePart = request.getPart("picture");
            String table = request.getParameter("table");
            System.out.println(table);
            if (filePart != null)
            {
                // prints out some information for debugging
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());

                // obtains input stream of the upload file
                input = filePart.getInputStream();
            }
            try
            {
                if (table.equals("orders"))
                {
                    String sql = "update orders set paymentProof = ? where orderId = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    String id = request.getParameter("id");
                    System.out.println(id);
                    ps.setBlob(1, input);
                    ps.setString(2, id);
                    if (ps.executeUpdate() < 0) {
                        System.out.println("insert error");
                    }
                }
                else if (table.equals("updateProduct"))
                {
                    String sql = "insert into productpictures (productId, picture) values (?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    String id = request.getParameter("id");
                    System.out.println(id);
                    ps.setString(1, id);
                    ps.setBlob(2, input);
                    if (ps.executeUpdate() < 0)
                    {
                        System.out.println("insert error");
                    }
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            response.sendRedirect((String) session.getAttribute("back"));
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
