package dao;

import model.Tache;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TacheDao {
    Connection connection ;
    public TacheDao() {
        connection = DatabaseConfig.getConnection();
        try {
            Statement statement = connection.createStatement();
            String createProjetTable = "CREATE TABLE IF NOT EXISTS tache (" +
                    "idTache INT AUTO_INCREMENT PRIMARY KEY," +
                    "nomtache VARCHAR(100) NOT NULL, " +
                    "description VARCHAR(100) NOT NULL, " +
                    "idProjet INT NOT NULL, " +
                    "dateDebut DATE NOT NULL, " +
                    "datefin DATE NOT NULL, " +
                    "FOREIGN KEY (idProjet) REFERENCES projet(idProjet)" +
                    ")";

            statement.executeUpdate(createProjetTable);
            System.out.println("Table 'tache' créée avec succès (si elle n'existait pas).");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public   void insertTache(Tache tache) {
        String sql="INSERT INTO tache (nomtache,description,idProjet,dateDebut,datefin) VALUES (?,?,?,?,?)";
        try(PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            System.out.println("Insert a new tache");
            preparedStatement.setString(1,tache.getNomTache());
            preparedStatement.setString(2,tache.getDescription());
            preparedStatement.setInt(3,tache.getIdProjet());
            preparedStatement.setString(4,tache.getDateDebut());
            preparedStatement.setString(5,tache.getDateFin());
            preparedStatement.executeUpdate();


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public List<Tache> getAllTaches() {
        List<Tache> taches = new ArrayList<Tache>();
        String sql = "SELECT t.idTache, t.nomTache, t.description, p.nomProjet, t.dateDebut, t.dateFin " +
                "FROM tache t " +
                "LEFT JOIN projet p ON t.idProjet = p.idProjet";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Tache tache = new Tache();
                tache.setIdTache(resultSet.getInt("idTache"));
                tache.setNomTache(resultSet.getString("nomtache"));
                tache.setDescription(resultSet.getString("description"));
                tache.setNomProjet(resultSet.getString("nomProjet"));
                tache.setDateDebut(resultSet.getString("dateDebut"));
                tache.setDateFin(resultSet.getString("dateFin"));
                taches.add(tache);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return taches;
    }

}
