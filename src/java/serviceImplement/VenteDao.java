package serviceImplement;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import services.IdaO;
import model.VenteModel;
import dbUtils.DBConnection;

public class VenteDao implements IdaO<VenteModel> {

    @Override
    public boolean ajouter(VenteModel vente) throws ClassNotFoundException, SQLException {
        String sqlInsert = "INSERT INTO vente(num_station, type_carburant, quantite, prix_vente, date_vente, revenu) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement pdS = conn.prepareStatement(sqlInsert)) {
            pdS.setString(1, vente.getNumStation());
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
        return true;
    }

    @Override
    public boolean supprimer(int id) throws ClassNotFoundException, SQLException {
        return true;
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
                    vente.setNumStation(rs.getString("num_station"));
                    vente.setTypeCarburant(rs.getString("type_carburant"));
                    vente.setQuantite(rs.getInt("quantite"));
                    vente.setPrixUnitaire(rs.getDouble("prix_vente"));
                    vente.setDateVente(rs.getDate("date_vente").toLocalDate());
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
                vente.setNumStation(rs.getString("num_station"));
                vente.setTypeCarburant(rs.getString("type_carburant"));
                vente.setQuantite(rs.getInt("quantite"));
                vente.setPrixUnitaire(rs.getDouble("prix_vente"));
                vente.setDateVente(rs.getDate("date_vente").toLocalDate());
                liste.add(vente);
            }
        }
        return liste;
    }
}
