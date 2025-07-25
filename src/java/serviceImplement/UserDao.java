/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package serviceImplement;

import dbUtils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.UserModel;
import services.IdaO;

/**
 *
 * @author bendy
 */
public class UserDao implements IdaO<UserModel> {

    Connection conn;
    PreparedStatement ps = null;
    ResultSet rs = null;
    UserModel userModel;

    @Override
    public boolean ajouter(UserModel obj) throws ClassNotFoundException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean modifier(UserModel obj) throws ClassNotFoundException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean supprimer(int id) throws ClassNotFoundException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public UserModel rechercherParId(int id) throws ClassNotFoundException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<UserModel> afficherTout() throws ClassNotFoundException, SQLException {
        //Creer une liste de UserModel
        List<UserModel> users = new ArrayList<>();

        //Etablir la connection
        conn = DBConnection.getConnection();

        //Recuperer les donnees
        String query = "SELECT * FROM users";
        ps = conn.prepareStatement(query);
        rs = ps.executeQuery();

        //Maintenant ajouter les users dans la liste
        while (rs.next()) {
            userModel = new UserModel();
            userModel.setId(rs.getInt("id"));
            userModel.setUsername(rs.getString("username"));
            userModel.setPassword(rs.getString("password"));
            userModel.setRole(rs.getString("role"));
            users.add(userModel);
        }
        rs.clearWarnings();
        ps.close();
        conn.close();
        return users;
    }

    public UserModel rechercherParUsernameEtPassword(String username, String password) throws ClassNotFoundException, SQLException {
        conn = DBConnection.getConnection();
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        rs = ps.executeQuery();

        if (rs.next()) {
            userModel = new UserModel();
            userModel.setId(rs.getInt("id"));
            userModel.setUsername(rs.getString("username"));
            userModel.setPassword(rs.getString("password"));
            userModel.setRole(rs.getString("role"));
            return userModel;
        }

        return null;
    }
}
