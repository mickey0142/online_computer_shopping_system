/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
            request.setCharacterEncoding("UTF-8");
            Orders order = (Orders) session.getAttribute("order");
            // add insert differentation for credit payment and bank payment later !!
            String paymentType = (String) session.getAttribute("paymentType");
            String cardNumber = request.getParameter("cardNumber");
            String cardName = request.getParameter("cardName");
            String expireDate = request.getParameter("expireDate");
            String cvv = request.getParameter("cvv");
            boolean success = true;
            String message = "";
            if (paymentType.equals("credit"))
            {
                if (cardNumber.equals(""))
                {
                    success = false;
                    message += "รหัสบัตรเครดิตไม่ถูกต้อง" + "\\n";
                }
                if (cardName.equals(""))
                {
                    success = false;
                    message += "ชื่อผู้ถือบัตรไม่ถูกต้อง" + "\\n";
                }
                if (expireDate.equals(""))
                {
                    success = false;
                    message += "วันหมดอายุไม่ถูกต้อง" + "\\n";
                }
                if (cvv.equals("") || cvv.length() != 3)
                {
                    success = false;
                    message += "CVV ไม่ถูกต้อง" + "\\n";
                }
            }
            if (order.getProductList().isEmpty())
            {
                success = false;
                message += "ตะกร้าของคุณว่างเปล่า" + "\\n";
            }
            session.setAttribute("message", message);
            if (success)
            {
                order.addToDB(paymentType);
                response.sendRedirect("orderHistory.jsp");
            }
            else
            {
                response.sendRedirect("confirmPurchase.jsp");
            }
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
