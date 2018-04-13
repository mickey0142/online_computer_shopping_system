package process;

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
import model.Orders;
import model.Users;

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
            Users user = new Users();
            try
            {
                String sql = "";
                if (username.startsWith("emp01"))
                {
                    sql = "select * from employees where username = ? and password = ?";
                }
                else if (username.startsWith("emp02"))
                {
                    sql = "select * from accountingemp where username = ? and password = ?";
                }
                else
                {
                    sql = "select * from customers where username = ? and password = ?";
                }
                PreparedStatement ps = conn.prepareStatement(sql);
                if (username.startsWith("emp01"))
                {
                    user.setUserType("employee");
                }
                else if (username.startsWith("emp02"))
                {
                    user.setUserType("accounting");
                }
                else
                {
                    user.setUserType("customer");
                }
                ps.setString(1, username);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                {
                    session.setAttribute("loginFlag", true);
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setFirstname(rs.getString("firstname"));
                    user.setLastname(rs.getString("lastname"));
                    user.setPhoneNumber(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setAddress(rs.getString("address"));
                    if (user.getUserType().equals("customer"))
                    {
                        user.setId(Integer.toString(rs.getInt("customerId")));
                    }
                    else
                    {
                        user.setId(rs.getString("employeeId"));
                    }
                    session.setAttribute("userInfo", user);
                    Orders order = new Orders();
                    order.setCustomerId(user.getId());
                    order.setConnection(conn);
                    session.setAttribute("order", order);
                    response.sendRedirect("index.jsp");
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
