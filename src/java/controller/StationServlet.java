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
import java.sql.SQLIntegrityConstraintViolationException;

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
            } else if ("logout".equals(action)) {
                request.getSession().invalidate();
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
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
        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("erreur", "Ouf! Impossible de supprimer cette station");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Désolé! une Erreur lors du chargement des stations", e);
            request.setAttribute("erreur", "Désolé! une erreur de connexion à la base de données");
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
        }
    }

    // ...
    private void conserverValeursFormulaire(HttpServletRequest request) {
        request.setAttribute("numero", request.getParameter("numero"));
        request.setAttribute("rue", request.getParameter("rue"));
        request.setAttribute("commune", request.getParameter("commune"));
        request.setAttribute("capaciteGazoline", request.getParameter("capaciteGazoline"));
        request.setAttribute("quantiteGazoline", request.getParameter("quantiteGazoline"));
        request.setAttribute("capaciteDiesel", request.getParameter("capaciteDiesel"));
        request.setAttribute("quantiteDiesel", request.getParameter("quantiteDiesel"));
    }

    // Methode pour lire et valider le formulaire
    private StationModel lireEtvaliderStation(HttpServletRequest request) {
        String numero = request.getParameter("numero");
        String rue = request.getParameter("rue");
        String commune = request.getParameter("commune");
        String capaciteGazolineSTr = request.getParameter("capaciteGazoline");
        String quantiteGazolineSTr = request.getParameter("quantiteGazoline");
        String capaciteDieselSTr = request.getParameter("capaciteDiesel");
        String quantiteDieselSTr = request.getParameter("quantiteDiesel");

        if (numero == null || numero.trim().isEmpty()
                || rue == null || rue.trim().isEmpty()
                || commune == null || commune.trim().isEmpty()
                || capaciteGazolineSTr == null || capaciteGazolineSTr.trim().isEmpty()
                || quantiteGazolineSTr == null || quantiteGazolineSTr.trim().isEmpty()
                || capaciteDieselSTr == null || capaciteDieselSTr.trim().isEmpty()
                || quantiteDieselSTr == null || quantiteDieselSTr.trim().isEmpty()) {
            throw new IllegalArgumentException("Tous les champs textuels sont obligatoires");
        }

        int capaciteGazoline = Integer.parseInt(capaciteGazolineSTr.trim());
        int quantiteGazoline = Integer.parseInt(quantiteGazolineSTr.trim());
        int capaciteDiesel = Integer.parseInt(capaciteDieselSTr.trim());
        int quantiteDiesel = Integer.parseInt(quantiteDieselSTr.trim());

        if (quantiteGazoline > capaciteGazoline) {
            throw new IllegalArgumentException("La quantité Gazoline ne peut pas dépasser la capacité");
        }

        if (quantiteDiesel > capaciteDiesel) {
            throw new IllegalArgumentException("La quantité Diesel ne peut pas dépasser la capacité");
        }

        return new StationModel(0, numero, rue, commune, capaciteGazoline, capaciteDiesel, quantiteGazoline, quantiteDiesel);
    }

    // Methode pour l'enregistrement des stations
    private void enregistrerNouvelleStation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StationDao sdDao = null;
        try {
            // on recupere un objet de StationModel de la methode lireEtvaliderStation(param)
            StationModel stationForm = lireEtvaliderStation(request);

            StationModel stModel = new StationModel();
            stModel.setNumero(stationForm.getNumero());
            stModel.setRue(stationForm.getRue());
            stModel.setCommune(stationForm.getCommune());
            stModel.setCapaciteGazoline(stationForm.getCapaciteGazoline());
            stModel.setQuantiteGazoline(stationForm.getQuantiteGazoline());
            stModel.setCapaciteDiesel(stationForm.getCapaciteDiesel());
            stModel.setQuantiteDiesel(stationForm.getQuantiteDiesel());

            sdDao = new StationDao();
            boolean resultat = sdDao.ajouter(stModel);

            if (!resultat) {
                throw new SQLException("Échec de l'enregistrement dans la base de données");
            }

            response.sendRedirect(request.getContextPath() + "/StationServlet");
            return;

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

    private void modifierStationExistante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StationDao sdDao;
        StationModel stModel = null;
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // on recupere un objet de StationModel de la methode lireEtvaliderStation(param)
            StationModel stationForm = lireEtvaliderStation(request);

            stModel = new StationModel();
            stModel.setId(id);
            stModel.setNumero(stationForm.getNumero());
            stModel.setRue(stationForm.getRue());
            stModel.setCommune(stationForm.getCommune());
            stModel.setCapaciteGazoline(stationForm.getCapaciteGazoline());
            stModel.setQuantiteGazoline(stationForm.getQuantiteGazoline());
            stModel.setCapaciteDiesel(stationForm.getCapaciteDiesel());
            stModel.setQuantiteDiesel(stationForm.getQuantiteDiesel());

            sdDao = new StationDao();
            boolean resultat = sdDao.modifier(stModel);

            if (!resultat) {
                request.setAttribute("erreur", "Échec de la mise à jour dans la base de données");
                request.setAttribute("station", stModel);
                request.getRequestDispatcher("/stations/modifier.jsp").forward(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/StationServlet");
            return;

        } catch (IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Erreur lors de la modification", e);
            request.setAttribute("erreur", e.getMessage());
            request.setAttribute("station", stModel);
            request.getRequestDispatcher("/stations/modifier.jsp").forward(request, response);
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
        } catch (SQLIntegrityConstraintViolationException e) {
            logger.log(Level.SEVERE, "Erreur lors de la suppression", e);
            request.setAttribute("erreur", "Ouf! ce n'est pas de votre faute, cette station ne peut pas etre supprimee en raison de ces activites: ");
            load(request, response);
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
