package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ApprovisionnementModel;
import model.StationModel;
import serviceImplement.ApprovisionnementDao;
import serviceImplement.StationDao;

public class ApprovisionnementServlet extends HttpServlet {

    StationModel station;
    ApprovisionnementModel approvisionnement;
    ApprovisionnementDao approDao;
    StationDao stationDao;

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
            out.println("<title>Servlet ApprovisionnementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApprovisionnementServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if (null == action) {
            load(request, response);
        } else {
            switch (action) {
                case "delete" -> {
                    try {
                        deleteApprovisionnement(request, response);
                    } catch (SQLException | ClassNotFoundException ex) {
                        Logger.getLogger(ApprovisionnementServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                case "edit" -> {
                    try {
                        afficherFormulaireEdition(request, response);
                    } catch (ClassNotFoundException | SQLException ex) {
                        Logger.getLogger(ApprovisionnementServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                default ->
                    load(request, response);
            }
        }
    }

    // ...
    protected void load(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Ceer un objet de ApprovisionnementDao
            ApprovisionnementDao appDao = new ApprovisionnementDao();
            //creer une liste generique pour recuperer Approvisionnement depuis la methode afficherTout
            List<ApprovisionnementModel> appList = appDao.afficherTout();
            // Ajout de la liste dans les attributs de la requete
            request.setAttribute("listApprovisionnement", appList);
            // Redirection vers la page index.jsp
            request.getRequestDispatcher("/approvisionnement/index.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException ex) {
            // En cas d'erreur, transmettre un message d'erreur a la JSP
            request.setAttribute("erreur", "Erreur de connexion à la base de données : "+ex);
            request.getRequestDispatcher("/approvisionnement/index.jsp").forward(request, response);
        }

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
        try {
            int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;
            if (id > 0) {
                approvisionnement = new ApprovisionnementModel();
                approvisionnement.setId(id);
                approvisionnement.setStationId(Integer.parseInt(request.getParameter("stationId")));
                approvisionnement.setTypeCarburant(request.getParameter("type"));
                approvisionnement.setQuantite(Integer.parseInt(request.getParameter("quantite")));
                approvisionnement.setDateLivraison(LocalDate.parse(request.getParameter("dateLivraison")));
                approvisionnement.setFournisseur(request.getParameter("fournisseur"));
                // Vérification de la capacité
                int stationId = approvisionnement.getStationId();
                int quantite = approvisionnement.getQuantite();
                String type = request.getParameter("type");

                stationDao = new StationDao();
                int capacite = stationDao.getCapaciteParStationIdType(stationId,type);

                if (quantite > capacite) {
                    request.setAttribute("erreur", "La quantité ne doit pas dépasser la capacité maximale de la station (" + capacite + " gallons).");
                    request.setAttribute("approvisionnement", approvisionnement);
                    request.getRequestDispatcher("/approvisionnement/modifier.jsp").forward(request, response);
                    return;
                }

                approDao = new ApprovisionnementDao();
                approDao.modifier(approvisionnement);
                response.sendRedirect(request.getContextPath() + "/ApprovisionnementServlet");
            } else {
                enregistrer(request, response);
            }

        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            request.setAttribute("erreur", "Erreur lors de l'enregistrement de l'approvisionnement.");
            request.getRequestDispatcher("/approvisionnement/modifier.jsp").forward(request, response);
        }
    }

    private void enregistrer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Récupération des paramètres

        String typeCarburant = request.getParameter("type");
        String quantiteStr = request.getParameter("quantite");
        String dateStr = request.getParameter("dateLivraison");
        String fournisseur = request.getParameter("fournisseur");
        String stationIdStr = request.getParameter("stationId");

        //Validation simple des paramètres
        if (typeCarburant == null || quantiteStr == null || dateStr == null || fournisseur == null || stationIdStr == null
                || typeCarburant.isEmpty() || quantiteStr.isEmpty() || dateStr.isEmpty() || fournisseur.isEmpty() || stationIdStr.isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires.");
            showForm(request, response);
            return;
        }

        try {
            int quantite = Integer.parseInt(quantiteStr);
            int stationId = Integer.parseInt(stationIdStr);
            LocalDate dateLivraison;
            dateLivraison = LocalDate.parse(dateStr);

            // Récupérer la station
            stationDao = new StationDao();
            station = stationDao.rechercherParId(stationId);
            if (station == null) {
                request.setAttribute("error", "Station introuvable.");
                showForm(request, response);
                return;
            }

            int capaciteMax = 0;
            int quantiteActuelle = 0;

            if ("gazoline".equalsIgnoreCase(typeCarburant)) {
                capaciteMax = station.getCapaciteGazoline();
                quantiteActuelle = station.getQuantiteGazoline();
            } else if ("diesel".equalsIgnoreCase(typeCarburant)) {
                capaciteMax = station.getCapaciteDiesel();
                quantiteActuelle = station.getQuantiteDiesel();
            } else {
                request.setAttribute("error", "Type de carburant invalide.");
                showForm(request, response);
                return;
            }

            int quantiteLibre = capaciteMax - quantiteActuelle;
            if (quantite > quantiteLibre) {
                request.setAttribute("error", "La quantité livrée dépasse la capacité restante du réservoir (" + quantiteLibre + " L disponibles).");
                showForm(request, response);
                return;
            }

            // Enregistrer l'approvisionnement
            approvisionnement = new ApprovisionnementModel();
            approvisionnement.setStationId(stationId);
            approvisionnement.setTypeCarburant(typeCarburant);
            approvisionnement.setQuantite(quantite);
            approvisionnement.setDateLivraison(dateLivraison);
            approvisionnement.setFournisseur(fournisseur);

            approDao = new ApprovisionnementDao();
            boolean ajoutOk = approDao.ajouter(approvisionnement);

            if (!ajoutOk) {
                request.setAttribute("error", "Erreur lors de l'enregistrement de la livraison.");
                showForm(request, response);
                return;
            }

            // Mise à jour du stock dans la station
            if ("gazoline".equalsIgnoreCase(typeCarburant)) {
                station.setQuantiteGazoline(quantiteActuelle + quantite);
            } else {
                station.setQuantiteDiesel(quantiteActuelle + quantite);
            }
            boolean majOk = stationDao.modifier(station);

            if (!majOk) {
                request.setAttribute("error", "Erreur lors de la mise à jour du stock.");
                showForm(request, response);
                return;
            }

            // Tout OK, rediriger vers la liste ou confirmation
            response.sendRedirect("ApprovisionnementServlet");

        } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
            request.setAttribute("error", "Erreur : " + e.getMessage());
            showForm(request, response);
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Date invalide.");
            showForm(request, response);
        }
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("approvisionnement/enregistrement.jsp").forward(request, response);
    }

    private void afficherFormulaireEdition(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        approvisionnement = new ApprovisionnementModel();
        approDao = new ApprovisionnementDao();
        approvisionnement = approDao.rechercherParId(id);

        if (approvisionnement != null) {
            request.setAttribute("approvisionnement", approvisionnement);
            request.getRequestDispatcher("/approvisionnement/modifier.jsp").forward(request, response);
        } else {
            request.setAttribute("err", "Approvisionnement introuvable.");
            request.getRequestDispatcher("/approvisionnement/index.jsp").forward(request, response);
        }
    }

    private void deleteApprovisionnement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ClassNotFoundException, IOException {
        //
        int id = Integer.parseInt(request.getParameter("id"));
        approDao = new ApprovisionnementDao();
        approDao.supprimer(id);
        response.sendRedirect("ApprovisionnementServlet");
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
