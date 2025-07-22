
package model;


public class StationModel {
    private int id;
    private String numero;
    private String rue;
    private String commune;
    private int capaciteGazoline;
    private int capaciteDiesel;
    private int quantiteGazoline;
    private int quantiteDiesel;

    //  Constructeur vide
    public StationModel() {}

    //  Constructeur complet
    public StationModel(int id , String numero, String rue, String commune,
                   int capaciteGazoline, int capaciteDiesel,
                   int quantiteGazoline, int quantiteDiesel) {
        this.id = id;
        this.numero = numero;
        this.rue = rue;
        this.commune = commune;
        this.capaciteGazoline = capaciteGazoline;
        this.capaciteDiesel = capaciteDiesel;
        this.quantiteGazoline = quantiteGazoline;
        this.quantiteDiesel = quantiteDiesel;
    }

    //  Getters et Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getRue() {
        return rue;
    }

    public void setRue(String rue) {
        this.rue = rue;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    public int getCapaciteGazoline() {
        return capaciteGazoline;
    }

    public void setCapaciteGazoline(int capaciteGazoline) {
        this.capaciteGazoline = capaciteGazoline;
    }

    public int getCapaciteDiesel() {
        return capaciteDiesel;
    }

    public void setCapaciteDiesel(int capaciteDiesel) {
        this.capaciteDiesel = capaciteDiesel;
    }

    public int getQuantiteGazoline() {
        return quantiteGazoline;
    }

    public void setQuantiteGazoline(int quantiteGazoline) {
        this.quantiteGazoline = quantiteGazoline;
    }

    public int getQuantiteDiesel() {
        return quantiteDiesel;
    }

    public void setQuantiteDiesel(int quantiteDiesel) {
        this.quantiteDiesel = quantiteDiesel;
    }


    public int getCapaciteTotale() {
        return capaciteGazoline + capaciteDiesel;
    }

    public int getQuantiteTotale() {
        return quantiteGazoline + quantiteDiesel;
    }

    public double getPourcentageGazoline() {
        return capaciteGazoline == 0 ? 0 : ((double) quantiteGazoline / capaciteGazoline) * 100;
    }

    public double getPourcentageDiesel() {
        return capaciteDiesel == 0 ? 0 : ((double) quantiteDiesel / capaciteDiesel) * 100;
    }
    
    
}
