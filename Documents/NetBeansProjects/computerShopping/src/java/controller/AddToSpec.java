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
            else if (productId.startsWith("04") || productId.startsWith("05") || productId.startsWith("06"))
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
            int index = productId.charAt(1)-48;
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
            String compatibilityCode = (String) session.getAttribute("compatibilityCode");
            boolean isCompatible = true;
            // if this is the first product to add in spec
            if (compatibility != null && (compatibilityCode == null || compatibilityCode.charAt(0) == '_'))
            {
                inSpec.set(index, pl);
                // if it is ram
                if (index == 3)// test to see if this is working later
                {
                    compatibility = "_" + compatibility.substring(1);
                }
                // if it is cpu
                if (index == 2)
                {
                    compatibility = compatibility.charAt(0) + "_" + compatibility.charAt(2);
                }
                session.setAttribute("compatibilityCode", compatibility);
                compatibilityCode = (String) session.getAttribute("compatibilityCode");
            }
            else if (compatibility != null && compatibilityCode != null)
            {
                if (index == 1 || index == 2)// if add mainboard or cpu
                {
                    if (compatibility.charAt(0) != compatibilityCode.charAt(0))
                    {
                        session.setAttribute("message", "this product is not compatible");
                        isCompatible = false;
                    }
                }
                else if (index == 3)// if add ram
                {
                    if (compatibility.charAt(1) < compatibilityCode.charAt(1))
                    {
                        session.setAttribute("message", "this product is not compatible");
                        isCompatible = false;
                    }
                }
            }
            if (isCompatible)
            {
                inSpec.set(index, pl);
            }
            System.out.println(compatibilityCode);
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
