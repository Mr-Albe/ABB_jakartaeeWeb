package model;

import java.time.LocalDate;


public class ApprovisionnementModel {
    private int id;
    private String numStation;
    private String typeCarburant;
    private int quantite;
    private LocalDate dateLivraison;
    private String fournisseur;

   

    public ApprovisionnementModel() {
    }
    
    public ApprovisionnementModel(int id, String numStation, String typeCarburant, int quantite, LocalDate dateLivraison, String fournisseur) {
        this.id = id;
        this.numStation = numStation;
        this.typeCarburant = typeCarburant;
        this.quantite = quantite;
        this.dateLivraison = dateLivraison;
        this.fournisseur = fournisseur;
    }
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNumStation() {
        return numStation;
    }

    public void setNumStation(String numStation) {
        this.numStation = numStation;
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
    }

    public LocalDate getDateLivraison() {
        return dateLivraison;
    }

    public void setDateLivraison(LocalDate dateLivraison) {
        this.dateLivraison = dateLivraison;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

}
