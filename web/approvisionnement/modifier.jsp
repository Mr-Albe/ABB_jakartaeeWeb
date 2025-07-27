protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // Initialisation
    HttpSession session = request.getSession();
    approvisionnement = new ApprovisionnementModel();
    
    try {
        // 1. R�cup�ration et validation des param�tres
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
        
        // 3. V�rification des contraintes m�tier
        if (quantite <= 0) {
            throw new IllegalArgumentException("La quantit� doit �tre positive");
        }
        
        // 4. Hydratation de l'objet
        approvisionnement.setId(id);
        approvisionnement.setQuantite(quantite);
        approvisionnement.setDateLivraison(dateLivraison);
        approvisionnement.setNumStation(request.getParameter("stationId"));
        approvisionnement.setTypeCarburant(request.getParameter("type"));
        approvisionnement.setFournisseur(request.getParameter("fournisseur"));
        
        // 5. V�rification capacit�
        stationDao = new StationDao();
        int capacite = stationDao.getCapaciteParStationIdType(
            approvisionnement.getNumStation(), 
            approvisionnement.getTypeCarburant()
        );
        
        if (quantite > capacite) {
            throw new IllegalStateException(
                "La quantit� ne doit pas d�passer la capacit� maximale (" + capacite + ")"
            );
        }
        
        // 6. Persistance
        approDao = new ApprovisionnementDao();
        if (id > 0) {
            approDao.modifier(approvisionnement);
        } else {
            approDao.ajouter(approvisionnement);
        }
        
        // 7. Succ�s - redirection
        response.sendRedirect(request.getContextPath() + "/ApprovisionnementServlet");
        
    } catch (Exception e) {
        // Journalisation
        Logger.getLogger(getClass().getName()).log(Level.SEVERE, "Erreur approvisionnement", e);
        
        // Pr�paration erreur
        session.setAttribute("erreur", e.getMessage());
        request.setAttribute("approvisionnement", approvisionnement);
        
        // R�affichage formulaire
        request.getRequestDispatcher("/approvisionnement/add_edit.jsp")
               .forward(request, response);
    }
}