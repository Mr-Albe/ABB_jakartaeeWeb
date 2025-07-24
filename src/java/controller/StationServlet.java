package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.StationModel;
import serviceImplement.StationDao;

public class StationServlet extends HttpServlet {

    StationModel stModel = null;
    StationDao sdDao = null;

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
            out.println("<title>Servlet StationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StationServlet at " + request.getContextPath() + "</h1>");
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

        if ("calculerPourcentage".equals(action)) {
            calculerPourcentage(request, response);
        } else if ("delete".equals(action)) {
            try {
                supprimerStation(request, response); // fait un redirect interne
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(StationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("edit".equals(action)) {
            try {
                afficherFormulaireEdition(request, response);
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(StationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            load(request, response);
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
    
    // redirection vers la page station/index.jsp
    protected void load(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Initialisation du DAO
            sdDao = new StationDao();

            // Recuperation de toutes les stations depuis la base de donnees
            List<StationModel> listStation = sdDao.afficherTout();

            // Ajout de la liste dans les attributs de la requete
            request.setAttribute("listStation", listStation);

            // Redirection vers la page index.jsp
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);


        } catch (ClassNotFoundException | SQLException e) {
            // En cas d'erreur, transmettre un message d'erreur a la JSP
            request.setAttribute("erreur", "Erreur de connexion à la base de données : ");
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
        }
    }
    
    
    // Méthode pour enregistrer une station à partir des données du formulaire
    protected void enregistrer(HttpServletRequest request, HttpServletResponse response) {
        try {
            //  Creer un objet modele StationModel vide
            stModel = new StationModel();

            //  Remplir l'objet avec les paramètres envoyes depuis le formulaire HTML
            stModel.setNumero(request.getParameter("numero"));
            stModel.setRue(request.getParameter("rue"));
            stModel.setCommune(request.getParameter("commune"));

            int ctGazoline = Integer.parseInt(request.getParameter("capaciteGazoline"));
            stModel.setCapaciteGazoline(ctGazoline);
            int qteGazoline = Integer.parseInt(request.getParameter("quantiteGazoline"));
            stModel.setQuantiteGazoline(qteGazoline);

            if (qteGazoline > ctGazoline) {
                setStationFormAttributes(request);
                request.setAttribute("erreur", "La quantite de Gazoline doit etre inferieure ou egale a la capacite.");
                request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
                return;
            }

            int ctDiesel = Integer.parseInt(request.getParameter("capaciteDiesel"));
            stModel.setCapaciteDiesel(ctDiesel);
            int qteDiesel = Integer.parseInt(request.getParameter("quantiteDiesel"));

            stModel.setQuantiteDiesel(qteDiesel);
            if (qteDiesel > ctDiesel) {
                setStationFormAttributes1(request);
                request.setAttribute("erreur", "La quantite de Diesel doit etre inferieure ou egale a la capacite.");
                request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
                return;
            }

            // 3. Utiliser la couche service/DAO pour enregistrer dans la base
            sdDao = new StationDao();
            boolean resultat = sdDao.ajouter(stModel);

            // 4. Verifier si l'enregistrement a reussi et rediriger ou afficher message
            if (resultat) {
                load(request, response);
                return;
            }

            // Échec : message d'erreur
            request.setAttribute("erreur", "Échec de l'enregistrement.");

            // 5. Transfert vers la vue (JSP)
            request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);

        } catch (ServletException | IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            // 6. Gestion des erreurs
            request.setAttribute("erreur", "Erreur : " + e.getMessage());
            try {
                request.getRequestDispatcher("/stations/ajouter.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
            }
        }
    }

    //méthodes pour  extraire tous les paramètres du formulaire "Ajouter une Station"
    // et les réinjecte dans la requête comme attributs pour pouvoir pré-remplir les champs
    // du formulaire en cas d'erreur quantités invalides.
    private void setStationFormAttributes(HttpServletRequest request) {
        request.setAttribute("numero", request.getParameter("numero"));
        request.setAttribute("rue", request.getParameter("rue"));
        request.setAttribute("commune", request.getParameter("commune"));
        request.setAttribute("capaciteGazoline", request.getParameter("capaciteGazoline"));
        request.setAttribute("capaciteDiesel", request.getParameter("capaciteDiesel"));
        request.setAttribute("quantiteDiesel", request.getParameter("quantiteDiesel"));
    }

    private void setStationFormAttributes1(HttpServletRequest request) {
        request.setAttribute("numero", request.getParameter("numero"));
        request.setAttribute("rue", request.getParameter("rue"));
        request.setAttribute("commune", request.getParameter("commune"));
        request.setAttribute("capaciteGazoline", request.getParameter("capaciteGazoline"));
        request.setAttribute("capaciteDiesel", request.getParameter("capaciteDiesel"));
        request.setAttribute("quantiteGazoline", request.getParameter("quantiteGazoline"));
    }

    private void calculerPourcentage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer l'identifiant de la station depuis le formulaire
            int id = Integer.parseInt(request.getParameter("idStation"));

            // Initialiser le DAO et rechercher la station
            sdDao = new StationDao();
            stModel = sdDao.rechercherParId(id);

            if (stModel != null) {
                // Calcul des pourcentages
                double pourcentageGazoline = 0;
                double pourcentageDiesel = 0;

                if (stModel.getCapaciteGazoline() > 0) {
                    pourcentageGazoline = (stModel.getQuantiteGazoline() * 100.0) / stModel.getCapaciteGazoline();
                }

                if (stModel.getCapaciteDiesel() > 0) {
                    pourcentageDiesel = (stModel.getQuantiteDiesel() * 100.0) / stModel.getCapaciteDiesel();
                }

                // Stocker les données dans les attributs de requête
                request.setAttribute("station", stModel);
                request.setAttribute("pourcentageGazoline", pourcentageGazoline);
                request.setAttribute("pourcentageDiesel", pourcentageDiesel);
            } else {
                request.setAttribute("err", " Station non trouvée.");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("err", " ID de station invalide.");
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("err", " Erreur lors du calcul : " + e.getMessage());
        }

        load(request, response);
    }

    private void afficherFormulaireEdition(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        StationModel st = sdDao.rechercherParId(id);

        if (st != null) {
            request.setAttribute("station", st);
            request.getRequestDispatcher("/stations/modifier.jsp").forward(request, response);
        } else {
            request.setAttribute("err", "Station introuvable.");
            request.getRequestDispatcher("/stations/index.jsp").forward(request, response);
        }
    }

    private void supprimerStation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {

        int id = Integer.parseInt(request.getParameter("id"));
        sdDao = new StationDao();
        sdDao.supprimer(id);
        response.sendRedirect("StationServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;

            stModel = new StationModel();
            stModel.setNumero(request.getParameter("numero"));
            stModel.setRue(request.getParameter("rue"));
            stModel.setCommune(request.getParameter("commune"));
            stModel.setCapaciteGazoline(Integer.parseInt(request.getParameter("capaciteGazoline")));
            stModel.setQuantiteGazoline(Integer.parseInt(request.getParameter("quantiteGazoline")));
            stModel.setCapaciteDiesel(Integer.parseInt(request.getParameter("capaciteDiesel")));
            stModel.setQuantiteDiesel(Integer.parseInt(request.getParameter("quantiteDiesel")));

            if (id > 0) {
                stModel.setId(id);
                sdDao = new StationDao();
                sdDao.modifier(stModel); 
            } else {
                enregistrer(request,response); 
            }

            response.sendRedirect(request.getContextPath() + "/StationServlet");

        } catch (IOException | ClassNotFoundException | NumberFormatException | SQLException e) {
            request.setAttribute("erreur", "Erreur lors de l'enregistrement de la station.");
            request.getRequestDispatcher("/stations/modifier.jsp").forward(request, response);
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
