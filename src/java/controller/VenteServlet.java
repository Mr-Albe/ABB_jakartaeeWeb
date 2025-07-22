package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import model.VenteModel;
import serviceImplement.StationDao;
import serviceImplement.VenteDao;

public class VenteServlet extends HttpServlet {

    StationDao stationdao = null;
    VenteDao venteDao = null;
    VenteModel venteModel = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("vente/ajouter.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        enregistrer(request, response);
    }

    protected void enregistrer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int stationId = Integer.parseInt(request.getParameter("idStation"));
            String typeCarburant = request.getParameter("typeCarburant");
            int quantiteDemandee = Integer.parseInt(request.getParameter("quantite"));
            double prixUnitaire = Double.parseDouble(request.getParameter("prixUnitaire"));
            LocalDate dateVente = LocalDate.parse(request.getParameter("dateVente"));

            stationdao = new StationDao();
            int stockDisponible = stationdao.getquantiteParStationIdType(stationId, typeCarburant);

            if (stockDisponible >= quantiteDemandee) {
                venteModel = new VenteModel();
                venteModel.setStationId(stationId);
                venteModel.setTypeCarburant(typeCarburant);
                venteModel.setQuantite(quantiteDemandee);
                venteModel.setPrixUnitaire(prixUnitaire);
                venteModel.setDateVente(dateVente);

                venteDao = new VenteDao();
                venteDao.ajouter(venteModel);

                // Mettre a jour le stock dans la station apres la vente 
//                stationdao.retirerQuantite(stationId, typeCarburant, quantiteDemandee);

                response.sendRedirect(request.getContextPath() + "/VenteServlet");
            } else {
                request.setAttribute("erreur", "La quantité disponible en " + typeCarburant + " est insuffisante pour effectuer cette vente.");
                request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            request.setAttribute("erreur", "Erreur lors de l’enregistrement de la vente : " + e.getMessage());
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de gestion des ventes de carburant.";
    }
}
