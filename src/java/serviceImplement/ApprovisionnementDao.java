package serviceImplement;

import dbUtils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ApprovisionnementModel;
import services.IdaO;

public class ApprovisionnementDao implements IdaO<ApprovisionnementModel> {

    ResultSet rs = null;
    ApprovisionnementModel appModel = null;

    @Override
    public boolean ajouter(ApprovisionnementModel app) throws ClassNotFoundException, SQLException {
        //
        String insertSql = "INSERT INTO APPROVISIONNEMENT (id_station,type_carburant,quantite,date_livraison,id_fournisseur)  VALUES(?, ?, ?, ?, ?)";
        String updateSql = "";

        if (app.getTypeCarburant().equalsIgnoreCase("diesel")) {
            updateSql = "UPDATE STATION SET quantite_diesel = quantite_diesel + ? where id = ?";
        } else {
            updateSql = "UPDATE STATION SET quantite_gazoline = quantite_gazoline + ? where id = ?";
        }

        try (Connection connect = DBConnection.getConnection(); PreparedStatement psdInsert = connect.prepareStatement(insertSql); PreparedStatement psdUdate = connect.prepareStatement(updateSql)) {

            connect.setAutoCommit(false);
            psdInsert.setInt(1, app.getStationId());
            psdInsert.setString(2, app.getTypeCarburant());
            psdInsert.setInt(3, (int) app.getQuantite());
            psdInsert.setDate(4, Date.valueOf(app.getDateLivraison()));
            psdInsert.setString(5, app.getFournisseur());
            psdInsert.executeUpdate();

            psdUdate.setInt(1, (int) app.getQuantite());
            psdUdate.setInt(2, app.getStationId());
            psdUdate.executeUpdate();

            connect.commit();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    /**
     * Met à jour les informations d’un approvisionnement existant dans la base
     * de données. Cette méthode modifie à la fois les détails de
     * l'approvisionnement (station, type de carburant, quantité, date,
     * fournisseur) et ajuste automatiquement la quantité de carburant
     * correspondante dans la station (quantité_diesel ou quantité_gazoline).
     *
     * *
     */
    @Override
    public boolean modifier(ApprovisionnementModel app) throws ClassNotFoundException, SQLException {
        String sqlGetOld = "SELECT quantite, type_carburant, id_station FROM APPROVISIONNEMENT WHERE id = ?";
        String sqlUpdateApp = "UPDATE APPROVISIONNEMENT SET id_station =?, type_carburant =?, quantite =?, date_livraison =?, id_fournisseur = ? WHERE id = ?";
        String sqlSubDiesel = "UPDATE STATION SET quantite_diesel = quantite_diesel - ? WHERE id = ?";
        String sqlSubGazo = "UPDATE STATION SET quantite_gazoline = quantite_gazoline - ? WHERE id = ?";
        String sqlAddDiesel = "UPDATE STATION SET quantite_diesel = quantite_diesel + ? WHERE id = ?";
        String sqlAddGazo = "UPDATE STATION SET quantite_gazoline = quantite_gazoline + ? WHERE id = ?";

        try (Connection connect = DBConnection.getConnection()) {
            connect.setAutoCommit(false); // Démarre une transaction

            // 1. Récupérer l'ancienne livraison
            int ancienneQuantite = 0;
            String ancienType = "";
            int ancienStationId = 0;
            try (PreparedStatement psOld = connect.prepareStatement(sqlGetOld)) {
                psOld.setInt(1, app.getId());
                try (ResultSet rs = psOld.executeQuery()) {
                    if (rs.next()) {
                        ancienneQuantite = rs.getInt("quantite");
                        ancienType = rs.getString("type_carburant");
                        ancienStationId = rs.getInt("id_station");
                    }
                }
            }

            // 2. Enlever l'ancienne quantité de la station selon ancien type
            if (ancienType.equalsIgnoreCase("diesel")) {
                try (PreparedStatement ps = connect.prepareStatement(sqlSubDiesel)) {
                    ps.setInt(1, ancienneQuantite);
                    ps.setInt(2, ancienStationId);
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = connect.prepareStatement(sqlSubGazo)) {
                    ps.setInt(1, ancienneQuantite);
                    ps.setInt(2, ancienStationId);
                    ps.executeUpdate();
                }
            }

            // 3. Mettre à jour l'approvisionnement
            try (PreparedStatement ps = connect.prepareStatement(sqlUpdateApp)) {
                ps.setInt(1, app.getStationId());
                ps.setString(2, app.getTypeCarburant());
                ps.setInt(3, app.getQuantite());
                ps.setDate(4, Date.valueOf(app.getDateLivraison()));
                ps.setString(5, app.getFournisseur());
                ps.setInt(6, app.getId());
                ps.executeUpdate();
            }

            // 4. Ajouter la nouvelle quantité à la station selon nouveau type
            if (app.getTypeCarburant().equalsIgnoreCase("diesel")) {
                try (PreparedStatement ps = connect.prepareStatement(sqlAddDiesel)) {
                    ps.setInt(1, app.getQuantite());
                    ps.setInt(2, app.getStationId());
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = connect.prepareStatement(sqlAddGazo)) {
                    ps.setInt(1, app.getQuantite());
                    ps.setInt(2, app.getStationId());
                    ps.executeUpdate();
                }
            }

            connect.commit(); // Tout s’est bien passé
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean supprimer(int id) throws ClassNotFoundException, SQLException {
        //
        String sqlDelete = "DELETE FROM APPROVISIONNEMENT WHERE ID =?";
        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(sqlDelete)) {
            //...
            pds.setInt(1, id);
            pds.executeUpdate();
        }
        return false;
    }

    @Override
    public ApprovisionnementModel rechercherParId(int id) throws ClassNotFoundException, SQLException {
        //...
        String sqlSelect = "SELECT * FROM APPROVISIONNEMENT WHERE ID =?";

        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(sqlSelect)) {
            pds.setInt(1, id);
            appModel = new ApprovisionnementModel();

            try (ResultSet rss = pds.executeQuery()) {
                if (rss.next()) {
                    appModel.setId(rss.getInt("id"));
                    appModel.setStationId(rss.getInt("id_station"));
                    appModel.setTypeCarburant(rss.getString("type_carburant"));
                    appModel.setQuantite(rss.getInt("quantite"));
                    Date appDate = rss.getDate("date_livraison");
                    appModel.setDateLivraison(appDate.toLocalDate());
                    appModel.setFournisseur(rss.getString("fournisseur"));

                }

            } catch (SQLException ex) {
                if (connect != null) {
                    connect.rollback();
                }
            }
            return appModel;
        }
    }
    

    /**
     *
     * @return Une liste d'objet
     * @throws ClassNotFoundException
     * @throws SQLException Methode permetant de recuperer la liste des
     * Approvissionement de la base
     */
    @Override
    public List<ApprovisionnementModel> afficherTout() throws ClassNotFoundException, SQLException {
        String selectSql = "SELECT * FROM APPROVISIONNEMENT";
        List<ApprovisionnementModel> appList = new ArrayList<>();

        try (Connection connect = DBConnection.getConnection(); PreparedStatement pds = connect.prepareStatement(selectSql)) {
            rs = pds.executeQuery();
            while (rs.next()) {
                appModel = new ApprovisionnementModel();
                appModel.setId(rs.getInt("id"));
                appModel.setStationId(rs.getInt("id_station"));
                appModel.setTypeCarburant(rs.getString("type_carburant"));
                appModel.setQuantite(rs.getInt("quantite"));
                Date sqlDate = rs.getDate("date_livraison");
                appModel.setDateLivraison(sqlDate.toLocalDate());
                appModel.setFournisseur(rs.getString("fournisseur"));

                appList.add(appModel);
            }

            return appList;
        }

    }

}
