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
                    "fournisseur VARCHAR(100) NOT NULL" +
                    ")";
            statement.executeUpdate(createRessourceTable);
            System.out.println("Table 'ressource' créée avec succès (si elle n'existait pas).");

            // Création de la table 'quantite_ressource'
            String createQuantiteTable = "CREATE TABLE IF NOT EXISTS quantite_ressource (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "idRessource INT, " +
                    "quantite INT, " +
                    "FOREIGN KEY (idRessource) REFERENCES ressource(idRessource) ON DELETE CASCADE" +
                    ")";

            statement.executeUpdate(createQuantiteTable);
            System.out.println("Table 'quantite_ressource' créée avec succès (si elle n'existait pas).");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public void insertRessource(Ressource ressource) {
        String sql = "INSERT INTO ressource (nom, type, fournisseur) VALUES (?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, ressource.getNomRessource());
            statement.setString(2, ressource.getType());
            statement.setString(3, ressource.getFournisseur());
            statement.executeUpdate();

            // Vérification de l'ID généré
            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()) {
                int ressourceId = rs.getInt(1);
                System.out.println("Ressource insérée avec ID : " + ressourceId);

                // Insérer la quantité dans la table quantite_ressource
                insertQuantiteRessource(ressourceId, ressource.getQuantite());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de l'insertion de la ressource", e);
        }
    }



    public void insertQuantiteRessource(int idRessource, int quantite) {
        String sql = "INSERT INTO quantite_ressource (idRessource, quantite) VALUES (?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            System.out.println("Insert quantite ressource");
            statement.setInt(1, idRessource);
            statement.setInt(2, quantite);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
                ressources.add(ressource);

            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return ressources;
    }
}