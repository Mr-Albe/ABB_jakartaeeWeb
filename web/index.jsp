<%@page import="model.VenteModel"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp" %>
<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<h3>Liste des Ventes</h3>
<a href="${pageContext.request.contextPath}/vente/ajouter.jsp">+ Nouvelle vente</a><br><br>

<%
    List<VenteModel> listVente = (List<VenteModel>) request.getAttribute("listVente");
    String erreur = (String) request.getAttribute("erreur");
%>

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
        <% if (listVente != null && !listVente.isEmpty()) { 
            for (VenteModel vente : listVente) { 
                double revenue = vente.getQuantite() * vente.getPrixUnitaire();
        %>
            <tr>
                <td><%= vente.getId() %></td>
                <td><%= vente.getStationId() %></td>
                <td><%= vente.getTypeCarburant() %></td>
                <td><%= vente.getQuantite() %></td>
                <td><%= String.format("%.2f", vente.getPrixUnitaire()) %></td>
                <td><%= vente.getDateVente() %></td>
                <td><%= String.format("%.2f", revenue) %></td>
                <td>
                    <a href="VenteServlet?action=edit&id=<%= vente.getId() %>">Modifier</a> |
                    <a href="VenteServlet?action=delete&id=<%= vente.getId() %>" 
                       onclick="return confirm('Supprimer cette vente?')">Supprimer</a>
                </td>
            </tr>
        <% } 
           } else { %>
            <tr>
                <td colspan="8" style="text-align: center;">
                    <%= (erreur != null) ? erreur : "Aucune vente trouvée." %>
                </td>
            </tr>
        <% } %>
    </tbody>
</table>

<%@ include file="/layout/footer.jsp" %>