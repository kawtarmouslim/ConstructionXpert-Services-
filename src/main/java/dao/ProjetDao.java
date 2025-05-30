package dao;

import model.Projet;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjetDao {
    Connection connection;

    public ProjetDao() {
        connection = DatabaseConfig.getConnection();
        try {
            Statement statement = connection.createStatement();
            String createProjetTable = "CREATE TABLE IF NOT EXISTS projet (" +
                    "idProjet INT AUTO_INCREMENT PRIMARY KEY," +
                    "nomProjet VARCHAR(100) NOT NULL, " +
                    "description VARCHAR(100) NOT NULL, " +
                    "dateDebut DATE NOT NULL, " +
                    "datefin DATE NOT NULL, " +
                    "budjet FLOAT NOT NULL " +
                    ")";

            statement.executeUpdate(createProjetTable);
            System.out.println("Table 'projet' créée avec succès (si elle n'existait pas).");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertProjet(Projet projet) {
        String insertUserQuery = "INSERT INTO projet (nomProjet, description, dateDebut, datefin, budjet) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertUserQuery)) {
            preparedStatement.setString(1, projet.getNomProjet());
            preparedStatement.setString(2, projet.getDescription());
            preparedStatement.setString(3, projet.getDateDebut());
            preparedStatement.setString(4, projet.getDateFin());
            preparedStatement.setFloat(5, projet.getBudget());
            preparedStatement.executeUpdate();
            System.out.println("salam");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    public Projet getProjet(int idProjet) {
        Projet projet = null;
        String select = "SELECT * FROM projet WHERE idProjet = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(select)) {
            preparedStatement.setInt(1, idProjet);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                projet = new Projet();
                resultSet.getString("nomProjet");
                resultSet.getString("description");
                resultSet.getString("dateDebut");
                resultSet.getString("datefin");
                resultSet.getFloat("budjet");


            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return projet;
    }

    public List<Projet> getAllProjets() {
        List<Projet> projets = new ArrayList<Projet>();
        String select = "SELECT * FROM projet";
        try (PreparedStatement preparedStatement = connection.prepareStatement(select)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            System.out.println("ssss");
            while (resultSet.next()) {
                Projet projet = new Projet();
                projet.setIdProjet(resultSet.getInt("idProjet"));
                projet.setNomProjet(resultSet.getString("nomProjet"));
                projet.setDescription(resultSet.getString("description"));
                projet.setDateDebut(resultSet.getString("dateDebut"));
                projet.setDateFin(resultSet.getString("dateFin"));
                projet.setBudget(resultSet.getFloat("budjet"));
                projets.add(projet);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return projets;
    }


    public void deleteProjet(int idProjet) {
        String delete = "DELETE FROM projet WHERE idProjet = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(delete)) {
            preparedStatement.setInt(1, idProjet);
            preparedStatement.executeUpdate();
            System.out.println("deleted");


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public void updateProjet(Projet projet) throws SQLException {
        String sql = "UPDATE projet SET nomProjet=?, description=?, dateDebut=?, datefin=?, budjet=? WHERE idProjet=?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            System.out.println("update projet dao");
            preparedStatement.setString(1, projet.getNomProjet());
            preparedStatement.setString(2, projet.getDescription());
            preparedStatement.setString(3, projet.getDateDebut());
            preparedStatement.setString(4, projet.getDateFin());
            preparedStatement.setFloat(5, projet.getBudget());
            preparedStatement.setInt(6,projet.getIdProjet());
            preparedStatement.executeUpdate();
        }
    }

}
