package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        String action = request.getParameter("action");
        int id;
        id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        venteDao = new VenteDao();

        if (action != null && !action.isEmpty()) {
            if ("delete".equalsIgnoreCase(action)) {
                try {
                    venteDao.supprimer(id);
                    load(request, response);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(VenteServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if ("edit".equalsIgnoreCase(action)) {
                response.sendRedirect("vente/ajouter.jsp");
            }
        } else {
            load(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        enregistrer(request, response);
    }

    protected void load(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        venteDao = new VenteDao();
        try {
            List<VenteModel> listVente = (List<VenteModel>) venteDao.afficherTout();
            request.setAttribute("vente", listVente);
            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            request.setAttribute("erreur", "Erreur de connexion à la base de données : ");
            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
        }
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

                try {
                    int retirerQuantite = stationdao.retirerQuantite(stationId, typeCarburant, quantiteDemandee);
                    System.out.println("Carburant retiré avec succès !");

                    // Redirection vers la page index seulement si tout est OK
                    load(request,response);
                    return;

                } catch (IllegalStateException e) {
                    request.setAttribute("erreur", "Erreur utilisateur : " + e.getMessage());
                } catch (SQLException | ClassNotFoundException e) {
                    request.setAttribute("erreur", "Erreur technique : " + e.getMessage());
                }
            } else {
                request.setAttribute("erreur", "La quantité disponible en " + typeCarburant + " est insuffisante pour effectuer cette vente.");
            }
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);

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
