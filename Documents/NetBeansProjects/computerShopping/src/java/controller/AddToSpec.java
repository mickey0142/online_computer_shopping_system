/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductLists;
import model.Products;

/**
 *
 * @author Mickey
 */
@WebServlet(name = "AddToSpec", urlPatterns = {"/AddToSpec"})
public class AddToSpec extends HttpServlet {

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
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            double powerConsumption = -1;
            String compatibility = null;
            if (productId.startsWith("01") || productId.startsWith("02") || productId.startsWith("03"))
            {
                powerConsumption = Double.parseDouble(request.getParameter("powerConsumption"));
                compatibility = request.getParameter("compatibility");
            }
            else if (productId.startsWith("04") || productId.startsWith("05"))
            {
                powerConsumption = Double.parseDouble(request.getParameter("powerConsumption"));
            }
            Products pd = new Products();
            pd.setId(productId);
            pd.setName(productName);
            pd.setDescription(description);
            pd.setPrice(price);
            ArrayList<ProductLists> inSpec = (ArrayList<ProductLists>) session.getAttribute("inSpec");
            if (inSpec == null)
            {
                inSpec = new ArrayList<ProductLists>();
                for (int i = 0 ; i <= 10; i++)
                {
                    inSpec.add(null);
                }
                session.setAttribute("inSpec", inSpec);
            }
            int index = Integer.parseInt(productId.substring(0, 2));
            System.out.println(index);
            ProductLists pl = new ProductLists();
            pl.setProduct(pd);
            if (powerConsumption != -1)
            {
                pl.setPowerConsumption(powerConsumption);
            }
            if (compatibility != null)
            {
                pl.setCompatibility(compatibility);
            }
            String compCodeC = (String) session.getAttribute("compCodeC");
            String compCodeMC = (String) session.getAttribute("compCodeMC");
            String compCodeMR = (String) session.getAttribute("compCodeMR");
            String compCodeR = (String) session.getAttribute("compCodeR");
            String temp = (String) session.getAttribute("powerSup");
            String temp2 = (String) session.getAttribute("powerCon");
            double powerSup = -1;
            double powerCon = -1;
            if (temp != null) powerSup = Double.parseDouble(temp);
            if (temp2 != null) powerCon =  Double.parseDouble(temp2);
            if (compatibility != null)
            {
                if (index == 1)
                {
                    if (compCodeC == null)
                    {
                        compCodeMC = compatibility.substring(0, 1);
                        session.setAttribute("compCodeMC", compCodeMC);
                        inSpec.set(index, pl);
                    }
                    else
                    {
                        if (compatibility.substring(0, 1).equals(compCodeC))
                        {
                            compCodeMC = compatibility.substring(0, 1);
                            session.setAttribute("compCodeMC", compCodeMC);
                            inSpec.set(index, pl);
                        }
                        else
                        {
                            session.setAttribute("message", "สินค้าชิ้นนี้ไม่เข้ากับชิ้นอื่น");
                        }
                    }
                    if (compCodeR == null)
                    {
                        compCodeMR = compatibility.substring(1, 3);
                        session.setAttribute("compCodeMR", compCodeMR);
                        inSpec.set(index, pl);
                    }
                    else
                    {
                        if (compatibility.charAt(1) > compCodeR.charAt(0) && compatibility.charAt(2) > compCodeR.charAt(1))
                        {
                            compCodeMR = compatibility.substring(1, 3);
                            session.setAttribute("compCodeMR", compCodeMR);
                            inSpec.set(index, pl);
                        }
                        else
                        {
                            session.setAttribute("message", "สินค้าชิ้นนี้ไม่เข้ากับชิ้นอื่น");
                        }
                    }
                }
                if (index == 2)
                {
                    if (compCodeMC == null)
                    {
                        compCodeC = compatibility.substring(0, 1);
                        session.setAttribute("compCodeC", compCodeC);
                        inSpec.set(index, pl);
                    }
                    else
                    {
                        if (compatibility.substring(0, 1).equals(compCodeMC))
                        {
                            compCodeC = compatibility.substring(0, 1);
                            session.setAttribute("compCodeC", compCodeC);
                            inSpec.set(index, pl);
                        }
                        else
                        {
                            session.setAttribute("message", "สินค้าชิ้นนี้ไม่เข้ากับชิ้นอื่น");
                        }
                    }
                }
                if (index == 3)
                {
                    if (compCodeMR == null)
                    {
                        compCodeR = compatibility.substring(1, 3);
                        session.setAttribute("compCodeR", compCodeR);
                        inSpec.set(index, pl);
                    }
                    else
                    {
                        if (compatibility.charAt(1) <= compCodeMR.charAt(0) && compatibility.charAt(2) <= compCodeMR.charAt(1))
                        {
                            compCodeR = compatibility.substring(1, 3);
                            session.setAttribute("compCodeR", compCodeR);
                            inSpec.set(index, pl);
                        }
                        else
                        {
                            session.setAttribute("message", "สินค้าชิ้นนี้ไม่เข้ากับชิ้นอื่น");
                        }
                    }
                }
            }
            else if (index == 4)
            {
                if (powerConsumption < powerCon)
                {
                    session.setAttribute("message", "กำลังไฟไม่เพียงพอ");
                }
                else
                {
                    powerSup = powerConsumption;
                    session.setAttribute("powerSup", powerSup);
                    inSpec.set(index, pl);
                }
            }
            else if (index == 5)
            {
                if (powerConsumption < powerSup || powerSup != -1)
                {
                    powerCon = powerConsumption;
                    session.setAttribute("powerSup", powerSup);
                    inSpec.set(index, pl);
                }
                else
                {
                    session.setAttribute("message", "กำลังไฟไม่เพียงพอ");
                }
            }
            else
            {
                inSpec.set(index, pl);
            }
            response.sendRedirect("spec.jsp");
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
