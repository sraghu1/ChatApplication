package com.chatapp.controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//import com.chatapp.Connections;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.chatapp.core.Connections;
/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/LoginContoller"})
public class LoginContoller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginContoller</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginContoller at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        //processRequest(request, response);
    RequestDispatcher rd=null;
    int flag=0;    
    try
        {
            
    	
    Connection con=(Connection) Connections.give_Connection();
	Statement statement=con.createStatement();
	ResultSet rs=statement.executeQuery("select * from user");
        while(rs.next())
	{
	    if(rs.getString("email_id").equals(request.getParameter("email"))&&rs.getString("password").equals(request.getParameter("pwd")))
		{
            flag=1;
            HttpSession session=request.getSession(true);
			System.out.println("Session created.SID: "+session.getId());
			String nickname=rs.getString(3);
            String email=request.getParameter("email");
            session.setAttribute("email", email);
            System.out.println(nickname+email);
            session.setAttribute("nickname", nickname);
            request.setAttribute("nickname", nickname);
            session.setAttribute("password",request.getParameter("pwd"));
            Statement statement1=con.createStatement();
            statement1.executeUpdate("UPDATE user SET logged='1' WHERE email_id='"+email+"'");
    
                        
		}
            else{
                request.setAttribute("pagefrom", 1);
            }
	}
        if(flag==1)
        {
            rd=request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
        else
        {
            rd=request.getRequestDispatcher("Login.jsp");
            rd.forward(request, response);
            
        }
        }
    catch(Exception e)
    {
        e.printStackTrace();
        request.setAttribute("pagefrom", 1);
        }
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
