package dao;

import model.Ressource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RessourceDao {
    Connection connection;

    public RessourceDao() {
        connection = DatabaseConfig.getConnection();
        try {
            Statement statement = connection.createStatement();

            // Création de la table 'ressource'
            String createRessourceTable = "CREATE TABLE IF NOT EXISTS ressource (" +
                    "idRessource INT AUTO_INCREMENT PRIMARY KEY," +
                    "nom VARCHAR(100) NOT NULL, " +
                    "type VARCHAR(100) NOT NULL," +
                    "fournisseur VARCHAR(100) NOT NULL," +
                    "quantite INT NOT NULL" +
                    ")";
            statement.executeUpdate(createRessourceTable);
            System.out.println("Table 'ressource' créée avec succès (si elle n'existait pas).");
            String createRessourceTacheTable = "CREATE TABLE IF NOT EXISTS ressource_tache (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "idTache INT NOT NULL, " +
                    "idRessource INT NOT NULL, " +
                    "quantite INT NOT NULL, " +
                    "FOREIGN KEY (idTache) REFERENCES tache(idTache) ON DELETE CASCADE, " +
                    "FOREIGN KEY (idRessource) REFERENCES ressource(idRessource) ON DELETE CASCADE" +
                    ")";
            statement.executeUpdate(createRessourceTacheTable);
            System.out.println("Table 'ressource_tache' créée avec succès (si elle n'existait pas).");
//            // Création de la table 'quantite_ressource'
//            String createQuantiteTable = "CREATE TABLE IF NOT EXISTS quantite_ressource (" +
//                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
//                    "idRessource INT, " +
//                    "idTache INT, " +
//                    "quantite INT, " +
//                    "FOREIGN KEY (idRessource) REFERENCES ressource(idRessource) ON DELETE CASCADE," +
//                    "FOREIGN KEY (idTache) REFERENCES tache(idTache) ON DELETE CASCADE" +
//
//                    ")";
//
//            statement.executeUpdate(createQuantiteTable);
//            System.out.println("Table 'quantite_ressource' créée avec succès (si elle n'existait pas).");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public void insertRessource(Ressource ressource) {
        String sql = "INSERT INTO ressource (nom, type, fournisseur,quantite) VALUES (?, ?, ?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, ressource.getNomRessource());
            statement.setString(2, ressource.getType());
            statement.setString(3, ressource.getFournisseur());
            statement.setInt(4,ressource.getQuantite());
            statement.executeUpdate();


        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'insertion de la ressource", e);
        }
    }
    // In RessourceDao.java
    public void assignRessourceToTache(int idTache, int idRessource, int quantite) {
        String insertSql = "INSERT INTO ressource_tache (idTache, idRessource, quantite) VALUES (?, ?, ?)";
        String updateSql = "UPDATE ressource SET quantite = quantite - ? WHERE idRessource = ?";

        try {
            connection.setAutoCommit(false); // Start transaction

            // Insert into ressource_tache
            try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                insertStmt.setInt(1, idTache);
                insertStmt.setInt(2, idRessource);
                insertStmt.setInt(3, quantite);
                insertStmt.executeUpdate();
            }

            // Update ressource quantity
            try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                updateStmt.setInt(1, quantite);
                updateStmt.setInt(2, idRessource);
                updateStmt.executeUpdate();
            }

            connection.commit(); // Commit transaction
        } catch (SQLException e) {
            try {
                connection.rollback(); // Rollback on error
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'assignation de la ressource à la tâche", e);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Optional: Method to get resources assigned to a task
    public List<Ressource> getRessourcesByTacheId(int idTache) {
        List<Ressource> ressources = new ArrayList<>();
        String sql = "SELECT r.*, rt.quantite AS assigned_quantite " +
                "FROM ressource r " +
                "JOIN ressource_tache rt ON r.idRessource = rt.idRessource " +
                "WHERE rt.idTache = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idTache);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Ressource ressource = new Ressource();
                ressource.setIdRessource(rs.getInt("idRessource"));
                ressource.setNomRessource(rs.getString("nom"));
                ressource.setType(rs.getString("type"));
                ressource.setFournisseur(rs.getString("fournisseur"));
                ressource.setQuantite(rs.getInt("quantite")); // Remaining quantity
                ressources.add(ressource);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la récupération des ressources", e);
        }
        return ressources;
    }




    public List<Ressource> getAllRessource() {
        List<Ressource> ressources = new ArrayList<Ressource>();
        String sql = "SELECT * FROM ressource";
        try(PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Ressource ressource=new Ressource();
                ressource.setIdRessource(rs.getInt("idRessource"));
                ressource.setNomRessource(rs.getString("nom"));
                ressource.setType(rs.getString("type"));
                ressource.setFournisseur(rs.getString("fournisseur"));
                ressource.setQuantite(rs.getInt("quantite"));
                ressources.add(ressource);

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ressources;
    }
}