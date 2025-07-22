<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<h3>Nouvel approvisionnement</h3>
<form action="<%= request.getContextPath()%>/ApprovisionnementServlet" method="post">
    <input type="hidden" name="action" value="enregistrer" />

    <div class="form-group"> 
        <label> ID Station :</label>
        <select name="stationId">
            <%for (StationModel st : listStation) {%>  
            <option><%= st.getId()%></option>
            <%}%>
        </select>
    </div>

    <div class="form-group"> 
        <label>Type carburant :</label>
        <select name="type" required>
            <option value="gazoline">Gazoline</option>
            <option value="diesel">Diesel</option>
        </select>
    </div>

    <div class="form-group"> 
        <label>Quantité :</label>
        <input type="number" name="quantite" min="1" required>
    </div>

    <div class="form-group"> 
        <label>Date :</label>
        <input type="date" name="dateLivraison" id="dateLivraison" max="<%= java.time.LocalDate.now()%>" required>
    </div>

    <div class="form-group"> 
        <label>Fournisseur :</label>
        <select name="idFournisseur" >
            <option value="5"></option>
        </select>
    </div>

    <div class="form-group"> 
        <button type="submit">Enregistrer</button>
    </div>
</form>

<%@ include file="/layout/footer.jsp" %>
