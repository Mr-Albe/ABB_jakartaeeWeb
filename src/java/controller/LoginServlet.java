/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import model.UserModel;
import serviceImplement.UserDao;

/**
 *
 * @author bendy
 */
public class LoginServlet extends HttpServlet {

    UserDao userDao = null;

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
//        processRequest(request, response);
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

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            userDao = new UserDao();
            UserModel user = userDao.rechercherParUsernameEtPassword(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", user);
                System.out.println("Utilisateur connecté : " + user.getUsername());
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("errorLogin", "Nom d'utilisateur ou mot de passe incorrect.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (ServletException | IOException | ClassNotFoundException | SQLException e) {
            request.setAttribute("errorLogin", "Erreur de connection");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
