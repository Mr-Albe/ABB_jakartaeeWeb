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

    // Methode pour valider les champs du formulaire de vente
    private VenteModel lireEtValiderVente(HttpServletRequest request) {
        String stationIdStr = request.getParameter("idStation");
        String typeCarburant = request.getParameter("typeCarburant");
        String quantiteStr = request.getParameter("quantite");
        String prixStr = request.getParameter("prixUnitaire");
        String dateStr = request.getParameter("dateVente");

        if (stationIdStr == null || stationIdStr.trim().isEmpty()
                || typeCarburant == null || typeCarburant.trim().isEmpty()
                || quantiteStr == null || quantiteStr.trim().isEmpty()
                || prixStr == null || prixStr.trim().isEmpty()
                || dateStr == null || dateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Tous les champs textuels sont obligatoires");
        }

        int stationId = Integer.parseInt(stationIdStr.trim());
        int quantiteDemandee = Integer.parseInt(quantiteStr.trim());
        double prixUnitaire = Double.parseDouble(prixStr.trim());
        LocalDate dateVente = LocalDate.parse(dateStr.trim());

        return new VenteModel(0, stationId, typeCarburant.trim(), quantiteDemandee, prixUnitaire, dateVente);
    }

    // Methode 
    protected void modifier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        try {
            int idVente = Integer.parseInt(request.getParameter("id"));
            // recuperer les donnee du formulaire
            VenteModel venteForm = lireEtValiderVente(request);

            venteDao = new VenteDao();
            stationdao = new StationDao();

            // Recuperer la vente originale
            VenteModel venteOriginale = venteDao.rechercherParId(idVente);
            int ancienneQuantite = venteOriginale.getQuantite();
            String ancienTypeCarburant = venteOriginale.getTypeCarburant();

            // Si le type de carburant a change
            if (!ancienTypeCarburant.equals(venteForm.getTypeCarburant())) {
                // Retourner l'ancienne quantite a l'ancien type
                stationdao.ajouterQuantite(venteForm.getStationId(), ancienTypeCarburant, ancienneQuantite);

                // Verifier que le nouveau type a assez de stock
                int stockDisponible = stationdao.getquantiteParStationIdType(venteForm.getStationId(), venteForm.getTypeCarburant());
                if (stockDisponible < venteForm.getQuantite()) {
                    request.setAttribute("erreur", "Quantité insuffisante dans la station pour le nouveau type de carburant.");
                    request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
                    return;
                }
                // Retirer la nouvelle quantite du nouveau type
                stationdao.retirerQuantite(venteForm.getStationId(), venteForm.getTypeCarburant(), venteForm.getQuantite());
            } else {
                // Meme type de carburant, on calcule la difference
                int difference = venteForm.getQuantite() - ancienneQuantite;
                if (difference < 0) {
                    // Retourner l'excédent
                    stationdao.ajouterQuantite(venteForm.getStationId(), venteForm.getTypeCarburant(), Math.abs(difference));
                } else if (difference > 0) {
                    int stockDisponible = stationdao.getquantiteParStationIdType(venteForm.getStationId(), venteForm.getTypeCarburant());
                    if (stockDisponible < difference) {
                        request.setAttribute("erreur", "Quantité insuffisante dans la station.");
                        request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
                        return;
                    }
                    stationdao.retirerQuantite(venteForm.getStationId(), venteForm.getTypeCarburant(), difference);
                }
            }

            // Mettre a jour la vente
            venteOriginale.setStationId(venteForm.getStationId());
            venteOriginale.setTypeCarburant(venteForm.getTypeCarburant());
            venteOriginale.setQuantite(venteForm.getQuantite());
            venteOriginale.setPrixUnitaire(venteForm.getPrixUnitaire());
            venteOriginale.setDateVente(venteForm.getDateVente());

            venteDao.modifier(venteOriginale);

            // Redirection
            load(request, response);

        } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
            request.setAttribute("erreur", "Erreur lors de la modification : " + e.getMessage());
            request.getRequestDispatcher("vente/modifier.jsp").forward(request, response);
        }
    }

    // Methode pour l'enregistrement d'une vente
    protected void enregistrer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // recuperer les donnee du formulaire
            VenteModel venteForm = lireEtValiderVente(request);

            // Recuperer la quantite de carburant de la station en utilisant la methode 
            //getquantiteParStationIdType(param1, param2) suivant le type de carburant choisi
            stationdao = new StationDao();
            int stockDisponible = stationdao.getquantiteParStationIdType(venteForm.getStationId(), venteForm.getTypeCarburant());

            if (stockDisponible >= venteForm.getQuantite()) {
                venteModel = new VenteModel();
                venteModel.setStationId(venteForm.getStationId());
                venteModel.setTypeCarburant(venteForm.getTypeCarburant());
                venteModel.setQuantite(venteForm.getQuantite());
                venteModel.setPrixUnitaire(venteForm.getPrixUnitaire());
                venteModel.setDateVente(venteForm.getDateVente());

                venteDao = new VenteDao();
                venteDao.ajouter(venteModel);

                try {
                    stationdao.retirerQuantite(venteForm.getStationId(), venteForm.getTypeCarburant(), venteForm.getQuantite());
                    load(request, response);
                    return;

                } catch (Exception e) {
                    request.setAttribute("erreur", "Erreur technique : " + e.getMessage());
                }
            } else {
                request.setAttribute("erreur", "La quantité disponible en " + venteForm.getTypeCarburant() + " est insuffisante.");
            }
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "Veuillez entrer des nombres valides pour les capacités et quantités");
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur lors de l’enregistrement : " + e.getMessage());
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);
        }

    }

    //methode pour charger les donnees de la BD
//    protected void load(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        venteDao = new VenteDao();
//        try {
//            List<VenteModel> listVente = venteDao.afficherTout();
//            request.setAttribute("vente", listVente);
//            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
//        } catch (Exception e) {
//            request.setAttribute("erreur", "Erreur de chargement : " + e.getMessage());
//            request.getRequestDispatcher("vente/index.jsp").forward(request, response);
//        }
//    }
    protected void load(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        venteDao = new VenteDao();
        try {
            List<VenteModel> listVente = venteDao.afficherTout();
            request.setAttribute("vente", listVente);

            // Ajout d'un log pour vérification
            System.out.println("Chemin JSP: " + request.getServletContext().getRealPath("/vente/index.jsp"));

            request.getRequestDispatcher("/vente/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur de chargement : " + e.getMessage());
//            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de gestion des ventes de carburant.";
    }
}
