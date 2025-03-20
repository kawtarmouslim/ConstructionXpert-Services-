package model;

import java.util.List;

public class Tache {
    private  int idTache;
    private String nomTache;
    private String description;
    private  int idProjet;
    private String nomProjet;
    private String dateDebut;
    private String dateFin;
    private List<Ressource>ressources;

    public Tache() {
    }


    public Tache(String nomTache, String description, int idProjet,  String dateDebut, String dateFin) {
        this.nomTache = nomTache;
        this.description = description;
        this.idProjet = idProjet;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    public int getIdTache() {
        return idTache;
    }

    public void setIdTache(int idTache) {
        this.idTache = idTache;
    }

    public String getNomTache() {
        return nomTache;
    }

    public void setNomTache(String nomTache) {
        this.nomTache = nomTache;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getIdProjet() {
        return idProjet;
    }

    public void setIdProjet(int idProjet) {
        this.idProjet = idProjet;
    }

    public String getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(String dateDebut) {
        this.dateDebut = dateDebut;
    }

    public String getDateFin() {
        return dateFin;
    }

    public void setDateFin(String dateFin) {
        this.dateFin = dateFin;
    }

    public String getNomProjet() {
        return nomProjet;
    }

    public void setNomProjet(String nomProjet) {
        this.nomProjet = nomProjet;
    }

    public List<Ressource> getRessources() {
        return ressources;
    }

    public void setRessources(List<Ressource> ressources) {
        this.ressources = ressources;
    }
}
