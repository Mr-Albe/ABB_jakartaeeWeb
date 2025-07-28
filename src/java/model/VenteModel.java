package model;

import java.time.LocalDate;

/**
 * Représente une vente de carburant (gazoline ou diesel).
 */
public class VenteModel {
    private int id;
    private String numStationId;
    private String typeCarburant; 
    private int quantite;
    private double prixUnitaire;
    private LocalDate dateVente;
    private double revenu;

    // Constructeur vide
    public VenteModel() {
    }
    
    // Constructeur 
    public VenteModel(int id, String numStationId, String typeCarburant, int quantite, double prixUnitaire, LocalDate dateVente) {
        this.id = id;
        this.numStationId = numStationId;
        this.typeCarburant = typeCarburant;
        this.quantite = quantite;
        this.prixUnitaire = prixUnitaire;
        this.dateVente = dateVente;
    }
          
    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumStation() {
        return numStationId;
    }

    public void setNumStation(String numStationId) {
        this.numStationId = numStationId;
    }

    public String getTypeCarburant() {
        return typeCarburant;
    }

    public void setTypeCarburant(String typeCarburant) {
        this.typeCarburant = typeCarburant;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
        // calcul automatique lors du  revenu
        calculerRevenu(); 
    }

    public double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
        calculerRevenu(); // idem
    }

    public LocalDate getDateVente() {
        return dateVente;
    }

    public void setDateVente(LocalDate dateVente) {
        this.dateVente = dateVente;
    }

    public double getRevenu() {
        return revenu;
    }

    private void calculerRevenu() {
        this.revenu = this.quantite * this.prixUnitaire;
    }
}
