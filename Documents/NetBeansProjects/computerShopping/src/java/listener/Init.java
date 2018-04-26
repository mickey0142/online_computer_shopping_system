/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

/**
 * Web application lifecycle listener.
 *
 * @author Mickey
 */
public class Init implements ServletContextListener {

    private Connection conn;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try
        {
            boolean realdb = false;
            if(!realdb)
            {
                conn = getComshopdb().getConnection();
                sce.getServletContext().setAttribute("datasourceName", "comshopdb");
            }
            else 
            {
                conn = getRealdb().getConnection();
                sce.getServletContext().setAttribute("datasourceName", "realdb");
            }
            sce.getServletContext().setAttribute("connection", conn);
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try
        {
            conn.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    private DataSource getComshopdb() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/comshopdb");
    }

    private DataSource getRealdb() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/realdb");
    }
}
