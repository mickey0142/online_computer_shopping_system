/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

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

/**
 *
 * @author Mickey
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

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
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            boolean success = true;
            String errorMessage = "";
            // check input data
            if (firstname.equals(""))
            {
                success = false;
                errorMessage += "First name can't be empty" + "\\n";
            }
            if (lastname.equals(""))
            {
                success = false;
                errorMessage += "Last name can't be empty" + "\\n";
            }
            if (username.equals(""))
            {
                success = false;
                errorMessage += "Username can't be empty" + "\\n";
            }
            if (username.startsWith("emp"))
            {
                success = false;
                errorMessage += "username can't start with emp" + "\\n";
            }
            if (password.equals(""))
            {
                success = false;
                errorMessage += "password can't be empty" + "\\n";
            }
            if (phone == null)
            {
                success = false;
                errorMessage += "phone can't be empty" + "\\n";
            }
            if (email == null)
            {
                success = false;
                errorMessage += "email can't be empty" + "\\n";
            }
            if (address.equals(""))
            {
                success = false;
                errorMessage += "address can't be empty" + "\\n";
            }
            if (phone.length() != 10)
            {
                success = false;
                errorMessage += "Phone number invalid" + "\\n";
            }
            if (!(email.contains("@") && email.contains(".com")))
            {
                success = false;
                errorMessage += "Email invalid" + "\\n";
            }
            if (success)
            {
                try
                {
                    String sql = "insert into customers (firstname, lastname, username, password, phone, email, address) values (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, firstname);
                    ps.setString(2, lastname);
                    ps.setString(3, username);
                    ps.setString(4, password);
                    ps.setString(5, phone);
                    ps.setString(6, email);
                    ps.setString(7, address);
                    if (ps.executeUpdate() < 0)
                    {
                        System.out.println("insert error");
                    }
                    else
                    {
                        session.setAttribute("message", "Register Success!");
                        response.sendRedirect("register.jsp");
                    }
                }
                catch (Exception e)
                {
                    e.printStackTrace();
                }
            }
            else
            {
                session.setAttribute("message", errorMessage);
                response.sendRedirect("register.jsp");
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
