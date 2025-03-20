package model;

public class Ressource {
    private int idRessource;
    private String nomRessource;
    private String  type;
    private String fournisseur;
    private  int quantite;

    public Ressource() {
    }

    public Ressource(String nomRessource, String type, String fournisseur, int quantite) {
        this.nomRessource = nomRessource;
        this.type = type;
        this.fournisseur = fournisseur;
        this.quantite = quantite;
    }
    public Ressource(int idRessource, String nomRessource) {
        this.idRessource = idRessource;
        this.nomRessource = nomRessource;
    }


    public int getIdRessource() {
        return idRessource;
    }

    public void setIdRessource(int idRessource) {
        this.idRessource = idRessource;
    }

    public String getNomRessource() {
        return nomRessource;
    }

    public void setNomRessource(String nomRessource) {
        this.nomRessource = nomRessource;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }
}
