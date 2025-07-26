package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.StationModel;
import serviceImplement.StationDao;

public class StationServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(StationServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                supprimerStation(request, response);
            } else if ("edit".equals(action)) {
                afficherFormulaireEdition(request, response);
            } else {
                load(request, response);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur dans doGet", e);
            request.setAttribute("erreur", "Une erreur technique est survenue");
            load(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            if ("add".equals(action)) {
                enregistrerNouvelleStation(request, response);
            } else if ("edit".equals(action)) {
                modifierStationExistante(request, response);
            } else {
                load(request, response);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur dans doPost", e);
            request.setAttribute("erreur", "Erreur lors du traitement: " + e.getMessage());
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
        }
    }

    private void load(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        StationDao sdDao = null;
        try {
            sdDao = new StationDao();
            List<StationModel> listStation = sdDao.afficherTout();
            request.setAttribute("listStation", listStation);
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors du chargement des stations", e);
            request.setAttribute("erreur", "Erreur de connexion à la base de données");
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
        }
    }

    private void enregistrerNouvelleStation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        StationDao sdDao = null;
        try {
            // Validation des données
            String numero = request.getParameter("numero");
            String rue = request.getParameter("rue");
            String commune = request.getParameter("commune");
            
            if (numero == null || rue == null || commune == null || 
                numero.isEmpty() || rue.isEmpty() || commune.isEmpty()) {
                throw new IllegalArgumentException("Tous les champs textuels sont obligatoires");
            }
            
            int capaciteGazoline = Integer.parseInt(request.getParameter("capaciteGazoline"));
            int quantiteGazoline = Integer.parseInt(request.getParameter("quantiteGazoline"));
            int capaciteDiesel = Integer.parseInt(request.getParameter("capaciteDiesel"));
            int quantiteDiesel = Integer.parseInt(request.getParameter("quantiteDiesel"));

            // Validation des quantités
            if (quantiteGazoline > capaciteGazoline) {
                throw new IllegalArgumentException("La quantité Gazoline ne peut pas dépasser la capacité");
            }
            
            if (quantiteDiesel > capaciteDiesel) {
                throw new IllegalArgumentException("La quantité Diesel ne peut pas dépasser la capacité");
            }

            // Création du modèle
            StationModel stModel = new StationModel();
            stModel.setNumero(numero);
            stModel.setRue(rue);
            stModel.setCommune(commune);
            stModel.setCapaciteGazoline(capaciteGazoline);
            stModel.setQuantiteGazoline(quantiteGazoline);
            stModel.setCapaciteDiesel(capaciteDiesel);
            stModel.setQuantiteDiesel(quantiteDiesel);

            // Enregistrement
            sdDao = new StationDao();
            boolean resultat = sdDao.ajouter(stModel);

            if (!resultat) {
                throw new SQLException("Échec de l'enregistrement dans la base de données");
            }

            response.sendRedirect(request.getContextPath() + "/StationServlet");

        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "Veuillez entrer des nombres valides pour les capacités et quantités");
            conserverValeursFormulaire(request);
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            conserverValeursFormulaire(request);
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de l'enregistrement", e);
            request.setAttribute("erreur", "Erreur technique: " + e.getMessage());
            conserverValeursFormulaire(request);
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
        }
    }

    private void conserverValeursFormulaire(HttpServletRequest request) {
        request.setAttribute("numero", request.getParameter("numero"));
        request.setAttribute("rue", request.getParameter("rue"));
        request.setAttribute("commune", request.getParameter("commune"));
        request.setAttribute("capaciteGazoline", request.getParameter("capaciteGazoline"));
        request.setAttribute("quantiteGazoline", request.getParameter("quantiteGazoline"));
        request.setAttribute("capaciteDiesel", request.getParameter("capaciteDiesel"));
        request.setAttribute("quantiteDiesel", request.getParameter("quantiteDiesel"));
    }

    private void modifierStationExistante(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        StationDao sdDao = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Validation des données
            String numero = request.getParameter("numero");
            String rue = request.getParameter("rue");
            String commune = request.getParameter("commune");
            
            if (numero == null || rue == null || commune == null || 
                numero.isEmpty() || rue.isEmpty() || commune.isEmpty()) {
                throw new IllegalArgumentException("Tous les champs textuels sont obligatoires");
            }
            
            int capaciteGazoline = Integer.parseInt(request.getParameter("capaciteGazoline"));
            int quantiteGazoline = Integer.parseInt(request.getParameter("quantiteGazoline"));
            int capaciteDiesel = Integer.parseInt(request.getParameter("capaciteDiesel"));
            int quantiteDiesel = Integer.parseInt(request.getParameter("quantiteDiesel"));

            // Validation des quantités
            if (quantiteGazoline > capaciteGazoline) {
                throw new IllegalArgumentException("La quantité Gazoline ne peut pas dépasser la capacité");
            }
            
            if (quantiteDiesel > capaciteDiesel) {
                throw new IllegalArgumentException("La quantité Diesel ne peut pas dépasser la capacité");
            }

            // Création du modèle
            StationModel stModel = new StationModel();
            stModel.setId(id);
            stModel.setNumero(numero);
            stModel.setRue(rue);
            stModel.setCommune(commune);
            stModel.setCapaciteGazoline(capaciteGazoline);
            stModel.setQuantiteGazoline(quantiteGazoline);
            stModel.setCapaciteDiesel(capaciteDiesel);
            stModel.setQuantiteDiesel(quantiteDiesel);

            // Mise à jour
            sdDao = new StationDao();
            boolean resultat = sdDao.modifier(stModel);

            if (!resultat) {
                throw new SQLException("Échec de la mise à jour dans la base de données");
            }

            response.sendRedirect(request.getContextPath() + "/StationServlet");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la modification", e);
            request.setAttribute("erreur", "Erreur lors de la modification: " + e.getMessage());
            request.getRequestDispatcher("/stations/modifier.jsp").forward(request, response);
        }
    }

    private void afficherFormulaireEdition(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        StationDao sdDao = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            sdDao = new StationDao();
            StationModel st = sdDao.rechercherParId(id);

            if (st != null) {
                request.setAttribute("station", st);
                request.getRequestDispatcher("/stations/modifier.jsp").forward(request, response);
            } else {
                request.setAttribute("erreur", "Station introuvable.");
                request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de l'affichage du formulaire", e);
            request.setAttribute("erreur", "Erreur technique: " + e.getMessage());
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
        }
    }

    private void supprimerStation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        StationDao sdDao = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            sdDao = new StationDao();
            boolean resultat = sdDao.supprimer(id);
            
            if (!resultat) {
                request.setAttribute("erreur", "Échec de la suppression de la station");
                load(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/StationServlet");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la suppression", e);
            request.setAttribute("erreur", "Erreur lors de la suppression: " + e.getMessage());
            load(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de gestion des stations";
    }
}