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
import model.StationModel;

public class VenteServlet extends HttpServlet {

    StationDao stationdao = null;
    VenteDao venteDao = null;
    VenteModel venteModel = null;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
        venteDao = new VenteDao();
        stationdao = new StationDao();

        try {
            if (action != null && !action.isEmpty()) {
                if ("delete".equalsIgnoreCase(action)) {
                    venteDao.supprimer(id);
                    load(request, response);
                } else if ("edit".equalsIgnoreCase(action)) {
                    // Charger la vente à modifier
                    VenteModel vente = venteDao.rechercherParId(id);
                    List<StationModel> stations = stationdao.afficherTout();
                    request.setAttribute("vente", vente);
                    request.setAttribute("stations", stations);
                    request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
                }
            } else {
                load(request, response);
            }
        } catch (Exception ex) {
            Logger.getLogger(VenteServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("erreur", "Erreur lors de l'opération : " + ex.getMessage());
            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("modifier".equalsIgnoreCase(action)) {
            try {
                modifier(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(VenteServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            enregistrer(request, response);
        }
    }

    protected void modifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        try {
            int idVente = Integer.parseInt(request.getParameter("id"));
            int stationId = Integer.parseInt(request.getParameter("idStation"));
            String nouveauTypeCarburant = request.getParameter("typeCarburant");
            int nouvelleQuantite = Integer.parseInt(request.getParameter("quantite"));
            double prixUnitaire = Double.parseDouble(request.getParameter("prixUnitaire"));
            LocalDate dateVente = LocalDate.parse(request.getParameter("dateVente"));

            venteDao = new VenteDao();
            stationdao = new StationDao();

            // Récupérer la vente originale
            VenteModel venteOriginale = venteDao.rechercherParId(idVente);
            int ancienneQuantite = venteOriginale.getQuantite();
            String ancienTypeCarburant = venteOriginale.getTypeCarburant();

            // Si le type de carburant a changé
            if (!ancienTypeCarburant.equals(nouveauTypeCarburant)) {
                // Retourner l'ancienne quantité à l'ancien type
                stationdao.ajouterQuantite(stationId, ancienTypeCarburant, ancienneQuantite);

                // Vérifier que le nouveau type a assez de stock
                int stockDisponible = stationdao.getquantiteParStationIdType(stationId, nouveauTypeCarburant);
                if (stockDisponible < nouvelleQuantite) {
                    request.setAttribute("erreur", "Quantité insuffisante dans la station pour le nouveau type de carburant.");
                    request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
                    return;
                }
                // Retirer la nouvelle quantite du nouveau type
                stationdao.retirerQuantite(stationId, nouveauTypeCarburant, nouvelleQuantite);
            } else {
                // Meme type de carburant, on calcule la différence
                int difference = nouvelleQuantite - ancienneQuantite;
                if (difference < 0) {
                    // Retourner l'excédent
                    stationdao.ajouterQuantite(stationId, nouveauTypeCarburant, Math.abs(difference));
                } else if (difference > 0) {
                    int stockDisponible = stationdao.getquantiteParStationIdType(stationId, nouveauTypeCarburant);
                    if (stockDisponible < difference) {
                        request.setAttribute("erreur", "Quantité insuffisante dans la station.");
                        request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
                        return;
                    }
                    stationdao.retirerQuantite(stationId, nouveauTypeCarburant, difference);
                }
            }

            // Mettre à jour la vente
            venteOriginale.setStationId(stationId);
            venteOriginale.setTypeCarburant(nouveauTypeCarburant);
            venteOriginale.setQuantite(nouvelleQuantite);
            venteOriginale.setPrixUnitaire(prixUnitaire);
            venteOriginale.setDateVente(dateVente);

            venteDao.modifier(venteOriginale);

            // Redirection
            load(request, response);

        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            request.setAttribute("erreur", "Erreur lors de la modification : " + e.getMessage());
            request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
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
                    stationdao.retirerQuantite(stationId, typeCarburant, quantiteDemandee);
                    System.out.println("Carburant retiré avec succès !");
                    load(request, response);
                    return;

                } catch (Exception e) {
                    request.setAttribute("erreur", "Erreur technique : " + e.getMessage());
                }
            } else {
                request.setAttribute("erreur", "La quantité disponible en " + typeCarburant + " est insuffisante.");
            }
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur lors de l’enregistrement : " + e.getMessage());
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);
        }
    }

    protected void load(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        venteDao = new VenteDao();
        try {
            List<VenteModel> listVente = venteDao.afficherTout();
            request.setAttribute("vente", listVente);
            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur de chargement : " + e.getMessage());
            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de gestion des ventes de carburant.";
    }
}
