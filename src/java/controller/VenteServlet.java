package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

        HttpSession session = request.getSession();
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
        } catch (ServletException | IOException | ClassNotFoundException | SQLException ex) {
            Logger.getLogger(VenteServlet.class.getName()).log(Level.SEVERE, null, ex);
            session.setAttribute("erreur", "Erreur lors de l'opération : " + ex.getMessage());
            load(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equalsIgnoreCase(action)) {
                enregistrer(request, response);
            } else {
                throw new IllegalArgumentException("Erreur : Une erreur technique!");
            }

        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur lors du traitement: " + e.getMessage());
//            load(request, response);
            request.getRequestDispatcher("/vente/ajouter.jsp").forward(request, response);
        }
    }

    // Methode pour valider les champs du formulaire de vente
    private VenteModel lireEtValiderVente(HttpServletRequest request) {
        String num_stationIStr = request.getParameter("num_station");
        String typeCarburant = request.getParameter("type_carburant");
        String quantiteStr = request.getParameter("quantite");
        String prixStr = request.getParameter("prix_vente");
        String dateStr = request.getParameter("date_vente");

        if (num_stationIStr == null || num_stationIStr.trim().isEmpty()
                || typeCarburant == null || typeCarburant.trim().isEmpty()
                || quantiteStr == null || quantiteStr.trim().isEmpty()
                || prixStr == null || prixStr.trim().isEmpty()
                || dateStr == null || dateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Tous les champs textuels sont obligatoires");
        }

        int quantiteDemandee = Integer.parseInt(quantiteStr.trim());
        double prixUnitaire = Double.parseDouble(prixStr.trim());
        LocalDate dateVente = LocalDate.parse(dateStr.trim());

        return new VenteModel(0, num_stationIStr.trim(), typeCarburant.trim(), quantiteDemandee, prixUnitaire, dateVente);
    }

    // Methode pour l'enregistrement d'une vente
    protected void enregistrer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // recuperer les donnee du formulaire
            VenteModel venteForm = lireEtValiderVente(request);

            // Recuperer la quantite de carburant de la station en utilisant la methode 
            //getquantiteParStationIdType(param1, param2) suivant le type de carburant choisi
            stationdao = new StationDao();
            int stockDisponible = stationdao.getquantiteParNumStationType(venteForm.getNumStation(), venteForm.getTypeCarburant());

            if (stockDisponible < venteForm.getQuantite()) {
                session.setAttribute("erreur", "La quantité disponible en " + venteForm.getTypeCarburant() + " est insuffisante.");
                request.setAttribute("vente", venteForm);
                request.getRequestDispatcher("vente/ajouter.jsp");
            }
            venteModel = new VenteModel();
            venteModel.setNumStation(venteForm.getNumStation());
            venteModel.setTypeCarburant(venteForm.getTypeCarburant());
            venteModel.setQuantite(venteForm.getQuantite());
            venteModel.setPrixUnitaire(venteForm.getPrixUnitaire());
            venteModel.setDateVente(venteForm.getDateVente());

            int lineAffectee = stationdao.retirerQuantite(venteForm.getNumStation(), venteForm.getTypeCarburant(), venteForm.getQuantite());

            if (lineAffectee == 0) {
                throw new IllegalStateException("Impossible de vendre " + venteForm.getQuantite() + " gallons de " + venteForm.getTypeCarburant() + ", quantité insuffisante.");
            }

            // ajouter la vente dans la base de donnee
            venteDao = new VenteDao();
            venteDao.ajouter(venteModel);
            load(request, response);

        } catch (NumberFormatException e) {
            // recuperer les donnee du formulaire puis les recharger dans les champs
            VenteModel venteForm = lireEtValiderVente(request);
            session.setAttribute("erreur", "Veuillez entrer des nombres valides pour la quantité");
            request.setAttribute("vente", venteForm);
            request.getRequestDispatcher("/vente/ajouter.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            // recuperer les donnee du formulaire puis les recharger dans les champs
            VenteModel venteForm = lireEtValiderVente(request);
            session.setAttribute("erreur", e.getMessage());
            request.setAttribute("vente", venteForm);
            request.getRequestDispatcher("/vente/ajouter.jsp").forward(request, response);
        } catch (Exception e) {
            // recuperer les donnee du formulaire puis les recharger dans les champs
            VenteModel venteForm = lireEtValiderVente(request);
            session.setAttribute("erreur", "Erreur lors de l’enregistrement : " + e.getMessage());
            request.setAttribute("vente", venteForm);
            request.getRequestDispatcher("vente/ajouter.jsp").forward(request, response);
        }

    }

    protected void load(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        venteDao = new VenteDao();
        HttpSession session = request.getSession();
        try {
            List<VenteModel> listVente = venteDao.afficherTout();
            request.setAttribute("vente", listVente);

            // Ajout d'un log pour verification
            System.out.println("Chemin JSP: " + request.getServletContext().getRealPath("/vente/index.jsp"));

            request.getRequestDispatcher("/vente/index.jsp").forward(request, response);
        } catch (ServletException | IOException | ClassNotFoundException | SQLException e) {
            session.setAttribute("erreur", "Erreur de chargement : " + e.getMessage());
            request.getRequestDispatcher("/vente/index.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de gestion des ventes de carburant.";
    }
}
