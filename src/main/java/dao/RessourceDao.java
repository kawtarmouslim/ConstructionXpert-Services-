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
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertRessource(Ressource ressource) {
        String sql = "INSERT INTO ressource (nom, type, fournisseur, quantite) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, ressource.getNomRessource());
            statement.setString(2, ressource.getType());
            statement.setString(3, ressource.getFournisseur());
            statement.setInt(4, ressource.getQuantite());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'insertion de la ressource", e);
        }
    }

    public void updateRessource(Ressource ressource) {
        String sql = "UPDATE ressource SET nom = ?, type = ?, fournisseur = ?, quantite = ? WHERE idRessource = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, ressource.getNomRessource());
            preparedStatement.setString(2, ressource.getType());
            preparedStatement.setString(3, ressource.getFournisseur());
            preparedStatement.setInt(4, ressource.getQuantite());
            preparedStatement.setInt(5, ressource.getIdRessource());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la mise à jour de la ressource", e);
        }
    }

    public List<Ressource> getAllRessource() {
        List<Ressource> ressources = new ArrayList<>();
        String sql = "SELECT * FROM ressource";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Ressource ressource = new Ressource();
                ressource.setIdRessource(rs.getInt("idRessource"));
                ressource.setNomRessource(rs.getString("nom"));
                ressource.setType(rs.getString("type"));
                ressource.setFournisseur(rs.getString("fournisseur"));
                ressource.setQuantite(rs.getInt("quantite"));
                ressources.add(ressource);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la récupération des ressources", e);
        }
        return ressources;
    }

    public void assignRessourceToTache(int idTache, int idRessource, int quantite) {
        String insertSql = "INSERT INTO ressource_tache (idTache, idRessource, quantite) VALUES (?, ?, ?)";
        String updateSql = "UPDATE ressource SET quantite = quantite - ? WHERE idRessource = ?";

        try (PreparedStatement insertStmt = connection.prepareStatement(insertSql);
             PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {

            insertStmt.setInt(1, idTache);
            insertStmt.setInt(2, idRessource);
            insertStmt.setInt(3, quantite);
            insertStmt.executeUpdate();

            updateStmt.setInt(1, quantite);
            updateStmt.setInt(2, idRessource);
            updateStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'assignation de la ressource à la tâche", e);
        }
    }

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
                ressource.setQuantite(rs.getInt("quantite"));
                ressources.add(ressource);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la récupération des ressources", e);
        }
        return ressources;
    }
    public void deleteRessource(int idRessource) {
        String sql = "DELETE FROM ressource WHERE idRessource = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idRessource);
            stmt.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}