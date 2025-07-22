
package serviceImplement;


import java.sql.*;
import java.sql.Date;
import java.util.*;
import services.IdaO;
import model.VenteModel;
import dao.DBConnection;


/**
 * Gère les opérations CRUD sur les ventes.
 */
public class VenteDao implements IdaO<VenteModel> {

    @Override
    public boolean ajouter(VenteModel vente) throws ClassNotFoundException, SQLException {
        String sqlInsert = "INSERT INTO vente(id_station, type_carburant, quantite, prix_unitaire, date_vente, revenu) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement pdS = conn.prepareStatement(sqlInsert)) {
            pdS.setInt(1, vente.getStationId());
            pdS.setString(2, vente.getTypeCarburant());
            pdS.setInt(3, vente.getQuantite());
            pdS.setDouble(4, vente.getPrixUnitaire());
            Date dateVente = Date.valueOf(vente.getDateVente());
            pdS.setDate(5, dateVente);
            pdS.setDouble(6, vente.getRevenu());
            return pdS.executeUpdate() > 0;
        }
    }

    @Override
    public boolean modifier(VenteModel vente) throws ClassNotFoundException, SQLException {
        String sqlUpdate = "UPDATE vente SET id_station=?, type_carburant=?, quantite=?, prix_unitaire=?, date_vente=?, revenu=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement pdS = conn.prepareStatement(sqlUpdate)) {
            pdS.setInt(1, vente.getStationId());
            pdS.setString(2, vente.getTypeCarburant());
            pdS.setInt(3, vente.getQuantite());
            pdS.setDouble(4, vente.getPrixUnitaire());
            Date dateVente = Date.valueOf(vente.getDateVente());
            pdS.setDate(5, dateVente);
            pdS.setDate(5, dateVente);
            pdS.setDouble(6, vente.getRevenu());
            pdS.setInt(7, vente.getId());

            return pdS.executeUpdate() > 0;
        }
    }

    @Override
    public boolean supprimer(int id) throws ClassNotFoundException, SQLException {
        String sqlDelete = "DELETE FROM vente WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement pdS = conn.prepareStatement(sqlDelete)) {
            pdS.setInt(1, id);
            return pdS.executeUpdate() > 0;
        }
    }

    @Override
    public VenteModel rechercherParId(int id) throws ClassNotFoundException, SQLException {
        String sqlSelect = "SELECT * FROM vente WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement PdS = conn.prepareStatement(sqlSelect)) {
            PdS.setInt(1, id);
            try (ResultSet rs = PdS.executeQuery()) {
                if (rs.next()) {
                    VenteModel vente = new VenteModel();
                    vente.setId(rs.getInt("id"));
                    vente.setStationId(rs.getInt("stationId"));
                    vente.setTypeCarburant(rs.getString("typeCarburant"));
                    vente.setQuantite(rs.getInt("quantite"));
                    vente.setPrixUnitaire(rs.getDouble("prixUnitaire"));
                    vente.setDateVente(rs.getDate("dateVente").toLocalDate());
                    return vente;
                }
                return null;
            }
        }
    }

    @Override
    public List<VenteModel> afficherTout() throws ClassNotFoundException, SQLException {
        List<VenteModel> liste = new ArrayList<>();
        String sqlSelect = "SELECT * FROM vente";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pdS = conn.prepareStatement(sqlSelect);
             ResultSet rs = pdS.executeQuery()) {
            while (rs.next()) {
                VenteModel vente = new VenteModel();
                vente.setId(rs.getInt("id"));
                vente.setStationId(rs.getInt("stationId"));
                vente.setTypeCarburant(rs.getString("typeCarburant"));
                vente.setQuantite(rs.getInt("quantite"));
                vente.setPrixUnitaire(rs.getDouble("prixUnitaire"));
                vente.setDateVente(rs.getDate("dateVente").toLocalDate());
                vente.setPrixUnitaire(rs.getDouble("prixUnitaire"));
                liste.add(vente);
            }
        }
        return liste;
    }
}
