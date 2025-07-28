package serviceImplement;

import dbUtils.DBConnection;
import java.util.List;
import model.StationModel;
import services.IdaO;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StationDao implements IdaO<StationModel> {

    private static final Logger logger = Logger.getLogger(StationDao.class.getName());

    // Méthode utilitaire pour fermer les ressources
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Erreur lors de la fermeture du ResultSet", e);
        }

        try {
            if (ps != null && !ps.isClosed()) {
                ps.close();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Erreur lors de la fermeture du PreparedStatement", e);
        }

        try {
            if (conn != null && !conn.isClosed()) {
                // Si vous utilisez un pool de connexions, cette méthode la retourne au pool
                conn.close();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Erreur lors de la fermeture de la Connection", e);
        }
    }

    @Override
    public boolean ajouter(StationModel obj) throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO STATION (numero, rue, commune, quantite_gazoline, quantite_diesel, capacite_gazoline, capacite_diesel) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, obj.getNumero());
            ps.setString(2, obj.getRue());
            ps.setString(3, obj.getCommune());
            ps.setInt(4, obj.getQuantiteGazoline());
            ps.setInt(5, obj.getQuantiteDiesel());
            ps.setInt(6, obj.getCapaciteGazoline());
            ps.setInt(7, obj.getCapaciteDiesel());

            return ps.executeUpdate() > 0;
        } finally {
            closeResources(conn, ps, null);
        }
    }

    @Override
    public boolean modifier(StationModel station) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE station SET numero=?, rue=?, commune=?, capacite_gazoline=?, "
                + "quantite_gazoline=?, capacite_diesel=?, quantite_diesel=? WHERE id=?";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, station.getNumero());
            ps.setString(2, station.getRue());
            ps.setString(3, station.getCommune());
            ps.setInt(4, station.getCapaciteGazoline());
            ps.setInt(5, station.getQuantiteGazoline());
            ps.setInt(6, station.getCapaciteDiesel());
            ps.setInt(7, station.getQuantiteDiesel());
            ps.setInt(8, station.getId());

            return ps.executeUpdate() > 0;
        } finally {
            closeResources(conn, ps, null);
        }
    }

    @Override
    public boolean supprimer(int id) throws SQLException, ClassNotFoundException, SQLIntegrityConstraintViolationException {
        String sql = "DELETE FROM STATION WHERE id = ?";
        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(sql)) {
            pds.setInt(1, id);
            return pds.executeUpdate() > 0;
        }
    }

    @Override
    public StationModel rechercherParId(int id) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM station WHERE id = ?";
        StationModel stModel = null;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                stModel = new StationModel();
                stModel.setId(rs.getInt("id"));
                stModel.setNumero(rs.getString("numero"));
                stModel.setRue(rs.getString("rue"));
                stModel.setCommune(rs.getString("commune"));
                stModel.setCapaciteGazoline(rs.getInt("capacite_gazoline"));
                stModel.setQuantiteGazoline(rs.getInt("quantite_gazoline"));
                stModel.setCapaciteDiesel(rs.getInt("capacite_diesel"));
                stModel.setQuantiteDiesel(rs.getInt("quantite_diesel"));
            }
        } finally {
            closeResources(conn, ps, rs);
        }

        return stModel;
    }

    public StationModel rechercherParNumero(String numero) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM station WHERE numero = ?";
        StationModel stModel = null;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, numero);
            rs = ps.executeQuery();

            if (rs.next()) {
                stModel = new StationModel();
                stModel.setId(rs.getInt("id"));
                stModel.setNumero(rs.getString("numero"));
                stModel.setRue(rs.getString("rue"));
                stModel.setCommune(rs.getString("commune"));
                stModel.setCapaciteGazoline(rs.getInt("capacite_gazoline"));
                stModel.setQuantiteGazoline(rs.getInt("quantite_gazoline"));
                stModel.setCapaciteDiesel(rs.getInt("capacite_diesel"));
                stModel.setQuantiteDiesel(rs.getInt("quantite_diesel"));
            }
        } finally {
            closeResources(conn, ps, rs);
        }

        return stModel;
    }

    @Override
    public List<StationModel> afficherTout() throws ClassNotFoundException, SQLException {
        List<StationModel> listStation = new ArrayList<>();
        String requete = "SELECT * FROM STATION";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(requete);
            rs = ps.executeQuery();

            while (rs.next()) {
                StationModel stModel = new StationModel();
                stModel.setId(rs.getInt("id"));
                stModel.setNumero(rs.getString("numero"));
                stModel.setRue(rs.getString("rue"));
                stModel.setCommune(rs.getString("commune"));
                stModel.setCapaciteGazoline(rs.getInt("capacite_gazoline"));
                stModel.setQuantiteGazoline(rs.getInt("quantite_gazoline"));
                stModel.setCapaciteDiesel(rs.getInt("capacite_diesel"));
                stModel.setQuantiteDiesel(rs.getInt("quantite_diesel"));
                listStation.add(stModel);
            }
        } finally {
            closeResources(conn, ps, rs);
        }

        return listStation;
    }

    public int getCapaciteParStationIdType(String num_station, String typeCarburant) throws SQLException, ClassNotFoundException {
        String sql = "SELECT capacite_gazoline, capacite_diesel FROM station WHERE numero = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, num_station);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                if ("gazoline".equalsIgnoreCase(typeCarburant)) {
                    return rs.getInt("capacite_gazoline");
                } else if ("diesel".equalsIgnoreCase(typeCarburant)) {
                    return rs.getInt("capacite_diesel");
                } else {
                    throw new IllegalArgumentException("Type de carburant invalide : " + typeCarburant);
                }
            } else {
                throw new SQLException("Station introuvable avec NUMERO : " + num_station);
            }
        }
    }

    public int getquantiteParNumStationType(String numStation, String typeCarburant) throws SQLException, ClassNotFoundException {
        String sqlSelect = "SELECT quantite_gazoline, quantite_diesel FROM station WHERE numero = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement psd = conn.prepareStatement(sqlSelect)) {
           
            psd.setString(1, numStation);
            ResultSet rs = psd.executeQuery();

            if (rs.next()) {
                if ("gazoline".equalsIgnoreCase(typeCarburant)) {
                    return rs.getInt("quantite_gazoline");
                } else if ("diesel".equalsIgnoreCase(typeCarburant)) {
                    return rs.getInt("quantite_diesel");
                } else {
                    throw new IllegalArgumentException("Type de carburant invalide : " + typeCarburant);
                }
            } else {
                throw new SQLException("Station introuvable avec ID : " + numStation);
            }
        }
    }

    public int retirerQuantite(String numStation, String type, int quantite) throws SQLException, ClassNotFoundException {
        String sqlUpdate = null;
        if (type.equalsIgnoreCase("gazoline")) {
            sqlUpdate = "UPDATE STATION SET quantite_gazoline = quantite_gazoline - ? WHERE numero = ? AND quantite_gazoline >= ?";
        } else if (type.equalsIgnoreCase("diesel")) {
            sqlUpdate = "UPDATE STATION SET quantite_diesel = quantite_diesel - ? WHERE numero = ? AND quantite_diesel >= ?";
        } else {
            throw new IllegalArgumentException("Type de carburant invalide : " + type);
        }

        try (Connection conn = DBConnection.getConnection(); PreparedStatement psd = conn.prepareStatement(sqlUpdate)) {
          
            psd.setInt(1, quantite);
            psd.setString(2, numStation);
            psd.setInt(3, quantite);
             
            return psd.executeUpdate();
        }
    }
}
