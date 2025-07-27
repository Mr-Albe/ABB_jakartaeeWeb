protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Initialisation
    HttpSession session = request.getSession();
    approvisionnement = new ApprovisionnementModel();
    
    try {
        // 1. Récupération et validation des paramètres
        String idStr = request.getParameter("id");
        String quantiteStr = request.getParameter("quantite");
        String dateStr = request.getParameter("dateLivraison");
        
        // Validation basique
        if (quantiteStr == null || quantiteStr.isEmpty() 
                || dateStr == null || dateStr.isEmpty()) {
            throw new IllegalArgumentException("Tous les champs sont obligatoires");
        }
        
        // 2. Conversion des valeurs
        long id = idStr != null && !idStr.isEmpty() ? Long.parseLong(idStr) : 0;
        long quantite = Long.parseLong(quantiteStr);
        LocalDate dateLivraison = LocalDate.parse(dateStr);
        
        // 3. Vérification des contraintes métier
        if (quantite <= 0) {
            throw new IllegalArgumentException("La quantité doit être positive");
        }
        
        // 4. Hydratation de l'objet
        approvisionnement.setId(id);
        approvisionnement.setQuantite(quantite);
        approvisionnement.setDateLivraison(dateLivraison);
        approvisionnement.setNumStation(request.getParameter("stationId"));
        approvisionnement.setTypeCarburant(request.getParameter("type"));
        approvisionnement.setFournisseur(request.getParameter("fournisseur"));
        
        // 5. Vérification capacité
        stationDao = new StationDao();
        int capacite = stationDao.getCapaciteParStationIdType(
            approvisionnement.getNumStation(), 
            approvisionnement.getTypeCarburant()
        );
        
        if (quantite > capacite) {
            throw new IllegalStateException(
                "La quantité ne doit pas dépasser la capacité maximale (" + capacite + ")"
            );
        }
        
        // 6. Persistance
        approDao = new ApprovisionnementDao();
        if (id > 0) {
            approDao.modifier(approvisionnement);
        } else {
            approDao.ajouter(approvisionnement);
        }
        
        // 7. Succès - redirection
        response.sendRedirect(request.getContextPath() + "/ApprovisionnementServlet");
        
    } catch (Exception e) {
        // Journalisation
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Erreur approvisionnement", e);
        
        // Préparation erreur
        session.setAttribute("erreur", e.getMessage());
        request.setAttribute("approvisionnement", approvisionnement);
        
        // Réaffichage formulaire
        request.getRequestDispatcher("/approvisionnement/add_edit.jsp")
               .forward(request, response);
    }
}