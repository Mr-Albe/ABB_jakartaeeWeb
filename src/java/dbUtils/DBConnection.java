package dbUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        // Charger le driver JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Paramètres de connexion
        String url = "jdbc:mysql://localhost:3306/stationDB";
        String user = "root";
        String password = "";

        // Établir la connexion
        return DriverManager.getConnection(url, user, password);
    }
}
