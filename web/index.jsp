<%@page import="model.VenteModel"%>
<%@page import="serviceImplement.VenteDao"%>
<%@page import="serviceImplement.StationDao"%>
<%@page import="serviceImplement.StationDao"%>
<%@page import="model.ApprovisionnementModel"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layout/header.jsp" %>

<%
    StationDao stationdao = null;
    VenteDao venteDao = null;
    VenteModel venteModel = null;

%>

<h3>Liste de Ventes </h3>
<a href="${pageContext.request.getContextPath()}/vente/ajouter.jsp">+ Nouvelle vente</a><br><br>

<table border="1" cellpadding="8">
    <thead>
        <tr>
            <th>ID</th>
            <th>ID Station</th>
            <th>Type Carburant</th>
            <th>Quantité Gallons</th>
            <th>Prix unitaire</th>
            <th>Date de vente</th>
            <th>Revenue en Gourdes</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            List<VenteModel> listVente = (List<VenteModel>) request.getAttribute("vente");
            String erreur = (String)request.getAttribute("erreur");

            if (listVente != null && !listVente.isEmpty()) {
                for (VenteModel vente : listVente) {
        %>
        <tr>
            <td><%= vente.getId()%></td>
            <td><%= vente.getStationId()%></td>
            <td><%= vente.getTypeCarburant()%></td>
            <td><%= vente.getQuantite()%></td>
            <td><%= vente.getPrixUnitaire()%></td>            
            <td><%= vente.getDateVente()%></td>
            <td><%= vente.getRevenu() + " HTG"%></td>
            <td>
                <a href="VenteServlet?action=edit&id=<%= vente.getId()%>">Modifier</a> |
                <a href="VenteServlet?action=delete&id=<%= vente.getId()%>">Supprimer</a>  
                <!--onclick="return confirm('Supprimer cette vente ?');-->
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="9" style="text-align: center;">
                <%= (erreur != null) ? erreur : "Aucune vente trouvée."%>
            </td>
        </tr>
        <% }%>
    </tbody>
</table>

<%@ include file="/layout/footer.jsp" %>