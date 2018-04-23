package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customers;
import model.Employees;
import model.Orders;

/**
 *
 * @author Mickey
 */
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            Customers cus = new Customers();
            Employees emp = new Employees();
            String userType = "";
            try
            {
                String sql = "";
                if (username.startsWith("emp02") || username.startsWith("emp03"))
                {
                    sql = "select * from employees where username = ? and password = ?";
                    userType = "employee";
                }
                else if (username.startsWith("emp01"))
                {
                    sql = "select * from accountingemp where username = ? and password = ?";
                    userType = "employee";
                }
                else
                {
                    sql = "select * from customers where username = ? and password = ?";
                    userType = "customer";
                }
                PreparedStatement ps = conn.prepareStatement(sql);
                if (username.startsWith("emp01"))
                {
                    emp.setEmployeeType("employee");
                }
                else if (username.startsWith("emp02"))
                {
                    emp.setEmployeeType("accounting");
                }
                else
                {
                    //
                }
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                {
                    session.setAttribute("loginFlag", true);
                    if(userType.equals("customer"))
                    {
                        cus.setUsername(rs.getString("username"));
                        cus.setPassword(rs.getString("password"));
                        cus.setFirstname(rs.getString("firstname"));
                        cus.setLastname(rs.getString("lastname"));
                        cus.setPhoneNumber(rs.getString("phone"));
                        cus.setEmail(rs.getString("email"));
                        cus.setAddress(rs.getString("address"));
                        cus.setId(Integer.toString(rs.getInt("customerId")));
                        session.setAttribute("userInfo", cus);
                        Orders order = new Orders();
                        order.setCustomerId(cus.getId());
                        order.setConnection(conn);
                        session.setAttribute("order", order);
                        response.sendRedirect("index.jsp");
                    }
                    else
                    {
                        emp.setId(rs.getString("employeeId"));
                        session.setAttribute("userInfo", emp);
                        session.setAttribute("isEmp", "yes");
                        // employee go to page after login here
                        response.sendRedirect("empindex.jsp");
                    }
                }
                else
                {
                    session.setAttribute("message", "Invalid login !");
                    response.sendRedirect("login.jsp");
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
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
