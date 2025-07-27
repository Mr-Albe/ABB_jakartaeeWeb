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
import java.util.List;
import model.VenteModel;
import serviceImplement.ApprovisionnementDao;
import serviceImplement.StationDao;
import serviceImplement.VenteDao;

/**
 *
 * @author bendy
 */
public class DashboardServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request ser * @throws IOException if an I/O error occurs vlet
     * request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Forcer le rafraîchissement des données à chaque accès
        refreshData(request);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    private void refreshData(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            StationDao stationDao = new StationDao();
            ApprovisionnementDao approDao = new ApprovisionnementDao();
            VenteDao venteDao = new VenteDao();

            session.setAttribute("listeStation", stationDao.afficherTout());
            session.setAttribute("listeAppro", approDao.afficherTout());

            List<VenteModel> ventes = venteDao.afficherTout();
            session.setAttribute("listeVente", ventes);
            session.setAttribute("totalRevenu", ventes.stream().mapToDouble(VenteModel::getRevenu).sum());

        } catch (Exception e) {
            session.setAttribute("error", "Erreur de rafraîchissement des données");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
