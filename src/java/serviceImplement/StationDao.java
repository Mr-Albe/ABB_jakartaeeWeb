package serviceImplement;

import dbUtils.DBConnection;
import java.util.List;
import model.StationModel;
import services.IdaO;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Albe
 */
public class StationDao implements IdaO<StationModel> {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    StationModel stModel = null;

    @Override
    public boolean ajouter(StationModel obj) throws ClassNotFoundException, SQLException {
        // Definir les colonnes explicitement 
        String sql = "INSERT INTO STATION (numero, rue, commune, quantite_gazoline, quantite_diesel, capacite_gazoline, capacite_diesel) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            // On ne met pas l'id est AUTO_INCREMENT
            ps.setString(1, obj.getNumero());
            ps.setString(2, obj.getRue());
            ps.setString(3, obj.getCommune());
            ps.setInt(4, obj.getQuantiteGazoline());
            ps.setInt(5, obj.getQuantiteDiesel());
            ps.setInt(6, obj.getCapaciteGazoline());
            ps.setInt(7, obj.getCapaciteDiesel());
            // Executer l'insertion et retourner true si au moins une ligne a été insérée
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean modifier(StationModel station) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE station SET numero=?, rue=?, commune=?, capacite_gazoline=?, quantite_gazoline=?, capacite_diesel=?, quantite_diesel=? WHERE id=?";
        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(sql)) {
            pds.setString(1, station.getNumero());
            pds.setString(2, station.getRue());
            pds.setString(3, station.getCommune());
            pds.setInt(4, station.getCapaciteGazoline());
            pds.setInt(5, station.getQuantiteGazoline());
            pds.setInt(6, station.getCapaciteDiesel());
            pds.setInt(7, station.getQuantiteDiesel());
            pds.setInt(8, station.getId());
            return pds.executeUpdate() > 0;
        }
    }

    @Override
    public boolean supprimer(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM STATION WHERE id = ?";
        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(sql)) {
            pds.setInt(1, id);
            return pds.executeUpdate()>0;
        }
    }

    /**
     *
     * @param id
     * @return
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    @Override
    public StationModel rechercherParId(int id) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM station WHERE id = ?";
        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(sql)) {
            pds.setInt(1, id);
            try (ResultSet rss = pds.executeQuery()) {
                if (rss.next()) {
                    stModel = new StationModel();
                    stModel.setId(rss.getInt("id"));
                    stModel.setNumero(rss.getString("numero"));
                    stModel.setRue(rss.getString("rue"));
                    stModel.setCommune(rss.getString("commune"));
                    stModel.setCapaciteGazoline(rss.getInt("capacite_gazoline"));
                    stModel.setQuantiteGazoline(rss.getInt("quantite_gazoline"));
                    stModel.setCapaciteDiesel(rss.getInt("capacite_diesel"));
                    stModel.setQuantiteDiesel(rss.getInt("quantite_diesel"));
                }
            }
        }

        return stModel;
    }

    @Override
    public List<StationModel> afficherTout() throws ClassNotFoundException, SQLException {
        // creation d'une liste generique de station model
        List<StationModel> listStation = new ArrayList<>();
        // reccuper la connection
        conn = DBConnection.getConnection();
        // la requete sql pour recuperer les donnees
        String requete = "SELECT * FROM STATION";
        ps = conn.prepareStatement(requete);
        // executer la requete
        rs = ps.executeQuery();

        //parcourir ResultSet
        while (rs.next()) {
            stModel = new StationModel();
            //numero, rue, commune, quantite_gazoline, quantite_diesel, capacite_gazoline, capacite_diesel
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
        rs.clearWarnings();
        ps.close();
        conn.close();
        return listStation;

    }

    public int getCapaciteParStationIdType(int stationId, String typeCarburant) throws SQLException, ClassNotFoundException {
        String sql = "SELECT capacite_gazoline, capacite_diesel FROM station WHERE id = ?";

        try (Connection connect = DBConnection.getConnection(); PreparedStatement pdS = connect.prepareStatement(sql)) {
            pdS.setInt(1, stationId);
            try (ResultSet rs = pdS.executeQuery()) {
                if (rs.next()) {
                    if ("gazoline".equalsIgnoreCase(typeCarburant)) {
                        return rs.getInt("capacite_gazoline");
                    } else if ("diesel".equalsIgnoreCase(typeCarburant)) {
                        return rs.getInt("capacite_diesel");
                    } else {
                        throw new IllegalArgumentException("Type de carburant invalide : " + typeCarburant);
                    }
                } else {
                    throw new SQLException("Station introuvable avec ID : " + stationId);
                }
            }
        }
    }

    public int getquantiteParStationIdType(int stationId, String typeCarburant) throws SQLException, ClassNotFoundException {
        String sql = "SELECT quantite_gazoline, quantite_diesel FROM station WHERE id = ?";

        try (Connection connect = DBConnection.getConnection(); PreparedStatement pdS = connect.prepareStatement(sql)) {
            pdS.setInt(1, stationId);
            try (ResultSet rs = pdS.executeQuery()) {
                if (rs.next()) {
                    if ("gazoline".equalsIgnoreCase(typeCarburant)) {
                        return rs.getInt("quantite_gazoline");
                    } else if ("diesel".equalsIgnoreCase(typeCarburant)) {
                        return rs.getInt("quantite_diesel");
                    } else {
                        throw new IllegalArgumentException("Type de carburant invalide : " + typeCarburant);
                    }
                } else {
                    throw new SQLException("Station introuvable avec ID : " + stationId);
                }
            }
        }
    }

    public int retirerQuantite(int id, String type, int quantite) throws SQLException, ClassNotFoundException {
        String sqlUpdate = null;
        if (type.equalsIgnoreCase("gazoline")) {
            sqlUpdate = "UPDATE STATION SET quantite_gazoline = quantite_gazoline - ? WHERE id = ? AND quantite_gazoline >= ?";
        } else if (type.equalsIgnoreCase("diesel")) {
            sqlUpdate = "UPDATE STATION SET quantite_diesel = quantite_diesel - ? WHERE id = ? AND quantite_diesel >= ?";
        } else {
            throw new IllegalArgumentException("Type de carburant invalide : " + type);
        }

        try (Connection connect = DBConnection.getConnection(); PreparedStatement pdS = connect.prepareStatement(sqlUpdate)) {

            pdS.setInt(1, quantite);
            pdS.setInt(2, id);
            pdS.setInt(3, quantite);

            int rowsAffected = pdS.executeUpdate();

            if (rowsAffected == 0) {
                // Aucun carburant retire => station non trouvee ou quantite insuffisante
                throw new IllegalStateException("Impossible de retirer " + quantite + " gallons de " + type
                        + " (station introuvable ou quantité insuffisante).");
            }

            return rowsAffected;
        }
    }

    public void ajouterQuantite(int stationId, String type, int quantite) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnection.getConnection();
        String sql = "";
        if (type.equalsIgnoreCase("diesel")) {
            sql = "UPDATE Station SET quantite_diesel = quantite_diesel + ? WHERE id = ?";
        } else if (type.equalsIgnoreCase("gazoline")) {
            sql = "UPDATE Station SET quantite_gazoline = quantite_gazoline + ? WHERE id = ?";
        } else {
            throw new IllegalArgumentException("Type de carburant invalide : " + type);
        }
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, quantite);
            pstmt.setInt(2, stationId);
            pstmt.executeUpdate();
        }
    }

    public boolean modifierQuantiteAvecChangementType(int stationId,
        String ancienType,
        String nouveauType,
        int quantite) throws SQLException, ClassNotFoundException {
        String sql1 = null;
        String sql2 = null;

        if (ancienType.equalsIgnoreCase("gazoline") && nouveauType.equalsIgnoreCase("diesel")) {
            sql1 = "UPDATE Station SET quantite_gazoline = quantite_gazoline + ? WHERE id = ?";
            sql2 = "UPDATE Station SET quantite_diesel = quantite_diesel - ? WHERE id = ?";
        } else if (ancienType.equalsIgnoreCase("diesel") && nouveauType.equalsIgnoreCase("gazoline")) {
            sql1 = "UPDATE Station SET quantite_diesel = quantite_diesel + ? WHERE id = ?";
            sql2 = "UPDATE Station SET quantite_gazoline = quantite_gazoline - ? WHERE id = ?";
        } else {
            // Si le type de carburant n’a pas changé
            sql1 = "UPDATE Station SET quantite_" + ancienType.toLowerCase() + " = quantite_" + ancienType.toLowerCase() + " + ? WHERE id = ?";
            sql2 = null;
        }

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Pour garantir la transaction complète

            try (PreparedStatement stmt1 = conn.prepareStatement(sql1)) {
                stmt1.setInt(1, quantite);
                stmt1.setInt(2, stationId);
                stmt1.executeUpdate();
            }

            if (sql2 != null) {
                try (PreparedStatement stmt2 = conn.prepareStatement(sql2)) {
                    stmt2.setInt(1, quantite);
                    stmt2.setInt(2, stationId);
                    stmt2.executeUpdate();
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
