package dao;

import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static dao.DatabaseConfig.getConnection;

public class UserDao {
    public User getUser() {
        User user = null;
        String sql = "SELECT * FROM user WHERE id = 1";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                user = new User( id,username, password);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
