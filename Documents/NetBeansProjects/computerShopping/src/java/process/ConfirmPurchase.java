/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Orders;
import model.ProductLists;
import model.Products;

/**
 *
 * @author Mickey
 */
@WebServlet(name = "ConfirmPurchase", urlPatterns = {"/ConfirmPurchase.in"})
public class ConfirmPurchase extends HttpServlet {

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
            Orders order = (Orders) session.getAttribute("order");
            try
            {
                String sql = "insert into orders (status, totalPrice, customerId, orderDate) values ('not paid', ? , ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setDouble(1, order.getTotalPrice());
                ps.setInt(2, Integer.parseInt(order.getCustomerId()));
                java.sql.Date sqlDate = new Date(Calendar.getInstance().getTime().getTime());
                ps.setDate(3, sqlDate);
                if (ps.executeUpdate() < 0)
                {
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
                for (ProductLists i : order.getProductList())
                {
                    sql = "insert into orderdetails values (?, ?, ?, ?)";
                    ps = conn.prepareCall(sql);
                    ps.setInt(1, orderId);
                    ps.setString(2, i.getProduct().getId());
                    ps.setInt(3, i.getQuantity());
                    ps.setDouble(4, i.getProduct().getPrice() * i.getQuantity());
                    if (ps.executeUpdate() < 0)
                    {
                        System.out.println("insert order details error");
                    }
                }
                order.getProductList().clear();
                order.setTotalPrice(0);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            response.sendRedirect("manageCart.jsp");
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
