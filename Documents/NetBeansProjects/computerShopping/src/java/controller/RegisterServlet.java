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
import model.Customers;

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
            request.setCharacterEncoding("UTF-8");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            boolean success = true;
            String errorMessage = "";
            // check input data
            if (firstname.equals(""))
            {
                success = false;
                errorMessage += "กรุณาใส่ชื่อจริง" + "\\n";
            }
            if (lastname.equals(""))
            {
                success = false;
                errorMessage += "กรุณาใส่นามสกุล" + "\\n";
            }
            if (username.equals(""))
            {
                success = false;
                errorMessage += "กรุณาใส่ username" + "\\n";
            }
            if (username.startsWith("emp"))
            {
                success = false;
                errorMessage += "ไม่สามารถตั้งชื่อ username ขึ้นต้นด้วย emp ได้" + "\\n";
            }
            if (password.equals(""))
            {
                success = false;
                errorMessage += "กรุณาใส่รหัสผ่าน" + "\\n";
            }
            if (!password.equals(confirmPassword))
            {
                success = false;
                errorMessage += "ยีนยันรหัสผ่านไม่ตรงกับรหัสผ่าน" + "\\n";
            }
            if (phone == null)
            {
                success = false;
                errorMessage += "กรุณาใส่เบอร์โทรศัพท์" + "\\n";
            }
            if (email == null)
            {
                success = false;
                errorMessage += "กรุณาใส่อีเมล์" + "\\n";
            }
            if (address.equals(""))
            {
                success = false;
                errorMessage += "กรุณาใส่ที่อยู่" + "\\n";
            }
            if (phone.length() != 10)
            {
                success = false;
                errorMessage += "คุณใส่เบอร์โทรศัพท์ผิด" + "\\n";
            }
            if (!(email.contains("@") && email.contains(".com")))
            {
                success = false;
                errorMessage += "คุณใส่อีเมล์ผิด" + "\\n";
            }
            if (success)
            {
                Customers cus = new Customers();
                cus.setFirstname(firstname);
                cus.setLastname(lastname);
                cus.setUsername(username);
                cus.setPassword(password);
                cus.setPhoneNumber(phone);
                cus.setEmail(email);
                cus.setAddress(address);
                String result = cus.addToDB(conn);
                System.out.println(result);
                if (result.equals("success"))
                {
                    session.setAttribute("message", "สมัครสำเร็จ!");
                    response.sendRedirect("register.jsp");
                }
                else if (result.equals("duplicatedUsername"))
                {
                    session.setAttribute("message", "ชื่อ username ซ้ำ");
                    response.sendRedirect("register.jsp");
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
