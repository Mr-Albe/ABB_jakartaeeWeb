
package model;

import java.time.LocalDate;


public class ApprovisionnementModel {
    private int id;
    private int stationId;
    private String typeCarburant;
    private int quantite;
    private LocalDate dateLivraison;
    private int fournisseur;

   

    public ApprovisionnementModel() {
    }
    
    public ApprovisionnementModel(int id, int stationId, String typeCarburant, int quantite, LocalDate dateLivraison, int fournisseur) {
        this.id = id;
        this.stationId = stationId;
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
    }

    public LocalDate getDateLivraison() {
        return dateLivraison;
    }

    public void setDateLivraison(LocalDate dateLivraison) {
        this.dateLivraison = dateLivraison;
    }

    public int getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(int fournisseur) {
        this.fournisseur = fournisseur;
    }

}
