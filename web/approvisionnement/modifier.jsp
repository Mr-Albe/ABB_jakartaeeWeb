<%@page import="serviceImplement.ApprovisionnementDao"%>
<%@page import="model.ApprovisionnementModel"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layout/header.jsp" %>

<% StationDao station = new StationDao();
    List<StationModel> StationList = station.afficherTout();
    
    
    ApprovisionnementDao appDao = new ApprovisionnementDao();
    ApprovisionnementModel appModel = (ApprovisionnementModel) request.getAttribute("approvisionnement");
    if (appModel == null) {
        appModel = new ApprovisionnementModel();
    }
    boolean isEdit = appModel != null;
    
    String dateValue = isEdit
        ? appModel.getDateLivraison().toString()
        : java.time.LocalDate.now().toString();
    
    String error = (String) request.getAttribute("erreur");
    
%>

<%-- Affichage des erreurs --%>
<% if (error != null && !error.isEmpty()){%>
<div  style="color: red; background-color: #fee; padding: 10px; border: 1px solid red; margin-bottom: 10px;">

    <h3><%= error%></h3>

</div><hr>
<%}%>

<h3>Modifier un approvisionnement</h3>
<form action="<%= request.getContextPath()%>/ApprovisionnementServlet" method="post">
    <input type="hidden" name="action" value="edit" />

    <input name="id" type="hidden" value="<%= isEdit ? appModel.getId() : "" %>">
    
    <div class="form-group"> 
        <label> ID Station :</label>
        <select name="stationId">
            <%for (StationModel st : StationList) {%>  
            <option value="<%= isEdit ? appModel.getStationId() : st.getId() %>"><%= st.getId()%></option>
            <%} %>
        </select>
    </div>

    <div class="form-group"> 
        <label>Type carburant :</label>
        <select name="type" required>
            <option value="gazoline" >Gazoline</option>
            <option value="diesel">Diesel</option>
        </select>
    </div>

    <div class="form-group"> 
        <label>Quantité :</label>
        <input type="number" name="quantite" min="1" 
               value="<%= isEdit ? appModel.getQuantite() : 0 %>" required >
    </div>

    <div class="form-group"> 
        <label>Date :</label>
        <input type="date" name="dateLivraison" id="dateLivraison" max="<%= java.time.LocalDate.now()%>" 
               value="<%= dateValue %>" required>
    </div>

    <div class="form-group"> 
        <label>Fournisseur :</label>
        <select name="fournisseur" >
            <option value="5"></option>
        </select>
    </div>

    <div class="form-group"> 
        <button type="submit">Enregistrer</button>
    </div>
</form>

<%@ include file="/layout/footer.jsp" %>
