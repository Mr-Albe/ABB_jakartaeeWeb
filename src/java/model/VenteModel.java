package model;

import java.time.LocalDate;

/**
 * Représente une vente de carburant (gazoline ou diesel).
 */
public class VenteModel {
    private int id;
    private int stationId;
    private String typeCarburant; // "gazoline" ou "diesel"
    private int quantite;
    private double prixUnitaire;
    private LocalDate dateVente;
    private double revenu;

    // Constructeur vide
    public VenteModel() {
    }
    
    // Constructeur 
    public VenteModel(int id, int stationId, String typeCarburant, int quantite, double prixUnitaire, LocalDate dateVente, double revenu) {
        this.id = id;
        this.stationId = stationId;
        this.typeCarburant = typeCarburant;
        this.quantite = quantite;
        this.prixUnitaire = prixUnitaire;
        this.dateVente = dateVente;
        this.revenu = revenu;
    }
          
    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStationId() {
        return stationId;
    }

    public void setStationId(int stationId) {
        this.stationId = stationId;
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
        calculerRevenu(); // calcul automatique lors du set
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
