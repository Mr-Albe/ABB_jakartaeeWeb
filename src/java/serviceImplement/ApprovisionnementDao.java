package serviceImplement;

import dbUtils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ApprovisionnementModel;
import services.IdaO;

public class ApprovisionnementDao implements IdaO<ApprovisionnementModel> {

    ApprovisionnementModel appModel = null;

    @Override
    public boolean ajouter(ApprovisionnementModel app) throws ClassNotFoundException, SQLException {
        //
        String insertSql = "INSERT INTO APPROVISIONNEMENT (num_station,type_carburant,quantite,date_livraison,fournisseur)  VALUES(?, ?, ?, ?, ?)";
        String updateSql = "";

        if (app.getTypeCarburant().equalsIgnoreCase("diesel")) {
            updateSql = "UPDATE STATION SET quantite_diesel = quantite_diesel + ? where numero = ?";
        } else {
            updateSql = "UPDATE STATION SET quantite_gazoline = quantite_gazoline + ? where numero = ?";
        }

        try (Connection connect = DBConnection.getConnection(); PreparedStatement psdInsert = connect.prepareStatement(insertSql); PreparedStatement psdUdate = connect.prepareStatement(updateSql)) {

            connect.setAutoCommit(false);
            psdInsert.setString(1, app.getNumStation());
            psdInsert.setString(2, app.getTypeCarburant());
            psdInsert.setInt(3, (int) app.getQuantite());
            psdInsert.setDate(4, Date.valueOf(app.getDateLivraison()));
            psdInsert.setString(5, app.getFournisseur());
            psdInsert.executeUpdate();

            psdUdate.setInt(1, (int) app.getQuantite());
            psdUdate.setString(2, app.getNumStation());
            psdUdate.executeUpdate();

            connect.commit();
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    /**
     * Met à jour les informations d’un approvisionnement existant dans la base
     * de données.Cette méthode modifie à la fois les détails de
     * l'approvisionnement (station, type de carburant, quantité, date,
     * fournisseur) et ajuste automatiquement la quantité de carburant
     * correspondante dans la station (quantité_diesel ou quantité_gazoline).
     *
     *
     * @param app
     */
    @Override
    public boolean modifier(ApprovisionnementModel app) throws ClassNotFoundException, SQLException {
        String sqlGetOld = "SELECT quantite, type_carburant, num_station FROM APPROVISIONNEMENT WHERE id = ?";
        String sqlUpdateApp = "UPDATE APPROVISIONNEMENT SET num_station = ?, type_carburant = ?, quantite = ?, date_livraison = ?, fournisseur = ? WHERE id = ?";
        String sqlSubDiesel = "UPDATE STATION SET quantite_diesel = quantite_diesel - ? WHERE numero = ?";
        String sqlSubGazo = "UPDATE STATION SET quantite_gazoline = quantite_gazoline - ? WHERE numero = ?";
        String sqlAddDiesel = "UPDATE STATION SET quantite_diesel = quantite_diesel + ? WHERE numero = ?";
        String sqlAddGazo = "UPDATE STATION SET quantite_gazoline = quantite_gazoline + ? WHERE numero = ?";

        try (Connection connect = DBConnection.getConnection()) {
            connect.setAutoCommit(false); 

            // 1. Recuperer l'ancienne livraison
            int ancienneQuantite = 0;
            String ancienType = "";
            String ancienNumStation = null;
            try (PreparedStatement psOld = connect.prepareStatement(sqlGetOld)) {
                psOld.setInt(1, app.getId());
                try (ResultSet rs = psOld.executeQuery()) {
                    if (rs.next()) {
                        ancienneQuantite = rs.getInt("quantite");
                        ancienType = rs.getString("type_carburant");
                        ancienNumStation = rs.getString("num_station");
                    }
                }
            }

            // 2. Enlever l'ancienne quantite de la station selon ancien type
            if (ancienType.equalsIgnoreCase("diesel")) {
                try (PreparedStatement ps = connect.prepareStatement(sqlSubDiesel)) {
                    ps.setInt(1, ancienneQuantite);
                    ps.setString(2, ancienNumStation);
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = connect.prepareStatement(sqlSubGazo)) {
                    ps.setInt(1, ancienneQuantite);
                    ps.setString(2, ancienNumStation);
                    ps.executeUpdate();
                }
            }

            // 3. Mettre a jour l'approvisionnement
            try (PreparedStatement ps = connect.prepareStatement(sqlUpdateApp)) {
                ps.setString(1, app.getNumStation());
                ps.setString(2, app.getTypeCarburant());
                ps.setInt(3, app.getQuantite());
                ps.setDate(4, Date.valueOf(app.getDateLivraison()));
                ps.setString(5, app.getFournisseur());
                ps.setInt(6, app.getId());
                ps.executeUpdate();
            }

            // 4. Ajouter la nouvelle quantite a la station selon nouveau type
            if (app.getTypeCarburant().equalsIgnoreCase("diesel")) {
                try (PreparedStatement ps = connect.prepareStatement(sqlAddDiesel)) {
                    ps.setInt(1, app.getQuantite());
                    ps.setString(2, app.getNumStation());
                    ps.executeUpdate();
                }
            } else {
                try (PreparedStatement ps = connect.prepareStatement(sqlAddGazo)) {
                    ps.setInt(1, app.getQuantite());
                    ps.setString(2, app.getNumStation());
                    ps.executeUpdate();
                }
            }

            connect.commit();
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
                    appModel.setNumStation(rss.getString("num_station"));
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
            ResultSet rs = pds.executeQuery();
            while (rs.next()) {
                appModel = new ApprovisionnementModel();
                appModel.setId(rs.getInt("id"));
                appModel.setNumStation(rs.getString("num_station"));
                appModel.setTypeCarburant(rs.getString("type_carburant"));
                appModel.setQuantite(rs.getInt("quantite"));
                Date sqlDate = rs.getDate("date_livraison");
                appModel.setDateLivraison(sqlDate.toLocalDate());
                appModel.setFournisseur(rs.getString("fournisseur"));

                appList.add(appModel);
            }

            System.out.println(appList);
            return appList;
        }

    }

}
