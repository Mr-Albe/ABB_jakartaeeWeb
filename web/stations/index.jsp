<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.StationModel" %>
<%@ include file="/layout/header.jsp" %>


<a href="<%= request.getContextPath()%>/stations/ajouter.jsp">+ Nouvelle station</a>

<br><br>

<!-- Formulaire pour calculer le pourcentage -->
<form action="StationServlet" method="get">
    <input type="number" name="idStation" placeholder="ID de la station" required>
    <button type="submit" name="action" value="calculerPourcentage">Calculer pourcentage</button>
</form>

<br>

<%
    StationModel station = (StationModel) request.getAttribute("station");
    Double pourcentageGazoline = (Double) request.getAttribute("pourcentageGazoline");
    Double pourcentageDiesel = (Double) request.getAttribute("pourcentageDiesel");
    String err = (String) request.getAttribute("err");

    if (err != null) {
%>
<p style="color: red;"><%= err%></p>
<%
} else if (station != null) {
%>
<h4>Pourcentage de la quantite de carburants pour la station</h4>
<table border="1" cellpadding="8">
    <thead style="background-color: #f2f2f2;">
        <tr>
            <th>ID</th>
            <th> Gazoline</th>
            <th> Diesel</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><%= station.getId()%></td>
            <td><%= String.format("%.2f", pourcentageGazoline)%> %</td>
            <td><%= String.format("%.2f", pourcentageDiesel)%> %</td>
        </tr>
    </tbody>
</table>
<br>
<%
    }
%>

<!-- Tableau des stations -->
<h3>Liste des Stations</h3>
<table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 100%;">
    <thead style="background-color: #f2f2f2;">
        <tr>
            <th>ID</th>
            <th>Numéro</th>
            <th>Rue</th>
            <th>Commune</th>
            <th>Capacité Gazoline</th>
            <th>Quantité Gazoline</th>
            <th>Capacité Diesel</th>
            <th>Quantité Diesel</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<StationModel> listStation = (List<StationModel>) request.getAttribute("listStation");
            String erreur = (String) request.getAttribute("erreur");

            if (listStation != null && !listStation.isEmpty()) {
                for (StationModel st : listStation) {
        %>
        <tr>
            <td><%= st.getId()%></td>
            <td><%= st.getNumero()%></td>
            <td><%= st.getRue()%></td>
            <td><%= st.getCommune()%></td>
            <td><%= st.getCapaciteGazoline()%> </td>
            <td><%= st.getQuantiteGazoline()%> </td>
            <td><%= st.getCapaciteDiesel()%> </td>
            <td><%= st.getQuantiteDiesel()%> </td>
            <td>
                <a href="StationServlet?action=edit&id=<%= st.getId()%>">Modifier</a> |
                <a href="StationServlet?action=delete&id=<%= st.getId()%>">Supprimer</a>  
                <!--onclick="return confirm('Supprimer cette station ?');-->
            </td>

        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="9" style="text-align: center;">
                <%= (erreur != null) ? erreur : "Aucune station trouvée."%>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<%@ include file="/layout/footer.jsp" %>
