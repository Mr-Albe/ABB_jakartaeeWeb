
<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
<%@ include file="/layout/header.jsp" %>

<%
    List<StationModel> listStation = new ArrayList<>();
    String error = null;

    // Récuperer d'abord l'erreur envoyee par la Servlet
    if (request.getAttribute("erreur") != null) {
        error = (String) request.getAttribute("erreur");
    }

    // Ensuite essayer de charger les stations si aucune erreur n'a encore ete detectee
    if (error == null) {
        try {
            StationDao stationDao = new StationDao();
            listStation = stationDao.afficherTout();
        } catch (Exception e) {
            error = "Erreur lors du chargement des stations : ";
        }
    }
%>


<%-- Affichage des erreurs --%>
<% if (error != null && !error.isEmpty()){%>
<div  style="color: red; background-color: #fee; padding: 10px; border: 1px solid red; margin-bottom: 10px;"">

    <h3><%= error%></h3>

</div><hr>
<%}%>

<h3>Effectuez Nouvelle vente</h3>

<form action="${pageContext.request.contextPath}/VenteServlet" method="post">

    <div class="form-group">
        <label>ID Station:</label>
        <select name="idStation">
            <% for( StationModel station : listStation){ %>
            <option value="<%=station.getId()%>"><%=station.getId()%></option>
          <% }  %>
        
        </select>
    </div>

    <div class="form-group">
        <label>Type de carburant:</label>
        <select name="typeCarburant">
            <option value="gazoline">Gazoline</option>
            <option value="diesel">Diesel</option>
        </select><br>
    </div>

    <div class="form-group">
        <label>Quantité Gallons</label>
        <input type="number" name="quantite" min="1" required>
    </div>

    <div class="form-group">
        <label>Prix unitaire en Gourdes:</label>
        <input type="number" step="0.01" name="prixUnitaire" required>
    </div>

    <div class="form-group">
        <label>Date de vente:</label>
        <input type="date" name="dateVente" max="<%= java.time.LocalDate.now()%>" required>
    </div>

    <div class="form-group">
        <button type="submit">Valider</button>
    </div>
   
</form>

<%@ include file="/layout/footer.jsp" %>