<%@page import="model.VenteModel"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@ include file="/layout/header.jsp" %>

<%
    String error = null;
    VenteModel vente = null;
    List<StationModel> listStation = null;

    if (request.getAttribute("erreur") != null) {
        error = (String) request.getAttribute("erreur");
    }

    if (request.getAttribute("vente") != null) {
        vente = (VenteModel) request.getAttribute("vente");
    }

    if (request.getAttribute("stations") != null) {
        listStation = (List<StationModel>) request.getAttribute("stations");
    }
%>

<%-- Affichage de l'erreur --%>
<% if (error != null) { %>
    <div style="color: red; background-color: #fee; padding: 10px; border: 1px solid red; margin-bottom: 10px;">
        <h3><%= error %></h3>
    </div>
    <hr>
<% } %>

<h3>Modifier une vente</h3>

<form action="${pageContext.request.contextPath}/VenteServlet" method="post">
    <input type="hidden" name="action" value="modifier">
    <input type="hidden" name="id" value="<%= (vente != null) ? vente.getId() : "" %>">

    <div class="form-group">
        <label>ID Station:</label>
        <select name="idStation" required>
            <% if (listStation != null) {
                for (StationModel station : listStation) { 
                    boolean selected = (vente != null && vente.getStationId() == station.getId());
            %>
                <option value="<%= station.getId() %>" <%= selected ? "selected" : "" %>>
                    <%= station.getId() %>
                </option>
            <% } } %>
        </select>
    </div>

    <div class="form-group">
        <label>Type de carburant:</label>
        <select name="typeCarburant" required>
            <option value="gazoline" <%= (vente != null && "gazoline".equals(vente.getTypeCarburant())) ? "selected" : "" %>>Gazoline</option>
            <option value="diesel" <%= (vente != null && "diesel".equals(vente.getTypeCarburant())) ? "selected" : "" %>>Diesel</option>
        </select>
    </div>

    <div class="form-group">
        <label>Quantité (Gallons):</label>
        <input type="number" name="quantite" min="1" required value="<%= (vente != null) ? vente.getQuantite() : "" %>">
    </div>

    <div class="form-group">
        <label>Prix unitaire (HTG):</label>
        <input type="number" step="0.01" name="prixUnitaire" required value="<%= (vente != null) ? vente.getPrixUnitaire() : "" %>">
    </div>

    <div class="form-group">
        <label>Date de vente:</label>
        <input type="date" name="dateVente" max="<%= java.time.LocalDate.now() %>" required value="<%= (vente != null) ? vente.getDateVente().toString() : "" %>">
    </div>

    <div class="form-group">
        <button type="submit">Valider les modifications</button>
    </div>
</form>

<%@ include file="/layout/footer.jsp" %>
